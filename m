Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742618;
	b=BpOoc+cUZvVYjQ+OTLbAP2OpTC4Q+z3H22BvvUuCTKQeZ2b6E0FRnXqHc5aNlzlEKiSv
	 2U6RAvOnqdS8hVjN0j9tSh5LI/7D2Qc+32Bq+hhOHyjcGdHThiQO6cA4WLv9UPysveYwC
	 zsRwS8FR+VCPcU1ykbKANVmE49hnrXC3NRb3iy9JRTUL6MCKX3gRtnI+S2FDJqOG06OnZ
	 U7Y8JswxFkm5HTGo69+sySiJYWax7Y5j2gs1qVToqFR9BXXlbGZYU7e835RwB3v0F9IIo
	 ujv9nf3Pl2dvbEH60YpJYy4d/TCbiJXds+6Iqy7O0GNk7WNQQp2BOJuArJKtXLr9I4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WLdKZlJF/qGqwODa3vLO4RaXJiUN9yLH/ZRd6gD0w9c=;
	b=nBEjvS64iNDOtwLjRENW10U93iJx4GQBsJGwOWIe92hDfcsdQ3tbwwCfr8AIIUpEpl3w
	 ynsOAynmJJwWZNJyFikHMUMdUEN2gjOZEAQgQf6pdaM8uHWAoANIzHhR4ujCTqDAfr2vj
	 Qfe9TQaMZsadBEK6K2CU7On/gyvOzDmCowKiRiFCMkgSJhWViRz61rus0fLk5ChQkpND+
	 lOuNHB/bm7nJEwe9zbqqh6NFz7RwBpwfOjTGsRZT5+JpvhlcbQn/5InGlp5nVHz4jl9cf
	 43+qouQlTNZdpBvvWROeCQPBrVHBiN8VXVtTfY5p6HBrL7J03kIhuq6BrTpwZNcdZ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bpuzOY88;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13456606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13456606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bpuzOY88
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c45111bebso285306f8f.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792742616; x=1793347416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLdKZlJF/qGqwODa3vLO4RaXJiUN9yLH/ZRd6gD0w9c=;
        b=bpuzOY88MEYCWNBSNSsqKsnFeqX8i/maIhBv1GYRR2s4wYnt3/f9z2U4UHVHl8Xp8C
         ItZs7ne2B/WFN/6AbeFlvmOQF2h/LfZjmIiqSuwg/vvFiI9WnWQ+yuTcE+/cbrBDtkwh
         S4DKdRyi6t+UzEjTVZpOyKm/awo5kmIgCdEbGKlfxKB16FfwXx+sBB/FT0BZyOZITR4S
         NNodavNpdre4CCO9b9tp2JKY+PrR5bsNOxcJkt3ww9ph77ncEebbGi8eiAoyqoE9WpX0
         Qxotm2QFwHIIxsGVc7D1bSmdSgWpLWDp56HIZad2tV5AtFipUZBH2bKVyqFqOedNQLQ6
         3HMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792742616; x=1793347416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLdKZlJF/qGqwODa3vLO4RaXJiUN9yLH/ZRd6gD0w9c=;
        b=C9XzDqdbDLBxzFHMcYGOjB5u6EPH0FGJ2q6m5WUGZvF9Af5A7gAj2JKBmHOGPDDcsx
         m3HIHm+9MzHILrOPGUmMngoa7cwvwbVIxYrAGySdPgPKJcNXXfpcIavQPM1zz/z1PKyc
         veSAJtgJmR9CsEdXoFqYQEs6adbDApNcsIFD+4Mij8SskTTRyPO7iV9PlkTsaFpe+76S
         kBhkox8emG//S9J//EQnMepmPrHyL1tcFEwTVcckW3YYSem6qmTEqXq4KFDHusP5S1gO
         3inOOa/CrHIuRRrtgozRtYzFW9TOy1WHcKbDN6VjtFxzcyoBMPpbm658vKx5Y9Cyq18O
         t3sw==
X-Forwarded-Encrypted: i=1; AKwUvBxRD93tNdYU1qRQ+ZnXgRkFHPG+MnZukSIXEKAC+xIMEq7MyL6xHFOsGxYoTW5z5ZQOrF0LKNw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOtSp2kjmfCr+6/cr3NBRww9J85nXELySviXui+sb44C3kUrwU
	9I/lRriOhDKNO2PsGQB0+z+UM6CSlPZ78mb8UZQGDmsksiI8emH12WU4o56vjj/LzZc=
X-Gm-Gg: AYBFou38kQPazJ6MbIIe0b85yC3i7r3hDsoT78BmMmMuZRfBxa9VNkF9/h787w9y/OE
	LxFMrkYyPxgvLSLvK9gPc2FmF1a/cQDoHjKbvk6wu5TxejjieaRvLjgS1uZEJUXMwJsshdO4q9D
	T/uUlVz8Lyx5Wr/ssTTpI5Bo11LDRosbsEG6ve4O2xBGo5USfLcQcuOV7/DuSWnCAiSFnIPt568
	5ATaBwyrSek1MmEonzQ8suchv3RvkNkyd5uP9cvtjyZ7uiN/4bNSyXgkdpGJbefjPgwSxZBKVFr
	8XE3Ohf5t9UeqeRfUM/UojvjiKUQnqoVM8KBsxGSHL4Scd6BdI+9TxR2GZ4HkPoXBj2w9EAWKw2
	8wycvRRaob7tKNh2XXIFvEVOGp8yA95owvFoMqXs4+7kosavKbKE9P+A4cqLGoExJ4+3yJ+ZhtZ
	gy/NqJule/dKkvlB5in0Y5Y42jFrkFtYmz7E5gcrUEPf7mMmBH2ScM4AO69BvwlytOMKk50mnCB
	JZN+3iIw3PqaNDeTJuWQH4R8yA7rN649cjTVyn+CD+5DUTf291Aoy9FWGC7K77zo5qMD2/MrMqA
	YLWWSWdkBzIPPx/k2tkKqxscyTNsOiwbDA==
X-Received: by 2002:a05:6000:4b0d:b0:48b:f08:8162 with SMTP id ffacd0b85a97d-48e385a5de2mr2189976f8f.39.1792742615381;
        Fri, 23 Oct 2026 01:03:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:6877:44a0:5297:9502])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37eded3fsm3390163f8f.7.2026.10.23.01.03.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 01:03:34 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: olivier@mg-crea.com
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: dma-jz4780: Fix NULL dereference in tx_status after terminate
Date: Fri, 23 Oct 2026 10:03:33 +0200
Message-ID: <20261023080333.81524-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

jz4780_dma_terminate_all() sets jzchan->desc to NULL. The cookie of a
cyclic transfer never completes, so a later jz4780_dma_tx_status() call
with that cookie finds no descriptor on the channel's lists, takes the
else branch and reads jzchan->desc->vdesc.tx.cookie through the NULL
pointer.

The driver has always allowed this, but it only shows once something
calls tx_status() on a terminated cyclic channel, as
snd_dmaengine_pcm_sync_stop() does since commit 88e98af9f4b5 ("ALSA:
pcm_dmaengine: Don't synchronize DMA channel when DMA is paused").
Closing a playback stream then oopses:

  epc : jz4780_dma_tx_status+0x184/0x210
  Call Trace:
  [<8048e104>] jz4780_dma_tx_status+0x184/0x210
  [<805804d8>] snd_dmaengine_pcm_sync_stop+0x4c/0x94
  [<8058f068>] snd_soc_pcm_component_sync_stop+0x80/0xc0
  [<805775b8>] do_hw_free+0x20/0x6c
  [<80577650>] snd_pcm_release_substream+0x4c/0x9c
  [<805781ac>] snd_pcm_release+0x48/0x9c

Only compare the cookie with the current descriptor's when there is one.

Fixes: d894fc6046fe ("dmaengine: jz4780: add driver for the Ingenic JZ4780 DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
Seen on an Ingenic X1600 (HiBy R1, compatible "ingenic,x1830-dma" as
fallback) on v7.3; the code is shared by all the SoCs this driver
supports. The patch is build-tested on 734bef548a96 (v7.3-7363).

 drivers/dma/dma-jz4780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 6070dfdb7114..7f827be502f1 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -658,7 +658,7 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 		/* On the issued list, so hasn't been processed yet */
 		residue = jz4780_dma_desc_residue(jzchan,
 					to_jz4780_dma_desc(vdesc), 0);
-	} else if (cookie == jzchan->desc->vdesc.tx.cookie) {
+	} else if (jzchan->desc && cookie == jzchan->desc->vdesc.tx.cookie) {
 		residue = jz4780_dma_desc_residue(jzchan, jzchan->desc,
 					jzchan->curr_hwdesc + 1);
 	}

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.39.5

