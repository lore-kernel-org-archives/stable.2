Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA9B3E92A5;
	Tue,  4 Aug 2026 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807654; cv=none; b=pXpO9uuvwVDZR04tK6by1J2qM0aIB17jqzlmGVB9REpVmYu7DGXxpxSCVquR0U4G3riCBwW/cYKV+59pIC+ASKxWZ4UOoGMv27d0FJFpeaCeb84+eBXyjS/gEZlRbYLVgEEG79nWaTrxMewKysiI6PItAqlZslZGk586bFyC47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807654; c=relaxed/simple;
	bh=g4uq+JfypAVJ9RScxjOoJbuMfn9vlczAoMsOAlU65bI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFNXtH11kgUqcRTw1IzkgyWqLdEwvwVN76D3fDik41pRKMTdkK+/AmDexv6OQMda3ZSuZwRAdCLDwCZK4s2fF6OfLTGNlxojMy/J6nWKUDHINDQA3IxTH9JSGxjIiqLoetHBokKFPY31+ZVO6KhtSpkdWwj3ZqCYAAP9HpvPWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG/L8wKA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG/L8wKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4031F00A3A;
	Tue,  4 Aug 2026 01:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785807651;
	bh=Oic1r/RdJs0p25eYXITWGXQfTIlTGgREqOaY42+fH1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hG/L8wKAeNwmgVRj+GI45ZUdZMnvGSE3EOLe6ya7z5Ixxo3CHf2b8ZgXsa7BbUzcS
	 7co2spdP6CcXFrOSI/kBi6x+3iNMR1hljxbHS7VwJpUOsKi9R+rzt2SwGZC+pnCkiE
	 TkZb2VVT+eiwwKTfVqAYiCz+azb6exQObopo8xQ2wbczVTw5K6X21DIhkItLnY4eon
	 ZU//XShakHIQJcxxs7eMeGrS44Krc/Gu9Z1+RfB97+PsuFfncxfQYNMvx1u51LKQM5
	 GVC8QOB9u/XHGNiq73al5iynUFtPC6Uvb1DnCCIWTBt/NhN+pElxQPkY+8fc5gO05R
	 lXcuyMPPp82Fw==
Date: Mon, 3 Aug 2026 18:40:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Akari Tsuyukusa <akkun11.open@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
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
 <daniel@makrotopia.org>, Sam Shih <sam.shih@mediatek.com>, "open
 list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, "open list:PTP HARDWARE
 CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH 00/32] clk: mediatek: Migrate to common probe/remove
 helpers and fix memory leaks
Message-ID: <20260803184047.4a8ec29a@kernel.org>
In-Reply-To: <anD518s51UBvJHj4@redhat.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
	<20260803125034.49055f62@kernel.org>
	<anD518s51UBvJHj4@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 16:28:07 -0400 Brian Masney wrote:
> Hi Jakub,
> 
> On Mon, Aug 03, 2026 at 12:50:34PM -0700, Jakub Kicinski wrote:
> > On Mon,  3 Aug 2026 23:16:27 +0900 Akari Tsuyukusa wrote:  
> > > This series migrates most MediaTek clock drivers to the common
> > > probe/remove helpers provided by the MTK clock framework.  
> > 
> > Why are you CCing netdev on this? None of it touches networking  
> 
> I saw that message from you about two different mediatek patch series
> from different submitters. This series has 38 files, all under
> drivers/clk/mediatek/. If I run get_maintainers.pl on each file path
> individuall like this:
> 
>   $ cat filelist | awk '{print $1}' | \
>   	xargs -iblah echo ./scripts/get_maintainer.pl blah
> 
> Then netdev list doesn't show up.
> 
> However, if I look at it as a whole, then it shows up:
> 
>     $ b4 am 20260803141659.559129-1-akkun11.open@gmail.com
>     $ ./scripts/get_maintainer.pl \
>     	./20260803_akkun11_open_clk_mediatek_migrate_to_common_probe_remove_helpers_and_fix_memory_leaks.mbx
> 
>     ...
>     netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_))
> 
> I think it's matching on this entry in MAINTAINERS:
> 
> PTP HARDWARE CLOCK SUPPORT
> M:      Richard Cochran <richardcochran@gmail.com>
> L:      netdev@vger.kernel.org
> S:      Maintained
> W:      http://linuxptp.sourceforge.net/
> F:      Documentation/ABI/testing/sysfs-ptp
> F:      Documentation/driver-api/ptp.rst
> F:      drivers/net/phy/dp83640*
> F:      drivers/ptp/*
> F:      include/linux/ptp_cl*
> K:      (?:\b|_)ptp(?:\b|_)
> 
> I think it's the K: for the ptp that's matching.
> 
> $ grep ptp 20260803_akkun11_open_clk_mediatek_migrate_to_common_probe_remove_helpers_and_fix_memory_leaks.mbx
> -static const struct mtk_pll_data ptp_plls[] = {
> -	PLL(CLK_PTPPLL, "ptppll", PTPPLL_CON0, PTPPLL_CON0, 0, 0, PLL_AO,
> +static const struct mtk_clk_desc ptp_plls = {
> +		PLL(CLK_PTPPLL, "ptppll", PTPPLL_CON0, PTPPLL_CON0, 0, 0, PLL_AO,
> 

I see, thanks for digging thru this!

Patchwork matching rules must be missing the PTP side because none of
the patches end up assigned to netdev. No big deal but going forward
I think you can drop this extra CC.
