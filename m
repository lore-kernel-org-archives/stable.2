Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2429B3EEAF8
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289950; cv=none; b=Nhi/GGE1MhnKxOGG0ZZSOsWrC8mya61nkt11xEV+GpY9Pljj2L265+tkE9v1y6S56xDlHSmoqk1lRRf1wk7MzXmSTtJUxRNFlXS8Kysa8LnTfOtkVC1n6tpQTMhKAr+jNuvtRWB2o3/o13KojW7Dvktr1co7txiWQvm2IM0MCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289950; c=relaxed/simple;
	bh=nXOfDn4KEb0ZRHsBf8D5SWwj6+kjfcLqNo0zqeCTz64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzW74eX+NmcOn66QXjH7Y84HRoM0jTa98Fp7qwoQbr/c5Mwl88m4OROTPmJPqHa+228aGlBc5YXsZypZS8yH8Rt9OLo+vFWIPjTXkijlTwF207pfWutoEg/1xRB4LZDiHtyJjvsd5EjEi2YiNAQmFDWMsrowHmFMDp6RF6Wt/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGNycR/D; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGNycR/D"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a865731ee4so494135a91.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 05:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791289948; x=1791894748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1HKRIiBlfoiGul+mMoQpEEjIcPaSF4T8zm8QS66XhNQ=;
        b=mGNycR/Dec+13DVA93FlxBFT5y3i4PtT2b7ypWY0DMmieZXOE28/Z1e6B5zEEilGBP
         FTHHdpioSBROSJqGmerzgess8opa9wgH9PQwlboEyTk9mmHV3/mfDqPw0CLTJf1koHKL
         evqxTOf/8qFbtAjB/ODZYamjOhD+zma8W06spoCiYXD/opfSykriUB1gejcJ/uEJnO4v
         4NnHb14cDS1xwrkcoawIaywHjJ6Rz+RktHb7HqcCzRVtFyELlJQLYl8iLP0HDccSJ0z3
         Wo9pQsaGN5oIT7BOWMk9hssBwAObpf0s9L5ubUpHmh1brqpUwU/KB1TOeSxjD8lBi2Od
         fV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791289948; x=1791894748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1HKRIiBlfoiGul+mMoQpEEjIcPaSF4T8zm8QS66XhNQ=;
        b=qyiYESbIRB8ahnRETVhp/9prx768rBBJMBIxVVFjLK8ZR6HuZRK79mvjSo5Nb3rQPn
         DOmMlJr96puwqOjfehiNk1XcwQh654SM+rtqIsPbK9H+nAoxHHaQojZ0z4WBxXskvFjI
         70LacjP7jvHimf7iaqyvtnnSpasRDLDnFPotaBJmZUDtFD0Oj7pJ3pRXlGftQ7KNV0T0
         yYEVZ1AnvMtQAqDhkYkXUzxYYggMVxBc/eT/k6OeMCS3eFNWvJm4y9g7ZzOQv6aE1SQZ
         EWHqFPmoQfB+Jiuor90JVNcPx6O+yO0ouTe173wQfpE4D8QRDBgg0VzrcVrwUD5ccJ+y
         vA+g==
X-Forwarded-Encrypted: i=1; AKwUvBw39OPhJ4nKeW3Yra0xmDVFD1l826s0UWVzIGxdaCtqnH7IAWznBNsdsFfJF3R9Rpr+9zYn9rA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7zxgizxC6M7kAukPCFW3E4mMOiPWL7ExULOsm5EOKgvwkLTap
	oqne1B/8DsAsQy6J/ZLvqveqQjUBv/M/h2tsHgt3mjyiXn48ZCv/WvnF
X-Gm-Gg: AYBFou0eTsPfPW1YvPfTMddpr749Q2SPHUrOwiA6qFZ0GZnsg/ET8b+HcmjMtDwDMQM
	rzEDJjnBC34XGxflHXLYQh6GCzRbJdISVQJ8Ew/KfTIO33kXsk5wPTHGw0zZbS4oC2OUhV3uMyg
	CbGUILqOVrz8BV73VT58JXWfhOoj7iBrHdwiGAGiFFS+Fp8LR66EX8jFXNDzy3xysaraQAPRc12
	Pm18SJaepdYvUPc+hp1h1FiHU9I6bBSJeyrm9eaO+zU5Cbr39bK+OmOo3JqdhIjL1bTuO3CLZxd
	pHGC6kbos75ipFFGitC3252t8PK3DKALHw12LpctkBIOicEDMdv3tTYMMLDxQqsSnxk+R5of4Sw
	I7EGVvsnUeEHVUlFvrDHoK+MH5frqN/0L8OWIDFwnDmX8A6e7PwjaZ8Z4Q92KVWVa5BV1IIOMg5
	GSjHDsvcmxZl+kZFgXNqwoULrlrLrU87Dkvb13LzBjCQsFAhrGnLpW8vSfarYTUtWdTH1K1RIEp
	Nk6vCedhHKo+A==
X-Received: by 2002:a17:90b:17ca:b0:3a8:748e:c422 with SMTP id 98e67ed59e1d1-3a8748efef9mr1039769a91.8.1791289948330;
        Tue, 06 Oct 2026 05:32:28 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853d00fc5sm4898516a91.16.2026.10.06.05.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:32:27 -0700 (PDT)
Date: Tue, 6 Oct 2026 20:32:13 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	qi.zheng@linux.dev, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, ljs@kernel.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
Message-ID: <87a35a80-07fd-4915-82f4-447c61d1b6bd@gmail.com>
References: <20261005062236.564210-1-vernon2gm@gmail.com>
 <CAGsJ_4yKSoCwcEDhtd=biKoUjUX9eTJJhFJGFAZWc=WsAyXycg@mail.gmail.com>
 <4cdb95f5-4140-4116-8247-c04f4b2a5c4c@gmail.com>
 <CAGsJ_4x3n1g1tqxFnnLj8mS46fyYNWQq6goqop+_2QoKO09eeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4x3n1g1tqxFnnLj8mS46fyYNWQq6goqop+_2QoKO09eeA@mail.gmail.com>

On Tue, Oct 06, 2026 at 06:17:02PM +0800, Barry Song wrote:
> On Mon, Oct 5, 2026 at 6:21 PM Vernon Yang <vernon2gm@gmail.com> wrote:
> >
> > On Mon, Oct 05, 2026 at 02:30:36PM +0800, Barry Song wrote:
> > > On Mon, Oct 5, 2026 at 2:23 PM Vernon Yang <vernon2gm@gmail.com> wrote:
> > > >
> > > > From: Vernon Yang <yanglincheng@kylinos.cn>
> > > >
> > > > When the cgroup has no memory pressure at all, writing to
> > > > /sys/devices/system/nodeX/reclaim triggers proactive reclaim on
> > > > NUMA node, causing increase in the writer cgroup's memory PSI.
> > > >
> > > > Due to this reclaim is performed in the context of the write(),
> > > > accounted as memory pressure on the writer, like
> > > > commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> > > > as memory pressure"). This is unexpected, the phenomenon resembling
> > > > senpai will appear again.
> > > >
> > > > The Documentation/ABI/stable/sysfs-devices-node documentation also
> > > > notes that "This interface is equivalent to the memcg variant."
> > > >
> > > > This patch unifies the semantics of the memcg and node interfaces:
> > > > per-node proactive reclaim is no longer counted as memory pressure,
> > > > and the per-node proactive reclaim interface no longer produces
> > > > phantom pressure.
> > > >
> > > > I ran demo[1] that performs per-node proactive reclaim 10000 times
> > > > in qemu, writer cgroup memory.pressure as follows:
> > > >
> > > > without patch:
> > > >
> > > > some avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> > > > full avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> > > >
> > > > with patch:
> > > >
> > > > some avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
> > > > full avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
> > > >
> > > > [1] https://github.com/vernon2gh/app_and_module/tree/main/reclaim_node_psi
> > > >
> > > > Fixes: b980077899ea ("mm: introduce per-node proactive reclaim interface")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > > > ---
> > >
> > > This seems to be a valid concern. Personally, I don't like
> > > having the code depend on whether `__node_reclaim()` and
> > > `node_reclaim()` are called from proactive reclaim or page
> > > allocation.
> > >
> > > Can't we check whether `sc->proactive` is true? Am I missing
> > > something?
> >
> > It is also fine to directly check `sc->proactive` in __node_reclaim().
> >
> > I chose the current coding because a previous similar fix commit
> > e22c6ed90aa9 was written this way, and it is also very clear.
> >
> > Of course, it depends on everyone's preference. If everyone prefers to
> > directly check `sc->proactive`, please let me know clearly. Thanks!
>
> I personally think the following is much more explicit than the
> current implicit code based on path dependency. no?

Yes, both implementations are fine with me.

I usually wait 1~2 weeks to give all maintainer/reviewer to review.
As long as no one raises objections during that period, all suggestions
will be accepted in the next version, don't worry. Thanks for your
suggestions!

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6a931b576b7d..048ba11852fe 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7997,7 +7997,8 @@ static unsigned long __node_reclaim(struct
> pglist_data *pgdat,
>                                            sc->gfp_mask);
>
>         cond_resched();
> -       psi_memstall_enter(&pflags);
> +       if (!sc->proactive)
> +               psi_memstall_enter(&pflags);
>         delayacct_freepages_start();
>         fs_reclaim_acquire(sc->gfp_mask);
>         /*
> @@ -8014,7 +8015,8 @@ static unsigned long __node_reclaim(struct
> pglist_data *pgdat,
>         memalloc_noreclaim_restore(noreclaim_flag);
>         fs_reclaim_release(sc->gfp_mask);
>         delayacct_freepages_end();
> -       psi_memstall_leave(&pflags);
> +       if (!sc->proactive)
> +               psi_memstall_leave(&pflags);
>
>         trace_mm_vmscan_node_reclaim_end(sc->nr_reclaimed, NULL);
>
