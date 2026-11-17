Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925405;
	b=wkSHQB3tMOudNMLFWgOR58P0kAg61itUjPXcBFLmVBZQzt7ZRJ5bP4YFpd+2BhtUwh1n
	 PbYcgx7rQQ6CERgPw9/1LNPj4wE1RAyLQFZx7/xOHuy1ybXjJQs0pNNp1ncJxbguWpKn+
	 9S6IwlD9wm1v3Gi+nrMgpgIgmP/5AMAmSo+p13nFLPDbXNvm+6T9B6t3ZMnyBmjXEG8zM
	 tsDHZ/PFc7/qAi1OY1y14rhlpYVJh3y5M+b4vXFzGmT9ORnEJPenyy+cEzqX96TxOB40T
	 tx6xCiTEh5tDBoV7WszQu0XZwmPxXFIzwD+29pmcWRuz9gv54I/HLqWQZ1HiNXBXOCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925405;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=g80SiH+ng5urDF4FCTLf1bdd/UkOkxO1eAY1IXDz8z8=;
	b=v4kvida/8Mom1a+NxSIflqf95GRWXAW1I/C1KzoEuVUQwNOF6aXF3pwe6oWbRHFKhCUp
	 A004g0JP57R4kdSmyUWEr0sSxXuaqLUTUrmXcgI+/isKsJPq/62bvvKadGVFmy51ZmeVY
	 MtwWJ4LU4BfhiVCLR9KUoWOSYu5HZ77fSTpnQ6qshYtwHpWWT00p3diPGOdv/D3SsDPQq
	 o1uERTMUfhZOZraWABB4xHGFnaPAY4jRdZUvUZzREjtA/rVkQP3A/sr3/o4PU0bZROncc
	 og/AWkTJTH+WVpNTKHud6K4hWRoMyD0DvOl5cxi8wysJ8pYz/vDsWoDaPr5UB4ex75w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PrCsK8oh;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F4606A8B9;
	Tue, 17 Nov 2026 14:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C40F4606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PrCsK8oh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9AAF64E415EE;
	Tue, 17 Nov 2026 14:23:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69BB75FD6A;
	Tue, 17 Nov 2026 14:23:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22B6711BC004A;
	Tue, 17 Nov 2026 15:23:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794925402; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g80SiH+ng5urDF4FCTLf1bdd/UkOkxO1eAY1IXDz8z8=;
	b=PrCsK8ohahMc/1D7Hut2u+V9puAKhj4hTNcOwBMLVIYQwO6jZPWsVDRtxdiU1DCNFUrHIa
	JmIeqpUMOCPhhCyd3P7HHCQFbuaLRhy2NZ4hoN1xQi6RvbSHb58uK9pKgNQ7caheWi56fh
	fvysmDdCyTsv0do4b8580zr12tDBrvqyvaUKifbT1MZs/9zsaFsPKiNR3lyNobSmOr+cld
	Kvh6v9xeIWEk486znBuyfdPcdY+Hq/6rk4mupi5k+Fk7i8WMho8dLefkc1sOJwVAiimD5/
	cFncLsIKPbCMmbVoogXRa2InJaNhRnjnyfwqvS/CVclIuhQy5QrjlgJm1oh6Tg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261110-9f141e6bc8-mtd-marvell@mail.sdu.edu.cn>
References: <20261110-9f141e6bc8-mtd-marvell@mail.sdu.edu.cn>
Subject: Re: [PATCH] mtd: rawnand: marvell: Fix potential DMA buffer leak
Message-Id: <179492540106.2259780.10780989763768054974.b4-ty@bootlin.com>
Date: Tue, 17 Nov 2026 15:23:21 +0100
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 10 Nov 2026 22:32:24 +0800, Guangshuo Li wrote:
> The bounce buffer allocated by marvell_nfc_init_dma() is not freed on
> probe failure or removal. Releasing the controller loses the buffer.
> 
> Use a device-managed allocation so the buffer is freed after the DMA
> channel has been shut down.
> 
> This issue was found by our static analysis tool under development.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: marvell: Fix potential DMA buffer leak
      commit: f39045da527565bc58171ad6c88ee4be4771fb62

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

