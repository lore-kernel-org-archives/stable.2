Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197380;
	b=Q/QBV7VbzHlFstdehShjzbmu4JmlZw38mCsiLhnspWTTBKDihKPuP96O64m8FnGEapSa
	 reBj/UL+4pIh1/0RtI/9WGxrZUIA2ghrl+t787CocFf+VuSmD9Ar+Mspa4o5g7732Pqb8
	 +cI1r/M38Sp85oIrbRgwB41iabWEpVZyGdrk1SY01uaQu9bMoJNbd+Mv8k/YopqfgryLp
	 9GpzG9xuMkgafZcLfEVKND/2k/zrHr6+S9aalZ4IGPVFNeePWjhTy2Z0BhQtmoN7v1DDc
	 NTjefbGeHnSszN0RFwdisrDzrWTVh6PTn5RvcvDQ/qXNffpSs1Axfu3jQCDqeCV+ogQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7V8TJ7hV12SQrdPDboL85gY+G3YL3+ZJkH+iYuGDZo8=;
	b=mr+AWirD6I+xlJ+nJkgrrK2QfWo3Pom381/jwwMl9GV5eYbXUvVY/rckRry8efunKuOF
	 7Lk3EKN1mqUyLZkEXPFM9sgqcPJ33SByCTsrt/NV3Gvup+4rs0iC6ABcF7NE0/oFzT3cY
	 qsAmPbZl44HIkpX8GXztVCdOYJIRU8g31Ms8y0/b/qgg2hi/T3L0dBLgGs4HR9QbabEgY
	 sdrETxQNlZvMdvpV8w3eKWAB5R71sUBr2ZY5VXtMHGgpBzNO+0YnKYTUVVltIqUVUZz06
	 ZiyYd6HADH3JKKFmgFkEV7EQ1Oj6nmHoGbB+A+zAjKH8C9OgIO1RLBSmWkBrQPcrwKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ebjSrOn+;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90C606A321
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD90C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ebjSrOn+
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso414980b3a.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197379; x=1793802179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7V8TJ7hV12SQrdPDboL85gY+G3YL3+ZJkH+iYuGDZo8=;
        b=ebjSrOn+E7LVjMvKaDuAmzTut4DQ/a9PuFwQjTjtotC5x51Cq3iv7YTPD2ibgTLG2Q
         zhMTozdHmHNHQ3lHAs5DJc8Pj0OcHJB+cVh/oVjvobFu0ZIFK0Pq9AyXUcf0ilW6RWu2
         omNLyzj5mEbxskBE7MF+AqkbHljddxsyAQq1WCGpR3RlbtcKGXYd8V80+cfangXeHisi
         Yq3hwSsJKmR/DwYTYRwh6ukkDtfEaUEDq+AysSwMCrIeGc5fwNS1//bP1tApiP6QUxcz
         v35xaryw3rSTvy318XMKUuOP9TLlHRJXrCQBrDYnBn3lXKo7UV8WUKu1rN3xImwGNo0v
         B50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197379; x=1793802179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7V8TJ7hV12SQrdPDboL85gY+G3YL3+ZJkH+iYuGDZo8=;
        b=tyMWEFGcEud3k6rOuC04VYKzj+nUMR4dYESZwT/VW9Sz/vYy2zh23s99T+Qi+M3spc
         h7EVBNCtzFJxTsDX6FQKLNQdtBJ/IQj3waWwFVp5HFmRjNzzh6+hDzbwyTCxwrcUkJ0g
         R9HJXIwVK/QhU0cvVyvOftEGiS2O7KGtJ9Qp4cldrdTXTuk7P7Cdb7ODxrl0sa0ausK8
         mObBiVDROrFhAyGaIcxCqk8SbJHsTVL2QYthEba+7LFO6HcwqORLwny3EeZHkQNkMkii
         5KcP76iq36UFD3TLB0rZzUdQD6ZOJjFoUWCSTHiWK8pAxVVKYgouPMGWKDm7oBHYcB2A
         UCbg==
X-Forwarded-Encrypted: i=1; AKwUvBwLPqn/M2Zkh8RUEdFt108VvTS7hSOVr+BfCRri2U92pQyYQkE1Oahd2B/d9WDSiSuDP887ieA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJreNf1+KsWjmvIBKHX5YtOXqxX6I8PLLSwCOnrB0R5CWLxzNuj
	Xgq+zd3p1wAipGkaucFAlQj8pveXy80hYr+deEwiBYNGsalM1KTS9zwW
X-Gm-Gg: AYBFou3ZS15wM9LFL7LNLkgCyOgqsfToQRmCyufwxTX4lrtxnU35EPOG3tP5aDJWMgZ
	4XeWPm/GiKuBwc9ZvzDjxHTdUIGBJ1AaSsdJKx2Up7qkEVybjKihU+hWm+3Ur7WIE16hFaMHxHv
	tVNA/ynNDLWOXlf4Aw+9CyjcmdOaDOLG9TJjwNsd8SdGoALq4XZqaLzkBRBSJ3sD4Hsp34wg4iY
	FervZ2JHhu3KvaX+xK+iIPHyOryHXhgb9F63OwcCXmQy7YpWlL4ye9ZP5xnmi6BDcWsQUyf978X
	y0dtnE/QKc8VlIecrCffsOp/fs/1NFsEU/UEUYgNFA+lsu4T5ovRwE+9rYFBSnLUsPA7uAErO7R
	T/klFKlBn+UeJwV6puNoRslcyL1bdsash7PH5eLUpUnR4o9hXgl6xi9Vtd5Hz9FTP7Hx937CvZW
	Sg2J/mo137Fi85TbIWgZyp1ImibseBaw9nE9ipVWX90QavkQ1DW1G8leIrQj6C5zltIzcVmPNAR
	SbR8p7OuoRwbITxNR5YBUA2EdxKtMyuILpn+Z5BkhhT78iyLSzgut3tKoSPRvYVByekqc59jeZ7
	MwlWhHjrDPag5Vj8Yk4jQTFWC2drJWDd6sMURz35+fOm+IkMyC9WsEVyz1ehmaCbca04QrvOAx4
	721L6eguWXFOC4g==
X-Received: by 2002:a05:6a00:3989:b0:89e:9c7e:fd49 with SMTP id d2e1a72fcca58-8a6e7bc8597mr1970471b3a.20.1793197378617;
        Wed, 28 Oct 2026 07:22:58 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662ba00sm1245181b3a.23.2026.10.28.07.22.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:22:58 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: mac80211: recheck the IBSS station limit before insertion
Date: Wed, 28 Oct 2026 22:22:34 +0800
Message-ID: <20261028142235.15428-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028142235.15428-1-enderaoelyther@gmail.com>
References: <20261028142235.15428-1-enderaoelyther@gmail.com>
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

Frames from successive unknown IBSS peers can make the deferred worker
install more than 128 stations.

The receive path checks local->num_sta before allocating each station,
but pending stations are not included in that count. Several allocations
can therefore pass before the worker inserts any of them, and the worker
then drains the list without rechecking the limit.

Recheck the installed-station limit in the worker under the wiphy mutex
and free entries that no longer fit.

LLM assistance was used to find the bug and review.

Fixes: 8bf11d8d0811 ("mac80211: delay IBSS station insertion")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. The
insertion recheck was not exercised separately; the two-patch series was
run as described in patch 2. A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 net/mac80211/ibss.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index d74b66426349..bd7dbaa942fa 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1626,8 +1626,12 @@ void ieee80211_ibss_work(struct ieee80211_sub_if_data *sdata)
 		list_del(&sta->list);
 		spin_unlock_bh(&ifibss->incomplete_lock);
 
-		ieee80211_ibss_finish_sta(sta);
-		rcu_read_unlock();
+		if (sdata->local->num_sta >= IEEE80211_IBSS_MAX_STA_ENTRIES) {
+			sta_info_free(sdata->local, sta);
+		} else {
+			ieee80211_ibss_finish_sta(sta);
+			rcu_read_unlock();
+		}
 		spin_lock_bh(&ifibss->incomplete_lock);
 	}
 	spin_unlock_bh(&ifibss->incomplete_lock);
-- 
2.56.0

