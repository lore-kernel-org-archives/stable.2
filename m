Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AF37A833;
	Fri, 16 Oct 2026 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169825; cv=none; b=r+JW469AstOmMECDxORFRdjAwB2md0cbF0fpp7BpFm+q1e6Opu26YglSs1oyK4mMQyFvoP10nS32n0XwdCctHjtvKMb5fLF83JYgmSclaCyFEPmCxbQqe8+uKHAWO+aeb+pHWqdHh5ipbEm1FJlmwhbgmt4zI04oehbmJvlItko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169825; c=relaxed/simple;
	bh=Akx0YvKoaSycAnST5WW9WCTjIwrjKDBD4IujP+nsVy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idMkLYFMRHnZ9jcbPlzdjKG/16MZrFhS6KTJ51P0k96Q8l9pT2nLi98Gz2fuj13jSPSpAlCOzwlNo4B53kQYY/o3yKUbZ909C1LVIE0ZQGglgoMauR7lgDYic9C5baV1FpiI7eWUTgy/BfPIe3hqEG/20NFrw31IdldpSU7caDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b=YfFF7DuQ; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b="YfFF7DuQ"
Received: from [10.0.36.124] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0ABF64C442F863;
	Fri, 16 Oct 2026 18:56:02 +0200 (CEST)
Message-ID: <5a1b4d3d-c2c4-4b3f-8969-551767309ded@molgen.mpg.de>
Date: Fri, 16 Oct 2026 18:56:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix Tx hang dump using stale tx_buf[0].skb
To: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1792169762; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=M86NJ4IZ6fNbViWJtHydCb8YPVJzzZtCVo1NWFk9yDs=; 
	b=YfFF7DuQldV9OVPmSexX3aVubwPR3i7CDpaUPPEl2FVG7McvNAIyadMcH8KU0dHwLfR7yPtJgvLN
	Vm+a/eC3ntuytUHmF2fFiGPatyVGHvr+9bzMr53XlFLNwf6/4U/DH1DhwHY6mtiwfTPkSI8xRSFMZA
	0tzGsuxV7WmroroHeNKUbT3ckgXUI8x5hOOLgkgM6Zl644V4vI/mQYqWuMk0wKaZJ5EWNl0EEBsC2n
	/XT0YqbVeHElexuLi4TsnW3t8nRH1QMz4hrRtjYtxHLp2ysH9TIJ+TMTeI9dxSARGo2zOSQwCgUIPD
	H79DG8g1YWw+xyVpVLJbA3knh+wc9P5A==

Dear Vincent,


Thank you for your patch.

Am 16.10.26 um 15:08 schrieb Vincent Choiniere via B4 Relay:
> From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
> 
> ice_tx_hang_reporter_dump() always reads tx_ring->tx_buf[0].skb,
> regardless of next_to_clean. The Tx cleanup path frees the skb and
> marks the buffer empty without clearing the skb pointer, so slot 0 can
> hold a stale pointer. A NULL check alone does not cover this, and
> devlink_fmsg_dump_skb() can fault on the freed skb.
> 
> Read tx_buf[next_to_clean] instead, use its skb only if the buffer type
> is ICE_TX_BUF_SKB, and skip the skb dump otherwise.
> 
> Observed on an E810 PF passed through to a KVM guest (Ubuntu 7.0.0-14,
> PREEMPT_RT, local scheduler patch): a delayed queue IRQ led to a Tx
> timeout and a page fault in devlink_fmsg_dump_skb():
> 
>   BUG: unable to handle page fault for address: 0000000004cd0c11
>   Workqueue: ice ice_service_task [ice]
>   RIP: devlink_fmsg_dump_skb+0x2d8/0x5d0
>   Call Trace:
>    ice_tx_hang_reporter_dump+0x1ce/0x210 [ice]
>    devlink_health_do_dump+0xcc/0x190
>    devlink_health_report+0x1d7/0x260
>    ice_report_tx_hang+0x7d/0xa0 [ice]
> 
> With this change and auto_dump enabled, starving a queue IRQ thread
> reproduced the Tx timeout; the dump contained the test packet, no Oops
> occurred and the PF recovered.

Also past the dump (excerpt)?

> Fixes: 2a82874a3b7b ("ice: add Tx hang devlink health reporter")
> Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
> ---
> This complements the NULL check in [1]. With only that check, a non-NULL
> but stale tx_buf[0].skb is still dereferenced by devlink_fmsg_dump_skb().
> I have only reproduced the crash on an Ubuntu 7.0.0-14 kernel with
> PREEMPT_RT and a local scheduler patch, and the skb lifetime against
> concurrent Tx cleanup still needs review. Feedback welcome.
> 
> In my case next_to_clean was 0xfc while the reporter read slot 0.
> Upstream v7.0, v7.2 and current net main (191aa4154) all read
> tx_buf[0].skb unconditionally. Before this change, recovery stayed
> stuck until reboot.
> 
> [1] https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
> ---
>   drivers/net/ethernet/intel/ice/devlink/health.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index 8e9a8a817..059859c36 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -390,12 +390,15 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>   				     struct netlink_ext_ack *extack)
>   {
>   	struct ice_tx_hang_event *event = priv_ctx;
> -	struct sk_buff *skb;
> +	struct sk_buff *skb = NULL;
> +	struct ice_tx_buf *tx_buf;
>   
>   	if (!event)
>   		return 0;
>   
> -	skb = event->tx_ring->tx_buf->skb;
> +	tx_buf = &event->tx_ring->tx_buf[event->next_to_clean];
> +	if (tx_buf->type == ICE_TX_BUF_SKB)
> +		skb = tx_buf->skb;
>   	devlink_fmsg_obj_nest_start(fmsg);
>   	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
>   	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
> @@ -409,7 +412,8 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>   	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
>   	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
>   				     event->tx_ring->count * sizeof(struct ice_tx_desc));
> -	devlink_fmsg_dump_skb(fmsg, skb);
> +	if (skb)
> +		devlink_fmsg_dump_skb(fmsg, skb);
>   	devlink_fmsg_obj_nest_end(fmsg);
>   
>   	return 0;
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
