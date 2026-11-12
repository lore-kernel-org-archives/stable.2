Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466586;
	b=IC+4eTQlUlbkiayXRlwrzt62ZmXug8KrOkZGbFEl2kBLEa4P+0T3GVO2zL7fGfGoOwpx
	 tMmUo8PIw9YjMDHcu/3a8OpuVy7bC1WsZ/7jwH91nvvFP02EGqGgwVfXdG0OLMahDddEL
	 uyOw0+Dr8dHt0vqKT1u4VQr3iVTQyrLhUgPxkRThggv6qxlDs8BRdz15cQMJ9gyB6VsR9
	 eH0p6ipU2evoYnPGxgwHRkErf+U94Xjw7zSdZ7RVdmAacjoxRFas+V7mYU6JyHFZDhXG8
	 a4zcl6oI2FYdEH3PXAB759BiPDLiVUCrzAeEv40ACCsq54uJOE5Zqi13SSc8Hxff6Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=csZSNdtphR4UrJionrHwtrF+cPcKbhAt8xmIfm2H+zw=;
	b=pZlIFrFg58/e40q3AU5bzZ6UpomuA/S/WjNMoxSYdUVITLB8JawgPmeoe0dR+petu0Nk
	 iSFu1lq12XCD6jWF6Fpl9nzeugt+rM2ZMh08zG5zAz7djaFC32UtHJNCWjf/inBe6tPYS
	 QK6/GVnAj4DBsZGUNJEWCDfwKsGfXH0d0XVR8UfBU833Ni8MIPmQh+Dl/1Qftgyrc2r8E
	 EYweH+Xc4DGNbF6EfmcuNyhJjwk6z4roZwAsevGJmWppwQ5lrukAivCsXK1/ZTK/XFQ9j
	 yxVTLU0HtKgCGwY70CT9Z7wA6s+GkyozZj88KVUpihsxjNQqV0ge3EmmksSpRS0WdHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="z/TJ3Xhf";
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DAD60A2612
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92DAD60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z/TJ3Xhf
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5569551d19dso6466731cf.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466585; x=1795071385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=csZSNdtphR4UrJionrHwtrF+cPcKbhAt8xmIfm2H+zw=;
        b=z/TJ3XhfSGoUPqhZUqv/zZmJ9HOGxzJ00XDyo9zsrUC4geZxxRviNE1Gku/8HoBFlu
         5srUqj87jFT+sAfQ76XHxWgzOMQNmmWzG39wodzkCZPLwPE40EgYuIwHvRsrp8HheZPf
         DdxXzAyjs8Tu200PkN/XLnzdYqgaUHMA6TPzQAiLrW2s7ITyDnu3+NubVY4PAV/KBWEM
         Xas2jOtk6DrhPj2Hh5PUN1pa2FoAeEHaTjSREcFqcX7PuvINg+b0ni1KBeMeuLTjCEdE
         0VmlletuSyAAiecrQWVDCD7ib4zQsK8DYTdP19WgRgCvg2VKi5J79FtmMxHxsLydvoXc
         o13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466585; x=1795071385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=csZSNdtphR4UrJionrHwtrF+cPcKbhAt8xmIfm2H+zw=;
        b=JPlTlF560cF150M0uHiMjd1g8zQp7vp/CQspGNloL4W7KF0QzJYRL+WW9cJun5RJ75
         h4kSssXuCe1BqXzXheD89LhEK0hA5nNSnGKrTRgJSp0t29TGysu8OGP7rWDhK+DAs05s
         iasnAbuaUOIBYMu6Gb7RAyLjYOp3md6GFmsS2Vp6ckd9NbGkdqJUUhAhD7G/RKEiaWkh
         dHYUF/UZRXPk0VIkjXPIxNwTNEluPFWUo9KgegU9qzKtYCBa84j2m51bykDleDeKBLib
         D96gh2gaA+QsEJZ0c1MY2ObcavrsLnq/BWSR/4jHwWj4Iu63WsTIjA1f8dlFVVEDCIu2
         Bb3A==
X-Forwarded-Encrypted: i=1; AL+hErFHWAfY4C+NrD153D28hP6kvWri9B4G20L6PdKwlHxqbSvQN+coXNoXO0jJdKC8pnQkZjYGic0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fTYjnRDqT2GTRDmzIes1D+1bqOKa6uwV/Hh3dw1tNP2U10uLb
	1BAqgaKyHSsApmEn60NKDbsBah5Gma2+OyZse2Z3RT+jEFv9OzKSrgU=
X-Gm-Gg: AYBFou1MYxoEZJVCkSKXBTajltJLQnfXWK0PvBJreLXbuavpZCLSwTtjzW28fPH+kp+
	CFkWcpFodlH6+t2vQjfM1XzIZ9gLzV/1MMLTCavyX57A5/pQrmROKY9wsd+M5Fkft55Ylu52Zdi
	aKoPtGChG3q0VoYutV3ifucJB7fUMzZ5VnWae3xi7+blSSYU7PSKG0fXDlPBSKq8mxGQUWUymAI
	IBYcckbJ47Dzqr0WzIGZ4mn2EBT8UJ9V42Cy7xeR25e5EZmuzYDf7QgjBTe84vPq/5++/QgtDUJ
	7Lfdj/0pERpV9JYFqOQExG0WbGbqviAqUlcq8/OCUQauGZzKYhHMy5PGXB9IrSsxYQTK7fNhqLt
	i0Oad3jhjvDFgGv/viFD0G5Diyp7qwUgHwmQL1izDm6zTNSNp8yFP6ITIilp8cODT2sx7IVF8nO
	SUQ5ulcFxw8rNyeUhwP0UxlTSJUdbyzz/comfsQyFQdeULsnxrVJwHjt5iiKsPm3kGaT25D/TGV
	oNzGieAvjsW8enzAscpw1edix5AMwVDjRTks7Ss3HZuNdRCwAKUdGZeXKj2hrZnsZQJgseGx+UU
	lhj0j6I4dqR05v5QeolthsVlJJDRfiYGoiPGVzay9PcyINQ9anvob6De6jFGVP0ZKPR56mRe6sQ
	3HvK/Tivr/7uvF3XiUKEnvjid9IE/LIBo/NgKnJ4b3FydMO5uXCjuAZ74TsSFeJbcRDrABW+ViP
	T75/HdPbsibmiQ3S83uVXg54dsHqvzQSaEp7COxBNbY6EpxlY0tBu4jA==
X-Received: by 2002:a05:622a:1dc7:b0:54f:7f40:799d with SMTP id d75a77b69052e-55956e5ebd8mr31073631cf.31.1794466585518;
        Wed, 11 Nov 2026 22:56:25 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef054f382sm64827376d6.43.2026.11.11.22.56.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:56:24 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: sunxi-cir: Disable the interrupt before stopping the hardware
Date: Thu, 12 Nov 2026 01:56:23 -0500
Message-ID: <20261112065623.34296-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

The devm-managed IRQ remains registered after sunxi_ir_hw_exit() stops
the hardware and rc_free_device() frees the rc device. A running handler
can therefore access the FIFO with clocks gated or pass a freed rc
device to the raw event code.

Call disable_irq() after rc_unregister_device() and before
sunxi_ir_hw_exit() to wait for the handler before stopping the hardware
and freeing the rc device.

For backports to kernels where rc_unregister_device() frees the rc
device, disable the IRQ before unregistering it.

Found by a static analysis tool under development.
Not tested on hardware.

Fixes: b4e3e59fb59c ("[media] rc: add sunxi-ir driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260729153104.3F6641F00AC4@smtp.kernel.org/
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

 drivers/media/rc/sunxi-cir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index e97bd9e03c1f..9d22ad7aa94b 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -374,6 +374,7 @@ static void sunxi_ir_remove(struct platform_device *pdev)
 	struct sunxi_ir *ir = platform_get_drvdata(pdev);
 
 	rc_unregister_device(ir->rc);
+	disable_irq(ir->irq);
 	sunxi_ir_hw_exit(&pdev->dev);
 	rc_free_device(ir->rc);
 }

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

