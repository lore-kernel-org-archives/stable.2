Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550763;
	b=TyVcrfKzvrN3yS9BYxsI0ZXN1NEJik6JHrOfHP4uHMhRyEdhnm3qC9Tx1C7heqtbGjsl
	 TrrkoHxV7Ga6hh1Ju3rS2s+1wSW/l8Hll6MWh5fUj3nSvtt1B6l7k2+TViOCkdvBvvUYR
	 U8gYGqZNZiTgIUvuQuzTqLaw/2Yq5HIGjWGH7S3m7/jGsEH04P78PFhIXsliGHMue1rlk
	 YCboUTpVfDcPhNiaJXpmj28ErUKD5WX2rc6afoEKkyxju/1GCiC2W6T0ttTsxhNbun39p
	 EXMJWUaM/WOFpD4BlVRIWJ9rGzjLSft9Pn5kjeUcH1xc8aWJuCZwGiQjZXzrMAUqItA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=UCVdR2KBBx8WLXWoyaVSXl2ic20BPoQEkXA56hQM/48=;
	b=ZkOPff+DLhvKqlJEdDR44MTzAG6McQBe1YuN0gOGRPbOa/4E7BPwpY+iYYNGPsvwtm1N
	 lw2/nI2PGDABw7eNkhDrQCuE60t8J8Jwq47l3CT+JjjjE6EJkGEkGCOZdRIHgoEOroo3D
	 xLPTiPRAsWZQr7cqvf/cdeN5/8vD3xYVfuvbNR4AX+SoOvWvrHpO351dNvLw/qmvF6mz3
	 hNvGufH+RfrvIr6hFafchM4A+NwKuZLCqEnKXdyoudkL2dawgtUvPSFdpbk0jX9am/8/0
	 jJ1KZtmErfwFs7T4wK27Lps8PlxBrlKV98YYti1TFIDqrWcn/g/y0XnZTujI5Qyt5Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQqsSNPo;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE6606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 16:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CFE6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQqsSNPo
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a599e9110eso10734495e9.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 08:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550762; x=1794155562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UCVdR2KBBx8WLXWoyaVSXl2ic20BPoQEkXA56hQM/48=;
        b=aQqsSNPozk03xR9/D58dcN3ACHT6ds46Yk4IXM/IrTvX47XvTB7srSWWQqdaCoLYpG
         +X0E0SUmPSuW/75vBVdwwk6RJlLJpbhyDatwfAf+RA/u2jzJICPVZbliu1Yiv6qdH0Mb
         CmlJRwiyV6Nse+Fx14+MqbwlNeR5txaUfxz1PU9ylRNLCup14ztF6fljqlBCNMgiJrUq
         osF6Hm+8Kk+R2ExKRE+B/uKNLCgxQG2daZRJ/54RzD1Ed9eWf7UGJLxuwwpyMUc1AhLa
         oZMBTZu7yOjIriqHydC2t5pnPddIIz0jCn25eTjM+H/YdlOzKytvOJF023S3oXs9MQfz
         i5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550762; x=1794155562;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCVdR2KBBx8WLXWoyaVSXl2ic20BPoQEkXA56hQM/48=;
        b=1xLJUbLJttlCbqqo6rw0zmr8JQqDUVuX8wB5plrTqUM5099bEsPXxy6l2ozBCF1DtT
         BGcpgsq5tqBMV1yZiJBB5DWKPTnGLbmK8qDzamnGVUxoOv+u87iMaAEPcJpVARxinO7s
         P+VKf/QIc6/hAL6fSHR7xX1ZVTqQ6nBj+OKzUh0uBT/Hjep2qymvcvHLltNcmFC1tovb
         9vBOGlpqlPZMJL8I72AHW5OxofulxuN5NSVokTDGlGhasd9SvUJC1tN4Ro5NnHMyN5kw
         pu+F+atxf9M/fIOib4IRGAtOFwrN+fB5+tOrX85g9o/7ZiwlvGN4k1LAoe8hhd3jagV5
         mGoA==
X-Gm-Message-State: AFq9FYLb8fhrZ/U2SpcOJnjm6gN+Ad2EUDVessU2PTHIfN67LEEkkwEF
	GQ8S3U4PP29GZFNOGcziR/18RAAp9Pu479IdVov4B9ZKdsGQ1TBMc1XuSRSockf0
X-Gm-Gg: AYBFou0/XWxNVXouDrjcXI7++DqFf5DpoV34HrgMhBCX6CLMicTdIhUhhev6jtYVdre
	a2dYQX6ASStO4ssjpkvpxAxN2OBwncOrY303q0IMaqkyrMWNQP8KusAMsjYh7QnYi1ROZwfNQRR
	QW5U01L7Pj4jRHwLlRM8mk8WxY2wSbDjrnn/DUug2PfRhOr6JEq0zhb1Wpe7YUJp4Aw00OAJXUE
	rD5fNdVQlj6K5OFiPJO07EmwgfJjGFyT8W6NEgA/2UrMdmyNjectG4SWr+DkeX+NEdbZvbYvTzf
	4aJICwGRESJQJbyNiOwoQXmlJ/Ey+u4Q/7Bo3zWPtAzOBMsfJvJJz/2PDwYUztK6vr/iXErV0Nx
	Ahd/HAGhYuKVFF9Nwfxd1zZnEn3FG2jGTfkSIVDRWiwBDyLxWpNnjYb3C4nvbl/8M7KY8ZRqhKs
	pNZZpo23QXJ316N8HgmWd5NA8h4q6s397NUfCSDANXD9lDP0YE8d2yZw7QkM49dzEnHGCaQsdOo
	QF5SqTY6g0UoLQaPXCCY7IpE1jWXlQdncE5/PM+gTH2fWmyBOKDJwSY5DwUvf0aYQcChSte/kId
	tXYy+ovvt9b0sjDuN1/wI7dsPFzpUmanJ3FjaksQG8Lhk5r4BQ==
X-Received: by 2002:a05:600c:a010:b0:4a1:7dcf:be1f with SMTP id 5b1f17b1804b1-4ac166ee4d6mr181601175e9.1.1793550761756;
        Sun, 01 Nov 2026 08:32:41 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe77053fesm97219875e9.0.2026.11.01.08.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:32:41 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Vasut <marex@nabladev.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	Itai Handler <itai.handler@gmail.com>
Subject: [PATCH 5.10.y v2 3/4] =?UTF-8?q?spi:=20zynqmp-gqspi:=20Undo=20run?= =?UTF-8?q?time=20PM=20changes=20at=20driver=20exit=20time=E2=80=8B?=
Date: Sun,  1 Nov 2026 18:31:53 +0200
Message-Id: <20261101163154.2274099-4-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261101163154.2274099-1-itai.handler@gmail.com>
References: <20261101163154.2274099-1-itai.handler@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 2219576883e709737f3100aa9ded84976be49bd7 upstream.

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time.

So, call pm_runtime_dont_use_autosuspend() at driver exit time
to fix it.

Fixes: 9e3a000362ae ("spi: zynqmp: Add pm runtime support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20240920091135.2741574-1-ruanjinjie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Assisted-by: LLM
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 58b8c5c37f9a..167eb9072c3e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1190,6 +1190,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 clk_dis_all:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
@@ -1220,6 +1221,7 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
-- 
2.34.1

