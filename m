Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE16410D0F
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411535; cv=none; b=BpLfE78NPStnvG7Uou+QXiAx74K0a0NL/4/xtig7ZLGIf+ChRym8M8RSEPQzDkpXcm1rERrA9sRGN8O2DwdR93JBuq5ok2YibWP3iBfnlbM/uu7tKyOK8V5SK98kEdKd0gtZ8k7cEc1wNkyujx0TCh+/AwAnmxpEhwsZZyU8FBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411535; c=relaxed/simple;
	bh=iHqcO2Rnwzd2L6OufeDd5pmiMKk3eaglPKa6bUr+zcM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+cV1y1zHcLWFWZ8YdrwLaXZZ1u7Xolcdr/dsVuPoSfBPanZqjCNgn4k6DZD6/UPvi0HzpzoMN3nnW4mtb9XOz5TBELbL6p20S99nrk0oRn337Liqhd0ZdeKw0PAH1z88Y6xgKul1KUbr/QujYJ/PXczDZs5tyJwhndJg47/ziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf9On7wZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf9On7wZ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so2880883a12.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411532; x=1786016332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plwMvaUEY9e4Fyn22yn6zx4oz4Vgz2fcf+cgeq068e0=;
        b=jf9On7wZ7ubfCfF3H+VRwPMPf77nbTNmT2eFrx/RzP2STYTsNF3YlpqYDk/GzUmJWV
         46ii+55bow6qfkVVGeDxLHTSbKowqf9VW1JVFHg3N0ZViQZqqGxX94iTElE2YMXHoQJP
         DhS8AUgdAkT3FcZ8o5aJrWqzWEm5TNTIJIuA/zij/oiMLIEx0pkd11DpUF/dRhviYClc
         JEyVE0ZYAOP51aFElNbGTPTPQ1VG12v+oZqI4q1cP3OhCS+v6QNspu2nLcGgTCg9zxdt
         rTeJfC8VkUHcdXTe0S0oHNVU/Q4DNkCHQgkexkHy9xYhqarjmHLjEmIPaY/+NF6BTSES
         Ce8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411532; x=1786016332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plwMvaUEY9e4Fyn22yn6zx4oz4Vgz2fcf+cgeq068e0=;
        b=ppf21I5t59vNKnMqaZaSe40HLGcZObLLsVBkqw5t0Yl1uFuJtiu9HM16/G3fIQOJPy
         WYjMpbg3wjm5yH9TXqb43Ml6fP3VPSV3YE3SWpe+7520a17D3+uNmHY09yZovAyws1sd
         IUmSSTBHqtXsbZe4KPZzS9ajwNIFcXR/LgHIRHZ3mUdAfCvfG3zk8OcfQUUBysD4GGSM
         c9BxVhS3FRdYzBwjxh0Sceg0cBUnycN/GLf6XylOMFz5zdo1pm4A7GB/ZVXOptppfYLQ
         bM+ldkn25W5ZgQ8W+ymZyobFc4yw4mFSArQxcl6H9Ahb/G28+AZTAotMVpcGeHLV9JSC
         rV9g==
X-Forwarded-Encrypted: i=1; AHgh+RqXR0kIrgXUqg9jevQUc+p7vu8zH+E+5ygugTZpry8Gg0Jd2Z9zoD2WZDn9ORUHPVPHIyIzJbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqBtd+rqU75AnKCtMqbnupjkL6C8xGbgr61wMSSZCmOQ2jH3+
	AnhC/FGAJ1ypSIqlVaAQOuxC0Us9+kEygmy7WDrmdVdShy0uja6OE66i
X-Gm-Gg: AR+sD102YOxI30ug9C+aagzJwI8ey6eXVsT0bJZFnvQy0j9nruvRPXtGY2A2u54Owl7
	9ckdL17j3E4uWl/vxDXTOY0GyP8mEvkLJYwUJQYdPe2nWKnCPSEr3wzxe1nfCC4RVOLak1Xo9K6
	bRWLkqGa80UaXDckZV2FiAZOP+LPqLnGaQxTs5EBVZ+o7fT2Xf2Y9XH+DBRZv/i/Euc+56dDyo3
	VyrTQU1Qqawjq5OjQQArPvDnL54m/5fq8Krn2FG7rJm6VSAwO+JR99vOUfwMS/7l9/ss6zNjJGD
	kBlcq/6QkezPwCnaP9tYKFDNgYsLNjN5Gse7uKsDqFBQxpKruWld7NDNypUiBc5LcE5+r1fgdFJ
	Y6Gi1RjoTR0SeK0XJVZq6aSSG1yRC1T/66Ji7BAgz1RWSOT/r4p9q40GjoKqO4WYg2yEzc3JqFO
	uBk5G5MN3Dv6GAQFkdVU+hdMDeedhBYobnqVGhV7gHB5C8h+8=
X-Received: by 2002:a17:907:c1c:b0:c1f:983a:368c with SMTP id a640c23a62f3a-c1fa5753beemr105392866b.49.1785411531532;
        Thu, 30 Jul 2026 04:38:51 -0700 (PDT)
Received: from krava ([173.38.220.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8b6da32sm57922366b.39.2026.07.30.04.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:38:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Jul 2026 13:38:48 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>, STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: Re: [PATCHv2 bpf-next 05/11] bpf: Disable preemption in
 bpf_get_stackid
Message-ID: <ams3yHvqyXrWAbBV@krava>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-6-jolsa@kernel.org>
 <78c72a5b-0db5-47da-8b35-e6a2e6976d7c@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c72a5b-0db5-47da-8b35-e6a2e6976d7c@linux.dev>

On Wed, Jul 29, 2026 at 06:30:26PM +0800, Leon Hwang wrote:
> On 29/7/26 16:38, Jiri Olsa wrote:
> > The get_perf_callchain call needs disabled preemption plus we need
> > it disabled as long as we access its returned trace entries buffer.
> > 
> > Note the bpf_get_stackid_pe function is executed already with
> > preemption disabled.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
> > Reported-by: Tao Chen <chen.dylane@linux.dev>
> > Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@linux.dev/
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/stackmap.c | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 43b1e5436047..e48ddb4edd47 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -624,30 +624,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
> >  	struct perf_callchain_entry *trace;
> >  	struct stackid stackid;
> >  	bool kernel = !user;
> > +	int err = -EFAULT;
> >  	u32 max_depth;
> > -	int err;
> >  
> >  	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
> >  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
> >  		return -EINVAL;
> >  
> >  	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> > +
> > +	preempt_disable();
> 
> Better to use the guard-style guard(preempt)() in this series.

we prefer to call stackid_install with preemption enabled

jirka

> 
> Thanks,
> Leon
> 
> >  	trace = get_perf_callchain(regs, kernel, user, max_depth,
> >  				   false, false, 0);
> >  
> >  	if (unlikely(!trace))
> >  		/* couldn't fetch the stack trace */
> > -		return -EFAULT;
> > +		goto out;
> >  
> >  	err = stackid_fastpath(&stackid, map, trace, flags);
> >  	if (err != -ENOENT)
> > -		return err;
> > +		goto out;
> >  
> >  	new_bucket = stackid_new_bucket(&stackid, map);
> > -	if (!new_bucket)
> > -		return -ENOMEM;
> > +	if (new_bucket) {
> > +		preempt_enable();
> > +		return stackid_install(&stackid, map, new_bucket, flags);
> > +	}
> > +	err = -ENOMEM;
> >  
> > -	return stackid_install(&stackid, map, new_bucket, flags);
> > +out:
> > +	preempt_enable();
> > +	return err;
> >  }
> >  
> >  const struct bpf_func_proto bpf_get_stackid_proto = {
> 
