Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B2476CF1
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477367; cv=none; b=Ky5xYHyXZn1SDei3fHQeTeVdKt10Bez7j4X1MhsL1XXqYoMD60Q3XTykSiAJbClC7W4gEdIg4d9lAUtjuPcDKqiKwPV30Ax9p+02HA8VO4G74hrjw0A2hPxcvTfZbCb2LVD+Z/90VeJl5Y8uyM8qGqhxNrSltj/5AfaV1e8PmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477367; c=relaxed/simple;
	bh=l4VG0FqV/vJrXP9/bYAlLrRX5IxIiYLLx7pkgrMFnTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqyFFd5ECTuHJwiG9ebZF7SvHohh+cuyAG7C1dA/Z50RU6NGF8BK/kOI64BmR81YvVYwzFfjzh5TQW6TG9pXeiVJMjlWynujl4KJ7KZe/PNAGS/bOf21ds+AZP9F/J0kU3SeI8Z9VAiWkAgOEnj/XwzI0GxdBRpbH8gXxSLoeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLwLP5IJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLwLP5IJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495635a85d2so682155e9.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477364; x=1787082164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8qrj8CmLGjwQMZeVA2ZOifuwHu1xiIsioWlV9Mw2Jg=;
        b=XLwLP5IJlXW7enAxfH6H2OmXyX7rk3ZQj3CiyxKMYS7z1WWLBhQt9eDirC8qfKUZpP
         U8KuBalr42WAXUNqtS3AxSbcvJAMZtL1RMYxk2cnks8Cl5XWYKk6of/PrDLMZiOZNhjw
         TWkBMbJRKBE+L8fFpy3x5ONYNtwDGcqgvgiNODsItFY/6rGoFzCIswTd/SCPCxFuIPrv
         uRrB1tAk3D9fr3XzNeMzBXu4DQrtTQyjBQ7BuHkpFpdv/uVXGDX+GVxC5hEADy7eNn0P
         KbnaJw27xYLGNN1fQA8NpgXUe8YBQGM5nTeRXHRsNaCJzCag0eWWuS8VlB4bBjZMH8MF
         xLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477364; x=1787082164;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8qrj8CmLGjwQMZeVA2ZOifuwHu1xiIsioWlV9Mw2Jg=;
        b=GbMmNrDr/IZNgH9wUyh7pPT18bkn9kPjcNxMmqa5ozMCG/tMTsLtXcND0foa2joVrw
         mbj+FyOVkMseE0wI63cXLCWB1//Zlqj6fZZMr0areCh33Kiu2TFCuvAqOW9RV85FW9+x
         UPH82mxM6gINSSxAVDmZV5mTb8ln82su1brWnwGETPM6n6AaU9fIzl/Va8edZLPBL9xq
         uDitcvOchDZ9BRikfDl7W8mC0zG1aoTYAI9mZFt7+dkoOfLpO/cjW1XNZwJ9YRuDiVyP
         u3yHikRFnSYRlfyAceDgY5LobkaKDxy4mOiB2nPd9oEcceQEJ/Asy65aAGw1+TLLIL+x
         Y72g==
X-Forwarded-Encrypted: i=1; AHgh+RpygIwvFSt4LlBDoitBdXFWMZLUd/bNkN42CQCJ+2YeRVtb/AHvDLZ9zl1RGHJeZl+i87re748=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+un4waeRfmbYvLiNOhc9/CkzBHkd5hiCxTYMv1gf+I9PYfn5y
	l6K90bFHIUyPA75D6usK/gpL9zFtQfGCmR/d+3VwVB0Tv9KcBA2vhqWy
X-Gm-Gg: AR+sD10SXlfvZTRZixJ4ZDi6V0/Pg8ODIEAUUXvboKREr5OE2lz9VLnYVY6KNzte7il
	7wDpKVCHrtnvT1QCQNJ+wkbRAhJTjsplSz8IWq6t0A3dFXhQbCRjuZQc+bwYGkh088fagbOaDgV
	YnnEzHU3kSKsEGR+nkBlvzIxlKLRbPh1JIbdLK9/q9pYiPYOkCtABzoB7Ge6VzzwuiqhKLl45qq
	eCwE1o+9Xv0il8BLg5EX0DYhY2be+Lz9CU95ilg0EmRtWIdVbSX5sY+4Bn+TGvWqSnHdxSECFiI
	K1ghiAMsbn1VE5o7C/fY7MZUEqCpQDJiP1TAw0PfS4A8M6DuoWHRsJoXpRrysKCIui9FeYsfPna
	fnukUXF/LVqrdQcO2hM9FlDwyZ6gx1oJWAkKPHaScmZ2qKK914kI34ihd2nNwUe5gq2yTq53NHN
	UOOioCQytUzEzuJ1zUz59w3ycAtNszxcfTNEi428aNnkRmGuxwqePxdotlLYcfDmfz5XN4OTAZb
	ELnBbmVskr/TRAZDHDv4UNElkQUn+6mas5D2DqWHv7nonYOR/wb
X-Received: by 2002:a05:600c:1d0b:b0:499:51b8:d649 with SMTP id 5b1f17b1804b1-4997a5f2427mr38053465e9.3.1786477363864;
        Tue, 11 Aug 2026 12:42:43 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:43 -0700 (PDT)
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
Subject: [PATCH v5 5/6] ttm_pool_mgr_fini() does not destroy the list_lru
Date: Tue, 11 Aug 2026 21:42:20 +0200
Message-ID: <20260811194224.121597-6-megia.oscar@gmail.com>
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

Bug: ttm_pool_mgr_fini() does not destroy the list_lru.

Fix: Add list_lru_destroy() after ttm_pool_type_fini().

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 74d8770f41d8..876b6d3a632d 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1572,16 +1572,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
  */
 void ttm_pool_mgr_fini(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
-		ttm_pool_type_fini(&global_write_combined[i]);
-		ttm_pool_type_fini(&global_uncached[i]);
-
-		ttm_pool_type_fini(&global_dma32_write_combined[i]);
-		ttm_pool_type_fini(&global_dma32_uncached[i]);
-	}
-
 	shrinker_free(mm_shrinker);
+	ttm_pool_type_fini_and_list_lru_destroy(NR_PAGE_ORDERS);
 	WARN_ON(!list_empty(&shrinker_list));
 }
-- 
2.55.0

