Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFA3E8338
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939891; cv=none; b=ozUrXwEuwRhijLa7DQ1LJHUpylpOWmltX8gZoXIx/O7FRa/U6/OwokDkAfVJTHkDFb44rf9Yp0ajucMgihagCSRfQd8gJ/MRc3GJ61vZRouoP3LOMEZnX3pwh1+TLtZv4rM0ne54ll7ARIjkRmaUjcihJjq5Cnan4b16uONWOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939891; c=relaxed/simple;
	bh=z11t9LwXEAps95nmJFn9bgrfWgmUbK8OsamIUC9xo1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RW3YUoQ9+baG5FB1ebBvAu/bUMS91xUF2BpX9iSLO7a4f7o3TDd5codOKZiUOXHk8whDRXIToXJoLX8fR/mIPQQnHEgtV/ILbVdePbIyIa0dWnM2SUHSNObCZzLuiglTsE12upQCE87DYE6GXJrKnp5ILIDp3ApP7A/o53byRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=JPVlFIdy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="JPVlFIdy"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b966dd74so10934315e9.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783939886; x=1784544686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0xXW5DaPK6zTkeDY542N1FQHx5XzZ6y+YRGl+QSs6T8=;
        b=JPVlFIdyMwRdVhC86ydqr99/64xCRL6D6aF7eae8LtLF9rc06YsiWrtdCA6PObfymd
         3/iU7jvxeokSR0uG0D5kNWpUvJbKcYUgyzH971ynv8JdInuUHCC0bQRP+EH77UqyPLZt
         QCD0dX99TjviXX/e2LpI02dPhqLtVEwkJP8OMpRFTXpGek+0t/MceBgJ0OJB73KWgx3d
         qkEO8VFFRzJ97pHa2OCT7TnGdGAxFpPzTQZvw9a1Ycgni+XHAUtcJdTVbP2A8hjEwFFM
         d9N5tL+VwXNiTEbRZsNT9fODiW4YSz7GH8gqHcNZJRkbjMjKTC5cI+kWcNrEOE6OUQH0
         LFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939886; x=1784544686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0xXW5DaPK6zTkeDY542N1FQHx5XzZ6y+YRGl+QSs6T8=;
        b=Wd0hSerIsQ2NAb2BNJIJ4M+0e14SsVbAZfQWpMl3ocEHPc0H+1qVg45K5ddKaNoEVu
         l0WjSJ1s/cV8cYI0W11ulOGc8C7cM7ApLU+EySmSCk4NoOV+OVRCIKo+gzhkrRzP0Vb3
         NmLzfhwxEDM7GmPyJLKUb01owumgUIHMAMxpW74MXWQshUPs9NfPquE2NcvMTUscicE4
         iVAeKzOp/2wB5Qge4Ng0HQo4H1HH5/cgLFnelM1wSOBKp5PP9uT+ytyHdNTD4SANNcEG
         8tBeQA1NC49oBQrvSkml5sWYaRqGnsnKK/6bVECwf1yeAGRTYVWGuX4qH7wr7Aa8VOT7
         QaDQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNvKusJvjuq+XTKMIUXo37C6gxQf1aj6V+NpGsnq/Kh20rYT/kc9an7UNaBPpTloGX9LM2HOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2o+74XvqYd76cSoRLVKrGRRydqvI6LkuN/TvWoncs0hV70koS
	DGy1DkL9ulxT6WMCNFOgm5mkJxG0E3Xtix0IlijnXCPlw9jXTcfqCwLKnMjo+X15aAs=
X-Gm-Gg: AfdE7ckK2vicafHSTSGnmUaQ5pLi4m+p4xIiNNSXSgqL0ASmw5wtJ166SYXbuoF/L5P
	W9vy+JrXEuBdtkDym/rrJ61OpJjYc849JI07IKCdu8Sgul0JjqclyMeZsVGwCodOKSMOYMQ+15W
	f/wU3Np0UgCJcFOh6f0BuLTC9U5xopseJBwVVVjDwJQCiQNUIxFV75WiS+hTnJ/6AHPTvrbvHni
	5WeBoQAucEHWsyCMC/mchoB+taCU9FGiaQ5FYDRLQ7YWMBwKieAwnMerZ0mQsRwt7gIZuucMoaA
	cslPQkYMoFnRLOLqLtc68U+UA7iSmoRJ75etkHT73BbDK5GwK6OX90LNwoVG/tqRLHbyQNcWvef
	dnvgxJW0bR7VB/u/3r26yIypk7eh5HmgT30GF2ZeWxxXXUzw+XBsa9/POQXIKm6hDWdSTMRJ8E1
	ti/fiuNfzEAg==
X-Received: by 2002:a05:600c:1906:b0:493:c8a6:b517 with SMTP id 5b1f17b1804b1-493f883b7e8mr84731245e9.38.1783939886273;
        Mon, 13 Jul 2026 03:51:26 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3b85sm573716585e9.2.2026.07.13.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:51:25 -0700 (PDT)
Date: Mon, 13 Jul 2026 06:51:23 -0400
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
	stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of
 cgroup_mutex
Message-ID: <20260713105123.GB276793@cmpxchg.org>
References: <20260712174619.3553231-1-tj@kernel.org>
 <20260712174619.3553231-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712174619.3553231-2-tj@kernel.org>

On Sun, Jul 12, 2026 at 07:46:18AM -1000, Tejun Heo wrote:
> a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> made pressure_write() hold cgroup_mutex across psi_trigger_create(), which
> forks the psimon kthread for the first rtpoll trigger. As kthread creation
> depends on the whole fork path, the commit inadvertently created a lot of
> unwanted locking dependencies from cgroup_mutex.
> 
> sched_ext got hit by one: its enable path blocks forks and then grabs
> cgroup_mutex, so a pressure write racing a scheduler enable deadlocks, with
> every other fork piling up behind.
> 
> Fix it by splitting trigger creation so that the worker is forked with
> cgroup_mutex dropped and the kernfs active reference left broken. The latter
> matters because rmdir and cgroup.pressure writes drain active references
> under cgroup_mutex. Publishing the trigger last keeps error reporting
> synchronous and preserves the of->priv lifetime rules.
> 
> The trigger registered in the first stage pins the group's rtpoll machinery
> across the unlocked window, leaving only creation races to resolve. The
> catch-up poll on installation covers scheduling attempts dropped while there
> was no worker.
> 
> v2: Retagged sched/psi (was cgroup).
> 
> Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> Cc: stable@vger.kernel.org
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Edward Adam Davis <eadavis@qq.com>
> Cc: Chen Ridong <chenridong@huaweicloud.com>
> Reported-by: Matt Fleming <mfleming@cloudflare.com>
> Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readmodwrite.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
