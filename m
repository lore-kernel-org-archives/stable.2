Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122465;
	b=siTa6Mqy5Juo7nlY4ynOYFtgkOUdY6zt2MalFSPDYAoO6uxy2TQbstPsMMsL2Fr+Us9Z
	 NhZ2g9Xos2McqIZAz+AKKqR/FyeamMLKR9P3tA8pLAZYI/xnrgOfxskG7c5Oy03HmEoYD
	 zbnb0uVzIUvwhzyPUv1kJMxB+54nsxMdzmSM8SBsHW+2yG1n6azBoZtgsHU9BxS2eFQOQ
	 d5MT/X+D+bxj6oyptw8jXFbpQXnXy3qLPEtqum5GsFF3/klREy7JJSmyn1Dhm7y3OFuAZ
	 Z3Ez4YM59AJpoGRmWL43glIKP9Oh6xwJcqqrw8bTbUydkR8M9fCuVOB93YuVMj2N6rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122465;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=COdQsqilLLQbumWXSPatN4LDhJMWTfOp2W8kqhDBWxs=;
	b=K5yotWVMsn7QNQBSi7Nt5tQjlqVBUlXBQw59gZb9rhnfMAqcaB8NRhgWJ5x/THRJnBpO
	 Vh8Kl2Fy25i6tBL/NtqfAXwapRzwpJy+M7JijboTyHrGYsYLsutWUzBP8shTop9UDLXHs
	 TS3rySUNyaNpoI7XiwmLC+UjAgnNY1rZoLzIT7MRjQm/GA2t6MTMpW1e4ZAoBQFDnjAF7
	 0YDbZ1xvMGyZKmkq/NB8QB8kIOa6crMVbVIiaWUV4Kdf2p6wSMc4IhMlOOpceTKocffr4
	 /NpWGHlXeOU0A6SZFHTtlEvJReHWV8fnvryfTXQhDrJIbL5p4Uyb/u8tobWTt+ozf5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYN2vzKs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B895606A31A;
	Tue, 27 Oct 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYN2vzKs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30B81F01825;
	Tue, 27 Oct 2026 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122465;
	bh=COdQsqilLLQbumWXSPatN4LDhJMWTfOp2W8kqhDBWxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RYN2vzKs4ZkzsggRNOd5345Y9RmP5xJuwIVm9w6r5x3FAJg1HBumtJ7kzq7Zk2Byv
	 NJLY3MTki5J/jgMKffKX0MJUDmrh7Mj9/0LUeDWRGFT9PKDun2MDUk4bswpvOBod5/
	 bNYMieVVAxa9BIH2qgUZj85frA0Pfn970M2GP/0jc91EGPQZNOIAGmiPNiger8wclo
	 ufyI4lp/osGtIkHDTUYogUM4fs20J692aYPNRbVq5x2xvqh4gPgqRcUB13BB9b5qSK
	 oNjI1xXwG20lYigNS/pYDFW4KUWITLyuatPQ7hVvva5pYJEnM36h88Ce4pzq4aw8J6
	 m+957JU9t5eOA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Gregory Price
 <gourry@gourry.net>,  Zi Yan <ziy@nvidia.com>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>,  Rakie Kim <rakie.kim@sk.com>,  Ying Huang
 <ying.huang@linux.alibaba.com>,  Johannes Weiner <hannes@cmpxchg.org>,
  Vladimir Davydov <vdavydov.dev@gmail.com>,  Michal Hocko
 <mhocko@suse.com>,  Hugh Dickins <hughd@google.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Lukas Czerner <lczerner@redhat.com>,
  Carlos Maiolino <cmaiolino@redhat.com>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Daniel Verkamp
 <dverkamp@chromium.org>,  Jeff Xu <jeffxu@google.com>,  Muchun Song
 <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Stevens <stevensd@chromium.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  William Kucharski <william.kucharski@oracle.com>,
  Chris Li <chrisl@kernel.org>,  Kairui Song <kasong@tencent.com>,  Nhat
 Pham <nphamcs@gmail.com>,  Miaohe Lin <linmiaohe@huawei.com>,  Naoya
 Horiguchi <nao.horiguchi@gmail.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Chris Mason <mason@kernel.org>,
  stable@vger.kernel.org,  Pedro Falcato <pfalcato@suse.de>,  "Kiryl
 Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v2 04/14] mm/shmem: honour F_SEAL_EXEC when an ACL is set
In-Reply-To: <20261027-fixes_shmem-v2-4-86a00952acb9@kernel.org> (David
	Hildenbrand's message of "Tue, 27 Oct 2026 14:03:09 +0100")
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
	<20261027-fixes_shmem-v2-4-86a00952acb9@kernel.org>
Date: Tue, 27 Oct 2026 18:34:18 +0100
Message-ID: <2vxz7bj3oxnp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 27 2026, David Hildenbrand (Arm) wrote:

> From: Chris Mason <mason@kernel.org>
>
> The owner of a memfd sealed with F_SEAL_EXEC can still change its
> execute bits by setting a POSIX access ACL. With CONFIG_TMPFS_POSIX_ACL,
> this lets an unprivileged owner make a non-executable memfd executable,
> bypassing vm.memfd_noexec=2.
>
> simple_set_acl() updates i_mode directly, bypassing the seal check in
> shmem_setattr(). Add shmem_set_acl() to check the resulting mode. Share
> the F_SEAL_EXEC check with shmem_setattr() using memfd_check_seals_mode()
> in include/linux/memfd.h.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Acked-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> [ david: use common helper; simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
