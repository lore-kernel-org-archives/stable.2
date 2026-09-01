Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE053C09EC
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231868; cv=none; b=bd6QL+1v4+SwsTQRgUFm+rtu78QuCBKiVB0+bjp+PoDvSykUt0Hjswl5v/9zQqbG9pil7D0ZpfylH2fMeQtDCBKk4+abQDS5/7RLEp4svWfRmbkOc16PEPFifou14wCd0V13Vy46GhVqK4Yu72PdWJLAuUZnJbV8kIMSO3nlGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231868; c=relaxed/simple;
	bh=QaT3nycN1nU+767e6gGU2hQy4Jh8Zmp8/ztDqnMyiNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TvmZC6MV90aYKbfXX89/5EOtH+d2cv97rQ5srtd8VGcVsq4RMiRO1mguYirGbFkruIsXZTd5trBObeICZxMZplcOcBL3ODjPCY3pKZKotv7yp+kTI0tGP1Mx6p3D3nFv+lyU4kzjK1D2+du7AgJmuUoObrZEowzorCCNV+c4dlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGrP46m0; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGrP46m0"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1b8088202so4424979a12.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 20:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788231866; x=1788836666; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4kY4yMnAUzFdJb35gMXcen7Y7r8uKRQU8t9+ieisNw=;
        b=rGrP46m0mv9VyZK3ltDaSaLMchOP69AJMxy1d3MFvw5r+kanjEhD2iG08J79/Qs2YQ
         3Qu8Hn6fcqgfXfzo7KyokBAU/fM2qrz5mzdkckY0uathI/RVmZLMYugNYmaid+z9OvX8
         YdMlJtV8Tf3M+3DUgL6+PXa99kELizb8qxKBI9zZzmiSOewdnh2hP0W4wGZF1TgxucR1
         pYoXZZGQU7LuY5g4FHaD9xAvLyTMhxCfIMems4sE50nDSktDt2Jk4jBPjUsmG1mzmoTL
         YgDpMx7awRl3sKa2q+oXlq32IMglo3CWjeOaM9np76z2HIns4Y3j3mkyNL7cpFpADTOv
         Tjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788231866; x=1788836666;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4kY4yMnAUzFdJb35gMXcen7Y7r8uKRQU8t9+ieisNw=;
        b=Hi+Y7RPm/tMtvJunBCRfHkWQz09je0U5A0Pz1M1I6Hm1ZnyExT7psPdCgKpZnMmjND
         MjmAbtydXF1fyADOHXgfvbsWJiGdfCc5V6QXlnd0HOfHJHvFg42hKSkWcO6+C/7Q0apx
         eIOlLAJGHQWjaVuLZqY4Ox0AiKA3fYjOn/C4uipRCL+3Qbk2TqXU7Rkfepp0LnuPwoHk
         Rqfzez5f7kh1WIcnsPCgM0ETZlm9KDo22dXIFDqrCLJzKZtpvaFWkklXzDlKG2limKUL
         MtCZfxzUgjNbhpSHa6P291yWBi8D9URsD42kmHjLVsAtmU7+cOAj+fRMKO+niVbUkkwu
         NAaw==
X-Forwarded-Encrypted: i=1; AHgh+RpD6hXhOoLJ6zktY2qavLP2uq38AqTyvCi41scSw3RFtPI8Kbk+i27BRxZ5wfD7xRR9myq7Rcs=@vger.kernel.org
X-Gm-Message-State: AFuF++lWwpv1L+xXA3l4RSClEdXO+lDjbUnpAneai6n4RHBOlBBH5u7D
	Z6w1z27XiUdbUJGlEpHYOwW2S52k7IrbKYgEGyuikmmDVnx/SS0IPhSY07I/SgxjWNe4HctuTMp
	kZIG3xgJi8RdVfg==
X-Received: from dybgl8.prod.google.com ([2002:a05:7300:e008:b0:322:9543:a5f9])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2d2c:b0:3d1:39e9:b261 with SMTP id adf61e73a8af0-3d7aacd026bmr8048089637.0.1788231865714;
 Mon, 31 Aug 2026 20:04:25 -0700 (PDT)
Date: Tue,  1 Sep 2026 03:04:14 +0000
In-Reply-To: <20260901030419.470246-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901030419.470246-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260901030419.470246-4-cmllamas@google.com>
Subject: [PATCH v2 3/5] binder: check vma->vm_start in binder_vma_close()
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
these, let's verify that the VMA matches the expected starting address.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas%40google.com?part=1
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 1b492ed48ea6..3ec3a77af106 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6018,6 +6018,9 @@ static void binder_vma_close(struct vm_area_struct *vma)
 {
 	struct binder_proc *proc = vma->vm_private_data;
 
+	if (vma->vm_start != proc->alloc.vm_start)
+		return;
+
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
 		     "%d close vm area %lx-%lx (%ld K) vma %lx pagep %lx\n",
 		     proc->pid, vma->vm_start, vma->vm_end,
-- 
2.55.0.897.gb25b4bd76c-goog

