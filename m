Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537773;
	b=ceSFaE9YE3Ii3hLFRQSpIyUIQUABy5pyPWVPxz7E3c4Gh29b7Ej6bJWJoO6/OCaimRji
	 wq8SQSXvt9OpykoxRbHTqeYvpZahGkaZWdqhT+NasK/bnKiOAW9Gi3LrYD/CcJWGxLa8l
	 l+ZWlcUIntQJD8vV5agE+fN5fBfISqmfpFVuKuTG4gOmzQmq8GV1d+lw246dV6Tx621Hm
	 28WfvEnjanH+dlbLbaWQJoMdzCS14TQHVaaLbAcQfwI6t7RNClpCZyd+NF6P6/nUYtOjm
	 B78IUH+LW8ww5lWlz8GS8ckHXdRRvls23H6WlcH04FFjB1jXAp+vu4qKL7TkI79bJ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537773;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rpfqaLD/s0aZ2I2qPUV8mwprDsWG5GFsyO34/kwcrmE=;
	b=4j04rXvuEcnRLrJReOdxr9ANfBdlFGdBPJYYEFWpHcJGoBRqXCq+rNzJ/+Yc+BnSHlhP
	 hlv4QNAEOhjCoxk3DWCj4CW2y6Rvd/oIc4X/UNVu52InhZaykz4lcvioZMdm1ehobugew
	 t9PncbJ7pF1CBPodLh/aYdJvjq/Z6/hayxZtvrQHJcXSNd0KDkSCiZeRR254422JleKos
	 pIP/KzXKVrGtFyJy5Tof20usV83p1MSmooYr8q4HvfI5WCeCInT7C8mRrqYB7ukp5T9ja
	 l8sAXcEA0fMVzJxTyOQCAX3Mf3+upbct6cRe5pzcbWYKDUmve7Pwyuj140WVqgUXEZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=v2J4x8w4;
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63F606A32E;
	Fri, 13 Nov 2026 02:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A63F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=v2J4x8w4
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794537765; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rpfqaLD/s0aZ2I2qPUV8mwprDsWG5GFsyO34/kwcrmE=;
	b=v2J4x8w4xEhBnkI2KXUn9Obj2RPAX7Pm0AMMy1kLpWiU10VOmZmULFBcgr9nLPL6XyBojG03lx+TyWpUnuo9dhfVQxUM/fWx+m4kDo+3HAo1cXY16nG3LvB5VEvEG88b9fl0VUKNPUm8gcrhVwtvUSppvcUk8rAw5vErkQDIHgM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0XEdeb.M_1794537762;
Received: from 30.74.144.124(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEdeb.M_1794537762 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 10:42:43 +0800
Message-ID: <795b8d8a-4f6f-451f-9274-ccb8380e03dd@linux.alibaba.com>
Date: Fri, 13 Nov 2026 10:42:42 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/khugepaged: reject shmem collapse ranges beyond i_size
To: Andrew Morton <akpm@linux-foundation.org>,
 Pedro Falcato <pfalcato@suse.de>
Cc: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261112142335.2749597-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <avYBFPhB46XWAG4A@pedro-suse.tail5790ac.ts.net>
 <20261112145036.97f74a828755d5b9178a3e3a@linux-foundation.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261112145036.97f74a828755d5b9178a3e3a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/13/26 6:50 AM, Andrew Morton wrote:
> On Thu, 12 Nov 2026 18:11:35 +0000 Pedro Falcato <pfalcato@suse.de> wrote:
> 
>> On Thu, Nov 12, 2026 at 02:23:35PM +0000, Jérémy Jean wrote:
>>> MADV_COLLAPSE lets collapse_file() treat absent shmem pages as holes
>>> filled with zeros. It does not check i_size, which allows one present
>>> page to become a huge mapping that covers the whole collapse range,
>>> including pages beyond EOF. This makes those pages writable. A later
>>> file extension can expose their contents after F_SEAL_WRITE.
>>>
>>> Hold inode i_rwsem in read mode while collapsing shmem so i_size
>>> cannot change. Reject a collapse if its page range extends past
>>> i_size rounded up to PAGE_SIZE. Keep i_size_read() outside the
>>> page-cache XArray lock because its 32-bit SMP reader is not IRQ
>>> safe.
>>
>> I don't think this is an issue. shmem/tmpfs purposefully maps with large pages
>> across i_size, and collapsing across i_size is a feature, not a bug.

Yes. finish_fault() even has comments explaining the special case for 
shmem/tmpfs.

	/*
	 * Do not allow to map with PTEs beyond i_size and with PMD
	 * across i_size to preserve SIGBUS semantics.
	 *
	 * Make an exception for shmem/tmpfs that for long time
	 * intentionally mapped with PMDs across i_size.
	 */
	needs_fallback = !shmem_mapping(mapping) &&
		file_end < folio_next_index(folio);

> hoo boy, this again, See
> https://lore-kernel.gnuweeb.org/linux-mm/nwkpojnictbg6jicccpxyfi63ol4tmfajrlx24u5xxoxx7lv5f@jkw3o7j6tlfs/T/
> and enjoy.
> 
> It's not good that this sequence permits non-zero data to be exposed in
> areas which ftruncate() created - the ftruncate() contract says it
> doesn't do that.

That's a valid concern and this is a known issue for shmem/tmpfs. Brian 
previously posted a patchset to fix it:
https://lore.kernel.org/all/20251112162522.412295-1-bfoster@redhat.com/
