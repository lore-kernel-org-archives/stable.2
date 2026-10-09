Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B53D8133
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579909; cv=none; b=PgN8MNCwuT1sHF+59vNWN/VXGKzcsZ3scoSpXC6ET+nX7aMEd8ABA3vVE7XWw7QSND9KI/LTE26tqxObLpY0APpyOlnT9R2yQQHjmqpSVD9KR4Qnno3kqxMJDUUohbWgS+GM9747zcmpp3ErURrj/pmiqyCcOIDGf1khwzS8wfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579909; c=relaxed/simple;
	bh=lv4U2JoYCAddpO2oEpUCrNtOq6iSFh+gZ2nPJ8zjVKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtPeqDq9s2ND4rUl9D0X/OE6NNEG6YRs99+lHMW0AnQFE6nUxuWx5qh6pN3x86RrV3wOZZoy0tygSqH8zvlCUGZAAaAMsSGfOFq9eemYRzMyskwJCwdW6P6KrLvIi2JoR4aVyU5Ha3ydc+Kgaq9oBiCIqFD9Uyt17/XCNmW4wOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGBOdr34; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGBOdr34"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c315729ad50so48901566b.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791579905; x=1792184705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMJNXVDBr1Y/oZTvHICO1h8qIMsaNHo5+E377B7YCuQ=;
        b=YGBOdr34B3OKPh6yNO677V4lRh80sYTMS+vsChsfzcqAWGhkMT97jebZUMfxpYCyd+
         FOzZCCiOrI/Zo+9RL6uN9UsTxjaK/jI3/L8v7cCxGmtTVUkCSmp51FdmuF4yZRO5uXeM
         2MedQXNZNAv8wqu3hyNfspwS1ct7iLsppzIgINNOzr6kQo+n2EYBLgR1qkXjPu2DXA1A
         x2b3prf1loaNeRzZrsmtEihuE0XIda0HHJGazoeMIGyTdea6t5guyuK3rjGhxXNherSV
         xX0uEzx2McRt6gD1jwnvaY7EP2uAqB9RiJKs7uFv3HQ7ervR36njCEBdimtZglPxqhBp
         Kh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579905; x=1792184705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FMJNXVDBr1Y/oZTvHICO1h8qIMsaNHo5+E377B7YCuQ=;
        b=VP6v0Plg/vIzxWb2/y+inQLU4W3cFbXm/UzoAWOhjn7C2Rku5eDwNS8Q8KQjmaqOEc
         oDUX++9rPiQFfdLOE3jdXd28xxzmIRBWR+lI9rJIxuTegev/S9sandjW7JBS/RsfSiUM
         MuRVOm/0X/ulGGInPXSuHNYAZ/7AMG4iY7cQqZVYkrGh9pzltPMYt+rTfJQU9ql6rXpc
         jRrmYbGjD6ZGOWinNXQMqQjSeGzQjsAowiTXCTMXXIzveI9C6BLIRV5eK1nAmmd+JAhm
         FMwRStIwgmKLi+HeYxcKtx9rO736deaLp2zUbhKBL8bc7VLkaDMW148sNYkQCZ6GdL71
         m2qg==
X-Forwarded-Encrypted: i=1; AKwUvBwYfmiazwThqfNSG6uL+7E9+EE5h+k40J/T0D/92hKaGj1eaAlNpIQ3eto0aaOTrQB1ezibxvI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDS0o8q6ixtsjAcROL7nYXhwsiImhHfxKnU9tv5kA+ldhTjD+a
	OfFK1FO1O8gPMvlWb+qU7Gt/Kgrj0NmsNl8qXvbag9C2BagixFJ1jwdv
X-Gm-Gg: AYBFou19yAGbl79mWFQ2yjJKIv4HAV29Z26zjXJTN7UTZObct05sCz8mjdCuBLnzgcr
	u4aOyqKkR/JWdxdx15HUler4OfvbKw3mRZhmjwuMtKmeummxd1cm0owgG7O2mxzC291AVkNOYnd
	fEu8nIovtGOJKRDpCI38TuouCkdvQ55uwX8pPzhwm9bBKCDHctZMroPgXLaA3m964zjOVzyd8Hr
	aFdkk5T5D63gAv2jvCFFB8Dy9aPPpF+fGCTbY0oq/rlSAxijODqiUizZlDi4AGyXJGHrClPB3mg
	0bcAUNbYdYAiFzTuFHxZ43GioOHiGP6KbxH+NQ6t6PAoeS51AbC/6zYHEtnO/GJ7fxuRJvhtOMX
	Zc1vY6bLFT01IjB5xOTujJh1hgoxLV+a7DlIAXLoCDrIWjjWK5Sr81ovn5QB3mBOMp1uSwCIxO3
	MLOFtLhkah3HaNxiqTzqwhRyrex2cDd12Sdg5OFx4pWeq2I1S9AEaPNhLnf514UmqT82cG1eRKY
	wvjdX6TPbNeBVR/Ou8HKZsNuSuAnDEVwdEDhnM+tg==
X-Received: by 2002:a17:907:724b:b0:c2e:1d6a:6b78 with SMTP id a640c23a62f3a-c31aa0e0cb8mr335909666b.47.1791579904459;
        Fri, 09 Oct 2026 14:05:04 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9765d1asm142141266b.8.2026.10.09.14.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:05:03 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 3/8] alpha: only use a targeted tbi() when the target mm is really current
Date: Fri,  9 Oct 2026 23:03:48 +0200
Message-ID: <20261009210449.971057-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009210449.971057-1-linmag7@gmail.com>
References: <20261009210449.971057-1-linmag7@gmail.com>
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

For an mm borrowed through kthread_use_mm(), the prerequisite direct-switch
fix installs the context before the task can take a shootdown IPI. The
current->mm test therefore covers that case as well.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Message-ID: <20260923074903.862898-3-linmag7@gmail.com>
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

