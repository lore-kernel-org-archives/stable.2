Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469824;
	b=YGmQfxMlNW33nIQK5CUou75hXvQ/60rPfLe1E9nA6ybFRjczdeV25lxv+tLw+v1YQ8AO
	 U10fD/HzdNy4+p/cr4BbCJpNho7nYPIVIlMBxxOxpdnNCQaIQGUhaZV2d0QnJFTYHoj0d
	 B/6izj818a/6O4wgbYYGDyPUgU26DxvIpFD6+8TPXmvJHIG6y2X5CzIyJvF5HhqzrDd0L
	 vDlF7KZEgCkVU1TeKwvenOjEpxyG6EvcDYFROzae5IVJjYrC6ZGaqrJoDyvJD3V8dt8rq
	 4q9PR64OW4iCS2B5WG43taotkxgRPRWOZYJ6JpRHsS8+3StByjuoLyGsdkUkYmKkHZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469824;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eAEaXknwutXsE98av80d8xzVhjo04EdbVXbDbQO9bFo=;
	b=vNRHEpGGIPqOMZPz15rhuzYh1VLILEE8FBtI+TqO4xz3kq9aihusX0beAdgP8fEA/wgV
	 2PPb4W4E9vIYs4vKiGp3VOZNiEcJIR7f2zxHsccg6UwpI4FK59oAwYNe/oVvqeBROiynm
	 sRWjW/JQJI6GTUGGTSoALJRYa4aXjlKFTvBetRi77hikO6WEq3P2FkX2Xzed0hCGVV1Pg
	 4/vKbVEt0yasv0QKHE1Qe6amPkS9AAIOlPS6GroDSYa9YvbtjE6OcN6p6+SWchUpCsb+9
	 HSI0t55/AwOwB6BTffC3kA2AtpZNdQ9FUjkBZB1eqvCIuFHrw9+T5gsb5N/BUd4kLAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JKkq4OVS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qDwrBmcq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F54606A334
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F54606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JKkq4OVS;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qDwrBmcq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794469823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAEaXknwutXsE98av80d8xzVhjo04EdbVXbDbQO9bFo=;
	b=JKkq4OVSOwOVaENYQrVtTIOsishWT0KXHP8jq08Hg9gXbzl065PK3xFFnOvHlpqvIQRRVl
	c6Xnfb7CzxU3ZbPNbGvxNVgoVsUTQrlwPZow7kopw/O6EMSxkUj6cylzzxmWqcPBYIk2bV
	3YAgBmuklmCi+nNVHBGtToPnPPhoLTY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-lLppTAlcNAaCH6MAgVTYFA-1; Thu, 12 Nov 2026 02:50:20 -0500
X-MC-Unique: lLppTAlcNAaCH6MAgVTYFA-1
X-Mimecast-MFC-AGG-ID: lLppTAlcNAaCH6MAgVTYFA_1794469819
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso33172155e9.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794469819; x=1795074619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eAEaXknwutXsE98av80d8xzVhjo04EdbVXbDbQO9bFo=;
        b=qDwrBmcqbdfv6sjXk1rqxfTgCtqUKuKT1+J9Hh/rhnouIzDHTT66xrCcbFw09I5gzH
         shdWuZZgpiY7326zbMZC217ZWyMWsiJlHJUuwt6QWR9XgsdW032CaJPDjngjN1lHNWNu
         pdDlSf22mdcd9DHpYvFdT3oWmDnGz0PxNtRtVnWqIicChUtPmY1lzcN+QWv2sBRAUyCr
         n+7mdMjMeq5ADnfe/XQBPNgfgjwjdTWWikxeP7FFO1nmpQijKjghDM6B78PoLBDKSop5
         DHjNxtHQtaLc9kYWDgH/EBIy6TA6zxY1msISa4pPKoJt906w9hOvsl0CSD3o/9/jFse+
         MgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794469819; x=1795074619;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAEaXknwutXsE98av80d8xzVhjo04EdbVXbDbQO9bFo=;
        b=DDuWX+E0goh0WGp+k9kA2nEAXOfUc+HFSJRTLbTIP/96v1MplOzjAXtJ6551onNPsh
         2Nyry1LAj6E9ZxzUUlb4CyEcJLNvnSzXV5Y2nlScISSCOh27sHxb13GvoAB5Ki6fdOl6
         Z68I7QHq04gRU4b3jw4WKxOkOG7t7Qt8JXrK7wi2dOdnV5AvUa3D09Kz2zwrGbbXf0fD
         lgV3womaDPUKiEyy/u+cF9GrVlczdJa2+8TiXScGNuVhTla2gCftVKtLuHdec1Vh77yp
         3WqJ0CwIP4jF4LY95Lnyu4M05dx1O+rkOoq0Q3I7VQcmd2Cuk6xHUN6w6hcZlHpzJbVI
         Ft4g==
X-Forwarded-Encrypted: i=1; AL+hErHTyp99/eAOdEbsZUrIYljUr+cQSbCTJ2pbTYYZAywnVL7v/69FmUzZmFFTZ82diy6vHzkkjr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z++dlBI46MovQgvmQ05bsyBXYxkRHIGvTIkWWxsDmA/OEoDkG1M
	MBoHEHtOVdT0BQ843oFXxBRZibprvKdhPD6KHw7wyvkG4OduUkD8luIGSewUZ8oc+dILxg8PoWi
	Grlg3NfHUMuSai5Dra+u7QgXZHU9aYgE5o3Ely/jfzeAaF3YiKJ8JS9xYvA==
X-Gm-Gg: AYBFou2oTCgmDOpjrmOihOCUtKQTyEivCFeEQdrIw9ln2gDluI3PTqFWrDrOTVjtC2A
	WqP6ngwOcHdnh84DXOLvN6RXgz7qH+AJoiy+mbDnySHPcgKUrXoek98hLqn3b3zOqNT4jl5LeiE
	n9v/SBiay5s1D00+zLrcgqGfEIzkmUe1+Dtlf/PcODb1SpYVVbAhIDFSDOPbJyiyXY7Dvat2uyD
	+Pl/OUbplu24KSl07p+GiRqGk/4nxT3gKF9b21Y4hobeYs15kulUq79cuOimJhFgYQJ80mMFQOo
	vfclEGdq5kqimJI1GoPJnjTnB8bP7DGpRyU7wc/WGR3YFzfG8iiX1J3/5il1ldsRBZizesPKdzF
	JUYseLokxjs+7+EgNpj+uZTQ9fABVhp83GNTP2+FvT5Dv0NJN7W/IxgPoCZM3c/feQpFZ3VIfqq
	h6FLY=
X-Received: by 2002:a05:600c:1986:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ba09376d2dmr82685635e9.11.1794469819096;
        Wed, 11 Nov 2026 23:50:19 -0800 (PST)
X-Received: by 2002:a05:600c:1986:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ba09376d2dmr82684805e9.11.1794469818478;
        Wed, 11 Nov 2026 23:50:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e28c882sm52359655e9.6.2026.11.11.23.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:50:17 -0800 (PST)
Date: Thu, 12 Nov 2026 08:50:15 +0100
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
Subject: Re: [PATCH v5 19/29] cgroup/cpuset: Wait for an attach before
 rebuilding the sched domains
Message-ID: <avVvt8wlKqW4LqTa@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-20-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108185406.1549770-20-mathieu.desnoyers@efficios.com>

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> cpuset_can_attach() reserves the bandwidth of the deadline tasks it
> moves in the destination root domain. cpuset_attach() moves their
> bandwidth later, on the strength of that reservation.
> 
> Commit 75f7a25ec6bb ("cgroup/cpuset: Prevent race between task attach
> and cpuset state change") lets cpuset_attach() rely on what
> cpuset_can_attach() set up. The writes of cpus, mems and cpus.partition
> wait for an attach in progress, in wait_attach_done_lock(). CPU hotplug
> cannot run in between either: it takes cpus_write_lock, and the attach
> holds cpus_read_lock throughout.
> 
> But a rebuild of the sched domains does not wait. A write of
> sched_rt_runtime_us and the energy model rebuild them through
> rebuild_sched_domains(). The cgroup v1 writes of sched_load_balance and
> sched_relax_domain_level, and hk_sd_workfn(), use cpuset_full_lock().
> 
> In this example, a rebuild drops the reservation. T is a deadline task
> asleep in root domain R. Thread A moves T to a partition root P, which
> has a root domain of its own. Thread B writes sched_rt_runtime_us:
> 
>   A                                      B
> 
>   cpuset_can_attach()
>     takes cpuset_mutex
>     cpuset_reserve_dl_bw()
>       P's total_bw += T's bandwidth
>     drops cpuset_mutex
>                                          rebuild_sched_domains()
>                                            takes cpuset_mutex
>                                            dl_rebuild_rd_accounting()
>                                              clears R's and P's total_bw
>                                              counts T in R (not moved yet)
>                                            drops cpuset_mutex
>   cpuset_attach()
>     takes cpuset_mutex
>     cpuset_attach_task(T)
>       set_cpus_allowed_dl(T)
>         R's total_bw -= T's bandwidth
>         records a CPU of P
> 
> P now lacks the bandwidth of T, and admits deadline tasks beyond its
> capacity. When T leaves P, P's total_bw underflows. In testing, the
> race left a destination admitting 3 tasks of 10% too many, or P
> admitting no task at all.
> 
> Fix this by waiting for an attach in progress in
> rebuild_sched_domains_cpuslocked() and in cpuset_full_lock(). The
> latter then takes its locks in the order of the writes of cpus and
> cpus.partition. A rebuild from CPU hotplug finds no attach in progress.
> The online, offline and kill of a cpuset never wait: they hold
> cgroup_mutex, which the attach holds throughout.
> 
> The move_vs_rebuild case of deadline_bw_test, added later in this
> series, tests this race. Without this patch, it fails in 5 of 8 VMs with
> 8 CPUs. With it, the case passes in 8 of 8. The next patch needs this
> wait too: without it, it would give back a reservation that a rebuild
> dropped already.
> 
> Found by the Sashiko AI reviews of v2 (the race) and v3 (the cgroup v1
> writes) of this series.
> 
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

This looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

BTW, this and other patches are actually cgroup/cpuset domain, so we
will need to ping Tejun, Waiman and others at some point (if they are
not looking at this already :).

Thanks,
Juri

