Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141C3E867F
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940221; cv=none; b=KHNRJTI6JrSN+ghG0FbLgInWv35YZ0z1NjCPEMSNC+8kLtbiCoaKGknALdUIi9Jm14iQfN0+1S2fNdmLpj1BzQn5ia4IdSLUk2999J62KHiKdaxwp+fUcRtJb10SfDYh+vv0gQbgh8pdXpMe7K1p2u0/Nv1+LVjbChs9a9r1kkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940221; c=relaxed/simple;
	bh=y7zI6WWCN62EttLtA8m/eJMwaY6HfV7JtvtgKW2u+RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PunCafQpswuAueJDqQLxP4IkO+H9CO9cDB7fI0eMcxmKNFmUmnIarWS8Hd37mNm54bevXigrPIle6ixpjw5F0bQW8a55XOiBuzCSg7I5mxpXFUSPbaO574ZI0L4oF6LeObKcPWtLc4dIUpcyapqqJ20ANtVYkhoS1u7inkH+SDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=L0inpc3C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="L0inpc3C"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so11578925e9.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783940218; x=1784545018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Dhj2OBMuhusOZcXZldE/EzCpMTqXXR0jxmWBxe1EX0=;
        b=L0inpc3CP/d/ACLmiClmdyk04MGYYQzowGg+hyTlIjfzZG8+i+eLstDVM7G1V9wZPa
         DbCq9RThE/phL8g5fGwGB24sQf5O8f5acacYQMpC2DzXynsSDuo0vWVAJE6fD7RYFsWD
         D0FEGE/9zdPp00aI06fzR79iwvCPi3Ee3ZNfU5S5JjnvAXpK3qZREo4uZEY4CZYmViRA
         5EMP2HytNoFlwCAb64uVnhoPnjqeiBMTxiH9wGFtedGhHSjOTfHOT2n7OJSthoAbpDrR
         lT1GteYzVXXG0frwaB8w0MCkk2jxSnMdbhZ0gQsgYw4zh66Y4nKY9+J4tflf8a8hdQzX
         IQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940218; x=1784545018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Dhj2OBMuhusOZcXZldE/EzCpMTqXXR0jxmWBxe1EX0=;
        b=n01JboJNVqdUwiM4CCq8/f3iHirx2hh7JywSpW83hRzNiZEG5PK6MyhuOfV0Gp7sMe
         KdDltwpF8s1DNf488XaAoWF4eaae4ZKKb3rBFMnO1bCH3riGNIUFX8yy2gNvX4Rk+2Oy
         kndJkZOVKkQabIGZNKSdw64jGJvJnKnwid1JycEtjHZSsu3T1T6Qg8LmV4ThDynxqBno
         99RfzXQe0ZhGGGAF1ZHxJeVp1Rc1dBnrvfDuDqemjBR3Bq1q403fbryHf85i7C/Uahjy
         br8fTvReu9kN0rTWQCOF04tkcblB9gxYX5okLNyWxol16OC39Lx5U1/52jxc5AsyzFvc
         MMlg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0woYkjEDWBvuh51jAOVyNJnJYS4a3N9Enjyxffrbg7hiLJrb9OlPXDtS1F268HoYc70Evn5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTwYGNbiXOiNv12Y5J8qb2EHUOnMLeSXJJzsfqH1WobAC1h/zE
	DQjjXD/NN99+x0kw87PfzKGm2b+3OjgebrrcEwhAzhnDzDOmPJmtV5zaauxkfWfhxWQ=
X-Gm-Gg: AfdE7clProBSHmnC1G0C1UA6i6UpC0E06+6JMPAU5tOyxrZRwq1EbpblqVmutDygnjc
	/x5WjJzaVDREzLpiV0b6IcAS6p96FICw3/eGogpXQdmO5XLzS6jjf6YHjL5rROjnP1QLIn+ra10
	YQ/kjYd2Blo+AWfRvD10dd+4PK+fJDz2CnYOR9Wu9eNuxQLA1rcK5mdH/tl2YmfwvJyrO2xvXhU
	e089EyGG4kzXU6isJwK/mYL5kRcf5yrqOCO63+mJOt2WWEz01jbDrGruZH6O3GGp7zwRBPLhkvg
	QEsyo9jEhV0NO4GtiWK8v9XmsrRMCGN01rwmcG3saRGddGNvgYcCZC7F0/rWJrv1ibY7ymcuF/8
	K4o3iyP33Lv1+JLYeV5Qlj+G3AWtjnLvxF2/9aPYpv4V1cXn0qizAs+pvbmKp0w3Iz52qVR/sv8
	GnYzB8Fd9MSg==
X-Received: by 2002:a05:600c:a016:b0:493:f442:3de9 with SMTP id 5b1f17b1804b1-493f883174amr85181725e9.27.1783940217582;
        Mon, 13 Jul 2026 03:56:57 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73ae14sm352682965e9.11.2026.07.13.03.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:56:56 -0700 (PDT)
Date: Mon, 13 Jul 2026 06:56:55 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	"ziwei . dai" <ziwei.dai@unisoc.com>,
	"ke . wang" <ke.wang@unisoc.com>,
	Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@cloudflare.com,
	Sashiko AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/2] sched/psi: Shut down rtpoll_timer in
 psi_cgroup_free()
Message-ID: <20260713105655.GC276793@cmpxchg.org>
References: <20260712174619.3553231-1-tj@kernel.org>
 <20260712174619.3553231-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712174619.3553231-3-tj@kernel.org>

On Sun, Jul 12, 2026 at 07:46:19AM -1000, Tejun Heo wrote:
> psi_schedule_rtpoll_work() is called locklessly from the scheduler hotpath
> and can race psi_trigger_destroy() taking down the last rtpoll trigger under
> rtpoll_trigger_lock:
> 
>   psi_schedule_rtpoll_work()        psi_trigger_destroy()
> 
>   rcu_read_lock();
>   task = rcu_dereference(rtpoll_task);
>                                     rcu_assign_pointer(rtpoll_task, NULL);
>                                     timer_delete(&rtpoll_timer);
>   mod_timer(&rtpoll_timer, ...);
>   rcu_read_unlock();
>                                     synchronize_rcu();
>                                     kthread_stop(task_to_destroy);
> 
> The group can then be freed with the re-armed timer still pending, and
> poll_timer_fn() runs on freed memory.
> 
> 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling
> mechanism") deleted the timer synchronously after the synchronize_rcu(),
> which prevented this but raced trigger creation instead: the deletion could
> cancel the timer that a new trigger set armed during the grace period and,
> as creation also reinitialized the timer at the time, corrupt it.
> 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy") moved the
> initialization into group_init() and the deletion into the locked section,
> trading the creation races for the window above.
> 
> Neither placement in the destruction path works. A pending timer firing
> while the group is alive is harmless though. poll_timer_fn() just wakes the
> rtpoll waitqueue and doesn't re-arm itself. Bind the timer to the group's
> lifetime instead and shut it down in psi_cgroup_free(). Nothing can arm it
> by then. timer_shutdown_sync() because the timer is never armed again.
> 
> Fixes: 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy")
> Cc: stable@vger.kernel.org # v5.10+
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260711000434.36C4A1F000E9@smtp.kernel.org/
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Both these patches look good to me, but Suren can you please also take
a look?
