Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453731;
	b=19Uz25hoTo555g1V20g6heaEzPrkfbJIexb/FgvTtrGSPR+nXTApstBclFsolXSOwB1m
	 IfAywFDW8DFXVritvQe4ClJToa7KeN3YBHYFbaxASPqN2WfQ3sQMVqSkxzydfVKB3XzxD
	 aBTVIZkAdcmzyPqTPFS7z6IDMnq9zuzavq2HePtLKsLiXk2afAP4YkOb51Ld7g7YaIzK9
	 x7OBAw/ijykumdTIO//r0PrMF3l9cYgzkD8vU2y0RoMKN7hLd52D/ENOCB9CrkrMqJr48
	 rpdSEqPtvAYLYMTW0N3W5gLsmqyBElFbs+wAjPWLdJmCkcdpOcVRkPTDzADeNpwaEow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jYABWeDo+AGiod8hgPoggERFln3qmx9KSSnUFrivFQA=;
	b=OX/H3+aad/9M9Eg9HVrK8A1TT98RSiWG1BuSdutxlRsRSz0t/U3dKz+O7y9mLAkCxu+u
	 Efw7CZmftrsxvyszjughXpSua8OFF1Grx/kZqeGJCg44bVr1h0qRDyIarMyDXBv64u/al
	 LAYJBD2gTRrjmm8U7/abCnx+cg7p2NO58krnpYPF0rWLY/a3LWxIqrV4p3bPHtNlO5nS/
	 PVhatp8NZu0QozpOSi2cHOoMhP6pJNmne00RL//Ia4GUk4pcKWUURFRHSn0W8ic5O4wqY
	 lsc6C7uQFQd+XlIS48ywtKy0B+FqtdWVy0jG1wJyB9KcJuJ2sD+fu8D4XIc2meURiFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mX4wM0Tg;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B3606A327
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 509B3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mX4wM0Tg
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5366ae57896so19227231cf.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793453729; x=1794058529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jYABWeDo+AGiod8hgPoggERFln3qmx9KSSnUFrivFQA=;
        b=mX4wM0TgZgY0LPbLWGS2TWIQo9dW6F+CNVQtMb4E0wYV0YYJmqABQFQ3n41d8lcMP+
         ZOf8JTOUJe7wwn9Gm8kVd1HHLlSQwr4dbqz/C56sIucLWkSQescmtjJlptUosOFxdZCT
         qE8NUff1K8EhMsxf3aJ1HFTEIMMFZrbUxtw1c5eZT9TEYojoV/Dda55eicgHuFh3rfpH
         oMfYNJU0xPNQLsAt/k6lSoHcDUCym9YL59D6Mz9b/Msvp5lSlWbZ6mOks5x0ZC6I2oAh
         SJ52DkkTGIb1fRtFKkDyKPs04rKsKJjw+T/665i18LO0eiUA8xB+DQzy5W1JAl3AnwwX
         ejog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793453729; x=1794058529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYABWeDo+AGiod8hgPoggERFln3qmx9KSSnUFrivFQA=;
        b=0mtwq+7nySKD0+sq36ytyEZAypCTf6+ZCSccFKDGCaAyUxMnr6KWfgZfUo4xOW/er9
         tDMCbnzoe3bx9c8BPFs27Vglymjp8S6S/xfkdCmxCZo4kUjmw0UsJvOc+GSrLGyzfY5/
         gIrzZVGS4O0JKjAIcfIpiO6ceXmofh8lTUA/1UwNCIF9H7JbrthgrwSoCtWGAWjjTUuZ
         fnLpnyHB0pKrqqdYfa+AugjmYpgpX16KzIXvDVSUHvuLqHOoU373isgGEwuRefZJhL1/
         alsohsIUPy8gv6sEWKjS4zKjEf3SGn+GKc7uUiQa5RrQQOpnNd0JqUQsSPjYwWxD2U6D
         KrRw==
X-Forwarded-Encrypted: i=1; AKwUvBygYDAKKc4tsopUKtihmMZDgaDBSnE9WWtxk3zSE9T4DAPC8qQs7zBfjm9pDA9AgFjI5rYAUFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIN1fGFswBlRsMqS4heNnFa5u2BKhtDDhw0dRmcyiECVplNTGfl
	1Ey6BAToSG/BIi/ZpvDcUx4PUloCgodePizjRqCk0mxF9WXZ0xjokbc=
X-Gm-Gg: AYBFou135gbbxKG4qj8SNVL2rWWrIbNBXXLOd4uf6Pl3sG+ZO4Dd92eYK6YUWAzaCO7
	gDxTCmTCb4EEDxMQ5Ptx9+oLwHf947gtuhGAWGb9GVqX6cVxKGZFUslCTp6ROrVSIyomg1vnqaH
	wjyfqOlSc/H2MKxCRDTNC2K8arRdGio4QeVNB7YHcBsb/EgjRu0K94sR75y9H4Klc54Gptda7IB
	MuInLa1XVx2d/Md8t1KfM77NcChDgzy/Ffq9/QG9tEx+ylR8QWX/8VRiN8+YHpphyJnqkpN8QhR
	7KySIOAwUDVlbOI1i8gwKSLjQ7LXYu2xFgQk4BdWr30h5j9en0vceE5nw90ylLSVozy2CeeRqA4
	toEzfraeHeMM6S8t4Xg/5JOz/WE/IJ0yEYjyKIsTIfAPmzFerkkrrTvNzV/FaYqFo/U7DuwSgqJ
	LNwAAgUNcew6GHYv5Ke2kgT/IrVuRI2OCwTk/qsxcZDuCe61Q6jkjkhN49rnEW0t9HSbGGRqoW+
	Bozdbvgrlr7fB/pKaQaoS6WsYpud82RxczYiQil0Vkapn68IcLpP1TOM+eF/Z6OTfjAESCyE8am
	bYqkV8rEkS6mNr5Xl9btX0owrEJ6Rlof4VKigIoJlbceYOOOEGbQlcT47aQ7CsPMoN4Wo6OEvC3
	hMy0mKIs=
X-Received: by 2002:ac8:5f08:0:b0:537:83ea:6923 with SMTP id d75a77b69052e-542b714560cmr82010581cf.34.1793453729164;
        Sat, 31 Oct 2026 06:35:29 -0700 (PDT)
Received: from phoenix.rocket.std.internal ([2a12:26c0:4608:9602:488f:ea65:c201:8ce2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75fd7sm38713741cf.11.2026.10.31.06.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 06:35:28 -0700 (PDT)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: pavan.chebbi@broadcom.com,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tg3: make depend on ZONE_DMA
Date: Sat, 31 Oct 2026 13:34:56 +0000
Message-ID: <20261031133455.3070233-2-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Since 614f4d166eee, on systems with ZONE_DMA unavailable, the Tigon3 driver
fails to initialize, at least on systems with BCM57766 controllers. On a late
2012 Mac Mini:

[    1.226623] tg3 0000:01:00.0: Unable to obtain 64 bit DMA for consistent allocations
[    1.226718] tg3 0000:01:00.0: probe with driver tg3 failed with error -5

Fixes: 614f4d166eee "tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets"

Cc: stable@vger.kernel.org

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 drivers/net/ethernet/broadcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index f0bac0dd1439..c9875daa043b 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -124,6 +124,7 @@ config TIGON3
 	tristate "Broadcom Tigon3 support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on ZONE_DMA
 	select CRC32
 	select PHYLIB
 	help
-- 
2.55.0

