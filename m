Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064234B2CA0;
	Wed, 16 Sep 2026 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582761; cv=pass; b=pwCU/80q6nzAKuBEAb2brtTNAkr0M8OPn1bF/1hsTzpZ3mUz9+Z4I+BP+Q1Y1A2twEL8NF/j3qFDC3wnmK6c8/uWrtCRN6YTeVBD1lHvAtNJoL3vO/IVVIlsyd0fmk2ipr+v/Me1v/Q4H7tHRCOMg+WJ3qKXpVcnw/xMYbcMbw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582761; c=relaxed/simple;
	bh=nWzo0HDo6N8NvfD7Eu6Y0tEufvFTL/scvLxOulxh/R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9zbgoXbsV6QMGHtUIwBsfzh2X6WgFcyE/Il/+FD5sSoJCtiP+OZPVl9ODpoVAqPn3XiSQkVQAsflTwyA+gO5trIOutc1dVMwi2RRqZzgf/KJa6B7emjaBCbNZNRnnglEavv8f4y3ZLMgBTqWDnndVOYawusC9C5vn6tn0q8k0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikuyo.dev; spf=pass smtp.mailfrom=ikuyo.dev; dkim=pass (1024-bit key) header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.b=v+l7ySEq; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.b="v+l7ySEq"
ARC-Seal: i=1; a=rsa-sha256; t=1789582727; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mwJGAepeUYis/lVmnwjq/9VkTbEnw43TaQHwkIT4W0/tMAz2N/oMCpdz2TFInlwbGwZmBz2WeCqkls9ISSh1btwOjidCvYulwjhlyXjN30VhDrVspF91U05p55cmMOS8jfg6niFR2hY52N62byNTB9MPMMbQqAeguvVk2aJ23hQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789582727; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y+UfJbuF/uO6cDN3gMGHg0bTeAtYo5gesNGocK4DlJM=; 
	b=ILfo7I/tbukok9OC49d/6Wn9lY3do1UmgrATzk0+edD9i873nrEKT+O3c4am/gyi8ZgtVRa/JdJVYGkHoLejnKecbpkhoA/8vTE1pLBpyHdBpeLkSCA8nigS/ghqLkOHXKO5WQFpPn/Gj4OjKVEfuWPH67WEVDISZZkZ1z8kTtw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ikuyo.dev;
	spf=pass  smtp.mailfrom=eritque-arcus@ikuyo.dev;
	dmarc=pass header.from=<eritque-arcus@ikuyo.dev>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789582727;
	s=zmail; d=ikuyo.dev; i=eritque-arcus@ikuyo.dev;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=y+UfJbuF/uO6cDN3gMGHg0bTeAtYo5gesNGocK4DlJM=;
	b=v+l7ySEqqJm7z8oINH3Vds6fgaEAyUD0NNeLu6ufvcTTcwhMYClSCrrgyHym2G0K
	HscPeYMDq7ra0GG2rensYvZwEWxiB2VE+h2F0/d4EpBL7+xy5MwuGOLtb0ePpnPn4+o
	4nPcQWOzjNLWji1JmCaqFe8I4KC7Edh0YuCuZ/VQ=
Received: by mx.zohomail.com with SMTPS id 1789582726216729.0547607155628;
	Wed, 16 Sep 2026 11:18:46 -0700 (PDT)
Message-ID: <050b2eb3-3435-4180-935d-c03f3972e11c@ikuyo.dev>
Date: Wed, 16 Sep 2026 14:18:44 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] can: kvaser_usb_hydra: reject too-short commands in
 the receive path
To: Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, blbllhy@gmail.com
References: <20260815-can-esd-hydra-fixes-v1-0-de644cbeaec2@ikuyo.dev>
 <20260815-can-esd-hydra-fixes-v1-2-de644cbeaec2@ikuyo.dev>
Content-Language: en-US
From: "eritque-arcus@ikuyo.dev" <eritque-arcus@ikuyo.dev>
In-Reply-To: <20260815-can-esd-hydra-fixes-v1-2-de644cbeaec2@ikuyo.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc, Vincent,

Please drop patch 2/2 (kvaser_usb_hydra) from this series. Cen Zhang has 
since posted a standalone fix for the same hydra receive path that is 
more complete than mine.

<https://lore.kernel.org/linux-can/20260819145658.29872-1-blbllhy@gmail.com/>

Patch 1/2 (esd_usb) is independent so please consider it on its own.


One note on the automated review of patch 1/2: the issues it raised are 
all in esd_usb's probe and tx-done paths. I've kept this fix narrow 
rather than widen it into those, and will look at them separately.


Thanks,
Yiran

On 8/14/26 2:05 PM, Yiran Qiu wrote:
> kvaser_usb_hydra_read_bulk_callback() walks commands out of the RX URB
> buffer, using kvaser_usb_hydra_cmd_size() to determine each command's
> length. For an extended command (CMD_EXTENDED) that size is taken
> directly from the device-supplied 16-bit length field with no lower
> bound. A CMD_EXTENDED command whose length is zero makes cmd_size 0, so
> "pos += cmd_len" never advances and this URB-completion softirq spins
> forever.
>
> Reject a command whose reported size is smaller than the command header
> before it is dispatched, mirroring the minimum-length check added in
> commit 0293dd153f9d ("can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd():
> validate received command extents"); that fix did not touch hydra's
> asynchronous read_bulk_callback().
>
> Reproduced with USB_RAW_GADGET + dummy_hcd on a KASAN build: after the
> normal probe/START_CHIP handshake, a 6-byte CMD_EXTENDED frame with the
> length field set to 0 makes the callback loop print
>
>    kvaser_usb 1-1:1.0: Unhandled extended command (255)
>
> without bound (306000 times in ~75 s), until
>
>    rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>
> and the machine had to be killed externally.
>
> Fixes: aec5fb2268b5 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yiran Qiu <eritque-arcus@ikuyo.dev>
> ---
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index efbb7bed34c9d..d44f9875fbe2f 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -2156,6 +2156,15 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
>   
>   		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>   
> +		/* An extended command carries a device-supplied length; a
> +		 * command shorter than the command header would never advance
> +		 * @pos and would spin this URB-completion softirq forever.
> +		 */
> +		if (cmd_len < sizeof(struct kvaser_cmd_header)) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			break;
> +		}
> +
>   		if (pos + cmd_len > len) {
>   			/* We got first part of a command */
>   			int leftover_bytes;
>
