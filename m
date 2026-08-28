Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE3385509
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787898498; cv=none; b=J7kPIcM2pQuyqV5Xjh9vnNhTtzIJlT/wcXGBYz09TkIJ2lkLmaXPLcXW1Fy1Gz9uVMGVIJbGgy9leKTniJjSQoSce4dm85YY3KWmfqvbnOJQp+C2aKd4VwpRA9VYCB9eF+tMgktwOfdZotf6iKiO1l7k0UAlEdJStCwA9XcvDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787898498; c=relaxed/simple;
	bh=iylSaV0d0HRd+S2GPFe5/jKSghYie3AtA0Grqnoy3Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM72pENG+RcAQcNdEEXaNrTfKzx22hshg1ulwbW998EV4oU8R/NnEzJJn4JZnv3Vq1HnE+t5POZc1VhbbxmqiIh3G3GB2VrI5O+mUM8iERCVhVRDXjKcueN2LaCvg8S22DKQz4Rq0IQol7+L3nG3BpadIENRFRgthlv71wYA80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gp4X1x1N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rRMW9X81; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gp4X1x1N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rRMW9X81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787898495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHGnCVhNuLFnG/5OVisM5ogzmWXFPIK5JB6VW53vdI8=;
	b=Gp4X1x1NvFSonWO1zi30Z+4PTcqD3AiU5mpF6bon+uKlh3wbwTj50oTi0lyLn4R8wj18WA
	wXB8yS1fbJ1VctnxEWXYt5IhuQGVaFhe2QumGO5Xqunzco3haQGvsQlxcfhnKk1Qcm9G96
	WyLw+rfS1v28NjspYgDCgRBvrlLaTjs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-q3N6hZF9POOgO1Rk7KK_DA-1; Fri, 28 Aug 2026 02:28:13 -0400
X-MC-Unique: q3N6hZF9POOgO1Rk7KK_DA-1
X-Mimecast-MFC-AGG-ID: q3N6hZF9POOgO1Rk7KK_DA_1787898492
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994aebe932so5177855e9.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787898492; x=1788503292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHGnCVhNuLFnG/5OVisM5ogzmWXFPIK5JB6VW53vdI8=;
        b=rRMW9X81b9CrhGuXaITMFePihVy5/SmN5y0/evcgDuyCZkWWbeuYchgP5HlPSCk19b
         FO35/KDF2An3GpiLPTQpxQWU1uJr75AldE3nGNrtwH/1AGzMLWPF+ZWVbvq4R7c2Vs0F
         g1e5eoaE2pu8Fy86ycXVMMpj/6rvHK5tpLLkkGhcDmCOBcuGUt/3muZumYOJX4Y8NoYL
         3pe9nddakxY3nMnQ4hLZdnlVxKPNHfWvX/88faS8GoMTZj9qNvHnaCHn7HFwnfI2Fi3Q
         nx6SGvnI/5K+jxljzFZNrOIGox0CdvdWaSylu1QjmNBaN+QKZJHs7hC5rF/uupYilJLO
         ASdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787898492; x=1788503292;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHGnCVhNuLFnG/5OVisM5ogzmWXFPIK5JB6VW53vdI8=;
        b=AibXoy0saikaIWLuU20caAxvObC7/KeQsDK44P8BO7V5pDQnqqiig1II13ygO6SbcO
         lXzlXQ3kO4R9kUBGl7F2MigvnN6sFTjnVn/7zjb3limGtdJYtHoNApNnnM03Tt7PttP4
         HGbysnmmtBG6YQ+VA7HoonV3sHr71/wr/0joGPqfJqORIttgDxo4BQsbFI2khG8BcFdF
         +/RUl2Erdg1zEof936V2CZt0p8g7n2UlU7N21u1UxYXCZGmIMtPQOPgA88Z132bffhmX
         19AnTY2wNsBLBV9QkPBVob2AGk4YMf7odv0yTTBYo8G+0vCyubql7PbMsCPcT3slAbbW
         Tmdw==
X-Forwarded-Encrypted: i=1; AHgh+RpuqHi+fqa3ky9uwOHvL8J+fPbRAqBvjaF01c+LEZ7frP2ArBPbIegabTR4dTBGuINJboCdalY=@vger.kernel.org
X-Gm-Message-State: AFuF++mOycqfG3Th2QQfHTm9C0AuHEF4VuDm4QUKakjetEIhEYU96H3R
	nQMIl3EjIiNMT0ywt+2VpdMBh28SFdOHQeyuJk8Mo195d4Bff0bhGL4h6h8fSHhas7Dt4dAk7h9
	wXDNbvhMwlJQbdCyeHdSVfDz5MCCdsAwPnKtXhqKkyzopn2QJvsdqCFpzEw==
X-Gm-Gg: AR+sD13Vu0h+KCAFmpknk8ei+MRrJcYIx3NB/6ARmv0QrBCJujBlyjwoE5mRicc77ot
	5BaLdxLObBPECaP+Kw5FoHZ1EjXxPJe+DCVGIQs1luTpguYA5Dkr9X7UrSvnvBR4088mWNVTeoW
	ZWq1gS0PgyBg9WOJNvU+ajcthWYK0K6qM3AfaJMiSDCQ/OFq96gxTICXFaxztoIjbvaOF3DTjLX
	OA4CwRksTl5/5z7O2JkJ3CZBR0QHK1xzJ6NCl2bMnSMlX2RBeHDe7e7oj1EwC8Cu6bVX4EXJhY/
	5Rxphh9H0+q+F6lW2Qa0pbJ/w1I98RdUV1+5zy981zRn3bsGTZlVBUdXFnbAHBe0teEs/gWHsrK
	b3Dy5R4lLgC2yzObf3Pc2gN9nrXhBhvHQapEdgjTb2ljfFG3Vgy4c2q1morXOzx+OsK2ryXc=
X-Received: by 2002:a05:600c:3493:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49b91c4792bmr62737995e9.10.1787898491944;
        Thu, 27 Aug 2026 23:28:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3493:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49b91c4792bmr62736365e9.10.1787898490772;
        Thu, 27 Aug 2026 23:28:10 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942366asm99143435e9.3.2026.08.27.23.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 23:28:10 -0700 (PDT)
Message-ID: <38a2e111-799f-4c8c-b46b-501999f71e52@redhat.com>
Date: Fri, 28 Aug 2026 08:28:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net/sched: pfifo_fast: reject oversized ring
 and account to memcg
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org,
 vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>
References: <20260825081751.134086-1-jhs@mojatatu.com>
 <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
 <CAM0EoMkJdo_e5VYPRcPN2mZpNyrTQ43FxNvkqFSNDjyV9x45dA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAM0EoMkJdo_e5VYPRcPN2mZpNyrTQ43FxNvkqFSNDjyV9x45dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/26 7:39 PM, Jamal Hadi Salim wrote:
> On Thu, Aug 27, 2026 at 7:26 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 8/25/26 10:17 AM, Jamal Hadi Salim wrote:
>>> pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
>>> ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
>>> bound. An unprivileged user (via unshare -Urn) can set a huge
>>> tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
>>> memory, causing a system-wide OOM.
>>>
>>> Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
>>> in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
>>> Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
>>> via extack whereas for the resize path, the error propagates to
>>> netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
>>> the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
>>> are charged to the allocating process's memory cgroup.
>>>
>>> S16_MAX is the virtio virtqueue size limit: the virtio specification
>>> stores the queue size as a u16 with a maximum of 32768, so 32767 is
>>> the largest tx_queue_len any in-tree driver can meaningfully use.
>>>
>>> Conditions to recreate the bug:
>>> - CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
>>> - Unprivileged user in a fresh user+net namespace (unshare -Urn).
>>> - Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
>>>   while the devices are down.
>>> - Attach mq at root, then replace each child queue with pfifo_fast:
>>>     tc qdisc replace dev veth0 root handle 1: mq
>>>     tc qdisc replace dev veth0 parent 1:1 pfifo_fast
>>>     tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
>>> - Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_array
>>>   rings of tx_queue_len entries (~12MB per qdisc at QLEN=500000).
>>> - On the unfixed kernel this exhausts global memory in ~28 iterations
>>>   on a 2GB guest -> OOM panic. On the fixed kernel the oversized
>>>   tx_queue_len is rejected with -ERANGE.
>>>
>>> Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
>>> Reported-by: vega@nebusec.ai
>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>> ---
>>> v1 -> v2:
>>> - Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE) (Jakub)
>>> - Changed cap from 65535 to S16_MAX (32767), matching virtio's
>>>   virtio16 ring size limit.
>>> - Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_MOD
>>>   already prepends KBUILD_MODNAME).
>>> - Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
>>> - Fixed tdc teardown to use JSON list form for acceptable exit codes.
>>> ---
>>>  net/sched/sch_generic.c | 14 ++++++++++++--
>>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>>> index ef2b4bf51564..eb5c0d3f67c2 100644
>>> --- a/net/sched/sch_generic.c
>>> +++ b/net/sched/sch_generic.c
>>> @@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdisc, struct nlattr *opt,
>>>       if (!qlen)
>>>               return -EINVAL;
>>>
>>> +     if (qlen > S16_MAX) {
>>> +             NL_SET_ERR_MSG_FMT_MOD(extack,
>>> +                                    "ring size %u too large (max %d)",
>>> +                                    qlen, S16_MAX);
>>> +             return -ERANGE;
>>
>> Sashiko noted that setting a large tx_queue_len to a down
>> interface gives an inconsistent behavior:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081751.134086-1-jhs%40mojatatu.com
>>
>> (all other comments are IMHO noise and should be ignored)
>>
>> I don't see and effective way to avoid that, short of falling
>> back to v1, WDYT?
> 
> I changed my mind on this. See this thread and let me know what you think:
> https://lore.kernel.org/netdev/CAM0EoMk8fAACt11fe1pUsFeG9np3SdsV0YUNmEevLu=i=b+xKg@mail.gmail.com/
Whoops, I missed the last message in such a thread. I think it makes
sense and will cover all the sashiko-reported concerns. You can probably
also additionally get rid of the old test:

	 if (new_len != (unsigned int)new_len)
                return -ERANGE;

/P

