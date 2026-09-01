Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7148167C
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280530; cv=none; b=rKzDuDuiiT9bjIypIqXdQEB/V/+ELzzLTI9u4aX1yj0N1te4ezioMOCqUCcPZ/gw0rz9tkzY6Y+ZOmDOH10RHU/zOrUUnvyyl912bPpGdByAQjhUTpnTmL4kNRYRrW3u/7Iwmkr0br7y6V4r00LGCy8Uc+AMYps9FXwhXKGcixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280530; c=relaxed/simple;
	bh=hu/IbFNnTPszKMIhPjq4a+4Cu+oiVtMDsWGda3p00DU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sdV39IkcD2KEIktlPOKCImMDY2hf+yqhD52RlxpPO+F7YEncYL1/ZFv4ntExiFKlXYbjhjmkoGYV8c5vRLUb1iIDeGv/UrgjcRPhMToWqIIes9lNUGmR5rsRM9NEl9+kpPaBCuuz5sJKs82q/C05HyujfsupH2d/LFz86tws5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvkihqJA; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvkihqJA"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so71839a12.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788280529; x=1788885329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0uaVU7Y38geHLJxnPBb9TaaFKTDZvM/A8qN/l+64928=;
        b=CvkihqJA2qpPL1UQ3oJ6e7TAj4ayw/tKeAgNn9zMKeErFpN1j96lHfY4IOICZrpZb4
         so12zVU5egPQmOfGMd9eSnfBu8cpYtSmW9BFFoq/JodeK0eHwBmwUfRilY9+WtNpfxUW
         hgqaokLnH83uzv9/pbFUQBGADgXjBLx28bCALvIM3slUJkx9lr6adeYUuEl7D7UlWU8T
         e/nnogtKR+BFCwtGU5sKlCs1oD/5uwlzyOjHvPRrWoY8uQgp7e+bs2FEHhOMBRRvxETJ
         3FqA6Z4vSs3laeqiObIsx9YjVCAnKN3zF+m5t4EHWpXnI+bWUi4ot+H67HoCBA1TOyS7
         erbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280529; x=1788885329;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0uaVU7Y38geHLJxnPBb9TaaFKTDZvM/A8qN/l+64928=;
        b=XmEji5ZsVc49Nrci0Rd3OZwpGG0VZGL13EzeVAZFCnv7Iu+CG10TnHuMGygh8LH+tc
         TcoWD+Yfz5T0CGWmI5hRF8bF9BKAW1SNt/r0JuDOTQoGrGyY5oBbuVEWbZ6luA1AzPvo
         P/p3OgHil9wrxBrDosOdVawpTeCg2gGBwEDNpZpmXE/bp4M/fLjxJZ8MtchOGBe8FGsV
         GN5Vj2GWeoMT/0V/BYIMJEWeV5yNSDz2jWKqUDewZvQcOz64NTxl8peIuyoyaKPDYCCp
         AH9A8zzoLgll8KgsNl6M5UXmhgIHjz7ANrccgquEpXh7mJ2KjvG2ZrOiZYQoG5fbvm8S
         RZNg==
X-Forwarded-Encrypted: i=1; AKwUvBzRPI9BXP+Yqs97LYa/OZ56CseK8bmiKCXkGOkiH9Q/c8X25ru0NHXI0BKx2Z6/jky1zX/QTCg=@vger.kernel.org
X-Gm-Message-State: AFuF++n4zI+mwHSj0ODTrSe8N2r2/Ojlg0H1y9KDt/SQf1zQEiScfrHL
	0ckKV7ksx1+06V1g/SPE4LdUX4QuDkyHiWXny0w3wYQzfLc4+DEsxl+kMbvL2ERBemevLiu7HW2
	voxBZg82V0yZ5wQ==
X-Received: from dybgt3.prod.google.com ([2002:a05:7301:2203:b0:327:d6cb:19b8])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1e05:b0:398:9bd5:490c with SMTP id 98e67ed59e1d1-3989bd54c4emr33067004a91.19.1788280528732;
 Tue, 01 Sep 2026 09:35:28 -0700 (PDT)
Date: Tue,  1 Sep 2026 16:35:16 +0000
In-Reply-To: <20260901163521.1355535-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901163521.1355535-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901163521.1355535-4-cmllamas@google.com>
Subject: [PATCH v3 3/5] binder: check vma->vm_start in binder_vma_close()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Certain operations like a failed mremap() might trigger vm_ops->close()
on temporary mappings. To avoid tearing-down the main binder mapping on
these, let's verify that the VMA is within the expected address range.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas%40google.com?part=1
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 1b492ed48ea6..59ff436f1138 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6018,6 +6018,10 @@ static void binder_vma_close(struct vm_area_struct *vma)
 {
 	struct binder_proc *proc = vma->vm_private_data;
 
+	if (vma->vm_start < proc->alloc.vm_start ||
+	    vma->vm_start >= (proc->alloc.vm_start + proc->alloc.buffer_size))
+		return;
+
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
 		     "%d close vm area %lx-%lx (%ld K) vma %lx pagep %lx\n",
 		     proc->pid, vma->vm_start, vma->vm_end,
-- 
2.55.0.966.g6673acef38-goog

