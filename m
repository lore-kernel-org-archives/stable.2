Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAEE373BF8;
	Sat,  4 Jul 2026 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130767; cv=none; b=g57g/GAWm6sGW1ZrdALGsuzCBuLmkUJlBZ+Je+TmYBaeMt9WPO5KCvcWX86PyHMsW1MSEfEluJ4rAGDJJdP3plAvj/kru2+SwwZjThuk2Z6sf2QCKIsxuHLzMRZxfz1bPBg6ZPCmxDpbB5eG7Y1MVMj305XwkLiIx3MbY9FltNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130767; c=relaxed/simple;
	bh=gO4rDBRiMETXdpJrTrPRAWkHa94HVrdO4JBM/4+cnqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tut97cHa182kTzSH+3M7uiYzOzRhGaRE+LJnCKX57umIA8Rwi4eJBnaggmDUrQib7nTYSIqzoQeRV4W6W/jhf7dajc9pFqg4ZyVrBUyER0dRJFJ+cwSkHTB6D5LyRsCzzDSt1lVXMXUd0sf3mIrq8li3xIZu9mq7GN6+16Ankpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWcrJ40u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWcrJ40u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B316E1F00A3A;
	Sat,  4 Jul 2026 02:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130766;
	bh=aso6+ZsG3X+4VdCWyOlZl63tV16w6vCIPuhmM3D3paQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hWcrJ40unSWvU9QgvHJGS2bqy2j/RV6koWG01ewcqbsKK0HhEwP+TxwlMQ1VgSXG/
	 FVirmawuCmHeOhcJc9V52h/tbr5fFStsMtQPNAwB6ACqigw4kFuJtvrDbgtlMQ3p4D
	 V3n0HVrS1OYnqOKKk6Dd7VLEfxEUm9zsAttEHwqTItWKXlnJjmWNXqJoIxwvVkJbN0
	 pJOcjnNqtyUCuhV6HCJNIBCL8BxoeN1/rCPxRqGP1JN01wFCOq54QNfddBrZ7j0awW
	 3yOfeLuKFIt7MC8CQ907iypOIJoo9rfcbtyamDnTqNw6CXXliqaDGhbrKiNXopBXGA
	 ooMNLCiQX3WwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Abel Vesa <abel.vesa@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Adam Ford <aford173@gmail.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Brian Masney <bmasney@redhat.com>,
	Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10/5.15] clk: imx: Add check for kcalloc
Date: Fri,  3 Jul 2026 22:05:23 -0400
Message-ID: <2026070315-stable-reply-0029@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703121338.25747-1-adiupina@astralinux.ru>
References: <20260703121338.25747-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 03, 2026 at 03:13:38PM +0300, Alexandra Diupina wrote:
> From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>
> commit ed713e2bc093239ccd380c2ce8ae9e4162f5c037 upstream.
>
> As the potential failure of the kcalloc(),
> it should be better to check it in order to
> avoid the dereference of the NULL pointer.

Queued for 5.15.y and 5.10.y, thanks!

-- 
Thanks,
Sasha
