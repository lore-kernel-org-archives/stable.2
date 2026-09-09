Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6888550DBB;
	Wed,  9 Sep 2026 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981234; cv=none; b=ITkpipUPZn3tbF460qjkk7BGYyzrLzosdzFTJ32RqttmMGXrAj34Dh35o+jl/c8qfRVTEjpuBNSRdV5UlZS1oIkkShUwfN4n82/4T6uTKOjZesGL6vnNaEa/HMlFYjTfSrQEkha+bzE3JLfkbDYBdLHls9UmRL1wWVSTr3480Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981234; c=relaxed/simple;
	bh=2zqeMdfMgzgLSz4WalrmXPvdFX+4uJ6wmlBvyPJsE24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEuBC+GvAgZoGtPa9U3bfldjvPbhjL+ogYJAvjaSpW6BgIwVTEYq+cy6N6oxAJPzdMh4Tp38c8yl3J6GerSfs0cCzYKX93MbBpDei3NeSRbdmx/ObjSIOYPFs39bsbEjmn85pUl4ypw4CU6scWNZ0muRWkuGqRzhhgpMedIXKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp5QCKRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp5QCKRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789AF1F000FF;
	Wed,  9 Sep 2026 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981230;
	bh=GJQLOIo2F/8mgbaZ6MM/HOKjSOsdGspfu+Rgpw9gTLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sp5QCKRGqnjtgftM39OzgG9o3glYhC+pUXsZYdO21iDX/IQKGR305FK8SU+gUUHmH
	 EzvxMEEF5giefLVCAKnxpz42h3RhUGy85cUc9rxoEJGDwAFsQuY++Ir25TD3YrKPvc
	 ZETtroFS/VizLPnltYkazT64Q8hGpCzwF1OilDSrkgqiCSCsUYr+x7I5XvlDFMAXZh
	 uLgF1WfYWu/jodY5tkqEjRYJgQS86BFaUfwYL1GL5+TcF06c4VZP9jTTRJEwxsZ9kW
	 auRlwbJEbnWhhoa4ud0i4CrjYK7SZtm8V25+Txnn0PPSpnBVKn1RswiLii/fnSGGvt
	 p05HydOIsCMDg==
Date: Wed, 9 Sep 2026 09:13:49 -1000
From: Tejun Heo <tj@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb
 drain pass
Message-ID: <aqGv7R4LTmlrW6QI@slm.duckdns.org>
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
 <aqGilhgcEd0qaHjI@slm.duckdns.org>
 <16d13239-8911-4597-bfd6-18aa02135137@paulmck-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d13239-8911-4597-bfd6-18aa02135137@paulmck-laptop>

Hello,

On Wed, Sep 09, 2026 at 12:03:20PM -0700, Paul E. McKenney wrote:
> > The patch looks fine but this overall seems fragile. cond_resched() was
> > already marking "stuff that can take too long" but we need to use
> > cond_resched_tasks_rcu_qs() if it can take *really* long. There gotta be a
> > way to make this more maintainable. If always doing tasks_rcu_qs from
> > cond_resched() is too expensive, can it be be gated behind something cheaper
> > e.g. some tick based test?
> 
> This is the business end of cond_resched_tasks_rcu_qs() in preemptible
> kernels (in which cond_resched() is nothingness):
> 
> # define rcu_tasks_classic_qs(t, preempt)				\
> 	do {								\
> 		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
> 			WRITE_ONCE((t)->rcu_tasks_holdout, false);	\
> 	} while (0)
> 
> This is pretty lightweight.  Adding a jiffies check would likely make
> it more expensive.
> 
> Or am I missing your point?

I found the following thread for why there is a separate variant for
cond_resched_tasks_rcu_qs():

  https://lkml.kernel.org/r/20180224151240.0d63a059@vmware.local.home

The rationale was that it'd make cond_resched() expensive, so I assumed it
was relatively heavy. If it already comes down to a single test, I'm not
sure having a separate interface makes a lot of sense. There isn't some
semantical difference between the two, right? Anything which takes long
enough needs to do the tasks rcu qs, and that is what we mark with
cond_resched().

Thanks.

-- 
tejun
