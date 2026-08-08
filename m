Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D7369D6D
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786172017; cv=none; b=iVJohChj+6eGvaPoLMcPw2c/lelp9bdp0XnkiNwdxazcD/AwnyPW286WF93VceNC4mu08/gFXmePKYdxciuVgNxGGp9zDFxs/Ei1lUujFhAcES6udowXkoqiov5sCdT7grHNtEuQn1zy2ruKs5hfwyrddbB/jFSjDEjkFeONpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786172017; c=relaxed/simple;
	bh=Yg5CbE960A1w7vxea9z+UV1mUCRNaxpr/Wq63BHbYNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNnqX+K9eQH+rTx5VUml1qivNqY5D5WwQhNCFaoL/cNZVS51MvrX09sRCMB08y+i8MR634ed+zkUeCBGeiYCV27hvsvajpR1F8oU/kMQJJKvpEcDEChrSNuBYOlEprg/n7XV8lYkpdHj81Jbq0PZH8mGeoQ52WN6+UirzzOLQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJsf9DCe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJsf9DCe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d032846c95so3797405ad.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786172016; x=1786776816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q8+qdfUNsFYx07WswywD1ui9gvhu1XyZ5pnsDk2yr+k=;
        b=nJsf9DCeHKoimLQJ5p5bFdDH5Lq4oxyD6fvJDAT0z0usPuFgF5YGJpTa3HjxV0XF6q
         RFIHQzHsIFmfcShd1zbJInDxWhh4ir2vnkD0S+ZV95iRP4QuFbBVQ6tFkR0Trwf4BqTo
         5Tw8OFpDfL+k+onai+pniP14AOdJyA3R8bE5lBl0/2OGJ8ueLT/c1SxQjaVnXe+vaErN
         vJxTO0IkjZw1eoduZvuycohPigeBBjDHm3jKI+dnWBl9pjInK9Pkny2wZtGrb4c9VI40
         e2LGPff8KO4OhTqrZF1k9lxNX3Wmj+CXTTkxXB7J8UouZaNFF0bjH0jcDOHMx+ZAUkkN
         +ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786172016; x=1786776816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q8+qdfUNsFYx07WswywD1ui9gvhu1XyZ5pnsDk2yr+k=;
        b=nSnwEhbsx0rHCyJFyn3nMDmr83JTEvpBGzxWAizyBTBCZ6rda4qdNOFYdmmxZFYIa0
         cw5hFXKuLd1nNAUcPn3SpZvQFvVUuZKl+uVr8h/DaWu+zREH+q6EoFiEk1McmblabRFR
         jIT07NnsQwh8QKxs6FJYdA8G6zpQ1v69tyhzYWyZPKDeUH4XyIsCo42OlCjgz0kjqS3G
         wsgYlkscMlrwDxWuIVqjTYpNtxKx7r82giofkV7a1OX8Wq0jwUuZWaHCN6UwWV4fn5jN
         breWvM7aTIDlRB/jbyyBQlcCmzTd1fxvT50pH5g0xSGXasoq+irptjZkQAqCFV/uworw
         eaGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpReeOtS9Li75LXNvpoAWMmrQkYOjLCNwQZWllAFquP7V9AWC7rXuETjdpsyfxy8fA+eLpYLk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+J+7QKWhDlU9/DJLkd4rFYoN/QkrktJNL0Gmh7/5qmAnzuwV
	9ThAyzEWijrpy1ts5GDHvnUXItTziunAAtCJrxA8DrSHOLjj7oLz5j5B
X-Gm-Gg: AR+sD11VB7D6OtCr6CH/+18xK9m5MyMyQl486Nzw41sczl86QBN2Zo2P7SeA35MvAJ+
	56VZMpcxYX166POIlMe+pkJ/B5I9Kfmut4slsLDp+Bo+zNzwMb2d5Vg3u3b9ho2wrIEkHjzkyA2
	Y+0KvXsxOlTrtpRbTGq0eWXsYg5xRc3N7lnJUbi9TfwHJNf3U7TLcXNLND1EoP/RdAK+uonmJpg
	ODnw1QB+wErGogIPCKQHg7gdd97Y28LCyU9X8UgJcP001mf4aOZmzX8omCrbCz5878h8DzIMerh
	hESbVnvph9sTfe+1KcT8p9kbs9LL06paM/TUp7YdYvm6xCKGi4OSnnCnTjvpF4dO7KDfycouhnP
	ej7/VqqWw9zhR0+uo5Htj1AU3NyZNawTVLBHeUxH/w09FWqZn0Xhw59K+ZRDLr8A5rrHm4JHSgP
	29+ZxxrJGmlSrWKoatpfDTNLjqhIdS0UbRL1Hc2HoUNw5Ne8vQmfB44A==
X-Received: by 2002:a17:90b:4b84:b0:38e:8021:2ea9 with SMTP id 98e67ed59e1d1-3903c5f6482mr25708102a91.19.1786172015866;
        Fri, 07 Aug 2026 23:53:35 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff6658bsm5116933a91.14.2026.08.07.23.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:53:35 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Hadar Gat <hadar.gat@arm.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwrng: cctrng: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 14:41:45 +0800
Message-ID: <20260808064145.2615010-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cc_trng_pm_init() calls pm_runtime_use_autosuspend(), but
cc_trng_pm_fini() does not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before disabling
runtime PM.

This issue was found by manual code inspection.

Fixes: a583ed310bb6 ("hwrng: cctrng - introduce Arm CryptoCell driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/char/hw_random/cctrng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index a5be9258037f..bed4b9876d09 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -126,6 +126,7 @@ static void cc_trng_pm_fini(struct cctrng_drvdata *drvdata)
 {
 	struct device *dev = &(drvdata->pdev->dev);
 
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 }
 
-- 
2.43.0

