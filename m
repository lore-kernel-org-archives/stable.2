Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090084;
	b=onj051unyZFvLf0pPoTl+acy0vfRPf/l5hIeGCFuJjWTBvMt/D9S+kUQOJ1UowVMmpUQ
	 WnDV+b3AylFY7uVyvlIDMzQyCuM3yWNBc8UDEyEHv0ucehunYrOkGAkIClNWJ+H2JjZpA
	 6bDv7jRlJk6KAlpuUxXdFZLKYSTgQ4/C/TgM+jhNaAkRd0eQj5ew5FeFkFXpxq2TiDQGn
	 y3LCm+jqt889OEbdHgrS6RkGlBVe8h7h8fvhVW++Hspsl4OdlRKVIoUR/57kRBkqHfPJj
	 RaeU+yQ4kB0v2WFTbP1IYBSYiCJ0Vpgr9ocvN8kFiO5+Z9cdNJVdaC2wWOraplSNQ8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090084;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sLWwjFGLdeBcwQnsfAwPrniEyWPhxDR91tX0J66L3So=;
	b=NogKooNCBf4ay2VP+PwemgCKBW+WPzznXKufxCx4hkwAziEfpBTTONAbvB3gRAYPMNKQ
	 5wCwZxKpuwdQYTkKANjFVNBrn+6rPwe/5m7u2M+AroXPF6pcXfZ4rKYlDkCjJsw5r0vkb
	 WMIwxu32VmEx5UsHr5vQF2ctWZzdxUtILANMJIvDfEbtZP+8vVDEiEUXqHkGeIg5ItpNb
	 znqeDPxsJYzj25YKGfA5H+P9VstLySLUw3lx9I9hxT7RgIU8VQa7KU7N6FdWGrj4auNH3
	 GKbgKFR6XOeGZEMJ+55mJV8QFPPR6A9hS9wM+d3yIKziyIWRkWIE1r0bXy6sltV2kCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWuW0cKX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285C606A31E;
	Tue, 27 Oct 2026 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWuW0cKX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E991F031E0;
	Tue, 27 Oct 2026 08:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793090083;
	bh=sLWwjFGLdeBcwQnsfAwPrniEyWPhxDR91tX0J66L3So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iWuW0cKXZmOQUEKA0DdsDmfISDp1HM6uNFA+OrpXEcF1EfYioInZMwtCGOdIF6qDm
	 2ZJ7hmlvVwY29S+AV1kR2VrjT+NwB2ZbC1AGDlkpP2Hu/2XGjUub9o0KZuUZDz5VN4
	 bOte2srwXvvDRkGWNqVEe92HB+0tNldbI+P4GIJuv4VQMS0wSNfDwWXFal2dIx1Orl
	 x0U8n1DndRrHYe5G6CxVSQBViEGL8i3o1uTW+8MPPqwsNJuV9WICe+0BuaGqEMXpZg
	 kfBddp5j6xO6B/b+7gSc8oOeq7qp1H1svOR4/Jz18QEn9IZjEbWW07ds8YSYkIyOJf
	 ixT5ifEbW3KDg==
Date: Tue, 27 Oct 2026 08:34:36 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, SJ Park <sj@kernel.org>, 
	Kees Cook <kees@kernel.org>, Colin Cross <ccross@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/4] mm: avoid losing atomic VMA flags
Message-ID: <auBh08P6GPQEHPCh@gremlin>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
 <179306587687.1925990.13855179558376532702.b4-reply@b4>
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
In-Reply-To: <179306587687.1925990.13855179558376532702.b4-reply@b4>

On Mon, Oct 26, 2026 at 09:51:16PM -0400, Gregory Price (Meta) wrote:
> You too get to be the unwilling participant in my schlopptesting
> experiment - but the good news is there's no issues and you win
> tags and free self/unit tests.

Uh oh...

>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Thanks :)

>
> Might be worth taking the VMA unit test below.
> Selftests... maybe the non-race uffd one.

Lazy-lorenzo, but could you submit your test schloppen as a 2 patch series? I am
behind on test-writing given the surge of fixes...

Thanks!

--
Cheers, Lorenzo
