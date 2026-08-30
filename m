Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DC3B47C6
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100319; cv=none; b=VIdCKxX5aqKMF4ZRgMOCTD4EsG+I/oqjrLoeYjbuvSBzJRHlVVex/OHKsDAp/jIcTxuBAXm7ppXnMa+7OE+nXUxGrjx0aIUvGw1FlKjFilrc/J1Vgr/8raJXbaisgkqsfXbhn1c5EEZDV+Hdtu4fDokIKdnmta9uzMb47e9YGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100319; c=relaxed/simple;
	bh=iBtDbzrrA3Qi8QxtdfsPvuAnJBG8zTYXvzy5zSQWvOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1TwUp9L+BUJGCf7t3ZDzW5xEbLPRi8T3I+bhbHVM+VWdBfG+l+JyBG6n3s6TooSad5E+k0HYCW6hc2HtrXOdEMtXiKtcuYcyfaLxyDeZB7G0QgHtWImIf9Nc9u7zKoKAu9nQfL8NYCt9YatFMKwJk8hHqfiQtUjdrUnbrvEGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTyFbtz7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTyFbtz7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso19210345e9.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788100316; x=1788705116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUdIs7pWN4w8RxbVLOKOg8qp85Eaa3COSA27rxG/j3g=;
        b=bTyFbtz7wlhFI/uzIj32F0+37cH4qLVqSnP10Njswz/4Fy3LXjopcSo8rgZirKNQ8m
         dzpv8IhE9NU18y29wCjDFXuwOFwZX39WCwdfSK5CP8yOrWkP7u2g74LeUPKg3ufna5Uu
         gpdSEpBDJI+7UsoaEoV9AkOWa+xlb3gN+4EQ5EPw7hmb9iqnqTr7QioGSXJkj5R6npEC
         w7wR5UMaK5TqHqep4iA5MjKb7RspcBrMiWbKmdaMv7bJTOQwShrZDr6uWgsfqqbFY5wc
         L3RgH6Sce6EC1/UlNlgOjxGSUcwtm5yYlca8eM+SkghpRAB78ZC3dHrlpiAOVGsE75jS
         obwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788100316; x=1788705116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUdIs7pWN4w8RxbVLOKOg8qp85Eaa3COSA27rxG/j3g=;
        b=VpEZw4b0ELtlXZjBxopDbV4n+bcV5H/vvPiZrYkRs8ES34UWK7Sfzadk6Tx4Z7Lglu
         z9ZrOgkhJWYWG4CVhpBcdPBYhF7XGBtS01VSwtnZOtjDLe3LcIq+NGMXm+q3J3gSpnQI
         //RSrtOfRmh0GEUXRWwby2yMMqLBpKkePfDmzpf9bBkyvC+KL+sM3ZGUyeyTGe6on9+c
         u22gnGWOUKZDGnDq8Y4/YOopGEGgbbUQ28xp1iVIe9mjCgRIpKqD2F7s8yXj9YVLCcEY
         OJ309pmpsJLoFA0evaAyQ/bGEb5XpL3LZQsDl0DO34KL8auzg+4EZZXXpmLXGCPCSc/y
         hnsw==
X-Forwarded-Encrypted: i=1; AHgh+RqJjemP1IbwPNDQ3+8GaDTQG7JT82hFwjE4mzMT/hLQfG8Atfipk/v3hXuoWMixuNqxOLtbc9M=@vger.kernel.org
X-Gm-Message-State: AFuF++kKku8CUYrWdsBtfBwVOLe5QK3+iSOJFX4P9BjFRXJnuz35zV8U
	wCl+ML2869/tujWmE2HeLI2shko1dSU1rbH70qh+RH0dbp5OQLOBcPZJYW6Y
X-Gm-Gg: AR+sD121Hp8WBR/V5H8O48EfExgr0Sw9sYSSotIYn9KH1z7uqiXkp72qhUcwXtlRHwe
	OyKt+Rq0S2u3YflAG03jBgIDm4eODvjD5MGCJ1p1XJmQtwsSMiZS7M93YFJ/g1OvLGefWRCcP6H
	XoGmRrXkpSvkn5+FtdsVsAFBSqov2c9+SmD5mO0VFHHtGT/ZBV2Xm7qM9uFipc7wAaz85ZT6tRn
	i4PSylceZQ4DlV0YIaCUSahGPn4tIef3zINS06TrdQmOr3y7HbmfrFg2nMwHFTQiFZPpWlYwXKL
	VOt1tgulDNsABQr9Gn8Mbr3t6J5pQb1LEJbDAdoWlEQpz+/dbQiN2NLM3FpWPxe3NIDgwSJ7aJ/
	JViF2YRgsehCc+p9WuFLtD5J6RdfxYoitbnDQLCgIYqCWdN66HKDx4ZYhIEVuAaL3IL7/3YndCG
	8KfB3FO3kh8lTU77AdSpaYgTi9E7KvsA==
X-Received: by 2002:a05:600c:1f82:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49b91c19d37mr304483175e9.2.1788100316464;
        Sun, 30 Aug 2026 07:31:56 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccae954f9sm146319065e9.13.2026.08.30.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 07:31:55 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Po-Hao Huang <phhuang@realtek.com>,
	Chin-Yen Lee <timlee@realtek.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 2/2] wifi: rtw89: fix OOB read in __rtw89_wow_parse_akm()
Date: Sun, 30 Aug 2026 14:31:53 +0000
Message-ID: <20260830143154.1751910-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830143154.1751910-1-tristmd@gmail.com>
References: <20260830143154.1751910-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

__rtw89_wow_parse_akm() computes a pointer to the IE area with

    ies = mgmt->u.assoc_req.variable;

and then passes skb->len as the IE data length to cfg80211_find_ie():

    rsn = cfg80211_find_ie(WLAN_EID_RSN, ies, skb->len);

skb->len is the total frame length, not the length of the IE portion.
The IEs in an association request start at offset 28 (24-byte header +
4-byte fixed fields), so the correct IE length is skb->len minus that
offset.  Passing the full frame length causes cfg80211_find_ie() to walk
up to 28 bytes past the end of the skb data buffer, triggering a
slab-out-of-bounds read.

Fix by validating the minimum frame length and passing the correct IE
data length to cfg80211_find_ie().

Fixes: 480dd4dddfc5 ("wifi: rtw89: enter power save mode aggressively")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 8dadd8df4fc65..82b74ded68631 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -16,10 +16,16 @@ void __rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	size_t hdr_len = offsetof(struct ieee80211_mgmt, u.assoc_req.variable);
 	const u8 *rsn, *ies = mgmt->u.assoc_req.variable;
 	struct rtw89_rsn_ie *rsn_ie;
 
-	rsn = cfg80211_find_ie(WLAN_EID_RSN, ies, skb->len);
+	if (skb->len < hdr_len)
+		return;
+
+	rsn = cfg80211_find_ie(WLAN_EID_RSN, ies,
+			       skb->len - hdr_len);
+
 	if (!rsn)
 		return;
 
-- 
2.47.3

