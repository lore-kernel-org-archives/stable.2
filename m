Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793565537;
	b=gOiCMNqgDpMfjYaf2ujPy3hQNQVOYlAyglSh/j78B5WMs+me4dLGK4KaPhRhHwqKixyr
	 HbYdv5qjns+4+0LOVBJnAArwIxIwRjTJA/jeTKp/Y1vJB+UnbPt1ZUPqIJf/6mr4pDQmT
	 4zCKPugYxtrc5E+3D4vmzV7WR+BILq2g/+xs8Jtb6kMP7I2ZO7nG6bPWtU9J8gTiFvm4x
	 okBJQkmubAFlHSueEOlEt3thF9FU5d+Gesy3sTxC7B+Rqx/IQkF800roNdUyl5J9pXXEl
	 fjVKVz7jQD61pbiWvjiX2IAArtzlNhcsWCp+DJ5iLSAbolSKEoCoOtkcHW54LMMP9HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793565537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jyzRAE3eK4igcY55MYF2Ksg7aA4zKhF87ODiuJEPR/Q=;
	b=I+YUP9Y/8e7CLeSIJpX5heW4NvOF17CTI/SNST72A0untS+DjpRdmONv8R8PBzocgwev
	 7vve9krdk+77wjxB+xQ4gwmiVjXtshRAYoo3nhIl5TqYGjU2MnNgVu0Xi5yQqNUMtuFbq
	 nTWD4Oud04/QUm8EGcBe6F4TYhqzCjgJ8bbTO6vhKYy9BAD9NAng6Cy72fR3JsQCznC1O
	 93doFCb/mY60wPUnKKWmeWu6X0Rd6dWXhSWvYjfPU6rAMWc7+EKyw700yTWNx5tQDOx1Z
	 5M1U1Y0qLdvsFVIUeXtjjBmhdzf7hjR4tTQBACzSBAFKlYhJl0OEChgLEdO6+jeL1YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PC03FEVC;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA07606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA07606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PC03FEVC
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1612159f8f.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793565535; x=1794170335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jyzRAE3eK4igcY55MYF2Ksg7aA4zKhF87ODiuJEPR/Q=;
        b=PC03FEVCY9+mDRScSx3TojfR8X8GFQYMbCOOPfu/3nAGgTc+59IcJ30k2SaE23wfF/
         GR7NdmdauPwpAKdJMsfJ0A5hbhY4ugXncbfQLceVTHf7VTLMCI1OPreAj2YRtozObiGd
         1BT2xJ2XEWGsHe81vm7bgdi3QhwHOZMA83AJ9gALIscQq6DsBAcJNn3V2liBKdbON7jt
         xgXQFiYDEQFbIRWZKKzRTzhlwpeeQRiLn7S9zbniLPDDBPvXVNKErMPN+OtUBlA4TDmC
         yfVHxBVjy+jjz7nRNPZJkdld6L2DH/I5hZ/RWLmT+HhKLE1RGTqln7MTHKjl0iIbGwAk
         LHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793565535; x=1794170335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jyzRAE3eK4igcY55MYF2Ksg7aA4zKhF87ODiuJEPR/Q=;
        b=mMGtDUgYJSs9Gn+CmmtqdtrQ3HS3C0Y/a6BhzZp0FKYIkhWHexLQIbDm1hRbsExZ/J
         OIIAT+3AQ7LKkwNL87pgTVp6X/kW2seszzcjBfkscyEzN/2HW5e0WoBF2BlwEKOXfjQE
         ROfUhQCfW9mZTYx6xDLj1MegDs0vlyVNfb0Q1SzIYZ2gYRosRX7DOjv14Nm6Q8r96cul
         JA6YbGdUSBNhMVSOk0y4lGMFA/zdDL1R1q+kFc4Z2k3oU8IyY9qnYhoi29nLj3+D7vb9
         L9LWB0O1fyMnF5cUtg+7ufBDUQT0FQPL15DhPjXKQSygylB4AQfMqBTLBe1wAFnVO2ta
         BVVg==
X-Forwarded-Encrypted: i=1; AKwUvBxrEC2RiZJip+V8cEhNPgFGl7mnZJLY/IYm8wN0lmeVJZoa1g+10CTm6sTRqGYcEbpviJ8gZA8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+E5556Jg6raEDz0/toBET/siCyOUQncUm/eINHtAj3M+W+oFYO
	AgDPvpni7uPOSBAlGmG004lYZTZhZs2xSscWD0D/sYsvGHZq2X73zMs=
X-Gm-Gg: AYBFou2iavpt4cONEiitbPsbHgpFUSb2ouZlQRXi7w7PDFGefxfALlvCaw0Q6ThQD8w
	EF313jWk/LK75/RKAYxtqRCZKmzNEvKU4JSzn9B3IBbhtHY1emXMFRj2eQYNlQEgY4OrTiQpaQh
	WdsRN80Wrs8FLDawCD0xVmnK3FzhDTcvrxiQ1Gi1MC/bJzfqXIddm7triUO2lCGaZWfXnMQr0QG
	G8l+4cUI1Q+QMqd5ADiHJrbahz2R9QoZug4J8tznya4kK6ekwbcRUGYIJfIcJvlGiHEPJj4jJIB
	LBf6MSK5vSR8njdAayKz3AX/4AZGDU9BbS3+iBZ+2/LGZskZW/YbjeOL1rD5c0qRE12afhpkRIW
	dJQwZoTKn57Z+Kh+32e+xrFhMUy6l8dMffL4Y8BTY6CoNoOO13KhQiqeSDK7M+gGfTrpEvVJn+s
	XCJEDaII4gzlqgWOnZFLfsbQHAzj2WyPdOeNjN2l4GFPRCeM+qio1xMy6dFhI2+0cBU76+Z2jnr
	hbqYph3e3ffVdCXC7nMn0pEW9Tgzqs6UrKkrbEhyObOi/w6gf982W98zPdUHHRS07gIOTvzTudZ
	DaOtvk+kP5d6SqTvieZq+AImGmqCLV7D
X-Received: by 2002:a05:6000:26c8:b0:48d:f014:63ee with SMTP id ffacd0b85a97d-48e6e3040a3mr18060386f8f.20.1793565535266;
        Sun, 01 Nov 2026 12:38:55 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b72715sm15502295f8f.18.2026.11.01.12.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:38:53 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 1/2] wifi: wilc1000: validate frame length in wilc_network_info_received()
Date: Sun,  1 Nov 2026 20:38:48 +0000
Message-ID: <20261101203849.2807553-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101203849.2807553-1-tristan@talencesecurity.com>
References: <20261101203849.2807553-1-tristan@talencesecurity.com>
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

The frame_len field is read from a firmware-supplied buffer using
get_unaligned_le16() and then decremented by one. If the firmware
provides a zero value, the subtraction wraps a u16 to 65535, causing
kmemdup() to read up to 64 KB beyond the buffer.

Add validation to check that frame_len is non-zero and that the
buffer is large enough to hold the frame data before proceeding
with the allocation.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 60fe5f08964f39..46f71b6898998e 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1579,6 +1579,7 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	struct host_if_drv *hif_drv;
 	struct host_if_msg *msg;
 	struct wilc_vif *vif;
+	u16 frame_len;
 	int srcu_idx;
 	int result;
 	int id;
@@ -1599,7 +1600,13 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	if (IS_ERR(msg))
 		goto out;
 
-	msg->body.net_info.frame_len = get_unaligned_le16(&buffer[6]) - 1;
+	frame_len = get_unaligned_le16(&buffer[6]);
+	if (!frame_len || length < frame_len + 8) {
+		kfree(msg);
+		goto out;
+	}
+
+	msg->body.net_info.frame_len = frame_len - 1;
 	msg->body.net_info.rssi = buffer[8];
 	msg->body.net_info.mgmt = kmemdup(&buffer[9],
 					  msg->body.net_info.frame_len,
-- 
2.47.3

