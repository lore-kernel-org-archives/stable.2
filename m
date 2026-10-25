Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896772;
	b=raujltc4tD7MHYLjRvqbyaUSR1+1Ec35KJvXDXzRNPTXKoGmhkYwIlsC1YcTOvSEBQ9R
	 z+E4DximgRAdWbtxa/7zjICb/ArfYQtkPNHJ7nMHAbeLSs4BF+W97VZYfhWgOg7Texw6L
	 uMMExfCrxldoYdpHX9iO/SVelqgq3kQTA+lRxFanEv6NYAFyX+Fc/8kdwfxY9xNTKjdK6
	 B9OhelKS293MJrsKOcQfbGh5MfMAZn3RmKk7u0G0v38XuweJhH+JmiJE5aJijzoWa7fGT
	 kFIkrlB0t0tby+tRwOJaEhwLjKxYsQoMFpVnebbzxQC/vR12DRL2pRn+5vin3hC3xQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896772;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=HLOt41l/QWC0fEiGeX8Tnz6uBnCfl8WR/5GPhpD68hE=;
	b=HcOqQvdNFvOitl9YkIs26EH1Nt2a1LLDwLq1K2MlkXHw5UsNMUtVkA2hNg8rsDH1GKAt
	 8T5eG5m3hFrsRLFwmBl+dqGGogqYuk+0MQSLTmitP89OG9NkaIGbfJ8jN1XoH7hXw1ufq
	 R40FrHU+lL+OSS1oXJOCT4d3C+aEFdctW5s0ko9cmh8OiE5UNfwnt8PIoJ3mtxRbhpZXs
	 JrH9+k7oGXM2xUGHtRYp3hAft/UlsUsN40q/pT/SDOhhMWilfxr9Or+00QE+kWQpaNOHr
	 dLqt8LSMaRD/O4/nbi05cKpJplXw8ii8rC6BivT09go5gCsuxI/faAxPrKoKQ3NM7kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nJdqkhhY;
	arc=none smtp.remote-ip=95.215.58.72
Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED141606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 02:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED141606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nJdqkhhY
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WwzTK24epbuB+saadzHwyBUTb+kgdJ1j3wLcauZFEws=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792896769; v=1; x=1793501569;
 b=nJdqkhhYTFn/ZQeoWgGRwLrLMLFp4HIs8zjT6EyPpjQWoirq0BF3GWtViugALgcabRWE1oMR
 rWG6qyAcmyxpU+87WU7GlGgN4E8RFknMjosmFA6fgadKocE/B8OZ4MOObFTb/0J7qB/fX8+WbRS
 VtIc4/Rjs/uJVC6BSLjYzx+A=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 8cc735b5c8cf76cd;
	Sun, 25 Oct 2026 02:52:48 +0000
X-Mizu-Trace-ID: 8cc735b5c8cf76cd
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v5] dax/bus: Fix Device DAX range alignment validation
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261024183853.6803ce81788636e94d8c16a4@linux-foundation.org>
Date: Sun, 25 Oct 2026 10:52:29 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Dan Williams <djbw@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5AFA3B1F-48C6-49FF-A6FF-7D71153671CF@linux.dev>
References: <20261024112555.2476001-1-songmuchun@bytedance.com>
 <20261024183853.6803ce81788636e94d8c16a4@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 25, 2026, at 09:38, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Sat, 24 Oct 2026 19:25:55 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> Only range sizes are currently validated against dev_dax->align. A
>> dynamic device can therefore select a large-page alignment and =
allocate a
>> range whose start is not naturally aligned.
>>=20
>> Sashiko found that memmap_init_zone_device() could then initialize =
the
>> struct pages with a large-page order for a physical range that is not
>> naturally aligned. A subsequent write to a userspace mapping then
>> triggered a kernel panic in testing.
>>=20
>> The automatic resize path can also split a size-aligned request =
across
>> arbitrary free gaps. When devices with different alignments fragment =
a
>> region, this can extend a range by less than the device alignment. A =
later
>> allocation then fails, leaving the failed resize partially applied.
>>=20
>> Initialize the device alignment before its first allocation. Validate =
both
>> the start and size of allocated and adjusted ranges. Use the same
>> aligned-gap iterator for free-space accounting and range allocation =
so the
>> pre-check and allocation path cannot diverge. Skip unusable gaps and
>> serialize size validation with alignment updates.
>>=20
>> Static Device DAX already has a pre-populated pgmap whose full range =
was
>> validated against memremap_compat_align(). Its usable data range may =
begin
>> after namespace metadata, so require only dev_dax->align for static
>> devices. Dynamic Device DAX builds its pgmap from the allocated =
ranges and
>> must continue to satisfy both alignments.
>=20
> Thanks.  This is now a must-have for 7.4.
>=20
> I suggest that the changelog mention that the bug becomes hittable =
once

Let me explain this issue in more detail. Without my patch set, the
problem was not hidden=E2=80=94it was simply shifted to the second =
stage.

DAX device usage is divided into two stages:
1) Device DAX initialization
2) When user space maps a Device DAX device.

Without my patch set, this problem would trigger a kernel panic during
stage 2). After applying my patch set, the problem is caught during the
first stage (with the current prerequisite that CONFIG_DEBUG_VM is
enabled; if it is not enabled, the problem still occurs in the second
stage).

Therefore, there is already a serious problem that will trigger a panic
when users use it.

> your series "mm: Unify device DAX and HugeTLB vmemmap population =
paths"
> exposes it.  That's=20
>=20
> 4b77739fe789 ("mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX").
>=20
> I intend to send this to Linus next week.
>=20
> Maybe also a Fixes: 4b77739fe789.  That series didn't create the bug,
> but this data provides notification to people who are backporting this
> series (unlikely) "hey, you need to add this fix as well".

Based on the above info, do you think it is necessary to include this
commit as a Fixes tag? My inclination is to exclude it, because the
issue is still there. It's just that it gets triggered earlier when the
debug kernel is enabled.

>=20
> Also
> Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Closes: https://lore.kernel.org/wlrkqqvg.ritesh.list@gmail.com

This is a similar issue to the one reported by Ritesh, but it was =
reported
by Sashiko.

Thanks,
Muchun

>=20
> I don't believe that Ritesh has tested this?  He wasn't cc'ed...


