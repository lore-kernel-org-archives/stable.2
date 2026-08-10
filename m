Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E30442FA5
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390829; cv=none; b=NwT9sihb3nscgpckT1bzxGgCU3/jyW3SaLgR3vZul22s7tKndbE3VmGspUAqtZizxc7F6hNGv2PImACmrcEw73Q8LPqpDMuTSAzpCkOdtCcU5YdZBVAYi2TCXLiBAMYzboXW/PfMZgRwmKeDbCoyyi4cMDgHBsigtL/LD8+uwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390829; c=relaxed/simple;
	bh=HYvMhIHogsEmsh3zuOs4+nenCywngBzCFU9HdpqBDvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+kG8M2MbpGih4VSgXRmnCEaCuujpplnzqAbBYvOgous2HvOC+1Lutr8ps8T9R4eac0/hXLhj9ICRkjdeNADgZJigHt2y3itT0EkpKkB5GhMOBu+6YpSSVoGoLupeM3RtyVpcbCfaQO7oCRnBt9lOUi+0XDwczGvsNChVVlo2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCEO7LfI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCEO7LfI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1f5208b38dso6189066b.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390818; x=1786995618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5i+hFEyj9xNww6KQk9eCZA+gjMFJ8e7FKLAkoQOfyOE=;
        b=hCEO7LfIJyAfgqwVbXJTe02c0rGlsOStheZx4mKk8Mv1XHyWOHR2ap6o7+1lPNMekd
         Q52kXlZtS8LVqYw+S6oc/qnmG0lNxKjX5wW/EOVt8mOY0+USEypDjbtoFtEOg2tLHmTV
         X7NEPcVUpi4jZEWn0eG/KvToKPwswD60c8yyNzoDnSiX3/HwbWxbOKt1yoVxX7JeqHNh
         byv6hERL1sGmX68CWL6nEdNB6qmNNFvolnJXzkzem4lRYih0R4EfHcuKxDwV2ZM5I1JO
         a1X4fgaxsEgjx4Ak2ZL+sNeVRCsUEsFsDo4qVRbzohFJksRy0rX9SfRlEhZEYAD9MYpu
         Fb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390818; x=1786995618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5i+hFEyj9xNww6KQk9eCZA+gjMFJ8e7FKLAkoQOfyOE=;
        b=RCR4bT6H1//rIDQP281UZzNjnOhCR+4Y2qGFmQmL5pBctIzSFmhjSXAvSFNhRvTDQo
         fTJlbk7BKzdy9IUV8VthV8L94IMrJ850haYujoOZhFXP7FShu9MD/sydapDKVZgFQp2C
         jxqcYbMA+QDxhHB5kr1IUrHaeB4q45t52sOxisfuI5vwVn61YiXxlSRsnAywWWFGKruT
         zNcE15pFpwgn6lCXoXzjHc3s1DYQmT5QoZz6VvWoAYRcD2uwGw6bRAi8fbmz08aygv0C
         tNzIfG6/fhEo18BtIQPLLc7p0Ve8PVJmHuWFgm2z1k1R9yVpliSy8jjWfXyTISU+jRKC
         hjLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqhx9W0U0MMdgSHvMhPT0HsytE8o/0rzYiqEnsJkHpVdN6rURLJgr/PPaZ5sYWo7bG+cbO3o/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YznXMVGE+fNOynl4jSS2RF7bie4Zf+tXrfPeSwXcnI9jfodBGPO
	GkPzWU/PC+FfOKeyI6ZpPnE91/v1TwMSLHKZiUZxjCSL39vu4H3265QW
X-Gm-Gg: AR+sD113M2iONnnMd3i6fCznEgbeSoh2LDR52TBLMe6yUIvl18Wb5dLxyEczQZ46X2V
	0rG7gZTb9Z/p6bfVoIzvkFTXGUsLLvDWMVJmrdMNhTHB2sUDEkhz0AWi1ZEWJQw/33wT2xUVTRB
	e3q+L8QdePPqJfTPtdLlfffOmhU1f6IHdxtE37GGWLDQcq7FrZu5L7jJgKFRiwlDBcw5YzjuWRw
	BMCNjCpTSopar3JuvKxrCQEAJsEwVgzcmiOwPYDfmW7OuQuUUuEHvpbxZQm1iCKB1lRFpFIDBzV
	Qbf0BfIAey+UP1r/BLeLNRCbhRZ+Ef5DL1i8MJD5Q6CcGGAajPV9htdBjFb/MIWjgB88R6+aF2f
	yCP0yRl0wOfgqU4Xtt75TGP1z2w1cnz7HpH4DohirDOTdBoJSEzDAmtFwZhC/kCMo8azopBEKjJ
	UlQ2diWukTpWU1QsdEYLbEMRFPdmQfehOBnxO63q7QiE22Wq9Xa3CkvzSLYnkZTULt/bRkPtwwj
	eDjxuJ6OAxWesUB7NESZzAR9tLCwmmGVwGOGm1n6A==
X-Received: by 2002:a17:907:1688:b0:c15:ee0d:9a32 with SMTP id a640c23a62f3a-c2039dcde67mr2185271866b.21.1786390818037;
        Mon, 10 Aug 2026 12:40:18 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a84sm449928966b.3.2026.08.10.12.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:17 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	macro@orcam.me.uk,
	Magnus Lindholm <linmag7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/7] alpha: fix the local TLB invalidate in the UP flush_tlb_page()
Date: Mon, 10 Aug 2026 21:34:56 +0200
Message-ID: <20260810193902.3286353-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193902.3286353-1-linmag7@gmail.com>
References: <20260810193902.3286353-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uniprocessor flush_tlb_page() in asm/tlbflush.h has the same wrong
test as the SMP one: a targeted tbi() reaches an mm's translations only
when a thread of that mm is current, but the gate is
current->active_mm.

Test current->mm instead. arch/alpha/kernel/smp.c is not built with
CONFIG_SMP=n, so this is how the same defect reaches a uniprocessor,
where the flusher kworker necessarily shares the only CPU with the
writer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/tlbflush.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index 0c8529997f54..9ae1902faf8e 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -87,7 +87,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	if (mm == current->active_mm)
+	/* A targeted tbi() needs a thread of MM to be current.  */
+	if (mm == current->mm)
 		flush_tlb_current_page(mm, vma, addr);
 	else
 		flush_tlb_other(mm);
-- 
2.53.0

