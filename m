Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB344162A;
	Mon, 21 Sep 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984587; cv=none; b=mfg7HFrh8TEPhnpZ3V5RjSJpGuxK6lTyaUJJ8LCG+9c+C93mJzSPIydzno5Hik++2RMOJ7VcgkON/ZFkPsFmLDxtSVDspC3V0HwUCOoc7tJvp4aVMU9RlAbxOU80qOQ5L3ElAZozF3cuTWNrk5dG+A2XogqlO92vZ0RDOJUAlOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984587; c=relaxed/simple;
	bh=SEZbFxZXTLb9pYzTcnhtLeUwdu1yLrrYEmWmRGN7HsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1uo5B/h/UheBu4OsJXyG4MlrZ/cD3bHeGT0EkwhH+pl7iCTcmxJefxArSPK71+27Z0FjMmTItBu2mhR1h/qFK0N4Kjdm5YYZj6wuVacSgqO5mMp9HFqLVR5O6tiod13ljtB5McNGcYCZ6xSzNpjmNVsbp6Inj+D18+9lwolEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiylB+5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiylB+5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2390B1F00898;
	Mon, 21 Sep 2026 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984586;
	bh=A2hp1ekIVVhcURopRUkJ5nr7RbLgbjGhCKArrBF1hA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kiylB+5FniKQvB5KpdSZLyXFvTJgGkEy6+ppaAUc6+eMXEKzvQxCuVzKrsyZaSNUB
	 karozlDsRshyqXiLkljLVBI0ttwl+4UkbnGMlJ1MIVluLDxwBcUGr0jfwD78cEqrkf
	 H6kISPvKIRn+q63nfqJGU8hLOfQvoWWl4/KnYTA9nYnpQd2i6dElhYK/kB08V7rkhD
	 KRz9AdTr9xNKzu9/y1Q8nzDiTV/BgZKROwwtjsU3r81QQ6SumE9dAsTPIuDZzmFnT5
	 TNs/4Vk2ITsHFZlAKB8YrS4/cspc5FZbxV0t3/rAXl7f/5EsR9tlRInxT8WUWK306d
	 QceLthuEo18OQ==
Date: Mon, 21 Sep 2026 10:56:21 +0100
From: Simon Horman <horms@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	olteanv@gmail.com, pabeni@redhat.com, paweldembicki@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: vitesse-vsc73xx: Fix SPI device reference leak
 in vsc73xx_spi_probe()
Message-ID: <20260921095621.GC13925@horms.kernel.org>
References: <20260917104920.2147568-1-vulab@iscas.ac.cn>
 <CAD++jLn8zuuBQKXTp_-Z9An2Qb-axBet5jwtyp+iecyUR_c0Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLn8zuuBQKXTp_-Z9An2Qb-axBet5jwtyp+iecyUR_c0Og@mail.gmail.com>

On Fri, Sep 18, 2026 at 12:22:12AM +0200, Linus Walleij wrote:
> On Thu, Sep 17, 2026 at 12:49 PM Wentao Liang <vulab@iscas.ac.cn> wrote:
> 
> > spi_dev_get() takes a reference on the SPI device, but neither the
> > probe error paths nor vsc73xx_spi_remove() ever release it, so the
> > spi_device can never be freed after the driver has been unbound.
> >
> > Release the reference on both probe error paths and in remove().
> >
> > Fixes: 95711cd5f0b4 ("net: dsa: vsc73xx: Split vsc73xx driver")
> > Cc: stable@vger.kernel.org
> 
> I think we don't set this on networking patches, the network maintainer
> decides himself what is stable material.

Hi Linus,

That was the case in the past.
But these days following the standard stable procedure is encouraged.

Link: https://docs.kernel.org/process/maintainer-netdev.html#stable-tree

> 
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> 
> Yours,
> Linus Walleij
