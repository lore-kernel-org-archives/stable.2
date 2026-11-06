Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935391;
	b=zBTfdTmaTra/VT9Y3gLZGvasnsV6imW1i94dBFt0L2qBus999wPhhWIbxgCRFV4UG+K8
	 eI81v2yH8KBXpl+W2Xqm9uoRr+1cbN9gn2ZMtHzbZEUq9dlqLD9PcKfmI2FWhr1Mf6ho1
	 gZm8pAOLzOg3p7Tdo+HRk5vpEGWjyW9KLkZcWw/3LnfVtFi76/ULveHT2nShC6tbpva/5
	 DbvHnJsT7mPAIvMrhECb8qHRjvoYq3w/QQH0d7wM/uNRr34iPGXzHtTTOBNivz1SRRY6f
	 669PiZGc6RFxTVBxZ9dHzxkCa+0/4vEfZCqvS+Wi2p4ZwRIc2CfDSwzvOb6aPeOVGdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935391;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=emPbxkg0/5QWmcFNHB+2nCw1B2TwiWmUMmFbNjnQBT4=;
	b=nycIQrzSMNjGibIhYCwQNKtF+u8xdDyjwuDoT1Se6kk7UAIg05+4C8za+HCZX/8zinmP
	 Qt9pEUciKMbST4fYpq1ZwbbHrVVEu9xrNsljZZPNX9IvDYV6L9itFlLHPwLN/TVrZ7HYK
	 l8FO//1rjwenJZB8nY6NW1bxsFDdXE+62uJXaQT/IoL3dMN/LqyBOxEEUBroE5Ct8D9Ft
	 exfv4b4rIKB5sk+8oY445eEG64vQq6qyRQEnXitegYBkm6f2NOrRusWEv53q5YSkE6ANh
	 nmVmk8A3oKWrPBA5/0b175wmuKoMhly7HZxXUy9k6qBUrLxNbNry8ELz3Ho1W52ZXmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XOoYdaIE;
	arc=none smtp.remote-ip=95.215.58.221
Received: from mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B4606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655B4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XOoYdaIE
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1iTUSdXTCVsjLijjuHlyn2Zs0ncBSwD81Jn4H+YS6Ek=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793935387; v=1; x=1794540187;
 b=XOoYdaIEO1PLcALd/MslMlMLSoiXfEn/R03bC1W01fF6dOSyhsIhLi5+VnlHEhz5jDJ5wRZA
 TqUx77Ia0un0XKqmsjcvn0wIJFk6AbjbNbPAWP1MUHLArebQg+IZp+JjDFE0Bi9sNF9nOoxDuzi
 bjUgGZ24dTno5+8HURzNynMk=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 01a3aaa1f1fe2691;
	Fri, 06 Nov 2026 03:23:07 +0000
X-Mizu-Trace-ID: 01a3aaa1f1fe2691
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] dax/pmem: fix unaligned compound devmap initialization
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <au0KLseDt4S6b1ME@aschofie-mobl2.lan>
Date: Fri, 6 Nov 2026 11:22:49 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 stable@vger.kernel.org,
 nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <75814BF9-8CC1-44BC-AB72-94EC5985A39D@linux.dev>
References: <20261016054914.2601510-1-songmuchun@bytedance.com>
 <au0KLseDt4S6b1ME@aschofie-mobl2.lan>
To: Alison Schofield <alison.schofield@intel.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 6, 2026, at 06:58, Alison Schofield =
<alison.schofield@intel.com> wrote:
>=20
> On Fri, Oct 16, 2026 at 01:49:14PM +0800, Muchun Song wrote:
>> Static pmem Device DAX namespaces reserve space for namespace =
metadata
>> before the user-visible data range, and may also include padding =
needed
>> to satisfy the Device DAX alignment. __dax_pmem_probe() adjusts the
>> dax_region range to start at the data range, but the dev_pagemap =
range
>> still starts at the beginning of the namespace.
>>=20
>> That is not valid for compound devmap mappings whose memmap is stored =
in
>> system RAM. Compound page initialization requires the start PFN to be
>> naturally aligned to the compound page size, because the head and =
tail
>> struct pages are initialized according to that geometry. If the pgmap
>> starts before the aligned data range, memmap_init_zone_device() can =
build
>> compound page metadata from an unaligned PFN.
>>=20
>> The resulting struct page layout is inconsistent with the Device DAX
>> mapping. A later mmap fault can then resolve the user-visible PFN =
through
>> invalid compound page metadata and hit a kernel panic while inserting =
the
>> DAX folio.
>>=20
>> Fix this by advancing the pgmap start to the aligned Device DAX data
>> range for non-altmap compound mappings. Leave base-page namespaces
>> unchanged, and leave the altmap path unchanged because
>> memmap_init_zone_device() already skips the altmap reservation =
itself.
>>=20
>> Fixes: 14606001efb4 ("device-dax: compound devmap support")
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Closes: https://lore.kernel.org/r/wlrkqqvg.ritesh.list@gmail.com
>> Assisted-by: LLM
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> drivers/dax/pmem.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>=20
>> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
>> index bee93066a849..d3a9b85107b0 100644
>> --- a/drivers/dax/pmem.c
>> +++ b/drivers/dax/pmem.c
>> @@ -51,6 +51,13 @@ static struct dev_dax *__dax_pmem_probe(struct =
device *dev)
>> 	/* adjust the dax_region range to the start of data */
>> 	range =3D pgmap.range;
>> 	range.start +=3D offset;
>> +	/*
>> +	 * When the memmap is stored in RAM, exclude metadata and =
alignment
>> +	 * padding from compound page initialization.  Otherwise, the =
pgmap
>> +	 * may start before the naturally aligned Device DAX data range.
>> +	 */
>> +	if (!pgmap_altmap(&pgmap) && le32_to_cpu(pfn_sb->align) > =
PAGE_SIZE)
>> +	pgmap.range.start =3D range.start;
>=20
>=20
> Hi Muchun,

Hi,

>=20
> Does moving the start here lose vmemmap savings when the old start
> was already aligned? ie. on x86_64 with -M mem and 2M alignment, a
> namespace starting on a 128M section boundary has its data at +2M. The
> first section then becomes a partial add, which 2ef77f4a7d5a
> ("mm/sparse-vmemmap: set compound page order for device DAX") doesn't
> optimize. Would that cost about 1.7 MiB of extra vmemmap?
>=20
> Can you round the original pgmap start up to the alignment to avoid
> that loss, and still fix the crash?

Yes, you are right. Rounding up the original pgmap start still fixes
the crash without losing the vmemmap savings. I'll use the following
change for v2.

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index d3a9b85107b0..d54d23f1cc58 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -52,12 +52,11 @@ static struct dev_dax *__dax_pmem_probe(struct =
device *dev)
        range =3D pgmap.range;
        range.start +=3D offset;
        /*
-        * When the memmap is stored in RAM, exclude metadata and =
alignment
-        * padding from compound page initialization.  Otherwise, the =
pgmap
-        * may start before the naturally aligned Device DAX data range.
+        * When the memmap is stored in RAM, compound page =
initialization
+        * must start at a naturally aligned address.
         */
-       if (!pgmap_altmap(&pgmap) && le32_to_cpu(pfn_sb->align) > =
PAGE_SIZE)
-               pgmap.range.start =3D range.start;
+       if (!pgmap_altmap(&pgmap))
+               pgmap.range.start =3D ALIGN(pgmap.range.start, =
nd_pfn->align);
        dax_region =3D alloc_dax_region(dev, region_id, &range,
                        nd_region->target_node, =
le32_to_cpu(pfn_sb->align),
                        IORESOURCE_DAX_STATIC);

Thanks,
Muchun

>=20
> -- Alison
>=20
>=20
>=20
>> 	dax_region =3D alloc_dax_region(dev, region_id, &range,
>> 			nd_region->target_node, =
le32_to_cpu(pfn_sb->align),
>> 			IORESOURCE_DAX_STATIC);
>>=20
>> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
>> --=20
>> 2.54.0


