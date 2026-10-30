Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329414;
	b=DoopSufkOQeW/wKS/VEoY5tfuRdG3Oip4KzG5mSeKyojBovw3phU340Ykhz93gdpf241
	 rO0epUp2tbKS7gsWJEv9e2BFzIkzr1Ef6sMGRCOQbXj0ZIakMV05RVrB5kpb9hTvYPybV
	 /Prh8o9mR4CiUIomamtPSz3RydpQKMgCw4eGQEvo8AKPhAJp/JISHEIAxxepyXmDc8HyG
	 pH/40IThiwH5DrEdmNllV28pB+fnL6g0DfB34nlt5E502ICLbvBaL7FhOvXUWpxa3UNZj
	 CQ8fmO5P3yAyqn5likD1Nl8LyEdVzquWM/z/Q08ESN18ZbACdYE4Ol6Z0UVOlMWmXRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329414;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=P1HTdK9Us/nXxv6524NGuZeaCWy7CFdEOV2AIIWt1JQ=;
	b=KNA8EMGy3gPg3pZxYryRX08+3JghUMptCm1WAFBCmT3JO9+430OPwXaYRUwVR6VcIswv
	 wjJmGBXCuU9JxmRDRQRqROfcEbgsE54KB1bJxvWMfH4+NktCmyRg5WMy5++bc6Mwd0PaH
	 yfpxa6+jMXs9WGs99ZhNmrR7qrIHK/Ikf58mo2ad9ILFuKT9SelU+V7hDmjXOqjeL6hXh
	 VsG5vj7HZN106g/BwaCg8zwF9TU3zSS5r5L28MZXDDxmbMAuLueIx3Awpkv19BIHC0T3q
	 9WqhTlK6tO3LP1NxHNTLWvpRHS9RfLDdC/dotsppdzbxPALL73b+ig9ONQY6XT7xD4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KKaSdtvp;
	arc=none smtp.remote-ip=95.215.58.196
Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D8606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 357D8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KKaSdtvp
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A7GiL3udSSdyFKnyh+0Vow6D9krgem3lJz6Fq4u8pT4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793329411; v=1; x=1793934211;
 b=KKaSdtvpu7txiAPoaxO8Yi6oAg91UieXpbfe9qIH3UNe/A6K+26PUE7c87i/lLbsBJfJcwDy
 HnXgdIK9fg6F+VRmcJTj7SAJUXDJfeOGWvmjFSXMhkmUpcqbaQFxIPp4jFyCXa5y/2/JK3WWnBO
 6f5UQ7hbWl/4DFYCEZ9Mr+n4=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 70512d1ee8cb6ea0;
	Fri, 30 Oct 2026 03:03:31 +0000
X-Mizu-Trace-ID: 70512d1ee8cb6ea0
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages
 with PMDs
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <h5i4wlx5.ritesh.list@gmail.com>
Date: Fri, 30 Oct 2026 11:03:08 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Pavithra <pavrampu@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <20FE1232-A48B-4F72-8F18-89EFF70EE0FE@linux.dev>
References: <20261029063601.1961415-1-songmuchun@bytedance.com>
 <h5i4wlx5.ritesh.list@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 23:45, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>=20
> Muchun Song <songmuchun@bytedance.com> writes:
>=20
> Thanks Muchun,
>=20
>> PowerPC radix vmemmap population can reuse an existing PMD mapping =
while
>> populating a device DAX range whose section is marked as HVO-enabled. =
The
>> reused mapping is an ordinary vmemmap mapping: the redundant tail =
struct
>> pages are not remapped to the shared tail page.
>>=20
>> Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
>> initialization treat the range as optimized and initialize only the =
struct
>> pages that would be backed by a real HVO mapping. The remaining tail =
struct
>> pages can then be left uninitialized even though they are still used =
as
>> metadata for the device DAX compound page.
>>=20
>> This first triggers a zone mismatch warning in __init_single_page(), =
then
>> faults while initializing the pageblock flags:
>>=20
>>  WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>>  Call Trace:
>>    memmap_init_zone_device+0x164/0x430
>>    memremap_pages+0x43c/0x93c
>>    devm_memremap_pages+0x3c/0xa4
>>    dev_dax_probe+0x264/0x3d0
>>    dax_bus_probe+0x140/0x1c8
>>=20
>>  BUG: Kernel NULL pointer dereference on read at 0x00001400
>>    __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>>    memmap_init_zone_device+0x358/0x430
>>=20
>> On kernels without these initialization-time diagnostics, the
>> uninitialized metadata remains latent. When userspace later maps and
>> accesses the affected device DAX range, the kernel operates on those =
struct
>> pages and panics at that point instead of during device =
initialization.
>>=20
>> The Fixes target predates the section-based vmemmap optimization
>> infrastructure, so older kernels do not have section state that can =
be
>> marked non-HVO. Backports to such kernels need to handle the =
PMD-reuse case
>> in powerpc radix code directly, for example by initializing the tail =
struct
>> pages that core ZONE_DEVICE initialization would otherwise skip.
>>=20
>=20
> Actually that would be totally new code right? It won't be a straight
> forward backport, correct? ...=20

Right. Because it's impossible to backport the whole section-based =
vmemmap
optimization infrastructure (48 commits).

>=20
>> Mark the section as non-HVO when reusing an existing PMD mapping, so =
the
>> section's HVO state matches the actual vmemmap layout and all =
required
>> struct pages are initialized.
>>=20
>> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap =
optimization for radix")
>> Cc: stable@vger.kernel.org
>=20
> ... then should we mark Cc: stable here with the above mentioned fixes
> tag? Because this patch cannot be backported as is to older kernels -
> for the reasons you mentioned above.

The comment following the trailer is used to guide stable maintainers to
backport proper prerequisite commits. It's hard to do that. So I choose =
to
mention the alternative in the commit message. But with the help of LLM,
I found the alternative is also not the right solution. The reason is as =
below.

That pmd_leaf() path only creates or reuses the vmemmap mapping. After =
it
returns, sparse_add_section() calls page_init_poison() on the whole =
memmap,
which overwrites any page state initialized there.

Therefore, older kernels must pass the PMD-leaf information to
memmap_init_zone_device() and let it initialize all real tail struct
page entries. Initializing them immediately in the PowerPC pmd_leaf()
branch would be too early.

Another solution is making vmemmap_can_optimize() range-aware by passing
the vmemmap start and end addresses.

On PowerPC, reject the optimization when any part of the range is =
already
covered by a PMD leaf. This ensures that an existing PMD mapping is =
reused
normally and that all real tail struct page entries are initialized =
later
by the core code.

Maybe it should be a separate patch for old kernels? Thoughts?

>=20
>> Reported-by: Pavithra <pavrampu@linux.ibm.com>
>> Closes: =
https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070=
429.git.ritesh.list@gmail.com
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>> arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>=20
>=20
> I think, this patch should go via mm tree, due to all the dependencies
> coming from there, right?

Better. I hope Andrew will pick it up once I send a v2 version with more
proper commit message changed.

Thanks.

>=20
> -ritesh


