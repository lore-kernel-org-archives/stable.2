Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E4306754;
	Thu, 16 Jul 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214187; cv=none; b=XCRmHwH8Nn2iCM8eLDy3/tn9gKlYrvt+pyltRST83w3jjBxMoOwhYQ3MmqZeRrxc7SD4e7dKnGTLUdB2Y2Xfcqcr9pkfkdckYIK1e/HmqzqpoA91a2o+5H4PXrcJGKLTirluAu8Iy4Hs+vct/SrZuDqRmPAAE6A7+DSRBwysjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214187; c=relaxed/simple;
	bh=tSdAXpqXJovcr1WgmLGcsPgPgujc5v6KD2LLAK0AOFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly2oPaEUt6NW6zUGKC1SCOyuSsRn7ZnYlIeeWrM2w8my2aLUSNnPHlKPoD7w+tn58T0h0XJLbGXch9h32ndYAJjk8rG5u+0/WbNO41qq/Tr/8P5vrgjhbP7QTNETjCEUXDQHJlmNnfP8PCwvRsScAA+lVtNiaB9G7I4zPqPtYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHCo3Hu2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHCo3Hu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA181F000E9;
	Thu, 16 Jul 2026 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784214186;
	bh=+ExhIekzxCh4zJqorxDbL/NrT8u8gcatX9LYZ+QXseY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oHCo3Hu2aZu2ozL+3PeryVZ1Z9x4Sc+FYrlm8ijSwDlzJnp+10aYIb8GdaZUgFLV1
	 3kAIbQuRZQmY6zf3ToCCvha2HnRvFRM9FW4bXl7BQPPB/whMgMsyxusiKflF160KeV
	 tIpYwqfKRI1LkeHoK7CyQSWnB1qEziEkIlmskYVgzXpKKWH8iWOJw7pq+nmHQ/OMM6
	 dMNmeQ8eVbFruzOL1zoXqkLtwucL0spWaIBtOJ2mPLrQWeOxCtIcMfh3ZYM72NTf1e
	 A7vKNMC2RIUNbxnMn9/+Wv/x+DMcjxLT6HWWfCrT95mjVMB1NjfT8TX3X8dkkZiB0f
	 UNMuyq3Ti33cg==
Date: Thu, 16 Jul 2026 17:03:01 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Vincent Jardin <vjardin@free.fr>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>, 
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>, Shawn Guo <shawn.guo@freescale.com>, 
	Stefan Eichenberger <stefan.eichenberger@toradex.com>, linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Carlos Song <carlos.song@nxp.com>, Stefan Eichenberger <eichest@gmail.com>
Subject: Re: [PATCH v3 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Message-ID: <aljyYViyNwN0MjGQ@zenone.zhora.eu>
References: <20260713-for-upstream-i2c-lx2160-fix-v1-v3-0-073ac9e103a5@free.fr>
 <alZZmzQrnBptGEMQ@shikoro>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alZZmzQrnBptGEMQ@shikoro>

On Tue, Jul 14, 2026 at 05:45:31PM +0200, Wolfram Sang wrote:
> On Mon, Jul 13, 2026 at 08:11:58PM +0200, Vincent Jardin wrote:
> > i2c-imx rejects an SMBus Block Read byte count of 0 (valid per SMBus 3.1
> > 6.5.7) as -EPROTO and returns without emitting a NACK + STOP, leaving the
> > target holding SDA so the bus stays stuck until a power cycle.
> 
> Bigger picture: Linux does not support SMBus3 which also allows byte
> counts of up to 255. I started sketching support for all that but could
> never implement it.

Yeah... I have claimed many times to have patches that add
support to smbus3. I also promised many times that I should
update and send them over :-)

Andi

> That being said, despite no SMBus3 support, it should not hang the bus
> like here.
