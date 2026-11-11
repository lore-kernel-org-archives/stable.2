Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380113;
	b=VYBBHiwWD0zJtSQhul+Lf3CyFMgjKY0qfHmvUjRQCbXTLW31AElQBekJ8b2BF6hu/q6i
	 vK1oZSEeuh4dh0qEVS9cItKm4SoVkBQ+ZaQh2cp2WMNwWGENZDZAsodU1Wgu4z4G2FO5P
	 wquiE+5eRn6LqM/RTzDk8ZkXTV0bIkDYrq2zlfXQU6RiMHBq9Y1Ql3W2wHXCKu0ofJihU
	 HkYIidy5img7nkfj9ZUStnGYQLFJgzUlsF62x1NsDxgRKFiRA7DjsdT8UWnzl9oG7NU9n
	 ZWfxf9Cf0etYZ7lmS8Zn9dMZDmgyK/9Dor8gT70gsHWOPO7sf5EFtep3oLbZbYcp98A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380113;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yk7uCCWqva6Cz5l1wMiNcrGG28MVu58wttnXuq3Zst4=;
	b=uwwmseU/SwrbB/NSdNqei2YS+LHH5AM+ElKbVGRRS0n5i7YiLWUHWRSyapkF7uplv36j
	 GWtfsCNNpjQ3zVfU2FjuE9FMsvM8BzR3U2F7TE7y0kreJ3lfbjAi2Whe1KSu3lJof/HDT
	 XOi0rj7xEd1gXjTqpaU3MYQmbsVSN5Q4Hho1sewkY530E2W7JdFNetvYEP32OkuI7wk42
	 RoEJL22MG0vAkt0ilFQTx9ymaKXI/RxoSjDR7rpCdwKh3QyFqwmJyKerTMBhcQk6RrSj2
	 XrytkJKSqPcylYfN6FApMWpU8N9MqT5HgM1AGjQ5znfDT8HNJskRlUAaNsX1WADGYMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q8ytxZJl;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="UyX3yv/Y";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F195606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F195606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q8ytxZJl;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UyX3yv/Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794380111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yk7uCCWqva6Cz5l1wMiNcrGG28MVu58wttnXuq3Zst4=;
	b=Q8ytxZJliyqx8KAEE2UjXU77OB1fQ2bn4K+A3H/cyLxscxslyCOgRauNIYUZGQUN5nPCcG
	FQs/uKXQVjt9oa42NFXtbza+DJTi0eRdcMdGJUCoUPtwYgLhAsbx5//Pn/MaaxjhsuuAax
	b+SW2oVBqMPUuiy3f2dpBxDgyCWjTzU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-XanWyR4MNrm98bPltIQ3WQ-1; Wed, 11 Nov 2026 01:55:09 -0500
X-MC-Unique: XanWyR4MNrm98bPltIQ3WQ-1
X-Mimecast-MFC-AGG-ID: XanWyR4MNrm98bPltIQ3WQ_1794380108
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso20311835e9.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794380108; x=1794984908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yk7uCCWqva6Cz5l1wMiNcrGG28MVu58wttnXuq3Zst4=;
        b=UyX3yv/YQ2i4wO9frSBnspnz7bdpT+z6pnNbaQpExynrIgYcp9KJZcoGuMDXqchZaZ
         RDhT2aTINacelsVBg375+O/TDH7rJpXFhJIB4NLq4UY3bkjFgOgzZIcIIRC3dByh0lPX
         mKXiVyOWazCba43QiTmI/jskbCAF4UW0Zd9ATL2ehHs+CnxAF7uY6xbUnx9BcR8WbPj0
         fsTuQXEuwZJXhRYFlNe3K3TUO0AP0YhCQKcwXvafUblk0aM4zZmQqnJqDjWQpFHOS1eJ
         8eoBqQgAsdQMYZjhFt0QAsBwsmvstJ5woGI2ERwiE5j4hlUOwT/+Iwr+m8mTbY5FNJBI
         cMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380108; x=1794984908;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yk7uCCWqva6Cz5l1wMiNcrGG28MVu58wttnXuq3Zst4=;
        b=k2OFeA8bjgKn24hmtAecew9PVvwkrE4Drst+1eAMSweRGSodjg+xYE7t4XRk6nYUSu
         sVfPrN4pyAv4cVrPAp1MwKHalNBdEp8zpaTjej7vwzwYuLsTteYP51LpsKDKuqEsfNt0
         j/St7ICc6xS9k8uIMql3t86eT2wRgfP1Prl++WFW0mcC6RIi9r/8E2OymrQ70Cd4AtUj
         Uys+JIyU9i7B1v/SKaqC0wvIXfN5X+MTyAUiItt4ekDJ5zH3N7hY8L05NR0jcaho1NA+
         qdEtky3QLeemqAigaE+z1g6so8eoqnkA0iWA0z9w43RQ3jNOnqd+fQwGTIphxCMG2KWe
         XASg==
X-Forwarded-Encrypted: i=1; AL+hErHrIyYVlKZeQgcW8HADAPbXIBoTAH5hR6YxRY2kXYviyRbkvRH/NABSXX+EZ4dTyE+PhE+1pAw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bVgbp8kEvnRL8x158fkySAfRLaCOG850M1LN1BxZvS+k4TFam
	8vxyDhNfyVzUjLiZMbibouNAgG42jeHRl7i9z8DgJ2/rwcvIOrjJAm0e4x2+FW+SUtIg4AEyTSY
	daQNl6JztiBtLz92KVzUcxsE5pdzN+Hr0rDv6hLdmS4fxvQqdcmrA4a+7Dg==
X-Gm-Gg: AYBFou3Vc99XGbXCNbRFOIoBETBjuP1aBqfO+LjyH1nr53WWLGHuR1YQ0x7lOUUc+Xn
	QAeDmx4Gbl54XeLaKeGu+K0dYhVQr17dYvjr/2yGbvf8gkjiQbpPd2Te5xM1JjdroSQODCgqdSg
	uWijUCt7ozGSXwASckc+L7k2aSsrPRTdSnQYBPwVwQua6w7W8rqdVvAV15ap0TiGO/0u5tFs+CL
	6mr6B0Rv/+in6BOrm9JnkcQzQAFcokw2sdUaEThz4BrcRQ33jgFg0xl2XmDQeI8lHgD1xpuaKsl
	+UgEU/teb8o5dHIEbooH8cd9GHxJJ6mh8fjrrO56sZt8ekY9/rkKky1jFVGeucscE+POxKP9wys
	PKCUpxkr1gQhDq/7LqjZ3VIVp1KEJpR7skHeQx+MjTN0Q+aan19hqMkDYgMYHNJdGKmpTU5BTzQ
	vkM0U=
X-Received: by 2002:a05:600c:4f55:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4ba0938197dmr25955005e9.28.1794380108598;
        Tue, 10 Nov 2026 22:55:08 -0800 (PST)
X-Received: by 2002:a05:600c:4f55:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4ba0938197dmr25954715e9.28.1794380108281;
        Tue, 10 Nov 2026 22:55:08 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba09517bc7sm24307235e9.3.2026.11.10.22.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:55:07 -0800 (PST)
Date: Wed, 11 Nov 2026 07:55:05 +0100
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
Subject: Re: [PATCH v5 12/29] sched/deadline: Reject SCHED_DEADLINE on exited
 tasks
Message-ID: <avQRSdb-dRzzsmc4@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-13-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108185406.1549770-13-mathieu.desnoyers@efficios.com>

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> From: Juri Lelli <juri.lelli@redhat.com>
> 
> sched_setattr(SCHED_DEADLINE) on a zombie task succeeds and charges
> total_bw via sched_dl_overflow(), but the task has already done its
> final schedule() and will never run again. Nothing releases the reserved
> bandwidth. Repeating this fills total_bw to the admission cap, after
> which sched_setattr(SCHED_DEADLINE) and CPU offline fail with -EBUSY.
> 
> Reject sched_setattr(SCHED_DEADLINE) on exited tasks with -ESRCH.
> 
> A task of the class that exited, switched to another policy, runs
> switched_from_dl(), which decrements the count of deadline tasks of its
> cpuset that cgroup_task_dead() decremented already: at 0 with a deadline
> task left in it, the cpuset is skipped by the next rebuild of the root
> domains' accounting, and that task's bandwidth with it. Reject that as
> well. The deadline_bw_test selftest added later in this series has the
> case, death_zombie_switched: on v7.4-rc1 the switch is accepted, and
> the one-CPU partition root the zombie ran in admits 9 tasks of 10% after
> a rebuild, with a task of 30% still in it, where 6 are due.
> 
> Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
> Reported-by: Weiheng Qiu <weihengqiuu@gmail.com>
> Closes: https://lore.kernel.org/all/3f6e6c87-645b-45fd-8fc6-8da5bc5b82d8@gmail.com/
> Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-4-dd761fe005b4@redhat.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> [mathieu: reject a task of the class leaving it too, found by the
>  Sashiko AI review of the patch]
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Looks good to me, thanks!

Best,
Juri

