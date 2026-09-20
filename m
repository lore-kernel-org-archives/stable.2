Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA617993;
	Sun, 20 Sep 2026 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789945690; cv=none; b=BJIK2efQk/hVpC8/EjTGoZtYn8q87YYOgJlBbFAMmZHhpaeICLiXUOc3bbfwg+ddpAWdihelvtE+XQdi3AyQOYnUitxrUx9WdR2lsRly1qX5gj1yRjh522XQ4c6G+haur67EF5oSB8IJeDzWi74GzbxhxsLsFtkGzqN99xFmrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789945690; c=relaxed/simple;
	bh=kI3btekdDolq9CHrtl48dAsoqhxdnD/R8oCP/h7ETIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEuUBv4y0k2yKXypWmkqCyAhVH6Qh+W8SgskIvInUod0zI/LyLEYLkBY6iDP3ZgI7RhbIT3jt8PmGBTAo20vYH6aKX8ZbgVM02vMhFlPwOgGGyxknqMVuSPHV4ReRleh810ht4zqFXVZA19BVxwYexqZwaid8wRWhJNIlENPAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO0/HhXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO0/HhXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B871F000FF;
	Sun, 20 Sep 2026 23:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789945689;
	bh=AAkvtlTgMtIhLKtfXdECEdpJvOyrsKzhh3qvAgjEuMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MO0/HhXn4w/YTEtqB0grF5h/fGM6t1Fu4oRfj0EVRpgNJM4za1uzMTvZReJDb5rin
	 CJSAUaco9Or3z4C0yLN8r6QL59dQ7Ue7onLURIJ3A3+U8rPblLTo7SQfs8AAS/eh+C
	 0y+aVv9RFyHA8KuCEtY+iI9mxp+FPee+sJK1SyUshWmVi3z3lh9Lz2diXjyN6ospzE
	 wNj7PSmNsCQ1uKrK/XVPMOIFvMKCb9970vJWFnjjv7660ouZ39ky5HVMv3KHyNSsTe
	 UzCbjC1Ojjj0neqstCdgGXQs6BawyJ+MKNslmenwf062uEilnPFLDr3iajmSp85alk
	 2fpwwjIawD6kQ==
Date: Mon, 21 Sep 2026 00:08:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, sashiko-bot@kernel.org, stable@vger.kernel.org,
 Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v7 00/11] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Message-ID: <20260921000803.1148e493@jic23-hlaptop>
In-Reply-To: <aq0J9Vs1_rUAlcoA@ashevche-desk.local>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
	<aq0J9Vs1_rUAlcoA@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 12:52:53 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Sep 18, 2026 at 12:06:26PM +0300, Ariana Lazar wrote:
> > Refactor I2C driver implementation into separate modules in order to add
> > support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C
> > implementation. The I2C and SPI devices have the same memory map and
> > supported functionalities.  
> 
> Jonathan, can you pick up the fixes from the series, please?
> It will reduce a burden a lot (yeah, I know that it might mess with
> Sashiko, but wouldn't simple delay fix this, I mean to give Sashiko
> a time it needs and then update the branch?).
> 
I'm not sure sashiko ever looks beyond mainline and given recent general
comments from Linus about only sending him late cycle fixes for stuff
that went wrong this cycle or is a major issue (which I've been interpreting
 as applying after rc4) I'm not thinking these fixes will go upstream before
 the merge window.  I don't mind applying them to the togreg branch now but
that isn't currently picked up by sashiko.

My biggest current issue with these bots is they make the workflow
of nibbling away at patch sets like I traditionally did not work
so well.  One option is to just send the whole series but edit
the titles to say they are already applied?  Hopefully that
lets reviewers jump over them or even maybe filter them out?

Anyhow, let me queue some of these.  I doubt we'll see anything new
from sashiko given the minor tweaks the rest of this series.

So with that in mind, applied patches in this order
1 2 4 5
held 6 back for the thing about checking if property present.
3 7 8 with link dropped.

So just 6 9 and 10 for next version please.

All the above on the testing branch of iio.git.

Thanks,

Jonathan
 


