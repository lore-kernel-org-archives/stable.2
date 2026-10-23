Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770058;
	b=TqSLiSzVq1zbr13+I0nHhVIxRkxWG8VnC3vnWGsVX1oZbU+TQ+xXLXNji8NDH/ytYYOg
	 Gb5wbBmhw02iIahYjJuqERbaP/q6QxCFAWzK7l1J4+vhSMEKrFP3kn3qB/uLT6ULrxYQl
	 Q43P9WMM53YJMvbEv7A5exezKhMJcKaH2CS1z3QnPGn5LBmaU2/hX80wUTiIQ/EBLW8JJ
	 LLYgi87/qU3ddsePfi+jcV8ghhWWxz44fSooMVhiQ7h1r8J5k2hzVT3v106GqiTLqwSmL
	 93qthnzZ+R4jpiYvZ6R2y4/BTUilVAxk2HgyqAdWFJiLVcWDWZprbFBwwvo9GdOD+1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=o1wKXpk8uaU69f7z5em398pZg3Sc//6UJ87r/eL+V6g=;
	b=Cv53nFKSsHRaHjlenI8iHlOAy6o0VtboqCUkFuSEzM9jXZtcYbp6pSQoba3iKv71Zt3F
	 LU+RvD2i1smPdg/4FzO0AQ0pokXzqQ0VDKodXCrJzNn+P+GEmYPgJrqQH52h5zh2439nE
	 IMxdpKA4/S44Ha9pV35Xloe7t0XPrqsShbNY3Luvdeqn81+oc9FjTMJ6PTmcBQak2rPOK
	 yCpx11MjrAvC6UD6o6hcn8JSLvYQR3OcvMRbAuHNPOtjfd4mDpexKcWFDKxSePokp3Ei5
	 k7EnpATKIqaPmcG+FpcUtidcmFXt3bAKdfScPzR4bzLvLxumWavsFwk5M5+JPnjPUQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DAJ9Z8yE;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4499F606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4499F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DAJ9Z8yE
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4a6bb779d13so553625fac.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792770057; x=1793374857; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o1wKXpk8uaU69f7z5em398pZg3Sc//6UJ87r/eL+V6g=;
        b=DAJ9Z8yEtaq0BPZ6unE64Trh3XDNZCSYilPyb3X4iAKNyWcJRRd4jOi0kTpAbdiJf8
         rM2C4u5iS1IUBNC62tP98vNNvakBq6qpiXXTKaHygQGJnQID9feSq4MQr4KCrZPYRd07
         4ck8s6H3X8SyoulVTL2hzltRMX0S03aA+H78SfP4hKkVTQsc7+4DgovqJ32IPmQYiKAZ
         U5Cgz8ovqSllQjjLTGBDCdpPNg2y6fYbsrff67RjK+dWI22hZhIGnFgrO8c/9W13PGzd
         9KkXnejOWBcyX3dpGAK5Hxc/NMHP9kd6xQzAtlb5Ex83jNwOMjAnrjmSA+5qNeRTlK/u
         Kd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770057; x=1793374857;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o1wKXpk8uaU69f7z5em398pZg3Sc//6UJ87r/eL+V6g=;
        b=LyyR7CoJhKZOAW0DUv5ya7uegRfefad/Yz0hl82AECNoU+hRLH3NZsASCzfG6nAYO2
         la2Mq+HtCBmsjS7JVvdXcI/xgb1HNQthCyhlsflH5T63xZtNoZatyi3h/8LMVhBUDOTo
         1evCdfX/0wevhiDaVA2eXD8WKn5aKEUoy6MP6RXtiIsAu3O86hVft2BVFCqBzyFHklbu
         JLwbb/8mWwYu07ay1Igjw+0JOxXHtpCIGxiN3uFsRxNO+bORhdUHGCg7ABWIUFadqyei
         SHrvsqFxPW2r4jx6tIiRm8978RE0XjA/1zCom8RqPKFpnzaEM74FA9LuMzBSDZGWyHRX
         ljBw==
X-Forwarded-Encrypted: i=1; AKwUvBz7KzVoFbyPJ0LoATYg3YlfHl1ii7lg518Y0l4fAnbo9w+7Ji0rF8lavABCFb/mqvOqSlHbwxw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEArSxNCGzm5sTBXIt3f5MpUviuqAINrKPl1zsNHT42RuqT3xb
	ju5oQ83ukVnrjGRjpKTyHY6B9M5Ypyf/qzLjQA9xkjFS5O0/9lJgg/ga
X-Gm-Gg: AYBFou0C5UNaUaFxJhgPXSl6n0yV1CcvwI2QY1QDNzqUOmdXohCWHGFFe4WKMA9j8tb
	UVnzmVk0RGDSiK0S7r9dHt+eGUDotpnfnOSTkMsWR7T2VqMJOxk6bzv+ljACdS0NVpU1YAL/uoa
	Y4aWeug425blQJWUwzKMBMfKN2EKBhA4JJ+K3HtvpXD1jFam94JD6m+Nh60EWmpLv9mR7mz3ZQO
	JIF/0XYm1tjmWQNwwN2erDQ7ZumUUe0nVBVPjZW8tTptZk+txXy0jdpq8WZBJ8HxIVETQ+nf/Cr
	a2qSkrZLO8Fik77E24wHzMjGpygD3kkygYsnQCixQ57NfuPpy+nBFdBtdawKmY0j9OrCstlEtwI
	38mxZUwr9ivFfmmzSYP6Jc0AmlXiMTROp9EeEpnqYhXULt/n39ZZ11Q1PCkhctswa9OWnIO2z7e
	LlklejyRysyb6Ws9DYcgQb1lWTRo8RrJi2kQKWLSm+gpBOm7t6HaXnYoDIjakLEwP4Nr5tncfw3
	Wr8v6pNWwIk6fSBPiR4GxbxApvkRIqEmrWBVdYZn9Qiq5AbvGA+A0lHkioE9JJGWOutLNMU8cM6
	FcwuTzjn0NiMNGEMQEvTD/0t+8J58bPEfxP6jTZMllczerLiwt/HUHIEclghhtJhT+G3eamU+ce
	IpKxqYuok7nYfE2cUHUpUyhZhfhDpVfJ0YpPAV6igsUJe4YOXIfU8umSVqo6l67WuxcplD4QAhr
	E2szXR5Ft07SQLXEbKvFXCeVko
X-Received: by 2002:a05:6870:252:b0:4a7:41a2:c208 with SMTP id 586e51a60fabf-4a821efc9e5mr1621601fac.8.1792770057105;
        Fri, 23 Oct 2026 08:40:57 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a838287e9csm351794fac.7.2026.10.23.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:40:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 09:40:50 -0600
Subject: [PATCH v2] serial: 8250: calculate TX length before preparing DMA
 flow control
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-submit-serial-8250-dma-tx-length-v1-v2-1-c3106ef4d2df@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WO2w6CMAyGX4Xs2iprIgevfA/DxRiVzcAwWyUQw
 ru74ROYthd/D1//TQTyloK4ZZvwNNtgJxcFnjKhjXI9ge2iFphjIXNECJ92tAzpTA1Q4TWHblT
 ACwzkejYwS2ifBZZYVhJrJSLp7elpl+PLo/npiHmR5oROG60KBK1XTpvUYl4vscDRwmlsbODJr
 4fLWSbMf4Zixqg0aV3VKq/rez8qO5z1NIpm3/cv81FP/gcBAAA=
X-Change-ID: 20261022-submit-serial-8250-dma-tx-length-v1-bf627278129a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The Renesas RZ/N1 preparation hook programs the UART DMA block size from
dma->tx_size. The generic TX path calls that hook before calculating the
length of the new transfer, so it programs zero on the first transfer and
the previous length on subsequent transfers.

Calculate the scatterlist length before calling the preparation hook so
the UART flow controller and DMA descriptor use the same transfer size.

Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Correct the Fixes tag to the kfifo conversion, as pointed out by
  Miquel Raynal.
- Add Cc: stable@vger.kernel.org.
- Link to v1: https://patch.msgid.link/20261022-submit-serial-8250-dma-tx-length-v1-v1-1-18cecc89a099@gmail.com
---
 drivers/tty/serial/8250/8250_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1da605cc8601..2dc47adafec0 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -110,8 +110,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 		return 0;
 	}
 
-	serial8250_do_prepare_tx_dma(p);
-
 	sg_init_table(sgl, ARRAY_SIZE(sgl));
 
 	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, sgl, ARRAY_SIZE(sgl),
@@ -122,6 +120,8 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	for_each_sg(sgl, sg, ret, i)
 		dma->tx_size += sg_dma_len(sg);
 
+	serial8250_do_prepare_tx_dma(p);
+
 	desc = dmaengine_prep_slave_sg(dma->txchan, sgl, ret,
 				       DMA_MEM_TO_DEV,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261022-submit-serial-8250-dma-tx-length-v1-bf627278129a

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

