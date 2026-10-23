Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742664;
	b=0Ww3N+q22lLiavAKwB0j61AWqH/7t7ZTnQ3r4Uaf00CV8wnUNPGtXZcCPI2SbUvVhM3T
	 jideX4VDC8dEiu9nJ+EtEgLeZk7/YgEIV9jtxiSufQpO9UaOAnfNGV3GEfrhF0aVUgh74
	 h8Am+1E6zP7b16YBP67bFIyBrt0Es2pNRJSlXPmhEAbZCavNViZbpdXzmanCfbNs5J72Z
	 Zlbai0zQIcKfglUdRWyCH1hfrbXKaNQya0ug5Yu5OmQ3xokG8XKdD+R48RgbW9lhMWeck
	 wDkLc+qc+SA8GuROl3nufBwBeq1cC3VhVmezGLkqnAu1dUWEe5maY+f94xYj7gfZDhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WLdKZlJF/qGqwODa3vLO4RaXJiUN9yLH/ZRd6gD0w9c=;
	b=LM4JNjoui88T8x+K3GWg+vSrPpl9OBzBKwwwhPYqnA+13WmbCfS9Bu7P2Eh7xCr3I1Fe
	 HmVc9IT3TdpgqnGjhnXRVSDP9OIPm5gEZbk4Qfu+WnNpHkeeMCW2oQsgFnDvOzGPV0l1u
	 SU9hcEm1jLHo1KZ444iycf5DmG4Di3xP9x9xcFbr2ckJHFWtIkCUctbBlB3NemkD+aEau
	 po6TXj0hR585IJoL+dpMIDzJNFm0bgygBI5+IscRlc5yvNPODjxfXp3uqziGIl4+b1JBZ
	 SEGPyVjHg9sQjRXqokx5DAyR7H+s0DvGpkfTqfSsEgYTnF4BlPsKu9d/P+jpH8IH3wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=gI1vb59d;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FE606A31F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B8FE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=gI1vb59d
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df8fe8513so508186f8f.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792742663; x=1793347463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLdKZlJF/qGqwODa3vLO4RaXJiUN9yLH/ZRd6gD0w9c=;
        b=gI1vb59dtmQ94l/IVdwwWPUCkBFtkuNrVbUbbl4V24AArOCFrGi0zJxM57kLSKAICm
         7VFAJ10ToZXwGcwEIl+zjNsaWqdnGWw7OB55Kxe2aOL5oJJbHdkrMBKEn4vav1yaU67z
         moO6PhuKNaj0HsIp67uxELMWnKT5brffNh22EEN3zWqpdg2zW7C2YO8xdVFMT+cks3gZ
         tPzrZQSCfZ2c2TkWzkgSyTwDpeZbogCUr6HGZ5C7eXMGTRs15Jd2w9RRQxMv4j43EyAc
         X9KOjELmVlCpRdRnqFv8S96ZeHIa5NVdOY9CH+EHXUA70RZUcEPzAVFmV6UpmMM9LOku
         7wQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792742663; x=1793347463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLdKZlJF/qGqwODa3vLO4RaXJiUN9yLH/ZRd6gD0w9c=;
        b=piRKNp672CBGsQrG3ek5beTDCTJC0Ro+XTKas6mndDWPUWdXbkG6VOotsdnRmXTCqg
         bQ8VWelpQjZ1Ze/LuMdXZd9YkSPTSkK8dR40gd8EEt+x5iAwS7dxLzkxkxrY5DO5qXVz
         gV1lbpf6u25Ap2phtbv8xS/aVkzCY8Y/WZ5Ezou1wzFyyOioXlzyGif1z7cIXsaOO8g6
         OSzo/4FX2yZEjfga8iqSEhM8LS0b0lcPqIa4Ti4/yN10lu/V1DnvHxEE+BpU6e4Z9aY7
         7L75ImjLyPyPlCk8upQrdeaxM8FChDS+YXOOlXMjRShxSzZi10zEj9heMosR2A+7Vdc8
         FE7Q==
X-Forwarded-Encrypted: i=1; AKwUvBz9qZLtGxkKGT0CeawVeJ7XA+Mfs2v94xOvfBCB4qNbKTXUvhtTUCrItHzL3QcrpxPFu7UHnTI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJT/6WLRedgYdBf9hbHh6iwnIkOhfSLpiOOaT3OkIXvIlNACyE5
	hcE5kW+iPDclVpDdmO9Y9sm2CWzzXEz5Y5G4eR/E/9AGUHo7JNpbHUnOy0M2bG7l4v0=
X-Gm-Gg: AYBFou1Dl3YZZeERsI+bueW2T1jlT71uPgRYMGSiHXVWXnu2bkkr++vnXogWX2BnAPu
	3K99GS4DR7SLBaBL+2P+Y95UM7Z5HcusKX3QqeeM2bpxb4zw7/aIK3L6Ok7P8iYaLgqikzJIwQA
	Qle0HCZBIOFHe0nyPR+AqLLeVrLzb98TiY0JPI9poFfuUzQ9Sob4EpPXp2ffolqqCNAQNsKr/+B
	cDlNF1yBUj4hSMt4QhZZOgcBikOxWH8Ka7VI8DSeDPIWD0m3LWrto3weGI30Hzkfp4UHtSfHvdq
	MYIhd6B8Zky6pl03RwqSOKviM5ZkeAH0iXu/Ruvpwhmjme3ZgjzFBXkjMZVDeJnDHKsXt6MsM0Y
	HjkTG6Pe/rOEVQZbtkpalKokqxi66ZtUJFkRLdhV2YpHMV0j+qKxySYFegOFqSL4NsfBUyLnUOU
	IlCLQdYthUboXMb67b8dmo9UHeYGmCz0J2oVrpdqxY8JgglPeA0bYeTCSWBcIaZ1b2kssTbBLMk
	C6EfeGbnssYUXX5cZfdkCpi3X9b09d9otJnmtFBpiZUBFcLQ7/C5HFlvqsiTp/89XazUT5diExp
	beyj/WXuQZwq
X-Received: by 2002:adf:e00f:0:10b0:48e:2bf4:e7f1 with SMTP id ffacd0b85a97d-48e385af86fmr1524603f8f.39.1792742661906;
        Fri, 23 Oct 2026 01:04:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:6877:44a0:5297:9502])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3804450bsm3453867f8f.30.2026.10.23.01.04.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 01:04:21 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: olivier@mg-crea.com
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: dma-jz4780: Fix NULL dereference in tx_status after terminate
Date: Fri, 23 Oct 2026 10:02:45 +0200
Message-ID: <20261023080245.77005-1-olivier@mgcrea.io>
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

