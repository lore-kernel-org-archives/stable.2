Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDDE37EFFC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848920; cv=none; b=AbfWWbcKPkRbrRuz7tJhCjbOc/aZHKnX07qtEzB6EMfdVPTnIwUC7lw51qw/V3KF0DJbpSMmTx8ba0Wwhut+33LwfDoIQ3E3n0Zmf2YO83E6PdPvuHuCA28/KKsCorungFDZGmIOvEzfcssX55PyOfi9LolrI0G+QY/E3Q3Szjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848920; c=relaxed/simple;
	bh=xeL2XZisgo/FUrGnl5D33KAEDxNC1ErjkrARUG8bI+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uvi/8NvCd+PPvSpSxuhCBe8SGk0fv/p3aTZ+gXcmNoSWblVXeAQB/mBC8zUjObD2ejUNXyioj8//eG3xKGg4Uo7JAc2boSS1dnqSlpIfHVlVivXJd+Pg5I+ny1fJR8nd8wPYIOd7HRxWcabG/sNQJjWJDqDGqKycwaeecrxrKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=N8yV5RIQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="N8yV5RIQ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso3126824b3a.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 23:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788848918; x=1789453718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWrOKVPw0FussDK28wDfiGtsg6J7IXyelNHwkTWChaQ=;
        b=N8yV5RIQtimPiD9HYrJi1GyiBsLsRbERpXWx6Q49fwh1UfCkHMxVqFk5Gv7+zXT3Ml
         XhGujVBYdYnXt30mHZC8y6CTXCk48E3Kvv/Q2sKMb68Ya8dhPeQAyhJl83qIAEqsLYPT
         6QuZT6tZO74riSKlz19LgRNv30u3oTcCvnWkRW1/f/sQR/qCzffNWMCtu862TIuH8P9r
         tlft42KiA3apJEBV4AlcEFLzVExsB+uIAj7MMwfNfPIFL7yzBujAKdZpUFftqPGZ5plI
         Yb+qQS97IGerAYwOShXr3TDolUoF3dK6GbdpGUUT6IZmKy2H9b23HIIOKvCO5yz7YHy3
         dvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848918; x=1789453718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UWrOKVPw0FussDK28wDfiGtsg6J7IXyelNHwkTWChaQ=;
        b=CxwmxVUM2uUH7KWvS1ftEEU/tfkqI8V8J8cZDEJE4smUsk+9Sk1PGNvwMWj5Mj6xYZ
         2hsk3LgxX6lQFMM5E5P6xoqcv4IAL5WzLMMDfgy4tHNpRdaxQEFpN8Ecpfkn8SOM+Bb4
         6u4+uNxcydm24YGi9kVEaRf73sOw4l1WpFTAcVVhpuVTUfyTt01hTJ62DKiWK8G8Vj5W
         PH4veJuNh+FmPMl1tKatOk9tdhRVoa0d8iI+69zOgGvBUmcE79dCAp+ildy4uHTzZ9ll
         /Bs/LR+8lCRKv+KpvjuwjmfUL98R9sdAAdffSBUNwIIwnDhsoN2VDET4pd1OyRcItEcz
         +rtg==
X-Forwarded-Encrypted: i=1; AKwUvBwTeSRXDfRuTcrC2Qu17RU3kaJBR/mEq1k6On1n4St4HRfK6egixdEJSNTJf2aWluTysCjVo/A=@vger.kernel.org
X-Gm-Message-State: AFuF++mfO7oFRkb2MREAp6MOBDccDkx5EgqSECtIcYP9mm3HknkMe2QV
	+KsRI+NB9OcI4EJHu4nkZ23+RaAMHJyWGXYy9nB8lEh5HsXKgDMn16rxmn/JrpMRMKt2
X-Gm-Gg: AYBFou2cAOgsBZ9phNlxHUIj1xIBOW+lgeCr07Db60aJwUgMo+Jm4IJiYktYqBLUnJD
	9XBEh4EuVBL4yQGcFLoaDkoNzC23GzoWDVsySvZMgkVaLuameTYqEwsOLF7d5ZohbAnggcfJWuB
	jjeStFJV7LPpjb90VhRR0NvAyXMvkBPXa1m3D+eSgVg420Dj/0nnEYIzNI9Y6B8MJEACtLvCGvp
	wbBDXGdN2g2yz0Ga67itNAT342Xqh/2YjpVovEYY6S5SFWylz3OxnpULrjK6LSQ9NVwX9JzdCrk
	ZqMjN7TKXt/XX4XllMEi021Dgh7sCFfrEGwMcELqFJ6mKIBw6tJXTs7umq0VNmFzRfEPePFX/Pk
	KAayMUg5/Avgr1aC+Nc96zTVx3ISoqA/yavtkASbhW0xpmAWC6RGQRsEQSgeiKxozmeYzUVFzeR
	4AMPQqKh5aNWXRqt/mh+amEdMsD9rkBLPskM5DFblfIxa0zL2+j+hF67HQRVByMWnuNku93PnD3
	iRtZfrSd/IFzfkczdDbvCtw1/Pb0g==
X-Received: by 2002:a05:6a21:483:b0:3c4:3112:3b with SMTP id adf61e73a8af0-3da3a0a264fmr46279526637.18.1788848918208;
        Mon, 07 Sep 2026 23:28:38 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4554a312dsm5109502a12.29.2026.09.07.23.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:28:37 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH wireless 1/1] wifi: mac80211: fix mesh fast xmit path deletion UAF
Date: Tue,  8 Sep 2026 06:28:27 +0000
Message-ID: <94174303640c5e1022b31836770bad75f741afbf.1788845030.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788845030.git.zihanx@nebusec.ai>
References: <cover.1788845030.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mesh_fast_tx_cache() stores raw mesh_path pointers in a persistent
fast-xmit cache entry. Path deletion flushes currently visible cache
entries and then schedules the path for RCU freeing, but a sender that
already holds the path in an RCU read-side section can insert a new
entry after that flush. Once the lookup RCU section ends, the path is
freed while the new cache entry still points at it. A later
mesh_fast_tx_get() then dereferences the freed flags, expiry, or
next_hop fields.

Mark the path MESH_PATH_DELETED before flushing the cache, and reject
cache insertion if the mesh path or optional MPP path was deleted while
the entry was being built. The cache walk lock orders this check with
deletion flush, so entries inserted before the flush are removed and
later entries are not cached.

The crash path is ieee80211_mesh_xmit_fast() -> mesh_fast_tx_get().
The same cache is also consumed by ieee80211_rx_mesh_fast_forward(),
so the deletion tombstone covers both consumers.

Fixes: d5edb9ae8d56 ("wifi: mac80211: mesh fast xmit support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/mac80211/mesh_pathtbl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 03171cf008557..dfcc4f3a7088e 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -577,6 +577,12 @@ void mesh_fast_tx_cache(struct ieee80211_sub_if_data *sdata,
 		goto unlock_sta;
 
 	spin_lock(&cache->walk_lock);
+	if ((READ_ONCE(mpath->flags) & MESH_PATH_DELETED) ||
+	    (mppath && (READ_ONCE(mppath->flags) & MESH_PATH_DELETED))) {
+		kfree(entry);
+		goto unlock_cache;
+	}
+
 	prev = rhashtable_lookup_get_insert_fast(&cache->rht,
 						 &entry->rhash,
 						 fast_tx_rht_params);
@@ -812,6 +818,9 @@ static void __mesh_path_del(struct mesh_table *tbl, struct mesh_path *mpath)
 {
 	hlist_del_rcu(&mpath->walk_list);
 	rhashtable_remove_fast(&tbl->rhead, &mpath->rhash, mesh_rht_params);
+	spin_lock_bh(&mpath->state_lock);
+	mpath->flags |= MESH_PATH_DELETED;
+	spin_unlock_bh(&mpath->state_lock);
 	if (tbl == &mpath->sdata->u.mesh.mpp_paths)
 		mesh_fast_tx_flush_addr(mpath->sdata, mpath->dst);
 	else
-- 
2.43.0

