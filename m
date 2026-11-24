Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546283;
	b=QmydLIAK52qmjiXy27vtWPQATMGq/fdIZpM7/JRgqRoWJVHHhCLxPY+iXq+OI9T3Cy7L
	 EdMT6QUYd1Kfzmx4PAsQLV04VEXYtFdQw7OauvyrwqW6VbcdI6mltSLpXpj2pSvKG7F9V
	 hN91QxVumUgJnp1NvsIb9I7ZpNmH0QfxmP/nRX6Qo8wugV2IDcu5faxOxTbUMfQ0ezXYL
	 h4mOeizoFCo/joIBs++BadNqmCvmYkrfNMBQzLvI0VSXf3OC+3p2xOP5UQzcurTaoNN6S
	 MHV+F2r3+nGffEAEsWGv7/Bix+owq9gZ3m1DcYCVeGIQbhp0+lxKsNmD7FsJS/sgHLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546283;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=L6NqhcU1tLVcfEpjY2Ck1sJrOKIOcHdxKOQPUwApeeM=;
	b=RpExgYp3dsJor+hBIrWcnVe7lP52swtXbBCzqr2TAtC7BuRDKiruQdQtxkDpTfKIG7Ml
	 ZgJa0IIndB+rq3I0b0jBgUMHrYtbpBKOKe+bYLwm+oxNsZYqzNynolzuCL1Fqk8S8tfGV
	 LRAY8EdmYNsxE7e+EUh725i7zy124ddxTMlaSCCSuOoD8V8D4ZLvHb3LPpIxrKS7eq+Ch
	 3xfp5pswXulA0r4DlBpTRYwg+qfGBwIIqtVPSs+1dlPOzh2AqCx3vxIekxGV94lsT4D4k
	 +RDlQuLrMz+b1F49qdUOPNk4ai5b12EAqkCzc7G4HCr9lRLPddwxPMXmVzsljvxpIiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3kfl4NR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7125606A31E;
	Tue, 24 Nov 2026 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3kfl4NR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33B71F000C0;
	Tue, 24 Nov 2026 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546282;
	bh=L6NqhcU1tLVcfEpjY2Ck1sJrOKIOcHdxKOQPUwApeeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I3kfl4NR9qEuuyy0EjdjDi7dgww4iRyl8pwU8q9GJgU35EDQQZO5ws/pf0MvK3OzB
	 bYSZhRJ7hqHJsrjKKU7Eaam2n28TfeXl0ZyEuNKTTv0z5w1fI3UgjqtemhH4+LX3lZ
	 +KkFX2UfhQ6Iud3xifvU8gfvbZ7n8zqpfIi1+A/csWvw6qnVntjlm2EAh/3sLZ4Y/6
	 u7Zlq9w3FY3w1maR1Ag+Vdj7n1RzSh84grOnwKsb4tvEcAWdtLIxP+PE9wnTmHCdRd
	 1VmKb6nJqO05uf6Ud2X3rtpeg0ol4IBoOT6HeGKnBdKThZdSF9/wjz5N4MDHQEPtQO
	 N8TehsE9SnokQ==
Date: Tue, 24 Nov 2026 18:51:12 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
Message-ID: <awXbVeK7F2DmgL-9@gremlin>
References: <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
 <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
 <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
 <awWz3nc_b8x3mIXq@gremlin>
 <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
 <CAJuCfpFuDCUPTUi3SuAhmbtw5tubRZ0+YEY3PotjyJ8Or8pdQQ@mail.gmail.com>
 <awXHR007d8MlhJUC@gremlin>
 <20261124093328.3ba2e066e5d5081c69e0e667@linux-foundation.org>
 <CAJuCfpEmFEX5iqLw_c94a97rVrC+xBWpKnO4rVpeDgkUfAPq7Q@mail.gmail.com>
 <498284d2-70e4-4b6e-978b-98a2b9e1e74d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <498284d2-70e4-4b6e-978b-98a2b9e1e74d@kernel.org>

On Tue, Nov 24, 2026 at 07:35:39PM +0100, Vlastimil Babka (SUSE) wrote:
> On 11/24/26 18:49, Suren Baghdasaryan wrote:
> > On Tue, Nov 24, 2026 at 9:33 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>
> >> On Tue, 24 Nov 2026 17:23:35 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> >>
> >> > On Tue, Nov 24, 2026 at 08:34:40AM -0800, Suren Baghdasaryan wrote:
> >> > > On Tue, Nov 24, 2026 at 8:06 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >> > > >
> >> > > > On Tue, Nov 24, 2026 at 9:28 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >> > > > >
> >> > > > > On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrote:
> >> > > > > > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
> >> > > > > > that RCU unlocking move you don't need other_mm copy and the comment
> >> > > > > > that comes with it. VMA won't be freed until RCU lock is dropped.
> >> > > > >
> >> > > > > Yeah but they can be reassigned? They won't be _freed_ until a grace period but
> >> > > > > they can go back to the slab and then allocated elsewhere  right?
> >> > > > >
> >> > > >
> >> > > > Yes, they can go back to the slab and become a different VMA.
> >> > >
> >> > > Yeah, you are right about that. So, we either have to keep the RCU
> >> > > unlock in place to keep other_mm comment valid (my personal
> >> > > preference) or update the comment next to other_mm to explain the new
> >> > > reason it is needed. Either way is fine with me.
> >> >
> >> > I think let's just change the comment?
> >> >
> >> > Andrew could you change:
> >> >
> >> >        * stable and can be freed in the narrow window after vma->vm_refcnt
> >> >
> >> > ->
> >> >
> >> >        * stable and can be reused in the narrow window after vma->vm_refcnt
> >> >                            ^
> >> >                            |
> >> >                            just this freed -> reused :)
> >> >
> >>
> >> np.
> >>
> >> --- a/mm/mmap_lock.c~mm-vma-drop-mm-asynchronously-in-vma_start_read-fix
> >> +++ a/mm/mmap_lock.c
> >> @@ -300,7 +300,7 @@ err:
> >>  err_unstable:
> >>         /*
> >>          * If vma got attached to another mm from under us, that mm is not
> >> -        * stable and can be freed in the narrow window after vma->vm_refcnt
> >> +        * stable and can be reused in the narrow window after vma->vm_refcnt
>
> But this is talking about the mm, not the vma, so the motivation to change
> that was wrong? (it's not a typesafe cache). Moreover...
>
> >>          * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
> >>          * releasing vma->vm_refcnt.
> >>          */
> >
> > Sorry for being pedantic :)
> > There is also this comment later on:
> >
> >         other_mm = vma->vm_mm; /* use a copy as vma can be freed after
> > we drop vm_refcnt */
> >
> > That should be replaced too with:
> >
> >         other_mm = vma->vm_mm; /* use a copy as vma can be reused
> > after we drop vm_refcnt */
> >
> > Again, just replacing "freed" to "reused".
>
> Nah let's not overthink this. It's freed back to the allocator first. Which
> naturally allows it to be reused, yes. It doesn't matter if the underlying
> page can be freed or not. UAF is a UAF.

Let me just send a v2 that puts the rcu_read_unlock() back where it was, I don't
really want to get into some long debate about nitpicky details. I just have too
much to do sorry.

--
Cheers, Lorenzo
