Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB124EA90;
	Sat,  5 Sep 2026 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788646669; cv=none; b=JTdgpvdgZX+sFRd0dWUjArpYZ58I7/G/N/awJm+bcy4fNIj6BGOn4umgZ99TkZWpUrH0sUSjb7EU5K5vDNQmBMwUH+JrTRx6ydTdSwt9ZJso/QMltn6O+ZBpxOYwJbQZeCh+doC5137WDaO/FZEVgrC+5pViynrZfL6gqHESch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788646669; c=relaxed/simple;
	bh=wDN0PizPRhba+RCXt7Tpycb6CAxeNKQO1MZS6V/mCwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P36n/EZCeI74HZai3BsH97hYhPgjR5PKlcQLwL5JPy4F2fi+RE4MXmXtzLkEyVKMTsflQ3bBB/DX5g8q4loNaTPGe84VQNdXS1PbmBEPmqH+jfbt1wHcBB+K/QKvHes1I5uMPoJvM15BQmdo0/682Ix/eXFC4Lq0iEkihKIkgF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpBXobmf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpBXobmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD1D1F00A3A;
	Sat,  5 Sep 2026 22:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788646668;
	bh=A3eZZ8TfJYlcw34wez1Kdovv/0mAJhnU0+7MF4+bJt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hpBXobmfFLzOBMwLPse7sAFp5zbwefy5aTtb/vORaTrjkt/P9uTxdANRvLZVrpmLt
	 +zEPvzOp2Yu0GvURsinUtEJDbNmdboecSYEG6bYv6uMO+Ff7BT0GDy2EQyAPzfaUio
	 R/EISh/y5qsxPgx4wFvxB02mhMSxEpoAzMbZcuaD8s8NR/GGQE67+aygvuvDWl4ow2
	 GUs7olSmjsr4S9pxATVt/+B38ASZ7BVIWBqgcSWpWNVPaeJtSQIWpbJdY4pZAh9Xbs
	 SygLvRQBUVrfmHj6wBTDw/5/LVNyf/sVmg7hLKG8c/GaWX/HF3tx828FdEUsb/BDtd
	 q+GW9WGUIUK+g==
Date: Sat, 5 Sep 2026 22:17:46 +0000
From: Yixun Lan <dlan@kernel.org>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	Aurelien Jarno <aurelien@aurel32.net>, stable@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] clk: spacemit: k3: add CPU PLL rate tables
Message-ID: <20260905221746-GKD53903@kernel.org>
References: <20260903-k3-pll5-pll8-1800mhz-v4-1-afafd9cb47d9@linux.spacemit.com>
 <uyl23bmb7dtvkneu7wbpmq24gkmrpmr5n5xkanjrnjf27xsp6g@gcjezv6xwolx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <uyl23bmb7dtvkneu7wbpmq24gkmrpmr5n5xkanjrnjf27xsp6g@gcjezv6xwolx>

Hi Anirudh,

On 11:41 Sat 05 Sep     , Anirudh Srinivasan wrote:
> Hi Troy,
> 
..
> >  drivers/clk/spacemit/ccu-k3.c | 96 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >
> 
> On a recently new K3 board (shipped with OpenSBI/U-boot dated
> end of July), I was seeing upstream kernel boot hang after IMSIC
> initialization. Some logging indicated that it was hanging around the
> clock controller initializations (k3_ccu_driver_init).
> 
> On a board running older U-boot/OpenSBI from May, I originally didn't
> observe this hang, but doing multiple repeated boots showed a rare
> instance of this hang happening. Some changes were added to OpenSBI in 
> this period (end of June) that trap clock controller registers to M 
> Mode and handle reads/writes there.
> 
> Yixun pointed me to this patch, and it seems to fix the boot hang on 
> the board runner newer OpenSBI. I think this avoids some kind of a 
> race condition with disabling/re-enabling a PLL that the clock driver
> does. I'm finding it a bit hard to explain/understand what exactly it
> the reason though.
> 
..
> Yixun, could this patch get added in soon?
> 
Let's wait a bit, the patch itself do solve the problem, but Aurelien
and me still have some minor concern, see other post in this thread

Although the problem is a combination of vendor firmware + upstream kernel,
but it will affect quite widely and probably last for quite long time, so I
think it would warrant a Fix tag and back port to old stable versions..

> Tested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> 
Thanks for the testing

-- 
Yixun Lan (dlan)
