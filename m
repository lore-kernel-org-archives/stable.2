Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=96.67.55.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066885;
	b=4XSGot1qx1GDufoafcirAs8CinD6cOLd1HNsjgmgEmaXkMqoXVoP9VZzxdbkVjKE9cDZ
	 r/rSdXplI39zt+T3E9Z0XpcJXz7m9PJbuovGp5VsvIiwGje0t3RzcJw47ewBXvcXDUmQN
	 Sez40m6SdiHi07ndLbtdG6ESEIUdKfQVk/NtKztvVaO7O6z0CYHvKHEI+2xGM1eScEHdu
	 YzsFMXCZXIs/Sb9vRJL0JqNDrIj71P8GdqkrsmC/Ppe+AWeMTsUVQofIkj9mGaa1Q5EeC
	 jOFRp5uKaByLUUjMLQuI8icmM1lkhBgoW6h+1E97oYnZCeBTK+UsjeBwUL9S5ZgYJrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066885;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=oLq4wxz5oEh5R1sh+VJJCccBAQfxGPFlpx22HnajP3g=;
	b=p/EKTGqCBJhLoYsvIOmGKNJmTk4eOOcbHYzG7dk6bZxLyGMPjzf/B1KLpEXWxyZ1HFaN
	 JZIp+TeZlovtGMJIO7Fv95sBhHPdeR2fs15mDf77ylTpcJ+2rQX35m2luk/YMenRMHYgc
	 HQ/DpBJZORXwuDLnV98BLt6+VnhVDnvn2yKREFBFzsb4O5+LswYvhPB4c+41qbmKEq755
	 y/tbA21L/2H9vi+7AmKvtN2GloVMGmOpMU5IIV7GBjEkZ7UWOnnAnjAax9XjNwWIIuE2c
	 Cv59kCJnymg3cHfD/AobtmVHCcFuUKGVVkA+usQbjcHqPa0C8VLlidjBAtU+3URlkxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=surriel.com;
	spf=pass smtp.mailfrom=surriel.com;
	dkim=pass header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=I4TZvnuF;
	arc=none smtp.remote-ip=96.67.55.147
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40057606A31A;
	Tue, 27 Oct 2026 02:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40057606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=I4TZvnuF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=oLq4wxz5oEh5R1sh+VJJCccBAQfxGPFlpx22HnajP3g=; b=I4TZvn
	uFx5nXaNn5b4N6dTFJOZnQFvfCyMSRe1WmZf0oJ6ac5FdYlGx4P4oZcraSi6f8oHxdUKQRL2hhMv2
	k1T8Qhk4DMEliLIEGV8Z9vwg9OjZR0LHm1fw7Q4EGvmnlyqmSPcCxJDJVd3+v/SvoT1lDE5OhhWJh
	bB0TywZtbrrrqxcpI/RWp69SqjcAEJ93TnMT1V6Mt8msESZgTNg0CoUeCX2noFZdIztNs0cPT7B/y
	9e9Au7mlP2j0PqR5y1+9tf4+O0p9v7VEND/Q6vD2t3xAaX7LNz89F3FQppIO6jBl/Ye+nt7mv8PxY
	jNU/oTDZc+eq68lcC1MXDWmrSHAA==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xLWaN-0000000B10v-3TRT;
	Tue, 27 Oct 2026 02:06:47 +0000
Message-ID: <639cb6dca4ab423272e05b90562ec49c7bdb12f9.camel@surriel.com>
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
From: Rik van Riel <riel@surriel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton	
 <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko	 <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt	
 <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Kairui Song	
 <kasong@tencent.com>, Barry Song <baohua@kernel.org>, Axel Rasmussen	
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu	
 <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Baolin Wang	
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>, Kees
 Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jann Horn	
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Hugh Dickins	
 <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush
 Yadav	 <pratyush@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Lance Yang <lance.yang@linux.dev>, Harry Yoo	 <harry@kernel.org>, Alistair
 Popple <apopple@nvidia.com>, Nico Pache	 <nico.pache@linux.dev>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain	 <dev.jain@arm.com>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau	 <kas@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, John Hubbard	 <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Will Deacon <will@kernel.org>,  "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, Oscar Salvador
 <osalvador@suse.de>,  Minchan Kim <minchan@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,  Chengming Zhou
 <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>,  Nhat Pham <nphamcs@gmail.com>, Youngjun Park
 <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Ying Huang	
 <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, 	linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, 	linux-cxl@vger.kernel.org, Josef Bacik
 <josef@toxicpanda.com>, 	stable@vger.kernel.org
Date: Mon, 26 Oct 2026 22:06:47 -0400
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
	 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-27 at 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>=20
>=20
> Set the flag when the memfd is created.=C2=A0 As for any other regular
> file the
> lock is only taken if the file is reachable in more than one way, and
> nothing a memfd does in read or write waits for another operation on
> the
> same file.=C2=A0 This cannot be done for all alloc_file_pseudo() files:
> anon
> inode files such as eventfd are S_IFREG as well, and a blocked read
> holding
> ->f_pos_lock would lock out the write that is supposed to wake it.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
