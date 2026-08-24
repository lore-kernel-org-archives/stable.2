Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4028E3655CA;
	Mon, 24 Aug 2026 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584406; cv=none; b=qyEwnHJ0eiPaja03/3kKSzBKc8VuDxsN0UCaJCP1gQHPLEsxQ8oaImBWrY/qv9HlMNB5Yvv7sAI16o/2Z9W5g1l+SpQ6HBBi2mn/T+bz8I2dEjvprLCVhVm84jCgqvNPJm02XO61TjfdcNahIGU1zObQiNwTI6SGRyZLbSDrmwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584406; c=relaxed/simple;
	bh=LMUl0wRqk8+xqojqeT+SrIqH8HRZqBkNpw5r+kVtCp4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tYmIZmhfvW0D6Ohrn6lJT4uME2W2gqPD2M+tDIo5mohVZoPmMRB5+gSFBPi3LTE8eZ9GBwfgRrq/ko4/oJzhSopmCMOI2TCS6gXjIOiiMZx80VhPlS0fG/gij4ledRqw81E+yvJ3W8v1iDwadGB28srh9uV3x7KLGZcNgWgnMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Vd/XN1i0; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Vd/XN1i0"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15017A02A3;
	Mon, 24 Aug 2026 17:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787584396; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g2xnyjbL7P8HZTzEf65T2GecraVsWg2Jd43dBvLVMt8=;
	b=Vd/XN1i0CL0GldedKnpeyvV+Vlv5B0hFCIyJjqg8nN0knzNp5a9OUhscpONcUs8CMyfogY
	fPerXxJEgz1Xr62Ml6PiAMYAoIvSQGfzzoxmTfJV47SzJ4VwNKceRadBZsn1haH0sgrh34
	P29MCwRTHxRM/z8ppQToaslxBRSPNy5Mo3s/g3WQtgt0ZKrXiZo1DvjPlmeQsMHB3L+NoA
	Kjuibwgl2chYyFIvRqzVZBaJwU+1lpuicmspP1boTkM8JeP1uwHovwZd7lQ7EsU4Z/Hptw
	I63REv8GSBbQzpksGlDa/eCoQqlcZSsh+eatDLXU8sToU6w83TAKXlKok0z8nw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 17:13:13 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Breno Leitao <leitao@debian.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: fix spurious TX timeout after dev_activate()
In-Reply-To: <20260824-trans_start-v1-1-0419cc427ed9@debian.org>
References: <20260824-trans_start-v1-1-0419cc427ed9@debian.org>
Message-ID: <4f3857029d855ed4e513ae01a2e8f018@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Breno

On 24.8.2026 13:45, Breno Leitao wrote:
> While debugging another issue today, I found out that my TX queue is
> stopped for 136.07 years (4294907392 ms).

nit: 4294907392 ms is ~49.7 days

> 
>     bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 28: transmit queue 
> 23 timed out 4294907392 ms
> 
> 4294907392 is not an elapsed time. It is the value of jiffies at that
> moment: INITIAL_JIFFIES is 4294667296.
> 
> dev_activate() runs transition_one_qdisc() over every TX queue, which
> resets trans_start to 0, and then stamps only queue 0 through
> netif_trans_update().
> 
> Stamp jiffies instead. A queue stopped across dev_activate() now gets a
> full watchdog_timeo of grace, and is still reported if it is stopped
> that long.
> 
> Fixes: 9b36627acecd ("net: remove dev->trans_start")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/sched/sch_generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index ef2b4bf515641..4539dc2c6d380 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1278,7 +1278,7 @@ static void transition_one_qdisc(struct 
> net_device *dev,
> 
>  	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
>  	if (need_watchdog_p) {
> -		WRITE_ONCE(dev_queue->trans_start, 0);
> +		WRITE_ONCE(dev_queue->trans_start, jiffies);
>  		*need_watchdog_p = 1;
>  	}
>  }

Follow up or v2: netif_trans_update() in dev_activate() now seems 
redundant?

> 
> ---
> base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
> change-id: 20260824-trans_start-557ecd4c8866
> 
> Best regards,
> --
> Breno Leitao <leitao@debian.org>

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
