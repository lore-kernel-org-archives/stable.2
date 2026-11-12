Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523838;
	b=CJSSqPfrA17YK3LLRWxx2djIllCqGErsuj/i1fAigIgZk64gZRe2UALv8KoWg7iY0hU7
	 lwraGqzpe9MlY5PF/URTR5a8rwlJvp2tzlvmgHmp9v/iNxnebrPnK5xgmq+SiGFVzvEst
	 6Stuz7fsR3krjAZzLpmz4WnV+/UBlBNh+2NNEqmY1v2HfNnqITtCn5m0Wg0QopFdvGSMJ
	 2d6NIHJZqdzPCT3jNEn2cAsZzi+DVlPYNol/mjyw2bVl6B8vuKNu57MSSzB4j6exq5f4G
	 BTUcTC855Q11wHpIX3jpPayi2XxE3cjRSGzWDbwZ8FPvYVwSYs0ALWM//IqbV3KV7wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523838;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0TqqnxQNVR9PGz0qsU/cytTwrDEZUDTjkuJZAfCjgjk=;
	b=pxL3xo0JN2/fyiVJZMowYq6lu+5RxO6MAbm2mHV0VbrnERY+Ldg2uG23KlX+kqT0nOQ3
	 5QLJ7Nkful3CRRN0Co0D+pkzUHlZ+0UvCw7BdVznJ13PKEx26C6M6xWihErwxEcME6XpT
	 1Utih4zJJDsgWUhwG0ETbdAaw0ylU3Smv6vBtz4eDvEP+vuXbBKlNrzP16DuzFAw7ObnT
	 UgvF64eCQ44oraSTmkuBTFTO8T1y5u+Cp5N70WxxPTPfkmEEjO31OJw44yYcHYso0sbRE
	 ADp3xR+dtnwvzTO9sWaEk3ucAQHGtPhwZxELITzr/cLOHrqpD4x4Z+13YcQlhps7ZDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ib1q3vLs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252B606A31C;
	Thu, 12 Nov 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ib1q3vLs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0321F000C4;
	Thu, 12 Nov 2026 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794523837;
	bh=0TqqnxQNVR9PGz0qsU/cytTwrDEZUDTjkuJZAfCjgjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ib1q3vLs3nrjWX3UOR0N6gf6I7Izk3R5STAMgmrEseBFZ2+/2ZtaLtD/xHRZV48+g
	 gdu2jbJ8rJ/E34iojbyi7lQ7kFgGmF1BapDESUJnU73YEDTFck/8O2UKwr2aOQ+6xK
	 RkXUOhwUwQIlfXlLqJw9puz+w0Be+j12bJXOqOak=
Date: Thu, 12 Nov 2026 14:50:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: =?ISO-8859-1?Q?J=E9r=E9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>, David
 Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau
 <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: reject shmem collapse ranges beyond
 i_size
Message-Id: <20261112145036.97f74a828755d5b9178a3e3a@linux-foundation.org>
In-Reply-To: <avYBFPhB46XWAG4A@pedro-suse.tail5790ac.ts.net>
References: <20261112142335.2749597-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<avYBFPhB46XWAG4A@pedro-suse.tail5790ac.ts.net>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2026 18:11:35 +0000 Pedro Falcato <pfalcato@suse.de> wrote:

> On Thu, Nov 12, 2026 at 02:23:35PM +0000, J=E9r=E9my Jean wrote:
> > MADV_COLLAPSE lets collapse_file() treat absent shmem pages as holes
> > filled with zeros. It does not check i_size, which allows one present
> > page to become a huge mapping that covers the whole collapse range,
> > including pages beyond EOF. This makes those pages writable. A later
> > file extension can expose their contents after F_SEAL_WRITE.
> >=20
> > Hold inode i_rwsem in read mode while collapsing shmem so i_size
> > cannot change. Reject a collapse if its page range extends past
> > i_size rounded up to PAGE_SIZE. Keep i_size_read() outside the
> > page-cache XArray lock because its 32-bit SMP reader is not IRQ
> > safe.
>=20
> I don't think this is an issue. shmem/tmpfs purposefully maps with large =
pages
> across i_size, and collapsing across i_size is a feature, not a bug.
>=20

hoo boy, this again, See
https://lore-kernel.gnuweeb.org/linux-mm/nwkpojnictbg6jicccpxyfi63ol4tmfajr=
lx24u5xxoxx7lv5f@jkw3o7j6tlfs/T/
and enjoy.

It's not good that this sequence permits non-zero data to be exposed in
areas which ftruncate() created - the ftruncate() contract says it
doesn't do that.

J=E9r=E9my , you haven't explained why this matters.  Is there some
userspace code which is encountering problems because of this?

Why did you propose cc:stable backporting?

Thanks.
