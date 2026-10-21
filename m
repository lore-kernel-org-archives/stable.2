Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595942;
	b=E70Ic5zO4XC4RbhwhEsFZOMSMS1hNi7+ir53H0/lLRGV2N0xEzUZ1oDkMZDxkallSuyc
	 tNkZ7zgjRhfuPIqRqkqDzPLvzW9bFhdo6uRUbZClYjhQmb5s3DeHn4QLdD/HYgjJmQy+i
	 kFcgM0etCxegZx7B+XV2EaJu5rFzz4vgxwLpivpVvmUthxj0UOUfLbLcvoJA5eDiGLmzk
	 sPQgtyJ3hDw+azlIDXLkOm8wjQQVWUmhVajEPWgxo6VBtCcut8kUjk4ke1LAxlnUMRhFb
	 T3N3XRIn5+pucvVptbg6KAUryo6qI+6ME2LQW4wP6oB1zMW3BpAg3Hj6bh//HcstDaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=32AIesMVX0KHhcJgOl+PuPXqBdz6oeLpBzw/BLPp7mg=;
	b=cPFy0UgIYDHndgCJPmm/TFBPSMRWg/MPMxLVl1DXOJZ1VCEdlDeiHnP1aUVJ6JLyzapF
	 hr7WSSxdHS2JIKnq10aMo/uAtHooFnlkxL2f6UnAYtTdapdm6DmXabetrAOw/m36Libqp
	 2YvBzG1oLpARZYmWMgtW6NNV1zRQ5b2GAQkwdfBEOimlQFQuThJ6kh54NHNgy7Vkas77Q
	 8MqtMUxPVxzayTeUG+Trs06V+6yLVIXvMVvi+/UIm/yHa6gHCw70InoCuquhp3g5VikMg
	 Olu31A8beT4gp5/KrDBmt1Tn5lVFGD5cY8Tzvs2ZEA2Jj0SmZkWL8aZuZCbic7pmk+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="p08eWo/i";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9C606A31B;
	Wed, 21 Oct 2026 15:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E9C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=p08eWo/i
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j8tGs323Lz1XM4Tn;
	Wed, 21 Oct 2026 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792595937; x=1795187938; bh=32AIesMVX0KHhcJgOl+PuPXq
	Bdz6oeLpBzw/BLPp7mg=; b=p08eWo/iuxDNK6Ylz+8L0s6xZzuPbAKm8IqwZ5BM
	mxFdgeuK5MBpVSqVBQv4lGyhUGHBy8hjmAvvTb84Ii8a+5T9ajgoyLW4UYF3n0CG
	T/NAl04O/o2UnbWJ41Gu02RduP04mcgW13Babsd3xboTtG4KECMCwDWakhBqiITa
	w0MvnOE5XfOnvWYu59CzWEbfqshwWM3DHw8ituDNHkYA69Ofo+QxoVltbKxbZPkG
	oTuawAd/z9yfX3fie3bFqon0piaIo36gWS8OjZRcly6wfSxUo3CBmrJvo0r71bS1
	KUEJGxRQcxbonjHYAjUyKeSB4CM9BSaBVeqb3gxykBSw8A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JXSlaVw-xihs; Wed, 21 Oct 2026 15:18:57 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:e988:4883:8cd6:dc3e] (unknown [104.135.182.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j8tGn3YHFz1XM4Tl;
	Wed, 21 Oct 2026 15:18:57 +0000 (UTC)
Message-ID: <a39c904d-4d84-49ef-84b2-16db1b28b706@acm.org>
Date: Wed, 21 Oct 2026 08:18:57 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
To: Jens Axboe <axboe@kernel.dk>, Nirmoy Das <nirmoyd@nvidia.com>
Cc: ming.lei@redhat.com, hare@suse.de, dwagner@suse.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
 <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
 <29692751-e80e-4f29-a07a-ea0221f1116e@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <29692751-e80e-4f29-a07a-ea0221f1116e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10/20/26 7:39 AM, Jens Axboe wrote:
> On 10/20/26 8:13 AM, Bart Van Assche wrote:
>> On 10/20/26 5:51 AM, Nirmoy Das wrote:
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 025a799f35b924d..00b75eb95dd943a 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -4002,6 +4002,7 @@ static int blk_mq_init_hctx(struct request_queu=
e *q,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hctx->queue_num =3D hctx_idx;
>>> +=C2=A0=C2=A0=C2=A0 clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hctx->tags =3D set->tags[hctx_=
idx];
>>
>> Why clear_bit() instead of __clear_bit()?
>=20
> Since this isn't a hot path at all, going into details like
> that does more harm than good. clear_bit() is totally fine
> and honestly preferred.

Although I'm fine with the patch as-is, I want to clarify that
the concern behind my reply is code readability rather than a
micro-optimization. No other context should be accessing a hctx while
blk_mq_init_hctx() is in progress. Using clear_bit() instead of
__clear_bit() might make readers of this code wonder whether any other
context might be accessing the hctx concurrently with the
blk_mq_init_hctx() call.

Thanks,

Bart.
