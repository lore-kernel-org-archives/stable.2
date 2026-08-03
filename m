Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F03A1682;
	Mon,  3 Aug 2026 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786637; cv=none; b=lQkRZ/CVHczc0rLsXMjjvETB1DJWAqyklDPYxSqu73HSinFjH0tSq1KpNrlaQAgKB6bqYjNNioxa7a08ODL9tOJswtSMiJLnjUjEUMobr5DKV1wTzIubazMfYY3JZVqX9cQWOsVm5udfYPRNn2lJWIO1FOwEc7nTDXf5pRsxtgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786637; c=relaxed/simple;
	bh=X4fXAkmXIRkkAWSQqnvwAOPz+LXNGhUWiv5tPPZowq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlEXkGwyXXdxv9/NELgou66OWvvE779Xk/tNPNZOl0EH/XelCokpO2Uc9KWBVCFlI1Pljj1t5peK3EZsLqriDwCclRsgSqyS+o51uQQiBYmw+R3iusUdE+iCsqddjntAXHVdRKiPRfF+MN/Sik7coY9cKD1A9QvonrWcr4jotPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+9ke+lq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+9ke+lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8311F000E9;
	Mon,  3 Aug 2026 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785786635;
	bh=qLQmoT0Qm+InB+muH0SCnb4r1bw0bnjyIeYCMj4nTDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F+9ke+lqECruVGOxyMzEozXERA+qhYXA6J56xw74Ett7xKQf+GPhWNgK7tAb8ZDko
	 l+4m+fFhhG3hgilmqsZ8GVquUE5tbB8+FzBNaW5gVRWurTt90AOhy466ndC0bNOGnx
	 PFoFIASClfvOVrSdNEQ9hk7RwDsb6ij2dlHxhfcI83qxUHzb5BHpfdSy2nnSGwu0Cl
	 1Xysqpi06aCkNZyS/SxlFFwafYytawHNoqQaoQmzeGqbIHQ0Qa78NVf8DxprASxcyj
	 JGUaeDq9YQ734+pJ/JrOkKhWBIAfF3SOx7ThH0UiUYL3i6UqCxYahNCdKGaJKRD7X8
	 qdTRaLOzSDn6w==
Date: Mon, 3 Aug 2026 12:50:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Yassine Oudjana
 <y.oudjana@protonmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Laura Nao <laura.nao@collabora.com>, "=?UTF-8?B?TsOtY29sYXM=?= F. R. A.
 Prado" <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Danilo
 Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>, Haotian Zhang <vulab@iscas.ac.cn>, Kees Cook
 <kees@kernel.org>, Miles Chen <miles.chen@mediatek.com>, Daniel Golle
 <daniel@makrotopia.org>, Sam Shih <sam.shih@mediatek.com>,
 linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
 linux-kernel@vger.kernel.org (open list),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
 support), linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek
 SoC support), netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK
 SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_)), stable@vger.kernel.org
Subject: Re: [PATCH 00/32] clk: mediatek: Migrate to common probe/remove
 helpers and fix memory leaks
Message-ID: <20260803125034.49055f62@kernel.org>
In-Reply-To: <20260803141659.559129-1-akkun11.open@gmail.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 23:16:27 +0900 Akari Tsuyukusa wrote:
> This series migrates most MediaTek clock drivers to the common
> probe/remove helpers provided by the MTK clock framework.

Why are you CCing netdev on this? None of it touches networking
