Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B53C3439;
	Fri,  7 Aug 2026 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089546; cv=none; b=UqrKRna9UtNx+BplFGBev+I0kInVf30qJuBXcNXjbFzUfURIhTnocaUKJh5nLSvJBMZH5i34gBXYXxAsRn22Dz0mOeIUilXCUu7v7NVXa+QdpaeaIGnPriVqEP9dNMtnfRdUWUGweONeB+Z/meTxo+bObgCMVTjctpwuv8yM6N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089546; c=relaxed/simple;
	bh=NbJ9IVpwycZnmQ+/PVsvEhvqqY3XRHwI92BLOJF6e6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c07Q5fnzB4+z+CYaWpNnZ1uX25X4qWOxBf7wcsrRzERWgN7jray+RGqmUvMP7KzFSDOuXvZ/i8Xj3b5l2lcK2aAPOr9WRETyJCSlb46Xz0rOcObOvStB6Im99+347KI9ThwQ6vAEmDBG645jseDG1J/50l5VH+RHqtK1hJoi3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLWDOUMG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLWDOUMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29271F000E9;
	Fri,  7 Aug 2026 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786089542;
	bh=NbJ9IVpwycZnmQ+/PVsvEhvqqY3XRHwI92BLOJF6e6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oLWDOUMGHncsHIjQEsJMJR95AovO72eNAZUuqaxIGDeDFzVcKIigaGDzQbfglRwpI
	 X+4BqK5mJUlvQB0Q3LYFZL3x3/BN7P7Lb+bSEQARTSqJTxyl75cM/mHp2RCGrlQY3e
	 SovjrIgCPIWkB/6Sp06qJBLvhzx6Z7uyFC+EkaNWOw+AwmY5vExfyP7gnQ/KoQ27VY
	 w90YNJfp6BMXuT8y1KUIXA98bgkeM1vV1D0yeoE93z6x4kbvz9VKo/3soeEDfWq7Z0
	 8TIMK3Pf69bE40NbCf73s1bH0DFS1h79zi/CmnskhUR+dmjSoTNikbL0Dc14+jg4KI
	 jnUgD+BTDdQDw==
Date: Fri, 7 Aug 2026 08:58:41 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: sparkhuang <huangshaobo3@xiaomi.com>, akpm@linux-foundation.org, 
	bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, kees@kernel.org, 
	kprateek.nayak@amd.com, liam@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, ryabinin.a.a@gmail.com, 
	stable@vger.kernel.org, surenb@google.com, vbabka@kernel.org, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Subject: Re: [PATCH] fork: reset pointer tag of vmapped thread stack before
 vfree
Message-ID: <anWQIwKDHj-8SXO0@lucifer>
References: <anSVlVpUXrA8ra_z@lucifer>
 <20260807065351.93659-1-huangshaobo3@xiaomi.com>
 <anWPTt4DE-Q8PKry@lucifer>
 <15a1b3e5-825b-4ffc-9349-de771cbde7fa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a1b3e5-825b-4ffc-9349-de771cbde7fa@kernel.org>

On Fri, Aug 07, 2026 at 09:57:30AM +0200, David Hildenbrand (Arm) wrote:
> On 8/7/26 09:56, Lorenzo Stoakes (ARM) wrote:
> > I'm sorry that whole reply is more AI slop and I'm not reading it.
> >
> > I have zero interest in chatting to an LLM via a middle man.
>
> I think we should start charging a workslop fee of, say 100$ per patch? :)

I don't get out of bed for less than $1,000 ;)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
