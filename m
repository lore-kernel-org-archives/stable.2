Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D8311592;
	Fri, 18 Sep 2026 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763468; cv=none; b=o9yJbL6gWdFIyA6IMCL6pYW9A0qqZNwhKwM8XOVhXBLMLuzImKU81ax9CDH+KCoWvaAgpf3TNfbhNBp0l8f6cldRJ5vKF4zr9p6nIHBvac807Aw4tJomfxt/B7wl/II0FyT1fOyGw+nMjnpdnRWD9Pt5qC9kmnwYSbCdtyGb3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763468; c=relaxed/simple;
	bh=bfUD+tK7gL88toJsNOhAM1tfubjcSzc+hEBedDn3LCU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DKTL41ppLIZNC1OSBLMDeIT6OZy1t7775O2fPHb0LpsoMQ6yycOI5SflBJhvR4jhSqCcHsKsqS/k75vAlEWk9JUL8eBUYBNRLkRT8tETEuPHoywpp6GLiOFIdaCwUmcbb5sIsUmD0LQ41051Q4aC+5nGajCgWdbwV5tCEdbAxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ckNf0D72; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ckNf0D72"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F702A0350;
	Fri, 18 Sep 2026 22:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789763463; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3Y5HCAbfoaQ0Lvl3S8vbI4ON8iaEWurJ/eJhwn9NflQ=;
	b=ckNf0D729XxueNWvJvJ6Zv5hA3slhfJIe8fL661zNSSywWhXwgTYVJRgVX0/Z89YUpu56p
	+D86vD2LFQtRJtxxXoE1ZkVc8acya8xDUiSWybfxTAO7EasyAKc2MMOVgZLmU1ddx6Quzm
	vhd4bh7iBB/xuwHXeF/k082qImcWXvWc8j0rhgRwMF2BrUMCmGNpv9Z+tXUpJE8rECXm/Q
	rbfa1UkT+/HTuaFWbfUEsDHeS9G4zpsL1E7M2JxkWNMej6HFbGpNzdmJGPu22/QsczyC+o
	IZU9IXcdrVkk0ZlyKSuA1WBuLWeTf6HyhpzITDPdTCK0IluZ5b2srDHwlqYh3w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 22:31:01 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Sean Anderson <sean.anderson@linux.dev>,
 Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: macb: take bp->lock around NCR
 read-modify-writes
In-Reply-To: <20260918-macb-ncr-rmw-v1-1-30c3494f93cd@bootlin.com>
References: <20260918-macb-ncr-rmw-v1-1-30c3494f93cd@bootlin.com>
Message-ID: <f695ad9aa88acb08727f442307dafe9c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 18.9.2026 21:59, Théo Lebrun wrote:
> NCR is read-modify-written from many contexts:
> 
>  - macb_mac_link_down() clears RE|TE,
>  - macb_mac_link_up() sets RE|TE|PTPUNI,
>  - macb_hresp_error_task() clears then re-sets RE|TE,
>  - macb_start_xmit() / macb_tx_restart() / macb_tx_error_task() set
>    TSTART (already under bp->lock),
>  - macb_interrupt() might toggle RE (also under bp->lock).
> 
> The first three risk concurrent RMW with anyone from the list as they
> don't grab bp->lock.

There is a fourth, in at91ether_interrupt():

      if (intstatus & MACB_BIT(RXUBR)) {
              ctl = macb_readl(bp, NCR);
              macb_writel(bp, NCR, ctl & ~MACB_BIT(RE));
              wmb();
              macb_writel(bp, NCR, ctl | MACB_BIT(RE));
      }

I guess you have skipped this as the emac variants using this are not 
SMP?

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Regards
Nicolai
