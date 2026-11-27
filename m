Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770398;
	b=RnYgB4Pd0AiPEL9YKs/YkGNipRTq1erpSy/YhAg9+S48cjqiJOoQktOcTCL6+DBXrPPF
	 eby7bpfPbWZbXZqGIYcbD1UX6hVRtVBnMbuShTdWaa86fqRToDWhAJvss1Ckz/V954dwm
	 OC/lhq1pLvcom6VWYAncDqivA27aZQTVvKweYvpjblLuNJjImBrwW9HrooDQ57872Lnlm
	 E7TEg0fibxGv3F5Es3Src1d9iXmf2qMubAA1cNeoIcQwUfB70EJ9Q4YuezcED6dVmlu3M
	 ouQi155VxXCN4dzhuY4CUsQ/9rE30eO2YpIsKyh2tgLDqA57yWmGBuW4enYHFxsiE4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G3BGRngaI9F1CnRF4P/xvzYqrQvw8BmIKTivHk14ioM=;
	b=HoR2Yov8DGr/so8EYH9mWI8U7PaGUbFUVih75tiVyeC0tnApW+rggklVTKp5c1q8zQ6Y
	 4lkIdQR0jdjPN6yDTpDs75G48DHFrDkNgaNxuxJ3clSNzZ8EofR/kevMMRqm8VmxngygQ
	 TyyozalqeibLgRXydf2WDoSXuMsUDZQ0OToyCb64KcaElEbNCRU/pDS2nvXfPdlseHlwl
	 fjyIO9AbnDtHFiM/x+/9a7wCAOi9c3j+pKvOCzzlUJaV1oQEhsuLtdYLoSmNcV34JQB9c
	 vq0g6Fofsgm7x2QhdzNA/KG3BMmUkU0nQ0giJXChB79kQOHb/7YTN6NIrnnGRkQlb4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhXNzEI3;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3A606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED3A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhXNzEI3
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3863db981d4so11033680eec.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770397; x=1796375197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G3BGRngaI9F1CnRF4P/xvzYqrQvw8BmIKTivHk14ioM=;
        b=yhXNzEI3dP2Y0Mcui0QTwRlE1ToVcfBwZup6yfrwV0yxzQQskU5nraLUhrh015b4WK
         S+cH+vbAyzgj0H2gPQNZvW+StZ3sjYqmWOosN800aaq8+GvRdNaEwR9IbcbrycfpcZPX
         L/uw+zdZbHdPAhLigIVIPmqYZQ8rOB0kWoyahjGuusbG5bxnI8tQC1rsSXrc9YaIcYQ1
         ArprQH8fiR9psWu76MkybMVX8KpzifK4UQ6R4jMbViUCPo+h7NAZMq4JqdW7/pG/ohZt
         HDfHct5NfbQqEuhBHDKfJUj8XN9yFe1LJ9XShB1oTefxpPTGs+KtN9KH/80nz4ywhdSq
         9XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770397; x=1796375197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3BGRngaI9F1CnRF4P/xvzYqrQvw8BmIKTivHk14ioM=;
        b=ITMc9C0q8ENTNO5SofgSj2Zympr29ww8DiHr7pUoaVB1K+HWfNvPnvevGviRr+4x8V
         68bHJBpOBUdJJa/rlkRxREDesJIpjEw249LA5fHBFALLnvkQvZWtlrSKqCujTV4k4ERI
         0HNIbsvKsOEB0EYgoyQKANfZnfKdAhKg4f+ELUnH9AO3nkl8kU5xK5XlNmAvsR9Rh13x
         ByUfYXPPtiEksCd2TVX7gmZGh9mrFrTE1aVo0V0WkyegK3ijUF/7/j0hxUTADUv5oBaR
         BD51sMS2E5vZK19LtZG+3Z1wDKmfBcqZck37yZ2X8rG1uTISD5e87bSHNPy6JesiBGGd
         edsw==
X-Forwarded-Encrypted: i=1; AL+hErGnLiT1AscyAR0CTn6AUV/oRwQ9sRswGfr/QAvhdmx91acq9P1y/AGy0KMkrayvPCjx03JyjcA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UASs2dT/L0+6lwGhLonSAIY9aRNvmuX3G7UNob0grImljuora
	oowTpKEn1JwKQw1R74K1121sJIVUSvbgaG45oYz6RIrfCh+K7sHDOY126NnfVQ==
X-Gm-Gg: AZFdTZerT3PYoC/V46zkKAEwQnMvta9h1UW/TNrezd4EL5+MkPn0KjdZyiKt0NPKAg5
	HYA91KgAkH0HLxcGr6Y66f0f4gmEYdqac4DnzyxTHLow+6m7HKlyf3Bijq7Aicw8XBsB5qKoLTX
	L5nJgsEJC/9lRaop5l02sjuE1dfvaABMsT1Ofg1PQ/RDCFDPXY/rbXZ8o9rjsGfClaVAjdj/Rz6
	sI1qDgYY1EH0GMoH/EqaJNoUdcKfEisVzBS8Q4tfxhNd4vRqyNshdn577x0YgpVQrVzgOwFQLPO
	rYBoyT5k8e98IOaXK0vugX/0ukTXvUIKeAUJBTvwMxlVg4bYRF9Vfm2dXdxT3eCo21TkpleA+w+
	uqWWViFKR11MAFSAbu05yTC6XAwzdaqbdFRXbyUUJnJfrQpE2V4lL9Lr/+/nOqfrod2Izm4IVc+
	zUbktDJGdyuxSyskMbynLP340l5bexX+eYLh+RKmIxaUM7d2iwxlIrhyF4HTBnOA3GbpeyBwy6I
	eSK27X0bs+RO1zT7XFv4X+CDzacBAdjadPdPiDs6k2Ae2QKq8Pl9lmfLq5yhfo9sT+1RGSibMSd
	9HKJsWumTU/C8/VGHOnx70rgIz3l0nR1u6n1TxFtc8wgoH9E4n2/f8WaF1rS+WIvuCEN+4YV5ii
	u
X-Received: by 2002:a05:693c:60d7:b0:386:a01f:a31e with SMTP id 5a478bee46e88-386a01fa8a5mr20886475eec.29.1795770397337;
        Fri, 27 Nov 2026 01:06:37 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567ea2cc5sm64837608eec.29.2026.11.27.01.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:06:36 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: siano: Drop responses shorter than the message header
Date: Fri, 27 Nov 2026 17:06:33 +0800
Message-Id: <20261127090633.162540-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

smsusb and smssdio set cb->size from the msg_length field that the
device sends. Nothing checks that msg_length covers the 8-byte message
header. For MSG_SMS_DVBT_BDA_DATA, smsdvb_onresponse() passes
cb->size - sizeof(struct sms_msg_hdr) to dvb_dmx_swfilter(). A
msg_length below 8 wraps this count to nearly SIZE_MAX. The demux then
reads past the end of the buffer pool. On 32-bit big-endian hosts, a
short message of another type also makes smsendian_handle_rx_message()
byte-swap words past the buffer.

Drop such responses in both receive paths, before
smsendian_handle_rx_message().

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested
on hardware.

Fixes: 2e5c1ec8865a ("V4L/DVB (8258): add support for SMS1010 and SMS1150 based digital television devices")
Fixes: 319afbf97f20 ("V4L/DVB (11240): siano: add high level SDIO interface driver for SMS based cards")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/media/mmc/siano/smssdio.c | 6 ++++++
 drivers/media/usb/siano/smsusb.c  | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/mmc/siano/smssdio.c b/drivers/media/mmc/siano/smssdio.c
index 41dcab816216..eafb20a7c357 100644
--- a/drivers/media/mmc/siano/smssdio.c
+++ b/drivers/media/mmc/siano/smssdio.c
@@ -226,6 +226,12 @@ static void smssdio_interrupt(struct sdio_func *func)
 		}
 	}
 
+	if (hdr->msg_length < sizeof(struct sms_msg_hdr)) {
+		pr_err("invalid response msglen %d\n", hdr->msg_length);
+		smscore_putbuffer(smsdev->coredev, cb);
+		return;
+	}
+
 	cb->size = hdr->msg_length;
 	cb->offset = 0;
 
diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 0fdc2e0950b7..8c351422a6ec 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -98,7 +98,8 @@ static void smsusb_onresponse(struct urb *urb)
 		struct sms_msg_hdr *phdr = (struct sms_msg_hdr *)surb->cb->p;
 
 		smsendian_handle_message_header(phdr);
-		if (urb->actual_length >= phdr->msg_length) {
+		if (phdr->msg_length >= sizeof(struct sms_msg_hdr) &&
+		    urb->actual_length >= phdr->msg_length) {
 			surb->cb->size = phdr->msg_length;
 
 			if (dev->response_alignment &&
-- 
2.34.1

