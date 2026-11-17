Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911868;
	b=fzi9rSM65hzko2VEH2E/LTIpPr3Sbt5avQjcLeN42OEb2Z21GqxEUz4pk17bFe0Bjp78
	 ViNNrd9YWkRldienKvb9swYZe7I0b+ZrKmbTJamKs5E5850QQDeI9E0493UYenLZHoXy0
	 6lDdMd94yGI2cupR/LozWgzLus8aY7rNX+pEymRJ0a0UT/sz7R8/NPwpaDy6md1cfvz+w
	 BVcLoKL1HQtm/h5VFwzb+3Oq9/UU39ELHPheOiaiCWTWs+cmNmCR27YaNdeHiI0ODziAK
	 Qpu5rx7hNMe24LRAv9TfiNDOOqHH3LJ2z6dIXBX48bbHdSMkSD6+IiR8UIDeLXup8Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911868;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/oGiJHm/jh1FUNLOdXcbYyLNEuc+U0PJnk+ui2av96o=;
	b=YXtHgKgTxLSDFPUJGvMC9ueoi0zkLZUh6/ryunrle+/jEqeo/3b73ivMypr74E4PpliT
	 9pAQ5N9/xFViKXF9qcjVFpiiiwkmEZTtwua4WHNBGsv9sjzUqGmXDr2OOssENsfGkBnmV
	 jASZ7W9BvJZ8kOhCL0+sFxT9RZvWD/H/+p6F2/IO1aPCqOGDlJonKiEkpWRKhe6MzI3Sq
	 m2cKaAsZDrEFIWmyr2tarHAEyQg5SokvFtUtBc6/D8LUvQDKbXWLzrTJ/mk3NNBPU1ggX
	 jzlUJlPsBC8CjWFvGDt343sGBGepSnypT8dKMx4JKXIAanxRcL4tq4pmyXV7Onjv4SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=aG0yeLuY;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66706606A334;
	Tue, 17 Nov 2026 10:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66706606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=aG0yeLuY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794911866;
	bh=VOW3N+kuAOhlQXMVPIKqUw8yVwXy/w9NQurJNFZ3824=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aG0yeLuY8OMnE6Cf2ENdM+pBOa2xVk8BB7i+rUJa3ZPKf6EEagNeE/cLqZj+KDzMl
	 B+2rit060SVf8Fl0Lb7R3KzJZMEeBDhWXqwjsDKf1vgbevsUfdCsjxjckuPrj+389h
	 AuxR/9X3ZVWCtd8ir9+Z9q8SeT50dODfe0CmmBa6EzqtzEWvE2W3VAtT/KPvGFYTBI
	 SvjHgwie7k2wL5k7v6U71LmuXpSrB3it2GQWuYBuClo3+gMgn+P3uiGLHX/4YBbl32
	 2V7DEgaj4Cj1+Wbf6qoVb09V098q9GC9hNq4FepGPCD/qZffIu1aBs70eMa1+hS7qy
	 unczhdnjFCVIQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C3F817E0390;
	Tue, 17 Nov 2026 11:37:46 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	zoan37 <agentzoan@gmail.com>,
	linux-clk@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Irving-CH Lin <irving-ch.lin@mediatek.com>,
	kernel@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: mediatek: mt7981: fix "emmc_400m_sel" clock mux sources
Date: Tue, 17 Nov 2026 11:37:34 +0100
Message-ID: <179491184091.148303.8587843697634686350.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <OSCPR01MB1501934D1DC407B535D78F02EBC992@OSCPR01MB15019.jpnprd01.prod.outlook.com>
References: <OSCPR01MB1501934D1DC407B535D78F02EBC992@OSCPR01MB15019.jpnprd01.prod.outlook.com>
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

On Sun, 18 Oct 2026 13:50:16 +0800, Shiji Yang wrote:
> According to the document "MT7981B Platform: Registers Part 1", the
> 4th clock source of "emmc_400m_sel" group is "cb_net2_d4".

Applied to v7.4-next/clk, thanks!

[1/1] clk: mediatek: mt7981: fix "emmc_400m_sel" clock mux sources
      commit: af557feaed1f9344666296284cda362d4ed53a9c

Cheers,
Angelo

