Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA047DD44
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399873; cv=none; b=sZqlU/6f0AIOkSvNt2y1jACxub4NEoLmh9XXWkW8mDKGISYLdef+QrGuA4qYUk01dK5rEIqTqafTbSgTuT+S5gt9uKVd482bYcW4BZWnZ5wrpoWt5lgku9RCAc103VSOL1217s1JLTsEcuEQpreFtp3gRNEegMwMQ8FTfNlJhUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399873; c=relaxed/simple;
	bh=1ezIW7jP9wyqxlPE1NcLyB4NHCHxjn3KBi+qknJXVSw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SASOeU5wIz73FK3fhc/lUJgmKjxyTZMBC18cdAeqVCPWp1rJIvd3uSQvULp9r6tuXETW12OXV65MmsqxE5rPUhs/sCRTvFUqnXFcXd4K2mqxOd4iHIl7kzX6xe6y+47WmnTTsu+B2STiCI/6mV0tJmf44fzgic/AObjC089oRdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com; spf=pass smtp.mailfrom=karaolidis.com; dkim=pass (2048-bit key) header.d=karaolidis.com header.i=@karaolidis.com header.b=EkMU7TSv; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=karaolidis.com header.i=@karaolidis.com header.b="EkMU7TSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karaolidis.com;
	s=protonmail3; t=1792399862; x=1792659062;
	bh=nxWiRzun1MUxXHHtwkjm2y/TD5zRPsCCzmyXZVf4DBo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EkMU7TSv/sPpSb//opgCgtpPnFPfEK1cZE9o0zTsUUc8huV+SG0wgnm9U2f91bNCw
	 KSTc/G5CxcD73YDpt5w0/grU/CHUe44Bi+KEKULxldGrZK1tXvvHhQkbZfYbrJJapv
	 N+Oc2QsLXYublEw0Gt6bYySPU08EOaRQvCfeNOko9UoICxa2Cv+XHe9MrQIMTpsmTV
	 f+I//a9qlTcDwY2qP6d2k7Xa6FJa0CeokK+1s0u1gCIym66jyWVEAyW8SM5E0DowY6
	 vgdYUT9iVnNIcPpwUXXPCz1JrTMXcjUq6V47cf4kfkNgYC4Vxa1v0ox9tMmxwidA7E
	 Js4kvMYxN9fyA==
Date: Mon, 19 Oct 2026 08:50:52 +0000
To: Zhihao Cheng <chengzhihao1@huawei.com>
From: Nick Karaolidis <nick@karaolidis.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: rotate inodes whose page cache could not be dropped
Message-ID: <qNyuimLVAkP0k7luIlbuqeg7Co3gXnyrzZ2fIuFjRZiKon2IaylrG1-_tkSRE_cWyOuq6eIzU6O12OvRg8J-ZszqHBaxE0XL2uYVhQ08MS8=@karaolidis.com>
In-Reply-To: <5b74fceb-dc8d-21ad-d313-eba7a0009056@huawei.com>
References: <20261016102515.111285-1-nick@karaolidis.com> <5b74fceb-dc8d-21ad-d313-eba7a0009056@huawei.com>
Feedback-ID: 101209095:user:proton
X-Pm-Message-ID: 56a8ba167d1bfe9de3fb76b4475e97c78503300d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, October 17th, 2026 at 8:43 AM, Zhihao Cheng <chengzhihao1@huaw=
ei.com> wrote:

> Hi Nikolaos,
> I find a possible BUG_ON if this patch applied, details shown as:
>     P1                          P2
> prune_icache_sb
>   lock(lru->lock)
>   inode_lru_isolate
>    if (!mapping_empty(&inode->i_data))
>     unlock(lru->lock)
>     spin_lock(&inode->i_lock)
>     inode_state_set(inode, I_REFERENCED)
>     inode_unpin_lru_isolating
>     spin_unlock(&inode->i_lock)
>                           unlink
>                            iget_locked // find_inode_fast gets the inode
>                            iput
>                             iput_final
>                              drop =3D 1
>                              evict
>                               BUG_ON(inode_state_read_once(inode) !=3D
> (I_FREEING | I_CLEAR))  // inode state with I_REFERENCED
>=20
> Could that be possible?

Hi Zhihao,

Thanks for looking at this. I don't think that BUG_ON can trigger.

- The patch sets I_REFERENCED in the same i_lock section that clears
  I_LRU_ISOLATING, and evict() waits in inode_wait_for_lru_isolating()
  before calling ->evict_inode(), so the walker can only set the flag
  before the filesystem's eviction runs.

- clear_inode(), which every ->evict_inode() calls, sets i_state to
  I_FREEING | I_CLEAR.

- Evicting an inode that has I_REFERENCED set already happens.
  iput_final() sets it through __inode_lru_list_add(inode, true) when
  the inode is already on the LRU.

Did I miss a path that checks i_state before clear_inode()?

Thanks,
Nikolaos

