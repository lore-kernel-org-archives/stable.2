Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394852F7F0F
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280528; cv=none; b=r0pwRWslH2xUbuWE++uwMWRfiNj/XmkUkyMwXvyUfyjUk124YGwi/QoBKaSQui79/XRpa/vImyEFTd3RPds4V63e7oa0yyJ9jGkaydOo3SWc0tFJZfXA3Dhs98uuCfM76BpFvuncJ7TbY67ATV3IamEZqcl4ZQBWXxRP8L74qPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280528; c=relaxed/simple;
	bh=Ef4BVBI7qGDPlNFCmdIJj76ArTzSGUBqsa9qjOr7AUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ug+keLvbAkCBS0WZWlUlmH1UsDpal/Xnu2yZL+f+IKC7reVDM9D2ak2SQHqL6Un0VeX4tIkn1Ks6ySEr2ZdUr6W09msq9Rq2Knms1cqf8PeAEfVeOsX8YhomB0/88aHNqTPRVEWDnvyv6tJ6ObymIJtZXrrHPOcd2IeMl7qppnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BnQiAAaA; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnQiAAaA"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so15082a91.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788280526; x=1788885326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOQzO1BwLqdJ6VWVJ7Bsn3PX5GscE0Esr+/b/xerP4U=;
        b=BnQiAAaAfm9xU//FEf50iWunOo7QUkAgkuNhscgqwapFJNDvFUSomFLngiA5RW2egT
         Pfgw4hQwPQPPmIwnQNMTf18839G0rRadDnVEnhyua11vfmuEwnUAlTX9KVe3dY1QIevR
         /q6OvSlGyIPJeTHm9zy6e+JFGEooJ5BFzpLG3Cz3J4fsJpwpt972QceSmtkAvznCvNfF
         dC7I3Xc1j4WAkT85gEK19fUzpbjHuF2gnDFZyezQhSSGlPyd3Q2ntOxQd4EwY03Vlnby
         SnYAmASRiFv278F9MM3s/oc3xlOvc3rdkonpubh1E4RhjXgq6Ku5vTo03uLHfndyKapZ
         BsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280526; x=1788885326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOQzO1BwLqdJ6VWVJ7Bsn3PX5GscE0Esr+/b/xerP4U=;
        b=d3VIAJVdQ/oOwmLTUHFoY8zi5sG0LUPYfqRq4RGVR/Qfe7zU6yAg//6xeGeca27sEL
         r0Jr9rbnYrZHgHkIZ9k7/T0of0bx5Z8gEkz+Q3XPN3pE4JgUzjFazeZR3Ee7ewxfL8BM
         rqFNtjqaV2fdCZro7ueIXw/ix+VhCCzSdsM/qH2/cmlpocC0E3cHSW1IKACkYEjUypVL
         AViSMc1ouE2iXGctLb3LwQSn/j32frZ5mpXMBHxYNlwSEr+rn9iOHUJlLnoVlxWP+i3c
         pBDrmgAxqyg/iNg1lgGXBFfwt5ZLN+GKEWrByLXi28RGOoUH0zvW2hHvnwObE+w1q+Gm
         viIw==
X-Forwarded-Encrypted: i=1; AKwUvBwFPqeilKbba6xpuRQQTUeMd1UOGwwuiEqchFWz/e2CrWbLjFOEctkhggYkX1vTVFMSLwaMluw=@vger.kernel.org
X-Gm-Message-State: AFuF++mtmvQN/BdbE01GCe9zpH8weIaHVA/3ZqHXb9YktfjqUdUbhznD
	ZCbSPOpit+9vpcQdeb0OCyg7PawrGqY5bEZvyftSttwLxwN6S18G99xsd+1ekFlQg0u+oKgPT1+
	j7qFGmfAd2EaGTQ==
X-Received: from dybsr39.prod.google.com ([2002:a05:7301:71a7:b0:328:ea0:399e])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ec1:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-396d0f2dcd8mr41443991a91.10.1788280526175;
 Tue, 01 Sep 2026 09:35:26 -0700 (PDT)
Date: Tue,  1 Sep 2026 16:35:14 +0000
In-Reply-To: <20260901163521.1355535-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901163521.1355535-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901163521.1355535-2-cmllamas@google.com>
Subject: [PATCH v3 1/5] binder: set VM_DONTEXPAND
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Binder does not support expanding VMAs. It caches the original size
under alloc->buffer_size during mmap() and expanding the VMA would only
result in a wasted virtual range. Set the VM_DONTEXPAND flag to prevent
the vma from being expanded via mremap().

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas%40google.com?part=1
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8f2ef1bd539f..1b492ed48ea6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6056,7 +6056,8 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 		       proc->pid, vma->vm_start, vma->vm_end, "bad vm_flags", -EPERM);
 		return -EPERM;
 	}
-	vm_flags_mod(vma, VM_DONTCOPY | VM_MIXEDMAP, VM_MAYWRITE);
+	vm_flags_mod(vma, VM_DONTCOPY | VM_MIXEDMAP | VM_DONTEXPAND,
+		     VM_MAYWRITE);
 
 	vma->vm_ops = &binder_vm_ops;
 	vma->vm_private_data = proc;
-- 
2.55.0.966.g6673acef38-goog

