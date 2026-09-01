Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC57344A3EE
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295978; cv=none; b=g2I71OzdAhqYEWMCBN5rwBmN1Xmer6AcKh8X54U398kY0IJM/6hfbbkF5FftriC5M1KnjtIJyPEALZ3M1PymHMnW04zRHjOumUbergdHRnGCUaOBqCp0YcS5+lRFp9CegVcSP9XpMdxp34JX1Xe9l64mangHNq3Mgy6udo3z14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295978; c=relaxed/simple;
	bh=mC01VX1n7muqMaBoWw5J7zX+JcinZQb0IpbAjZAJoWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=krn+DNV815pPArPySEdFh7Bw3K1Xzyuc+tAjlEXmKFccBiO7CsEtLt+VJfVFV5IbQkbYjjfAaJEXrnbYh+pbHtWYnp/0nn/XiZQeAHaNxAIzQbMgga2jIpwU8aPGrYJfIlnnVdQG6wZLC2Io9TA2xV3/KzL2s3vcoKH7DJHUKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQzoiVT1; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQzoiVT1"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce7dff6253so15698935ad.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788295976; x=1788900776; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zocSb9A1qfC5TL5NRNiwUw0+UxJIZxHTRhrF7BbbrB0=;
        b=MQzoiVT1Y2bEl7t4/tMFXOGz6gcgV9h6I/ENOIWVQy289NffZqaVD3bcSnc7m/PvLH
         v7EaHE6WGvYhDxZx8pii+XxhOiOeeCSKxjkXvE7DYk40JoQjdrY8S4vauo8V52B3DKkU
         iMs4QJ8njowrYRwpRNzbPQKHmwFLvPO0XgFQOyWMXsPMF7trE4GzbgD3IxUvECraUHuO
         3XCS1jXGjPlX9NBTBYoN6SLlVY/olUA0mS8sxvkYyXU0zTrsjpH1F2/gLRbTELOzHUvS
         QtzhPaLy5Fv8T8c7kN1LznZAXG6XJA7jgDaoVjwhkQghIF0uVTx/VLs7ymPhSFMyuHGb
         5HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788295976; x=1788900776;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zocSb9A1qfC5TL5NRNiwUw0+UxJIZxHTRhrF7BbbrB0=;
        b=du+oo4R6VdePEMrlgyYCmrAX6GqtIAyrqpUiHSpnNSK6f40RL0CK0TDs9+RKcUSDkp
         MZEOiD0fO8AEHCgUn0dBhc0l6RycZ4J54WAhruUk74RonWHwad4cNbjMtoN/vTguvU96
         N1/oQZXBI40DAwtenihQ2gBWCUsFeBzqr4dOCo7X6b22yEEVAHWMraZ4G37nR6UMPhkd
         BlI+eHHSBrXQKCbHY5T8SD67tp8ImxTkdaQ0sfact/5nKub0C2xOPT7h9CV+AY19P+H2
         DdcGfyH3GA9ge6hK5bjHFqN0/YcLYyavtesUe646QYOLostWIuKFMiz9b3+GAWYlNmp7
         uNUg==
X-Forwarded-Encrypted: i=1; AKwUvBz+0YWy7SGS6oB2qaliV1x0UPJjsHLNxN2yB43b5v/E6/cx8pycnsjAPpkSuL1b+p0Cd8kUAGw=@vger.kernel.org
X-Gm-Message-State: AFuF++n23zT1MRbh5aNtZRPD/Bj3ZKm6huVW1Bh3iVknbftPzy9iFR5M
	h5rIvQSjLnACgMW5rIZqedxC9zG+30j2aQg7w7b2zClry/KaXlKifuNDMZvv7vpJXnMs2uN5sdf
	d8ZkYbgNLSF1frA==
X-Received: from dybla10.prod.google.com ([2002:a05:7301:1a8a:b0:32e:7e7e:22ff])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2410:b0:2d9:2b1b:878a with SMTP id d9443c01a7336-2d9526c2cdfmr76986075ad.10.1788295976098;
 Tue, 01 Sep 2026 13:52:56 -0700 (PDT)
Date: Tue,  1 Sep 2026 20:52:41 +0000
In-Reply-To: <20260901205250.1638304-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901205250.1638304-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901205250.1638304-2-cmllamas@google.com>
Subject: [PATCH v4 1/7] binder: set VM_DONTEXPAND
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
Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas@google.com?part=1
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

