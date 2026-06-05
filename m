Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E85D390CA9
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697385; cv=none; b=WrSFhw6bgHpsbdvOWISqlyZi5q4sa259pANRtgsb31BkPe2rcixRqQwZoDtj801U9VkLsHl6wxj27qQQbitNeLJIQkvdboS1N7MUc84VzznYijVBQ9mpeDYXZa4HN0P5gRB4cmzQQoN0cFZLmWXrYiQ6+yy0Cn4CzXSJ+99ORlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697385; c=relaxed/simple;
	bh=89bKrDgiYLlIYMHyRyyy3WzSFWbKD7kzrdaUGZI7sZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XemA2Xy9CI+PzSqoTIMIB+eOlz7jrNiV8L2i2h782wRKImbXtL3pyRW3shSh9IQNZpwMKlW88bRAOTe1eGRL77XD2WQSuLpa+ZKDd2REWRurCn4PsBFr+pTdH8rTqJb9MX0UlU8PU9a2E6u/h/K7F0YYm7QHmQ79tcApZ/twu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=zIlGkxv6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h8dUkpnD; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="zIlGkxv6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h8dUkpnD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92EFA7A0148;
	Fri,  5 Jun 2026 18:09:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 18:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780697383;
	 x=1780783783; bh=HfGaltYFlaYxSdxo2CBT6e+H4cx0pQpTp/gdj3c600k=; b=
	zIlGkxv6Sg5heUCZxbzIVSqO66HhcToPEbJXX8/HnfCABO9L8/KghmfafsD/o2WR
	ilSjZB3w14XbXUS6a8kQ5TZnzPEMdfIZHR4jhMeJLFh0sdFUzts+bbQJxc/HJpXo
	pDHoK9hh6UYEsBxQYTyZbMVSlCuzmz6NcpIy4efB8kujJSIjKMwKWoUULGJZNwMx
	VgB5WiLQo6/yN0Mr8fEvIqcaQvzU9vPbTTTGs6iluLFFNkvsBqDzQ7DnSfJEiY1g
	iOA/O/BIEkDE7IDTmBjFkt3gpq0xJgI//cBg9qgossW6/0f2/UFlSlZHTc8xArbW
	UuSI5dXmdHXw1AygZrdsnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780697383; x=
	1780783783; bh=HfGaltYFlaYxSdxo2CBT6e+H4cx0pQpTp/gdj3c600k=; b=h
	8dUkpnDHiFGMFvlNRCmmloEXe+k0DN3jePEUuEtY/omfhEYc4+pN9RFynBKDkFPz
	6Ab5OtZGHKTQAw8MTVxh8VLUyrrWRfrT+M/KV+oPBfOGD6pu5Vh1hyQhYLiYbzgM
	T4lSXvYslea6BEV7GX+Rtd0fCnrKgxjjqYkS8Dx6pvkqXlZt+py/i0YPqHrazyjv
	tRHzltSL7Vd7Z1gv3kK/ZKqPIChXuE3Gug9UoTGJaC6YfRudq7jOSKmsgxCNgqrk
	0ikV/aBqSldH7powoyYyOmslDizlKUA6gN95ji+WGEELOvEYhf15muKlEv0ul9N5
	P1NCCI3h5OLF9nsPuaS0g==
X-ME-Sender: <xms:J0kjavghO__agWofe-hB3477mGnJvpwBpQX8r80wRzQPQ3RyVsKueA>
    <xme:J0kjathw87Kih0PmVqWPO38vuoTr3rf2DTIIEKFLty73SMgKqBahVuG2uDwiTRTNq
    rThh603AMIwtYyQ6e0cGYACiPx7U2-ISvUL1UfTtQGA8v1Tc667>
X-ME-Received: <xmr:J0kjavLYPnVuWmMsd9q9f15mtZTcAny1_Q1IPigmk9rySXMRT9pi848jN1UNHAQWusbGNnt_sMVZifSyV63VYT4ZU8DCGLgVrOcyPwRu9kMhNzdBig>
X-ME-Proxy-Cause: dmFkZTGW4nbf+5cfvhA1JzQErJo+Dl+bekfkFgaXEv06kPJ3Aakp0ZocczSlXp9cuYyVSB
    64AyfIdTlKYaPWMH8+xF3hiQwqO985WolubJPWZQ+DDL8Ces8S9qU76Mex8ziN4e16Qwyb
    fk0VQIEs6LqVYpyZIyzLkhxRLucuH190GKWMzg6nzZz/v1ywOc2cIUMCyXEr30yGILjh53
    JLkMfgXS3HPdEJuJff0/euuBvfkus/arEmYNrM4snWGHdGFe5Ec3yPkP0UCKvVPPBtHInZ
    FeiAdQ7HlbFl8GrZuUhpPdCrWOdAvKYMGV3dEdjvwYPA61Li2ZBPQTAOLPcNDshLOr4mRx
    19SFIghE228JPHaAeuaYSof+hCXl3MQxMxz6Cixy7ip2joLHIXmOpnJsKa312Lj0XufjHU
    OW8a90pgiY37pUlGGqdD16kIEkw2jMg+OZyVxN8aoSUU98LNKuPJeOT/t5Ff+2BkziqYxM
    O0W0MUgg/wZzplfMBOumto4vQte1FywLJBxxHTE5DXneKcdCZzcd/tAEeS6lcCUyIMy5PV
    Pi+F19hkMopwkBjZJi6xhVQIFqNWA+mmjq4Awi3Zk4K+CdqCUFMhF1YYwnpSf06Sc8+y0q
    CEc3tgfgT1q+I1sm7dRBMx9oq9EymVyuKZ27tJ74x1IeaPNSJ/FVu1uHWROQ
X-ME-Proxy: <xmx:J0kjasEkwEFeKXc95Tfu0S1v7jlXdwafnxACWhNibn76DGQEo4-5Zg>
    <xmx:J0kjajRU-jVFmJNfCEa3UT_KHkgbQ6Ep0XNTafQhHciwV5NN_sHnxw>
    <xmx:J0kjaofTnZKVRamSeZuIhEpwMmyJ4LkN9ZOy2-bmeFWnJT6O49gqcg>
    <xmx:J0kjaiq1dZQ0bcJdiZPFIML7TDLFYINYoNlTbj85ZXOYKvz-MS41lw>
    <xmx:J0kjavDsNqGfeSlwdXNK5_vrvQc6qwoWqyXf8fOKWsko7mFlgepzIaD5>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 18:09:42 -0400 (EDT)
Message-ID: <058fd2d4-3ba4-46e5-9107-3a7e0ab66653@bsbernd.com>
Date: Sat, 6 Jun 2026 00:09:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fuse: end fuse_req on io-uring cancel task work
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, Chris Mason <clm@meta.com>,
 stable@vger.kernel.org
References: <20260605192708.141921-1-joannelkoong@gmail.com>
 <20260605192708.141921-4-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260605192708.141921-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/26 21:27, Joanne Koong wrote:
> From: Chris Mason <clm@meta.com>
> 
> When io_uring delivers task work with tw.cancel set (PF_EXITING,
> PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
> fuse_uring_send_in_task() takes the cancel branch, assigns
> -ECANCELED, and falls through to fuse_uring_send(). That path only
> flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
> it never discharges the ring entry's owning reference to the
> fuse_req that fuse_uring_add_req_to_ring_ent() handed it at
> dispatch time.
> 
>     fuse_uring_send_in_task()
>       tw.cancel == true
>         err = -ECANCELED
>       fuse_uring_send(ent, cmd, err, issue_flags)
>         ent->state = FRRS_USERSPACE
>         list_move(&ent->list, &queue->ent_in_userspace)
>         ent->cmd = NULL
>         io_uring_cmd_done(-ECANCELED)
>         /* ent->fuse_req still set, req still hashed */
> 
> The fuse_req stays linked on fpq->processing[hash] and
> fuse_request_end() is never invoked. The originating syscall
> thread blocks in D-state in request_wait_answer() until
> fuse_abort_conn() runs, which can be the entire connection
> lifetime. For FR_BACKGROUND requests fc->num_background is never
> decremented either, so repeated cancels inflate the counter until
> max_background is hit and all later background ops stall.
> 
> The non-cancel error branch already handles this correctly: when
> fuse_uring_prepare_send() fails it calls fuse_uring_req_end()
> before fuse_uring_send(). The cancel branch must do the same.
> 
> Fix by calling fuse_uring_req_end(ent, req, err) in the cancel
> branch before falling through to fuse_uring_send().
> 
> Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uring")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/fuse/dev_uring.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 7cd50990b097..b5cc700575ca 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -1222,6 +1222,7 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
>  		}
>  	} else {
>  		err = -ECANCELED;
> +		fuse_uring_req_end(ent, ent->fuse_req, err);
>  	}
>  
>  	fuse_uring_send(ent, cmd, err, issue_flags);

I think that can race with fuse_uring_stop_queues(), which leaves us two
choices


a) Same logic as fuse_uring_cancel() 
https://lore.kernel.org/r/20260515045541.1171335-4-joannelkoong@gmail.com

(also introduces slight code dup)

b) avoid the code dup and send it through fuse_uring_entry_teardown()
with a bit refactoring. I thought I had send an updated patch version
for that, but don't find it myself anymore. Explains why I never got
reply. The old patch from October had bug, but I'm rather that I
posted an mail with updated inline patch, not as separate series, 
though.


Thanks,
Bernd


