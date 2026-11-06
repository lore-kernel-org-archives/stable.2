Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983739;
	b=QLUeUR4olNr+mFUDe/sU9K1z9Sk3b6EZZ9HQQFELj7ECORPZwxPgJWD2rrIJssjS/rHM
	 rCZ8Wq9mRXJ6jAoVi6xnenGiRlMFwyZWcv32AWOJOMSbQLFcDm4g8O3dVUoKzpcyYTNbP
	 yx6SErrBp138fd3QgHPgYbuNYEvNeUpJpT2wRGFk5KISZBJylUT8/G9K+1Do2ZXFD74u5
	 2uMvl4QqGL6tlBhV2HS3Fq4eQ5qTCQ6EwgCHDFTzBVCFDvLD5WU26p5WF55Bmncv1YG15
	 OXrKa1HRZE3/04qjULMpurx/tFgkyR/E3GIHEtbKMb2UHXT2gpEP5/lK2aS6iTonV5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983739;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-Id:In-Reply-To:
	 References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HqTUPu4uDFtmEky3eJGu8FbX8sNx+Or+hz+eWSfrOqw=;
	b=fQf5XI7BXh4b399YEzgZFep0eU1HkDJ90nmQjZLB1AissvxObj7FPhMMM2fmnTdh1Q/2
	 hxyhK9fnbJgTbb65NKjmxERBubsZg0qh3ikDrnNn3ovohO673crQzwxZ97uauUFTvW1ks
	 Qg/VH4PTkBP7BQPdpba4IfMukbEfhJMfsJXCahzCiJUhfUDIlD1KO5J+rZZS7y9oCtgyn
	 j96FpYYQ0jZpheIl5ZJ0DaQrbFIkGK8+CEYUYUbspkikmjv66AJwzVWBYALXPiYhCZ6W/
	 OC19TSQa19siD5JPf/QQyEwR5Hkqpe6Cv3F6tq5I/mTJsCTwgQNJL1rJiNjxFIa2w8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KrB138xA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC7606A326;
	Fri,  6 Nov 2026 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KrB138xA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAAA1F0089F;
	Fri,  6 Nov 2026 16:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793983738;
	bh=HqTUPu4uDFtmEky3eJGu8FbX8sNx+Or+hz+eWSfrOqw=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=KrB138xAbdqLx8TVda6AqfjjiVZ0NsgU1TRW1cY618TT61y16rSjHyRHAkKV03uqz
	 EuGNu32HEURaTyQCeheMZKE+ynBrS6XYkA6s95y02MrhkypV+S2pgdVQW34S+4eq/o
	 Pt7wGOjdZo8mi7Wok+w4eX/kTwtVv8PT19SVyadw=
Date: Fri, 6 Nov 2026 08:48:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau
 <kas@kernel.org>, Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex@shazbot.org>, kvm@vger.kernel.org, =?ISO-8859-1?Q?Lo=EFc?= Molinari
 <loic.molinari@collabora.com>, Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 0/4] mm/huge_memory: copy PMDs at fork like the PTE
 path does
Message-Id: <20261106084856.4b254c973694345ee58a9b63@linux-foundation.org>
In-Reply-To: <20261105211819.2a6a349b2edc077784ca52f9@linux-foundation.org>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
	<20261105211819.2a6a349b2edc077784ca52f9@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 21:18:19 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> I'm attempting to runtime test this on local LLM-driven live kernel
> test setup, but it keeps on kicking me out and calling me a
> cybercriminal.  Sigh.  Giving up

Success.

tl;dr: all seems good.  The expected performance gains and losses were
observed.  Can't performance-test powerpc because the unpatched kernels
crashed due to the bug the series fixes.

: I tested the four v5 patches and the selftest fix on matched x86-64
: kernels. Both shmem fork tests passed with the series and skipped on
: the pre-series kernel, as expected. They checked inherited PMDs,
: private and shared writes, parent mappings and ShmemPmdMapped after
: child exit.
: 
: The special-PMD race was reproduced with a virtual QXL device mapped
: through VFIO. Revocation before fork produced SIGBUS on both kernels.
: When revocation completed during a controlled pause in fork, the child
: accessed the revoked mapping before the series and received SIGBUS with
: the series. Both pauses were reached without timing out. No BUG,
: WARNING, KASAN report or oops appeared in these x86-64 runs.
: 
: I also built matched PowerPC kernels and tested a POWER9/pseries
: hash-MMU guest under software emulation: two vCPUs, 2 GiB RAM, 64 KiB
: base pages and 16 MiB PMDs. A trace confirmed order-8 VFIO PMD
: insertion from a 64 MiB virtual PCI shared-memory BAR. On the
: pre-series kernel, the child's first access after fork caused a NULL
: pointer dereference in __hash_page_thp() and a soft lockup; that guest
: required a bounded timeout. With the series, the child read and exited
: normally. Revocation before fork gave the child SIGBUS with the series.
: This is one comparison, not a PowerPC stress test.
: 
: I measured fork costs with a 512 MiB private shmem mapping, including
: 510 MiB actually mapped with PMDs. Median times from 100 forks per
: condition on each x86-64 kernel, following five warmups:
: 
:                          Before    With series
:   fork only                49 us       63 us
:   fork through child exit,
:     no child reads        132 us      202 us
:   fork through child exit,
:     one read per PMD      637 us      326 us
: 
: This workload pays more at fork and takes about half as long end-to-end
: when the child reads every PMD. These are single-boot measurements, not
: a broader performance characterization. The timing kernels had KASAN,
: lockdep and DEBUG_VM disabled; the correctness kernels had them enabled.
: The x86-64 KVM guests had 8 GiB, four vCPUs (one virtual socket, four
: single-threaded virtual cores) and one virtual NUMA node. The host has
: 64 physical cores and 128 SMT threads on one physical NUMA node;
: individual vCPUs were not pinned.
: 
: I attempted a PowerPC VFIO fork-only timing comparison. The pre-series
: kernel faulted on the first child exit, even without a child read, and
: the guest was stopped after a 90-second timeout. The patched kernel
: completed 100 fork/exit operations, averaging 2.77 ms under software
: emulation with tracing enabled. There is no matched PowerPC performance
: comparison.
: 
: Tested-by: Andrew Morton <akpm@linux-foundation.org>

