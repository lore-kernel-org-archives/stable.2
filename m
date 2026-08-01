Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B7247291;
	Sat,  1 Aug 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785576939; cv=none; b=m2JP+yoaZo7HA1M1bgUrL4Vh0OWPdRsf+tGBETaLz0BAJnSe4lOkCwyk6ODcb6zWJfZogOzX+Q3ujuOvQLwkGpJoH4elvr3reFLbzbn8mxjN2/GBW/x/+eJ50RkZud0ZaycUBvy3R9cTPEumNDfHLX1pS9U38Aa8EAbbHxPdkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785576939; c=relaxed/simple;
	bh=YN0NRpX7g1R1WmNpLP+XH2cx9GPrlCuz/OHnjEdIehU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBvR7lVcplxpHqb1OPHrxjBhOS7KEMu5gTwcjFBe/5iDzb9AY3VloedgXRe5Z5A+V75kEb/3SE4zUn4RlvJdysGT//1F1QTedQdabKH5ncfoN+E7XB1VHFNTlfvU0sPihgvnYpfexjhI8QKgrZXNo9VmerUQ+qkcZ0NHxCaYhww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=wbCL6n+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMlujpuU; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="wbCL6n+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMlujpuU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7BF8EEC01D8;
	Sat,  1 Aug 2026 05:35:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 01 Aug 2026 05:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785576936;
	 x=1785663336; bh=lV7v7qvDIpbqiesAWok5EwqyRm8gVGxEQVDcMFj9euY=; b=
	wbCL6n+MHTEyVs9QTzhcXKdpCFFZ6WmuLPEepdIYI0F2lVpVWzMJ+C8pzFzxhWYn
	hFPjHoZBk5a3zxQWzNQrOS2CqYb33Sx/g6229mTIfj0HnJdEchg+DVsaWPrysytd
	iza1Gi5InwIy+RU+3QXKzo06OTlI9FECJMYkLh61a9KbQPCq1On/NrtmVo2v/Uyh
	MKTcuV8M0hZ+mN9E0D8cifgoTKTg60AGW0Yg3Z9k5j6ujwaULaAVGdOyicVEKWD4
	OmV64kHLBrtZiBMkzvIe/5//wl3f5lbzRw8DKpKW2DvYnwneIn0x0ah2RoTd2WTo
	AwrftYSvcqvyO9RarLM6iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785576936; x=
	1785663336; bh=lV7v7qvDIpbqiesAWok5EwqyRm8gVGxEQVDcMFj9euY=; b=f
	MlujpuURz/aPkuLOYjzG8nqNd/fP1ieXDXUoHGwEvMP3M112Ud4++V+KURe+Wcd+
	zBHsbau+Qyx5PbDNHfTE7ew0Soq0hsX5+CcTTeUPrU5AH6aFSAjUr6suRa7q1gHx
	Oc09pMYZYS253GvrHNJ2hwjkOgxPzgWzTJteDjs4G1GfWihOAWr4wqtcZTMTgWVF
	t99luQtLlplFwbPys6vUEr7l0m7jkxf0v//faqm/mncQg3V1vRIe24jsd1ZX6afT
	Bm7NZPbz7/L5VBygPBUAn+onWAGfKFgt6cYiNUq2xdFNj49BzEQwEVCRUdwEn76k
	Jmdy6QGHX0wa0Pm23dRhQ==
X-ME-Sender: <xms:5r1tajtbRtPdGQ9shtOBj5Pj0doyEpj7GD9oG6JxJeNjrfBpDMjexw>
    <xme:5r1takAZbg0dLq-YjtTM6XIu71yRdWGFPoMcZOtQ3OXs8BSKo9CG85XwpCdqaxIZZ
    jFbv6vNWPsM48YdUhAFGW9JWcnZexs52fe7xX4c9rl5Py2VWQspdyo>
X-ME-Received: <xmr:5r1tarHTC0yC_saos7vxjdRMIbI_a8I-HD9KQtWyTTW7DRhJl13jn7IXHdYEzE5kY_iBJf_onKOAnBCcL2t9n-O0FD2WbAM>
X-ME-Proxy-Cause: dmFkZTGbKF2PRo9FfpWpVdhZCi7KBOIwxI9XHTMtJqmhDSS4I1657VvthdxXJ7nDVPwBYo
    /eVV+dkQP+p7DwT+jI9nlujtbJvF7cmnGBgI/ZH5UfH3BRhUrHH5ifuR0uZ88EJnGlFdfj
    1q/UYJ+vXCWR50ZklOM/VQCUKy7FWPtYlsPJp8FWCkq+mH5rj8lwOUBA7rd50lqqzYwrKd
    HDx79d6GI0/kZEtXXvSh87h1Acu3/9hMJ8S1UkjNsZjj27HT4N6NtUOZFgoN6UIZ8KSGlE
    Vv6lBIAaSavp5rhgTSoVw1oyg+sBw0XFihRAtcdaJ9VlEz/No79ISqgvT1rdmGWBYt/5Un
    +xRuBUiGQcdk788QgPjnJctCnTI8h/D2zb60AVrQXbpVHJ1oquprVcUaPfLKNg7Lxbx1sV
    P2r/cPRUv/4YaaJ7JeCHikEvffLXcFAVZoBjwPnE8HuPUmWP7N5XhoERO9lpViKGVh/7QS
    xqdLjO2pFo+rAPKZNJCDJBH1Zzv4nNkNgG86N2+wyiT62RFbacMKudXK6hiyM+jXauzWcL
    ExjnLn9QnVNgrY4Ayiaah5dmBzz37bGo0Ybu+fc+8fY3cgn8lvBvGzivpZ2VL8cgYjHRU8
    ZH1b3u1Ix6c2i5NNPRxQsBV17Y45QhpnzMa6G3SyRa/gMaht59VcGYB3x5xQ
X-ME-Proxy: <xmx:5r1takuoRudHtPRRhvHMXaSlWOP_KSWKJXW8t7eE5wgbovWhT-aIVw>
    <xmx:5r1tahmbKGarjUZyMqz1hweEaLBXsbUQ01TOvYqgnxqQB4CjoOK98g>
    <xmx:5r1tanOU4yolUZYrfpaB9RJsqqNjKN5iOMm5dYTM0DcUhh5prSVjAQ>
    <xmx:5r1tatwmEPusHiryWHWuAhzObUTAuwXI6_HJ9aOsNeXCnHlFEG-mgg>
    <xmx:6L1taoFRKJTF6GvdIRjVQg4mWVTgVlqPoILgapSYs3tZtj1XtLEarcnf>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 05:35:34 -0400 (EDT)
Date: Sat, 1 Aug 2026 11:35:32 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, masaru.nagai.vx@renesas.com,
	sergei.shtylyov@cogentembedded.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v1] net: ravb: fix use-after-free in ravb_get_ts_info
Message-ID: <20260801093532.GC3091634@ragnatech.se>
References: <20260731063254.71260-1-xuanqiang.luo@linux.dev>
 <20260731182550.GA3091634@ragnatech.se>
 <4f8e09bb-b6b0-4036-af0c-89306b48493d@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f8e09bb-b6b0-4036-af0c-89306b48493d@linux.dev>

Hello Xuanqiang,

On 2026-08-01 09:56:30 +0800, luoxuanqiang wrote:
> 
> 在 2026/8/1 02:25, Niklas Söderlund 写道:
> > Hello Xuanqiang,
> > 
> > Thanks for your work.
> > 
> > On 2026-07-31 14:32:54 +0800, xuanqiang.luo@linux.dev wrote:
> > > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > > 
> > > The PHC is registered by ravb_open() and unregistered by ravb_close().
> > > However, ravb_ptp_stop() leaves priv->ptp.clock pointing at the freed
> > > clock. Since the netdev remains registered after ndo_stop, get_ts_info
> > > can still pass the dangling pointer to ptp_clock_index(), resulting in a
> > > use-after-free.
> > > 
> > > Clear the pointer after unregistering the clock and only query the index
> > > while a clock is registered.
> > > 
> > > Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > > ---
> > > I don't have access to RAVB hardware to reproduce the issue. To aid
> > > review, see the similar PHC lifetime fix merged as commit 8da13e6d63c1
> > > ("net: macb: fix use-after-free access to PTP clock").
> > > 
> > >   drivers/net/ethernet/renesas/ravb_main.c | 3 ++-
> > >   drivers/net/ethernet/renesas/ravb_ptp.c  | 5 ++++-
> > >   2 files changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> > > index 5f88733094d0f..3a9d9f8718216 100644
> > > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > > @@ -1779,7 +1779,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
> > >   			(1 << HWTSTAMP_FILTER_NONE) |
> > >   			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
> > >   			(1 << HWTSTAMP_FILTER_ALL);
> > > -		info->phc_index = ptp_clock_index(priv->ptp.clock);
> > > +		if (priv->ptp.clock)
> > > +			info->phc_index = ptp_clock_index(priv->ptp.clock);
> > While this avoids the lifetime issue, the fix is incomplete. The info
> > structure will still report HW clock support but there is no PTP clock
> > index.
> > 
> > I have a pending series which cleans up most, if not all, of this issue.
> > Could you check [1] and see if that covers your concern? I will post a
> > new version of that series as soon as vacation time is over and the Gen4
> > PTP driver itself is merged.
> > 
> > 1.  https://lore.kernel.org/all/20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se/
> > 
> Hello Niklas,
> 
> Thanks for taking the time to reply while on vacation.
> 
> You are right that my current patch is incomplete: it fills in the
> hardware timestamping capabilities before checking priv->ptp.clock.
> 
> This should be straightforward to fix:
> @@
> -    if (hw_info->gptp || hw_info->ccc_gac) {
> +    if ((hw_info->gptp || hw_info->ccc_gac) &&
> +        priv->ptp.clock) {
>          ...
> -        if (priv->ptp.clock)
> -            info->phc_index = ptp_clock_index(priv->ptp.clock);
> +        info->phc_index = ptp_clock_index(priv->ptp.clock);
>      }
> 
> I also checked patch 7/9 of your series. In the currently posted
> version, ravb_ptp_stop() still does not clear priv->ptp.clock after
> unregistering the PHC, while ravb_gen2_ptp_clock_index() calls
> ptp_clock_index(priv->ptp.clock) unconditionally. Therefore, as
> currently posted, the series does not appear to fully cover the UAF for
> the Gen2/Gen3 paths.
> 
> As this issue predates the Gen4 work, if you agree that a small
> standalone patch would be useful for fixing the UAF in stable kernels,
> I would be happy to send a v2 including the change above.

Ahh, yes you are correct. Clearing priv->ptp.clock after the clock have 
been unregistered, and checking it before use, is not introduced in that 
series. And as you do here that should be fixed.

I have no strong opinion if this is done before or after the PTP rework 
series. If you want to send a v2 and have it go in before I will rebase 
on top of your work. Else adding this on-top of the rework is trivial as 
the locations where it needs to be checked are abstracted out to  
callbacks.

> 
> Enjoy your vacation!
> 
> Best regards,
> Xuanqiang
> 

-- 
Kind Regards,
Niklas Söderlund
