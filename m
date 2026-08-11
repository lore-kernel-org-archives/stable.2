Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03EE43BDB0
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458561; cv=none; b=kjnV+JMJ4xp0umWn54T/9utprLAdRNXpgtu05an3PwSDWbUcDNfdLque8aG/I2H+FTLRGE4lWTw8bPmmFBoSqgRmge8kdWKEb2PtBT2Fd1dx+d/1icVwBWMUEcgqcPpCkTenRlNHoJqGBkB1yQw4aqxCNqzFlbDJFKPQXZO8e1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458561; c=relaxed/simple;
	bh=25RfUnYCCAn500NPErkFHuNL6+Q3MhhwJRPB178c5V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFTE0J8JeDsog0p73EqTI60VCvoQFgUEuGVgnwzjqUw6/OU/46q/CcjKd1fi1Wz12UkvikHwC/8S5XbtUQj/ZYKKHgIyw4DoGkdUaF0b89lr157ner4HkSu2mg026XcHOhdHPfy8SbgJO+upVNR4QNEboo1vCNtNETZzEb0acg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdWHcIH1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdWHcIH1"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84830c774a0so3250635b3a.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786458559; x=1787063359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mwCkWoypVWX0DUrD2GWalLqHhPmC5gYTzx+dm4HNg9s=;
        b=GdWHcIH1txRQ0aCzC5Tu2tdg9NnSH3H4KapoV+2/77OSA9mkSZTMm+h5GXxLqfZZvo
         mEz3Ot6gw58HPf2/p3jqfDu8cMwhwYcXa2MRhRMf/fGRlwKsmGNPQI2hMUahzqw7Lt8A
         gGGREnTI+mfXMOpii52fEHOfl+2LZ8yLtI4xSnOOvtuw6G5FyW6Q8VcI+OgqMADPeK5U
         xee5dTAQIYx5SWyCsJoNxy4QvqKmJloiPOE6omP20zlZmMuLO4VuIaAPGKj1sxLRs/on
         xgqEPgwEMO6w5r3qBQHWT8FSfNYkTrbgH94YvtCH8J81XBCVCWtnNOJ/d4/sktmUj2mu
         sqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458559; x=1787063359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwCkWoypVWX0DUrD2GWalLqHhPmC5gYTzx+dm4HNg9s=;
        b=B20BjRpBceea12pXbzr7Sgc1E+HezZTazF/654rLWrZYJjQOV88X6IhIyReHiz/ZJK
         pwlujOb/bw1esJICg4/sXr6jugQWakl/ip9tjUsWJhKjNPlJTnk8G7qBbsAtASKbWwS0
         /KU3rcSlvxbIfnwyzVC9tom3HZbhlSTYZd+Eap+Q1LhsBUrOffzCMjRCAdviNgjS8ym0
         y5wTJ8/ef6kchE9vH2PNB/8/f6MtKqZ/y6z1KFBnr+EbFJzwF/neUR/PeAPxEGVEh3xR
         5u5T1SIBa+Dmxq5C0fshG/YLZnc8ay5fN9gcTxVXDVpzS5Iv2/NQsvdxG/p3pAEi3Hy2
         pL0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq6RSEHsOuRDV1Ny4jLXa2bF1llNKnDnEnvTiJT5fr8W0TMKXvGAgMqp5w4Po9gCACAjEaZX5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxTjh1JoWCHbzcdhEbzkfZw08omH1GdKFe2A1mx8zE+1kGBlu
	jAZz+gpYkfLoK388MJFISQqKidWOuF/+LrKFASyTe7ah0pYSr4O0ZHRK
X-Gm-Gg: AR+sD122ldwUXqodRpi2vQSjwisJ7u3GlcGzo5bxqrIAxEd8aCaS5/wez2ksWZeZu8E
	+55BE0lygycm9Ylkbc9gLSLbIF2wlt8wgWQ9g+O75+BSkpPUkl4izkCuR7cf2rV6d4xoC8Ci1fK
	NObvSIMa0OQ+M61QgsL44cB1fOzhJvQveXk7rPUYBIBwl5nui7VrtLQiOJIo1ELJYl2HfyxWwmj
	O4ZpKTcFjKjeWtGGzKAu+dqRe2Uk/+bzywMA1Gq3QiKgpDHS2DbI1x2bOJsWEk0Q9RD4KcFCgGS
	iRTFlPdelEMeIo/DGFapWOn3T/nlUS9KE0qgyrQudSFqNEH6jFRfacW5iiuCYrUZfHIb2FLQ7yP
	ryHFKJqhoQRG75RNAp7Ebo+6GbLFTHLWxQ9C6C7AIjtOuaSI3mvD7rgxwjoVA57q8MoMgZK1PP/
	YS5b201DI7tPudjhciTYOknM5op61sX0+jjGVPdrSAOzfqTmus3W8tkstHSzU=
X-Received: by 2002:a05:6a00:848:b0:845:e8b5:8c49 with SMTP id d2e1a72fcca58-84fa86aa6f8mr3656519b3a.10.1786458558584;
        Tue, 11 Aug 2026 07:29:18 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa954fc8asm890209b3a.50.2026.08.11.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:29:18 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 22:28:51 +0800
Subject: [PATCH 2/2] drm/nouveau/dmem: fix callocated underflow on large
 folio split
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-nouveau-dmem-thp-fixes-v1-2-2cdf9860af2a@gmail.com>
References: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
In-Reply-To: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Balbir Singh <balbirs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786458544; l=2343;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=25RfUnYCCAn500NPErkFHuNL6+Q3MhhwJRPB178c5V4=;
 b=KuT7Vz44ftGEbyMSNmyMs8gTFuhkVAnAk7FcqfCULSkaKx7+Tre0AqjyKJ+yRD05IFx+yF++P
 mhFHY/fO+knCTMRcui6xM+5LBLSBox31ZOFlheXXru87VbNIRBncJX0
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

nouveau_dmem_folio_free() drops chunk->callocated once per freed folio,
while a large (compound) device-private folio is only counted once when
it is allocated.  When such a folio is split, the mm core invokes
->folio_split() (nouveau_dmem_folio_split()) once for each new
sub-folio, but the hook only fixes up the sub-folio metadata and leaves
chunk->callocated unchanged.

Each resulting sub-folio is later freed separately, so after a split
the single allocation (+1) is met by N frees (-N), leaving
chunk->callocated short by N-1.  On the first split/free cycle it
underflows: WARN_ON(!chunk->callocated) fires, the unsigned counter
wraps and never returns to zero, so the chunk can no longer be
reclaimed (nouveau_dmem_fini() also warns on the leaked count).

Account for the new sub-folio in the split hook, under the same lock as
nouveau_dmem_folio_free(), so the count stays balanced.

Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory migration")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index d2abee3efb9a..ad4570c50be7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -279,11 +279,25 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 
 static void nouveau_dmem_folio_split(struct folio *head, struct folio *tail)
 {
+	struct nouveau_dmem_chunk *chunk;
+	struct nouveau_dmem *dmem;
+
 	if (tail == NULL)
 		return;
 	tail->pgmap = head->pgmap;
 	tail->mapping = head->mapping;
 	folio_set_zone_device_data(tail, folio_zone_device_data(head));
+
+	/*
+	 * The split hands out a new independently-freeable folio that will
+	 * later be released via nouveau_dmem_folio_free(); account for it so
+	 * chunk->callocated stays balanced.
+	 */
+	chunk = nouveau_page_to_chunk(&head->page);
+	dmem = chunk->drm->dmem;
+	spin_lock(&dmem->lock);
+	chunk->callocated++;
+	spin_unlock(&dmem->lock);
 }
 
 static const struct dev_pagemap_ops nouveau_dmem_pagemap_ops = {

-- 
2.34.1

