Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEEC495059
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642366; cv=none; b=dcprO1OndCf6o1Ap0Z7uC99i3Vy55NEAwGz+rznIAfbvkumcMEEXbaNH7gM/vDtiwDnyvFNk0Wp86Rji7ZYtcJ8bhP/clFh67sat4zGx87YMah/yLXU+P1TFKQj9mhQALyw3PvaRMsOhKSxYVEB9OsjaPxjBAa7x6Evz7zDsraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642366; c=relaxed/simple;
	bh=o4/QakPrunlwH4+UeYVVLEHPsvh/uElL+9OeE2y1nUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5EZtv+/7vLNIJ9hpPD+AlDIG7Gw38Wa60BBA5u0lVsQ4mIdfmQTBzC+Xvf/TEVKEm51brSJ/CY86Wgm5xZLv0cSwdVRN2APhKXiz3x4IRdGo2Yi/Y8GQcGmsvxMa9DUBf7tvt4iHSpc97LD7lDVds0fGLvDnWF1ejkhBou1PGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAyEGIyq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAyEGIyq"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6af9befd04cso618101a12.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642362; x=1792247162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7L40EAbnIhHyrYuzeYb9zTU0QWMZbUjoIPPndxqWSw=;
        b=IAyEGIyqkCRD/VWxTmVyyNgTyG4zaOuUlexdPM2BSlIWPFFYPNcM7LC/ZSBBqMJqxy
         iK7tt8udx1w+Ql23zpcjcK2VATVESP4flCAFrWg7CZc5rt/TDg6RSnphpZ1NJbYYpIF/
         DrQR9+I6r4ACVDQ52RMoTzXpO3ij8YcqdwRbuP163JCvH8GlesyKXDMffyVVheKtVXnQ
         +r8wmDrMJcvtyUIkSReBX+eoV9SxWfMtVLo+JBUa/3LPbiXXxjMiDjN3p41s+TCDNpi+
         Jxzr5OJqH2uNN++Z5/6Og+zOcj2HOtM/imSrVYneK912lKCP5DIwFGgW1w7q4Wc2p8qI
         BssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642362; x=1792247162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F7L40EAbnIhHyrYuzeYb9zTU0QWMZbUjoIPPndxqWSw=;
        b=hpZzbVZVW+5thgv6KMvxTRFwpqyLFk+zMv+3jDAKNyTOZiiutXNg6GPn0QKRaQ5QlL
         KSAbcOwvQ9xzNDQD8q0QYV1jSaelCzGQQQa5TN1V4voSYDacfXsPxu4cqzUENIdpqtbp
         0LH2Ubj5AxnwFRQehgwc9TzDO8bK46euqL5VMtmg15LUrI5isyd30sGZOVfBXe1FLoPm
         MXl8Eu0XHTnnhrWXMz3T9pSoWFp4ELJCqNrKjE1GWEJALqJAXsvcxmjJSXz4X5gFLMHo
         B02EmtCPkBsKOrcSyiquC9C0GLCT1wf/PYWsUhdNHLm5g/y4BCPL2n3WHsUjuz52TjcZ
         rM7w==
X-Forwarded-Encrypted: i=1; AKwUvBwAmg0PSauzC7wlLhzA/zm0WobhEtPaL253fbXhP9XIkNdGiFWmTZ1GI9Dcb93vQ9e/PNx9K4Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWPe3IVNWSeL15QVHYPViBLTGtfgq1oDa/5dvRfTTNPNpe0RJU
	W2jjsVlDvUwrt8QWkGFc0ouhlukMzdwwv+5szDW37LGrsKNOgtemo4xo
X-Gm-Gg: AYBFou3NUFB4u5sl6HLXwhvvg/rcm+k71asMLSsY2S+X5KGd9ldtdaitV2ugbmqdnQ+
	k5K6tJ7MpmjiCVuKwAih2Pn+nvuV3E39t1reORsxDRG0zXUhrX+ITbvV/lFtxxX0JKkHjpalM48
	wECVBCIxCH45ABrFvMH3uGv3SS+yr3OyeYkcV59DHR7lCroBxnGNy1yc+TPu+WUfnVOgD8rr+K/
	SVAzCaHjO4rQIenll7ciriuoo/H1ELVne1T2lDkak6meNilwghmZlryHvAp/gzqsy/aFrwCWGp8
	BSPP5RyHVv1H2bxp0G+nUZACI3LaKKROreOvt1DgT0nsHo4GVSqCoLN6/fE4goM910MC1XRGePV
	xHzV5+5EX9dDkttdG76qpszdlEV+fCrTwd5hpyaz9hexeXxIoXdDH9XxkR/euchQJT3+PYgzBmG
	SqOsTpuQBGhzkhwnLDY8gQxvoPTKI7vywVcfYJ9d1PnfAK9VH/yLuo21GNpcrMkUOewcHJnM52d
	JuvY9orAnlb/BX2A8ANzMJjEFzyx79FFdGFz6Nk
X-Received: by 2002:a05:6402:50c8:b0:6a9:946a:d085 with SMTP id 4fb4d7f45d1cf-6b17c2b1ademr4491217a12.19.1791642362505;
        Sat, 10 Oct 2026 07:26:02 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm2635586a12.34.2026.10.10.07.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:26:01 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v5 8/8] alpha: invalidate the local context in flush_icache_user_page()
Date: Sat, 10 Oct 2026 16:24:34 +0200
Message-ID: <20261010142533.974797-9-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010142533.974797-1-linmag7@gmail.com>
References: <20261010142533.974797-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_icache_user_page() has the same caller-CPU omission that the
previous patch fixed in flush_tlb_mm(): when the target mm is not the
calling CPU's active_mm nothing happens locally, and smp_call_function()
handles only the other CPUs, so this CPU may later reuse the old ASN
together with the translations it still holds.

This matters here in particular because the function exists for
operating on another process's mappings: the comment above it describes
setting breakpoints through ptrace, and access_remote_vm() reaches it
through copy_to_user_page(). The calling CPU is therefore often running
something other than the target mm.

As in flush_tlb_mm(), the uniprocessor implementation in
asm/cacheflush.h already has the missing case.

No imb() is needed, here or in ipi_flush_icache_page(). Alpha's
user-space I-cache flush works by allocating a new ASN rather than by
invalidating the I-cache: the entries stay, but they are tagged with the
old ASN and can no longer match. An imb() is only required when the ASN
space wraps and numbers are reused, and __get_new_mm_context() already
does one in that case.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 988e397b0b8a..e21bc3920bec 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -758,6 +758,9 @@ flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	smp_call_function(ipi_flush_icache_page, mm, 1);
-- 
2.43.0

