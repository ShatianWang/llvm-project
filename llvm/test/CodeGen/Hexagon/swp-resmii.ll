; RUN: llc -disable-lsr -mtriple=hexagon -enable-pipeliner \
; RUN:     -debug-only=pipeliner < %s 2>&1 > /dev/null -pipeliner-experimental-cg=true | FileCheck %s
; REQUIRES: asserts
;
; Test that checks if the ResMII is 1.

; CHECK: MII = 1 MAX_II = 11 (rec=1, res=1)

; Function Attrs: nounwind
define void @f0(ptr nocapture %a0, i32 %a1) #0 {
b0:
  %v0 = icmp sgt i32 %a1, 1
  br i1 %v0, label %b1, label %b4

b1:                                               ; preds = %b0
  %v1 = load i32, ptr %a0, align 4
  %v2 = add i32 %v1, 10
  %v3 = getelementptr i32, ptr %a0, i32 1
  %v4 = add i32 %a1, -1
  br label %b2

b2:                                               ; preds = %b2, %b1
  %v5 = phi i32 [ %v12, %b2 ], [ %v4, %b1 ]
  %v6 = phi ptr [ %v11, %b2 ], [ %v3, %b1 ]
  %v7 = phi i32 [ %v10, %b2 ], [ %v2, %b1 ]
  store i32 %v7, ptr %v6, align 4
  %v8 = add i32 %v7, 10
  %v9 = getelementptr i32, ptr %v6, i32 -1
  store i32 %v8, ptr %v9, align 4
  %v10 = add i32 %v7, 10
  %v11 = getelementptr i32, ptr %v6, i32 1
  %v12 = add i32 %v5, -1
  %v13 = icmp eq i32 %v12, 0
  br i1 %v13, label %b3, label %b2

b3:                                               ; preds = %b2
  br label %b4

b4:                                               ; preds = %b3, %b0
  ret void
}

attributes #0 = { nounwind }
