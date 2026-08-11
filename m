Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0647F769
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477368; cv=none; b=ZVdpeGihf0FT9Cohjj+hupMRUBEGhKDHQ+j10m9gWqrKMh+Twn18OPuL7YI2GlpnpsQH1vB++9UNUUEyRwGGMqHFkYFeDDDUzU658e+PnWAf6Ao757fblvbI5qtQj0BgUH8nx/xFBePAKjM8EFjrH8C7yXlw/X4LEPSHaEyzt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477368; c=relaxed/simple;
	bh=ddu9DCVg5CNBBxYAZ7C2IjQ6tIBqi+R18l9PMT0/plU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+pd2icUDTpKMhi2+JLdt5nP77F5oTVOAXbq1W07/jLJvAd5xVZvGvbz2HnxjrtjHj8FpoAft0C2u38+D+dI0mGl88aSqK1UBhGT1MgRT6lDkvik9Iy9MTE51yLTIQfyk+UkMSPX8JL5LlBS1Utvx3xKEhyu9aP2jXymP828lkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlSFve13; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlSFve13"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954df200ddso1198875e9.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477365; x=1787082165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BuMfkemM9Oz2WhvZaC2ZnN/4G8tTmAb8WWo8t6gaQkk=;
        b=BlSFve13Gb9f+zra3PMJQEo3FBkG/BjUHf4SiSWqf9K0jNsdph37XeV4aa6j1F8lkT
         8gOqAyjsVrUiGke821I+GY/PEx15MkY6vNLvvjMFU3Rx5IMVH5wXNjeUFuihKiUGRNok
         e0ivNuJ9KLQSDuqljEFVA7HZjvWgEgty9cWlojShwbvG3anOSHfXj9u96qvEzHcp1M8p
         P4oBCFH7pPvcR8k0FlEMdLGLxNPc5aDnhuGpMrrzy7Z4bqpg3aox/NOIbg/s/SMawUSr
         cz+aKcDygUHU6LK6eKBzEGgDxHLsOTXzDSrswd6AD5wCkgeeteuj1ysC348FDPhjzL5d
         hTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477365; x=1787082165;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BuMfkemM9Oz2WhvZaC2ZnN/4G8tTmAb8WWo8t6gaQkk=;
        b=QFQudvIiqHstsWs/M/3yby30S/2RKcOl3fqRWkeWKC7f5XOnGY8Kc8cxwSmDxHaVv5
         oSlIxj9ZRAjuadpJeIAorjbWB5Cm6xL7oH8LkCH6k6GxsqpJArx8iOHG/jEHdMKLsYXu
         a3Ivl9rfwIO1WGZH9rerH9j7AdWh4ZEWOwyBvk066fojnkK208zQYxFFEZYOb/1gj7mW
         8tqfMXTX3C0eCrMgLyG2p9YJMfMTZyLIXxIHh54LtOFu+LrBJRYhndPC2mXm+vxhh0KR
         ra2KM84GnGbqTsZ4c05ZAfanSc6MItbdBrBC+/jZ+K+Ys1sGt/LEPuoo6S7arBtlexvb
         KVnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqrw07NSH4RfslCrk1o423v1oN61Jth/cExLgliZ55fA9jT9WYotrSIveApOornsnnvr1pmwE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtugPnemFoSuGjHYh4mAIb+tV4nYtxQ+6lB6jXsqKQinuPzIMX
	rxeRPabV1+2MV4VL+P1mLR6i6Lxg3JF8cBkrttQY8W0HIqxkKcFZEA42
X-Gm-Gg: AR+sD10imKOifg88d2F0igg+lhqEqyJ7/jEWmJjiTM2yMeF5kkKAJN4sGR9yJqGJ0rg
	3uYwtP8rURD4uDpRLR+0yagNQzvdB/SDrfB1opIAXjGfXq5NotQKHuXDgGlB7YYqY9RJDrCDGGW
	fo3OtBJNYWhhy3aWLzmDMtYvmR4Z7us0AUsuMCzD8rWCJUgICtFcRjAszAy4fyqvm6vbbGf9txN
	91OuyrkRgIrxPR73A8Am6rG/dz53Q+ZOawPRM4X4jHPoMn8Zy1JgfdHqGZOJ1nAeb3G/eJ6FJSR
	xpiE5yKDeVtF0nKVYQVjxFdOuSV+jiK2VrD/kQV6GMIpJj6jR1BvIrB789U3RTqYmw5ak6kf/BJ
	aXTzOra3f9fhgCJLpCmxfWxlsmhmLvdDXPRSSzBJJmch7ELxzwhIz0+5g1Tyfu1mVbozd7mUAFq
	cT9gZm1EnR3h2F59b14GjqFrcje2moQXjXesw3n+9EFZNWTG1SFjwAjayHWwFGTy4jOtkIqOD8g
	TKSG8HJqz2LV7in+VDZX/NsdXn6+MgvMpdiXtUwTkmNZh3MfsTq
X-Received: by 2002:a05:600c:c4ab:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4997842c213mr78119195e9.2.1786477364935;
        Tue, 11 Aug 2026 12:42:44 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:44 -0700 (PDT)
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
Subject: [PATCH v5 6/6] ttm_pool_mgr_init() does not check return value
Date: Tue, 11 Aug 2026 21:42:21 +0200
Message-ID: <20260811194224.121597-7-megia.oscar@gmail.com>
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

Bug: ttm_pool_mgr_init() does not check return value in
ttm_global_init().

Fix: Check the return value from ttm_pool_mgr_init() and propagate
the error.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d3bfb9a696a7..896b766712d0 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -96,7 +96,9 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
 
-	ttm_pool_mgr_init(num_pages);
+	ret = ttm_pool_mgr_init(num_pages);
+	if (ret)
+		goto out;
 	ttm_tt_mgr_init(num_pages, num_dma32);
 
 	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32 |
-- 
2.55.0

