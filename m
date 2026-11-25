Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607482;
	b=BRUe2LlEiaW+OiqY3dqn941//Trd0FcevPesShYoGpEjs0ekz6rzyEZ1iVKYjz4Nb/zo
	 zrJAuNgRoFWL6kg4XSb7xJ01XgxzbN57raOlNFGnGPa0nBk69oTSE19TI1lW0STQ+jbsA
	 X4IrcXJlBa5+3HsKLuoN+ilEOUQpaog+5J4qP0xiV577v8VHl248ubBkSGyyP9RVTAMHj
	 NsLyeYvErVHiG8pQ78sYNuOTW596OWy6b/TXzgjO2T6vqRMpUP7yyNxApEA2NB5QLHLcO
	 /0KGStAVRrG1w+AMKYz5gPinNp9AaTiUllCHbthKm6gobZgMnRRYvY5SGHhPF2EHA5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RkancunSX1kzbBE3OARY16RCkvG9MfPLza4pw9wRR9A=;
	b=RywEjyrVkDOYLJ7MTxptTUv46wTZ/554msJa4ihDvwtNLBuKDLhOHxbVI2GNAIc4wqFq
	 HKLk3xgLPCA9VgHjlUHCa6WKZSl8UlXdzV+HsEb29bf3HQ9BgyuVWB6StdWYx1wKlVNqO
	 PfcxNPIh3T9YUgYeBUGWzvrEBPO0EO1uObYu0BrzTLy814nhr7hdDe4i+o0fs/gRmMC3T
	 mIz1A/mkdTDXcPNZ1KWz2O3+nqe1bc85DQvQu8rxl//3mNqgGdPhrI0ZMTOSgkn9yHiUv
	 sDlyHbxRO6UI047Swz4RS23YoYxYttpvI/ijIfq92dE70eMxcY/pNE/oX8pHeOlWseQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MkUk41h;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F4E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MkUk41h
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cde7e8abf9cso1903759a12.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795607481; x=1796212281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RkancunSX1kzbBE3OARY16RCkvG9MfPLza4pw9wRR9A=;
        b=0MkUk41hFDV51LDY+sTYDDivcAgvstp05PtjWwqhg7MO2Jy4HD9aeZwGMDYQWU8NQN
         w0XuqdIUJ+gOX7c1z8wUd/iApgeDp/CT/7aXE7a4QwCa1bbabNGs1YHIPlu/hX4HhTg4
         oSpmnUY0rZjOFUUVFf2/L4ZKbaWQjrtZkiv4OhwU2sty7B0OKNpz6u070oCOGsg5sBG0
         Yew0Aeju7E2X2GHx0yRFtPQtcZS60DnKJTRA5DRn5W72AFcYAz98YCCHYuZTYqwfmpCI
         iSWb+4UkTHGpqZIK5262ErC0A2c2m2hhCV0EoTQ39h98lFVIumrtwQqHT9EmvLxCC/ry
         qgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607481; x=1796212281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RkancunSX1kzbBE3OARY16RCkvG9MfPLza4pw9wRR9A=;
        b=wgxHxNEPWYb5r+FMuviafZ6fNbsrp5HUs7UK3Lv68cmE1mESeFJ3EVNoqqR5VM9Gnp
         jkRonGAt4hfcVGQM/ThMAY6dh67FlYYxqG6bP9lyEjszu8pUY8MgxHvI0obg1Cp1D0wS
         pDeTPMB+iKU7IQsUvlVRKGYDTgmW5vIMFCtFnc3OcfBvVUd879adXMpJQlUqg4ryq02p
         axHh+2D4W7GwYAqmkjHS4euXhccYy3/dpv1k6kGKiUURyzjpv8Nf374fh1QBs82/h5Gf
         Sc4QTSYLUXzZkLM1nNjOYl9BBUR0Qb94r7UY/J0e1hUJtCELQoTlBHm2RXxksw47wKZt
         4Bfg==
X-Forwarded-Encrypted: i=1; AL+hErEmhXI9RJhAjYpJ0vxRXbXTnNY4nnaLS2TfZZ4kvXTk4rBPlSI65h9VneEbV07ya75/5VEtJ2A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TsNJ6Aswakh9bc2wJLTdhFobIwzT0uu2bGPgprDuKDIYZBu4b
	EUmw2+GpEDtC+bUP5SLrer3G55wBO75bKJ914CkL4TkkiYt9q6yuugGb
X-Gm-Gg: AZFdTZfAKvfTQxKwrwtRmPUpMhWkcIoCHc43wRmgSeHhJ8tevlsPFOE5i3QUPmlPhsl
	Hn1QsW4jRqhX7doFBCY7P6TcUa5EhCMU36aaTKaVlf7BiH/S54q0UK+Rxv1oct9XVN1SjpbpLpI
	hOn4oS3ZsdXmIEbSj9JoEhG3UPBpxAUPcq7nJP7sNTs79pSwvxKHuM2w1uk2PkBtYTJinw1WIv9
	YgRxRYi2NsHGRFeLpVlPTv0WZgXUP0BmK9gQrOsF0VK0MtcsgO8P31umEgwkX5s8cO/i3KtKqMq
	asxLbT38zJQkCkcuayHwPEB1cTXPZSAKQRgJBTch0ZSfsF7x/BcudbghM8JS1WMyiWMx0atM17r
	OKmhIL9n3pOjn771zti3U+MDSDrZuOBp0rz5WfEhK3+7ShyA0t449cu62dguWacExGfSAPxaFiv
	zpCpbakS21rsuvChX4C5gorcCjQyv3oUa1dVYhvx3n3COXKvlKyv3NAuavokC5cQtw691bhtHb0
	SOMtudXbwdrsqQdQJoopogzRgKLqNeXw0NjmgCXLVWx+SnNU43tCytSEOjAuYlp8u0JieQZgMMp
	MdSs2gboPMMsgEV2qgDL2szRX6wwIpyIaA==
X-Received: by 2002:a17:90b:554e:b0:3ad:6090:a189 with SMTP id 98e67ed59e1d1-3b41c95be86mr16142813a91.45.1795607480949;
        Wed, 25 Nov 2026 03:51:20 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm30569662a91.15.2026.11.25.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:51:20 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] mtd: rawnand: r852: declare NAND_USES_DMA
Date: Wed, 25 Nov 2026 19:51:08 +0800
Message-Id: <20261125115108.4147741-4-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125115108.4147741-1-leeonion.muyu@gmail.com>
References: <20261125092538.1938516-1-leeonion.muyu@gmail.com>
 <20261125115108.4147741-1-leeonion.muyu@gmail.com>
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

r852_do_dma() feeds the buffers provided by the NAND core straight
to dma_map_single(), which is only valid for linear-map addresses,
but the driver never declares NAND_USES_DMA.  Because of this,
nand_base cannot know the controller DMAs these buffers and never
bounces non-linear-map ones.  Such buffers are not hypothetical:
mtdblock's write cache is vmalloc'ed and UBIFS passes vmalloc'ed
LPT buffers.

Declare NAND_USES_DMA so that nand_base bounces non-linear-map
buffers through chip->data_buf, and advertise the hardware's
512-byte alignment requirement through chip->buf_align so that
misaligned linear buffers are bounced as well, like the other
DMA-capable controllers do.

Fixes: 67e054e919248 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 drivers/mtd/nand/raw/r852.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..a68f58c81d6c 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -640,6 +640,9 @@ static int r852_register_nand_device(struct r852_device *dev)
 	if (dev->readonly)
 		dev->chip->options |= NAND_ROM;
 
+	dev->chip->options |= NAND_USES_DMA;
+	dev->chip->buf_align = R852_DMA_LEN;
+
 	r852_engine_enable(dev);
 
 	if (sm_register_device(mtd, dev->sm))
-- 
2.34.1

