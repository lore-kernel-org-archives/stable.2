Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197409;
	b=pYawTdB7oaGTiOHsXeRMEhw4hOAfXkydVZz6ZbiMbQg/dmOCwJhf6B1D25UOO6f+adLH
	 BdRKy6QDkKRhotj55pCyyTqrV3ig9UGr9dlWFJAYtc6z2HR++138E4BIT7KVUgi7D35PX
	 JT0t9Pi7XwDy+AKcLZgJg9dIwQulD+GDH3hqSG3GH6n/s53lCL3odVJ7+zgKTTXetKq0l
	 tcEwDOPDBgSsOJ3HuVKWxtZ+5zDG91x/r7xC2pNxnImits02XfCu+4ukfT73L/Ns0c3oH
	 CO9/EbuOFLPeJeKaVgDfanE6oodJjPc5t1kOhCvGOYinSk1ghtSXhxDuxlRzTPSvxrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cVhL/LPEqcpTbY6iiAqPg/sDis35bxi9SXGTVRzvJJk=;
	b=Woll6eiNqmRkgYgNrukaK1BW8mJ56BVYs6DbM/1vv8vpkL6rCXsIq3A1XvSOAELNz3VV
	 A/bRlEjtwRNiTK+2+zR1BmV4mfUiTQ+vHA4ptqyOvuVfsYy5ZxTEhKepPqwhv1Z9DjQ5l
	 aBT6V1XNs6YZejUEYYZOsQX4xwp/07SNO7Vw0/wgFk/1vPD266w+2l/2wdcUe2k3EN28v
	 u7QoQhX8v8F1zL9rM3kqRkqtSpzczA+NbxWda6xYZIe8cPt+RJQDr1dGbbgSG2VQ61NgQ
	 bn12U2DeHILpJ2aoZkUXUwxvZJKGPH0QYv5y07AVWS6DUxs27TgV5XTOqZlcrVGPn9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HlgguaRG;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444760A2639
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C444760A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HlgguaRG
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so920469a91.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197408; x=1793802208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVhL/LPEqcpTbY6iiAqPg/sDis35bxi9SXGTVRzvJJk=;
        b=HlgguaRGlWLQNo6tLyekEGWSTluQr4x8+lI5jUjOszfi6sp3Bogma9wO0oDsxUl5Qe
         pJm6GHL/WVae3wBHsJcHzE7zYgm2mbzlizZGl2vOYtguDKiaBaijMWfA2MYDN02wuYxT
         2GHBF1uHpMIKqY6Xg0Lz2LBnpoB9+4HE37L3IjhBilBI0gjTiye3+KWBWK5TugbWmiwA
         QgAyWyxFw9tIib33N8IuRV9hpZpmdyT/X12C6vhTWPqB0DWG7S8qMhszehxjMSqdnltq
         f0yU3FLsPGGBjZuNzzja7Qeew+KeUkp47iAW2oxwv62nhRXDm/gZKnO01U/FOMegNYdj
         w6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197408; x=1793802208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVhL/LPEqcpTbY6iiAqPg/sDis35bxi9SXGTVRzvJJk=;
        b=ibDQQkm6br8Z82aFgOy6rgCDrqyagtSZXwjXCsXWZxM6zBUPaAys/Wo4MDBKwv+SZK
         Y6+QWz0RHsTborf6G0+hxwP+TleAF1yk8GGFLJKpQy8gZdcf9hHps9E+a37UmHJmHNzj
         gNHfirVrE8KSyG8WBBRfynzTKmFT6yVnCij0Orc2rn1Ll1Dw6iMuSG99m4UYfyKT2Cyt
         8tAKkyMRMoV+/LraOl9P8xND4fHNteznVx+AfBj0zBLozKuyI4dMbgM9OE7JCZxwCTDO
         I2zsMuuLMeXu4wWoz68e3DZNlnd1CcDqAhWzNwhwqilLnXFqq1GtTNNu1J114dz2okge
         xfeA==
X-Forwarded-Encrypted: i=1; AKwUvBxePHNBO7CXeuseBvFx/f2JjRva2vXy/JXWjb26HWWR56VOdxa+f50uaFpOqtBdJGXQyEY/qNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKx2J/RrA5MFlyh6cl7wmdp32jc85avhjWN2IX21jHG81G9lStw
	gD8EwMENQ4KV0Rga3eaFV/n8eD/LwFw8CxuQvxLgf0Pfk4UH4ZzgRsKL
X-Gm-Gg: AYBFou3LjxbH1MyEpkGyklqsuwauwR26vOA6BNQdSzO5HXyJUBwa4ROkvtKu/hhoCo5
	CKsaCINir9es2LiEc/rKDMNINTP8TLLkVg9d7nz5/BcetRr51BdSr7Itfx0MtbFeoQuwUX6P9yH
	y23hspnvqThGfyuVqec2Vhki2TXT0a+VjLQ/Hgtv8IYAUDvUFF+hNvEejSSGdTJkmN9EFatnBXx
	Bk3DjDovY0W07Azg1uXCthhDHNIyOCaJEQ33Hh+b/S5OYSn1qs4iy/KSCI2wQ50w44wpEQG9tDY
	GoRJDIWOvSjwBNxl8ImuGf/FdFrWGadBOiBwOfNXtjXq51bRCNHRArOt9hhkPC8r13y/r2/NYl9
	mCeKz+ZeiW4Oge1N58I4EkHf0cS0Qr8lERis1zyKCjr5kvXH1q8lCyWA6sJ7x95XZsAgxC+BoM3
	qaS0JvC0E5XMi+piZlOTcLjUepEa9ad0sFuWenOX/vH3UPZ4UNtmJ4gTqdgZumh8qQSao6IE9n8
	Tn+nqSleNiFmdcHSbB5b1vO9hGdEL+ihe8pYJMcnEfRPZa4ckWUczQlsit77Bu2+WE+2VpVjGp/
	N3wnVBCmV7iPH8tKsbZjDXg+2wNnJau/8kP8cmsnUimNigfH2FxACIhdNmNecnGoUwqN
X-Received: by 2002:a17:90b:2891:b0:3ab:afca:1d79 with SMTP id 98e67ed59e1d1-3ae581b45demr1855722a91.21.1793197407822;
        Wed, 28 Oct 2026 07:23:27 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a501083sm3773918a91.8.2026.10.28.07.23.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:23:27 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Rostislav Lisovy <lisovy@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mac80211: bound pending OCB station allocations
Date: Wed, 28 Oct 2026 22:23:02 +0800
Message-ID: <20261028142302.16634-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028142302.16634-1-enderaoelyther@gmail.com>
References: <20261028142302.16634-1-enderaoelyther@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delaying the OCB station worker while frames arrive from new peers can
retain an unbounded number of station allocations.

The receive-side limit counts installed stations, while new allocations
wait on incomplete_stations until process context inserts them. The list
lock does not cover the interval between allocation and list insertion.

Reserve one of 128 pending slots per interface before allocation. Release
the reservation on allocation failure, after the worker inserts or frees
the station, and when leave frees the pending list.

LLM assistance was used to find the bug and review.

Fixes: 239281f803e2 ("mac80211: 802.11p OCB mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. In a QEMU
hwsim guest, a 2048-address flood left 2048 OCB stations before the series
and 128 after it, with no KASAN report. This is a resource bound, not a
memory-safety result. A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/ocb.c         | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9374c2942489..52bc69774ea6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -696,6 +696,7 @@ struct ieee80211_if_ibss {
  * @wrkq_flags: OCB deferred task action
  * @incomplete_lock: delayed STA insertion lock
  * @incomplete_stations: list of STAs waiting for delayed insertion
+ * @incomplete_sta_count: pending entries and reserved allocations
  * @joined: indication if the interface is connected to an OCB network
  */
 struct ieee80211_if_ocb {
@@ -704,6 +705,7 @@ struct ieee80211_if_ocb {
 
 	spinlock_t incomplete_lock;
 	struct list_head incomplete_stations;
+	atomic_t incomplete_sta_count;
 
 	bool joined;
 };
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index a8dd4f4dbf70..90c43eec61e3 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -70,9 +70,18 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	band = chanctx_conf->def.chan->band;
 	rcu_read_unlock();
 
+	if (!atomic_add_unless(&ifocb->incomplete_sta_count, 1,
+			       IEEE80211_OCB_MAX_STA_ENTRIES)) {
+		net_info_ratelimited("%s: No room for a new OCB STA entry %pM\n",
+				     sdata->name, addr);
+		return;
+	}
+
 	sta = sta_info_alloc(sdata, addr, GFP_ATOMIC);
-	if (!sta)
+	if (!sta) {
+		atomic_dec(&ifocb->incomplete_sta_count);
 		return;
+	}
 
 	/* Add only mandatory rates for now */
 	sband = local->hw.wiphy->bands[band];
@@ -145,6 +154,7 @@ void ieee80211_ocb_work(struct ieee80211_sub_if_data *sdata)
 			ieee80211_ocb_finish_sta(sta);
 			rcu_read_unlock();
 		}
+		atomic_dec(&ifocb->incomplete_sta_count);
 		spin_lock_bh(&ifocb->incomplete_lock);
 	}
 	spin_unlock_bh(&ifocb->incomplete_lock);
@@ -228,6 +238,7 @@ int ieee80211_ocb_leave(struct ieee80211_sub_if_data *sdata)
 		spin_unlock_bh(&ifocb->incomplete_lock);
 
 		sta_info_free(local, sta);
+		atomic_dec(&ifocb->incomplete_sta_count);
 		spin_lock_bh(&ifocb->incomplete_lock);
 	}
 	spin_unlock_bh(&ifocb->incomplete_lock);
-- 
2.56.0

