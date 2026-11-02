Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614368;
	b=mx2s3jt5wvjedopfN3zzBc8l0T5/wkw03WX2LJm2F83GVBE6MeRfyzGu3BDdOdEqeqPg
	 HYkXStWjTj7qQ0YHB+/RiP/CtQx/pmpT2xcfEIp3pjBfq8IzeqjVsLhXvmoworufRazUq
	 y0pU3HCFcE0/h+y2xdqbl/TneB8Ax9Kf1JY5XKPySlAbyy8pkq245B8d4Kvb64yi+ML1G
	 J2io57esBHzLB8HbxfZitDDEwk42yWjRHdBPd98joSPi2ieG/QZnVscFl6EHHqB8mZL5j
	 6UOhUijx1pgKsAEvDLA1rTboSIRrr01ZxxIWcfqWRyh0T1XbeqaWv9DDoWZ3FNyg/jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=zhAJG7RoUXOoz7M+qXiobMg1MbFShww69uh/kTjgH68=;
	b=xoXC9Rvphj1lGBT4pOM/AdWyx6Nv/GIlxk1jonMUCw9Jurd1sIMzmggQRBG80nUb8UrW
	 WxlZ6umVqMuxHGpQt1FXxBFFxjaU9diB+H5N1JDGCYjrf/onQ+CcrOJCrxv7NE4yz+QJn
	 n4v6js4+W4PmpyU4xsp5QadJYawuXzOiqXmM7L04myg0yhpkS/SJJyth/hNNQPjv7DAj2
	 d/9FSpHQdxTo/Q1JLPqDZ0PCkN8qAmJFC+/SeEo6FWLkTEEsJtJePJHNX9eUwXglWOfIK
	 QkotpFtm9UTjpt3nAR7vFNZ37f1IeX6If2o/4ZvVWAopuy7WuD3vhj0Pe1xoX/ukEtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VmuCN7+4;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900ED606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 900ED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VmuCN7+4
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so25923585e9.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793614366; x=1794219166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zhAJG7RoUXOoz7M+qXiobMg1MbFShww69uh/kTjgH68=;
        b=VmuCN7+4AZROpo0l32qa7fIa38GzCV9C5RE7VWKIVqzBzIm8UL5G2FotGfej9c1OcM
         d+100dYvuuHHZ0DjCCpo9jjJ2fVhZzrXeM4uIDsoYltVvF9/YOv3EYWquqtbS5eJqSwf
         4dv4PJB4Xr1nR6H4EBRh9oQzkDrntLwyEKVPhMGGLx8ydJK9mxEIeRSbishj8frkFwWP
         k5J5B3xN93hnv5gX1ouoySBr3tjvb5zuCkTRlySP9nv6oRR79H5I+cyM5FoRwlU2yY4w
         rt65w5HFcdZi3Sp7dCrV+bT6avv1cp1nXwNTOgr71kCtFEzB4pSYcFq7AO47cM9DxB+i
         SqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614366; x=1794219166;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zhAJG7RoUXOoz7M+qXiobMg1MbFShww69uh/kTjgH68=;
        b=NOETftnnjwutr+39Hby8GdK/PgHXOK0iclzvWauUD33DVq9j+FIut88CVsV2xHJ80N
         skWAZW8k9zvOSaVmAeiyLDbzmtZkiWGJx3kEpndTyB9MO5x7aE+VhvFMsywj1YhFpUnC
         nq9oACicUsM6wsEWpkV6WW1foUxQW25QtJ5H+RsxS+GGAeXEaVCfgIorp9+Ebozcn2v2
         cRBADzwoU8efb8ZC0iDi/uZgQTuBkQiPbgfvqVCl0/f5q2RQghh3zuXodk9QGVwT8TZz
         ZPaqglej+Sb4WETrm3FvSmjhf6fI1ePLXYYhgr/tLAYQ+pILlOmf4nICtN9RdbcoJB4R
         fbpA==
X-Forwarded-Encrypted: i=1; AKwUvBwOqyrZtAGGvpDWewIefDO/SAPsCzh52LKgPyvSNIFLHSu5KzValimUsre8oqCu99AmmbhxwH0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKej/oPk4+GK5TlXXB5MAkfE7EYFMvTKZbFp+p695z83QafNJ4
	1YRTVe4XdixF0P27KIkl5IiZcnqAo8/UoW5PqCe61APgwrwUU5O3EUc3dQ90QxgabMQ=
X-Gm-Gg: AYBFou3wo5ocoKAX1vP43TgAhWqfOwupH9+nYME9s6lL1oDEbi4IAFem7DCF56oKJUp
	yB4jheDXrf95moLd8Dc+UqpaycWgxGuMP3eGstFM9YwEr0Y1SYDjut4HUULhBn/5rKAYl3gPslQ
	t442a9WzG4swsSM1l53+feWRw7ZvdDB8Z3LmlEbBH39H3+KpxhWC8eXcB2yrON+JNT42LXe91vr
	HD3ZPWiUCfLlc9tkH5dQSmtQajVgDvRnww+azlqXxlkuOPuCOa+M47+HRL2PFMV4xAzHI1xEvkd
	X5eagl5QECXPndc2crvfDMNC+BXujQL6Si4Ftd/SK8UJN13HPtWh53T0bm1jUHPsrlQSR37Pq1v
	PvArPC6fucpj1PSGH9UX8FOTzmHLatLI2tQLCXtD2ZiwSRrxbHaQWU0tD0L0QDkLejiWgsHClHV
	LMLXmPnYGsfFe1IGxp/4hHzMOUZ2k5+rM2lknXxdid4WcrDqaQvkX07adSuVJ/SA3NVyW4haJQn
	d+YzNpGJsjDUmMRtyMuVcNQJLe+k+GsKUCUyqZ6YIzYbALNiGhcEnZPZYkYVVbSEVmj3fhYwIPV
	Kv6O4M6QnK93IxPJtkqc6MVWzj1DAMTIzlbNEtY=
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4ac1970b9f7mr217205325e9.34.1793614365911;
        Mon, 02 Nov 2026 02:12:45 -0800 (PST)
Received: from localhost (109-81-32-81.rct.o2.cz. [109.81.32.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9a3b1sm20935867f8f.44.2026.11.02.02.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:12:45 -0800 (PST)
Date: Mon, 2 Nov 2026 11:12:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	penguin-kernel@i-love.sakura.ne.jp, tj@kernel.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: don't miss processes whose leader has
 exited in OOM scans
Message-ID: <auhiGqKJeukk7t3P@tiehlicka>
References: <20261026120248.2188024-1-zhanxusheng1024@gmail.com>
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
In-Reply-To: <20261026120248.2188024-1-zhanxusheng1024@gmail.com>

On Mon 26-10-26 20:02:48, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> mem_cgroup_scan_tasks() walks with CSS_TASK_ITER_PROCS, so it sees only
> thread group leaders, plus a dying leader that still has live threads.
> Moving a process whose leader has exited, by writing its PID to
> cgroup.procs, moves the live threads but leaves the leader behind, as
> cgroup_migrate_add_task() skips exiting tasks.

Is this a desirable/intended behavior? Shouldn't we move the dead leader
along with the rest?

> The destination's OOM killer then cannot see the process.  If it is
> alone there, every attempt ends with "Out of memory and no killable
> processes..." and the charge is retried indefinitely, and
> memory.oom.group kills nothing; otherwise another process is killed in
> its place.  The source's OOM killer still finds the leader, reaches the
> moved threads' mm through find_lock_task_mm(), and kills a process that
> has left the memcg.

While you patch works around this seems like something to address in the
cgroup core. Should CSS_TASK_ITER_PROCS iteration see all processes
regardless leader being alive after or prior the migration? AFAIU the
thread group belongs to the new cgroup in both cases.

> 
> @@ -1452,9 +1482,10 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  		struct css_task_iter it;
>  		struct task_struct *task;
>  
> -		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
> +		css_task_iter_start(&iter->css, 0, &it);

Shouldn't this be CSS_TASK_ITER_THREADED instead of 0?

>  		while (!ret && (task = css_task_iter_next(&it))) {
> -			ret = fn(task, arg);
> +			if (!mem_cgroup_scan_skip(task))
> +				ret = fn(task, arg);
>  			/* Avoid potential softlockup warning */
>  			cond_resched();
>  		}
> 
> base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
> -- 
> 2.43.0

-- 
Michal Hocko
SUSE Labs
