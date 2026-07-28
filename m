Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5531E852;
	Tue, 28 Jul 2026 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274357; cv=none; b=PZ2THJDNtNUh5alAaVRjp6NqvE0QThw/vpVPTcbo5kOwpkMU6kWl8TXYrkD3oq1n7fO80gkkDr9BIeOXy+40F02etJV+wzdfYxnQx9jLgT0xHVpD7F7DnMyqx581ypLGEBtqpCoT10iuCLuDPBCuHAD0UHKXAPVaVst3zfcmbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274357; c=relaxed/simple;
	bh=SAId/SJQnhSGCllCBQIdNG7uxRU7BQcCXX0iAkOuc5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt6lkE/dUgJxlaKiZysUeTdmCwuXE4KMDfkPk40Y0qcOgVpY59bn59riVC7UCZTnWatgxxr/mijGBuBh9cFvW5qjMmXb+KIG5wv7ZUX3Yyv05uCEVaUTduslmxAdqK9tvzPNlKHWMfTwbVxNjBIbMLoD7n/ttXBKvcgGq/iopXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRQD3VZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRQD3VZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0310F1F000E9;
	Tue, 28 Jul 2026 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274355;
	bh=pF6qsVRp/ynTp2yRc9Y/qPH4ccaUnT2tJzJbz05IV1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nRQD3VZgBgKkO/5uSFj/C8fT3mHdEYFIDxMtSx+SAEwZ627vDQJ8kT902LIF3/VrI
	 6tEBT/NfZdpoMS+697uakFbh6PDCoJOFQvnWD/d9SFq+pvIx9sRAC7N5elClETWdNx
	 pl1CKQ6aRN7jZp0hjvYFIcjZB32K5cNEz9Bw4GOkKGJ7e/zKF9dpycGWD7PrxGPu7W
	 O95/K1mY+6Xi04dZkimVL1BEcH1efIqD7ELSOx7MgPLhGllMv++Ti9MfnijvdHAlyK
	 KcFt6mQnwq1jDr1fJAZzhkF6CE7OR1/kwfrS1k8UwHWPHMczJjCD/6D5SE8e4nj4h8
	 ZEzryOcjmCvEA==
Date: Tue, 28 Jul 2026 23:32:31 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Liem <liem16213@gmail.com>
Cc: carlos.song@oss.nxp.com, biwen.li@nxp.com, festevam@gmail.com, 
	frank.li@nxp.com, frank.li@oss.nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	o.rempel@pengutronix.de, s.hauer@pengutronix.de, stable@vger.kernel.org, wsa@kernel.org
Subject: Re: [PATCH v4 0/2] i2c: imx: Fix slave mode corner issues
Message-ID: <amkftflH9EQ6JDQ4@zenone.zhora.eu>
References: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <20260629023829.152651-1-liem16213@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629023829.152651-1-liem16213@gmail.com>

Hi Liem,

> Changes in v4:
> - Patch 1: reworked to avoid race with shared IRQ handler, as
>   suggested by Sashiko.
> - Patch 2: unchanged.
> 
> Changes in v3:
> - Split the original patch into two separate patches as suggested by
>   Frank Li.
> - v2: https://lore.kernel.org/imx/
>   20260625160219.55116-1-liem16213@gmail.com/

you were already told not to send the subsequent series as
--in-reply-to.

> Liem (2):
>   i2c: imx: Fix slave registration race and error handling
>   i2c: imx: Cancel hrtimer before clearing slave pointer

merged to i2c/i2c-fixes.

Thanks,
Andi
