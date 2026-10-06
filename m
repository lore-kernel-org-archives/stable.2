Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119C4AFE2B;
	Tue,  6 Oct 2026 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327334; cv=none; b=OeB4H6b+1qA4RE7/zHH2adTDC1Pkc4ymK/1X8FIHwiVpc7j4cdo/+YdhX58c183efC5jsfbHfOiMHG5IIbIcpKFbWPsBdIGbiL2lvixkPhSTDNYJyTFLj1JXXk9Qerep6qM3NyaP5rHVL0N39qBAqKZ6+b9DivPQ5vhHmLLvqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327334; c=relaxed/simple;
	bh=1O9e7gKVNNEaPlw3w95PgTZHHC1J70j00txRnfNRtHE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GLYdNjvkbkyv7JtC+IoJTspJiUEr0PJkUpVjpnwiFJD1zp9mbdIIOr4hCtU6urtHrdtS3+6bk+842oaXaUVj2/c8Dk+TVGLlF/7MHtlSvR9tbCBU3F7KJlxG5O+jxMsyCKcbmBDajE2KC1d8/7DGEINA/0CN2i1jUHBisuBtrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th3p+inv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th3p+inv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF7C1F0089B;
	Tue,  6 Oct 2026 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327334;
	bh=nC3YZn+XWotlzSFcIl75lhFWfV5zUFiAW7wfrP3jwVw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Th3p+invhp8EMMvScJFURMTFYLn01r5Y6Z3+iDeqrMfRfUg9o56kvy/A9Bw5ES4gU
	 1er1BwjL0VogpklNmPXJUDK9ZsPBpkdUmICPE78Z+YzjyMkMxk+98rb8PHjJE71d1K
	 8IXrHzkEYKvs6H0aCLbcB+HMQD4DZrY04eXNeOhU8hVxCCx4l9FNQbreMjH9qfYkZm
	 gXcQDDw5W2zEUdbGChJXpV09kNxxcKiXF7qfbPvsK3zNXso3S7UczFH7z3vPfDSmNg
	 BTikaXi3YKuKLJwRujbo8qZ0slKMQFdrJlCP+mmLVH8cLFYB41EXVkjwSTi3otPshx
	 W8u8wT8brhWWg==
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
From: netdev-bot+sashiko@kernel.org
To: lilinmao@kylinos.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, hsu.chih.kai@realtek.com,
 nic_swsd@realtek.com, mail@birger-koblitz.de, zhangxiangqian@kylinos.cn,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 06 Oct 2026 22:55:32 +0000
Message-ID: <179132733298.434549.4329766325512827151@kernel.org>
In-Reply-To: <20261005105249.1281648-1-lilinmao@kylinos.cn>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] set_carrier() in drivers/net/usb/r8152.c (line 6983) now
  decides carrier-up from a single read of MII_BMSR.

--

r8152: Use BMSR to detect the link state

This patch changes how set_carrier() and rtl8152_runtime_resume() check
the link state. They used PLA_PHYSTATUS (rtl8152_get_speed() &
LINK_STATUS) and now use MII_BMSR & BMSR_LSTATUS. The goal is for the
driver to consume the latched link-down bit itself, so the first speed
query after link up no longer reports SPEED_UNKNOWN.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f61686433031c..e3947eb796c5d 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -6979,11 +6979,8 @@ static void set_carrier(struct r8152 *tp)
>  {
>  	struct net_device *netdev = tp->netdev;
>  	struct napi_struct *napi = &tp->napi;
> -	u16 speed;
> -
> -	speed = rtl8152_get_speed(tp);
>  
> -	if (speed & LINK_STATUS) {
> +	if (r8152_mdio_read(tp, MII_BMSR) & BMSR_LSTATUS) {
>  		if (!netif_carrier_ok(netdev)) {
>  			tp->rtl_ops.enable(tp);
>  			netif_stop_queue(netdev);

[Severity: Medium]

Can a single read of BMSR here leave the carrier stuck off after the link
comes back up?

BMSR_LSTATUS is latched low. After any link-down period, the first read
returns 0 even if the link is already up again. The commit message says
the first read returned LSTATUS=0 in all 5 rebinds and 6 cable replugs.

set_carrier() only runs from rtl_work_func_t() when RTL8152_LINK_CHG is
set, and that flag is cleared before the BMSR read:

drivers/net/usb/r8152.c:rtl_work_func_t() {
    ...
	if (test_and_clear_bit(RTL8152_LINK_CHG, &tp->flags))
		set_carrier(tp);
    ...
}

The only place that sets the flag is intr_callback():

	if (INTR_LINK & __le16_to_cpu(d[0])) {
		if (!netif_carrier_ok(tp->netdev)) {
			set_bit(RTL8152_LINK_CHG, &tp->flags);
			schedule_delayed_work(&tp->schedule, 0);
		}
	}

So on a down->up transition:

1. The event is consumed.
2. The stale BMSR read returns 0.
3. The else branch does nothing because the carrier is already off.
4. Nothing schedules another check.

The commit message says:

  If the first read still reports link down, the next link-up
  notification triggers another read and brings the carrier up.

Can the driver rely on that second notification? On RTL8153B it happened
to arrive about 32 ms later, but this path was not tested on the other
chips this driver handles. If one of them only sends an interrupt report
when the link changes, the carrier would stay off until ifdown/ifup or a
replug.

The second report can also be lost. If usb_submit_urb() fails in
intr_callback() after the work was scheduled, the error is only logged:

	res = usb_submit_urb(urb, GFP_ATOMIC);
	...
	} else if (res) {
		netif_err(tp, intr, tp->netdev,
			  "can't resubmit intr, status %d\n", res);
	}

delay_autosuspend() still reads PLA_PHYSTATUS:

	bool hw_linking = !!(rtl8152_get_speed(tp) & LINK_STATUS);

In the stuck state it would see carrier off and hardware link up, so it
blocks autosuspend. It never calls set_carrier() again, though.

Before this patch, the check read PLA_PHYSTATUS, which is the same live
source as INTR_LINK, so one notification was enough.

Would it work better to do a dummy read when the carrier is off, the way
mii_link_ok() does in drivers/net/mii.c:

	/* first, a dummy read, needed to latch some MII phys */
	mii->mdio_read(mii->dev, mii->phy_id, MII_BMSR);

Another option is to read twice when the link was previously down, as
genphy_update_link() does.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005105249.1281648-1-lilinmao%40kylinos.cn
