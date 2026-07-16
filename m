Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592222EEE82
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226721; cv=none; b=gjEqRuBqSc1OrLVA57gTATLBgXdXTNl+TGzImRZYfI5qf8Dkax/Kc6eps+7VKccH4k6x67fyIuebimeMqK2I6SnRLQbvjVyPf9BQWvh76nWKinoogfXzAF6ls9vyRp8tQBeGA5A4u78SMBEsGCpXVGB5Ri94pyIrTxA5vXKVmQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226721; c=relaxed/simple;
	bh=VT18DXOtgt7oi0I3B0HOPYZr70omh2IjfVSy6WXbX+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpuWR7lrMf7KmEablR/4n34aK3sfLn9aykgjQsE/40ZQ8dhWKBx0M7rOz+gsHTrmqXFfxxCWQc3Hp67xTRGFHJ+5ZLHsoE/x8LNHGAUIQH6v1NlKkPhqa2gxJVhVLVOgMDo2IowRqC1w6XeXWsNzZ+OlH2ZRiEwq3Me/PGWcAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyRLJuW1; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyRLJuW1"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-447a81776e9so2587719fac.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784226719; x=1784831519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OHB0+oZfaIMt3j2ttBM/Bcj/urTp1/X6MkZ1JSUewnc=;
        b=TyRLJuW1RJ78SA/MOZVJuliwWqKALsAznjaPeurYARCZ5EBOSGhQNf0aQ7T+TJ23h3
         iqeklN0ap///nOMCJgKmDbCmaTSkgzr2s+LN8GLwA+WLCo+zQ5582b+9VQtW5Hhs1ZA0
         hmS6ebwwiYaiud4dWNY00NCwOvRwdwL9Vr5hh8Yo8zc4w9G1WVIdAeQZaqqLuwPefnBL
         qY9eArr5DU1qQ8QSG20LN4YCNEop78NpPlIrQTJp2ZfrR+wftSJbUtOKP6uBb7/bq56r
         KT2tMUSJdbc7xMx4Rtj1BfbiOIY7u7WwhDLk/iAKgIn7QVZb5qjqWkrbCaoH1vItwnzB
         RyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226719; x=1784831519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OHB0+oZfaIMt3j2ttBM/Bcj/urTp1/X6MkZ1JSUewnc=;
        b=F/8hsVpbW0SmVqsk+Hsb8XC5jQbamve9dXRkAZlWKzGc+yh3/Sp/HB1krikxapM2wu
         f7t6uiw85QY9wlcQmsDlgkHvGgwi9Jo1TReoj2iRjWrSwvGaIxWDX/LdugE3PNA7PLHs
         ezFyjVW7fsz+LHptZKnGGrSl2V0wFVokm8jD+THBfFS2FE2d7KDmLZA02CJ1nwzZ5txd
         YegM7vLe0vYJbr5o7m4iZ4jOAL2J4iQlYaoqPInrs95ouzINkmmlNrushjzDGIb/4m9O
         h6Q6BWRHWqQ0Bq4M3+zlPms51ad1b7UOGbU0qvi0VIVRMiGqhnEfLL/PRLKTfv7uBzIC
         LpJA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5mm6K3/02aYjEHLJd1DSO5oVA5zaMFnQo+m6rx0MGZIJvof7sLIAZBUhndViUadO8+WBybr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5BpPD5A7EfcUnWe5CtOlnPNjw6Aujza3ixaN9uiFtFNSPFVxp
	SrwK0n4Flho/yKCRfMblCspE3xXgpTHXDA6FP6/XWO7sWmtlDI8wLxup
X-Gm-Gg: AfdE7ckVNAbd85qDORxZUxP11w2SZ5E7LK0XwFwvEhVq2sJbQ/l65+u3ZOh9Yrc3i4K
	jraUtGuKPlnBYFNL2ibO/Ed3wBN/GjUgdBwI3IqkC14MuNx8L3JsMSE2lMOyoHE4uiRW9QpDc8A
	pO111v/Sxa4izezBFqQI3l0ySg2oK90KhPIiC6re7j1THSN2BjULMivQ06ZFHYO0h1QsjWTBeMX
	lLpgrReSCmMnNlkx+iSArgZDFkMgDzi2jQGMqn4jESxzDDMvTLTz60iimAK/1UUS2KrMuQnLX4w
	2TZnDS9MtyAHdRi2RB4SkKvZM7Q58Tv6xDUIwMh+2j9yu0PDh+91i1GWu3YLO5VdlNU3RdMzOz/
	9pDdgavSQHb18fTFVlg8in49hafkElkH1GMvuYw9g8UZu7AY6FQurFTOA6RIwmzNw8glJkO1s/3
	hmovipfREUZxkQ7jTWM+pVeihXlJ3VhmkaA422RoEHqYMxE0kDCxF8
X-Received: by 2002:a05:6870:e99f:b0:43d:20f3:bc86 with SMTP id 586e51a60fabf-4560aea3309mr6716076fac.0.1784226718966;
        Thu, 16 Jul 2026 11:31:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4519d89f7desm20985156fac.7.2026.07.16.11.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:31:58 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] fuse: fix missing barrier when checking io-uring readiness
Date: Thu, 16 Jul 2026 11:31:42 -0700
Message-ID: <20260716183144.2710480-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260716183144.2710480-1-joannelkoong@gmail.com>
References: <20260716183144.2710480-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_block_alloc() reads fch->initialized and then fch->io_uring.
fch->io_uring is set before fch->initialized, ordered by the smp_wmb()
in fuse_chan_set_intialized(), but fuse_block_alloc() has no matching
read barrier between the two loads.

This may lead a CPU to observe fch->initialized=1 but fch->io_uring=0,
and skip the check that blocks request allocation until the io-uring
queues are ready. This can reintroduce the lock-order inversion deadlock
that commit 3393ff964e0f prevents.

Add an smp_rmb() barrier to pair with the smp_wmb() in
fuse_chan_set_initialized() to prevent this.

Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
Cc: stable@vger.kernel.org
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..bd3b48c4fdff 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -85,7 +85,13 @@ void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *pa
 
 static bool fuse_block_alloc(struct fuse_chan *fch, bool for_background)
 {
-	return !fch->initialized || (for_background && fch->blocked) ||
+	if (!fch->initialized)
+		return true;
+
+	/* Pairs with smp_wmb() in fuse_chan_set_initialized() */
+	smp_rmb();
+
+	return (for_background && fch->blocked) ||
 	       (fch->io_uring && fch->connected && !fuse_uring_ready(fch));
 }
 
@@ -120,9 +126,6 @@ static struct fuse_req *fuse_get_req(struct fuse_chan *fch, bool for_background)
 			goto out;
 	}
 
-	/* Matches smp_wmb() in fuse_chan_set_initialized() */
-	smp_rmb();
-
 	err = -ENOTCONN;
 	if (!fch->connected)
 		goto out;
-- 
2.52.0

