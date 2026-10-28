Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221466;
	b=W3x6307wpM52xo28NQQPpzni0mfJa6tHpDLuKooXLUxr5objUemX2I9n4jkDBjNZ5vYI
	 5rv+bR8rRQBidu3pk3SEw70DFW2R9Cg78ubqf6lKVvxnHzgYow44VlUmNUIIQunV04F2z
	 p8XM5xMPTPDeWdFI2Qo9sQYcSi4vVw1QPMBPO0/FGgKlCIuz/zOTqi+IJAMtJdgunFtOG
	 pEhvpxgiFwXXvXGGTqg9A+Mr3hLPE7C5hv3py7j2Et4YCbbQ8OvPgbkIfPOcLUznLKjul
	 32eC6zDxTVoE+mlpgPJrH5tnFf26dANB8qb4hCqxn/IwDa+8tq9ZnE6Me0o+Nwn52Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221466;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nQlwCq7l7ZSqCYPBLdBGqEjchNlsUXYVT1C1dmxvQG4=;
	b=TGBD8hsmKjP6Klw8DSHyf2uao3hMrUfe8ZQ+F7EfEXwob5je5Qbi/SRvM2eksFmrVAv3
	 k1p8PKsvghzqpilo7sCK536Z0odmxK5yzCQQDZI4pdACCan6deGi7ubb4sWxCD3hfzeaS
	 rpzdwjn9dEXkBhdGTlSF+Ye8W89WA7KrDwnjea0TTN6kY7+ujgOo9J6Tryy99XXsAIMvg
	 Y4xLRsD73svPPOgDZocwyWcTrckQWrn9t5iE1ge5ftMh/ySDN5enFvR5wZfH8ofKJCvWe
	 BLSsnRfWZsPh3eRKOcWENptCubPPxlxP1vHLzClzvsUwQ0VMZJYEiD9bhMX85c1TiOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=tgKSYjRf;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED59606A31A;
	Wed, 28 Oct 2026 21:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=tgKSYjRf
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 48CFC14C2D6;
	Wed, 28 Oct 2026 22:04:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793221456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQlwCq7l7ZSqCYPBLdBGqEjchNlsUXYVT1C1dmxvQG4=;
	b=tgKSYjRf89HgLOvPe6URrKmUypjyhwG5+lzp97At6k2jZHRIA4M7LUQfGXsHsKuK6s1hMb
	rkEmV7y6BfIg/pVvaVXxAkOjMtck/6CBFadxcMUwODqlPUpdDMTN6wALVWssSm+zc5Ijbb
	nf9Fo8hfcok7cHA8DfZzCHWB5Xkok1Z7+jdfb3mXZTtaYVvGAdTAnMy/3YdCOKE0q45CHt
	vOV5np0gCPxFNtzg16zWGNeRdPS7VA+UpiDvtXjWANC0mhfNJscfFyHoecfUfHOh7pT/sN
	t4oH9/sWchDWhNF6JXtuxX3D7mU3U1P0SlMAl+rUHaL5CYoxxsKDfazcyFcYlA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0620b481;
	Wed, 28 Oct 2026 21:04:11 +0000 (UTC)
Date: Thu, 29 Oct 2026 06:03:56 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] 9p/xen: validate the response size from the backend
Message-ID: <auJjPAJxzvz1uBvS@codewreck.org>
References: <20261005125640.274054-1-yhlee@isslab.korea.ac.kr>
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
In-Reply-To: <20261005125640.274054-1-yhlee@isslab.korea.ac.kr>

Yehyeong Lee wrote on Mon, Oct 05, 2026 at 09:56:38PM +0900:
> p9_xen_response() takes the length of an incoming response from the ring
> -- the first field of the 9p header, which the Xen transport reuses as
> its framing header -- and uses it to advance the consumer index, but
> never checks that it is at least the header size or no larger than the
> number of bytes the backend has actually produced.
> 
> A malicious or buggy backend can post a response whose size is smaller
> than the header (for example 0). The consumer index then never advances,
> so the response work re-reads the same ring contents instead of making
> progress. In testing this raced with the teardown that the malformed
> reply triggers and dereferenced a freed p9_client:
> 
>   9pfs 9pfs-0: Wrong req tag=ffff
>   BUG: kernel NULL pointer dereference, address: 0000000000000060
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.2.0-rc5 #6 PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>   Workqueue: events p9_xen_response
>   RIP: 0010:idr_find+0x4/0x10
>   RSP: 0018:ffffbf5d80063de8 EFLAGS: 00010202
>   RAX: 0000000000000001 RBX: ffffa229c21195a0 RCX: ffffa229c2400000
>   RDX: ffffa229c11c2200 RSI: 000000000000ffff RDI: 0000000000000050
>   RBP: 000000000000ffff R08: 3fffffffffffdfff R09: ffffffffffffffff
>   R10: 3fffffffffffdfff R11: ffffffff87a60e80 R12: 0000000000000050
>   R13: 0000000000000000 R14: 000000000000ffff R15: 0000000000100000
>   FS:  0000000000000000(0000) GS:ffffa22a7661c000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000060 CR3: 000000003ac34002 CR4: 0000000000770ef0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    p9_tag_lookup+0x2b/0x90
>    p9_xen_response+0x17c/0x2e0
>    process_one_work+0x16a/0x3a0
>    worker_thread+0x172/0x2e0
>    kthread+0xdd/0x110
>    ret_from_fork+0x18b/0x240
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   Modules linked in:
>   CR2: 0000000000000060
>   ---[ end trace 0000000000000000 ]---
> 
> Reject a response whose size is outside [sizeof(header), queued] before
> using it, matching the validation the backend already applies to
> incoming requests.
> 
> Fixes: f66c72bea129 ("xen/9pfs: receive responses")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

Thanks, picked up

-- 
Dominique Martinet | Asmadeus
