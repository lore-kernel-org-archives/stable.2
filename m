Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F74A43FA
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295979; cv=none; b=a+J4slQkNad5Qu5U1XUUQ6KF0I/fQjslpNU+fSY7qP4JxlX9zs9fbepRJxgjt0qaDeHnCvmXWn5oftUCTJyrWwZ7G2avNAkwHc5YwNT8GHw5tdZy7PddVud1mpdkf1Tfdtlc0IESdXK+UiKNq/4xBO0ObWb0UCenxdq6wr+KCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295979; c=relaxed/simple;
	bh=qDxPPBiVzVIZg0bueYBv9GJ3dcl74Eqh6LmL3sW7by4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NbV65+LDwPK2922Q/2utGAXL9DmRr0icY11etdLVfCxY6GMRXMrZhRFV+euSaNwXZajLM4i8EN457/3wQKMaxxu/X2P0WQDyUuid8ohUaxkkocM2OFODFOLezPD2HXgqOZTMse6RItAaMvm5pQWDrwrIrT4LSGfrHMJzFbptktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZzhFoVv; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZzhFoVv"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so433956a91.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788295977; x=1788900777; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4b9RJf/EoA9UAqTMJZs0pdFOLSykyAl2dSQSlyCXCk=;
        b=uZzhFoVvpFCQobtS2UZP/oJw6haDPgYW9kzWBA+S3a95dxlXmftJOubUvKjx/NmYDc
         CBvtwOQ7j9FJENsql8oqdMmdugkkY89Axo/B+CFYOx8kTF2YvQo7XhyRUIt8LPiu0nO/
         e0kz+cAZpYcnS7+lbeVoqxf6qgjgxdb3ltVY4vDXr4f40Tqf5vrnUAi7SK3dA5G3DAdd
         Wx0ShhkxXDyte5R9NInT8KIGesb5ihZcWgZ7dBTGvUVVg3mWc8SAUT1TRLESp4tbsuZh
         HAXvSgdqE8ug4v5O2cS5hS4jJWAEcNZY/tBv6K3yhMyNYS6IWFjiDJEbsQ0R1tgxM5a0
         SJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788295977; x=1788900777;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4b9RJf/EoA9UAqTMJZs0pdFOLSykyAl2dSQSlyCXCk=;
        b=mGtUYaKRydxFcueS3ZTF9dDYH8lujW5nztmjWQueo3pNzfJrkKANM86SW0WBXzaJQh
         altB9d0z2tDmy+r7BQwisYFWlFKllQibSp0hOW8mmgecQUyTaXab8v4OzTgZhZDBbsl9
         //OAMffW9lo6UMidblDQ4DnDjQ8TyW9C86DZAz5HqAo5TJywbWY2YAgJmQXShsTHEn7k
         SoZa1EBlVyruykqdVnAcCmY65H1vrQKpovbJrsOFW9x2nRafPhVmBnJYrxRZGkholEpn
         sH9RfqTmtaRQVDIosgxpikmdgamzj03jxd068VkVOYD5qKnhF/RLjUTPkltGg0p/l7bD
         oPAA==
X-Forwarded-Encrypted: i=1; AKwUvBylJ4xSQPhrJ3e1f6RKmpXPTWM24OHG4L2ZovLxbE+Ej1pPlA/ROAdgw4Go8HSV0mc0PmNb5p0=@vger.kernel.org
X-Gm-Message-State: AFuF++mI148oLtjN1DsnXJRr/uN1IEZjrdua+eMxujfkt3YkvaFx8gTH
	9MfzZGtsJ4HQkpgzOhBD3JJwZj3KRKH1GUQ0qbtWnbhAXFh97mUKU2J6I7fRIM36hjJ8k2/S95K
	OP1ExKm/nnFyAKA==
X-Received: from dltt5.prod.google.com ([2002:a05:701a:c965:b0:141:a317:d828])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3903:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39907bbe018mr15277088a91.8.1788295977354;
 Tue, 01 Sep 2026 13:52:57 -0700 (PDT)
Date: Tue,  1 Sep 2026 20:52:42 +0000
In-Reply-To: <20260901205250.1638304-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901205250.1638304-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901205250.1638304-3-cmllamas@google.com>
Subject: [PATCH v4 2/7] rust_binder: set VM_DONTEXPAND
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
Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas@google.com?part=1
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

