Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150785;
	b=vvlQJLigXI+Y6HuRhnzZt01m43M0j2E5QabLBvMSs6mx+LF7CU/21qFu6mkAwmrYrwre
	 umgtjwfMYNoMeYZsI3WlgF3fBZwY0Rn2LxbTL5L/tiRpwqUE1IEjUlA+/jzbeTo4o8alY
	 7W7OyDyV4HgtDF0kg5D73V33H55e7DGd0IqlCbTo3F7yRqIZ9vuD22mkEm8QWPGlHzLu+
	 GpvXALqkj49y6nHY610MQ4JAg1uZMxbHkG53LaBb3Aqu1+hOu0ipDc3KaJiVcTr8x5WXi
	 51mIeLrS+SyRe2QWT2UW3vTv5SVEOMWuCEGRfBfIEDIpIwS8894CxzaUHy6/VLxRDGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uOuX8lmp0xof0e0xCWW+uMkqG0cNoPc1tk+upESwVAA=;
	b=inYruHOirpDqBrEm6JHYN9a+REEVMQvhdSlrMH7V+3N4xMfuCh+VzJxK8fb7UX9fvktr
	 /1IxQZh0ACv4uCTtlw2lFIEIHdjfU0jHhGbLG3CtI+5/WWWIPu9nF2yBW6p6qO1yHIZEW
	 ybntFz+s/bxld8tWEuS6TwGlGGDooIrteIQdx32mQfgEJ/iY9eRHDM0AbEwxXNty1qbbp
	 8eqs9PspoQZAQ5BaKvajcr12WhF5U5xZgDAzPovemcmTCmV3UNzMNH9lKW/YDm8kDIEKN
	 NuCM9EYm/jR0NjrsnNcxAdkmHVwC/atWYxJo7rowCnsofYbuQLxktYPoUMgnRbB5eXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wD6nmJjk;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED9606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 01:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AED9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wD6nmJjk
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so5119335e9.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793150783; x=1793755583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uOuX8lmp0xof0e0xCWW+uMkqG0cNoPc1tk+upESwVAA=;
        b=wD6nmJjkfOYRuScAAjWuroVnw8/yb8cS2myqAQz8AU6cn6hJkgnYxaQpjxl6D9mRMJ
         ZcFMgRHJ5n73SPLY5hE3oPlainPIQ32aabs5/Mxinv4xNdV0R/0GdT810Kwqc9Wy/EnQ
         qrMdqyCIlZXQ+Rux1I0L6w7iCGx6F7GJGDyF7v9+KHClhIml6bdDHOIBYwd3mJhMybRo
         zOIVMSncRPdj2Na19D+2eikNW36sXxRY/PmjRoU1FI9D299oP4KeSoVGJa3t8mtHK8cc
         E9J6Oj1RDgUTrpn8i3Pnmg/qojF1p5V0l2cjZOyAKigv9Z0dMRnemAUvzY9fLpGiM58T
         bY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793150783; x=1793755583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uOuX8lmp0xof0e0xCWW+uMkqG0cNoPc1tk+upESwVAA=;
        b=sFFxeNfWp+yBMuLqu5VONp5u+vwGfUTgnyj4TZVtvLXeDo67lqMJZZGhibuz+34Jh3
         ip8eBvs1eAMPSo4C0lcZqEVYBTMkOAEpd6cScgZRODdvduJ/g+eIoTI9RnpIxtv2QUTo
         EmqOoGp4dub9sJROb9UfYPT9FuzvHi7R23Bn7gxmrzD49dBAHfQQzYBAVeH+f/IiAWZ5
         91BhX5lUPaB2AQ6KsfnLIpb04Zs2e6T4hZb+DOlWXBiyju32pEdy+f5kAg/fMdV/3NeV
         7Es+05KqAD33kUaha23j2rJ9OBa2hDK3Bz6uTha5YHuTztPIbXDYMWkQyVv+TpivHQiE
         nIEg==
X-Forwarded-Encrypted: i=1; AKwUvBxts0/agNy/xYxnLH3xB5TsU0BG3gA6NZhNjgSEpe3iPcXIEQn+akJ3sM27tOoU/E1Fq5ouWoU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoZD6UttUwy0ekQAdFpHoL2hdcDW2q/Z7mohkfATvAnJ3if8Fj
	bVfehqGQr3aPd2sFNy8ww0cc7v2lKRC4//41WkGxKKXL1ZFF1EJZInw=
X-Gm-Gg: AYBFou0idOinkrWOvHj4XVwVmTYhbZbgAGrIjGNlHyr/IzNLWGhfJZJvzIeHFrm1+p+
	MgTNihzIxN4UDKTp8vOok2wu4LPsWpEEmIhSWQvcPeq1OAq3nvoo3vfrVr5xoBTsYlcw7LFVGhd
	RK+0TeAZoi8v68u4HJA3T/hiw1Bi9xNz1LogU2vnlS/hxSaLQi1JJc9Ig0wZzpXmtSc56Z0yhX+
	U59zFkqyYzGITh0s6t+/IvvamJ2McWWcp5wSVnT0K0pr7rUGzTGYBX6rx4YwzwDk1vfXdfLov6e
	yD50zAFKHqS4e4DXwTpR7gUse0dWc6nEDOX9xviWhdIWKqvusp9tyLB2CPvdvaFXv3J7Pag3Z+j
	U58jYVF3L+RPRG6N5jPUIPhTZaqtlbxnf+5izhyj1ip7M9vzw71y2pHmeCqz447CKXB6SF1yM4D
	aL+bT8alyBikmn8uLb1q0+EkN700x0bxyNm/RwEtDSAf4xrt0f1koNbjTpE/5wGYo8r02+MMuBX
	jp4oQmDFKAmdEhiX3nMCMAk8J8XbRu+hxPxfpyqqsSJWROreAZXoB7zPzAWnG0Wn1LB27OUcfzE
	aqE2rzGMSO8=
X-Received: by 2002:a05:600c:190a:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4a966586d1bmr13640805e9.12.1793150783182;
        Tue, 27 Oct 2026 18:26:23 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c9f150fsm7935155e9.10.2026.10.27.18.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:26:22 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Jeff Chen <jeff.chen_1@nxp.com>,
	linux-wireless@vger.kernel.org
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless] wifi: nxpwifi: validate scan response TLV sizes before indexed access
Date: Wed, 28 Oct 2026 01:26:20 +0000
Message-ID: <20261028012620.3762590-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025181531.3744345-1-tristan@talencesecurity.com>
References: <20261025181531.3744345-1-tristan@talencesecurity.com>
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

The scan response handler indexes into TSF and channel-band TLV arrays
using a loop counter derived from the number of BSS entries, but never
checks whether the TLV data is large enough. A firmware response with
fewer TLV entries than BSS entries leads to reads past the TLV buffer.

Add bounds checks that verify each indexed access falls within the
TLV's declared length before dereferencing.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
  - Fix From:/Signed-off-by: email mismatch.
  - Add missing Cc: recipients (Francesco Dolcini).
  - No code changes.

 drivers/net/wireless/nxp/nxpwifi/scan.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/nxp/nxpwifi/scan.c b/drivers/net/wireless/nxp/nxpwifi/scan.c
index 67d7ff2f10c59..a8d3387320af4 100644
--- a/drivers/net/wireless/nxp/nxpwifi/scan.c
+++ b/drivers/net/wireless/nxp/nxpwifi/scan.c
@@ -1999,12 +1999,22 @@ int nxpwifi_ret_802_11_scan(struct nxpwifi_private *priv,
 		 * was received.
 		 */
 		if (tsf_tlv)
-			memcpy(&fw_tsf, &tsf_tlv->tsf_data[idx * TSF_DATA_SIZE],
-			       sizeof(fw_tsf));
+			if ((idx + 1) * TSF_DATA_SIZE <=
+			    le16_to_cpu(tsf_tlv->header.len))
+				memcpy(&fw_tsf,
+				       &tsf_tlv->tsf_data[idx *
+							  TSF_DATA_SIZE],
+				       sizeof(fw_tsf));
 
 		if (chan_band_tlv) {
-			chan_band = &chan_band_tlv->chan_band_param[idx];
-			radio_type = &chan_band->radio_type;
+			if ((idx + 1) * sizeof(*chan_band) <=
+			    le16_to_cpu(chan_band_tlv->header.len)) {
+				chan_band =
+					&chan_band_tlv->chan_band_param[idx];
+				radio_type = &chan_band->radio_type;
+			} else {
+				radio_type = NULL;
+			}
 		} else {
 			radio_type = NULL;
 		}
-- 
2.47.3

