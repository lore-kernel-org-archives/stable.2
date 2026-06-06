Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F430C152
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780731702; cv=none; b=gqTmKmDPvS0JFphAWOhZZJSD7bA19CpXwQozsCGFaZJcYTR5vp4krFO22OrCoFpPWO7qmxMrpUSAUikhhyEWNZ+TeNiytvhAZRBMvC1hbJNIgKQitfMwGNiWX8JS34lk5M4tZWBWCBbaQLb2AynDucVGBoP2tGshB+28rwxarG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780731702; c=relaxed/simple;
	bh=+W4zr0DGXAhGKWxwBMseoH9iSnzHN58utPlU8K0DQXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gO/paGVUd6YXsdnb+7V4cFzPATgiirpMCUTE4JFEFVlWudePWdsO9SGvh6A53AHEUNMfnX821BS+hnWgfzxtjDLXF287NzrZ66wVQi53KjSgargWsZD3kS0jyq0Ag0nettFYsVRfNc8Fxka69AcZyZ+TipMOXCf9iDb2+auIHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=aNx8mBDY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AVPuqdLn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="aNx8mBDY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVPuqdLn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2AB9FEC0195;
	Sat,  6 Jun 2026 03:41:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 06 Jun 2026 03:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780731698;
	 x=1780818098; bh=kX0K9nG96KhIB611PiGQwvOKCGrWsKHoQTYqfZU9ugU=; b=
	aNx8mBDY9EflEnUsYc3eUh6MBXja12V3YaRsaH5s3mPH6Q95jREbgFIfzVHwapvM
	fmWZs287ZtBbk0/jy41T8fUMDojQS5UQFxrBPBcJO9NwCNq0JvejYN4K0DbGJbs+
	IUnDebRrDjeg5o0jqOFE+ivJWlPAEk9n+4+djIpgPVVCQx0aoPQtxif3i9oO1oQS
	EQAevHIV8a2JX/Wrc3RzKYyrWAAiBq0CoT6H1YMaM1ZAU5u+5GXhiwKX0g27lCqO
	UQYecCRycfFbpu15McqWxvVjUn7uACoJ3mSashwXzlzaJkCVpA0W1nPiH4YPHZjg
	lXANneMnrGV7gXVDP+5csg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780731698; x=
	1780818098; bh=kX0K9nG96KhIB611PiGQwvOKCGrWsKHoQTYqfZU9ugU=; b=A
	VPuqdLnDAsHO4ljmqXnBf89eGvlXlq/Nh6I1olfWpWPuUh+FGJDxcuEu4NCi/QKP
	gkHPYZkLTSf3850IDAtyglm1iqohcgBh+kaEwUYqPvfuiFaEszRPcf+ZFUB4kNyn
	7yyhLYqRsOkaS/wyU+FIkIKDohV0AM29aWdntIPSAA3Fucc+fGjAcoC0MLfi4lgK
	k6u/IDhn/bLJ4JrWWQ7htk5zv2cRy0DnAHqtjk9JTd5Wp2bfjAK9TeRAsADO3rrt
	BTCFi+De5tLMrAPByj230tiD2dFDQQZ/DG199sxWpiy4vXh1LV7b+NTXrGsadIMv
	gNSLPdIawYynYAjhvwG7Q==
X-ME-Sender: <xms:Mc8japAtJNGH1XiiNV_xBcJYIgf9vf07V2vjYGvviEwFvtLWXNZIOw>
    <xme:Mc8japDwt_OeNt5ANiIVY5pANqGPbamG0jCh8crv_1yms5J53gOBcKj9WnCWk9hud
    vAvZA2s9UIkQqhEKXQo1ja6eFQPUtzIlMh5i31j_92XQNH6giNp>
X-ME-Received: <xmr:Mc8jakqKSOHxJMuzVh8IPt7yT3IhDyuo3ZJPtrJAtaJh5zpFNI6LNAFDSxTP8sn7TtU>
X-ME-Proxy-Cause: dmFkZTECkBeHEWa1B4RAF0h7O2iSS1Z6WaoUzCAjdA1445jr0wJ6hXZYHqsNQvbwt4L/6E
    lue3TLaPpx67LB7Uq0zt3ZNEX5xuXbgRszm36pecMNn96k8mWXSGuBwvyYel8/QZKQOoYe
    p18RBHL3gl2xyIfLuekZQSad45ZCG9SyjGdtHKJP9g/aq8P/RUZfmK/b6NtS4bUg/5NydC
    BVzSsGS+a0ZWVa9fMLcNjEt0MsN16rRZaq9KYlHaL8jVVNVyUkgcCP/ZLfP5+I+fCHFq5r
    gAGHPv6q8LXqXrtFoX4IGWdYCw6LAeqON+z61bT2BOvqSAfu8KP8XBpxL2OAbi/020qxEK
    cR9GK4Q6ahdFemNvv5dO3nLUSvpqufWKZlNxJmhhCK7rp/cWxlDgPEWi3wSKtv7KvFnBbS
    DLM+6pAoccMuzj/6WBu2Re41Yq9Uah32vJLuSwrmuQIz7gRFi7kS8jcyOz9TgMjeYNAyJQ
    BY58xADz0CvHth3O1iF5SUy0EfEHJ1Hc5VZ2vve4aWKu1I+142GpHXbdi5uIcPJwXwyw9S
    JHd2opIZEp3mJViNz+sFGDevU1PaoBCazDjBfx1XC2ck09AloNA+PP54XqvHX2sA6V+85h
    8WGkm5VS1YBE9wznUyTw4xNEveiVY/ntadBa+SbJkZ+mak4kAdYIFJTPDJlw
X-ME-Proxy: <xmx:Mc8jajm3VcTQeIkMENWQp9qnysqkdhpadGiaN6JEfr46y-XjCaLtjQ>
    <xmx:Mc8jakyB4Uf6TVcH_lHxSEXdxTJoIqkviRPPUsjgR-4pk2LY5AdVrg>
    <xmx:Mc8jar-Wr0b14Gysli9UASTpQUaabbMNxBmUkAWOCN3fsD8IYSzKsA>
    <xmx:Mc8jagIkCr3QCKg8v0py9NSb_3EkZOs6Gaq7PVA278ei6Yu3L4YfTA>
    <xmx:Ms8jaujdl9Ah5HqVdR-X-wp005fU9dxpvT2IoMoQOa93EWXKuBOHMq14>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 03:41:36 -0400 (EDT)
Message-ID: <742e68e6-c456-4655-a441-aaa8267f1a48@bsbernd.com>
Date: Sat, 6 Jun 2026 09:41:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fuse: end fuse_req on io-uring cancel task work
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, Chris Mason
 <clm@meta.com>, stable@vger.kernel.org
References: <20260605192708.141921-1-joannelkoong@gmail.com>
 <20260605192708.141921-4-joannelkoong@gmail.com>
 <058fd2d4-3ba4-46e5-9107-3a7e0ab66653@bsbernd.com>
 <CAJnrk1YHQEtpwA-ForFWXsLntc950ekqAHg=L9VExVfJ2WF1Rw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAJnrk1YHQEtpwA-ForFWXsLntc950ekqAHg=L9VExVfJ2WF1Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/6/26 01:52, Joanne Koong wrote:
> On Fri, Jun 5, 2026 at 3:09 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 6/5/26 21:27, Joanne Koong wrote:
>>> From: Chris Mason <clm@meta.com>
>>>
>>> When io_uring delivers task work with tw.cancel set (PF_EXITING,
>>> PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
>>> fuse_uring_send_in_task() takes the cancel branch, assigns
>>> -ECANCELED, and falls through to fuse_uring_send(). That path only
>>> flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
>>> it never discharges the ring entry's owning reference to the
>>> fuse_req that fuse_uring_add_req_to_ring_ent() handed it at
>>> dispatch time.
>>>
>>>     fuse_uring_send_in_task()
>>>       tw.cancel == true
>>>         err = -ECANCELED
>>>       fuse_uring_send(ent, cmd, err, issue_flags)
>>>         ent->state = FRRS_USERSPACE
>>>         list_move(&ent->list, &queue->ent_in_userspace)
>>>         ent->cmd = NULL
>>>         io_uring_cmd_done(-ECANCELED)
>>>         /* ent->fuse_req still set, req still hashed */
>>>
>>> The fuse_req stays linked on fpq->processing[hash] and
>>> fuse_request_end() is never invoked. The originating syscall
>>> thread blocks in D-state in request_wait_answer() until
>>> fuse_abort_conn() runs, which can be the entire connection
>>> lifetime. For FR_BACKGROUND requests fc->num_background is never
>>> decremented either, so repeated cancels inflate the counter until
>>> max_background is hit and all later background ops stall.
>>>
>>> The non-cancel error branch already handles this correctly: when
>>> fuse_uring_prepare_send() fails it calls fuse_uring_req_end()
>>> before fuse_uring_send(). The cancel branch must do the same.
>>>
>>> Fix by calling fuse_uring_req_end(ent, req, err) in the cancel
>>> branch before falling through to fuse_uring_send().
>>>
>>> Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uring")
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>>> Assisted-by: kres:claude-opus-4-7
>>> Signed-off-by: Chris Mason <clm@meta.com>
>>> ---
>>>  fs/fuse/dev_uring.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index 7cd50990b097..b5cc700575ca 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -1222,6 +1222,7 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
>>>               }
>>>       } else {
>>>               err = -ECANCELED;
>>> +             fuse_uring_req_end(ent, ent->fuse_req, err);
>>>       }
>>>
>>>       fuse_uring_send(ent, cmd, err, issue_flags);
>>
>> I think that can race with fuse_uring_stop_queues(), which leaves us two
> 
> Hmm, I don't think this races with fuse_uring_stop_queues() as
> ent->state here is still FRRS_FUSE_REQ and fuse_uring_send_in_task()
> can only be called for a registered fuse ent, which means the ent has
> already grabbed the queue refcount which will trigger the async
> teardown worker to run in the background during abort until the ent is
> reclaimed. I think this adds a race though with the request expiration
> checking logic which (a) fixed, so I think you're right that we'll
> probably need the same cleanup here. I'll look at this early next week
> and send a v2.
> 

Right, actually no race at all, just a plain use-after-free, because the
entry is set to FRRS_USERSPACE and then cleaned up during connection
abort and then released again through fuse_uring_queues or
fuse_uring_async_stop_queues.

I actually do not get this part of the commit message

> When io_uring delivers task work with tw.cancel set (PF_EXITING,
> PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
> fuse_uring_send_in_task() takes the cancel branch, assigns
> -ECANCELED, and falls through to fuse_uring_send(). That path only
> flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
> it never discharges the ring entry's owning reference to the
> fuse_req that fuse_uring_add_req_to_ring_ent() handed it at

A mean exit does not trigger fuse_dev_release() with a fuse_abort_conn()
from that function?


I do not think we need 3/3 at all.


Thanks,
Bernd
