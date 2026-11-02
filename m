Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623740;
	b=qxWpySQadRx3KNU7z5pKCkCRrfT4Kd1CIYK6x/n2wAnMyzGeyRpHGdyrBZCBg7pLx2ee
	 Zaf9Thk4ydK3b/I4k7bf2ddIC7hxbLakwNuA/qWT5rXzKOms3K+6FPa+g22zxVM58O3dK
	 kveQg4j2CZFT4r79yxmuwbGSKXnIEk5aimNDlBImAVP1hGG1+tqZu4vlTzM5H4kXTFrun
	 85XxvefEOP4F8hyhi6AfZOQTko2U/YQ9f9deh20LDrpTadAi4PfLVfk+Z/mJuYTSh2oKa
	 x8fYf9pebXD/pbJKkiBhWVPYF7Jl9svu3Gei9o7G7XjtJPHL0q8zQ/PBwphQ8J/QKJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7fMnYg29griSNHAmS2PXZq5vvQiH2csEt2FfsLS60Pk=;
	b=oBi4KGsxhP54cB/qnsEi42+eUuk0TlRVvT4hQP6YMWlWJZSBAR2YaCnEyF60xo1tSiaq
	 Tw3ia59+1NQfYGCYM6m9vIt+yTb5Pfd3Hz2/Hfb1OjXZUaU6Jdw5RPMtUOmrx9vTdm6P/
	 9TErTroezzKyXexE0qlJ/bZWwNoWAKOxUz6LVNWX6xXYnvkYd3g84vRiGj6Wftxw3xhwP
	 g12eyT9E8QPdHzn2/0KgC4F3xJ58EyG4NhWGTZN80uNtqaStEyzQkaB+8tUk9xhsMaOIW
	 O/G1WG59YwFGVD/iphT+YFXDBDzL5d3jtRktFUdvxfqZDncDzIVoWS3dhcQ3/EyG3Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJtfxzwz;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247660A2621
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1247660A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJtfxzwz
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2424713f8f.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623738; x=1794228538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fMnYg29griSNHAmS2PXZq5vvQiH2csEt2FfsLS60Pk=;
        b=yJtfxzwzNIUacvigCQ0K79QD6En3ow4xtxinMtp3MyZ2olcaP6L/MDgkeUKqE80u7g
         idjkMxw6Q4RVuSuElOSjosUrBWMJrLihAp3AVT4m8E0ABHAs0dOdq4eNaaZk05RYNWk9
         enTiFAGcvD01XWhtWN8k07wUZZBDi1wwcw38xQfIuM3oZjoHua0xHlvD12ra3J4bCJeb
         S3+yCfIWAZPAMuvAVYuIBKpIwozkQgOIsNcKeQXKcJ2yP8wL8wa0aRupJv7m6tzPURub
         7TxopA1eJqCySzbWIDUpydf+idTeX4gp31xuJl7NclDuAybGdBIOSMasQvxLBPs8pqyM
         p54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623738; x=1794228538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7fMnYg29griSNHAmS2PXZq5vvQiH2csEt2FfsLS60Pk=;
        b=ue92OUMwROiZ3DvgBwRjqyMM7uDzRcwSGKSzQYNbbLhEyLOWc3Jf9UUvRB1Vvj7RIZ
         ieiTGYpEwYIAopAlOz+zp29H6t0d6tnNhgv+QeF+0MpTX+vlqn2FmGSU7GczEXH8wqeS
         CtLP8h/TQtODjcNCc3l+fDU3RA6JPQ/iezU5gq1SMwATDVhZCs2ayBB9ioogwYjEkfNl
         lz7wZuopu7FnFX5wuX7ZEnGrpNdVa8H6BqeR0MIra1A+6H0YgX/ROxoT3BlnyaBD/+dQ
         5n5wVS3xFKE0O9eS4ckKqI/NS2/ADJMIYVvlhmLB6RXYDkSoaajfEQi1bxfdbc/eYR5a
         BvHw==
X-Forwarded-Encrypted: i=1; AKwUvBx7xqXi3a6wbwOVqZEbfDBiX+p2hrPetY7jueXc9EY9OoIzD9ptUx7a0poXui9NYXoCwAULLO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+magNzNUJQz4a1lkJ4q4YHkSN+6yMLPv2bgejX085/w1B01cXp
	HD8SqPooT5mm4zBxoukaSVw3kTZDJNzBcDV3vTTTBEcxA1Wvzs+39b4=
X-Gm-Gg: AYBFou3B5rctQ9YUOKsL6YsZbmiO0gjPAJbbeCwnlq6RxFTWBQIOPaPKpWoMFbXV28i
	y+T4Be/U7dNDxPbA1n7qZpPGmHcBvB6sxuT4c5+4qSvBW1zRFiP5lieOR9t6kz9qn3lRQ8J8u2z
	hmrp99eOQpPRv+AjRRK3yBDu4btqmRWloOu5Ck6wKxUfXXzjswwyJOF/uP1lYMK5zW+Ic14Gq97
	WnCD+P5NGn6N4y+T5O/yyT1Ko3uCuZVP5mK3+mTv79wFniQOPLulJK+/XIsBbXu35XFfazNC9Bj
	xbdijRqCK2HOrixowCfD0Z+nzJtaLp+9ZQjn4S8leuOEMTYrwyh9hgfZmuAbnL7ICl9ji5QBmxb
	BqpUnsshIryhycAzc/es6wS9XQjKe7LT1kNjIIrWyDMjWez/GXs51pVXkR+LSwdJ+zhU1EvLOMR
	2yADyMMVeFLkuTeTHCIUzrfN20HHaoUwPv9dfAjubxT2CgWNghS4lX51/ZTuiMQL94n1LzluYo0
	N0IMjwh2akpxaC/4qLm71jnAWymASxoixYP2ktfDNKpuCYYNEmbKUgESefcaF+owPi7N2AC8g==
X-Received: by 2002:a5d:588e:0:b0:48e:bf0:35c with SMTP id ffacd0b85a97d-48e6e4f543cmr20614479f8f.13.1793623738447;
        Mon, 02 Nov 2026 04:48:58 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm18719736f8f.15.2026.11.02.04.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:48:57 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless 2/3] wifi: nxpwifi: validate ext_scan buf_size against event buffer length
Date: Mon,  2 Nov 2026 12:48:53 +0000
Message-ID: <20261102124854.325979-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102124854.325979-1-tristmd@gmail.com>
References: <20261102124854.325979-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

nxpwifi_handle_event_ext_scan_report() uses the firmware-provided
buf_size to determine how much scan response data to parse, but never
checks it against the actual event buffer length. A firmware response
with an inflated buf_size causes reads past the event buffer.

Add a check that the declared buf_size plus the event header does not
exceed the event skb length before parsing scan results.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/nxp/nxpwifi/scan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/scan.c b/drivers/net/wireless/nxp/nxpwifi/scan.c
index f3becafb9c23c..e7d98463ad18b 100644
--- a/drivers/net/wireless/nxp/nxpwifi/scan.c
+++ b/drivers/net/wireless/nxp/nxpwifi/scan.c
@@ -2427,6 +2427,15 @@ int nxpwifi_handle_event_ext_scan_report(struct nxpwifi_private *priv,
 	u8 *scan_resp = buf + sizeof(struct nxpwifi_event_scan_result);
 	u16 scan_resp_size = le16_to_cpu(event_scan->buf_size);
 
+	if (sizeof(struct nxpwifi_event_scan_result) + scan_resp_size >
+	    adapter->event_skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "EXT_SCAN: buf_size %u exceeds event length %u\n",
+			    scan_resp_size, adapter->event_skb->len);
+		ret = -EINVAL;
+		goto check_next_scan;
+	}
+
 	if (num_of_set > NXPWIFI_MAX_AP) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "EXT_SCAN: Invalid number of AP returned (%d)!!\n",
-- 
2.47.3

