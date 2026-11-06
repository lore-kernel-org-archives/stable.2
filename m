Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933985;
	b=Us7niUrVClN5Z4YIqGj56RjRJ1N5KWgUqiFvQ9CDlCceJNaWoSnsUvknkqCm+WUzPKn5
	 gtqy7TmuMoSenH9/F3fx1wyWhlf/dsKC1Tutl9GwK4pZBIO2EjmYieqNcaC6VqOiUJEgw
	 ZNBwA6elvhbHxAy40kfTvn4o6vGv3GVi4Gc5qzO0Bc0y4e0Kqh/QsI2DbpYbRSN72JKwO
	 sWWB+EmXaiHdprYcaZKmzafuHRrUvrJAgCYxeaezz3ys/cSuINGWKNarPiRqbxYW44gL6
	 P0qTedp+SwKiKCduxN43sfd+pCO2hZ74NPnN3QFGN6qxXSrYw/ppah6ust6981d76DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933985;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g0MaA95Bx3ZoEANP3GZek3B2SzCrodWB+6/VqV4dGcs=;
	b=VoBapTpJuWbgJFEN3fy7Ya2bzikWkgmB4K8CxafCSwm4L2MK1dBqTcqTzihyEhwPTftS
	 pW4KE6ClqtL1IBj7GsFeDkBtmFqTANc7zRk47g2JKbRlcsKXZIeAAdbiSwL+hkFpzbwse
	 qhx8cRMsaFVLztQMOK3JIjsnK/f+8NOf/DVP3K/giYyjx/2dNfQEoh2fvxJeYYjaDUe+W
	 cEtMWYnQRJG+AFsh3Xg9MhmYwxywzGxMtZuGZ2VwvTmAhQe0X1pOZx9hw+QiS24ICW535
	 9Ia/YvooFUnuaydTmOlhmmkzz1Eesvih8OmPY4EHVWcnB6M2QsC55wEPqCRkXspo/Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=zMv7TaMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119A606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=zMv7TaMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5281F008AB;
	Fri,  6 Nov 2026 02:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793933983;
	bh=g0MaA95Bx3ZoEANP3GZek3B2SzCrodWB+6/VqV4dGcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=zMv7TaMh+8CJiKiz3Jbclm1ei9kNfUkBmRzCfBVB6LdILr7EU2lvxKPKfCnMNTgBf
	 nfcA4A1uqXz6FO3f8sGRDFS62Vmu1W30tiaLLBCRPfgDFDZj407JOhFeLegCN2Axem
	 Q+UptajLNRQmUmpdda7AanFZeq5TNNrrJpLm+CJA=
Date: Thu, 5 Nov 2026 18:59:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, David Hildenbrand <david@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Sarthak Sharma <sarthak.sharma@arm.com>, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 0/5] mm/mremap: fix accounting on a partial move
Message-Id: <20261105185943.3d6f4b34fbdbba8599bc7360@linux-foundation.org>
In-Reply-To: <20261105-b4-mremap-pre-split-v3-0-f8789de76849@toxicpanda.com>
References: <20261105-b4-mremap-pre-split-v3-0-f8789de76849@toxicpanda.com>
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

On Thu, 05 Nov 2026 14:02:02 +0000 Josef Bacik <josef@toxicpanda.com> wrote:

> This fixes a hugetlb reservation leak and two Committed_AS bugs in mremap().

Indeed it does.

Please lmk whether LLM's runtime test plan was sufficiently complete:

: I reproduced all three accounting bugs before the series and verified
: that they are fixed with all five patches applied.
: 
: The new HugeTLB partial-move selftest left three reservations behind
: on the baseline and none on the patched kernel. First/last-page moves
: also leaked three reservations before the fix and none afterward.
: Whole-mapping moves and populated-mapping controls passed.
: 
: For the unmap-error cases, identical diagnostic hooks in both kernels
: failed the first source-VMA split, or allowed the first split and failed
: the second. With a four-page source and a one-page move, cleanup left
: four committed pages behind for accounted anonymous mappings and one
: for NORESERVE/shared mappings on the baseline. All patched cases
: returned to zero. I checked task-specific accounting deltas and verified
: that every surviving accounted source segment regained its account flag.
: No-failure controls also returned to zero; destination data was checked.
: 
: The updated mremap_test passed 25 cases, including both new old_size=0
: shared-duplication cases, plus three expected rejections for overlapping
: or misaligned requests. All eight mremap_dontunmap cases passed,
: including locked partial moves. No unexpected kernel, KASAN or lockdep
: diagnostics were found.
: 
: This used x86-64 KVM guests with GCC 13.3, KASAN and lockdep: 8 GiB RAM,
: four vCPUs arranged as one socket with four single-threaded cores and
: one virtual NUMA node. Both kernels contained the same temporary
: fault-injection/accounting instrumentation. Cleanup tests used munmap;
: process-exit cleanup was not separately tested.
: 
: Tested-by: Andrew Morton <akpm@linux-foundation.org>
