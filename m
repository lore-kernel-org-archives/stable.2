Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D043F8ED1;
	Mon, 27 Jul 2026 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151537; cv=none; b=X6WhYVimlx5cx26NKEKuymzccQ38FhxSDDV9JBLULZ9eqF6Ur9u1XB5wdlDMCZGmZv06XVrohv5uEJVOaLFiq+Lrn/CfRy+lU3PQUdO5GUtNNTtHHYPzFDhNPC4TQeYC6kQWun8lg1GnpFFk+SB1L3E6iprjFBjnn9W9WA+8lBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151537; c=relaxed/simple;
	bh=08+hT4LC6IqwRNx8zMGRqwSU5ng6RkaDJeOtLNkTdSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzlivfTLYHkmld+oPRSJKNu/YziWBSq3m1bvnoyK0R0ge9Ia5NZPUxjuNzAT3Q9dGlctTfynMBx/SXA3tnGtdT+IDGLWbtFtSryfm9UCcxpkC/C+utIgFJE7PwpV7NE+mMPiQXVIeWVrjghnNtvyJiblyh+ns7s22HEdBkud5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gURdEEhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gURdEEhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2042B1F00A3D;
	Mon, 27 Jul 2026 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785151536;
	bh=08+hT4LC6IqwRNx8zMGRqwSU5ng6RkaDJeOtLNkTdSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gURdEEhEMWvzjd7vCRhS6YHmdHjStShU1vGvpoiQFhv3EIePzPg0zaS2IVVaVfL0A
	 9sLrb3O8GAXBsYHsgtmSMBkzFlidv2ecDqzVqJNV4gxjCm4tB5XZEtqieHbUu7joyq
	 R+X8k/H7b1DwQYwB+hJuSsEIZzHRhVVFwwq7/SFYnJm00U2OBTo4AHX6RBD4kJ3y7F
	 /2qYLedwNCmXRc0KWDfgVx4+k6uIilb2wNPFkmp1pcnnLBOMzE20vmeHketJokrJfI
	 lMnupykmxG7Y5JbVe153paj0CXj6WyGW8X0iWfjeG6ql1OUh+IkUrPbLlEs2tCZzWm
	 HEIZ9/i7+Nn0w==
Date: Mon, 27 Jul 2026 12:25:16 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Denis V. Lunev" <den@virtuozzo.com>, stable@vger.kernel.org, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: Re: [REGRESSION]: [PATCH mm-hotfixes v5 3/5] x86/mm/pat: acquire
 init_mm read lock on attribute change to avoid UAF
Message-ID: <amc_24CTvgPj8VV1@lucifer>
References: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
 <20260717-series-vmap-race-fix-v5-3-606a0ac6d3e5@kernel.org>
 <80993b70-352f-4069-84c7-39a04c061e98@intel.com>
 <amIEC1qDW3kfeuHd@lucifer>
 <15f365d9-b5b9-4dc1-b24c-1b6f9363e9b1@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f365d9-b5b9-4dc1-b24c-1b6f9363e9b1@intel.com>

On Mon, Jul 27, 2026 at 02:30:57PM +0530, Borah, Chaitanya Kumar wrote:
>
>
> On 7/23/2026 7:48 PM, Lorenzo Stoakes (ARM) wrote:
> > Thanks for the report!
> >
> > A small note - it'd be useful for you to clearly point
> > out the revision of next to make our life a bit easier :)
> >
>
> Ack.
>

Thanks! :)

> > (another small note - running scripts/decode_stacktrace.sh would be hugely
> > useful as these offsets aren't so useful unless I have the exact kernel
> > binary you have with debug symbols :)
> >
>
> We have not been asked for that yet but we can surely provide it if it
> becomes absolutely necessary for debugging.
>

It would be SUPER useful if it's not too difficult to implement, thanks :)

> Thank you for sending the fixes.
>
> CI looks good now.
>
> https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?

Great thanks!

Cheers, Lorenzo
