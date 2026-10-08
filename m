Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880683CA491
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486522; cv=none; b=C1mnW7xxixncyIXeLy6RxaiBZ0N+41BDFsvBv+lYTM2oUmUo3r8VwHA6WVegzYS8HJB0t4p9kuDGVd4tFN5BLmQ8nyvLe3xnlAtH3jM7qaci4Kj6me9qTgrrMFPC0i2sqCQOxGufzMzVx2eWJi/U2Tydg2SSZwpzuXFnjvHcNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486522; c=relaxed/simple;
	bh=5M6ONwAYQGGzjhALLBWWeXFdEJuST9MXsZw5Ht6qjWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnNexyUQNBb7qFQKMh1wlOv48CZIgu65Jmc64l+nLf4Zxg//4FkFXZaNo2XQtn83mHOYudBSIKsH9ukyEIr4heN/GOOXQl5RMu4W3ynSBHeSwsol8pJd56y56iYoYrUyR59F1ZxbEEPIzM8ca0JWxFLBhZrZL7stdmKafLxN5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=hLKDlfTT; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="hLKDlfTT"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33e6279a1d7so3232638eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486517; x=1792091317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=89nlx+M34LzIrZosb2dO9gI0RPZyt6hlktU5w00KTX8=;
        b=hLKDlfTTi8wSyzkszQkhy2B98cejuxB/NAGIeUBAThAT3UEZVroGVC1lMXlwlMBuyN
         +K20O9JUrNlHbXdCEQrTRp2NBej7iTL/AduRzVGmCtH/YYjL7MAhxTDLRArgWV7+IS5R
         S+GpC3qlRVURDR5EMZj6xF18VnIiXGjalS/nepMXgpK4oJaURRxtjmT8Wb3vVmuf4Snv
         nVgrg0wZ9ihY1xT870eGQvJcxMhSo8EyCnNWkT/C8aoLxbFZMWXaIVKEeyZGYOjgi6ow
         ziEGGS9zBO65BUU9eQhfcQxVZf31ST0bfcpADR0ljcOlwkhoYu/9Km+RxRJdsCAm5LFx
         AfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486517; x=1792091317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=89nlx+M34LzIrZosb2dO9gI0RPZyt6hlktU5w00KTX8=;
        b=UnS9VccRnX9o6aWc/hTKFEN8uive785ONNoiXpWTQWrvP9cASDwQnt/3pPS7f6RMD1
         LQcFESuKn4o7bj9IlOLfxFY75vDGzhk534MBFJSOtZOxXqFaffsw/cdsexewCD9st7+1
         NTFfiSEv1pp6stU/kxnGG2gyCGQ8FXshjpiERg8sYmPeLD4iZbQ0JJCDy9KAHUhOemCU
         k8swwKaJ3jHFkr+hEb/csyd18fS9PW4BUf46Mjr/Kvv87O9bCU+etv++TGbvhmfsYB0l
         VJEfahjNf0EJunKNKPQRCmYbywGDVpQY1YNj1whG3hMxRhm7vgobltzcEk2VpwVK9zRQ
         Uevw==
X-Gm-Message-State: AFq9FYJMShP5h+YKwgWrWZC5C4jfmFmqGbyZC2/zIMdnNyQ9eCbdDaHN
	D2oQ0XLM9eWPGM1BnaKWyIggN0pnBV8CsfyXOMHrde/mf/FwYGfpZvUfC7wAeWIAmZ7eW3PmM9W
	6Xm2ncZCRjQ==
X-Gm-Gg: AYBFou1aAz1LZCD3nT3sUEIz13hMxu/Ixz/GtQ+tDkAbIecwk7GblsAEkkqmGjnf35/
	rClBoI3tXgT8RQtKDL/m30IYpciV/oHTUOnuIine1qWQnOB7EpP06WThTqRm6u6s/hmsytnegk5
	+VaD9yr4WY8rbSsjCGzzUlbXMHAQ2d7KxuV8poMOHDe7ueRqaLO7pWNFe/ZECMl3AgeBCvLVmPk
	sckxarZxvdeAQ54gGYavH6OLuR/XE1Ys1Tb5vjtDgmLtysh9+NsbIZ3SDfJxtRSQ0i2zk3im3P1
	rB6TD4NrZyi1OqOfzUCqDA3YvRrgXM6vFzWy08o0O6hXInR1bVaOCTW4Eg8HIW6g9L594VnFY8f
	wEf9gJaOQ7IlyQYF7Vu/+cS6S0wvjA42bTcJBFo1aakYHuzuthNVj86NSqInzAIL4T/Sh9hk6M1
	J//cGfOEwjv7yKW+LdRmTCyKxejk+a0Ka4/2Li2n3MGKXJ7lPvgb/gKRknvFAmAe/mro9yjTHDb
	nTWo/d5J2Aa+HSCdIcXxmYnyEd2QqKobNpHhPZkAdW2bVGRv9ayt5sSKtFlY4tR/e2h39s=
X-Received: by 2002:a05:693c:88d1:10b0:351:f762:a10c with SMTP id 5a478bee46e88-351f762a25bmr2478155eec.0.1791486516485;
        Thu, 08 Oct 2026 12:08:36 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm80561eec.3.2026.10.08.12.08.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:08:36 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH 6.6.y 2/2] erofs: unify lcn as u64 for 32-bit platforms
Date: Thu,  8 Oct 2026 15:08:28 -0400
Message-ID: <20261008190830.97970-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008190830.97970-1-artem@trailofbits.com>
References: <20261008190830.97970-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 2d8c7edcb661812249469f4a5b62e9339118846f ]

As sashiko reported [1], `lcn` was typed as `unsigned long` (or
`unsigned int` sometimes), which is only 32 bits wide on 32-bit
platforms, which causes `(lcn << lclusterbits)` to be truncated
at 4 GiB.

In order to consolidate the logic, just use `u64` consistently
around the codebase.

[1] https://sashiko.dev/r/20260420034612.1899973-1-hsiangkao%40linux.alibaba.com

[ Backport to 6.6.y: rebase after the CVE-2025-68251 compact-index
  validation change. Widen its new lcn diagnostic along with the
  recorder, full and compact loader data flow, lookback and compressed-
  length locals to u64. ]

Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 2 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2026-53015. The EROFS zmap implementation and the
preceding compact-index validation fix otherwise retain 32-bit lcn values
in shifts on 32-bit systems; widening the complete data flow and the
validation diagnostic to u64 prevents 4-GiB truncation without weakening
the new loop check.
This needed a target-specific adjustment; I called it out in the bracketed
backport note above.

The fix is absent from the pinned 6.6.y branch and queue and must follow
CVE-2025-68251 in this series.

 fs/erofs/zmap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e53d5239f04d..990322b228cb 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -12,7 +12,7 @@ struct z_erofs_maprecorder {
 	struct erofs_map_blocks *map;
 	void *kaddr;
 
-	unsigned long lcn;
+	u64 lcn;
 	/* compression extent information gathered */
 	u8  type, headtype;
 	u16 clusterofs;
@@ -22,8 +22,7 @@ struct z_erofs_maprecorder {
 	bool partialref;
 };
 
-static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
-				      unsigned long lcn)
+static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m, u64 lcn)
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -219,7 +218,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 }
 
 static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
-					 unsigned long lcn, bool lookahead)
+					 u64 lcn, bool lookahead)
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -270,7 +269,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 }
 
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
-					   unsigned int lcn, bool lookahead)
+					   u64 lcn, bool lookahead)
 {
 	struct erofs_inode *vi = EROFS_I(m->inode);
 	int err;
@@ -289,7 +288,7 @@ static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 		return err;
 
 	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
-		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
+		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
 			  m->type, lcn, vi->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
@@ -310,7 +309,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 
 	while (m->lcn >= lookback_distance) {
-		unsigned long lcn = m->lcn - lookback_distance;
+		u64 lcn = m->lcn - lookback_distance;
 		int err;
 
 		err = z_erofs_load_lcluster_from_disk(m, lcn, false);
@@ -330,14 +329,14 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
 		default:
-			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
+			erofs_err(sb, "unknown type %u @ lcn %llu of nid %llu",
 				  m->type, lcn, vi->nid);
 			DBG_BUGON(1);
 			return -EOPNOTSUPP;
 		}
 	}
 err_bogus:
-	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
+	erofs_err(sb, "bogus lookback distance %u @ lcn %llu of nid %llu",
 		  lookback_distance, m->lcn, vi->nid);
 	DBG_BUGON(1);
 	return -EFSCORRUPTED;
@@ -350,7 +349,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	struct erofs_map_blocks *const map = m->map;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	unsigned long lcn;
+	u64 lcn;
 	int err;
 
 	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
@@ -402,7 +401,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 			break;
 		fallthrough;
 	default:
-		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn,
+		erofs_err(sb, "cannot found CBLKCNT @ lcn %llu of nid %llu", lcn,
 			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
@@ -411,7 +410,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
 err_bonus_cblkcnt:
-	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+	erofs_err(sb, "bogus CBLKCNT @ lcn %llu of nid %llu", lcn, vi->nid);
 	DBG_BUGON(1);
 	return -EFSCORRUPTED;
 }
-- 
2.39.5

