Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591127;
	b=1MOu6E68ATqWas+glpXoS4ZssLaqTIMun2lPNYi+2gLSt+nvTx4qninlK0nFaQyXqweo
	 Ht8cfgJfMrYUg27oGQHBhFuopppC8JjDnpTQbqxWgaumd4+1r+eo5HdIZmXx6i/xBVDQH
	 roTbtqGjNuuOVidGAMSnsNbiDdarQ1578v3OAtTzS1vntsvptnLmz28iSIffDdi8CJLsw
	 DMnwuqPQf7jRJM9F/0Y+XKJbpoeYKlE5TrepkzsxXMss54S53I3XBNY9pK+MFXOGmwDaA
	 I6AXyjK+c1pvfqNGgSqIFjv+PtSjJGMjLF4rlsX8Zd1wGYiWB3DAIcLrLjRi8nJlcMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4zg/LYuc5EVJgXpf2aLA4/NF2gq/+rC0L8/4lGLzGqE=;
	b=Gm62wNzFD0PDWbofurffe+d4uhpSHla7D7qkQ+6YvafyTdsqQTjtHesOdYRA7f2uVMze
	 TJYeM4i0ChxonEYNSYgMLvOhwMNnI1FV5mWg4XnmfqHJC42aOtMo0j2Mqif1y3vSTpmJI
	 WssYQX1skHc5m3mSboMx5zhI8IQyQrP9fXTLdsPnnD6VRrlhIjg11WlAtaZtrQ0A8qjU5
	 31Swe/JVoojNTuRABrnMuJ4jwaSu6QZPmjgrUhk0w5WEPubhcIzIpzOh6N7EfXzi76wEv
	 2o2yVp6eJUXJh1GhUefsNpJSwUirZsJvmC+A6wqEytDSPa01mbJlgTu6VOfTKmkT82g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NBvJApti;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3346606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3346606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NBvJApti
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ad6499e88fso109430a91.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792591126; x=1793195926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zg/LYuc5EVJgXpf2aLA4/NF2gq/+rC0L8/4lGLzGqE=;
        b=NBvJAptiWLVWyTnnDIdNkW7PRUv0hDRVi2HNyBXHSlHsNGSpubjArczgoe0F+uKrMf
         E+TJ8OztoOv9h/IJm4b/4EAZqNxBOBnIF1mGWTYmCQ3MQspieCzuaqEzKawhWldsa4zW
         sh4CjX9QwoDkE94aoj52vZjOOsw4bDwxE1LfzJ1IeB30CJ5J31mexy8lFtzvGsQzIyNW
         Tp2G9ygrE9dqZ9qaQKkLvuUwIkf+CAA55ssWS7p8jbdsSz/ttTzB6I8W5sG3IZcrcUxi
         I2LSW/P7P58yNoQxLATR0eC9kIUd2e/hMXwI+2/TRGKFMPDBeCwMH4BJ9Qm8dvri68Z3
         7ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591126; x=1793195926;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4zg/LYuc5EVJgXpf2aLA4/NF2gq/+rC0L8/4lGLzGqE=;
        b=Bvt3JYDC7LvcPfU5P7cuwuo3kOWn0yeGrkfpSdLUckAsGsSe7YlPRgowbhj55bOOqz
         hpDGtQg4CjptY8w065SugbopYDWz4Njm1n3cmG8A+nEWoV2cIJIkENy3dGWDr1gSNa/8
         qjlGnYG3IHu/I8uAuCCCxUx8oPaHXOkWl7yQxi/0RheODSxNrvWE8enSg6uD15ks5xj9
         qwDQ8980NlsngIHqzCGJidaN0Umi5dGGn4Oz7b7SwCy4KawWQELb0XFbRGtdphfn/xz2
         uo5YLOCprITXRys6bkOYS0Ypu98HiFuiRct9joYiWkMtDArh13n5+ifIK8o+HIdK+lz5
         cB0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxrIA9/KVrtWdfisNo06kROSwUZT+Zo4QAGgCYrslllD8hojy24taK9xcQdrr0yiUM4F/B5nKY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIszqbqoS73RQK5uL53OW0/5fIYgXhmu9+UQi8s9RD/XOFzr4r
	kQuyhWIdLnCGtGrrf+Y6YD5txiZQhQgzgjX4UwYjjrKAeHxfhLGPJ30L
X-Gm-Gg: AYBFou2Ue8qJrbYrlFa0h970jFwFtKBrVquq3ODwAbQG7lEIRq5bgg0G86SQxwCY0Ud
	OUCv/FWGTlx3ud1BqB1Xv4lMXF4Ks8ZMuc+VX3XI+liKwQoRg+v763bdTtQjs2qr7+Jz/qCCppS
	HMx4PYR/egtOMKcN4TyZWjAhY0cegcIgotXlq6YpRO7EcHh4nZEZt68Ri0kv+5y5ixvHHaxH0MC
	WkXI7Sgf8/yKKtn7CrhpCNzBWBL8rYhan/d+1fxUIgZW6UMw1Z/mU7TkzsePZVvR0v6HqVVVrEN
	kEy0/WDtTpkJBLiO/ZQUYQ/v7W7HykQyyNAfjXkwcyYwc18VIpVSJdXoSfF0kwKbN+gCo/2AhuD
	bm77QOJKOzgVMFvTmOJsxVE1pYTp6gTpwmfvP9xfIFfDz9f3+xXOZSPcjjf8wqhy3zy/VR4qY09
	/V/h2kR3pDfg618U4kUKiPTSgezShQdDKAKInjX5kueutdI+nH3fRPcyc4EBOF3Sw04YmoHTeac
	Q302uDCxjUDqmk84v13xJd8XbD/b/NP/zUYhzezT4fSlFOkaJmw4TI4orIVr2XVDXnmQGjuskMm
	Bf6hozw=
X-Received: by 2002:a17:90b:5249:b0:3ac:e6a:1af5 with SMTP id 98e67ed59e1d1-3ad86de0976mr3286305a91.2.1792591126388;
        Wed, 21 Oct 2026 06:58:46 -0700 (PDT)
Received: from [192.168.31.234] ([183.193.19.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f38df2sm2209811a91.2.2026.10.21.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:58:45 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] pmdomain: core: clear states after freeing them
Date: Wed, 21 Oct 2026 21:58:39 +0800
Message-ID: <179259111932.19580.13027750156272888992@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

genpd_free_data() frees the genpd power states through the ->free_states()
callback, but leaves genpd->states and genpd->state_count pointing at the
freed memory.

Providers that allocate the states themselves hand them over to genpd by
setting ->free_states().  When they fail after genpd has taken over, they
still run their own free helper, as psci_pd_init() and the RISC-V SBI idle
driver do:

    remove_pd:
            pm_genpd_remove(pd);  /* frees states via ->free_states() */
    ...
            dt_idle_pd_free(pd);  /* frees them again */

The second call dereferences the freed states array and frees it again,
causing a use-after-free and a double free.

Clear genpd->states and genpd->state_count once the states have been
freed, so that a later free helper becomes a no-op.

This issue was found by manual code inspection.

Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from PSCI domain driver")
Cc: stable@vger.kernel.org # v5.18+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 drivers/pmdomain/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 052ec478dfcc..12db69f53aee 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2353,8 +2353,11 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
 		ida_free(&genpd_ida, genpd->device_id);
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
-	if (genpd->free_states)
+	if (genpd->free_states) {
 		genpd->free_states(genpd->states, genpd->state_count);
+		genpd->states = NULL;
+		genpd->state_count = 0;
+	}
 	kfree(genpd->gd);
 }
 
-- 
2.54.0.windows.1

