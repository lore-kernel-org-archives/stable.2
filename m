Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B823FF1A3
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818112; cv=none; b=rpNCUUGv9dCtqwQEGsFQ+r24rmDG4DvQ4OhQBjhM/RmD7ARpM7PNJHtR/mcGHVp1EWNQ1S4gwi+IuJc+srkZLYyyexjHFM4UbLecA7u9jBMOyhj3VktY1p0ZJBdbEXsChjQujExbWY21Wq2n6N0vVeq597YBYmrnprMGQ8V6YKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818112; c=relaxed/simple;
	bh=KN1FRu4cuOz4IFhgPj+yn2ZmKQqb+oVckZ03m5pXlAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJUXRQrrSn0SbXiEowNFAD1QFyBAtPIr5aPIsUukw5K9PQJJg9bjfbqAUWp+qaWhWH27sXZVxwNk/oLIpwCHUIM3+3lA2aK/PcqDC5OWS0xLPMHsXa35RQ8wO1dDVW+fyyWUEWMNlNQKCyecxIhnlmeDtIkOL6o+0VwRolG+oJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWnAJo3y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6RITRFM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWnAJo3y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6RITRFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782818110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j15V7ngwE/VoSisyb4jPtPP2vsFCnu4q3l7tU5FLXAA=;
	b=MWnAJo3y9inWm0EXpBxzlVH5wanKleijOEMt4R4hG6NKcr5ZLvKmhdftO2kOvLL4WcphPb
	577fELL6/9GInAZzjK59AwmmTR8ZjFUBjcfKu4ldBkPwonjTX9fLl/Z7MJxLqBRYp4rPwN
	ANNn+2O2WM7qyuQzXb4Vab9ndTrg+18=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-p0Uzc16OMem5kdLhdRCuzA-1; Tue, 30 Jun 2026 07:15:07 -0400
X-MC-Unique: p0Uzc16OMem5kdLhdRCuzA-1
X-Mimecast-MFC-AGG-ID: p0Uzc16OMem5kdLhdRCuzA_1782818107
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-664d8e6c178so3143005d50.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 04:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782818107; x=1783422907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j15V7ngwE/VoSisyb4jPtPP2vsFCnu4q3l7tU5FLXAA=;
        b=J6RITRFMkP6oI/1ka8mRsZbGkrToqP7+lLijURua8dBCTr2oOedemijEI2JU2sVAQO
         1m0NhFHYXyUQ9dNqrqQedUO3OEvJgUgX8JfqioUdpkcHJM8TYyMQwSMbBTd+3D9mELp0
         yrbXGbKAvpSV24Jqs+5EUGHE27CNHFYPHZXc0pCV4kO+lSsNmHabHPnZc3cPWLQQNrQP
         OL6kAXi7oeupqo2THNLd+Wo07nvKvie/2Z5dPjTbGJqAsbk37gkc5YGxukcZ9qbZsm00
         zEZXUncro8JHpmiCScO88gX0OKb8onyb3VSKU7oaTbHNgjm0ENC/V1p+xCPnU/L9Ygnq
         lLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818107; x=1783422907;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j15V7ngwE/VoSisyb4jPtPP2vsFCnu4q3l7tU5FLXAA=;
        b=GbVtB5/Nb2XBofjJGbNXE5U1VBTb097FLjJ5r3zr7GU4J5BMGFCtcveS4QK/BYt/2h
         qdLiXoW2PYYtXpPihx+1BbQZWdmqU/M/3bnPPI47Qv6O0jSYmXa+WyVbk9Ik2hDj4GxF
         Dm15RxqNw8yYil2Xgitrm0zsiEMhV1LKLJETDeCZyxp9lUuZqIGw+LLmxTwqEIvdLysY
         f2tFnMHnmQBdnfsSlgBVcjtjFFJP6J/WUotn4UtHFaUsX8IlQbZ5bxhtoyrzE8JDQcda
         ao9E7ffi8hsqaL80fPwY3rE3Z7RNP5TDeb3yBY+U4RxOBrWzqY+Fus591aS/x4lyApHh
         Q7dw==
X-Forwarded-Encrypted: i=1; AHgh+RoUjcD/EYjFXUY9M5h1s75J0txpfodO7aBCpdo3PfpWb7jo2gHu62Xyvb1Eti/PRuEnPD3ZD5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjNVXrsEN8PWMgO50JKvqxhKv1Hkb+fUNKiI2Jj2/nDIMaNcn
	J0xU6dMYO9GtCeFL1eQjTWDvj5Pi8t0a/lELshusV+HAG8sX5F/UnLoBKg+/K6GlowLY+jsFhGO
	xC36qOnZv7jo7e2VG8+HTPfMeMpLu03/NoyFgYIAzvXK1wXwa6nxAz3uaqg==
X-Gm-Gg: AfdE7cngU4uqpqBXGXLfZXXAqW0heVcgU7ltD7WrrpdO/M3sVI4WfM9OJERU9Ok9tCM
	1uuFfPwQ3XhsReDwVZZFaUkCl5soB+AlH4kaHlrHBZ7kM6PwRcj1ip3JrS0LNKbt9zsJ2CPGCna
	/EA1+WCcd+RZJ1T/WUrG8FTwEHdCosGPuodXZJ9T1TXli5uPdiPAXlAxvOJm5+3jgg4KjaQzJGR
	WSU+0qiK/tNhwHEZ+vyfveaBhZGla6SieTlFjSeJXAwgcxJh87oN61hiEKwobJsPAE1QVoursao
	/DzfSJ9X87t0Mpm7WR0FUHm1nrjiYBAGXL7phnP0+Ct/AgPqK8AB3QaMeuPMQy/7u3kY1O8240L
	o9FiT7VMBNWPIfmkCniox4hMzRrRQiqpo5Z/o4SML8mcqNl4Sx2yLZRI4kZ++WpH+pOjbWqqxAG
	Dk7iYA/VX6KA==
X-Received: by 2002:a05:690e:428c:20b0:664:e5c5:5b3f with SMTP id 956f58d0204a3-664f98d1883mr2606810d50.44.1782818106792;
        Tue, 30 Jun 2026 04:15:06 -0700 (PDT)
X-Received: by 2002:a05:690e:428c:20b0:664:e5c5:5b3f with SMTP id 956f58d0204a3-664f98d1883mr2606780d50.44.1782818106280;
        Tue, 30 Jun 2026 04:15:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-665006a8c03sm770116d50.9.2026.06.30.04.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 04:15:05 -0700 (PDT)
Message-ID: <de40b1a5-663e-43ab-9fb7-5a49f029cc4b@redhat.com>
Date: Tue, 30 Jun 2026 13:15:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org
References: <20260628111229.669751-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260628111229.669751-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 1:12 PM, Jamal Hadi Salim wrote:
> The teql master->slaves singly linked list is not protected against
> multiple writes. It can be mod'ed concurently from teql_master_xmit(),
> teql_dequeue(), teql_init() and teql_destroy() without holding any list
> lock or RCU protection.
> 
> zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
> after an RCU grace period, but teql_master_xmit() running on another
> CPU can still hold a stale pointer into the list, resulting in a
> slab-use-after-free:
> 
> BUG: KASAN: slab-use-after-free in teql_master_xmit+0xf0f/0x16b0
> Read of size 8 at addr ffff888013fb0440 by task poc/332
> Freed 512-byte region [ffff888013fb0400, ffff888013fb0600) (kmalloc-512)
> 
> The fix?
> Add a per-master slaves_lock spinlock that serializes all mutations of
> master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> around those updates.
> Annotate master->slaves and the per-slave ->next pointer with __rcu and
> use the appropriate RCU accessors everywhere they are touched:
> rcu_assign_pointer() on the writer side (under slaves_lock),
> rcu_dereference_protected() for the writer-side loads (also under
> slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() and
> rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(),
> which run under RTNL.
> Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
> traversal in teql_master_xmit(), so that readers either observe a fully
> linked list or are deferred until the in-flight mutation completes. The two
> early-return paths in teql_master_xmit() are updated to release the RCU-bh
> read-side critical section before returning, since leaving it held would
> disable BH on that CPU for good.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: zdi-disclosures@trendmicro.com
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Looks good, thanks!

Please note that sashiko/gemini found a pre-existing issues which may
require a follow-up/separate fix:

https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.com

(the 2nd one in the above link, IDK how to generate a direct link to a
specific comment)

/P

