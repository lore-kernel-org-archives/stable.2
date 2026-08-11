Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19ED47986E
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477365; cv=none; b=AVfpOL429idssu4Sphc1/awInHUJ5vFbfXYePt7mb4PkJ2Tn81n6tKqXxsE0p89/K31YbG9p8PuPssCKt9ewQqSx5Y1Y7gZYvvH4SAbN78WR9nfQvnqq//WFMuofb2SyjjiRQE9JSGvokj43SPiPKKFGZA5/LPhEk16VXULvqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477365; c=relaxed/simple;
	bh=JqKxq/IOJGoEcnOQcFWHghdDL43RcY0jUPwMdDnrmpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLppb245ptGAD/66VPpJhjCEpwyg6ufIXIPhYO60bzKk7h1N9t2gjGlz+WzAeP4Sy0gXct0z7/QQJEVfLWM7thSL9P3NmrvKzGAeAqRfCOFQmTQmlVY+wli9ySi2hEjhWbZBV4XZxTSwfiK1NokltMoTpM7OKpJTVmw4gvJ0cqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scDbh4T5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scDbh4T5"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so1325705e9.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477362; x=1787082162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4v0iZboq/uLDu8mV5Gkz82xHeLB+QGVZ8axU862tksE=;
        b=scDbh4T5G/QwAqtllmYTLjlzOW2uSJ2TlsFx9AyxHOM6ubfyyAyHdfcaaXirIYtm69
         0Fhr0ws4xAqi1aYViuYEd4z9nZOW9EGPKmljE8rm5z1LIVietEK4H+zBptwAH1/0pEIQ
         gi5PkZJEZ8lftKx2ciaDQcTOqvzGneGr9AHLilk0+t1V86zaeoSLbBl71lb76+jdZvbE
         emfxuXzR07cqhgX74E9v2JW+nJHjpl78fvReZFikqINnihKdfd5xkp/O5v+VU5KAI4gL
         W1wdOu5b3WAjX2d96wkg6tQ7VlSjquCvT9pBGGDdaVzPcFm3gSdNSRL7Fgoi1WtF7aId
         SFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477362; x=1787082162;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4v0iZboq/uLDu8mV5Gkz82xHeLB+QGVZ8axU862tksE=;
        b=RyJXqsz/nofajH1rJBzgEO65Q5fPFnmzh1vfvYDJn+vSC8JlLuYrflXIuqOexlQdgE
         LZmpwAgHpD7MWkag8p5WkgEKejgbyx2iTN0oIPur+PjJIMYyLImkuzSBjsyiBo0s9exm
         wOitDbknp/fLkJ66f517gbIQvHefgRTGE0AOlhfW+8nH78+5U4oLaxBsZ7Ah4VqF/Cru
         mW96q6Es1q3ssMyWInbYApO2Yr9MbEcgt9Gbf82Lv0uetCQ7zVeOc3xuHD4wUfTojJ9r
         SCrSavoRWONTq8IjNnH8iH4CmRzzFlUjYr6oBM+QmOGyXHPfx14YD7bIIYAeA5x2rLe9
         3NIA==
X-Forwarded-Encrypted: i=1; AHgh+RpQ93s39GNf5Den/rtsmKP4vBYmYp7KKVlWiS9m+g97yEjkPvej08loG4/lumWhP4pww+nGAHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6felmX5TnYyV2LeFET1mtXgCqZdtP0VOpttI7cuevcbILXTT7
	RC057BXpPMxylk+5d4dNPvC/1NhdOJxw65zGKAlcqq6KkfFgdvoDXIlRemSZtnWx
X-Gm-Gg: AR+sD10tXKJPWB5NWxIVnqZbgThhl9I9Bn0Z4QVZSBUjaqJDdVjvAT7ts+auxqRkVgN
	R7VCknpDfY92FHFhk8WGf2Xx24RVrKhJhUFWx9t/D8MNLdCHwpu9MLbEDfO9gmj3oaLPEq3Wgqd
	pQd9Pd4QB00dTOvjKmbt3jbDwwvfyzW9qYP/4whB+SCV9c0nNbyTrRY+uSciyXfeEQzUzj5/fbR
	pE1CZ8gMbWvCUt+8ey7rnHBy4KYQCCShQgo2+pNVZBj8AMEPJJSdVVw3w+HPpueLFrK9p8jYA8V
	FyQvvW+WPq5u7PAnUobtzp/yHnZTvc65VqcfWPpXYTStbTjT+yp7ouU5vxqW7IVOHBRGURc8hNH
	/s4R3C2GjvFbrV7CZHcTy0NVYujzD4+GCK7Ly+h3GB/OZkQnCAy9b9GC2YrE5LM3OK0C5YhoHM+
	I8MZpptL1ZAmZc5Ir3krAr/glE9VlH5KYvLvfnSsbRsxbwzu/OADYrpbddv7py4seLDFnOfuNAn
	REOqzFiTOQHgpJKj9OeqbfdnVqkRbMldr5ngsTE2LVN9VOSsY/K
X-Received: by 2002:a05:600c:34d3:b0:499:6eac:36d2 with SMTP id 5b1f17b1804b1-4997846d9c5mr93834455e9.17.1786477361645;
        Tue, 11 Aug 2026 12:42:41 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:41 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v5 3/6] ttm_pool_fini() does not destroy list lru
Date: Tue, 11 Aug 2026 21:42:18 +0200
Message-ID: <20260811194224.121597-4-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811194224.121597-1-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bug: ttm_pool_fini() does not destroy list lru with list_lru_destroy().

Fix: Add list_lru_destroy() after ttm_pool_type_fini().

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 8637f7942347..87c843f52736 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1232,6 +1232,17 @@ void ttm_pool_fini(struct ttm_pool *pool)
 	 * that no shrinker is concurrently freeing pages from the pool.
 	 */
 	ttm_pool_synchronize_shrinkers();
+
+	for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
+		for (j = 0; j < NR_PAGE_ORDERS; ++j) {
+			struct ttm_pool_type *pt;
+
+			pt = ttm_pool_select_type(pool, i, j);
+			if (pt != &pool->caching[i].orders[j])
+				continue;
+			list_lru_destroy(&pt->pages);
+		}
+	}
 }
 EXPORT_SYMBOL(ttm_pool_fini);
 
-- 
2.55.0

