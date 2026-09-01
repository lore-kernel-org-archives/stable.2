Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550C41612A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231866; cv=none; b=YSUODcXe0wBoKR2Bu75ZrpsHieUFTbQ5KnLKA+fxcUz4cZArbQUXsG0p1PCNFr712V51qs/rvX2sxCgmN1106oCz4SqR9+OI0zEN9200JkGlrKmU8dmU8q33A+DaVg/H43jaVvkBN7iYZHlgUaJa6tBkzPGGJIXIz69lF5BXbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231866; c=relaxed/simple;
	bh=ZVDmy6VjoBuiJ9n9p6Ad1YWPKaC9lxc9NZ2K2c+ucEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jwf3/cUoeh9kZdZCvTPKHIEfC29Y4EMM2bLIRJHz8A+460mdcx9fzaneYII2Jx9n59v6fs0r82M0gV0NdprmX+fG+mpUs1X7bkHtQvbEL1cDZmKDcHyX5AQHsmzOFd/vw0CIQ317UmoMVyssfVuH/jH4kDtnnVUMYUc+iy9paf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhzRUiAt; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhzRUiAt"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d7443e0f0bso14222085ad.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 20:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788231865; x=1788836665; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8F8BdKyQbDU8LQ8WvhzelWDzD39wCf1FJtyBP4q/yWc=;
        b=bhzRUiAt8cG08SVMAC6Q9OqM3zOxPbhVYTK5Lbru9MADIq8Agqore1soqohOOrpo3y
         1HlR05GOHy0V3QpzdsoXGQ5GpSxzwPxbJOtvNgoh4hFZ8LdR1Gf4MgkOOTQFA89qz4Hj
         ehO6XqlZP8MkLZvzNr+P3TXgekS3o7Y5Qt4DRj6oaCDUL/bTO3WPeVeRCq1VGZyrYsEq
         XT0STyKMqMc4zjrynImJUVOYhSDd7MOgFLxGO2qOSiyaSe10MuQnuuysROTx5AJZiJGy
         pk7upWX+f7ZZDqV/uwDqw/22PvXdMQ1+c8eR1ticskfzWof+xUFmtDEk6Z5oFbWAGZxX
         op8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788231865; x=1788836665;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8F8BdKyQbDU8LQ8WvhzelWDzD39wCf1FJtyBP4q/yWc=;
        b=TmnkGAY4K9MkddpbaH35jxhE6sfNgbN5Ko9grrmPCYOUMDEiioFYzHE8n4b/9n5nir
         RA+MWLet93P9t9n/qpHsH7U0Y39IARp2Mcg0Ax8QdtMu+IukqTTiM6oZ8b4HnyMSnEfY
         qn9OQfdp5zmaTLtXFGYROqLMQR23CiWt/9FJ/iAUgXZLxscWN8H4xO22oY3T8bNKFvE0
         fsx4iNDscG7er6Xs3D0obY09rtImpTXTH84ywyTpEDNi1vpcHqetjYzXxcliiVj+TqTR
         H79vRlDN8aEowda4Z31CuhlBTomfoyK9qSi8SbWDSSiQCwjyFtlEPcIc4fySRieSy3n+
         fMvA==
X-Forwarded-Encrypted: i=1; AKwUvBxk3NUb4mkfN/bD5lUUT8ZMZmWIAf9EOOKsB3gwhsY2QmkmSRet6JYNPkXH8To55XvM/A39igA=@vger.kernel.org
X-Gm-Message-State: AFuF++mpmOg0hlSQhhZNk8m7CeYccJlfeUesevcJMo1Vo70VaOx/1U+9
	sKXO1NnOYl5WMulCcK/sXg/YAp65eg1O9pGpScbbtpbw83K5QzVKSDWcNxNNZx5UaSF+MPzOE4q
	CzzDk/GKdXrg5aw==
X-Received: from dlbrs15.prod.google.com ([2002:a05:7022:f68f:b0:13d:1da6:85cf])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:1c08:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-3991b082a7emr1620892a91.7.1788231864463;
 Mon, 31 Aug 2026 20:04:24 -0700 (PDT)
Date: Tue,  1 Sep 2026 03:04:13 +0000
In-Reply-To: <20260901030419.470246-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901030419.470246-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260901030419.470246-3-cmllamas@google.com>
Subject: [PATCH v2 2/5] rust_binder: set VM_DONTEXPAND
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
2.55.0.897.gb25b4bd76c-goog

