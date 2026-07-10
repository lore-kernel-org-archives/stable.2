Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA1405C47
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684220; cv=none; b=DCvIVMVmv14XIFjQUeh22m4Lf7AnV7N180OzbJakZ7EVs3Zn6Scj2xc9RyGwEzQOEbtdHc7G0+T/Y7FDn8p1Y2l4vWDIfvdPg+e0ABI9KrwXXNF9psbfgZMT3J8afig3FNfDRD1KTmdI4W1wZ79w+6fyRPfa051exQys4GN521Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684220; c=relaxed/simple;
	bh=VTQ5/pM0OAZjucDkuAXhdWo24CpuZaBSbKTGjrZXldo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6FGeViOOKvSbGfQzneb9OEMMB5BSsr+cMv8LgeFUDLasMDp17aqH+s95c3E/KrFTvgvZB2lIYMuqC2KApFL1PNMLfMfcFNsifaYxwnQ8PiC1aMh1CdVULBHBw/0Dy2kV6IwXKvOh9G4iXYnHKRdx2CPtqABkVFwH5WltWmUmKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=bvWwRRF+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="bvWwRRF+"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92ea24a2dbfso61029985a.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783684211; x=1784289011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O1cv839pt6gMzmGWDQWXXSzIxfFZGm2rebUfeK7nSPU=;
        b=bvWwRRF+PuNpa131cg97MZ1Ahv6x6iPA+32rduWdSbj0OTipCKHeLxLLJqoCJ8LDRK
         UOPBHy0PLdH5e7t8COeSBdvR3N0vOdgmOU/0WOEh/svWjBg3CyPtWVDUCLe54xxxuRJz
         1wm/AG0sxCH5KY1lxBOZSyn+mvaBfGzFaU49/PBRO6Ptx3UfTfAFD6L19nNL05AscDjk
         B67rS2m9dRVmpxEq5WAKd5Ln0yGST96lMUHEpztocGGSAeusYlnHtyAnt8cBYzSqYOkL
         h6QZ2WKt/Sr4CQkjtnIyxuBCidLxKsGkFcMUOhKYaqP24eYSu9gzpFymewX0/SY+j/kx
         lCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783684211; x=1784289011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O1cv839pt6gMzmGWDQWXXSzIxfFZGm2rebUfeK7nSPU=;
        b=oJdaLHZdG7b//i3dubvRaVo7Aqtqi9aZw772BsEMCGiIH/m6zmqldNN4S4wSwABIjv
         cX+hXLC4rwRNFFfhPNrtzsQcJR3GrQyf3y41w/jZIXoc0+g4Ij2bqBU1c9M2+Y0O+B41
         zmRzzn3wnFXoxHw8No95x5DCYAznNKbp7xjsF4NNRm+HJrwk0IAFgmgIT7kQgAVssEpT
         0Gpp2hb4lktvvMv6YG0bDaNufY9w0urgO9jtNXv/3jfUtIxaLQpd8k+Jx9poRulSp5Op
         FbEc9Za5OY0MXEnyFRfauuJ8u64Ds0EWg/YgH5Rvch6Nany1LNzW41WcYmx6Q2p9ROVh
         VPSw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0XOhxKOpchzATzeTmdykO3lEbu2MbDfnTPdsEPsMfU6iYV7X70cDph6AwVTJftWxBVkgOhdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gRgQNYNwJtulsBuGk21P68rPaY6HKYRHfXlMKsx5JcnGT/z1
	VISJjnjw39MRzeZvBeszSBs2qtvfav2D5Tlf/fr7rSkJd/kRAVzjJzL5dASbipjMqD4=
X-Gm-Gg: AfdE7cltDQlXmtg9i3rj222z6e3Do7hN+4/Okkwxnqfrq09u52HSIVJRIhDfsXVIRt0
	2oqruGvy84wc2OPAqezM4MVcShQ204o9MR3GsONLNnlStmb83dniuzX7sfPzZiLKMYHUY2hdmdy
	TxDU3UcFIIU/WxEirqLcQWr8EIeNYh18yE2gZ7eOIJV3Z1fZ4tQnek3FidpaDF4E++Vd14i9yMp
	LG6aidyppQsecjgS9xUJPAQ2SWQXZ3Vgax2ChI21FdkGmkHu92lxpTUyPWdXuC5XD5m/aUF6cOU
	AaM8WUSPJlEe/ol5X81aonTzAhiJdH3o5TOhq+StwTJdSjwQXMpBZQ8ADNRJrR7yjkKnpIj9icC
	G1afyEgwyAIS/48UDz7J6FOXEzrpjmn/caC1ZKqIHPQu429kvRyR+gSVJePC4FCvpSqMRKelfMV
	dpYtq+tiC8FTU=
X-Received: by 2002:a05:620a:8082:b0:92e:c117:9eaa with SMTP id af79cd13be357-92ecf908aadmr1243149185a.88.1783684211285;
        Fri, 10 Jul 2026 04:50:11 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a0cbsm176929585a.5.2026.07.10.04.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:50:10 -0700 (PDT)
Date: Fri, 10 Jul 2026 07:50:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>,
	akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
	peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
	roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <alDccVjPeCi_PN-9@cmpxchg.org>
References: <20260701145736.3785016-1-usama.arif@linux.dev>
 <2fb5ce53-666b-4b0a-a4ad-2b3a28c54768@kernel.org>
 <akU5VdOBkLGInh_t@cmpxchg.org>
 <cbba6349-55a1-416d-a686-d03ff72cc211@linux.dev>
 <alBQBRWDrVoh9P-a@cmpxchg.org>
 <843f6d0d-e893-43ef-9cb3-1df21fb64b8d@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843f6d0d-e893-43ef-9cb3-1df21fb64b8d@linux.dev>

On Fri, Jul 10, 2026 at 02:19:15PM +0800, Qi Zheng wrote:
> On 7/10/26 9:51 AM, Johannes Weiner wrote:
> > On Thu, Jul 02, 2026 at 09:38:41AM +0800, Qi Zheng wrote:
> >> On 7/1/26 11:59 PM, Johannes Weiner wrote:
> >>> lruvec_live_lock_irq()?
> >>
> >> But lruvec_lock_irq() grabs the rcu lock too. :(
> > 
> > Yes, but it's self-explanatory if you put it with those definitions:
> > 
> > static inline void lruvec_lock_irq(struct lruvec *lruvec)
> > {
> >          rcu_read_lock();
> >          spin_lock_irq(&lruvec->lru_lock);
> > }
> > 
> > static struct lruvec *lruvec_live_lock_irq(struct lruvec *lruvec)
> > {
> > 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > 
> > 	rcu_read_lock();
> > 	while (unlikely(memcg && css_is_dying(&memcg->css))) {
> > 		memcg = parent_mem_cgroup(memcg);
> > 		lruvec = mem_cgroup_lruvec(memcg, lruvec_pgdat(lruvec));
> > 	}
> > 	spin_lock_irq(&lruvec->lru_lock);
> > }
> 
> All right, should the implementation for !CONFIG_MEMCG be placed here
> too?

Yes. You can just #ifdef, #else the function body itself.

static struct lruvec *lruvec_live_lock_irq()
{
#ifdef CONFIG_MEMCG
	...
#else
	lruvec_lock_irq(lruvec);
	return lruvec;
#endif
}

> Will send the v5.

Thanks.
