Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B648124C
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280530; cv=none; b=V0mHquxPLcBrWmuNwb1TNpKtLRhruCkHUx0dAT1gJ/3Ns9qiKMYgj13BifwQJU0r1bu7b5izSPQvtleZ/rwl8sq5A7D4lcftoN7irDRJhOwraYyJIAPdKOOyrsiCd1gRNE1fhbNBPSw6TJ38Bdy27I+sRucpULA4jsps1OZtKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280530; c=relaxed/simple;
	bh=Q3w+fqnn1Odo3u33vSDwy+efpfwvyQRtuduW7bjVVNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tIfVE3/YjoWVxJ/ceWGqtot/qkgjMX1SxBtP8fK2PlOYBeoE4+IWX+idSoYG3K1So7jhQqGGdLz3Pw+HVoZDDAcwVAwfqQ4TfY3hnVjJVL/Fh2RqyvpmXUnzhAhVoz9vG2N/LxYlAPryA3aykeRDA5yfC2cevVn0SQuRnjp5NRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTuJ2vnZ; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTuJ2vnZ"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d959904658so18056595ad.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788280528; x=1788885328; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ro8mTU0e+ibPxFysuMqboUdneRfJQUV4jga1NJ1RSo=;
        b=HTuJ2vnZM2PvqUN+B7/j4+UrD23gZi6rqd3NE7rQfapiv9TUd7LuExYrZcE4CZQLuY
         h1B5v2FIWotb3ZOlqRLooF/vtRVU/k/gSM6Yi+bMMhVrNSVJFllsJ14xBxuTLszMBPol
         s4Z8LtBxwBZcJDTYF1Ekly7lp6iRuLbGrU9s/sIPCxKz4Vn+Z3yQRJZYaKdOZWoW+Bxj
         reFrKGvYiKGT9DuFOoC/Fs5AeHq0naYS7TIv1VfDv+lzymyxjkYcGFa9xiq/igAH+xPm
         /Sokq98YWtziB2rG2KTSey/wwaFJnflhijx0G23Ky3ZY0LLbkz5A2HsNNk9T38GnQEYc
         +0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280528; x=1788885328;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ro8mTU0e+ibPxFysuMqboUdneRfJQUV4jga1NJ1RSo=;
        b=p0CEnW1jitFJnqcyC+A1t5iP7s9iJ4HXaqhofaWzX8oRWAH1Rq1L3rEqHa6kHQcazF
         iUPRqJJ2eRqFgu0TLDUAAea7f87rAgqsRhZ1Ya4uZOQ4jFhu2zxSuoVWNAFsW5cRoJ1L
         T/8KS8HCQd1WbOlKZtExdIUikg8mLmQmGuu3XYmK8UWtFAUDbO1PaSX702JZOGpVJa0Z
         Qh9ScqsFvd0KaahpquGDQ4xebh22Ft8Rd8wehyCRSx/GQAxz5Z/swKyhtHuvLiJhhCA0
         h0t5+ZHvh0TUhCQZDVK00eDIRgGQ0/DSPDsNxTwY+7CokLIGalo1hHB3WauiFlB7JNrz
         uR4w==
X-Forwarded-Encrypted: i=1; AKwUvBxWtYU3zfdLUadgZbwPS0JZQxamBGid7b1QS3MauPAsIaBJ+aD7sKBCLuu7i8gb7WdazS/EVnk=@vger.kernel.org
X-Gm-Message-State: AFuF++lUuZS/Bb+/kV/PM/dn/nAKpT5Fo02Z3odjjfFehZdwqF0Vw0Kb
	+YhWa4/JLGGy+zJ7LVbwfMGnilZX1YWrGF57D9ewhcLoYINQJkh7eGssRBmTpG2M/LTzKDEopV5
	zM8FbhY/m47xCVg==
X-Received: from dlbro7.prod.google.com ([2002:a05:7022:1587:b0:141:4b64:a042])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:528f:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-39907e113f5mr15291291a91.16.1788280527477;
 Tue, 01 Sep 2026 09:35:27 -0700 (PDT)
Date: Tue,  1 Sep 2026 16:35:15 +0000
In-Reply-To: <20260901163521.1355535-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901163521.1355535-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901163521.1355535-3-cmllamas@google.com>
Subject: [PATCH v3 2/5] rust_binder: set VM_DONTEXPAND
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Binder does not support expanding VMAs. It uses the original size to
create its RangeAllocator during mmap() and expanding the VMA would only
result in a wasted virtual range. Set the VM_DONTEXPAND flag to prevent
the vma from being expanded via mremap().

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas%40google.com?part=1
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder/process.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 5372bfbd93b3..9038f3d13cfd 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1786,6 +1786,7 @@ pub(crate) fn mmap(
         vma.try_clear_maywrite().map_err(|_| EPERM)?;
         vma.set_dontcopy();
         vma.set_mixedmap();
+        vma.set_dontexpand();
 
         // TODO: Set ops. We need to learn when the user unmaps so that we can stop using it.
         this.create_mapping(vma)
-- 
2.55.0.966.g6673acef38-goog

