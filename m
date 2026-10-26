Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037718;
	b=PSnuLPPEtOkKUfBH9YUkx78cClnjboTg3IokMsdaqGzNiyd8CoFsXYQjTzx3wLsTce80
	 ZmSlE9VwwzaMaLaIb0B1ycyZEiZXGw+2ncLNhNmi5tm1R+Tt4jHJpR1O3D3WEF7DWU9fH
	 fR+4EP7ksCCmaM7rzS9hFTKmglSOU5ExJchFF+WBVH1gV0nkqkZSuQSvHQgrWaHBNRwMB
	 aagPsx0Xh+YmyvQuq2Khb7zsljLutXUMzo9d/Eqj8V79dHuevEwJvak6+99bIbxr+zmtN
	 RkXY0bDa5M/mQR/yBULv+y2RodwOK+/F2vbHCSJg0FI7IqnAEfIgYpYMEEfqCX+1tKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037718;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3PFsJLihFaPQXHz4UKfvj2WUy9LWdZX9tEl8YZxtmyM=;
	b=UslAP2LIayvhcmMda8AaUwOS5SAWWbNVypkJ7ACsNDre2b1rJ9Q4knQC3ASKyg1HKqF1
	 83RlK5Ekz4orRR++/3vkyNu8zMPwzghgwIALs+oyE+cwzEfjThXHeXRqA7KLxHbuMQAsl
	 WVZblX5hvG2NEda3BkB+g6IEiJ4IWlbN9w455Zqt62ynn4UgMZbK7nhD7Ht/Syz+ZkvHm
	 KA4cdxLC2OFywEZE6i1q3P9zzW9FEXYYyWeyhwPLYz1qtUZlSIz3FBokTD/fWixpqWob9
	 TUWafThQ1Ts3e0kP/wSGkXsAAHQJMafzOFIO0NAjZf4i6/gr+YWagVNi2MIl8nJMpnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PumzwmTQ;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E8606A31A;
	Mon, 26 Oct 2026 18:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC6E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PumzwmTQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3PFsJLihFaPQXHz4UKfvj2WUy9LWdZX9tEl8YZxtmyM=; b=PumzwmTQ9yri+zottlvBujb8h8
	G0+sZp8mwMJwQwf5pcjJJvRZICU677fKHFehVVnmMNH6OuFohjOjRL/wBGGFRuHx50Y45Uaf7Ujtx
	6BZjIXuRDMOoF9PFSiRQm9f5TeQIsPy40Pa0JnSJbPYnUlGD9D3TwDjhHX9wUobWNdRJiy1KDNiaI
	GfvrMFGXPovbqP8CNFgH9z5EHgOfQuKMvn2mGLRb8Zs9Si6/013n/WuMTHJRb3e8HRRcYF37rSiZ5
	SGJJMLEGDNNuRSRTbCIfZr1JbW1bYJpnWtfOajpPqWDz9e/ouWg0qnlYgzF0A5SQolcoZIw3jTbd8
	26Vq1oUg==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLP18-000000032DW-0VC2;
	Mon, 26 Oct 2026 18:01:54 +0000
Date: Mon, 26 Oct 2026 14:01:47 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
Message-ID: <ft4q2mxxiihpvc6wjs2pyku6fvfqg5r4brpgjvz4ikkeh7vwff@s6h5k2dxstk2>
References: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
 <at8-42OwXk2z6-HB@gremlin>
 <CAJuCfpFaxo06yHdVKsEEmFf9qoOYS0DbMvUuAZEhNfDe7dcwJA@mail.gmail.com>
 <8c5a8fb7-233e-4433-af45-b67cb2528b60@kernel.org>
 <at-M5hORjFt6aur4@gremlin>
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
In-Reply-To: <at-M5hORjFt6aur4@gremlin>

On 26/10/26 05:26PM, Lorenzo Stoakes (ARM) wrote:
> On Mon, Oct 26, 2026 at 06:19:18PM +0100, David Hildenbrand (Arm) wrote:
> > >> +       /*
> > >> +        * No lock was held since the last call, so the iterator's cached range
> > >> +        * may no longer be valid. Always restart by address.
> > >> +        *
> > >> +        * The vma_range_is_empty() checks below avoid unnecessary mmap_lock
> > >> +        * fallbacks.
> > >> +        */
> > >> +       vma_iter_set(vmi, from_addr);
> > >
> > > This is clearly simpler but this unconditional vmi reset is not ideal.
> >
> > Yes, exactly how I ended up where we am right now.
> >
> > I pref my current fix as something to backport that avoids performance changes.
> >
> > If you two disagree, please take it over and drag it over the finishing line in
> > a timely manner.
> >
> > I wasted enough of my weekend with this over-enginered piece of software. (had
> > to change one word before sending, can you guess which :P )
> 
> No problem, will take over.
> 

Just a follow-up, another option: the vma iterator can check the
previous end from vm_end and set the maple state to the range of the
current vma if they disagree. Using the set_range() and not
__set_range(), so the next walk will be a new walk immediately.

Thanks,
Liam
