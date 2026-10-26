Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037909;
	b=NWMywHrR1tzj67ETArZ3kAz1/Hb6EY9Rgow3QxpICS+FBvJLuhltNHpM5347oQZrYahF
	 abJPSDsC5NiVXOHwludFy5DHCu553KwxyS12CQPS9CyhdsVh/rHJ5IsvqhByeDKWzUVfW
	 wpMilxA21sq77df89IFncU74ooC4kVQdHKgQ7pvMEo75hhS7CVW1qYshsFJJuAm1f1OoP
	 GNio1dyr/AzQalEEKV9kXWbNTKzOVffv9yeGE5+HpAS1ciYXo9QerGrXqyjuqO0oIwyGw
	 wp2WUKoPsG/AN2DPzx/MUNriDTI5FMGXNU2Kxtng3Juwm+V5EBY63Y329sPUW4KKijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037909;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rSYE5PMCjtkYE/2kg/ihUpsjoSDnaarE8/1GfnhKwlM=;
	b=4ZU375KEPmwOuwXziyaS+JVk2uu89lMG+ZhNLntc0YY5fp5JPzANJNRMH5hMip+HvLuc
	 j1Vs4nWg6meuE8NxbYJz3+nUsjYIwpL4qDg/dKAPcUMeqp9YdWpcDa65oVXdvhyT1yZkM
	 0J9aNPKdnpYKZpxpjxecXlYmvdZ+ZkvVhfRG1fZv8rFqp3fvuz8yCHdYjiMb3bApIoHPM
	 TfuhIvffUBAD5Zw/9y7QY57ht0YJ3Se5EENCR7hL0JquJfO57AK6gp6F78Yeww0/ueDK+
	 i6uANrU4bK87/ecv16J/5dfBx9Ih+sWG1YVkqouaR6re6rEQoztxZnj/uvw6iyKpqJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpQTgW3r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76325606A31D;
	Mon, 26 Oct 2026 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpQTgW3r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB101F01825;
	Mon, 26 Oct 2026 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793037909;
	bh=rSYE5PMCjtkYE/2kg/ihUpsjoSDnaarE8/1GfnhKwlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kpQTgW3rDY1kY36F1bdm0miYZ7qkvzMiHcyoMuGIRhSZg80yhPvKxdxRJ5W2DNpt0
	 I6gAYk6hYOTLAEqH8qI+X+i0GZYNv6AQtPmYUNOwMxyD08Xio9hJR6JDhtVPjtt+2c
	 6OeChc//KC/hSRQsCQVeiyvmDo2C0KxPexzZTGLkw6rRpeSbjIG3QpImoUcRwULz8n
	 j7Uj660lB9mz/vFlMFInPEpDIr4WMSbX+ZasjwDlpJ2ZUcqqD7jiusTg8dOL1WNMI1
	 qo4w2j4PCvXPc32fKnnFbTQ8yj8gVUXudf+qfpREfOBTUskjKmklrsJle6s9kfkx/A
	 Ybfqosydthhlg==
Date: Mon, 26 Oct 2026 18:05:03 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
Message-ID: <at-WKy_zj2SYUhBa@gremlin>
References: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
 <at8-42OwXk2z6-HB@gremlin>
 <CAJuCfpFaxo06yHdVKsEEmFf9qoOYS0DbMvUuAZEhNfDe7dcwJA@mail.gmail.com>
 <8c5a8fb7-233e-4433-af45-b67cb2528b60@kernel.org>
 <at-M5hORjFt6aur4@gremlin>
 <ft4q2mxxiihpvc6wjs2pyku6fvfqg5r4brpgjvz4ikkeh7vwff@s6h5k2dxstk2>
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
In-Reply-To: <ft4q2mxxiihpvc6wjs2pyku6fvfqg5r4brpgjvz4ikkeh7vwff@s6h5k2dxstk2>

On Mon, Oct 26, 2026 at 02:01:47PM -0400, Liam R. Howlett wrote:
> On 26/10/26 05:26PM, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Oct 26, 2026 at 06:19:18PM +0100, David Hildenbrand (Arm) wrote:
> > > >> +       /*
> > > >> +        * No lock was held since the last call, so the iterator's cached range
> > > >> +        * may no longer be valid. Always restart by address.
> > > >> +        *
> > > >> +        * The vma_range_is_empty() checks below avoid unnecessary mmap_lock
> > > >> +        * fallbacks.
> > > >> +        */
> > > >> +       vma_iter_set(vmi, from_addr);
> > > >
> > > > This is clearly simpler but this unconditional vmi reset is not ideal.
> > >
> > > Yes, exactly how I ended up where we am right now.
> > >
> > > I pref my current fix as something to backport that avoids performance changes.
> > >
> > > If you two disagree, please take it over and drag it over the finishing line in
> > > a timely manner.
> > >
> > > I wasted enough of my weekend with this over-enginered piece of software. (had
> > > to change one word before sending, can you guess which :P )
> >
> > No problem, will take over.
> >
>
> Just a follow-up, another option: the vma iterator can check the
> previous end from vm_end and set the maple state to the range of the
> current vma if they disagree. Using the set_range() and not
> __set_range(), so the next walk will be a new walk immediately.

Ack, as discussed will give that a go and see how it looks taking on board
Suren's feedback also! :)

--
Cheers, Lorenzo
