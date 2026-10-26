Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011472;
	b=qpgUGBExyPssZnY82u1s9VqcfdVIs1Zox3pYDA8R9gmTS4xY3ohtyGWOanyvUHSqdyvp
	 woDEuPSlJWQVQdzPyZxw+GEP9WAxdMhaJ/7bKIj64rl442A6QvLqnBdejT5oSG/Gg+gD2
	 njmTzhE7y+AXFho7EwI3TYtKTTpXArT1d1e3uHfaw7wJZpTL7gu1tsvYFkx+yVx47C0/u
	 8t/FJrgUMeRXgtamuJ8LePxedDosH2h9U5hSUQ4phfHIj5PHdqAn+NuJrZFap/6QFG2XO
	 zj1cfvy36J2GKAoLaC/VJHh3krUunzTR2+L6Jut2AzZT1cs3XMyhSmpIh+yzzKD+MYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011472;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZT3sIrPYsLf4bF7EjJfBOJes6yXJ8vu8pSt2SltAhV0=;
	b=DiJpdeAo7W62D6Kf1fXpALasBSGHGdoW2CkYv6fdXyCqSiPOhVpV9BHbDiP70izlabkb
	 /8eYnF946SjCnd6j0byScpL3YSpG95hWL9KiP3QT5uXi4jxTmdceZr11ep9E93bAsUMGF
	 5SCRFxa2dGG4LN3+ApRqSI8QVFnFqj7Ur+PqPBJwtsN08Ua5TUaAZO5WCyvncAY+2C++3
	 u6tJ+XlgiRXgBIM7UD4N2gSi72PBMfTmDoJ9k4IW9WDDkf1UXOQQTqEFkjVLPAZ5ZDFFq
	 IH7G8MS+Y2WGX9gOLIXexec1q0wUlCjVNvdvSWI5Om6yMpz2sf5lZcTpijQ0IckfWYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fA/vhGip";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE5606A31A;
	Mon, 26 Oct 2026 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fA/vhGip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367B61F01825;
	Mon, 26 Oct 2026 10:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011471;
	bh=ZT3sIrPYsLf4bF7EjJfBOJes6yXJ8vu8pSt2SltAhV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fA/vhGipLIk1O8gOBsJtkkVVYQX814G2padlR/E3QpRBcK9Qi6+HvZ2ExCNOfCNwa
	 rwu46EGB1Ig+KgwWwFAMn3XSlehwoSFnKuXERVlXj/MT4cMi3ci5SHxxU1xSaZq5F0
	 JA0Un8J+PEVjd8yImOpT2z+oBDU0Xb58usskbKjW2GmBV/vQ7fOEHmyEU++MBHHBIc
	 qc9BcyIsbAHuACLSyGoxZaIZBwYVH+BNpEkIO02v5yPrxfepNl2gd5BKGOMypn3Qg4
	 Pipvea0+AzWp200ETgLLs/fltu0GJ/fJTJXimDKzvaxXG4JtEw7QNt4dOEigK2ChW/
	 8MaEOASm4t+Uw==
Date: Mon, 26 Oct 2026 10:44:25 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, Colin Cross <ccross@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/vma: write lock source VMA before duplicating it
 in __split_vma()
Message-ID: <at8u8H9dVRYLJI5u@gremlin>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
 <20261023-fix-vma-atomic-v1-2-8ff4fae1fc85@kernel.org>
 <20261023192627.yj5ltdj4fjzydblp@offworld>
 <24bb4c36-730c-4f04-9cfa-be096d4da9a2@kernel.org>
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
In-Reply-To: <24bb4c36-730c-4f04-9cfa-be096d4da9a2@kernel.org>

On Mon, Oct 26, 2026 at 11:42:40AM +0100, David Hildenbrand (Arm) wrote:
> > should just say "stabilize atomic VMA flags".
>
> You mean the s/stabilise/stabilize/ ?
>
> I guess that's just the (uncommon in the kernel) UK english variant Lorenzo
> tends do use.

King Charles dictates that this form be used ;)

--
Cheers, Lorenzo
