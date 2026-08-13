Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59A2ED848
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609960; cv=none; b=V5DsC5lVIkZ+HCy83U6l1Kv/5I8RAxj71ip0F+pF+PBCHuySqTb8tpx7EG0e8SsUcH6CPXn7xH6sMVJtHinyfygTEDAmIpqQP4JO7Pp6GKMKzndDV6rn9Sf4298Y/X2KaXMdT2soB84y+swdWpIY6FXxWG6H5lVh35AnIuwpYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609960; c=relaxed/simple;
	bh=V31mtVq++AV5mI1pQg/5KGwOQEZnJDCtH4REbIgX/ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oxx9HqhM7vmlhbuLb1VuAiRDMgW4LCJySdnObyGTJdNceIrlgc90GfLBUc6n2x8unqv7xHmk4jybNMJVrdtF3bkOEfBQwTjo0ONObS173bfiyhNArrL2emZfkeKDPmH6oens1D2tgiYMM2SjM54BHcx8Grn998hBnUKkZ845hEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5N6WayV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nh2hHqhN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5N6WayV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh2hHqhN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786609957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZniUuYgFzj/H+T8JGMMvMkk+yWBd0ZWaOpV1t/iwa4A=;
	b=R5N6WayVI+V3MWGoLO0duIQxCFvQ6aGN9X1mnBIwobOVLpZEvzZOOSinPhm9C+SgzFS0dJ
	GVktTRkm8P9ginI5GhrYjhhg4Pm4AAjC5O0YCXs6Ls4vJwspTL8vGuyypBJlcGXpcEPcAu
	f26sBi3pnZrS4Wrmx3xGz5neVBXY5Jo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-9goijwd6O025sN3xJw6VLw-1; Thu, 13 Aug 2026 04:32:36 -0400
X-MC-Unique: 9goijwd6O025sN3xJw6VLw-1
X-Mimecast-MFC-AGG-ID: 9goijwd6O025sN3xJw6VLw_1786609955
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4996832e7b4so4601455e9.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786609955; x=1787214755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZniUuYgFzj/H+T8JGMMvMkk+yWBd0ZWaOpV1t/iwa4A=;
        b=Nh2hHqhN+sYCgTHnvp6o/0uPR5l8KaFvlbokJVldIhEBhFudvzj4o+qkoA+Y1WGbUF
         QPM1omdeNN6fN1Ws0VsHBnLsR2iXLM3Q5exz37wQaRq9iXC13GHY6G3tpCPPjZy6anGp
         scRBRgf9Jj0xWjMLiBig32CZtCKvMDAKTOu3P+JCteD5weBhp+neW5LIh/+cMyHXJB8L
         IEgRj7axns5OEhgSsbBF/5LO6+rp3DBCBY6JAs9tSn5I+0S2umVfGPyxSDi5DQfjXfJi
         p3sqgV2G/aV+HJ+s6BFg7A9u46co9rrp2V4m5ExZ8szkcbbewwQAqhSfelU630G7rt1x
         CvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609955; x=1787214755;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZniUuYgFzj/H+T8JGMMvMkk+yWBd0ZWaOpV1t/iwa4A=;
        b=oMIJynGs/ASOX/Ya/QKf7T4F+bM3QoZDboIsUiTDpCLjhDbW3ltzPnuTYa33UAbLw1
         Agzxqp7bjelyWY5z0sc88Kdw9zRUXdvt4E1OLhj3CTQUMYOqen+6hQTniiwCQi+xyNRn
         H7yYBHqiZVEHnjaQFIUpa9oyiDMOZQpf1am+/7Ntc82NDNiCxHwan+LVb+nKZ+s1C4x2
         Xhxx4OsoP4u+jJJr6UJs4jLcD0cnUp/zGDXtdlvf7K36Zmj4dGuaMvpVCr8idQ/q6cRL
         wMDHreRRkVfkQVt5HqAvZkUWiQ6+1lAGkzoW4AgnuRY0cUeY36KtUeG8MICq4jWTJnst
         L5Tw==
X-Forwarded-Encrypted: i=1; AHgh+RqhzphpFPbX2IygyTW07LYNJU+MeJnJC5CCSGzMFxqenqJUnvZBJkCXEQUGagdEBIPDQ4J853c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3YO/LS9lmIw+cdGa86G/r5CExP5vBy0nye/uNu3IlhhDiWFO
	FGDewddAbd1mLTfme+L8MT+J5vtuECw2buQjm7nAZDH1z49sRgzvF3YSpthEsF0WpcYypKhYJCT
	eAt26w/lDXSaBDP3t/1nsn2aOd0Dcrabm4VYk9+QeXrW281fB1XLlhHFoW24um2AF/g==
X-Gm-Gg: AR+sD12bizZYvh9B6AYN2Cdp7Z/MeGMlh2K7KP7oRsawH9vDzAMOAb96m1k3THCuxDS
	df1nr2NupwtftnP5qQByom5nPEa+29ckrTluNkA+BdeKrlyOQmPDqZ2krogl5GzBbSmDdKchh/p
	p598C5sapPrp4qP1fKtMW0TnlUQzORd07ZweAmCLBo/grDBsW7CJDDXOGd9bInUA59LTRYRI3Io
	9ka+NieUs1srtoInCFac/6pX+kLBbmB2Lga4aAey2WlYD5mhTgvC45rEJWqIUwoZQ2PtORtS9aG
	rxnqNchPLXFIFu1X1f79vlebU3IKLmPkZkfxK/wYzNttjj0EFfw491r3kczmFHV4dUqyrv0Uyy5
	Gi4Z9UhS3TbVULguNjV3p6UX6dFtLlCw=
X-Received: by 2002:a05:600d:8489:10b0:495:7aaf:77b with SMTP id 5b1f17b1804b1-49982107b89mr37500655e9.0.1786609954812;
        Thu, 13 Aug 2026 01:32:34 -0700 (PDT)
X-Received: by 2002:a05:600d:8489:10b0:495:7aaf:77b with SMTP id 5b1f17b1804b1-49982107b89mr37499885e9.0.1786609954458;
        Thu, 13 Aug 2026 01:32:34 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.92.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5af19fsm4548225f8f.24.2026.08.13.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:32:33 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:32:31 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Hui Su <sh_def@163.com>
Cc: mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] sched/deadline: Fix DL server divide-by-zero for
 inactive CPUs
Message-ID: <an2BH9a8PWlZUGj6@jlelli-thinkpadt14gen4.remote.csb>
References: <20260812123252.2355986-3-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812123252.2355986-3-sh_def@163.com>

Hello,

On 12/08/26 20:32, Hui Su wrote:
> Commit 4043f5498416 ("sched/deadline: Reject debugfs dl_server writes
> for offline CPUs") rejects per-CPU DL server parameter updates once the
> target CPU is offline. However, during CPU hot-unplug, the CPU is cleared
> from cpu_active_mask before it is marked offline.
> 
> This leaves a window where cpu_online() is still true while
> cpu_active() is already false. A debugfs write during this window passes
> the cpu_online() check in sched_server_write_common() and reaches
> dl_server_apply_params() with init=false.
> 
> dl_bw_cpus() counts the active CPUs in the root domain. For an isolated
> CPU whose root-domain span contains only that CPU, it returns zero once
> the CPU becomes inactive. If the server bandwidth is attached,
> dl_server_apply_params() then passes this zero CPU count to __dl_sub()
> and __dl_add(), both of which divide by the CPU count.
> 
> Using CPU1 with isolcpus=domain,1 and a temporary local hotplug pause
> hook to stop the teardown after cpu_active_mask was cleared but before
> the CPU became offline reproduced the state as:
> 
> dl_bw_cpus=0 attached=1 dl_b->bw=-1 total_bw=52428 span=1 active=0
> 
> Writing a new fair-server runtime while CPU1 was held in that state
> triggered:
> 
> # echo 40000000 > /sys/kernel/debug/sched/fair_server/cpu1/runtime
> 
> Oops: divide error: 0000 [#1] SMP NOPTI
> RIP: 0010:dl_server_apply_params+0x39d/0x400
> Call Trace:
> sched_server_write_common.isra.0+0x1d2/0x2d0
> full_proxy_write+0x64/0x90
> vfs_write+0xf7/0x540
> ksys_write+0x6e/0xf0
> 
> Reject DL server parameter writes when the target CPU is inactive, not
> only when it is offline.
> 
> Also update root-domain bandwidth in dl_server_apply_params() only while
> the target CPU is active. This second check is necessary because CPU
> hot-unplug can race with the debugfs path after its CPU state check and
> before dl_server_apply_params() updates the bandwidth.
> 
> Keep the runqueue-local utilization update independent of cpu_active()
> so that the local bandwidth state remains consistent if the CPU becomes
> inactive during the parameter update.
> 
> With the fix, a write during the same hot-unplug window is rejected with
> -EBUSY instead of reaching __dl_sub() or __dl_add() with a zero CPU
> count.
> 
> Fixes: d741f297bcea ("sched/fair: Fair server interface")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/anw7IML1xzHys6re@jlelli-thinkpadt14gen4.remote.csb
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>
> ---

Looks good to me, thanks!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

