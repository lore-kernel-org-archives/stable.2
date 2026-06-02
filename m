Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D43955E2;
	Tue,  2 Jun 2026 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424511; cv=none; b=biL2BOhO4qOMpE7VCQk3HXyzQpgdCJO2Z8LCLZDpPnK9pCCOwLMH70mIkNLcs6o+fhLa60kE/9zjpFaPSzXL9sG6AuTEoe1P7mkZ76J8H1RlqUX6QsJ3U6ijYefCtWTCXHslKoFwABJBtRcuhjnmTu0J7H4MPtlCSnQCZWsxy+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424511; c=relaxed/simple;
	bh=CulUlplfQFY6/wgqCXpaivURdbVg8z+bIOwBv9PsOQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlnvtCCOkmFO2ABVmUpgC0zwNcYreRGPYqQRX5v2iTtaLFH5YdCTV7qhfC40d2hY1i22H9DeA74cqGyGmJWCrdN4/JtQs0UH2PU0PYS9/851rdd1OtanNz+Ht9Bf2KnnLamUuIcHdXt2mQxP1A/aoAfJ7XU7bYELXsPaVdvMgAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+yCCgyE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+yCCgyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C1E1F0089D;
	Tue,  2 Jun 2026 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424507;
	bh=CulUlplfQFY6/wgqCXpaivURdbVg8z+bIOwBv9PsOQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+yCCgyESni+/fiwDqhqZCH9LQIyTyLzxl+VFWA+bWryQorDQhsSEUYzfaeItJWZN
	 TJEy6Y5nJLu+v0A4lDIZNzsF4vfKZRb3TomoXh98J8khAMEnrPE9xk2l9GDcMIn7p+
	 zd+X0Ll4Qyk2MjIa0VTpUnNle9NHN0my0iL+wtUX03fXQ+SdzMb9jSRG/JXURecdiR
	 qsWodHLr+XLFObg4Jh1ba3Ibs2cVDcU6yBaTs5eJnwynAdSWbLREM0uuinocXz3SOD
	 jz1dEAcHFmbMaCSavst3Be2seOJ2uC2Fvw7/typQ0VH4o6ItUY1FJkFi8TFAtYFVEE
	 PVPu63yxtDn9A==
From: Sasha Levin <sashal@kernel.org>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Claudiu Beznea <claudiu.beznea@kernel.org>,
	Pavel Machek <pavel@nabladev.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris.Paterson2@renesas.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spinlock
Date: Tue,  2 Jun 2026 14:21:25 -0400
Message-ID: <20260602180900.rcar-gen3-usb2-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, May 02, 2026 at 07:58:59AM +0900, Nobuhiro Iwamatsu wrote:
> [PATCH] phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spinlock

Now applied to 5.10.y.

--
Thanks,
Sasha
