Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623739;
	b=hPJ8LCAOe/gKFAjdn/ZfgWnbIfvKUov8IKj1iPzR7Is2LKheIYIaUDvFhf1VTi88Pb6G
	 V1w+Lr0IwTmxAw3zjTwtkSbSNRGBqRXKeSNWGPtdAGRaBcvH4wd0aXID7kpMNX4qsSeSQ
	 sMPCWSWmnoF1sO6M7OVKxJHY5CuxZSCMu/SjOon2+gimXoBzgLR8BKr+XR6J2efWPxQm9
	 Ci5ENfOGRSIDc/L34vJcawllpNTohOpj0YWpXnk41qEGS6TsGiBZ7Jiy08UJFaTqHgGw+
	 G5sL3HWiMkJVinSA/KhOmKH90ZUoza0lwM416BoOVP6WQ4nsOHpEsuDPIc8Xma2GXZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FHXKwfyjhX6mVoz3qAoilKz+1ex0M8UbC4u4Bj+pau0=;
	b=LcsYegsHTQRYZ8eUNh92Eb2T5M8VuYtUwN48VIRtzScAATXUJ1hjPsuySGhCvYOnyf0q
	 kYvLkDw2b0M/StVvIGA1hEWHiLS8g/ycmLUocbKM7lnocTpv8ixRG8X5qXfbzmsTgIjCq
	 5wlUqR2VAqzWbweDpSkvRQzTtFzV497js+CrCGerkl9gOoueUK7A08e39RpQkmPg6+bhn
	 U7goN3MSm4mrT0NVO9Z7l9HqYThZ04ArY2BGuN9xSRKkARzhcDFtnAHnvLr7u/O2gXB2Y
	 IjKszhF9aMcQqzXSrQByU09mIfjz/kjQ8RPl2T7/ezAbyx1pNSVx9d+y/Ka5sEym2rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=auizdsJy;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CE260A2602
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26CE260A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=auizdsJy
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df54150dfso1347180f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623737; x=1794228537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHXKwfyjhX6mVoz3qAoilKz+1ex0M8UbC4u4Bj+pau0=;
        b=auizdsJy9Ldf+7S8Yco2jp5IjDhkadRv9VqvTUgnZK2styt4f3erznGi6atB80o6pq
         xYX3KBYX8QfSqNbTKsowMMz3NRmyRZkmMNrkUXoMHOwYW0Z3K/Bc2sD1CWJiCQn8ts9J
         LWNzH8c/uhoMk74cWwNyp+Rfl4Wm5FSuF+KBhf3vJnGYcapv/xET46KEwc4Lbu/t97EB
         GK+G5/66dwGRCmvCRuYVM5hfmJciH+GYllsIMV7EO4XMcc+WVFMcUhBKbK6GCZJpIX9C
         uZUsglGN6vZrjHCgQvUQklmLOB5ogtTHHRpg4NMXbmHxPQAdmoJ+BwRIIvaBgbUZR10P
         16vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623737; x=1794228537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHXKwfyjhX6mVoz3qAoilKz+1ex0M8UbC4u4Bj+pau0=;
        b=O0pLI+9M8BLvYryAeEUug+8GKYy7cqlYKPhEQKaKmvxuQI2vltMwk6wSRC6li/DD2j
         gd+jrLgDsMNy3/OPf4DShe1Qj9iJU4BNy0GTu/ZAcaZ4f7uJkT929rCfsysiq4UNrPW0
         SaTFdWuHvGvqz0VXvoZuiEawiGPNDio/3eYy3TK6J3WLIeFNsDgXKJFt8B5lQpn+v6ro
         LiJvRKifMXjYg2Rnf9FOo/Zi+OPqOSW+XEl/wfWScLPZBGUtMHhhoKQhT7VWU8DgikdK
         OF3UFHIQgTAbVDTIb9D2hOVhXtWeQnnzf6mZXbZ7JBgf9DI3crBdHWTAwiW0gzPdWdM/
         Nsvg==
X-Forwarded-Encrypted: i=1; AKwUvBzXIdBotSACyrVthuEgp+3amE2HRkza85d/5oC4syz42GgjRlwZc0SNXhNltm+5+mm1/fsQB9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2f/ooWlXPSVcsIBlxoNbFctHI74f9np9k25ocPXXOz4UJSpvH
	roNu8rSV7t49plFzsrmrOiLfWG2m5zd5Tf10NdO3SUd2KAKDPQRiZEo=
X-Gm-Gg: AYBFou3NLTyEJNK3DnMjs2noqECHegMCByuKjrPhRnDD83X8SHOWZAija7Y88ibQsFR
	OcBSma+H3kSl+Pv77mZtWQ1CZnmcfqTS978+2y1UpncJjIewm3YjPTfkYesEcl4TEmPSYjilBqE
	tvscmqRMRRT1ZeX/ZvrqVfIiSGDi1CHgRNWfPwNeHfK4kEh+aHIRlAPAEFBfPOepHrsrNf1XnEU
	TBKArS+QqrXQxrI6AwBLC1B9TQUCWnM42Vg0pCK2gfiwHjcGNVDej+vt0ihDk9Upjdy6BMSY0yA
	/PDRcAXIp60xwzpTv9yrJ2VHgewEnCN090pPbM7GYXeqOK7Y86vfhrDAM099YfpL4XktLG0Cr0J
	bI2k1shKEhnbWTMulWslFBRG9IplKRezW6QDXHZtKsNvE/cgYzn9IlzCTIwzHTJ4oClTIqMIEXq
	qPPB8vBqSEAR7kXeKrKwbSyTw0VrY+k5JSLROMSObGHjTuZeuKABrCqcqIofq12xR21BOpEhsXu
	4ZQtVWrk90Rd3SSfXIcoMja4IY8PmCqdGHXQHnHDlydXmM1kNWizO6FDiHASKeAezsz+szjIA==
X-Received: by 2002:a05:6000:22c8:b0:48e:4831:ae20 with SMTP id ffacd0b85a97d-48e6e305b92mr23429203f8f.37.1793623737454;
        Mon, 02 Nov 2026 04:48:57 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm18719736f8f.15.2026.11.02.04.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:48:56 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless 1/3] wifi: nxpwifi: validate HE capability TLV length in firmware response
Date: Mon,  2 Nov 2026 12:48:52 +0000
Message-ID: <20261102124854.325979-2-tristmd@gmail.com>
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

nxpwifi_ret_11ax_cfg() parses TLV data from firmware without checking
that each TLV's declared length fits within the remaining buffer. A
firmware response with an oversized TLV length causes reads past the
response buffer.

Add a bounds check that the TLV header plus its declared length does
not exceed the remaining data before processing the TLV contents.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ax.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
index dc1e747383eca..1006b4a84de73 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11ax.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -215,6 +215,9 @@ int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
 		tlv_type = le16_to_cpu(header->type);
 		tlv_len = le16_to_cpu(header->len);
 
+		if (sizeof(*header) + tlv_len > left_len)
+			break;
+
 		if (tlv_type == TLV_TYPE_EXTENSION_ID) {
 			ext_id = *((u8 *)header + sizeof(*header) + 1);
 			if (ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
-- 
2.47.3

