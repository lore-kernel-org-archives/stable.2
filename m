Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553571;
	b=UlD9Hv5Fq2SCv/bj9Icrg4s1mS6+vCrf9PmVu/IzPjN8l1ihtBMLv3Xe20pirx1nntX2
	 L2Q+oDaJNiZLROlrCfMT2DyMuv3XIgBVS3HxZ+zW54hZEUr+IG6WqxgprSMTrn8L4ITh8
	 uxHD1xWpnqGw3CTiUq3l0GEQnCrycXgwf30mjl3pIsTPbCaptKKmnUwrptxgfnnDO2oKX
	 VywAwS/ERxyO83N2oHslYd78uaeUfI3eaycRC9H+rE0MMorc2GpvfZmPFebYsMHjNdk80
	 R28L3ym3TsIXD5LdO5xp2uof11DK2GGGNbgoV3U36KCJbeaCdWbesJMTKbl1qq5EeHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Cpj2nfOgvWRfKTYAM5ppDFk5nmLpw5QMBkhfGZsFWC4=;
	b=SmvId5VlDCgkppEkv1ET4xR8017ToSZkZNKn1a+94IuVighPkFtQVeXvAvvyVPVEfL+k
	 IGfy8k+f8fudVkXrwQBEZMbwORui6YX4wZNv4oh4C7zX/w4g02ZBAHnKHmPlXkF9niyDx
	 xYeEEPyIbuqZLYi57yVMnXKttdT5Tn3zz4JnfGuqxZWa4sCjqbVcomU7U0674pAE5CM03
	 WrRl8vZY1oWXjmgow2JKKsVFI0Nvm+uYDs5oBeUl8k7OecXn47JoGuhEhUPFgieJKSqpC
	 PuFBsqe8EEYBU1o3ID7Yuo3m27GIDqXRUyxD1sqWlflsbBM6zeYRk+4L/vA+U3P8ODw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3FdHBBY;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27777606A33B
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27777606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3FdHBBY
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso37349495e9.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553567; x=1796158367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cpj2nfOgvWRfKTYAM5ppDFk5nmLpw5QMBkhfGZsFWC4=;
        b=A3FdHBBYQCtqltBpR0SUmc0Dwo+82qN4Dm2kSsCbhq1vyxVkqL4Tm82yj8ir9Goxzr
         hR/bVX4pqU7NReMiwTbPc6Ak8l6qyLh1G0YQvpisdH9xmOYXjz8vxwCVGTP1GJup0RAR
         od1V84iKS6AZO2at1zTZdtnzTi7wAjiP6i/1e/rGBg/j7VzyhdutCNGHprjKq8+qifSD
         XPZeskalqG1xm877qQnq0R4l4XZwuVS7v/f826uzFkhAxpkodHljdMaqL8DZjqxbFWRX
         WKWlb8PJaYTUXwPq0LkYJmgKhaHYv8sber325VgHr05y1vz2xIbjGPZs+TpcQ90Rs2Vq
         bSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553567; x=1796158367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cpj2nfOgvWRfKTYAM5ppDFk5nmLpw5QMBkhfGZsFWC4=;
        b=TGrZdw2t7GYzQB2cSJN/IRvOp4JunSAOtGAA3zpAjrs78khzNPfQEBAOPqnqNIMqZE
         rdjjVfC617BR4v9wLteksfHNvrg4tRYSIGrqeJXRS0Xjt341YSDoHdEGQr1InxbkYb8R
         nas7xmcpru+kn82r0XvQiRspupl4Hzc69Kom72SIdusm5YYs4rWRtOUFfT4HCoCnqS0E
         923xkWf9DrWopB0OyYqYNAunKMEgTVF8yBMbw1t5AqcHROnGe4+PBBvsgJnNbpVNahU5
         YJZ15aktJd5HeAdA5CTPCAj3Fkw1OnPKO1tC6YC62S73ftXILriMR8j3MO0UrE80mKXC
         xUJQ==
X-Forwarded-Encrypted: i=1; AL+hErGLtqTreHSLKsuK1LXXPcEPu312s3T4gF8XjoZJ/mo93vE2Ksb1nGN+AidVX5tTuaIBQapQ0eU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8S/kWmXrYa0soXEVFcdFm9lCZdgfe8TnbA0Q+nVF04jSLX+nPz
	gabxUzvblWGDn42qZRahIeztSE6Wcr5fo2gbdLLLg+kiL5TFCRivl1w=
X-Gm-Gg: AZFdTZfpZHj/7t1GcUubBA8rfihtYf+yf5A/e1sbUS/hpFOA1LgDyBYsIrd2ZArOnTq
	75evXLo2k4bkw5bVI1Zyfe6cnBY/kFOs1Y55NkgA/DVmB++7cnoMkfswWQnNCcyKpkHR5w+L2RS
	fUX+lHCaKNb9zb0urvHTK7YK9sdYvoYRWqpTS4iMAuJVSZCZCIjtbcvUA+ib5XaD+3KUMc3fGi+
	5gNXpJkDszly+sFYRBWlkWzTk9ZeWm1JBp5/J89lylaprFpfDvAN2SZEF0qa9XezOg+ElcGj6TK
	jDJpmUsCqJbiyuphbCKbYdQoArO0FukbzRyyBhZPz5bMSEKwq+kkjSx0SfaUbaPrqPXPIBMu6vZ
	SrUSMnz++bn3Td+Ys2vuCq47E3k2BHBBWRfpiOLJi65z5R8KDsXKd7wL/ACWth+BlJiSviv394e
	JzBmVSfoKkj7zzHNWkXCb44et3xEdc1FrEWt8ibk5+y3dM0HIrTsyDuYmv7dHTLebI/WlsQJVsu
	O+dJI4HWAKv03LnjUYfg1yLX6b+jSS5HIHTi3c6pY17WEy/KfsTxRuZDk4oL3NWNwPxaXP6e3Sx
	pmcSJUKrwwIORSg=
X-Received: by 2002:a05:600c:1d04:b0:4bb:685e:cc42 with SMTP id 5b1f17b1804b1-4bb88817e4emr334447225e9.18.1795553567186;
        Tue, 24 Nov 2026 12:52:47 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm666149315e9.13.2026.11.24.12.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:52:46 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless] wifi: mwifiex: validate scan response TLV sizes before indexed access
Date: Tue, 24 Nov 2026 20:52:38 +0000
Message-ID: <20261124205238.3531413-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The scan response handler indexes into TSF and channel-band TLV arrays
using a loop counter derived from the number of BSS entries, but never
checks whether the TLV data is large enough. A firmware response with
fewer TLV entries than BSS entries leads to reads past the TLV buffer.

Add bounds checks that verify each indexed access falls within the
TLV data length before dereferencing. Initialize chan_band to NULL and
fw_tsf to zero at the start of each iteration so that a short TLV does
not leave stale values from the previous BSS entry. Gate the
neighbor-discovery branch on chan_band being non-NULL to prevent
dereferencing an uninitialized pointer when the bounds check rejects
the current entry.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Chen <jeff.chen_1@nxp.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2: no code changes, add Reviewed-by

Build tested: x86_64 defconfig + CONFIG_MWIFIEX=m, gcc 14.2, W=1, 0 warnings.

 drivers/net/wireless/marvell/mwifiex/scan.c | 23 ++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index bdd4b8465863b..4c4bbd4b3b73b 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2208,6 +2208,8 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 	}
 
 	for (idx = 0; idx < scan_rsp->number_of_sets && bytes_left; idx++) {
+		chan_band = NULL;
+		fw_tsf = 0;
 		/*
 		 * If the TSF TLV was appended to the scan results, save this
 		 * entry's TSF value in the fw_tsf field. It is the firmware's
@@ -2215,17 +2217,28 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 		 * received.
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
+				chan_band = NULL;
+				radio_type = NULL;
+			}
 		} else {
 			radio_type = NULL;
 		}
 
-		if (chan_band_tlv && adapter->nd_info) {
+		if (chan_band && chan_band_tlv && adapter->nd_info) {
 			adapter->nd_info->matches[idx] =
 				kzalloc(sizeof(*pmatch) + sizeof(u32),
 					GFP_ATOMIC);
-- 
2.47.3

