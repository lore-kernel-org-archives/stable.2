Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E9449B0E
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459842; cv=none; b=dQr7oc96JZS95kSBH5mNHlO1aszeYL34YlOW0CRnerPvTX5DNPlCzS2L0/gY9k/Oiq6p4lK0KGJ8wd6Po3lY0IUddcKUnC9P78CoaAXNglWDIFjC8eSTAvHxPCryWLaI9CkyV1GghPHlDhwaQkv8CdEd2tA0dLmKos6QJAmqwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459842; c=relaxed/simple;
	bh=Br6365BjRw8p7qhJWeLlsDlUlVm8j0vMdyrwp7kq19E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smSMbjdm/x7CRgdrGSZaxWsZjBrWrnljSZf4v7zZpKsBO9e/OEm17hgKjIBE7sbclki9udPkmMovsQImjAtP7nKQwGiGDOBNsr5VgGW2jAveYZkY9IM+gYymyiFtwubX1N1g/u2IaXEqXGnsIXpw/YMlMWt97yFgypl9+sRTqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcb8Xx0W; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcb8Xx0W"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47de008b020so669892f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459838; x=1787064638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SnBy7c5mGqlDzx/PMF29gaY6i+fkREiEKAP5NZbtuS8=;
        b=hcb8Xx0WbNrU2MNxppwtjWGJShFNnAVHmL88BdpoZEz7wgFLH/pTuiCkiHc05DDsjM
         0h2uyQtW2PCJW4LiMAMK15TtlMdmviP8hwW5Qc7nYDjtV65ZiOwte00ZR8D5gFZxrlaz
         MUfywh3Is5Y6MGR2v+3eVI8XuzSJ/uXy2MYecjAo8eerrpAbFFED+ixzaF3OUBjuRP1R
         u54XQUsQLj0Ec/e71WIGKlZ5Mr6GEpHDzaEzASFZvr9vJ6ZKaHnK72XCm0RD83SOwJHO
         gCukCHiWwDTRY23mn3nSAEyrIvvMwjptNPJRB0BVDmaYaj8hEag+wjzGqeFgQ2Tgyi1I
         YQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459838; x=1787064638;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SnBy7c5mGqlDzx/PMF29gaY6i+fkREiEKAP5NZbtuS8=;
        b=p0xCQdLd1AVL1A4cDgiu9D71eZrQenD/qv01e9IHpr0ARnRpVUdqPdBX/MDjHnp6fi
         L1g931HBFpWwv39ZUy2e0lFnh7nST7vlzJmSKa55hQIzAKm+Npy9boly8wIEqxBH8Rgt
         /SP/P0JkHgMaTwbH9JR+1b7pBrpq/EJVfNSSHnjlsg43gUJcpvMSg0JDKdprRYpagsSM
         jHIbkz925R3X+BcKXWcs4Xx9/+27opbUD2+8Boi3f2EHbbogpiH0JE86KUDhvUsHdLZc
         Ueo0v7+b+71C4LT9uRAH4cRJ48TcJK87iYwcCY6b5vGvVjBu10KdL1jNMzj0ffEOhmR4
         kDdA==
X-Gm-Message-State: AOJu0YxJiUz9dPE1w65JwI7aJjysVp9lFYlP5Q0yGp4kx3L1K4MJ8TdN
	8MwsaNaZSGGH/5ulTm7yRNlC76AWalrOR3MeZDTm5JyXDEYcVBimT65rdDi7jg==
X-Gm-Gg: AR+sD12e9VnVAS15JI06rGUsJvcX7NSF7PTSy6HydjwW3y+UGGlQO7BoJjIgTezQT20
	ezZ37d4nchSDo5A+0mWyWTKqSKrPzvHUfgrV1qNgk2l8o/zgkkWUc/KWXUMF12dOxST2Qo6Q/3q
	Qol46cO1dzJ9s/KJHGuaMchX6MyXbzpeyc8013RC9HNO9aa5zRnyVTXNC1BjA/JTsGB9Fkd9gvT
	lIJCgs5aeUzW72QJOOaez6GsvM0w+s5pmye8ogJ8K4tUkJWyHYipp88NpgWpCs4+AjUlEhGMkhq
	Kua5KvMgIcFMZEK+cQ0hXVcsHwE0IsIp5UpwCynwcRh6TywK1+Q7sim6qqK4R5ejKm60qvtqG45
	xKvMhx6hXAajoT6rfWSNosRZK+8iVMv2G75eRx3FrCjMAeQZWcLKdSjxH3okF7muoSqH7cFWBPY
	N2giPIThHqokkpzTAsbznLYPVaIfqG1awSdVzKZzYvEDi4XxW8IpT0HxrG3MN/4oBsc6LJZyqpT
	84clAF+6hmWD0aSI7hmnOtw+zhNMg0AvbvBXKW52UR/yn9UhIGN
X-Received: by 2002:a05:6000:270c:b0:47f:90f1:68c8 with SMTP id ffacd0b85a97d-4814febb155mr851929f8f.1.1786459838257;
        Tue, 11 Aug 2026 07:50:38 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cea1sm5646271f8f.37.2026.08.11.07.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:50:37 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: megia.oscar@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v5 2/6] Memory leak error in qxl unbind
Date: Tue, 11 Aug 2026 16:49:18 +0200
Message-ID: <20260811144957.69900-3-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811144957.69900-1-megia.oscar@gmail.com>
References: <20260811144957.69900-1-megia.oscar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bug: ttm_pool_type_init() does not check return from list_lru_init().

Fix: Check the return value from list_lru_init() and propagate the error.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com
---
 drivers/gpu/drm/ttm/ttm_pool.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 3d6f024a815f..f2693c0c650b 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -354,17 +354,23 @@ static struct page *ttm_pool_type_take(struct ttm_pool_type *pt, int nid)
 }
 
 /* Initialize and add a pool type to the global shrinker list */
-static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
+static int ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
 			       enum ttm_caching caching, unsigned int order)
 {
+	int ret = 0;
+
 	pt->pool = pool;
 	pt->caching = caching;
 	pt->order = order;
-	list_lru_init(&pt->pages);
+	ret = list_lru_init(&pt->pages);
+	if (ret)
+		return ret;
 
 	spin_lock(&shrinker_lock);
 	list_add_tail(&pt->shrinker_list, &shrinker_list);
 	spin_unlock(&shrinker_lock);
+
+	return 0;
 }
 
 static enum lru_status pool_move_to_dispose_list(struct list_head *item,
-- 
2.55.0

