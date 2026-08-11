Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622DE47DD66
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477364; cv=none; b=rVO7/MOT1OvkrtAgeMicUIefZnUAHhctZV8VuoSjxcCwcYJcvpcPaLs83S7YuWEpqrHLzDtbkHwIK9k89u84xbrIPkmw1m9bgTt7bgWbEZ/0qe6x/meDqeyrSH8VjGIUmMp7onjzW0l7Ab4OwresZxwZdkCtgSCrcG9ARkV57Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477364; c=relaxed/simple;
	bh=0MSVQNAfX1H3iU3xjsiD/tQTHV1nkB6xpxwoTTdwURs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2f8FQVH/SKWrXW9bBsytNUBrlyrD/dmty4ZSKjm/0MRNhxLox2F+2M/szz6CLWKnz2YvjHylsj7hNn8Zf1NcekQjU8m2OPP9bCi5jGlO0a0nFvt93OmJ6e4ltuR5eLTG+HLizVyWl5Sy42XGAGbuB8saIfCoEeve+uw3XHcyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpv1ZjD0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpv1ZjD0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so734905e9.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477361; x=1787082161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=maGvDaUsV8Puzc/vzM2VfATUwgjtE+oqcHZemKrSRow=;
        b=Wpv1ZjD0PEaB6UzCTwI9FgPHMo5nOjXQhXQJbXm5GL+tIjVf2TRJUlLtkFAwRA7373
         qabMYMlX/g5Qc4dfrkT4R20HUPy6clBLtycSfTWC17GELlVWr4NgTFKoPctZmpEbQhat
         99lPnJKn1EM3R/5QwcPa0Dh13HBKpsoWLfY38L3f81mHImdSNEOCFcIYdQA3a1YgEYCF
         K74S6Ft9LrBeh3GmbEUJB/s1NwwnVlPluqn9uKVxYLKsbNCgVsIhU6SiiGgrsztZ49mV
         wykBjJUGDJCOTlfq63RXdzEruL7K/5pUqMgpk+GZgQ0u1yv4NyqY4YtSIamyH6yRNJAs
         Obxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477361; x=1787082161;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=maGvDaUsV8Puzc/vzM2VfATUwgjtE+oqcHZemKrSRow=;
        b=tAMSPRR1DtvN3eNE/+6boapjLxjMhRMIeoMXcVglhtZiLOBjxj4OneRadEZpm2U+b1
         esMn3CdUCbK6Ym1ddAS12FSucZkd5SUyodBt5JcbFp/zOVsvZ+izQ/AM6WbWgTPTliOk
         e0ATBmPz94XnqdiO80CRes6PdlZ9tyPa2KAXi6spcwvTw3cNtdRgtsv1SaayTGPYQuVX
         B5/+BYjeipgE9IkXeykG4SYQWuODuJFAaS3SSLoQFlz1DeyOuHl+O4Tky9RNVnEoUNu5
         2kPhjYDyVJ4UM007QCGWkVkYDNLRcNPgvYhFyXOHY7FTbcF5TUd4Gw1IKoMn/CRuojKo
         7Cbw==
X-Forwarded-Encrypted: i=1; AHgh+RqF0k2JNzLQ//YW6AR6AFEw7plkx3RlheMNg5FijWCWGLTPVnnTj1czfoJNbdzWjW1zgRvh4qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTnpLP6/MNbJSyKYgpEB17tp5KSwhZHfvHIqzn9OzsbEFfnDB/
	bRMH60aKZFABVZfb3FJbO8lBwC0S6TGv/isNL7gEzyMiJOQw5O3LyWiO
X-Gm-Gg: AR+sD12kT1jhrA8sVFDiW3K3CmoZZ9MSF7x5IHDrc7sY+ZZARuJTgPJItPSvPtnEb7f
	POUI8WMtudNT4rRWwqSkVubPTMVrmT4UHbC2EANy2EwlkOHHO6T0u1O/Vz3qOT5LF8fBYcXjGkh
	kZ840cRdh2MUy/DvKJBxFqTc7ZCujtZbOLlpULdWqnmWI4/v9PIFVOKfPgIN8tm8y5wghaEzLyp
	dg1rV6m2BbiOgpo12KCmNJu94GyqtAN8Dini1vNYNJRLaq+vH1pEQlFT+EIHHSifrWfQJ1geT2I
	xzT4nVn2HCcd1msSV4UHHNkrrOh9NbkvWX8JXbmqbAw9pyxnNQ1w8cgrAMt5p3REUhyBlR9ccdE
	0Pvbpe/MXT+OLBM+BN7r6pq32NEVtY4m/G9dvzPgdYO4Aks5xmTOE8rvFo28iKFvA0TprOiR74I
	w6mnwGy1kgoLZ9Cj1UVORDBnTCEbWDXZcnXnbvfOMv8eUb18xsFVAgEGaUa0GzW90VmPKJJaHSR
	25CADq2nPMybZmaMmzB3RyTI3yAxt9vox54HLH5Br7QAPPiXaXA
X-Received: by 2002:a05:600c:1d0c:b0:495:6bc9:62b0 with SMTP id 5b1f17b1804b1-499784611c4mr86084415e9.17.1786477360587;
        Tue, 11 Aug 2026 12:42:40 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:40 -0700 (PDT)
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
Subject: [PATCH v5 2/6] list_lru_init() does not check return value
Date: Tue, 11 Aug 2026 21:42:17 +0200
Message-ID: <20260811194224.121597-3-megia.oscar@gmail.com>
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

Bug: list_lru_init() does not check return value in
ttm_pool_type_init().

Fix: Check the return value from list_lru_init() and propagate the error.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 88c0d33eed1a..8637f7942347 100644
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

