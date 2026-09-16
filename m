Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C34E80C0;
	Wed, 16 Sep 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558275; cv=none; b=DP+LGn4G4dq8gpxkFKyloxfFHaBK69ZD46C6SyrbPkwhAhCRZoplREK9RJcud0iNLrkXcr3rzeUCuqEFQfB9njb/yTLLBfO+dGDPSPjlLMjCR83igwYhwdyve9fgYYYkfujRpln+4cOGvEJnDwh14gOm0XJxJdrwJQV5yOVOEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558275; c=relaxed/simple;
	bh=DJLTl1Cq+69Qn/Uf5a1VBdcbpPjUviqgT037jU5s9f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8XNfWk59vJCZv2kNSJDtzKtHroQuL9SNSWtbYjWS6Ejje9WcvOLInXWiObAdKPUbsT8TiW2sWJCOGVLmEDaNENZP34EIZIOOOGeURcgG2Vt6YGkp0b0L99AL2qgkyJ65qSI83pCpScPO8uEuPSK1xRsg97y3cGda40EmN5Vi+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JInK15Ne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JInK15Ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D870B1F000FF;
	Wed, 16 Sep 2026 11:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789558264;
	bh=d3aQ/RHXKAOVlFbFC1F/OA3OtXmrvIqiX5Vn/+TjVtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JInK15NePnHwnp5y0aeKVDsmdAWQ8ljldVfQpVz0MS0LQJtQw6xAdjqUcD11+caw5
	 j04ipBiOhLho3PxcawONN/CNz5rKhn3QLdRjSMjrFCR9qfLuG2i6ir8g/hV+P/B/kO
	 7lluvELFD+ej13n46WiWLJSF2G77vOKF744TzZHuWT/HW4vElneAba8jl6gsZ1t0cm
	 LGmel36amcsfpCcrvO+h9UCuoB3H5dtwncIjPLSIeJ42cn64gluNG1XGbhZwAzKzDX
	 AnDRxeXd7PuKQyiz9pwLE5C/8PblfNiwJA+38zoHGRbM6g0KTfrCbY0d4meDIcxuZ1
	 wZtv5VHieRyCA==
Date: Wed, 16 Sep 2026 13:30:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/6] coredump: hold RCU while releasing parked threads
Message-ID: <20260916-aufrechnung-urnen-jenen-519900ff6667@brauner>
References: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
 <20260915-work-coredump-fixes-v1-3-f354ca41780c@kernel.org>
 <aqlglWwVeh4rwL0q@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqlglWwVeh4rwL0q@redhat.com>

On Tue, Sep 15, 2026 at 05:13:25PM +0200, Oleg Nesterov wrote:
> On 09/15, Christian Brauner wrote:
> >
> > When coredump_finish() releases the threads the wakeup neither holds a
> > reference on the task nor is it inside rcu.
> >
> > The threads don't necessarily need a wakeup to exit. If it gets
> > preempted or was woken for other reasons it sees ->task cleared and
> > exits. So only rcu keeps such a task_struct alive.
> >
> > If the coredump client is preempted between the store and
> > wake_up_process() for longer then try_to_wake_up() takes pi_lock() in
> > freed memory.
> >
> > Hold the rcu across the loop.
> >
> > Fixes: a94e2d408eae ("coredump: kill mm->core_done")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> 
> Aah, thanks...
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> 
> But to be honest the changelog looks a bit confusing to me...
> 
> 	curr->task = NULL;
> 	wake_up_process(task);
> 
> So wake_up_process(task) is not safe, task can exit after a spurious
> wakeup if it sees ->task == NULL.
> 
> And perhaps a short comment above "curr->task = NULL;" makes sense?

Yep.

> The reason for guard(rcu) is not obvious at all.

Ok, will change.
