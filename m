Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48734ED187
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778188; cv=none; b=ipl7TUBdNEA8W4kEaLgGmuYDXoX1BhZiXkQfnEeST3UgDd2D93Z+T3jdTbwLMS4W63bJ67PIka5E+JqzWnB0jI/vEBkRCqKT2q0Dh0zrN1sFvJ5O6ItGxyQqYlZliKvFfodeFfcmWVc/eHeR/xOGfqAcfS4BRG8qwd73vZ+4rZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778188; c=relaxed/simple;
	bh=8BC5tkKKu64JweVfwPgvVAbEzr4IHGwzukxK7lfs8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoB4yakZYEqe9x0l6+jCi4G5OPWC9k1nuG9H/TEa+9LTGd/FBkdB46Ul9y0AeNAfqN9A9XHgspSE03EjITSgjIwQ/FvZ6biUqvudF1fEpggrHq2aHY+pb1tSDRgFYvd4C6VmjbmB9BWw0KbQ09WjqsNYwmPhniSVXXoarYAfjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=dApGPgat; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="dApGPgat"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c59695cc9so377129985a.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1790778177; x=1791382977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hYt6A34RfOeHkAot7XirdGnjVpo9UvZvKcMPW6ASkzI=;
        b=dApGPgatlMJ954ve69TvCXEJGQLZRm25f7FqjDkIQg6z7Mt+WeK719H2wEu0JHXa/P
         64T29gyakAiocg8+Nc6QAg2+OU5FzHOpTSlHs1QogzlbOkprjfxHWjw/4KI/Ug0TuGTd
         j9R8UH1HAfoYJ+bs70O80BoTVm4p6rurApgINlL6QjS2Ej+weSbSLLDLhcMaBOBE+E0w
         XWKgqjwIihKo6rzUP0ZXeyisG83vXgt0K4ezpOrgTwvqinekRO1ImdEzP66QEf08642M
         qsGI3fdkOnhoaHegYg4vc88+mp9yZP7RBLc7fXGlA+UAt0mPPYZBaIrtncIkaJlr0qpv
         ZuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778177; x=1791382977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYt6A34RfOeHkAot7XirdGnjVpo9UvZvKcMPW6ASkzI=;
        b=Rh+Dl2EnPPtkxFge1MuC2aebXfoz/ze9H1Emvyvzugo529qIWnS+hakCobcauPdvUK
         rGBJFSkNtWgirYETAgupARfVdIO7p6hFWInq1nq/GXC/kj59xIvtnmwQQQudlLEj17Av
         1YkHPFTbudFpFSYg10zfU8beU2bKkuyGKN2o97LAPX2jILRufx1vNATEdZliLJaqu+q/
         0azJMsJ7bBtzPB98NGpngGnhd/I24pKrUip5ygiFAfpOqhquR60aWxGjUCprRQM7D70v
         JCZOA1MUFYx+S6dWtzz4EqqTpOUa5iXX7CRHSh+7qE+qR1EVMLE6EKI+e2XrQpXEWkEn
         MVXw==
X-Forwarded-Encrypted: i=1; AKwUvBzwwQc5q5ACItObvF7jKJ56liTygsrS4BENwIL2a8Z/lisNU7go/eg/leevxny/Z9mHxKyCZ98=@vger.kernel.org
X-Gm-Message-State: AFuF++nOEZ4l6u+lxW96Igv4pq4hRlbdtqXF6ibPYp8tjY2jnmC7x00k
	MyZL+lXEdRl+SZWAXlyzkSAK6OsYKzM7uzR9RkpIpyN3j595xMc9dOFoqG/oB61I98s=
X-Gm-Gg: AYBFou1U9mP8nf2Gbx+Jo3xUdH/ojSFVrOrVy/gkyy3SBDx7xrOlUSDFX61jwxsKh5O
	0Nqznb4SgUCcsnMe9099M08TcUCXDBhUx26ZiLd3bPv7/13nZ8O6ewrwu5F+GFs0zjTpJwUIrun
	fgaEE41T/F5TzDD6VdKrP04idzUlYGRiMpSuJlYxEd1bp1pOxjsGZKnV92b/T7X8Coj2ooTQM9j
	xcdFgm9L0t8f80DOVtxRMc8Bn98mHjpYumeW1uCVFXg5PGDfmxYFOHx9XFFOW4RzhzlHarSBVUb
	FjLGehGHnj8xRlC+1Rm87AFzGaI1IkJyNRsJop1mF6rCCRneggM9e6AS6dDMAZkgDM9xT4nmnS2
	ZvT57WPMZrVhY9r3dDudW75DGU9wO/kdq4bsy65p4Fut28uqrBmdrdENGUIvuJAJ7TrHcog2nSf
	dKW1hQlgpyQGHSuH4vvAWS26pXWsuBZuI2tF+Ih2KpPTGX/yf1GLHwte1yQQ3ZL3exaC9t
X-Received: by 2002:a05:620a:3195:b0:92e:76a1:96cd with SMTP id af79cd13be357-93ca96692cbmr280574785a.13.1790778176896;
        Wed, 30 Sep 2026 07:22:56 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ca7eae7e7sm126812185a.3.2026.09.30.07.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:22:56 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:22:52 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Stevens <stevensd@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched/psi: clamp negative cpu_clock() skew
Message-ID: <ar0bPEyD5CBK331p@cmpxchg.org>
References: <20260928233743.3777102-1-stevensd@google.com>
 <20260929081004.GS4120091@noisy.programming.kicks-ass.net>
 <20260929081740.GH4121620@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929081740.GH4121620@noisy.programming.kicks-ass.net>

On Tue, Sep 29, 2026 at 10:17:40AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 29, 2026 at 10:10:04AM +0200, Peter Zijlstra wrote:
> 
> > > When running browser workloads on an Intel N100 with a sustained
> > > psi.mem.some of 2-3%, this underflow is observed once every couple of
> > > hours.
> 
> Reading is hard. This is sad, that's a relatively modern chip :-(

I'm still struggling, but I'm under the weather so bear with me.

That's a cpu_clock() implementation issue, right? "The value for
cpu_clock(i) is monotonic for constant i". Presumably violating that
would be a problem beyond psi?
