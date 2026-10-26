Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035586;
	b=xdMbxwyr7uACd7fWAvShbkINYYixrenBwHUS6oJk35JWsZSKi4WVB2j3bKtZgbftmvDE
	 J0O5R2Rm0DF5gKA54Q9C/xqsnMhu9+YvecrDUFuo6iOzKzctTzBxACG6xPylvhNL4j2+V
	 1g+3FnPtREOL4n4aH+zRR0UQ6AZ4IZWLH3tqVe25Hhb7n0PkPnx9DkwkN8+ToD3hF3cN6
	 5uahdnlCPBfkvON0c07rOyC039qAuV/lBQMeWUebLgLaJT0akjJjzcsE5HNLPF27cKRgI
	 9h2TXsQOCRF1ZwS0t2oBzlha8QsRe3qe9kjWI/cSFvAl56FljpB69wix2wvkq/bxDKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035586;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v0WoLkQVcDbSGumghdYohAdB7aedqeHVhzhgY1ziDNE=;
	b=WgrZNwBtQwWwdgAogVT1FFqi6KdesdUxYfWbSA9Re6RZCimzN0O7vnvu+tnicqeYZ2bL
	 O3lOEAziQgh6/IiVtOZsDzOVarYDP8NdVuf9iBj/CfqeHbPsslHJ3SjeInjJGHegZ593E
	 w4EeEg90Sg41D/fmHhBbJy+ao4SNwk9UKJz28+/d6n8tGwWr7Hj4ygjU+k5vgF95DK1mz
	 063GTeVkzEOr+F1GRa/TXCp6OKLiIAo6KZvsUWAeoiIU8hHACfdL2G3tqahto9URdhv11
	 J31BPq25q7Pbi/AxkLKku/iaurdR2kkHzumh/fOuDYKTHwSMPFKzXTpOUdhyBDNkWOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UJjjE+w/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98B606A321;
	Mon, 26 Oct 2026 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJjjE+w/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715BA1F031E0;
	Mon, 26 Oct 2026 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793035586;
	bh=v0WoLkQVcDbSGumghdYohAdB7aedqeHVhzhgY1ziDNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UJjjE+w/YXLWI0UQBaYCVSGw3pw3SwVACw6Xl+vENBzMgcxNnqssVXl0whwdZzcFb
	 aC6PVbgiG6rlNIXffQ7/CSshM+uJ8wofvwoA1WQbx2twWv05gNKRg4zbsOownetahZ
	 gFqHdVAHaa3wyS6p0m6KygE/nIb9evXkgph0RHfLnSfIOwZgiTL9LSQdNGAF+1RSMl
	 IFjgRMmUPEb15cci+VVrTv/2t4ClbdIC5xeM+YipLCAN52E/YyYnQnty8bueg8Kjk8
	 V9EiWb/e5kJwlanYEdX4xzdWyceuMjAb6jV89DNZrgaxizTDfn/4TY6Ut2Hu0slW30
	 6xFiw0AichPIA==
Date: Mon, 26 Oct 2026 17:26:20 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
Message-ID: <at-M5hORjFt6aur4@gremlin>
References: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
 <at8-42OwXk2z6-HB@gremlin>
 <CAJuCfpFaxo06yHdVKsEEmFf9qoOYS0DbMvUuAZEhNfDe7dcwJA@mail.gmail.com>
 <8c5a8fb7-233e-4433-af45-b67cb2528b60@kernel.org>
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
In-Reply-To: <8c5a8fb7-233e-4433-af45-b67cb2528b60@kernel.org>

On Mon, Oct 26, 2026 at 06:19:18PM +0100, David Hildenbrand (Arm) wrote:
> >> +       /*
> >> +        * No lock was held since the last call, so the iterator's cached range
> >> +        * may no longer be valid. Always restart by address.
> >> +        *
> >> +        * The vma_range_is_empty() checks below avoid unnecessary mmap_lock
> >> +        * fallbacks.
> >> +        */
> >> +       vma_iter_set(vmi, from_addr);
> >
> > This is clearly simpler but this unconditional vmi reset is not ideal.
>
> Yes, exactly how I ended up where we am right now.
>
> I pref my current fix as something to backport that avoids performance changes.
>
> If you two disagree, please take it over and drag it over the finishing line in
> a timely manner.
>
> I wasted enough of my weekend with this over-enginered piece of software. (had
> to change one word before sending, can you guess which :P )

No problem, will take over.

--
Cheers, Lorenzo
