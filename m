Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39237FF6F;
	Fri, 18 Sep 2026 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764224; cv=none; b=A5bojw1txVFB7QtZDSFLxm8yrJiTwZXGnKM1iqRMRV4NdhgcERBKzycxZvgIRcaHm0/x1ZDFBf3mgikIKhqNdohqc9iOueZvlzQVmUXjWkRkF6MsfI3pr7SZc6EcsiPHF35jDXV5cSTO7WB0wztcWOWFNj7rP3LP+cRo2WUD8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764224; c=relaxed/simple;
	bh=6g2QQvOrXpCndDqSK7FoLnuzLN9kp/hwlqWrR8+JHU8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uLnjFRYuSuEimpr5G6sKmXMT0ciMCXU03z5xdTgR7opUVzEBmJuXsQRrjGMFrlSKSqPVqaOIFHCK3++esXmRMXXH0KWmtZbGql8L1EA0wv5LbNvQ3os2Xw0UkNP5npjCgdv0zmb2wKgGQk/3Y5N0dIJDn3GIur3bMd14OOfqKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sRguR3+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sRguR3+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BF11F000FF;
	Fri, 18 Sep 2026 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789764223;
	bh=s5ambLtJv/AuCg2Coh5juy9jqmqcd8mcPlwipY+ptBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=sRguR3+DzyOGGRDDZzh1ApJrkGYDqyORnnvJ88iY2Aw8UWAGYl3NM+ahgzTDYCNI1
	 43gfg1whBdkDPOtx1iSARXCM0t1z/GQ1LGXdyUdJ149p0YR5KdlJxPDwIk/RlwNx1t
	 uzb4TdoOIM3UqeyRUCvsdl8NzSYJmN8raMNiQCWs=
Date: Fri, 18 Sep 2026 13:43:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: paulmck@kernel.org
Cc: Breno Leitao <leitao@debian.org>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: report RCU-tasks quiescent states while
 undoing a range
Message-Id: <20260918134342.c50423cfe3b2910e899226f2@linux-foundation.org>
In-Reply-To: <a67e8b91-ebc2-4d3d-b6ea-d221b297fad0@paulmck-laptop>
References: <20260918-shmem-tasks-rcu-v1-1-79acf91a2569@debian.org>
	<20260918123239.8f25b984ca280fcc11ef6e6a@linux-foundation.org>
	<a67e8b91-ebc2-4d3d-b6ea-d221b297fad0@paulmck-laptop>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 13:24:53 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> > 
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -1367,7 +1367,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
> > >  		}
> > >  		folio_batch_remove_exceptionals(&fbatch);
> > >  		folio_batch_release(&fbatch);
> > > -		cond_resched();
> > > +		cond_resched_tasks_rcu_qs();
> > 
> > Won't this change remove the cond_resched() function from old kernels
> > which really want it?
> 
> The cond_resched_tasks_rcu_qs() macro implies cond_resched():
> 
> 	#define cond_resched_tasks_rcu_qs() \
> 	do { \
> 		rcu_tasks_qs(current, false); \
> 		cond_resched(); \
> 	} while (0)
> 

Oh, should've looked.

And it appears to have been this way forever, so
s/cond_resched/cond_resched_tasks_rcu_qs/ won't break old kernels.
