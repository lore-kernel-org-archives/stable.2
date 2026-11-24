Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535890;
	b=QA2EpJ80AB2IPRvLOFkn8FprVPo/PTxO4pRwbfZY1XWsLlcjnp3H4GJYhUGuhsiKvOlH
	 LVyDTr/svIY/WAdIYaF9TWL5NtBAwQCc9jl6GgFCTx4LoFfZnoVnq8lc2iJ7OUd3Le0ad
	 VQGpONBl3o+z638K4DV+48n8EhgIHWEvkqTUodlXsXTSEB61Q9pJ2syr0Pbr+JQbydTAx
	 qqGNxg1ztHFyI+QeCw1BzpA4YJlT3GyV3BwCLWMacAUZuvQcdeovIrWLL2NlIFSuwynDh
	 8Q7jJhjMdt4uiOyNhZYgFtIwnjcYSkF4xTQ/2caQoHImI18B41SUbJoGJ4U0DeGINLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535890;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pIDEOjbq7+ZKjdjmkL/WuaSrdrNA5P329n5oCOdc1mI=;
	b=wM5DGx1qzCfjL8pix9YUGl3YqCwwBGuXijyOAFSQaGvlyhjdTztP1a3CIA2XhvV5PgJj
	 AeNdXippye5hBjZEZANd9dUVFCxZCMdgyrxV96e0L71PJVMJZtRARbVU2e10DU6MTssvC
	 ek/0zi+RdIhh9J/2qljQRTolWSXVwxCf9kbRED1mHgreWjbzh94RXBwvTECZCDZ0KYP8U
	 4+vG8HN7VqRQZ5KyBoyZUQFcrsnqU2qXCgiEd6NaKNJKX7g0KRPToTOnlPT+c9WLh17Gy
	 f7xXWuu6DAMQDaS/eSZ5V2pwyfxqwzJ7TPspyv5EGSDhwWrP7DQnhn2JUXktE3pJuyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzV0GS8z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F392606A31E;
	Tue, 24 Nov 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzV0GS8z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68651F000D0;
	Tue, 24 Nov 2026 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535889;
	bh=pIDEOjbq7+ZKjdjmkL/WuaSrdrNA5P329n5oCOdc1mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WzV0GS8zHavb1OFv0CO1J+MIVGhMkE8wteCr9YvLcQ9aNqWJv8gqMkrMMPRSKkymt
	 BEkdel8+bZ8C3ox0N6XRuftLsrJF/RuPn9hdn6iRTeemIUKiSzp293OrBxf1TjiN9g
	 rWx2ZkO1flwawt/+BdqA0vsQeuUyIs8R/mzMjr2uIEMBofdv2mZXAGaErHrZVrku0G
	 6QV6jjJ1iYqHdqV6VUUF7OA/cAEmRb0W38AhpynJbExx3tVdVmK+g9BhloPm/ABYYW
	 0w+9rsA2vIlSz2/CJ9ie0OPwJEk2Z5wpOO+JSPiUbTrTwK1vBoKymKPjPrTn/qHuEn
	 c9xRac28REvvA==
Date: Tue, 24 Nov 2026 15:58:00 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
Message-ID: <awWz3nc_b8x3mIXq@gremlin>
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
 <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
 <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
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
In-Reply-To: <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>

On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrote:
> Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
> that RCU unlocking move you don't need other_mm copy and the comment
> that comes with it. VMA won't be freed until RCU lock is dropped.

Yeah but they can be reassigned? They won't be _freed_ until a grace period but
they can go back to the slab and then allocated elsewhere  right?

--
Cheers, Lorenzo
