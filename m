Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CFD32B114
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231875; cv=none; b=NtlLNqFrOcr7TqvqT+oC4XAl0q63DwBZzpP5LwY6q15uMYx3aw0jZzUY/vyHK9myiwRUU8R3JiBWP0OKQUJhQ5+L69vWvV9GJvldjHMs5d6ClF+VvVI16PE/5sbb1MgGOopLf+D9uF8qlxr9ussEKMYH77sNhbIa/K71ONkK5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231875; c=relaxed/simple;
	bh=8KcSgffxAkB1OeS3/kdkp5OoiPWVBES6SdR64YQAb54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CpTV8Z8y82aQMeMZSRISR6sgs56e3Q9hBiaZJTgBmkx5QLg1sK7D+n8ScadYx0+NB2UW40lJh5OJVsn5G7hepRN3X0F6d9lkcyMDJN+bca07XJYyh6oqTevMQyYlXXs5dL6VBpxSxhBkeSpmpoFqPcTHU+C6Vn/OQIQ0gov2278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8Y436D5; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8Y436D5"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso4676323a91.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 20:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788231869; x=1788836669; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wgNVfGlbCEyq8MC5JaRKbxi7I9+N7W9TiHIhv9t8nRg=;
        b=s8Y436D5DrAn6S4iama2Vq3ITv2A86+qPIGZlFc6tQf/O3fyDbdYNTNd6O0w0hi5nk
         +mY+04o4xQM/PFjhF2KusvPSmPdi2rlwnA2l7AGPLnGKK00955RuN7pZT0zFZSZu4iG0
         JY4gmE+j7Q/oSypTYXKqWBNebBMM5LorMjmHaxqXZT3NHFw356CJl9K3W6Iq/SQ2NkIh
         TQSjVoT1vBy9+0XGCre3QVVGm+3hTZN7X/o3e87nVg4eghfLqIDmNBxWsH7+tYQ9RYbF
         2kQQImkBTxdcUIrUZEEVAd2AMhF7+RNBdZYfNDPl8krUUooCAObn5FpEtmxmdez2QBKb
         3Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788231869; x=1788836669;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgNVfGlbCEyq8MC5JaRKbxi7I9+N7W9TiHIhv9t8nRg=;
        b=eBmMuDA4xFWOBx9tsQvjWbFWDptRw5XGhS7dtqj7QQbM7R73zQbY805IOiocuWY14l
         A9ztG20CIjtHn57zdimZFPbZXfbZVNlzU3zTuWlWZr9y1rhQN4P8FKJmA9s8lrce16in
         cAg7OgrccVv3OzXYxskqYwRy0wUeK5Jb0Nsp/2uaEAjraBovzglk/gsHa5GpjAJLPKD9
         XzyuAepPRxMn3mJumMvDP3dXXQ9evVkfNrWOzmRo53o4kCXoIVRp5Ki7HT2COGNzv3Rb
         TyYfceb4Q3gBR8k/xqwSEg21Y/aHPzP0cfIVoRuYZ+nHr4ef55g5+H+X/Q/jVy+G5xYl
         2mMQ==
X-Forwarded-Encrypted: i=1; AKwUvByBmPb11zZ+MywZwQAQpTyGTtxQXXAc43JJY5QqOx11JwGnioY7I2MU4X9dWNmMh9JQeyH0ASE=@vger.kernel.org
X-Gm-Message-State: AFuF++mV/toKFOYdv9j99TmGSY7UFOPNKNBNqmqNB0C+LdAs5typ6lh4
	muw/XRsm1UAuwArGJ46Jn9oJnxFy6OVgJpTOGoPIOPm56z7U3BbCZCU4FPIFe7SIjo3njsD5bBX
	eE+AGIIdMlb7Hwg==
X-Received: from dycev8.prod.google.com ([2002:a05:7301:d588:b0:328:5a01:ea69])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d887:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-3989c0c7fdcmr33560585a91.24.1788231868274;
 Mon, 31 Aug 2026 20:04:28 -0700 (PDT)
Date: Tue,  1 Sep 2026 03:04:16 +0000
In-Reply-To: <20260901030419.470246-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901030419.470246-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260901030419.470246-6-cmllamas@google.com>
Subject: [PATCH v2 5/5] rust_binder: reject mremap()
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
Closes: https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb%40google.com?part=2
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder/page_range.rs | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
index 52ffbf3504e7..411efcc2116f 100644
--- a/drivers/android/binder/page_range.rs
+++ b/drivers/android/binder/page_range.rs
@@ -24,7 +24,7 @@
 use kernel::{
     bindings,
     error::Result,
-    ffi::{c_ulong, c_void},
+    ffi::{c_int, c_ulong, c_void},
     mm::{virt, Mm, MmWithUser},
     new_mutex, new_spinlock,
     page::{Page, PAGE_SHIFT, PAGE_SIZE},
@@ -144,8 +144,17 @@ pub(crate) struct ShrinkablePageRange {
     _pin: PhantomPinned,
 }
 
-// We do not define any ops. For now, used only to check identity of vmas.
-static BINDER_VM_OPS: AssertSync<bindings::vm_operations_struct> = AssertSync(pin_init::zeroed());
+unsafe extern "C" fn binder_mremap(_: *mut bindings::vm_area_struct) -> c_int {
+    EINVAL.to_errno()
+}
+
+static BINDER_VM_OPS: AssertSync<bindings::vm_operations_struct> = {
+    let ops = bindings::vm_operations_struct {
+        mremap: Some(binder_mremap),
+        ..pin_init::zeroed()
+    };
+    AssertSync(ops)
+};
 
 // To ensure that we do not accidentally install pages into or zap pages from the wrong vma, we
 // check its vm_ops and private data before using it.
-- 
2.55.0.897.gb25b4bd76c-goog

