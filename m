Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657713;
	b=AmD5iufQwAEskFs8el8iiTbO8ys89v3Vft5FuGAU5Eyd8vGOnreVFjv7GJ3ekm4AJiRe
	 MMauGedVivedBSkUOxS/JXadWAlzm67gbOUppB8hHZM0KkEeVekVWDokwQXf+EAX6aNdy
	 w1c8abQVerk0JxlQoyScxM46hwn4NievHDcXPHifSuCOeFHK6c4+b2cTZ/xNB8gNjho3S
	 mL0TSEtIGOS0Eg/76a+P6LNUsd1vx3PMabD0j3nKtIpad1BpoeVp5OYxP+VTsONVvYGhD
	 C6ltdPtpBQXW/wqWAQG632z6R81U1K2dxWOpFXjRcPwWAJbYcBEX/mrvNvjUZsIJjiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DDDq9vrORSWbnT/BmB95bS2gOj2xanzImuHp41SDLD8=;
	b=TW8J9a7wTRKArNNd19HisJRMnyz+cJKxq4FRg+TmZVOpdtnvSEh9luzCfOKmjF5y+wFg
	 3BUZp6ufBRqLmwbwZEBOmlnU8lSZn9n3dyEh+wa0BAJ514g7OiKi2rszSeH78OZy27i5B
	 cWxkl7oGkRyGcdMgdk/Bq8g7/Y8CMfcuaP1EIIvYm+g3k6MXDfRVHZHq0OztFiJ/E2ndh
	 vXDpCHFOpqKXLeBLe6PoQKilXIDPXFNarCBPvi6F9EPhfx8+o4BFjP6OeD73r1pSki4MO
	 bNFHkX1mGTqECHPNwk8kT69P7SLLDV3ObT2XtpKC0wr2i48pnm5FE8ZdPmQM1g0e8Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=TokvcMKc;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24257606A32C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24257606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=TokvcMKc
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so1423659a12.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1793657711; x=1794262511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DDDq9vrORSWbnT/BmB95bS2gOj2xanzImuHp41SDLD8=;
        b=TokvcMKc+KYIST87Mai260x4nopeORdiWMi79Bv4kzPWRQ+VEYVkBgKM7J7ubgfMct
         EAUHAd4PTv1r8+90sVT307xC2pRCL993JZJfQlLMk2O6IzZh1NLpuneUl+BUTtg8XxYx
         /QTo1JyjHQrs21R11/IBFyP5jg0n9Iy6VouHwlbd7HPaMecsZ/Wd/mOSzz0t9MTSXdHE
         aLOuN4vTnqJnwHQIzjkLQ3OlWd9efODyiNk9U0HJfXWPInLzKqDV8kugDOiez/o1io2s
         hF/KO9aruPizc94q+0RDxqUUSB5RHH4v19BLqwrotuv1CHCNEUPHBmPNWoT2ul3T99/0
         V06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657711; x=1794262511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDDq9vrORSWbnT/BmB95bS2gOj2xanzImuHp41SDLD8=;
        b=bfgyqhOuQPortrJKSN4n/hnVP4uHDLFM2yBWGr0JFzxJYnmKfLB5fMiyi0crRaM/np
         MHlNDan6ow+Gj5eqmofvjKw0lJoSkJjKkP+ppXs5rAgZHckxtTPibX6U5I79UB8/CUNq
         9d2tLiKQlfaednwhgi/k7D4QD/T/dzMZ+3XZYqrAO2m4wvnWZ1vikRElFEVkfGeF2xDg
         ojcF9TXIyojYB3a7aDsCgyR99IUr0UB6SD7heqPD4yRV96wOVfYyVnePdcUNESv2d0Nf
         1cORRnPKpXQqxFQg05buD2Jhobe8kN5knzz73+t7QmpRcRHpYbRERnCcZ2+cJRDGvjsM
         tqKA==
X-Forwarded-Encrypted: i=1; AKwUvBy3Sea9yz/fjaTpMFsPSrRtYtpabM0YJwnA5agcRVGzgZCsZdVprQb8TrNkZP16GIiUUj29054=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ALk4TrcURoKp6jLJbl50seNlTintU9Mu6bfTdploWi+560B33
	J+hF38ges+Rjgea/WxCifIY29KQNlhgnVyPwO8gteEihRbUu8J4bXTBRUCkUmWFegw==
X-Gm-Gg: AYBFou1upSfDcVHCJDafH58FH791fZpqclaKBvQqwllmGsza2ZLiFg/ejbzLIU8ICAW
	kR2s7Wa9kWn0Nf8sdfhOVyzHhltEczbF9QuE0X2FoklHF9/YPRfIM/44SaYfPg3pu97E6TK7X4/
	v9Vbo6Qs9D7LHPwn1kqwHxO9qe3fH80+WDsGfg49falR9+t7TE/T4ogdmh4JCfft29l47/Q5xfe
	0wEA9FJrISJ9Dptkjn823ngwNxuOvBqlm+btqKQsrJr8MacGE9S8/QyT3jMCNEqFRJj7xOYem8S
	vmTi8YejFVoZ7w8hFy4x9X3axyza3KLwOdtgbvoRGgCsDlcbF+qaLM0pj2bLmF6phCyGjE6fI9+
	wNTJ5Gl/P17253dVphd3nkdS5n8ERfgRcTJz3/RAC/yOGSqXtXEKQ5cI5HoSBr0DUV7jq8B5kBA
	dvkfjzkUtx4pGOL8sES71j9iNPjvYxMts/BtR5UxzdlNyUJXLRfaLk/yd+k45x4Ik6bPzTxL633
	KmkqBdJcl/X8rIlohdVRx9mcXLG0MpKDV3sI/ZFmbgOOOKMtBJneDyrl+VC5LfPGPzISX22kvso
	3jSElZ6+ne3Zzf4fUL7xtZ+WgTgmPiwreSTD9cI=
X-Received: by 2002:a17:90a:fc4b:b0:3ab:b64:5893 with SMTP id 98e67ed59e1d1-3ae8981bf35mr8240104a91.53.1793657711239;
        Mon, 02 Nov 2026 14:15:11 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8b1913sm984336a91.10.2026.11.02.14.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:15:10 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH] rpmsg: virtio: Reject a message shorter than its header
Date: Tue,  3 Nov 2026 07:15:04 +0900
Message-ID: <20261102221504.175116-1-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
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

rpmsg_recv_single() rejects a message whose msg_len exceeds len -
sizeof(struct rpmsg_hdr), where len is the used length the device
reported. Since len is an unsigned int, a used length shorter than the
header wraps the difference, and every msg_len passes. The endpoint
callback receives up to 65535 bytes from a receive buffer of 512 bytes
by default, and rpmsg_char copies them into an skb that userspace reads.
The receive and transmit buffers share one DMA allocation, so the copy
can run through the following buffers and, with small vrings, past the
end of the allocation. With vrings of 16 buffers and a header claiming
65535 bytes, KASAN reports:

  BUG: KASAN: slab-out-of-bounds in rpmsg_ept_cb+0x4d/0xb0
  Read of size 65535 at addr ffff888002484010 by task rpmsg_echo/140
  Call Trace:
   rpmsg_ept_cb+0x4d/0xb0
   rpmsg_recv_done+0x29f/0x840
   vring_interrupt+0x32a/0x540
   vp_interrupt+0x146/0x180

Compare the sum of the header size and msg_len with len. The sum cannot
overflow, since msg_len has 16 bits. Move the check ahead of the debug
output, since dynamic_hex_dump() reads sizeof(*msg) + msg_len bytes
when its dynamic debug site is enabled.

This patch is assisted by Claude Opus 5.5.

Fixes: 9648224e564a ("rpmsg: validate incoming message length before propagating")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 23ff6c8b7a20b..a9125e81cb150 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -661,6 +661,16 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 	unsigned int msg_len = __rpmsg16_to_cpu(little_endian, msg->len);
 	int err;
 
+	/*
+	 * We currently use fixed-sized buffers, so trivially sanitize
+	 * the reported payload length.
+	 */
+	if (len > vrp->rx_buf_size ||
+	    sizeof(struct rpmsg_hdr) + msg_len > len) {
+		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
+		return -EINVAL;
+	}
+
 	dev_dbg(dev, "From: 0x%x, To: 0x%x, Len: %d, Flags: %d, Reserved: %d\n",
 		__rpmsg32_to_cpu(little_endian, msg->src),
 		__rpmsg32_to_cpu(little_endian, msg->dst), msg_len,
@@ -671,16 +681,6 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 			 msg, sizeof(*msg) + msg_len, true);
 #endif
 
-	/*
-	 * We currently use fixed-sized buffers, so trivially sanitize
-	 * the reported payload length.
-	 */
-	if (len > vrp->rx_buf_size ||
-	    msg_len > (len - sizeof(struct rpmsg_hdr))) {
-		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
-		return -EINVAL;
-	}
-
 	/* use the dst addr to fetch the callback of the appropriate user */
 	mutex_lock(&vrp->endpoints_lock);
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

