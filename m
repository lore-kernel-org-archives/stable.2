Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117781;
	b=0GiG7OPEfSHqP/IMHxx3oPHP7Y7qkUrOnbmoaPlT8Gnk0IK+xTtOaS9bgH12WphovvVF
	 2i7kU9cEIEq/4Q2PoAVYiOz9dVSeiXiDHPP5rQaeE0IGUyxT0qFp9+WBELNt8/yqCG9M6
	 LPoT+68vSvHHvdW76+UlBJwMrXQvmnlUwGt+Y8vecrziq89LKu2OSrGuQoblzcEBMRsk4
	 nD5efxndBqMW1AjT5QQtHLFPLzdc0IqKEWc84jvYMc1OFekEWdca9gLZt1Lp++lag/KRD
	 czdSOcKG/uhhJSmqClMCWPCUOhXQatVU0SpABYIy9f+bYi2a5Wewn71TvqQgcDJiXbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=M/cTVLWcrP6wdweYhfAlqnzE5SnDU1HjoH6S98HjutE=;
	b=dlTno0OeZ/KPh9MKx/PMNltCXoFgBvT1n6ufxA4U1EVjK9dydscq3J7Thrt/6eAubv2j
	 eQ/WlMX1QhNK/cBD2Ja3KS71GeQgl7fxvxwSml8e/VitjgwSWiODCVEVxwlpEMsBae7sv
	 FKQM9ijJLi+CNDAchvQBsQDdmUgUJQV8UdgwtlBGYjxUSahoLcwErNdouAoylETEtEgol
	 IoCur98VYWKUZ9PwF0cO0nBIZNi7E2PI42ymnzlLMbVWd2aec1oFA5TG374hjjbZLCm7R
	 v4qLk+cIccQ3QEVxz+9DyJF5Swwt0n7OS8yYjm2cc7hpEP5tKSkL5bZheDg4X19DCdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=minyard.net;
	spf=pass smtp.mailfrom=minyard.net;
	dkim=pass header.d=minyard.net header.i=@minyard.net header.a=rsa-sha256 header.s=google header.b=b8Xyyhnk;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E38606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 19:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E38606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.a=rsa-sha256 header.s=google header.b=b8Xyyhnk
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-86298f9267fso107286a34.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1795117779; x=1795722579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M/cTVLWcrP6wdweYhfAlqnzE5SnDU1HjoH6S98HjutE=;
        b=b8XyyhnkF8vi61fWIpOmo3vBz4Kk8ItXPFhW6M2e/n8qgsypfAy0yobR9uEm5ASzes
         eK9RMwlZhMLX+Az0w7NGKDQ0er+lJK9OGmE0Iuzmo6pjaF7KykNqaEthTVt6tj0cDKSz
         mcG0K37URVUGtETIwLzvsv0fBs9yIRobm+NsGRVMJZxxAYhouKOlV1k5Hx4x73le4V9l
         uayhtXfnqswddPlLcevqOqia8X4IPRiPQyBiFuKKg17kNRs3g265qcyXEc9Q0wl2xpbW
         9bJEKVMWyfaIpU2/3j9f4mefcwoXWtypgwQ+D5JJcx2twv3gPjrWnjEFut0wlBFZczcW
         R/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795117779; x=1795722579;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/cTVLWcrP6wdweYhfAlqnzE5SnDU1HjoH6S98HjutE=;
        b=yn+KtyzQBTNb/oOT6cmyY64cAmFGubXaH+r05iGrzzVeDvoxNWk2KIr9I/F97vJoyN
         EjLslH9+wcx+Z4htRLF5FMCMl7cp1VsKIy1WMysrFwqNQurazbsPFMHOAW1ikHvd/1R/
         sjahwyj3L6MiT8CbPTS2N/r3JpFsB1K5zXSn9R1IJMh2dUC4fuOcAFBnzCudnGnO4c06
         OW4BPbvXfHsGaX0mr6KcEgt7RRPLPBuSRB+HrrjfvowZKNezVtbfEvnHpYZeghYlibp+
         MiYggLd8pdke3mGDOyglgxPnJW6OhmmZbxSqzFIdmR1M1sL1Ze52/eIFVMYegHsvRlOW
         zz6w==
X-Forwarded-Encrypted: i=1; AL+hErEnvnu2nRE9tYoVIumcBeiasEw7c0ecgjDmMcWpL9yDTRmoKM3swWszeVAOmlJ3gILFaSQ+5lY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yIZPohIMxxgIkxSZine+2DxtMsqSbaOBRXeiC5BhxS/bM1EvF
	qRZYWNj9KVfSENc26WwoQ8dTRgd/iTzhXmCt1yWVgpqPmK9OtV9iZ5G+uil4J0SLJAI=
X-Gm-Gg: AYBFou31urbmF5JW8TkJeNAOwYRpZyX/72uIeRcthyJ+aRalSIpGexExj3srPI71f/d
	2Hv2+RhzGpFHAcMsp+ebhRXWAM+C5fLTdf/WYT+mTIQ1C4DjSlRq2xPz1rQkxxx3ERyxZxuV0xJ
	I56LmPeq6Dr/gMSYiBJ+UzdGS6D3BlB66k2qdqtWAvz/Hzy8sHDL+Xs04JtASYwpqsUQCumYkr5
	8eJJUhelOnDGsy0A3l9sNd4JBguKEVbElgNudqJ1YaUu5pGfiLyvSXangN3z69WEktSo9DJxn3k
	KtswVAcSMOyyR1eS+/IcIuxe3/gbviawsQc4j2W38sYwtIikC65w2657TzkF/nT1zO9PsrZW3Zc
	CNqCUS5GCq8Sr4u5UdR+s5adiIQ9mpzRcdOpB65q8lGlbUGXWC/b6gI+n3wgV+EbfDQpoEuotZI
	4KYMZAkSZhlrzBWW1twIgM7LgF9s8TX0c1b1ywlo0Lfn7TdYjSriXWbv+3GWBnLSo5GwJV9LFw7
	1YUhFq86r6zG4c8akibduuMIBOxbTNFYu4AIBXQ245JDoHdumhYNxvbtKl+y0lI3zszEq3Asa2z
	QYVLG5iO6IF8l3e2b53sU5ztHFTzveGlSZa8gMrA1joU9hlCChUX4C3XuUO6AN37qstZTWrkGi3
	ndlRIaKV9rkI9YLNuOLwTrgTQMKgndxzbOLKqdZeMvhmu3/lA
X-Received: by 2002:a05:6830:6412:b0:862:a901:21fe with SMTP id 46e09a7af769-86315a0bc57mr1315957a34.29.1795117779142;
        Thu, 19 Nov 2026 11:49:39 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:c1ac:4946:698e:41d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6e7sm468800a34.12.2026.11.19.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:49:38 -0800 (PST)
Date: Thu, 19 Nov 2026 13:49:34 -0600
From: Corey Minyard <corey@minyard.net>
To: Deepak Gudiseva <deepakgudiseva@nexthop.ai>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Stop the thread before shutting down the
 timers
Message-ID: <av9SzjAnkoPaqYea@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20261119-ipmi-add-smi-races-v1-1-3b8b3648c512@nexthop.ai>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-ipmi-add-smi-races-v1-1-3b8b3648c512@nexthop.ai>

On Thu, Nov 19, 2026 at 06:53:39PM +0000, Deepak Gudiseva wrote:
> shutdown_ssif() deletes retry_timer and watch_timer and only then stops
> the kssif thread. The wait at the start of shutdown_ssif() only waits
> for ssif_state to become SSIF_IDLE, but a normal message is sent in
> SSIF_IDLE with curr_msg set (see IS_SSIF_IDLE()), so the thread may
> still be sending one. If that write fails, msg_written_handler() arms
> retry_timer again after timer_delete_sync() has returned. The caller
> then frees ssif_info with the timer pending, and the timer fires on
> freed memory.

Yeah, I see the problem.  Thanks for the detailed description.

This is queued for next release.

-corey

> 
> We hit this on a kernel without commit 88f65f903d25 ("ipmi:ssif:
> Improve detecting during probing"), with a BMC that NAKs every SSIF
> request: registration failed and the interface was shut down while a
> request was still being retried. When the freed slot had been reused,
> call_timer_fn() jumped to whatever was then in timer->function:
> 
>   kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>   BUG: unable to handle page fault for address: ffff888101f30900
>   RIP: 0010:0xffff888101f30900
>   Call Trace:
>    <IRQ>
>    call_timer_fn+0x24/0xf0
>    __run_timers+0x197/0x200
> 
> Since that commit the probe gives up on such a BMC. On current mainline
> this needs a BMC that stops answering after the probe, for example
> while it resets, and an unbind or unload of ipmi_ssif while a request
> to it is being retried.
> 
> Checking ->stopping before that mod_timer(), as the other retry_timer
> users do, would not close the window: shutdown_ssif() can set ->stopping
> and delete the timer between the check and the mod_timer(). Stop the
> thread first, then shut the timers down with timer_shutdown_sync(), so
> that nothing can arm them again.
> 
> Fixes: 00bb7e763ec9 ("ipmi:ssif: Add a timer between request retries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepak Gudiseva <deepakgudiseva@nexthop.ai>
> ---
> Not reproduced on mainline; the trace is from an older kernel, where
> the fix was tested on hardware. Mainline is build-tested (W=1) only.
> 
> If this does not apply to older stable trees, I can send backports.
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 3a11fc4f35..10393aca05 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1285,12 +1285,13 @@ static void shutdown_ssif(void *send_info)
>  		schedule_timeout(1);
>  
>  	ssif_info->stopping = true;
> -	timer_delete_sync(&ssif_info->watch_timer);
> -	timer_delete_sync(&ssif_info->retry_timer);
>  	if (ssif_info->thread) {
>  		kthread_stop(ssif_info->thread);
>  		ssif_info->thread = NULL;
>  	}
> +
> +	timer_shutdown_sync(&ssif_info->watch_timer);
> +	timer_shutdown_sync(&ssif_info->retry_timer);
>  }
>  
>  static void ssif_remove(struct i2c_client *client)
> 
> ---
> base-commit: 63fdb511c27afcebce797e3db580b3534ddfa639
> change-id: 20261118-ipmi-add-smi-races-0b8bce266803
> 
> Best regards,
> --  
> Deepak Gudiseva <deepakgudiseva@nexthop.ai>
> 
