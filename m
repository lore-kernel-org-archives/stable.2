Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197405;
	b=iHCXEX+vEq8l3rrcmlEpC2vxC0A8oN2Kgz/1lcqTH1U4sRXNgWZudpp3jBR71whmdX6w
	 fRmJV4C+EO+tK+Wo6sbhHXmeZ8CH/aQTJSKvtEAp0eeTP2wHa+ndPWMivUkcuWroGgFi1
	 xE84JyoNBgtrdfrlPHcKQDUCm6PJZ5B4MBH3m6hynrOLa1ilIeMQY3dNC+xE9zIL1edEj
	 Fm0x70VLgJkZfePpx5RYrlm3hUC9vj7qB9VxVPc6YUvkPt2rmlZ1CC91cOoGYKDLE+/kW
	 4p8o0KKRhQaWea4nPRUJ88m44AMv9Q9SP3LOoHm37V8lqslCuhJjedjZcrdXrC3Ep+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=alnKCsFxzyORsFsXKCIpyKnL9PTgktadfxwbxtnPw7o=;
	b=lvqKnBfTZrDQRqDVaLATHXeiv9tyJldWhX1JzsEIx3744zL0KnvjwQptbjGfriB+8u/i
	 X5lnjTCJFohvmoc8UYL31ipZCjWxhKiBEF5laVXXCvdGTRknn/5szX5CqseTT7UYP8Ewk
	 mh1/1KXTJzPZAUB1gTEsKWm1miHYUrdNskykfOGv7XTU/pqc26s3ekwId86DxWRRDJFMM
	 5c21f+yamkal4x6MHbk/UFlRV1l/BHVdRuTE63W+qo0aA8DFizgeXZcPHS+MF5yq5sSBl
	 pzLlq5PMj3qBTQ5FYuUVPQIJq4YR158svWEDBER27QPj/IvImN6Fb3G8uwHQvopJc8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i7zH5IKK;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D26606A33A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D26606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i7zH5IKK
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso673388a91.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197404; x=1793802204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alnKCsFxzyORsFsXKCIpyKnL9PTgktadfxwbxtnPw7o=;
        b=i7zH5IKKJ7SBUu17/XuTpK2eb/CPIFpHe1xmP9UpdHx6hlxiLPprhyPN/lJkP7FchN
         dACeyJnnIeGZVXF+Q173Tnogstf6yXMV0lmJh3yvcYRkxju30JB2sde02qJKEbiTEes6
         p8UoC+4LTpFPzGuC8ZK0yroiFP063Xqlvp6Vx/OdRTlqEFRjx/AalRcmwWcqg02djYBm
         UxphkjnzyunrO4SaUUeQqxlpDrKUlchwnLh9+UnFraZjO0mnpQEAjKJMir4p5h902mz/
         KGvtIyxTfIyEOj9DbNtpwGROOY5P6/5EuIttqDvtuWqtUyLXJpkzGFXHVlmYbDcyA6v9
         BJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197404; x=1793802204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=alnKCsFxzyORsFsXKCIpyKnL9PTgktadfxwbxtnPw7o=;
        b=IP8XYa40ykJWqKwYamKk8S8kXpeOtNU5ip5N1xyobCxHvc0WsoNJTaxi3QfWdQIobE
         5Ih3CSv4OqQvnqrjA/N2ngHJQiC2SNLjZgwWbS3G9nRcMtJ5SQThMMyI6F71nRG3J7Sh
         bNthLECdN6pVoMzvUaizf5Wf+fHtOBuyUNZTlDxBD1VO6Vdm0pIPVzePOm4jmU00HF9r
         RhtlRQIWNwZBiAmzmmPEU6s4DyciwbsLNPgySp1pbTf32kkcXI8IKWUBVrPWhbgwCBkb
         d5JM5CblOj7kMlsjJsWgiM7wK7r2oXtcQLn68f8D3niqKH9/VefNDv9ok33cMOXBRmNx
         tXiA==
X-Forwarded-Encrypted: i=1; AKwUvBwalU/6zvAVFbvg2lLOExas0mOSbB7h4INMTTYkDKS5/2Vwq3VfpYfmB4dMDC2thP8UyMCyokQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6vGRuEe2wwqyu8OXdT0vDI/dqXo9sSuOtj5vfJb/Fg048MjZG
	HraD3rxyFO8jmvM2Q24Ite9ZrAUkPRabN6YbILZMGuNk8Dh6S1SFnssB
X-Gm-Gg: AYBFou1Bpze/18XQEj2+apqnr0r0gb30fcb+DAUsYn40o3yJtQMFEWmUC+VqMK7hJ+X
	pPiGq7QBvAFtq1I9zOznGkGq39RaovUWB+rgCAMNKDydXK+FV0zJnWui6I+gAdXeX/YOL9OfR4x
	WWqpNq76lLGKfQP7bk4TFC3LAhcHSy8cvU2KKBijOgkTzZg550ytgPCKaHRgu4Jzm03vkxSy6tG
	T0kN5QI8izQ4z/lOK8kSegH7u6fhb5am1B8Jb+EoEqE5uHc+kNC37qr7WCz0GMRy0ZO+eMccExP
	NPaJBTUxXXYx9VF9MMC8JL6lbpW0PYiLhYat3kDj8hZnHlaoNffa1n+zVJ4kVd/YvzJIjC7WH3j
	ro4mMMyw7drQVVbMtTj9aC9ZHYvplQTtRh08uH/TAA6ijQlMV1bgWJiNs20WBr6PIqFhKGBlbJd
	PJ0aCsgUxcEUmrFQuTxRb3IQXiQLmL7ClaoB6TD62ktKKqYMye/PLXKlEfMFLejE5U+g6ppTYNy
	IeT+SrD6D0XImizBtLdHOzE1sLsc4dSwOTfZxbKostA/f0I4kO4pPu8voBHzKCl9AP2HBEbhuze
	3TRO6ZmxsQzNXAOd2i2CO3gbuiZN3V5e9csEs0mfl5CS/t8p5Qc3HSauyCKHxxG5zExE
X-Received: by 2002:a17:90b:2f4f:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3ae58181a3emr1804006a91.46.1793197404548;
        Wed, 28 Oct 2026 07:23:24 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a501083sm3773918a91.8.2026.10.28.07.23.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:23:24 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Rostislav Lisovy <lisovy@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: mac80211: recheck the OCB station limit before insertion
Date: Wed, 28 Oct 2026 22:23:01 +0800
Message-ID: <20261028142302.16634-2-enderaoelyther@gmail.com>
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

Frames from successive unknown OCB peers can make the deferred worker
install more than 128 stations.

The receive path checks local->num_sta before allocating each station,
but pending stations are not included in that count. Several allocations
can therefore pass before the worker inserts any of them, and the worker
then drains the list without rechecking the limit.

Recheck the installed-station limit in the worker under the wiphy mutex
and free entries that no longer fit.

LLM assistance was used to find the bug and review.

Fixes: 239281f803e2 ("mac80211: 802.11p OCB mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. The
insertion recheck was not exercised separately; the two-patch series was
run as described in patch 2. A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 net/mac80211/ocb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index e9bf4ba3e60b..a8dd4f4dbf70 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -139,8 +139,12 @@ void ieee80211_ocb_work(struct ieee80211_sub_if_data *sdata)
 		list_del(&sta->list);
 		spin_unlock_bh(&ifocb->incomplete_lock);
 
-		ieee80211_ocb_finish_sta(sta);
-		rcu_read_unlock();
+		if (sdata->local->num_sta >= IEEE80211_OCB_MAX_STA_ENTRIES) {
+			sta_info_free(sdata->local, sta);
+		} else {
+			ieee80211_ocb_finish_sta(sta);
+			rcu_read_unlock();
+		}
 		spin_lock_bh(&ifocb->incomplete_lock);
 	}
 	spin_unlock_bh(&ifocb->incomplete_lock);
-- 
2.56.0

