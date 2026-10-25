Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952135;
	b=BjO3adE4HPlHjK1vFXI0bW4sciuCQ1Dw4Utpy5ppNTXBfNKi+ZSe23K8tz+dXZxbqxRx
	 jIWFk4mWmbftN8E5+oWYxVrJWRC7CoYS1zTc9aNDub29inHyd/2+xZbhdKBe4/EHpqZdg
	 1rnLT7hZfG+hwfRuhRF1tBtQ8757DTHeAxTVpZQeakp2QHq2x/74LRH+ILbqJfbETWQv+
	 RDt6DThb7TzuU7LfaCs1hILFaXdsRditVrJc3aNqVGJRRNHNZ+pWe+K5nGijymmyHsgWH
	 v7MH2QlDoTAEOmF/0oefOSzaKMRxV0Tfxj23EpIVsxUkOyni3XHoUZQaWZ+0LGxbLLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=04oWWzfIpYNAPZyDmdd+igxHJmbJK3/MT7SSmprnQO0=;
	b=QlmLoztoYlT39873XeAyYIBcrh7Vnn8uHffHDfWkHBowI3Qo/+POvunU9odJTzBpUuWv
	 MM6Wsx77iARAldeqr0jsUGhbbvTtZl4OwS83ZW3HVmPLYjLcIGmOhdiHIqEb+8JXtGqp9
	 C+bdIjEk62F5j/TKeT4Lmk0PJ3n6ZIKTY5GLZeMBm2dllSHM/0yuh8n+1syxq7xpi5+45
	 H0uvdRjsId6uD4FPGlYwl4+FsVwvuLeXYmiES4MDYJSIpv06EumBtrlGYlKNhtR2pwUYG
	 TeKLL3fjVvFc4GrMlYUBJQby0OqlN0XrIu3z5LOJqWUcfLfqIiy9IniRyMRnQR4bQSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ItefY2w7;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E28606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17E28606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ItefY2w7
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48afbd2c386so1318248f8f.3
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792952133; x=1793556933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=04oWWzfIpYNAPZyDmdd+igxHJmbJK3/MT7SSmprnQO0=;
        b=ItefY2w77k/Kqn+lPWITcS5PXxUcOwecuNSjmwxQxuuPVK1Dk1Uzf7RgqufcqAlpj+
         Y5DQS5qS1u8yBmkgfZc4TRTeK/zv9x9fVCOXuEES3AeuXaHZ/erTJpXyKEEmRIMIRpxZ
         h1bYSRj+NM15ERmDza9UiiLvIuZ1OBcdiMNKoZz6l6cV7JgU91rCTsHOLirTiypNZCYM
         VdrhcTfuGkh+6/l0NogEc6ETClwPKjDrE7tjJiJ4fZYQdjLYswnKXUl4lMHtKkzpBlMf
         VFKLpkAvw1F4tzXLq14o74rRXMru+0AWVg7lMzmrDLSX1yxDCuFVTlrsJlJ81kkYmuIj
         HJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792952133; x=1793556933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04oWWzfIpYNAPZyDmdd+igxHJmbJK3/MT7SSmprnQO0=;
        b=Vq8sr9iqnbMHy9gP8fgnMWYw7mjGLFr/BeHZpm3NFERgICIAqrhsowHkzf3fm9JwvD
         6JVIN2Bh+choN7lTdNnMaehtIkprNlbFxhnIyrdEeb7uaOIie9FN4A2BTtUy59dPSWSR
         /kzopY67Kt6SiFYoz/j8zLMZ89J22iLgzemt7SF99WD9sj8riJZUGEVc/0VlALxQXwgU
         Tckb4ac5R1OdERMY5QwVpb1I+pK91Z2Zm24Rq4b/i4Cc49rz2XG5VjoPO7yeOGMgI7RG
         aXIEcK3Kd9WXUcVGnqsdOPPvVnwwiKTHqgC6zxnIW94KuYCnV+kXCzKhxt+nO+P+Kvak
         To3A==
X-Forwarded-Encrypted: i=1; AKwUvBwqPXgR0Gl+GNDtzg4nV3cbq1TyMsEOAmppDo/UXkbsDWzIqQXxKnEBbAbYvRdHoKLtj4oXoOA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMZj/Xr8tsLMS3YxCCLZR8albFf29wABWV01phiIl3wWovOd8i
	J2GvPWMPiVR7kSo0ABd8HsUEoSd6+HTlOqWh6kL8h5vB2q7RWiElRPw=
X-Gm-Gg: AYBFou3o1UKNJl8jTaVvwbfPTglTjRIBl+YKD5U546Rc9n3fb1NQeiuMWjDXKsjjxW2
	hv57eYPHzHNhUnn2R9F/zvsixv3YRMDs/Noqj2yZmnjmR6rtsRbzIcMUq/TbZ8nj1fZhsdYEZF7
	jMLIMJQZGlGtKu4w0FuaJFQS01xs3rnzoBM/gwZTShs2MaM0iwmnTqOazYEQDblqEGfswM6i/TR
	bhKUyKXe4VxNnIBml7+RFKhSW7kObErdxyAazTLY5FHItlvNumj02GJl1ZOtO6zrtJPy8Os+1v/
	EqqvhHmW8x2nvQZEnOpA3/NlTwEMrGtQ/Ox6fUKveWKtBAGi0/p3qoU96MBoOhk7EUdSQgHqIzZ
	00T3+Ndqezl+bSIlspy5HhQwo4fO6AJt9I2y83i74+YWNGonXqugooM16+V7QqFV9KU/lBzQOVl
	MRD60lMMrfhAgrq4uRD6H80XgRnTULD65hFBrsGFY7VMIdM3fIBd+PWIZXFiMZSV4qn+kIL3kl6
	GhGUHctgdDVImQYND3NQlByW0IJKHZ6ybQ+lw==
X-Received: by 2002:a05:600c:4704:b0:4a2:967:dfb8 with SMTP id 5b1f17b1804b1-4a35acb115cmr88717975e9.20.1792952133411;
        Sun, 25 Oct 2026 11:15:33 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a59d998sm143804225e9.15.2026.10.25.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:15:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jeff.chen_1@nxp.com
Subject: [PATCH wireless] wifi: nxpwifi: validate scan response TLV sizes before indexed access
Date: Sun, 25 Oct 2026 18:15:31 +0000
Message-ID: <20261025181531.3744345-1-tristan@talencesecurity.com>
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

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/nxp/nxpwifi/scan.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/nxp/nxpwifi/scan.c b/drivers/net/wireless/nxp/nxpwifi/scan.c
index 67d7ff2f10c59..304113b24e5cf 100644
--- a/drivers/net/wireless/nxp/nxpwifi/scan.c
+++ b/drivers/net/wireless/nxp/nxpwifi/scan.c
@@ -1993,23 +1993,36 @@ int nxpwifi_ret_802_11_scan(struct nxpwifi_private *priv,
 	}
 
 	for (idx = 0; idx < scan_rsp->number_of_sets && bytes_left; idx++) {
+		chan_band = NULL;
+		fw_tsf = 0;
 		/*
 		 * If a TSF TLV is present, save its TSF value in fw_tsf. This
 		 * is the firmware TSF at the time the beacon or probe response
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

