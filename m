Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197096;
	b=ZKViy6fDVwCcuvamsgiFFeXyIMvSAeFiToOnhD1l2eX9lcIbfBjCJzIfNbo5dIo3AMtX
	 gfC8rpOpWXyevXLiwCyjCw+o9SwJOuppHjb8XcLfbrFUvRd9mrZPTrnG8RoCXfq0J31XN
	 iGIj48NhEoASwHpF3e26ZdyjstjzLwCMU9TqsXkZthoY0m/gTvNm1BEEYrFvSPh4Bgt7Y
	 2wX+sgWZvT3vKR8dTL+evuuS69hCif35QiWHqh50ts7yEU7BKBD641xrZirJblLNfoidy
	 U8fxUVnTY9LGlSymy1bI4nGKd9UVoymiVnpFupfMSQ9VYDuaYYyACj+am4jZkkwWvrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hVBdoLW9fkr5VdAnACGjL9+bMh3fHpmpbhIVBqSJe08=;
	b=EBAYXyVtiGL8YxNSKiscGZI5wK8akAo9mwS/xXH21z+nYo9Kvmr6SR9wS4mKlQeRR1w4
	 E6o1Is8EeXWeFsZgRVUygNSvq0Aau6+GpCTRRnUzTQYzVLckR41GCR/mDXTn+7mJ8ongI
	 jEy2d8SnZLD0Ffr2NI6mIh95gokLkdcMmlHk46U8rx7RtLpQfhlTaZmKdIU63Z6qN9nzS
	 KM61nlQZG7Yr2GpOf6RJJWrKJmLJIN1z3GS1RpvGUTMHM4oFFk8NGciGVAhcsYzUrQr42
	 S3G5L4KU7ei/+wyHpbRq0r0xJDV1GxHDB+VhtQjs8ZqKY9imSQcE3rT3F3RCT+akLOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9ktbbCo;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D3606A324
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F9D3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9ktbbCo
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a070781f63so541076b3a.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197096; x=1793801896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hVBdoLW9fkr5VdAnACGjL9+bMh3fHpmpbhIVBqSJe08=;
        b=T9ktbbCo5Z9/1NKk27IFpSLUNx4pqAmx3YUBiyXrp1gSRwpZggwfBaFje0lTEEPq2q
         iL3ErvfMZqAiObyLvDQjeFEW/h26o94H5RTglDTfEcJ7vVebSor1ZW1j7vmOwwRVWCIo
         dcN/L3S3r5e3R+0DauINd/us37UOm0/Z6GRAe/hcGl8f7rXmtHtt12/+Ff76GtuJvrbA
         QX64UBX4ryNzG+zlGssnzbtmnOxrIJZgGtNKD1V67qDQsB+1TPLJG/lGVY+wW0eHjUit
         7xFRbh0ql0lbEPLtSQkufQaMdpnIpKAN3q3mH6PPPh+nZOLsz5dsf2W0eeyk8bp/Pizr
         kTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197096; x=1793801896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hVBdoLW9fkr5VdAnACGjL9+bMh3fHpmpbhIVBqSJe08=;
        b=Ad7Z0Upz6v4lCV5j+Os+T2A0zeOWcNTEQdzIgkGduojbCWz4NJSkGTzi3c8rV1gWB6
         4v0OPghnQ5u2WedWpYfr/pG0pvvpJJfXLykoImyQOr2s7AVOgF+tHI6jM1AnpG2GLc3i
         d1mMkDLwpOmXl4HR7AA/8FZrfwVKAScqBMBPOT8BTaDcr7eT8Jg4QS/yz+ACrM9hou9u
         5zFlYJohIoecdT+1gq37KhGjbJ2L4yf6wn39l3RjmXoCTijweNu/zz85Sx9uBuQPNBqe
         /qm/UNfg4WZoD/nk1GgFNsnCIdT5sU1eCvL+I+WTFNE9MTmoO0F0y8wKi1RAHI5kMMsN
         LO1A==
X-Forwarded-Encrypted: i=1; AKwUvBwEkRR4AJZR9Iai+Jqih/OkkhEcKjjIWKn6mqFrl6Nvxen9gNmRlYpIUi03v3L0W02rhAI7Y4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAjqydXy1oRILJRPnY8oEUKpK6GzSjBgvt04Wqo4hnIqwvKWfI
	9qomPHq1OhCjiHJQldsMMYICQR+9GdVoNawSL/FlGzZaf+POLpFV6nbk
X-Gm-Gg: AYBFou2SepT+7S5mrLa5q9y4oR1iM5+jF+AVcmyZwdNPwMIY6NWUyPANcXXuYf5OqPA
	pNBWDL5btEq34HyZSBJsQh1K+L65HspHo7Nico8cl4yCAQ3yq3zqIwSbN7R2VewkJpMmgrjoxf5
	2s6l6kO9GOWaPnaWdj3uMFykdzj9j5pcBzYGMvBVTIWwXkuOQNhQ6iN/VGIe7OJo084BEW9QNcB
	xFohLwjOG+INB+GcosrNSapMJBmX4ZByNkoYDcmTclEC8NZj5uhOjYUYYpGStnwC6rznpyNS00G
	+5jZXsYaepUAFVmSBvhLQdrUXtB4rhM+UP7y5k63nhk20RQ1F6NDN1J6beZT51YOqW8vGiysnp/
	Wli+ihKFJW84AqfQeiOagaAUWG66Rfpq8eO8Yrl+3BQt2xCi5Urs1G9cjyd9SaM0YKPHM1Tjshx
	89MWbjrw89IqDmcLmgzUoITJG9F8mQSj6xy7TUL1cuVt/hvcX4uBuNzhOcv7GNkBndV2kLvuC3R
	Wtw6lTkyP/CrSvM5ZqHSx5qwQR9VlhT09R1xvTrDmbMReGl84jMMU29SglXZUNO3qyJcuqRuSPu
	m3Ycfaq9lIHmgDXx0qH7R7pw1brKNcZ6pPOoTEWpyoYvbL2rpdQJf8xbyTrws/zr0f83Mk2qcdC
	1F8moBvKxWGbxcQ==
X-Received: by 2002:a05:6a00:2e88:b0:886:84c7:72b3 with SMTP id d2e1a72fcca58-8a6e81b3743mr2158463b3a.26.1793197095477;
        Wed, 28 Oct 2026 07:18:15 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a3d5e302sm1284996b3a.7.2026.10.28.07.18.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:18:15 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "John W. Linville" <linville@tuxdriver.com>,
	Javier Lopez <jlopex@gmail.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: mac80211_hwsim: ignore non-generic netlink releases
Date: Wed, 28 Oct 2026 22:17:50 +0800
Message-ID: <20261028141751.6728-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028141751.6728-1-enderaoelyther@gmail.com>
References: <20261028141751.6728-1-enderaoelyther@gmail.com>
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

Closing an unrelated netlink socket can remove mac80211_hwsim radios or
clear the active wmediumd registration when its port ID matches a generic
netlink socket.

mac80211_hwsim_netlink_notify() handles every NETLINK_URELEASE event,
but netlink port IDs are scoped by protocol. The notifier therefore treats
a release from another protocol as a MAC80211_HWSIM socket release.

Ignore release notifications unless they come from NETLINK_GENERIC.

LLM assistance was used to find the bug and review.

Fixes: 7882513bacb1 ("mac80211_hwsim driver support userspace frame tx/rx")
Fixes: e9ed49bf4c2c ("mac80211-hwsim: Add support for HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. Not
reproduced; source review confirmed that netlink port IDs are scoped by
protocol.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index b9446577ff49..fcbc7f4355bd 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -7197,7 +7197,7 @@ static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
 {
 	struct netlink_notify *notify = _notify;
 
-	if (state != NETLINK_URELEASE)
+	if (state != NETLINK_URELEASE || notify->protocol != NETLINK_GENERIC)
 		return NOTIFY_DONE;
 
 	remove_user_radios(notify->portid, hwsim_net_get_netgroup(notify->net));
-- 
2.56.0

