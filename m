Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512659;
	b=B0j7ycjByRkNd9jx12qsmO4gUvQiJH6otokgtSLSJfXnpPEXLPDvrIl5rzpNh4gATYLc
	 lV+lAy8KiLPRey4oZ/BK922lVunxTuD2o1ZHYEtKhhFTfZgdW7GAwX80CFe2/RkZTlNfz
	 a4JLYd2II2XS7JfDYvVL+NlnHmENsXTsYwDnhGo7Y1NCWXkNqsnSw+3722AMseKODI42n
	 G9sfbUA23UwvElEtRYPtQuBMU9wMIvSa+Tc/3nxJNjqGJhhbZ8fbZxEG6WJGtnFwKEll7
	 SRRROdxvpAwd0aHpkTztjPD2+FBQLFl/nnPH480hOs5/2aUROT5b1sY8aL4InksK7sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512659;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=O8a6g5QhV9k5cJH5ydZd3gAgrZOeyFEhq+VUTsANy2E=;
	b=bjLcqOs+etzt9+j69Q7dl+KKMoNZUwmzoFoQQokfjCTItpKx2Svu+akEWXJhXK1KjPdd
	 NsNVLdN4uWRZkpIevlQtD8jjrHIfndJyY1wPJ3OVNI6hXS1EWHVzAN/OdtSr6Mfjy5kkb
	 D5J6PveOe3UESaKrn2OQ2iYoQi6T8jxHIwVAz85NQbo2IebusbzDyjCEJzxq7ZSxbR7Yf
	 uDLOw3wIpfpb+3bMB7qin/LX142hffEw3d8iCducN8KBk9pNnW38PVm90qRXMBgVJPB55
	 7KaVRz8Duinppc+mJFGAQfgtZn0GNq2KGVP6ysGJRF+EQfEkQCieWdZO9E3+Zv+w/ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neELXo5s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2B606A32A;
	Tue, 24 Nov 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neELXo5s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A405A1F000E6;
	Tue, 24 Nov 2026 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512659;
	bh=O8a6g5QhV9k5cJH5ydZd3gAgrZOeyFEhq+VUTsANy2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=neELXo5smmln9BSULr6bIggpxkJdrw0ziYmTfNyoxicF+RJ9olWIwhBSuvbz8HdOw
	 Vza44OZ0+pjfsQh2bz+GXda5WCTWvw0a3UhGP3+lT4bns9CsrDK1OGOG3C4KVRE009
	 UD8/U1DpEYbNEZZJT5W/rqpdSs5mjwNB2btCzyd4wshFQ5uazc31bEzrfDxmwEL8tG
	 CbYV4UHL22APDF6JKOyy8OiomrdGnAAZVCW5Zs78qQdHMgod+lzMdJ3PIIsUg4cBZv
	 X0orF5A2XyZcwPrg7t7deB5HyPbvVUcA8wVQi2ZEn1KSRdNt2I7ssLm0bgcgRqdg4E
	 qcjvcRJdOjNNQ==
Subject: Re: [PATCH can-next v10 08/14] can: gs_usb:
 gs_usb_receive_bulk_callback(): use dev_info() to print re-submit info
 messages
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 09:30:58 +0000
Message-ID: <179551265819.3131.8321640293465934935@kernel.org>
In-Reply-To: <20261122-gs_usb-fixes-v10-8-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-8-7c165c35d04a@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a defect that a specific earlier commit
  introduced, but it has no Fixes: tag.
- [Low] The commit message does not match the code.

--

can: gs_usb: gs_usb_receive_bulk_callback(): use dev_info() to print re-submit info messages

This commit changes the IN URB re-submit failure path in
gs_usb_receive_bulk_callback() to use dev_info_ratelimited() on the
parent USB device instead of netdev_info(). With this change the message
names the affected device even when no network device has been
identified yet. It also drops the NULL initializer of the local netdev
variable.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260729102802.505168-1-mkl@pengutronix.de

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 308daa2645ada..75adec495e657 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -819,9 +819,10 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  			if (parent->canch[rc])
>  				netif_device_detach(parent->canch[rc]->netdev);
>  		}
> -	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
> -		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
> -			    ERR_PTR(rc));
> +	} else if (rc != -ESHUTDOWN) {
> +		dev_info_ratelimited(&parent->udev->dev,
> +				     "failed to re-submit IN URB: %pe\n",
> +				     ERR_PTR(rc));

[Severity: Low]
The commit message says:

    Replace netdev_info() with dev_info_ratelimited() to output the affected
    USB device, and also rate limit the number of messages to prevent log
    flooding.

Is the "also rate limit" part accurate? The old code was already rate
limited by the net_ratelimit() check in the else-if condition.

What actually changes is the rate limit state. The old code used the
global net_ratelimit_state, which all networking messages share. The new
code uses the per call site state that dev_info_ratelimited() defines.

There are two smaller mismatches. The subject says "use dev_info()", but
the code calls dev_info_ratelimited(). The commit message also doesn't
mention that the netdev = NULL initializer was removed.

The removal looks safe at this commit. The short read check jumps to
resubmit_urb before netdev = dev->netdev is assigned, but the code it
reaches no longer reads netdev.

Could the commit message be updated to describe these changes?

[Severity: Low]
This patch finishes a fix for a problem that an earlier commit
introduced, but it has no Fixes: tag.

Commit 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback():
unanchor URL on usb_submit_urb() error") added the netdev_info(netdev, ...)
call on this path. That call can be reached from the short read check:

	minimum_length = sizeof(hf->header);
	if (urb->actual_length < minimum_length) {
		dev_err_ratelimited(&parent->udev->dev, ...);

		goto resubmit_urb;
	}

That jump happens before netdev = dev->netdev is assigned. If
usb_submit_urb() then fails with something other than -ENODEV or
-ESHUTDOWN, the message is printed without a valid netdev.

Commit 494fc029f662 ("can: gs_usb: gs_usb_receive_bulk_callback(): fix
error message") carried Fixes: 79a6d1bfe114. It only set netdev to NULL,
so the message prints "(NULL net_device)" and does not name the device.

Should this patch carry Fixes: 494fc029f662 (or Fixes: 79a6d1bfe114)?
That would let trees that took those commits find this follow-up.

>  	}
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-gs_usb-fixes-v10-0-7c165c35d04a%40pengutronix.de
