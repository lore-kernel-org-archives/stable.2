Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85691253340
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459843; cv=none; b=QhHTzzne+d3JsMc2JK7i1GC5ZpSceCrcCNddEWPmGgrH5An7w3LR5frfRmnWRYiCbTLhKOukY0owhih+HDD7+3YFkZpcj/X0fm3XKeHBn9KkMSlj1pYMU+tTFQmlaMo0onnjxP8QvAdK40f8ch7w+NAcHkBnRv8rsHvnqOJPZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459843; c=relaxed/simple;
	bh=5X+oTNgVu4myfa6aPLRLF6sR1pCh4ZJIZc/nWGjGxd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soaeYPD05qRZBLgzXCqeeanqr+q7Xd2TzcCOuRuOSi6kBFukxU1zVR0XqZvf0cavZW2+pssMvx/rA6Ojgpb5WDNvZDyIzHETJhDLgWv2SWYz8EXM1HPWAF0fJgm7vH4nbumuz0nNQvfEMXfDSVgVWyYmQUjkISLyBxWZj9uwwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnJpi/QV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnJpi/QV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so2324894f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459839; x=1787064639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6S5kvIQbyMJPyoByCpJpsW6NwC5WAPggJ7pIz644jto=;
        b=CnJpi/QVsSPYNf1ahl9+0sksiUOaN9mT6y+eDKOL68vt1bJs0HsDO6enCm4Pdah89M
         nH90EAoLA6xbwxolpirh5/ddw0FUo1Ch9EIN7T9S9YkC0Lmvn/rbxhy7PgaJQjFg8W4n
         BMDuerf65KN1Ta/TsMD/PQJINTkYGOEJKmjPDaJTafF+93vG5AX5PtpEmbcnV43k7Q/p
         GLp+3bbRF7ThlIyj7CHjBGAgg/CVICBJLvdObFM46KwpwVsxg+LWB5xEBSFzPEN50dx2
         kkAGM3HwSd05yqwq9F+vWb/fzh2skoUgEuokRcExOktdf1M25+fAjSA7LG/psG0yLEXz
         Jsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459839; x=1787064639;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6S5kvIQbyMJPyoByCpJpsW6NwC5WAPggJ7pIz644jto=;
        b=QaltMUClZNJCKIgZC6SS1h5VU44BplmK/wX/0VXA/CS1pbJvxeVCGtKtxLj89lxWTM
         UmGUqiMxs/Vaj6Avw8XaPE++r0P9Ygr8pN/aFJMQ5+lGpV0NQNLwtVZaYqE9VgKH5qG6
         F8B0zcPzhqWjb7tfpXdsdy1yjJu4gOPEWqxt5VwUVmxhFxEUV1G3YKWr0rAniGVRiSvN
         RILznLL4ooWV1xuGIDvYEyu6x6f0RzPT1AjTCK5jhGT2HTFu33M07Btu/2rLRkAl/e4D
         lRF3TTo3lCy5PS4BVrv8m/d9U8oAswWtJlM0VLW8ZOm+EFfiyrwlMOO8ELXqMHJh6uPr
         99xw==
X-Gm-Message-State: AOJu0YwRV5xa0jwGQfUy2s0FqBAQzmtdkJqxAhFu0KWotBhri0ivn+na
	KgT8MmGWv6E8s8qqRdCGs23oEH5w72McGQmN6o9UKXo3FgxIM9uvlNkFST0BUw==
X-Gm-Gg: AR+sD10S+nCgNNST8eLKdQy4kqAISRR/WuXynkL2rL+YMm2L+An115LxB7OicAn+62Q
	16Tq+yn9jQzse6aYyirKFYZrW25/6sqRSW8+AHHiTW/6nUHKMhJ1q4ZGcPDnxTyJkWK3Yp+oiLZ
	QLv6N1NVfLgdKAB6pzTWdPpnGIlz0RNpeotA7qbxXwrY88BkendCIFmq++7fGFI3p4CkeOH8OUB
	j4SGrWkbG6Ds5b8D19h/4UJT3omQzV5QYJwbERIJZwW2e1lBnfzmBGEslH9iCaW1kncPQS7ho+n
	FMddGax6oh0Ql/oSD/bOyGpgfu8bafCkproe32CmYlu2e/H2YSwiwZVSnHJ2W7O/mdhUarjQpMn
	L50j3vAwUfjW+cg9HN1MtRix7b4LlkmgwQqLHtAPfP5/TFlQHv0ImNltvxS932ZRJ1uWPly+xw9
	HBUR5gryz0TVgVhb8jlHPax/fDtdSNtwPy3gTpXZbxGxwilpGT7nK5SPq8KeapzUQgI+ctJUBCe
	3kkNXrVtk0UMDJH/r5sWvXBVYi/sqEBlXneUHL+9BtDR+q3n7WrsA==
X-Received: by 2002:a05:6000:4009:b0:47f:9486:810b with SMTP id ffacd0b85a97d-4814ad89b16mr7050336f8f.7.1786459839243;
        Tue, 11 Aug 2026 07:50:39 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cea1sm5646271f8f.37.2026.08.11.07.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:50:38 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: megia.oscar@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v5 3/6] Memory leak error in qxl unbind
Date: Tue, 11 Aug 2026 16:49:19 +0200
Message-ID: <20260811144957.69900-4-megia.oscar@gmail.com>
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
index f2693c0c650b..3e6520297fb2 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1235,6 +1235,17 @@ void ttm_pool_fini(struct ttm_pool *pool)
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

