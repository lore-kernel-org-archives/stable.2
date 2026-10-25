Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951894;
	b=HOzNh8kvI1vFNji7Iw43QGDbWXWC0EsgQujZB4LfyTVrj9nDELBUvb/j5u+HStRbVAy/
	 zEcBDqs+hY4BqddtJ7agluNHZD2y22E/8HnFpotSiNoJ60QZn4mHh8ehT28F0tgH8e72o
	 /Mq05uKiHHodw1GqnJnGnsvAVh0CzVhbWEOmlMEysSwWxAgCXtK80ssh4jyCFDtXYd8P+
	 XDoeD5imu4NRsnuYEhl3cnhzdOeKR49HhztNHg1ZggCNNdroIoh9iilQU5jLZ9FlO8Wqz
	 JztVjO1KhZn4gZcsrLP5dGKxK+IAsuq84H3zgwS8QiLVH2VyuuTfFSD6EQ6TywhziAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9WjZ53v91Udvhflq6T6n2CXMPqhGqv+vK8tOndZRFq4=;
	b=NntPMzkSMnnSZXH7ABoJT4eo2xCpqWbPKZVEpBtdiaoGr9NKm/niRw6A1fBLA18KYl52
	 /QWl4ghZnhuDyDsp/SgdGFjBhyjr+DGh60x51OfgRoIB6eresTORuFV6asyFlrYGXFqbw
	 xc8xjDiMJRHxHgp74Zf4M3KuD1TpDU88nbU2LWVgo9qdXOl0k7XEot64hGMIe8wPjcFS8
	 KS0/9vJ++a/ldXBaHVQ+blesum4TtOyiKVKc3B4vj9MaZExyXCMZb8h661BqfJou4UvVw
	 OUOIRGtsNGM0gSeUkHXJYlHpYc6+Z/AdQwNrk3QDRgPh9f4TXpWvSnCdSwVyWZHdGuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GPqgI25X;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453C606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6453C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GPqgI25X
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso23911555e9.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792951892; x=1793556692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9WjZ53v91Udvhflq6T6n2CXMPqhGqv+vK8tOndZRFq4=;
        b=GPqgI25XFIOUIFfWoKmMCvrk5cFUmTbN3D7T+zxUCZKFzIUj5qgVISTCWBCCSZ/JD9
         413WsihAwqO1RITYGxNBoXS+AjxFnRv2IvxW2wUQ0h2FekFtk3DGccJddtacCoNXHHH9
         mVF2D127o5jSz5IvhxJTpp9/F6uBYURYDJLFza4HeDm1jfD6dvunn8InUErpOf3Rku8R
         oRzI44pgSrZYmRq1rYCvxDT/i0HgO6XJkjD1cliD2+C0Yo1t2fPpji1fQ3dE0JjYACO1
         uWPDcsq+cZtNTqyE0LIj2Jl+vRDgnJU1YnuJrwcJjhpDz9z+Luj2YfzwdC+d/IOlr0W3
         IWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792951892; x=1793556692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WjZ53v91Udvhflq6T6n2CXMPqhGqv+vK8tOndZRFq4=;
        b=pR9Af3O5bWVtLlr5Xpp7NJCCLil7EJLSWauMScEgJ87YKxmiCQatx9DS8yGikkPc1U
         ZAh34BAffzzbIS/XFKFMzUlCKSp+IR0lMIjllIzrMG+W7oWzXrs6Uhd7PYUJ5KDQnu+o
         CLNJ8cDXl9h4gxrNqX27p+3Cshd8ZL7whZasrjgTSP5jwGf2UfuZDwMfFZpcxkN+Lmy0
         cC02+AhEovXRXaJKH0aHfL1mKYWfpVuHlm95unCMUr3AkmSu7o5ecsobJTBqoeRWGi9k
         BEE5zC5MEotc63+qvZglJTiQgRclZHE9rFb/2/dF1y6NIx93dgubLA1u5dz8V9ypXQhr
         wSqA==
X-Forwarded-Encrypted: i=1; AKwUvBxnufGXIR3RSqTaRWp+r4Qczzu8xWxY17CmaLKuLbCFUyon3lE/+TjgIyFglPh9cjAW58CnLMw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoJLTMtQItZbMJ2mhhpIbaW5FZJ6h29XI4d/cCh+OYMPYiLYCz
	Oy0ssLkFCpXcfzNXk8S/2oWWAmrokReMEU7JVTem8y+YlYqwnXiJ05s=
X-Gm-Gg: AYBFou21krNoJAk2qVgL8MQ6hWaSUyBqlFeuXNolIf6j/lGrG1vWhkglv1yIRO/ovKd
	sxzm6juRZhYcGV+DLSloV3jNAXZW3M8Lm1tymBol82fJ0cY0wNye13aP2bdGZX/5swxkJ7//JCJ
	isFPKaGC6R+x1JSqB/+zVmIWmxB4/HHx9XlFAbRKdZCHmQFAJrAJz1l1r/AVraoUmYn8fK1jQIu
	iriqyXg4FT+YH1AzITC+wJYFFxQU77s+nAnxdnlcwCJ/IEbfKKzmg9+FQ038BBlrbZyE116gCX1
	uHuFRaFLSSFSqeSRtnzatmgJl4rApqSkrg8EvhNFGFl1jBkP9+dnl5gxRmoDUzoM8FVEw4dBShL
	g2MxgrxAS5PFx7dlzOBZRKL6LN/7F/RCKxupvNtkcTek5v2zji5yWqqRmwb3Fo/vUUlmVKKLiRZ
	moU4w7uUXsIYxPDb25aA8DpNQfqjr3d6I3kQRLM8ggXRMxU4NzlHcXBx7CFsjD900dHWOn3+bS0
	R0aycggkaXgkADYKXZ2ZANGQRp/p4GM5OFpAA==
X-Received: by 2002:a05:600c:6749:b0:4a2:e0c:2b10 with SMTP id 5b1f17b1804b1-4a35aca32e1mr76300305e9.19.1792951891663;
        Sun, 25 Oct 2026 11:11:31 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa097sm152124885e9.3.2026.10.25.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:11:31 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	briannorris@chromium.org
Subject: [PATCH wireless] wifi: mwifiex: validate scan response TLV sizes before indexed access
Date: Sun, 25 Oct 2026 18:11:30 +0000
Message-ID: <20261025181130.3711823-1-tristan@talencesecurity.com>
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

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
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

