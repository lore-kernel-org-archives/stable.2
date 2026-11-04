Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826367;
	b=L7w9fV1YNo8F+mINtYSdZZ6T5G4aS2ELKlgIncAReO1BD1wFFSi20gOrJu4XCHrOETZI
	 TWglONj09dI6pe34SfxkwE6QGtDQjvv5Xqxend525pzInkI6d3tr06LV+ky5ARqOz7WUG
	 61TrnppinFfqHEmUeoHJPXis2jdcpXkhYPV28VlbQWbSgQgyaS3vim3kl4maGo1HEYg24
	 DHmVTGKr8rZQXz5QHayHJOusfT9iwqPU53Xhwk+on+mJ2lFIEQoKa4iFMRGvELVrEORYw
	 RYzRwmBB8C7S8sSc6Y2qcda7EFX+FNJq8dntPSgDibT9CBjujg1CnNYWrGYlTkdx6Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826367;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YaJIToSCTk3wATVpVFceyT5vak8F0V2qG7IxMxnA4+E=;
	b=41r4k0AXmraVHBpEMTHUl65ZkyZh6FObHaeJBlg+uY1ZC/024MnjRsFTLFX7Ij/vWBIT
	 l2euC1q+bKisoFG7UK/KvSLi6yU2dIdWZqoMlxgrk1XysLWFOwnds2tylELLUncvaqyJw
	 juxZ3lFhe1KHCgval7XOj/npaNy38AsHyHrxKPBuZ/ZucTbIk6N3GuXwyn799peeTGWDP
	 NhqO7awYLYrrXNU1z3fOufGWXArt8RmmitA4UJwRaGeqj+i7Owcq9LA2hH7WkdhBdvb4J
	 lNgjGsr+/pmFmvW52NHDsseIO/KJXYN7ewj0wPl3gz8Y8PLnYUtoZ8zLmRqJPKEaxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=HwhqP+rm;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=NSlodPk7;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5406606BA3A;
	Wed,  4 Nov 2026 21:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5406606BA3A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=HwhqP+rm;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=NSlodPk7
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793826321; bh=YaJIToSCTk3wATVpVFceyT5
	vak8F0V2qG7IxMxnA4+E=; b=HwhqP+rmvez/IxMdWnnu0uFCWepIcV7DAZ+uyJR7/KXTKoYE9t
	CRZzagyC34XWD5KQBHk0MLK/1z2vzKBeOttu0GVaVl0xWhU2HFo4RLWQ5Av+h1nTRRQ2k+3Bb00
	CtGNSIN3aQpCbt2RT/o9csssZf012bN6qSB+efxUD4I/9OznWICY9taaIYvlha2qRhMXgxOf5me
	KY49yD2hsW09uGNpwMSGIXJC9OzHYOtIeO+txRhBUxzbj949cXIX7BASfoT9FIg2YRLX2aFJJca
	tU+9h9huWDV7yWZZh7vaoEs/6Tc+OZRgcXZHh05XpteFUGjMx7hZA43Ha0bNiVp9Zww==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793826321; bh=YaJIToSCTk3wATVpVFceyT5
	vak8F0V2qG7IxMxnA4+E=; b=NSlodPk75kfPWeiyfuy+p10Rs1WxGPFhXuX+wVB7MikD98/ai+
	p4fNC8hbRP3Cp2p2lnVyM67hEJda/bMRzUDQ==;
Date: Wed, 04 Nov 2026 21:05:21 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Paul Moore <paul@paul-moore.com>,
 =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Eric Paris <eparis@redhat.com>
CC: audit@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] audit: fix UAF in kauditd_send_queue()
In-Reply-To: <b446cedf8a7977337389f8cdc1e5acce@paul-moore.com>
References: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr> <b446cedf8a7977337389f8cdc1e5acce@paul-moore.com>
Message-ID: <D413CA1F-670E-4169-9DE8-CD8D9F630BDC@mainlining.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 November 2026 20:36:12 GMT, Paul Moore <paul@paul-moore.com> wrote:
>On Oct 31, 2026 Bradley Morgan <brads@mainlining.org> wrote:
>> 
>> kauditd_send_queue() grabs an extra reference to the skb header before
>> netlink_unicast() since it may need to retry a failed send. If unicast
>> delivery reuses that same header, the receive path stores the
>> destination socket in skb->sk without taking a socket reference.
>> Consequently, after the receiver consumes the skb and closes the
>> socket, the extra reference taken on the skb header makes kauditd
>> release a header whose skb->sk points to freed socket storage.
>> 
>> KASAN reports a UAF as:
>> 
>>   BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
>>   Write of size 4 at addr ffff888004f94140 by task kauditd/31
>> 
>> Clone the header before netlink_unicast(), then use the clone for
>> delivery and keep the original skb only for retries. If cloning fails,
>> handle it as -EAGAIN so the send can be retried.
>> 
>> Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages in
>case auditd comes back")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> ---
>>  kernel/audit.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>> 
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 9412af9144bc..5e739fa606be 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32
>portid,
>>  {
>>  	int rc = 0;
>>  	struct sk_buff *skb = NULL;
>> +	struct sk_buff *skb_to_send;
>>  	struct sk_buff *skb_tail;
>>  	unsigned int failed = 0;
>>  
>> @@ -810,9 +811,11 @@ static int kauditd_send_queue(struct sock *sk, u32
>portid,
>>  		}
>>  
>>  retry:
>> -		/* grab an extra skb reference in case of error */
>> -		skb_get(skb);
>> -		rc = netlink_unicast(sk, skb, portid, 0);
>> +		/* Keep the original header unowned for retries. */
>> +		skb_to_send = skb_clone(skb, GFP_KERNEL);
>
>As Bradley pointed out, this appears a little confusing as the existing
>approach of skb_get()+netlink_unicast() should end up doing something
>very similar to what you are proposing due to netlink_unicast() calling
>into netlink_trim() which in this case should always end up doing a
>skb_clone().  I'm sure I'm missing something, can you help me understand
>why this proposed patch is different and solves the problem?

From what I recall from review, sorry, crappy head. This does fix a *bug*
of some sort, but I don't remember what it fixes, kasan does report the
UAF, and this fix would be a good approach, but just things are messed up
at the moment 

>
>Also, do you have a reproducer for this?
>
>> +		/* Preserve the connection on a temporary allocation failure. */
>> +		rc = skb_to_send ?
>> +			netlink_unicast(sk, skb_to_send, portid, 0) : -EAGAIN;
>>  		if (rc < 0) {
>>  			/* send failed - try a few times unless fatal error */
>>  			if (++failed >= retry_limit ||
>> @@ -827,7 +830,7 @@ retry:
>>  			} else
>>  				goto retry;
>>  		} else {
>> -			/* skb sent - drop the extra reference and continue */
>> +			/* skb sent - consume the original and continue */
>>  			consume_skb(skb);
>>  			failed = 0;
>>  		}
>> -- 
>> 2.47.3
>
>--
>paul-moore.com
>

--- Thanks!
