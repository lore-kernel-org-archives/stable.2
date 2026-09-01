Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D494A499E
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295986; cv=none; b=hhOLaLSpsoqvbhfBhzqkjCk+8mnjmphzmsJake7l74FeVsS/abXXNewwagKNRfNZiHiGo6dpU2YSuG+F/uoQuTt9XuZPvv8Hy5TA2nHCMLurevxVvrPPVTK6jMpF7WZBQx7X8DKz05vgNFIaYd9sZOeULB160Mi+j9W7VtS1v7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295986; c=relaxed/simple;
	bh=QlZ8bwAY9neKKHezVtvtUAl90mGSvbr/T2WPNJJtduo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r9y5IzPurDJQkOYrxNCAvYzBFyZQ4tSx5Z4Lbi4TJiPxXsccCLxV+O/3s8x7StMp5+h6g0AIIyh8NY/D1p6uzZBL4RV+QOUCz377ovtIJXhCkeqBVGhQDRvpJRcg2CSJMv8FaBoXznqaJ55/SUgkJgeWnzURVlUjb95uJ34MGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYqTJLOz; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYqTJLOz"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so309639a91.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788295984; x=1788900784; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyvdbyrwWKUxEUT3K6aHYWOVvt2Ms0Td9F6k6Xd72tY=;
        b=FYqTJLOzU27ADUxg6lvT0ymOoh99oi1suhtDCJo42vITNZ1LofNuIaDIJvzDikSYkl
         THb/2EJhodntsntoB9hduUrNffL/1jKcSaBcD1xSlSm5V9sIDf2WkxjIejMd9Ckjg7kE
         eV+bmOUpeSw6riC9MQFzSjmsDZ5tu1R7cJOWg5+NitxuTdJDT+pu3Eq2rYSfFo+2etLG
         +8uk7mn+lAAQn5R6QcjUIE4xrq5o6FJqqgJSzOftOFIqhYmOZBUUwlPLSg/FcYsldrIs
         1CIumiU/i4G/mVpW/mbIh+BzvDeIkXfmVeDrfmfp5x3wYrKj5iFJZQZTFPB56/0Hz5OZ
         fy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788295984; x=1788900784;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyvdbyrwWKUxEUT3K6aHYWOVvt2Ms0Td9F6k6Xd72tY=;
        b=TkghPxMha28rgz+/HUohg1Oeom9z2F6PEmTVzJh4bNb0gS78tQCbJ5G1TJxNncbFKD
         08JMXuemxIfnRPy9L5llyulvKoP6lJMwGth3MN+VzEyC3/DkQKHvhG4W9ay40C0IiIp7
         i1WbA1URJqv0ZGUlAKUkCjyjbVei/F1VvZ90/vLwDN0JqyLE97IvnOxnxSPcK3rA6T7s
         9zSVv/Mc9nenNRWvUmYbAGYadxw7kA/Pq74k7/EwUou+Hw35cvqio1dX6JKEn7EACxW9
         5vD6LRM3kELSHouT/67MfOofi8PmVN8SWmsn0j4c00SHtuW9LnFUii5ZWX0qKapefSoR
         enZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzt0O0ZgJ8LD9bjhUfoyJJ+tI33NRR85N4UpSDAyessAHpvXxOM/xZdOePYaMWQEbZncefh+vw=@vger.kernel.org
X-Gm-Message-State: AFuF++lBJmVXacKcxGdJhf2uUXQguFZ6X+3sUrzgiYIgjLsTQWx/t75O
	KwpwmK1UV4YyDZK8PPGO9L74Zw3wdZ40fKAPzsepRaJlThSGCQqdkt+gOOG2tk/D+ntnqZICKXh
	ZYHP1G/dKoc1/+A==
X-Received: from dybnj33.prod.google.com ([2002:a05:7300:d0a1:b0:32e:56c:c1dd])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5745:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39ae8219104mr1343490a91.4.1788295983615;
 Tue, 01 Sep 2026 13:53:03 -0700 (PDT)
Date: Tue,  1 Sep 2026 20:52:47 +0000
In-Reply-To: <20260901205250.1638304-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901205250.1638304-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901205250.1638304-8-cmllamas@google.com>
Subject: [PATCH v4 7/7] rust_binder: reject mremap()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, 
	"open list:RUST [PIN-INIT]:Keyword:bpin-initb|pin_initb|PinInit" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Binder does not support mremap() as it caches the mapping address in
Inner::vma_addr. Moving the mapping breaks the IPC communication for the
process and can temporarily leak pages during a shrinker reclaim.

Fix this by explicitly rejecting the .mremap() operation.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@google.com?part=2
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder/page_range.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
index d260b009c184..c6247ba03313 100644
--- a/drivers/android/binder/page_range.rs
+++ b/drivers/android/binder/page_range.rs
@@ -148,9 +148,14 @@ pub(crate) struct ShrinkablePageRange {
     EINVAL.to_errno()
 }
 
+unsafe extern "C" fn binder_mremap(_: *mut bindings::vm_area_struct) -> c_int {
+    EINVAL.to_errno()
+}
+
 static BINDER_VM_OPS: AssertSync<bindings::vm_operations_struct> = {
     let ops = bindings::vm_operations_struct {
         may_split: Some(binder_vma_may_split),
+        mremap: Some(binder_mremap),
         ..pin_init::zeroed()
     };
     AssertSync(ops)
-- 
2.55.0.966.g6673acef38-goog

