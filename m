Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774109;
	b=knMV/F9QZ9oirHiBuug+h0zvUV0DHROwFlKt1jvAf2j88cQfp/wosTW9nXFuf0E1+f8Q
	 vifoqgtbY+RQcdZ8AyH/4aexR/vnfcEdaZddhg/Ufwt2qdV6URI3vjVgQxSLBJINP3XNh
	 SszN/G5RqgJYmHiVJPR7GJo+zRbsJLcBHBZDplrgYjGY0kXttm7U8t7yJd4XrBcysO1DE
	 COGeSGirgoe5/nIG782/MGgKffSmd5ff6Rw3ANfCuhzPPunakjE7HeqApLDlyH1agGfMd
	 p5x4oJe+eFFMPu7kN6Yye3yQJN6UyobJVFC/LPSlyei+Lj86GANCG10voiQyq7Mr9Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774109;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=u0PsfBl18AWyK4iQSGjFIhiNJ5cYD9CJo88yPJo17Sw=;
	b=0z31+o2WyVz9ZkNqfGZSkSZC0nrHR/aUO8k5kevLbOKK7RU9IPBqPg54XyhdGHhHBJrU
	 3gNxHysrlBrcgcXGLyg95OCW/t8cpNbQfNfZ1UJxtyVl4nkPcpokMgr+rAfthyQnXqnqV
	 OZWlNUX/J4UWjsVhxEq4uH2Hh9N17BE405UrLYBFmIWVPKgv7y4PWzSCzqHhzf4NZ9fJT
	 bvgA2c1WxLRckeY/BHInKcSCVSlIzFeDE+ycb3Fdgnh9flnzq5T8zC3ZMI9v0OesAeHBd
	 HUK5/Loe6VUUpF7opQQJxBlY7eRM5INlf09tBGgyuw3hM+RnHLEa5OaE3Oh32Vb0oXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=XvrNMgnd;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F2606A32C;
	Sun, 15 Nov 2026 20:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844F2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=XvrNMgnd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=u0PsfBl18AWyK4iQSGjFIhiNJ5cYD9CJo88yPJo17Sw=; b=XvrNMgndHaNpZ6nydqFHt5ym3I
	JoO6LfNPmqvNLCvCUtifefbs196ApVghVh+ssI8jAiqOxccoeJTLFfV7Eythu/RswNAKG3qs92MRZ
	TqZh3qJ5g16usg7xcFH2pdIGn15MMB1kK2fGyE3Ik4Se/WXqpHCYfR65QrJmTCAhIDbj4dg9tDUM1
	0Gu2sN9xI87vKJJVwCXn0K5OCJShN/bXqKgL3lF7xcijbGCDAbRvcO1nF57pzjSjQQZyD0Xdw0xvX
	Zom1Ye3XPrS64aYtqiSq0py8QIMNrvXzV+usP4aBPkzll3p49qfPkBMXb0GV2kDxr86UHqUKXyBRR
	XWxyxKog==;
Received: from [::1] (port=43856 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xSgjN-00000002LVQ-29rC;
	Sun, 15 Nov 2026 21:21:41 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 15 Nov 2026 21:21:39 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pedro Falcato
 <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Zi Yan
 <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>, Nico Pache
 <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau
 <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: reject shmem collapse ranges beyond i_size
In-Reply-To: <795b8d8a-4f6f-451f-9274-ccb8380e03dd@linux.alibaba.com>
References: <20261112142335.2749597-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <avYBFPhB46XWAG4A@pedro-suse.tail5790ac.ts.net>
 <20261112145036.97f74a828755d5b9178a3e3a@linux-foundation.org>
 <795b8d8a-4f6f-451f-9274-ccb8380e03dd@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <824c33ead7a2baf08715fe01a4c88714@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-13 03:42, Baolin Wang wrote:
> On 11/13/26 6:50 AM, Andrew Morton wrote:
>> On Thu, 12 Nov 2026 18:11:35 +0000 Pedro Falcato <pfalcato@suse.de> 
>> wrote:
>> 
>>> On Thu, Nov 12, 2026 at 02:23:35PM +0000, Jérémy Jean wrote:
>>>> MADV_COLLAPSE lets collapse_file() treat absent shmem pages as holes
>>>> filled with zeros. It does not check i_size, which allows one 
>>>> present
>>>> page to become a huge mapping that covers the whole collapse range,
>>>> including pages beyond EOF. This makes those pages writable. A later
>>>> file extension can expose their contents after F_SEAL_WRITE.
>>>> 
>>>> Hold inode i_rwsem in read mode while collapsing shmem so i_size
>>>> cannot change. Reject a collapse if its page range extends past
>>>> i_size rounded up to PAGE_SIZE. Keep i_size_read() outside the
>>>> page-cache XArray lock because its 32-bit SMP reader is not IRQ
>>>> safe.
>>> 
>>> I don't think this is an issue. shmem/tmpfs purposefully maps with 
>>> large pages
>>> across i_size, and collapsing across i_size is a feature, not a bug.
> 
> Yes. finish_fault() even has comments explaining the special case for 
> shmem/tmpfs.
> 
> 	/*
> 	 * Do not allow to map with PTEs beyond i_size and with PMD
> 	 * across i_size to preserve SIGBUS semantics.
> 	 *
> 	 * Make an exception for shmem/tmpfs that for long time
> 	 * intentionally mapped with PMDs across i_size.
> 	 */
> 	needs_fallback = !shmem_mapping(mapping) &&
> 		file_end < folio_next_index(folio);
> 
>> hoo boy, this again, See
>> https://lore-kernel.gnuweeb.org/linux-mm/nwkpojnictbg6jicccpxyfi63ol4tmfajrlx24u5xxoxx7lv5f@jkw3o7j6tlfs/T/
>> and enjoy.
>> 
>> It's not good that this sequence permits non-zero data to be exposed 
>> in
>> areas which ftruncate() created - the ftruncate() contract says it
>> doesn't do that.
> 
> That's a valid concern and this is a known issue for shmem/tmpfs. Brian 
> previously posted a patchset to fix it:
> https://lore.kernel.org/all/20251112162522.412295-1-bfoster@redhat.com/

Hello,

Thank you all for the quick feedbacks. I unfortunately did not find
and read the links you shared nor the historical discussions before I
prepared the patch. I'm sorry for reheating what it seems to me like
a sensitive subject; it was definitely not my intention.

> Jérémy , you haven't explained why this matters.  Is there some
> userspace code which is encountering problems because of this?
> Why did you propose cc:stable backporting?

My initial understanding was that there was a security boundary
crossed, and that's why I submitted the patch and added stable in the
exchange, so that it could get backported. While I'm now a bit
confused about the situation, I have no problem in accepting that I
was wrong and I'm totally fine with just dropping the patch if there
was already a discussion and suggest patches.

Regards,
Jérémy
