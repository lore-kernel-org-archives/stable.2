Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3694F3A6B8F;
	Fri,  4 Sep 2026 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561841; cv=none; b=FzW6fqD+dCsvNolKDNCp8WhEI7KWDw6Lf/vUvPMlMTfDQaU8HWo0GlOfEz7YAwfIDs8RkuqmtIX3EhfTtayMet1qL6h/JfKUuWvELrWD1kylV2Nfeld+nqgE1NBkZZOuixSuDMhP+8LCuI4V+gKK3vi8AnUT+oOSihg5M8dguDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561841; c=relaxed/simple;
	bh=HfVH5EMzz9zcj2NHRsaCia2CtO9Ns0wpkZxpGiGQyWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gN+kXuzbWl0fhasKYRJfHRtQvyW5i1Y7egsP6bB3snUf5uxNQdGNuYCx4ykZ2SIv74oZBr48zTrD21hu5nKncTcdLw8jz8sMx7Eq047haa4n5H9/YQqrrYm7meYOR1YDn1RQRJnAatxXOBO3ifTn3pUsDqb7o3WB/Xag5awhBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH+vGmAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH+vGmAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CED71F00A3D;
	Fri,  4 Sep 2026 22:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561840;
	bh=yIBEs8YvYOUCU6TvDhVSB8/Kdd+pjsmMutlDKBRYBV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KH+vGmAy8blbtGE5K+Li+x8WNh6h3UNfJ6M3MRudX8a2ucHrFk0ChPc4O4uhTCsYg
	 7wp/6ZwddAvuwqKLCcezqxpPNrgmsn5JE4ErSsX9fqskxkclO5jrLDSVtYKqGgXior
	 KO6NrigTkjkxFU4wQ7/osFXLbuYITgrzTVR8+Y/ocIY828zTYsugCntiA/pHfCL2Il
	 4szNZsawV/CjkW1Jjkio93x+Fh+Z7NHiNkXoc9cEoVdovurOGIkufMhqYo7j6qEqyP
	 QcmLhz0ozj+ceQ3xkqF2a5gb4G/02GeY095lpDZVRpYvR5MZYjFVVcQDog7v23kQt4
	 yijDwdivJT7uw==
From: Jakub Kicinski <kuba@kernel.org>
To: raoxu@uniontech.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	kuniyu@google.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: ipheth: stop RX URB on ndo_stop
Date: Fri,  4 Sep 2026 15:43:57 -0700
Message-ID: <20260904224357.4041665-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <351B4C70CB12AE0F+20260901050604.2523039-1-raoxu@uniontech.com>
References: <351B4C70CB12AE0F+20260901050604.2523039-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: usb: ipheth: stop RX URB on ndo_stop

ipheth_close() previously stopped the netdev queue and disabled the carrier
work but left the RX URB submitted, so an in-flight RX could still deliver
packets and re-arm itself after an administrative link down.  This commit
adds a usb_kill_urb() on the RX URB in ndo_stop, deliberately leaving an
in-flight TX URB to complete on its own.

> diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
> index 2b490114d2327..6b90fe1e0e382 100644
> --- a/drivers/net/usb/ipheth.c
> +++ b/drivers/net/usb/ipheth.c
> @@ -505,6 +505,7 @@ static int ipheth_close(struct net_device *net)
>  	 * it, so that such a schedule_delayed_work() is a no-op.
>  	 */
>  	disable_delayed_work_sync(&dev->carrier_work);
> +	usb_kill_urb(dev->rx_urb);
>  	return 0;
>  }

[Severity: Low]
Can this make a plain "ip link set ethN down" print a KERN_ERR line while
RX traffic is flowing?

usb_kill_urb() does atomic_inc(&urb->reject) before it unlinks and waits,
so a giveback that is already in progress can run ipheth_rcvbulk_callback()
with status 0 and fall through to the resubmit:

drivers/net/usb/ipheth.c:ipheth_rcvbulk_callback() {
	...
rx_submit:
	dev->confirmed_pairing = true;
	ipheth_rx_submit(dev, GFP_ATOMIC);
}

That resubmit then hits the reject check in usb_hcd_submit_urb():

drivers/usb/core/hcd.c:usb_hcd_submit_urb() {
	...
	/* Check that the URB isn't being killed */
	if (unlikely(atomic_read(&urb->reject))) {
		rc = -EPERM;
		goto done;
	}

and ipheth_rx_submit() logs that unconditionally:

drivers/net/usb/ipheth.c:ipheth_rx_submit() {
	...
	retval = usb_submit_urb(dev->rx_urb, mem_flags);
	if (retval)
		dev_err(&dev->intf->dev, "%s: usb_submit_urb: %d\n",
			__func__, retval);

Before this change urb->reject was never raised on the close path, so this
-EPERM branch was not reachable from ndo_stop.

The two sites also seem to disagree about what -EPERM means: ipheth_close()
treats the blocked resubmit as the intended outcome, while
ipheth_rx_submit() reports it as a device error.  Would it be worth teaching
ipheth_rx_submit() (or the rx_submit path in ipheth_rcvbulk_callback()) to
skip the dev_err() for -EPERM?

Related to that, ipheth_rcvbulk_callback() discards the return value of
ipheth_rx_submit(), so the now-expected -EPERM and a genuine failure such
as -ENOMEM, which leaves RX dead until the next ipheth_open(), are treated
identically.  Should the callback distinguish them?

Should the commit message also mention the new log output on the close path?
-- 
pw-bot: cr
