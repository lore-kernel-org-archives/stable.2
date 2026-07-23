Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012AC392C29
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850802; cv=none; b=SJ1s4QHB7OfLcMBEDUzlvBTYUqRo4M4UOvoN5c/IsClBaHTnTZ5CZXDnKByMAFKyxZC3lAkO/Cauoja3x4zc2C7MfBTwRU4OGahBE5vKT82g33A8NIJCNLb8ao8GkwRJXQaDb1Z24LP+OZ5v0d3qfcyyeqmhFIljhElvQ2+AVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850802; c=relaxed/simple;
	bh=GfkLUAQFgWKBMYsEyERI8B3AuH0SGgf6Iuj5LqXQ4xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3z+l8vZj6hDzUqFQ0qe3NciM0BaY8tj9lRsVxtvyWAyTHk90mGCIz/R+mIYwGBtvpnyMSzTXeBG0IhqB/TvCgzEQGu/uYElrQig6j4ddYvFwMFtWH7Ne7QJWijxwPmF03p/8ifijsfQPMZPnBnwzwYzFXj+oa1ZKTC/wTwI/pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQeU5uFY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQeU5uFY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so15595825ad.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784850800; x=1785455600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/k9ClJtyvU02TZ9gpxSr39RbShtvirfOkj9FLRc6064=;
        b=kQeU5uFYmOUNSKGdgk1P0BFHt9DlAMee61wLadctsh1KXllvAtIaqcrNM1CUgp42Df
         vyUuY8T1dD+UV3+sRHoMtqaVWgTMvj89tIxbGSVqb4LXE6Pu2UGmz3tHMEhOXrmfXjeH
         WaS6Yy1oX522njZMPEDToICwnULi3SQ+0cQCCMHCBu0v4S95THakC8RXk+f88J3qwz3e
         xkuN0VRao/VjkT7NKhJ4Z97BU5Af8dx+a+IhhIvECn0Itq/h2TK5qc156M3HXcukIj2Y
         +a4sxyFqaXDjAzDuaWM8x9nWDYJe4CE0CIUbGzphlo4OIkx1jK2LuoBKGXLv+7DDmJz9
         GVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784850800; x=1785455600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/k9ClJtyvU02TZ9gpxSr39RbShtvirfOkj9FLRc6064=;
        b=gJP8scpRiiYj90CpxWAiSukXPbs5iRSjko3SsGBfZsJEskzh689y6OAmviK3xzl/wS
         sZxhuSHeyP0wM4BAm7Pu2KOGzk5t4rb+pN7qVUcQ6sVvTKPXtfumtEt4GOsO4OzimJhd
         4qGdsu8m4cz7s3pWvNG/LsbSg/ebRtd/rlXqPaqQ6JI5T1L05lTop1IPz0/ZDcJWh3g7
         d8hsSAOL98dnK6Hv9oMZvJqiy+599zeVNj7z9vF7ar7TxprgOwIkx8gDIRFtv5VokNci
         bXP4QGtQbR35qx+2xnJtS+XBvMNaiGDyGyXk79UGyK3Fza8lcYc/wsgA81jOdnQFVoGI
         Ed0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrdVRfy8YW+IZyAeo4KER/O3V7Z2hrCtudMuVM+mhkg260eRFL19YbpVET9DMYqFymXlgFX7mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAhsFrOrt8X/o+wbw8xBxGHJqxibiYguTkySP4bCKUT7zfBhX
	jOIH0mck7R5TO2Q38+91oOJ3p7k20EANguN5Lqn9/o701fyiJxq7VJv0
X-Gm-Gg: AR+sD11Gqj8UmYVsmkvbFrJ+HeyMC629Eaj14YhQ6rjLcyGckG+y40uB/kvm8jtWnOD
	Z83fuDWNZ782Bnc3nNfjUOogblxnfsbmd/sYXZpYQfGwA3KV2ib2H1j03BJlcTS0/cKZSRVTvpp
	1u/STzMdkM3ei5noD6RCsTPUXeoPUPFaz/q8AEEFT/b5SF+pZKvUsdPfY97Wm/iU62sv1M/PyYm
	s384LfqlXCcLG2B5skLJZT4zEAyOuI30w2kZFsq7UR4F6Kh56tlzUW06M6ROkHrLJmnmoXyQc3W
	5MwpOtzxVcxfJmxS/vWh0MmT8gTSlda7/0wi6Gy2dL5KHsv8pEfk33IgyXE/acSsjmCbECm1ENO
	m8JR0JNWnOWYioWW/kwS+nIKL2h5+NVbFzPrZX+fFYrBCC0IwbWaLvbVA9hSJ0c20KlvtbQJ8Fz
	22Wcok+W5H7uyH7TkT+Jkm5nCvy+fNN2jTD0ZfJ5q9niBXmfu7nmW4wVXUG4ez3VXa4/xgQI6fF
	w==
X-Received: by 2002:a17:902:e748:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2cfa6a4f988mr63299815ad.1.1784850800151;
        Thu, 23 Jul 2026 16:53:20 -0700 (PDT)
Received: from localhost.localdomain ([119.204.109.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efde5cfsm41417575ad.31.2026.07.23.16.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:53:19 -0700 (PDT)
From: James Kim <james010kim@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	akpm@linux-foundation.org,
	error27@gmail.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	James Kim <james010kim@gmail.com>
Subject: [PATCH v3] rapidio: mport_cdev: fix use-after-free in dma_req_free()
Date: Fri, 24 Jul 2026 08:52:20 +0900
Message-Id: <20260723235220.588424-1-james010kim@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260615070530.371640-1-james010kim@gmail.com>
References: <20260615070530.371640-1-james010kim@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_req_free() acquires buf_mutex through req->map, drops the mapping
reference with kref_put(), and then dereferences req->map again to
unlock the mutex.

If kref_put() drops the last reference, mport_release_mapping() frees
the mapping, and the subsequent mutex_unlock() dereferences a freed
object. This is a use-after-free.

Fix this by caching map and md before kref_put(), clearing req->map
while holding buf_mutex, and using the cached md for mutex unlocking.

The bug is reachable from userspace via the RapidIO mport character
device interface.

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: James Kim <james010kim@gmail.com>

---
Changes since v2:
- Correct the Fixes tag.
- Clear req->map while holding buf_mutex.
- Clarify that the bug is reachable from userspace.
- Update Dan Carpenter's email address and add his Reviewed-by tag.

Changes since v1:
- Rebase on v7.1.
- Add Dan Carpenter to Cc for lifetime and use-after-free review.
- No functional changes.
---
 drivers/rapidio/devices/rio_mport_cdev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 009b3b595bbf..ad82c2108a56 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -564,9 +564,13 @@ static void dma_req_free(struct kref *ref)
 	}
 
 	if (req->map) {
-		mutex_lock(&req->map->md->buf_mutex);
-		kref_put(&req->map->ref, mport_release_mapping);
-		mutex_unlock(&req->map->md->buf_mutex);
+		struct rio_mport_mapping *map = req->map;
+		struct mport_dev *md = map->md;
+
+		mutex_lock(&md->buf_mutex);
+		req->map = NULL;
+		kref_put(&map->ref, mport_release_mapping);
+		mutex_unlock(&md->buf_mutex);
 	}
 
 	kref_put(&priv->dma_ref, mport_release_dma);
-- 
2.25.1

