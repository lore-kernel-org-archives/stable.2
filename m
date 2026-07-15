Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC53BF665;
	Wed, 15 Jul 2026 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152781; cv=none; b=QkItpBrKgWVJQoYZ3HlkIxD0bk2TF1p8cGq0cKaXiPkb1EodF+yJsibNxSVMNwHjaQomqJ/1iATRfAENmCuAFBH7jc3xEjhWZ9sb+uiNXTqQq/5v86mlasVbLlYyboTweObon19GvhaGom8It/r07of+/LOVguvwo1Dq6SaxW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152781; c=relaxed/simple;
	bh=NOAVxZS4uIotck51ZDhimlS8HiMBWZ6w9ReawGbCGck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1/n37ZM6CymFxuD0uyqKTqfv6LrjEsBE3iIkpGLOMiRma0aMMxgTRBliEYC+BJQyRHvZkudcOHMZBuXh9ph6XLQ5zpl5iOIZC5//POIlLf8n5QtV/sI6Ddr04T8+bFRkGr60DltdL4Ez8kqlllfGqiYue1JzGNKg6FryMD3TYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=YB1B5bQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbympuEk; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="YB1B5bQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbympuEk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E9A677A0138;
	Wed, 15 Jul 2026 17:59:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 17:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784152777;
	 x=1784239177; bh=81OaXMIS9gCQivFXADEv2cqZHgmuSBYxM29OqB8pUwY=; b=
	YB1B5bQ4JCUaUyoZ28DBlynMW6UUAoqwLYUVbxjrC3Uwv1wlDj1/cIEJE/sZdRXB
	WGUH0EVLfaxhFAc/gMjzCu6mHs5I8W4FZqsp3hyAS9RHzGIsUhL6U34fwL0Whx0q
	B7aU4jD1lyO4TBj8FLI8FfcZbZm8lFJ+0mVbQHkNZTlII7pMD2H13PIM+wrTu9Sd
	XDSg7Yl4hFjfEgNl+xrenO1QAcam2p6URz+M0ELLdsZwAr5WYdZwBDTyfPJQAER9
	cNw4NO5pcTm/grNU766BQZVtKIDfsR9Byyi1iZ0A1sxwvnrnnaPBSKEOawf/v7qo
	MjEOD6vROdO5XaLIx+UcqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784152777; x=
	1784239177; bh=81OaXMIS9gCQivFXADEv2cqZHgmuSBYxM29OqB8pUwY=; b=M
	bympuEk4180Qq877pUzhx9p4fSCIGE3jKES2FH7KEdj3bWlfPbnBsMbKFc33a53G
	h4dWU1qvxTGDn0dvowvj1q5ow+3JiK8woJOJzmThJDMzBZ/zit915AEXummkxa/6
	dbxav3cxoDS/M6IbzxeNC3ftzbrAvpl/ksgN3YDoCfi2YsRJuFbwv8C5ezgb/hqd
	c4zljyeK3dj9QmzAf5UCSBGbAafMK7RnG77o3O6oS7IjBWPYCgOo3tpykabkhGpY
	+TSbw4dvA+ahCd5gWwZHT+to7YZU4osfUwq6luUJHmWRPivvd3JkbuvaqHELFRvP
	dLBhCIWWBW7eayEABpgkQ==
X-ME-Sender: <xms:yAJYalkULA0odJ6GGAAjtvc5WKg_IaiXg8eiQuZoTnlPQGQn7MfATQ>
    <xme:yAJYamDnmFb-lV21J6NdwBy7YxkbGQbqe920Mvr9T8GHpPQRIG68t_gkhWKK2pLFa
    Yh7j2_FF16Jryw3DoZqITdlmIEHN6zsCsVpzu2cKUYR4bLOly3E>
X-ME-Received: <xmr:yAJYavBL5erxKaD4JLZ5fX7v2dqDnCjGw62r-3PgSD0jZ9W19tXSfquOtXo4Z9tEL2YVOqYOrE-_qALsTHOwuUu6D8I6_tebAELkDjXzrtRBjZHNGTNunbiC1HN24U4YXVq7HjJhCy5CWAbU22xQNyokVw>
X-ME-Proxy-Cause: dmFkZTGYY6vDhiTw0UdRhHgNi8ewbXmGCiW4L2TAGNbnsNX7aieIk12vCFH/GPoMIYuSLZ
    /ARb38Pk8+E2fBftYaM5x2UHCZPX9jnOzPm4Q14IsmRZ7PgioprRgtsOXCLPqXd1VgXGYZ
    P+7ndqHHklS9jm0cBH5J3q1n6eguc+PUGzp+mHFsDWZ9vlvnhJddncVajq5nrwz+TRmwPs
    qx8pXgOSbDCdhWzYigjNDE6SC6OpPqKJscxqoSbtKKmaNw3gxJxgHaDGLGLgclbxsUdK5t
    1TtZF9dknMRRf7ebRaW5vJu5hqAXlBnJWjw1epou/3mWLXhhL/NEFp8Nv073STz5gqWYrc
    n2GmX3t4LC6Z4JJp6Ke/c8c5h8RV9s4w1WQ83cMRnXxGe7+vjVn5wBHAvfDlAQ1w7PF4od
    i22uWv0Oo+lAK7mRZ+WxgVtOI3yVCT+xSMgN5i7l1ClBlk5+GkTDwfPNcR2Yc3TQeSZrh5
    F3pkDzM7J/lspBnd2+ZlmJ9SZSjQS1HnXNM9JRVHVmtogpAZ/w3HXcPDi/0rNrkYsj4Wza
    G+iARuTih2ExRqQB1hCbeDT14L0GR6HsXbSUZFswfo3xGI0Rj4uAwSfzbyZMmkxMzp1rL7
    Jxecr1FVqkEvry4CSKdExOLJlvTiwKkX/3ERl9iIenC3ZzrF7YIIkJ4IYSwQ
X-ME-Proxy: <xmx:yAJYalE0OcVjts_f7r6Pd_SgQumOmFWRMExIqJebCPVQOfPw5TLbUg>
    <xmx:yAJYau6fg7nEmsQDFxqWie6nNZr1S6pVLOzSkO3kBvbCjthLCY9mWQ>
    <xmx:yAJYakRsA1Orzpy2ejnjJsGSVer6XhU97Nep6IK_lgZCvLW3HComdg>
    <xmx:yAJYah7CJXVBq8nijEqq6tHXyeNcA8LBuX0lVdDR7OVGuJRIrBQMNw>
    <xmx:yQJYarmyNoE1cxNZ-ER-9_iU2Rdrw8UcX40HNngLochCn0kEQXECLNak>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 17:59:33 -0400 (EDT)
Message-ID: <c48c4541-c62a-45cc-aa3d-1c78a48d0676@bsbernd.com>
Date: Wed, 15 Jul 2026 23:59:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] fuse: whitelist the request headers for usercopy
To: Joanne Koong <joannelkoong@gmail.com>, Xiang Mei <xmei5@asu.edu>
Cc: Baokun Li <libaokun@linux.alibaba.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Luis Henriques <luis@igalia.com>,
 Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
References: <20260714235408.1666063-1-xmei5@asu.edu>
 <CAJnrk1b4VAsyEMx7obFTBgP8M3dBcD1+QnKVQK-r881MBySDOg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAJnrk1b4VAsyEMx7obFTBgP8M3dBcD1+QnKVQK-r881MBySDOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/15/26 20:13, Joanne Koong wrote:
> On Tue, Jul 14, 2026 at 4:54 PM Xiang Mei <xmei5@asu.edu> wrote:
>>
>> The fuse-io-uring transport copies req->in.h out to the ring in
>> fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
>> Both headers live inside the fuse_request slab object, whose cache
>> (fuse_req_cachep) is created without a usercopy whitelist, so copying
>> them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
>> panics:
>>
>>   usercopy: Kernel memory exposure attempt detected from SLUB object
>>   'fuse_request' (offset 56, size 40)!
>>   kernel BUG at mm/usercopy.c:102!
>>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>>   RIP: 0010:usercopy_abort (mm/usercopy.c:90)
>>   Call Trace:
>>    __check_heap_object (mm/slub.c:8268)
>>    __check_object_size (mm/usercopy.c:197 mm/usercopy.c:258 mm/usercopy.c:223)
>>    copy_header_to_ring (fs/fuse/dev_uring.c:618)
>>    fuse_uring_prepare_send (fs/fuse/dev_uring.c:776 fs/fuse/dev_uring.c:785)
>>    fuse_uring_send_in_task (fs/fuse/dev_uring.c:1306)
>>    tctx_task_work_run (io_uring/tw.c:96)
>>    task_work_run (kernel/task_work.c:233)
>>    io_run_task_work (io_uring/tw.h:84)
>>    io_cqring_wait (io_uring/wait.c:278)
>>    __do_sys_io_uring_enter (io_uring/io_uring.c:2685)
>>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>>
>> in.h and out.h are adjacent in struct fuse_req, so a single usercopy
>> region starting at in.h covers both and nothing else.  Create the cache
>> with that region whitelisted.
>>
>> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
>> Cc: stable@vger.kernel.org
>> Reported-by: Weiming Shi <bestswngs@gmail.com>
>> Suggested-by: Baokun Li <libaokun@linux.alibaba.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
>> ---
>> v3: no context change; add Bernd's Reviewed-by
>> v4: drop previous tags; use kmem_cache_args to reserve usercopy area
>>
>>  fs/fuse/dev.c        | 9 +++++++--
>>  fs/fuse/fuse_dev_i.h | 5 +++++
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 5763a7cd3b37..b8e43e374b35 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -2404,10 +2404,15 @@ static struct miscdevice fuse_miscdevice = {
>>
>>  int __init fuse_dev_init(void)
>>  {
>> +       struct kmem_cache_args args = {
>> +               .useroffset = offsetof(struct fuse_req, in.h),
>> +               .usersize = sizeof_field(struct fuse_req, in.h) +
>> +                           sizeof_field(struct fuse_req, out.h),
>> +       };
>>         int err = -ENOMEM;
>> +
>>         fuse_req_cachep = kmem_cache_create("fuse_request",
>> -                                           sizeof(struct fuse_req),
>> -                                           0, 0, NULL);
>> +                                           sizeof(struct fuse_req), &args, 0);
>>         if (!fuse_req_cachep)
>>                 goto out;
>>
>> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
>> index 668c8391d61c..b511aaab6bfc 100644
>> --- a/fs/fuse/fuse_dev_i.h
>> +++ b/fs/fuse/fuse_dev_i.h
>> @@ -81,6 +81,11 @@ struct fuse_req {
>>         /** @flags: Request flags, updated with test/set/clear_bit() */
>>         unsigned long flags;
>>
>> +       /*
>> +        * @in and @out are the usercopy region of this cache (see
>> +        * fuse_dev_init()); keep them adjacent.
>> +        */
>> +
>>         /** @in: The request input header */
>>         struct {
>>                 /** @in.h: The request input header */
>> --
>> 2.43.0
>>
> 
> I think this is more a matter of preference as they're both
> functionally correct but imo the previous approach seemed cleaner,
> given that only the io-uring path needs this. The extra hop goes
> through a tmp stack variable whose memory is already in the L1 cache
> and the memcpys are small (~40 bytes), so I think the cost is
> essentially negligible. Not sure if Bernd or Miklos or Amir have a
> preference here.

Sorry for late replies, currently on vacation and reviews only when
everyone else is asleep.

I don't have a strong opinion, I wondered the same if the stack copy was
avoidable, but then came to the same conclusion as Joanne - negligible
overhead.


Thanks,
Bernd
