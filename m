Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589044;
	b=ramQuIrbBeZ/aD/rR9JqZEE5TWXrfBUSQwkJFVyRJxglz2C289Easjr7XhvRj0ghafOz
	 qyEA+hfzHHzRkTw0ZRihq3IlF5QS2a5CLWap7a9BnBwvrYgxeZG6o50vaubQ/mivVQb+c
	 y3UiKBpwn+KPn6p6e3K/qKj/MnSOJkOhDN/J1azm08clk9TEJjPv3Krpqi3o3WlDr1qKL
	 leKKjYqAD9OttWRW7DFflSHvmRd0GqPnQjlgNfk1el91lD/hqvqVA/wuSEh9OPs7sqg1e
	 rXC4HF9Xgw4GG9b1DF9pAk3XMLvtrtFZQWBIJYowAPT6n1L6Urp7Qg/NbXDy1tGkhpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589044;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=t7R90zeBhuCAPBYRWGVInzQKZ8XGZNdOKwhHfCCRUDk=;
	b=bbMRPrv8X/MtsDBn0wjmYI5Qi3OB0s+rnSKg/wdm4ymDQiTlRNrm4jfwl8UU/xxsimCQ
	 x4W1NfoPwvFeMKRZs/323WPnshFkcHLTC63qKocQdhl+vDFITxJ5qqUnqUzFvZc/asdj/
	 cRN3Xql13FwT/FuQWYiGUqqoaBHiH0lXXhDZmCVABbZx5CJtnChMPWlftI124RzS0K2Yl
	 g2YCdL3FWy+f3fthfczpDSlOe4ypYyBJrxUgb+bHtyWUOX1zzRIWBpeaUfVZilI35sBg9
	 H3szGh6tsjmjOn7JrEnJOkOkNitSE9LJd6iCslomSbeDirGT8Y563UUgXwnSSXFjbBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="gG0tfYO/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AZRJTjLl;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD42606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD42606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gG0tfYO/;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AZRJTjLl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794589043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7R90zeBhuCAPBYRWGVInzQKZ8XGZNdOKwhHfCCRUDk=;
	b=gG0tfYO/i9WGOqSfARDcyM6poRvSu5Ng8Q8LRBfTxY1+kar2skDTMYTDYZ7fW8zFMnB/3m
	szoyfnrtQK4HnU1ujuj2IUEe34ua2mxq4frMiaEec6pgyCHhULlL/awV7KYGQNkLBDGve8
	c8qnbDy946xXczGfNwY0z0I3H1n705Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-NeKwhBTiOAerfz5m2rehUw-1; Fri, 13 Nov 2026 11:57:21 -0500
X-MC-Unique: NeKwhBTiOAerfz5m2rehUw-1
X-Mimecast-MFC-AGG-ID: NeKwhBTiOAerfz5m2rehUw_1794589040
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-49337a224a8so752255f8f.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794589040; x=1795193840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7R90zeBhuCAPBYRWGVInzQKZ8XGZNdOKwhHfCCRUDk=;
        b=AZRJTjLla20/bOP0upZA9DbntAjJGTMNRT3S8PlEwzRNCXOTwmz7ChdydZogcVmJTR
         Mc++h2/Ld2VCoAw45JbOfNAh3ny0mAlqq3Q/RvvMzAHMKTCwOpE/n0UJVUzLctm8haox
         hGH0v5bA8SPIRiEW8/+44HBLPtSeJ8AMb8OTNDcwsOHv4B2vKE8HWmhDwLRez/1Wo45U
         RCkHO0FuuHyBehHWDdybkyuk4wqSlnTfAXMS/on79RCztKaeIZJh64cHBnjbBVvFAdMG
         IQyjPw7EolOtSCaEtc4/wrP4kITjqCJW2BaQ6TNsAJtcgRSaTVjjYwLGxrVs5WTFEFQt
         tbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589040; x=1795193840;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7R90zeBhuCAPBYRWGVInzQKZ8XGZNdOKwhHfCCRUDk=;
        b=nKbseV2DpuO3fkChP0/rm1TN3QCWq1k2c5i5A7gfjRUvhHx+uM/WGY1Dlxn83QkEKT
         NY/5WGxVL15GbbqLpE/G0gH9/kg3a91ErNrMl3YkbZaAvNp5DZgZFfuiOvH/6OCemrPK
         sqMzbB2pKLoJLY7XxbR/n0r7M5hS0hzMpFTuy0fL1WwhnbkloR3eV8USZwbrWTvkGPw/
         jXJjiIXpumR3GTr5NMzr7gwE+fBSVxmEnLAXHspwkxL1gRS+5/V/xJxpE+7NoFUEg+yn
         e5bQkpzXffUAxp3XLfnOJxJnscHfo9omvPiV5szvw2pk7qbwDJqOii1P9mDJhf3SGLjh
         OI5w==
X-Forwarded-Encrypted: i=1; AL+hErG32OhBzg7BQlTD6vpe2R1HeBv1Dx2EtvhxapJIDMJPL/dL9ej2HqNFFysO6C8QS78nDk4RHvM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9V3JSXOJxktzBXbABEiGXZyhzm/HcdzlyS4SEBhGdT8HU9gt+R
	qIjcoOiRflUkJpy3UW8EZpeTefwJsDNJOyi7p9cix/S02SvwOmv/2F/f4TrgiMjUKmtQunJC+SH
	4oTx/W+iRuN7NfixlI1W7+MZg74HqdvzZIBQDZdkbGDIMZJAswmb+HQ8Srw==
X-Gm-Gg: AYBFou3Urz26SIwlKqUT0T8pv4vhyc9B7NCeVaoziBWpVI5MP2HhIAoMBGh9bZGKTMw
	zD9XLlI+h6a9/Hn3hpQvZTvZDKu6ZoJVK9+N2p4sbcR2TFMCEpRbXV8B/YmQa3gLIH9uCKgv/0x
	mhf0v4L3V1JLn8Z8f7F6wj7/ooSsJR9NjQjM/PsxxhzuHf+pbWNksLsCJmOYLqN5jcDL/mZCETJ
	+Vm34fCuCqGf3cD5xLgkukSUncOHYET4qZnv0lq4NvEWkx/4ZXTsO/frcqnpBUCuGEquIqpaz0x
	36Gscrbf+ZL97XD5FCHvX2/UXfAiBID6/b9deVJwb89JENnhO+DKgAeTdiK47YgUYFUme/nV1RQ
	cYVyf1lRfF3aclC1QqpTwiLgIuFTS8oejWHqlCfiXlIc+MNZJjW8Ut7bpqyfWjhUFvR+Sxk5pE6
	CxxtU=
X-Received: by 2002:a05:6000:4804:b0:49d:57b6:55eb with SMTP id ffacd0b85a97d-49d57b65632mr3158343f8f.17.1794589040314;
        Fri, 13 Nov 2026 08:57:20 -0800 (PST)
X-Received: by 2002:a05:6000:4804:b0:49d:57b6:55eb with SMTP id ffacd0b85a97d-49d57b65632mr3158249f8f.17.1794589039729;
        Fri, 13 Nov 2026 08:57:19 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm5790370f8f.38.2026.11.13.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:57:17 -0800 (PST)
Date: Fri, 13 Nov 2026 17:57:14 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 20/29] cgroup/cpuset: Give back the bandwidth an
 attach did not move
Message-ID: <avdBakhOOFb_j6y3@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-21-mathieu.desnoyers@efficios.com>
 <avWEta7b9X4K6hF7@jlelli-thinkpadt14gen4.remote.csb>
 <e21aaf40-b929-444c-b707-3200e21d7301@efficios.com>
 <avczaaXEh_xUhxpa@jlelli-thinkpadt14gen4.remote.csb>
 <3b2419e4-3874-4ccd-8af1-3ca76df20717@efficios.com>
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
In-Reply-To: <3b2419e4-3874-4ccd-8af1-3ca76df20717@efficios.com>

On 13/11/26 11:14, Mathieu Desnoyers wrote:
> Hi Juri,
> 
> > I believe we already have (maybe broken in-kernel) EBUSY on trying to
> > hotplug last cpu with bw standing?
> 
> Yes, in dl_bw_manage(), for dl_bw_req_deactivate. It refuses a CPU
> offline in two cases:
> - the CPU is the last one of its root domain, and that root domain
>   counts deadline bandwidth;
> - the CPUs that remain lack the capacity for that bandwidth.
> 
> Both look at the root domain as a whole. The planned next version
> leaves that check as it is.
> 
> The new refusal looks at each task. The root domain keeps other CPUs,
> but none that the task is allowed on.
> 
> The case hotplug_last_refused of deadline_bw_test shows it, in a guest
> booted with isolcpus="domain". I1 and I2 are isolated CPUs, in the
> default root domain. H and K are housekeeping CPUs, in another root
> domain. B is a cpuset of I1, I2 and H, and is not a partition root. T
> is a deadline task, counted in the root domain of H and K. Without the

Oh, wow. So, this is indeed possible today, but of course completely
broken from a theory/AC point of view. Urgh. :)

IIUC, what you propose for v6 makes sense, in that at least it should
close holes we have today. We will then need find time in the future to
address what dl_bw_capacity() already points out:

 * XXX Fix: If 'rq->rd == def_root_domain' perform AC against capacity
 * of the CPU the task is running on rather rd's \Sum CPU capacity.

In the example above T should be restricted (and its bw accounted for)
to either I1, I2 or (H,K). It shouldn't be possible to admit it in a
cpuset spanning both isolated and housekeeping cpus like B.

Thanks,
Juri

