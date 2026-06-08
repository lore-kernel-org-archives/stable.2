Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469F330307
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938975; cv=none; b=PtQnyFEcts4cxQ8s6JVuvJt8KxQWgjq31IOK/AZzI0k72FQPXgAXVrumneK3P3dTCod9XTLSNcIgTM5SzKbbCwYcb7PE9zrygvyRFyCw0hn7j9B19cQ1Acf/IvaL5y+flE+lASm517oul3jsVKovdv7aBhRGPOTymL+9sxeZWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938975; c=relaxed/simple;
	bh=OAkaQAIbia/UxfKZhhaUSwQpuzcDHqCQxCk2rq6a3NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrDHnmFBfOqMnVX3bXbIy2fL4BumJEodhePCna7/qQaA25+5EuKJaHZOvVHUTH7fbjahjVdoenc0pgezMLAzcuI2L8g2MYXjv9r4Kz9OPIcB3AR3aBtiroP2lr5pJ1ojR7ucCyGMqZwN9Bsh3xbS4iRgOLlejpaVmjpOtyz+o+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=CYwTzEsZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXFLQvVF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="CYwTzEsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXFLQvVF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C7361EC0179;
	Mon,  8 Jun 2026 13:16:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 08 Jun 2026 13:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780938972;
	 x=1781025372; bh=Llc7jokBTI3ed5STjcyZf98qZ7tkpnVXUvGXJkrnG7A=; b=
	CYwTzEsZrTQgh0k2rKX8ultVw8u8+fVD5B9d0EfYSTMuQ66Lh0jbHmQUeTeo90Jk
	0p/07teQ1q8ue3G2HyuV0mAp4gorIG3f4nY2h5jFWRhnt/Ni56GNUl/XzcPWYhco
	CVduhX3vTnfImWFPOP7qkpevGV4ZvduxXlB1FiUtC/VgBfzlzZQrxF95BCsuUztd
	oxTwfO4ctyewgJsQs4+XSb/LdPNssjv1P4IQNqqm9DbXoowavvwKaEK0eU55i7rk
	CUDENBmLiXXsFo7DyqxCRaeADB7m18lc0k9k6PuyP9kOPFOyHnunV0npo8z9UUGu
	a0g5k5IZIaqrSl5EEceZWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780938972; x=
	1781025372; bh=Llc7jokBTI3ed5STjcyZf98qZ7tkpnVXUvGXJkrnG7A=; b=c
	XFLQvVF+a19xnBgQjG2ImaSRf3/zgpe2mh+VOu0C4wU8Fri5peZ2CqSCITTr/2In
	j+2kWaWI0KoW5BvC3QxKN/lsqBhc5QeZBIfSwnbU5BOkPgVs7dJIASKhE4XrvM2Y
	i+5OF8B3FAeJRUUXUQbKXNRZF77NIMd3gVJGyCkKL+0FWSGWIeykrKnArHR8bbtf
	CXS3EHPiqkTTR9skvSRtq6EkStWugCcmctz7c4CPHh3w6il7XE+ZFzbnuvWUVsiN
	0xPCfqVeMIXINz1nq1yKxBel4tbUciRHGHw5QgcXEB+LtIVjY2LiqIFeRcVPhiiz
	TblxIuspmVPR3PY9oawCA==
X-ME-Sender: <xms:3Pgmap4Tsa_APkxVIJ1AThF2M_l_ced0YGlPyC7hJqgZMOK8fT9Mug>
    <xme:3PgmaoZ4ToU1OVPWXUaJdEfh8xntD9wFbC46W00PIxhoVz8A-dReDgGsmca9ykC3x
    KosWXKsP4uY_adxdC5UHZTI8pejLSHiz3bGgdllaWXU1mnkK4QU>
X-ME-Received: <xmr:3PgmaghyT8ccHHqWEYs7KJpxIBBQ1MlwWebclz6QXXFxYCzsE150PcVU9VrLYx5yR3qUvo6OHnPlCWGYGsINjaazwd6lgM1TvKoP7HvwW1ouyrn2ng>
X-ME-Proxy-Cause: dmFkZTGavsvv1XSInRXR4vVNLF1CrSUxB2QoASp/EhpEuyTd0+J0yn1NgKFLiqFbWXs+tt
    zQH3028oOnsg5nk/IOopfjOWugdL1fnUfblT/+fUYY8jB/ggGExRkGj6RZom3Vsc4isjX2
    jsc8ebXUivV4hvGQeyh55eCe1tUHVHl9Xn6tPwNk+aeYOzO9/NZ+yoq1XIxNyU0Uj92Jq/
    saGPUkms8T+Hcm1NCfNujxSE+tUtqMhnusJJ0ZCs1lm8YbTxDSEV8PUX6BPiv8XX9iGQ8G
    Li9j7evz8fPq2XZJ+DR1qnxr79SStjTH59b2XT/u5N4zWWTe+HUnWlxTE9GRpqK+GPtROM
    dLqRPRG/EVxYdPrdzfPp7/bI0jA891NJDfpo7hsyXBUfsLK0kLRz4mV7zNAzHHiAlT/a5o
    pl4NPMxGkrIEy4anenDuw9es9+fhIX5QEwgVZ5my+VD20AcfDztue0wQ/Bgbfm/jyeHdLL
    aj1E74Ur9/d8+0mY9XN/xP7IuypXamBXXITIHm0dPc1La+P6QXbchOsyibbv0+4eNJNmSx
    GPPVDsm9tnQaDVc5Mr5Hdr9YMB8kPJTJFVXuhUYWIgb5jh8MrlXHGPU+1apsugxDTyv1Tt
    iWazzWY03z1Cxa7mrZbDxSJSj9DcTeeJpmJlJX+ShRjU2bjE1Zb63Et4jKvA
X-ME-Proxy: <xmx:3Pgmah8Xo1AMpMg9Chuq9GvrQKMdnP2xcegSLAiRzSupzbBHqMtgpw>
    <xmx:3Pgmajr6A2VYAaxF8TH1ToSkwUi-IvW4_zIA-ee13T4P5ry7RbRBEw>
    <xmx:3PgmahXoaoaOsahm0TRiaO0H4p4_gbLswsxoHtWYnqhc8eDJTNObWQ>
    <xmx:3PgmaqAJJ7r-8CReOWKTJpdK3YyM-jhluBIrkP-JyYBFt4VEduVcGA>
    <xmx:3Pgmao5AoZzDotxo50sd6vaNhWemjzcUfCYQrG-QU1OIQ3JzUTTmiU3n>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 13:16:11 -0400 (EDT)
Message-ID: <57fdff56-6a4b-4bbd-b191-d63b82a14509@bsbernd.com>
Date: Mon, 8 Jun 2026 19:16:09 +0200
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
 <742e68e6-c456-4655-a441-aaa8267f1a48@bsbernd.com>
 <CAJnrk1bz=BHryaWkZ0uBCpzLoVM-FSsb4mhA8F7+fnMQ4Tt_YQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAJnrk1bz=BHryaWkZ0uBCpzLoVM-FSsb4mhA8F7+fnMQ4Tt_YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/8/26 18:46, Joanne Koong wrote:
> On Sat, Jun 6, 2026 at 12:41 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>> On 6/6/26 01:52, Joanne Koong wrote:
>>> On Fri, Jun 5, 2026 at 3:09 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 6/5/26 21:27, Joanne Koong wrote:
>>>>> From: Chris Mason <clm@meta.com>
>>>>>
>>>>> When io_uring delivers task work with tw.cancel set (PF_EXITING,
>>>>> PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
>>>>> fuse_uring_send_in_task() takes the cancel branch, assigns
>>>>> -ECANCELED, and falls through to fuse_uring_send(). That path only
>>>>> flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
>>>>> it never discharges the ring entry's owning reference to the
>>>>> fuse_req that fuse_uring_add_req_to_ring_ent() handed it at
>>>>> dispatch time.
>>>>>
>>>>>     fuse_uring_send_in_task()
>>>>>       tw.cancel == true
>>>>>         err = -ECANCELED
>>>>>       fuse_uring_send(ent, cmd, err, issue_flags)
>>>>>         ent->state = FRRS_USERSPACE
>>>>>         list_move(&ent->list, &queue->ent_in_userspace)
>>>>>         ent->cmd = NULL
>>>>>         io_uring_cmd_done(-ECANCELED)
>>>>>         /* ent->fuse_req still set, req still hashed */
>>>>>
>>>>> The fuse_req stays linked on fpq->processing[hash] and
>>>>> fuse_request_end() is never invoked. The originating syscall
>>>>> thread blocks in D-state in request_wait_answer() until
>>>>> fuse_abort_conn() runs, which can be the entire connection
>>>>> lifetime. For FR_BACKGROUND requests fc->num_background is never
>>>>> decremented either, so repeated cancels inflate the counter until
>>>>> max_background is hit and all later background ops stall.
>>>>>
>>>>> The non-cancel error branch already handles this correctly: when
>>>>> fuse_uring_prepare_send() fails it calls fuse_uring_req_end()
>>>>> before fuse_uring_send(). The cancel branch must do the same.
>>>>>
>>>>> Fix by calling fuse_uring_req_end(ent, req, err) in the cancel
>>>>> branch before falling through to fuse_uring_send().
>>>>>
>>>>> Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uring")
>>>>> Cc: stable@vger.kernel.org
>>>>> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>>>>> Assisted-by: kres:claude-opus-4-7
>>>>> Signed-off-by: Chris Mason <clm@meta.com>
>>>>> ---
>>>>>  fs/fuse/dev_uring.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>>> index 7cd50990b097..b5cc700575ca 100644
>>>>> --- a/fs/fuse/dev_uring.c
>>>>> +++ b/fs/fuse/dev_uring.c
>>>>> @@ -1222,6 +1222,7 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
>>>>>               }
>>>>>       } else {
>>>>>               err = -ECANCELED;
>>>>> +             fuse_uring_req_end(ent, ent->fuse_req, err);
>>>>>       }
>>>>>
>>>>>       fuse_uring_send(ent, cmd, err, issue_flags);
>>>>
>>>> I think that can race with fuse_uring_stop_queues(), which leaves us two
>>>
>>> Hmm, I don't think this races with fuse_uring_stop_queues() as
>>> ent->state here is still FRRS_FUSE_REQ and fuse_uring_send_in_task()
>>> can only be called for a registered fuse ent, which means the ent has
>>> already grabbed the queue refcount which will trigger the async
>>> teardown worker to run in the background during abort until the ent is
>>> reclaimed. I think this adds a race though with the request expiration
>>> checking logic which (a) fixed, so I think you're right that we'll
>>> probably need the same cleanup here. I'll look at this early next week
>>> and send a v2.
>>>
>>
>> Right, actually no race at all, just a plain use-after-free, because the
>> entry is set to FRRS_USERSPACE and then cleaned up during connection
>> abort and then released again through fuse_uring_queues or
>> fuse_uring_async_stop_queues.
>>
>> I actually do not get this part of the commit message
>>
>>> When io_uring delivers task work with tw.cancel set (PF_EXITING,
>>> PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
>>> fuse_uring_send_in_task() takes the cancel branch, assigns
>>> -ECANCELED, and falls through to fuse_uring_send(). That path only
>>> flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
>>> it never discharges the ring entry's owning reference to the
>>> fuse_req that fuse_uring_add_req_to_ring_ent() handed it at
>>
>> A mean exit does not trigger fuse_dev_release() with a fuse_abort_conn()
>> from that function?
> 
> I don't think tw.cancel implies a connection abort. tw.cancel gets set
> on io_uring task death or ring death which is different from fuse
> connection death (eg a single worker thread of a multithreaded daemon
> exiting doesn't drop any ref on /dev/fuse fd, but that thread's
> in-flight task work still drains with tw.cancel)
> 
>>
>> I do not think we need 3/3 at all.
> 
> I think this is needed for the cases where tw.cancel occurs without a
> subsequent fuse abort, else the application syscall thread is stuck
> uninterruptibly in D-state in request_wait_answer() for the
> connection's lifetime. tw.cancel with a fuse abort is the common case,
> but I think unfortunately we also need to handle the case where this
> doesn't occur.


I see, the initial code was using IO_URING_F_TASK_DEAD and I had wrongly 
assumed that is related to PF_EXITING. 
Well, I think the fix is clear, although I personally do not like the
exit code dup (or better triple)
https://lore.kernel.org/r/20260515045541.1171335-4-joannelkoong@gmail.com

In my option fuse_uring_cancel() and canceled fuse_uring_send_in_task() 
should go through fuse_uring_entry_teardown().


Thanks,
Bernd
