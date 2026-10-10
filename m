Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652149E124
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642353; cv=none; b=I7nFE0xImjAbBwH4N45QMnrZcjUSa/qTVoC5D/B5aMCH2yV+g2THK6VUjIrw2ZzXDKmZlh678bXl7XrJZsdtTAzf5LQ7jGYY/fqtd9U1s/H077CS4nMsES6T7h8L27nfSv0A8Nk8AGy9tMXWKwGqBojHo8Igzw31IrwWfp4WFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642353; c=relaxed/simple;
	bh=cXkMIq8q0zl3V52rVeK1piAZiIn6KlSymnHMZWG51BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6kmj3yQut/n85v/sNTGkVDMgBV+KJH8hbO61dXS7rwJrBOhkW5geTOKtIq6ur3eyqmItFdz6NKGyxCgyOiT9kKl9ktxsNdfzP36BHlahG3AURB3LoyXRLiM8rKxF4O/hcT9ZvAE8ChqucEt/zpWLZExWQ4lh1zfyKuutldUrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNXJOjxW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNXJOjxW"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so720617a12.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642349; x=1792247149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVnDfPQWDbfz+z7bzr+fAeI6gucp+XBlKaScYOwyp+I=;
        b=HNXJOjxW0ptz1QlJo8zynhmXR0GJJtNxcWpblcUqt8avQoc2GwYVOF70fkE79RDOt/
         e0nC56VchERHygXPmmBTosRZpZ5NJrQ9Le5pBw/UbqPsqXWP75XHKfYq5t5NemCCmE/P
         00FWiiqTFvp1KupAK7OxRtWvqbiyqu9gq+EGZB3+h4eHwS1lt8ujekvLylZazUSA8DW4
         z5l+ay5iFow6KdVtcKjmEsGCOjsQQlHAK+En9lfmqLtsbcW/xuXIkUffqO1jCg5lxLPz
         fSNymp4BkbIcfDS6C9Ywn7NKAtni8sGtUP90Btn3R3RIhKmmxwZx0DI6gi3pRobrJqm3
         JLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642349; x=1792247149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVnDfPQWDbfz+z7bzr+fAeI6gucp+XBlKaScYOwyp+I=;
        b=CpZLrOhidUqM61xYH/Pgpcudb/mNXuBzodgRAMKEPCatHtY+x5B4ZluY1v7mvZ0/nu
         H8Al2UOPu3odNvXRVGRMZNK40c3IMpQq/Ma1M65YhlW9txGenfH06G7VJFKWtQzrnAYw
         xJgTR6HE2NTCPsvSe6KedwjDyHhQb0y8ICUBZq3MG3VZpjubJXHWA3oC1I2mlM5zBToT
         XS37CXBDL1TGOSzl1b97Zduq33jjPSB79hzqbWA9Bycbspbey7i5I8DFIrXRbNEUNruI
         UOJ44EQpSAvUHpRH1m5dTaABqmD/Eo8iSPRFVbWME4C/4R7Mt8RAQ0dVy5WCrzz1hdfG
         d+1g==
X-Forwarded-Encrypted: i=1; AKwUvBxadBUzuf2uUQ1LP928LVcjgW0v04jqCT9pSvQOiAk9dtAEdr7pjYeMMloZl7ET78CeHw37cZI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvT+cS5wrYw3R9nZn2DexUqmxXCJ24fplFwyU6hJnI0RevfSV2
	UfA2PYHq2Djei8FZa39MnBmjuHwtJltQal1+2b8DiNjEfG69VdODWrq9
X-Gm-Gg: AYBFou34075iiHsfmt0dIIviyUiKZC8njIBy1IkQ55HpEUy2lsVC/G881S13n7hwgXb
	gOlZWC/73q09hsPAVt2p0sKIMA6epafZ090xKom/b+Od9E3R6/5Djn0lXqgxE6Z39F64WhI7h3P
	SD3zKxNorIabnxjGXbpEQG47shT21twdrmKZw76zcKLHJSiLrhIhE2J7r9YCKCQqSRuyLYeag+1
	mlaqUJn3xB7YS1ITRlUzAnWd2F0MCp7qXzsb46dIs3HFf4DE6tbx8mgntfOxQa5FfwiZHsmo5gI
	KrlaWJHZqdfzeHSQ4eEKo2yUiS3xpWZoL/o3v5qymWv/Pc5xH7EMH+vf2YSOd6TL3s5tplRwGAW
	BP/NY8W6LbZFYH4wsNOOKU47E1uOjCfPl+DZOwnDprDwbBXhEmAFdMHYOVrsf5cZ8DonLbSF/lW
	ttJ9afdrzXfxJu6vEY9JW+Ch6hFww7HQod1pYl9lXxrX2DHKlx2X4+ccgDrk6zMFPd3QeIuqvHf
	SVwwhWCyb770wW2as6fmZgyAtAlZBP8uJKvlM9M
X-Received: by 2002:a05:6402:5189:b0:6aa:f809:ef44 with SMTP id 4fb4d7f45d1cf-6b17c296a4bmr4478915a12.19.1791642348794;
        Sat, 10 Oct 2026 07:25:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm2635586a12.34.2026.10.10.07.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:25:46 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v5 3/8] alpha: only use a targeted tbi() when the target mm is really current
Date: Sat, 10 Oct 2026 16:24:29 +0200
Message-ID: <20261010142533.974797-4-linmag7@gmail.com>
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

ipi_flush_tlb_page() gates a targeted tbi() on current->active_mm.
tbi() acts on the address space context currently loaded on the CPU, so
it is only guaranteed to reach an mm's translations when a thread of
that mm is running there. current->active_mm is not sufficient: under
lazy TLB an idle or kernel task keeps an mm as its active_mm while a
different ASN is loaded, so the invalidate is issued against the wrong
context and the stale entry can survive. Nothing retires the old ASN
afterwards either, mm->context[cpu] still being valid, so the resuming
thread can reuse it.

Test current->mm instead and otherwise fall back to flush_tlb_other(),
which clears mm->context[cpu] and forces a fresh ASN at the next switch
whatever is loaded now.

For an mm borrowed through kthread_use_mm(), patch 1 of this series
installs the context before the task can take a shootdown IPI. The
current->mm test therefore covers that case as well.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index ed06367ece57..1ad448105201 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -669,7 +669,8 @@ ipi_flush_tlb_page(void *x)
 	struct flush_tlb_page_struct *data = x;
 	struct mm_struct * mm = data->mm;
 
-	if (mm == current->active_mm && !asn_locked())
+	/* A targeted tbi() needs a thread of MM to be current.  */
+	if (mm == current->mm && !asn_locked())
 		flush_tlb_current_page(mm, data->vma, data->addr);
 	else
 		flush_tlb_other(mm);
-- 
2.43.0

