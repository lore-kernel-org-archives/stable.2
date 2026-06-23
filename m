Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030C2DCC01
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179209; cv=none; b=DkN1O5bKG27FoOQ3oQgBfcAt3omnXYBPrX6FxCN5Q6Jz9GYT4I5NWdj0GBcR9iMBvxtZDYlItRUTRoOrNdyfRRkADo7+KSCkpnN/B4XkwQTJiCeoe6CvQK83YF5x+P9QbrslpMpAHw/Uks6ONKw2dLMrYJuHuWiPdnZ/ZrGAkNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179209; c=relaxed/simple;
	bh=2apY+z0N2eT8oIYqkywxMesHZ3STxvb01hviFdFriTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rERLuwMLK8E0IL4X3HlU2ueZLP8W/pLyVywAVyA6ywrUxtahTg5GziItYn+dDugfePFeXGT2sxe/KbKlKEaLiwza49bFWgo2sM6aqBvv346Hjko3AYcel3uxbTW8kV8wgDMsnfmgonBVGexvEl2veztwJx2FNAll/eDnCVd/Vyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFhBJgXB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFhBJgXB"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so25835ad.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 18:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782179206; x=1782784006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W573SLR3fQ3LHn7BMqDZVpOE+yHqb2rgziXRTcKO9m0=;
        b=NFhBJgXBZKaoSIu3MQhuzAADP234qklEVlguuLp42HCDRjCopVdfDbJUr9RfJgTDNx
         SK01RjhsnEyRUivuQ1AQRtN3+8WhE0mkTiq7U/j1W40pUn5d4Mz55HOhS4m+C+M8SUjd
         DbZhVH2zOOnRw/05EbcEUBMwmKErPi39eSfAvAiOyC8Acxz1zd2h3UYWSf6gTmhq17AP
         1Au6T1KGNiNFcLSOfjtN+GxSjHxye3/4f5oVY+PIpgBS+gHkwpQgX6VP3PaonUznfMgY
         0SrZpyrj0ZYyKQg25/rLyueMz72oycq1NGSLG0x82IIvu2UnGBBWXXzFKLrIKd8H3I35
         lNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782179206; x=1782784006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W573SLR3fQ3LHn7BMqDZVpOE+yHqb2rgziXRTcKO9m0=;
        b=L62L3rAJdCsTOtPaTscAe4aexRNyBw1nZ8MOMiNEkrDP3LwM/ja7FGHD1O8jsSnsen
         BCMHm+cp1ZKfK48qu9ETYPL8gSxdURkrAuWYPLCqr1fDDvO+z93mOvfLu5kNJbPsmDgt
         cBK+HkYc9u3o2XT+6vtZ6Hci433hyepr5X12dlPlISQR5+iUKpiTc0bAyXmSQgpOmeUB
         3MePMp67k5uG8lh8bJqeWtyNozr5K/QiNKF1nwLXlpinZhGt1Iyg9KRiGLwec088pNFN
         NDNrkC2VJygo0hMJMjXDNaLD9yDdRX3wD25Rjl9ZPzY8f/MLmrDsp4ULo3HMyWfLdKv2
         fhyA==
X-Forwarded-Encrypted: i=1; AHgh+RpYljgrvmwJrkuraB3z1HBHh08J5lrAiBRo0BTumsqTlaEQRXS3P8ZMYI7tGbkfOzJQJRPrkb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XiVoH8s6DanWldINpBeUFzjLvOaHmUWBxN9x98TkVFIgSm9i
	fco5PWgH1YZyaQjjO+yMqY+iPzuAyXY5GEadX9Nt8nbeHP0dgy+p26vs2VgoSjl9h2ZMF4Cgayt
	HrTfUWg==
X-Gm-Gg: AfdE7ck7uXHwQZBCvfQRvoV2S2ZQKhjxI8RYrbYt3CWL+MsCEBwzgBlIEUpNEVNfWGd
	YfRWThealwMb0IiV+uVHLGnNHAkFfsuYX+ExvTsEJQjcei9bQtAcI1rQPucJET0A5C3ThI5gLcJ
	NiamAmvUdtCt+iDEpVpdcA07qqAYTG1KGo1Wn1K6eT7O74RjKzm7RR8BBvVWJZYamFRQ8Tbbt9c
	2WvaxbmTUxeUQ3bXDqZj13QwrLqsqpqqoyb3Oe+0hJcnNPsJHDtCcGgXv8gPPBZFV/XuU7CCv6i
	KsSbq7IA1rtqlcMPkIl6TKyQYYk8LFX/e9giHT06zXTEIiZHaKt+PRmWQn4ISR6PwcaYBMIt6F1
	Zs+77HULUx0cl2Xy2PrTs5fl8b5j1F7A9BtIWLmplSEIJFm++SaGjCY1BUbbc9peKl0Qw3qE1Xj
	3PA65SWhNrz6ceOSHthi4kQudeF/b0JTBIu/RgHhp6jt3m8jwGIXh+w4qVKcrGEmJX/1zrxUIci
	dOGQFVyaC+Y4cuKgpA=
X-Received: by 2002:a17:902:ec92:b0:2c6:afdd:e62e with SMTP id d9443c01a7336-2c7c5156f0emr1179185ad.14.1782179205657;
        Mon, 22 Jun 2026 18:46:45 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af54dsm92530885ad.11.2026.06.22.18.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 18:46:45 -0700 (PDT)
Date: Tue, 23 Jun 2026 01:46:41 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org, baolu.lu@linux.intel.com, dwmw2@infradead.org
Subject: Re: [PATCH] iommu/vt-d: Fix UCTP context table slot when copying
 root entries
Message-ID: <ajnlKDglN6wEBBrS@google.com>
References: <20260622133540.48591-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260622133540.48591-1-desnesn@redhat.com>

On Mon, Jun 22, 2026 at 10:35:40AM -0300, Desnes Nunes wrote:
>When translation is already enabled at boot (e.g. kdump), the vt-d driver
>copies context tables from the previous kernel's root table. In scalable
>mode, buses that only populate the upper root half (UCTP, devfn >= 0x80)
>should be written to ctxt_tbls[tbl_idx + 1] through copy_context_table().
>However, the current copy path always uses tbl[tbl_idx + 0] in this situa-
>tion. Since idx wraps to 0 at devfn 0x80 due to a zeroed LCTP, new_ce for
>LCTP will be NULL and keep pos equals to 0. Thus, UCTP entries will be co-
>pied into tbl[tbl_idx + 0] instead of tbl[tbl_idx + 1], and written after-
>wards to root_entry[bus].lo instead of .hi in copy_translation_tables().
>
>As consequence, devices on bus 0x80 with devfn >= 0x80 fail DMA with
>fault 0x39, which breaks drivers running in kernels with translation
>pre-enabled. This fixes NO_PASID DMAR faults for UCTP-only buses such as:
>
>DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000 [fault reason 0x39] SM: Present bit in Root Entry is clear
>
>Fixes: 091d42e43d21 ("iommu/vt-d: Copy translation tables from old kernel")
>Signed-off-by: Desnes Nunes <desnesn@redhat.com>
>---
> drivers/iommu/intel/iommu.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>index 4d0e65bc131d..737936f942a0 100644
>--- a/drivers/iommu/intel/iommu.c
>+++ b/drivers/iommu/intel/iommu.c
>@@ -1443,7 +1443,7 @@ static int copy_context_table(struct intel_iommu *iommu,
> 			      struct context_entry **tbl,
> 			      int bus, bool ext)
> {
>-	int tbl_idx, pos = 0, idx, devfn, ret = 0, did;
>+	int tbl_idx, tbl_slot = 0, idx, devfn, ret = 0, did;
> 	struct context_entry *new_ce = NULL, ce;
> 	struct context_entry *old_ce = NULL;
> 	struct root_entry re;
>@@ -1459,10 +1459,9 @@ static int copy_context_table(struct intel_iommu *iommu,
> 		if (idx == 0) {
> 			/* First save what we may have and clean up */
> 			if (new_ce) {
>-				tbl[tbl_idx] = new_ce;
>+				tbl[tbl_idx + tbl_slot] = new_ce;
> 				__iommu_flush_cache(iommu, new_ce,
> 						    VTD_PAGE_SIZE);
>-				pos = 1;
> 			}
>
> 			if (old_ce)
>@@ -1484,6 +1483,9 @@ static int copy_context_table(struct intel_iommu *iommu,
> 				}
> 			}
>
>+			/* Track if saving UCTP or LCTP entries in scalable mode */
>+			tbl_slot = ext && devfn >= 0x80 ? 1 : 0;
>+
> 			ret = -ENOMEM;
> 			old_ce = memremap(old_ce_phys, PAGE_SIZE,
> 					MEMREMAP_WB);
>@@ -1512,7 +1514,7 @@ static int copy_context_table(struct intel_iommu *iommu,
> 		new_ce[idx] = ce;
> 	}
>
>-	tbl[tbl_idx + pos] = new_ce;
>+	tbl[tbl_idx + tbl_slot] = new_ce;
>
> 	__iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
>
>-- 
>2.54.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
