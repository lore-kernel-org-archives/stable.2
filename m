Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524023;
	b=gYMLdI/BIYhfVS8pzWO6aukRHpHj8KNOQltJL5DJXMFXX6C0niKHsdWVBLth1q1hibKf
	 OSHEehzvlOGDPX3GA9jARDC7vwnxuXf+Tcdz8+KQBwYVo49uTyHGB3gcbr4B+qv8IdO1N
	 GwjkZSdrGG/W/OpEN7LB5IkhOODhKMmAh33W0Ad9SR7kdlRskjK2PQlC3IoBXqoMqhUgO
	 BK0zupL7zdE8NHjRcyyanJD84/EmtZCnIY/1dQbdGQjstQkkBBnPPbWKg86Q10lA3Cu7S
	 5p2FsTEu0rGwa3E4rOypShmR9gIxm+3bB3Sw+4QtrHHat2LaQkw9Am8AzimljxQkSQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524023;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=fmJU1hjBtut2ZClpTk0/Uyfv4hHhwMNPcQa921A/cjI=;
	b=SJ0ofwX3ZveBND+dvWz+PBEr2Uw70CC34BLUirtZ3KdIZa5XO5+9nL2kGs2sNZ/Bp62R
	 +MjHfc8lfHxEoPnjhtXLYOGfh1Gcn4BTkHCdNl8JG6VMD83KHycjyxc9HVXYBI1spZ78J
	 POB7saqABangEPGC7Dl+5Hv1onetqMtYJy0Et96+bbviuZ3VTMfJ6nKpZWxOHuUwRmOu2
	 Ajjg9fPNPpEjeCojY/BInHeGm/HgfiB6kIVy4TMwqruJFZYNvyYT1a+uwzBO8JGFE+kQ7
	 PsvT2fujLyTxyoEeBl/a5empQp5mEN3yLW4KI4EQlN2cVH7XqAX4AsDkYxss7NHPZuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ndz7wbr4ebftpiguigrsldtefu.protonmail2 header.b="j/cWJcDy";
	arc=none smtp.remote-ip=79.135.106.99
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48333606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48333606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ndz7wbr4ebftpiguigrsldtefu.protonmail2 header.b=j/cWJcDy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ndz7wbr4ebftpiguigrsldtefu.protonmail2; t=1795524019;
	x=1795783219; bh=fmJU1hjBtut2ZClpTk0/Uyfv4hHhwMNPcQa921A/cjI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j/cWJcDyE1LJFJt1lsYHUyt5wY0iew0bPCEjGAWJuCSRCmhgg4xdsULHug7l0DT9x
	 UuyGAjVF3TpmZpSsga+vZZBC3RXS2avPqLfJdLX2a5IOnacdljp57RUOxu4nt7J9P4
	 DCthNWYBuoV8Q64y2LUH9iI8WXpnnnGqPHQAIGXOCY0c0aR/paAg4maRUlhAQBuJ4R
	 VucgBGlVP+L+AjSYEttL22HK3T6GCQiFx8lRqSmq4nkoHdBeIrNzIP9SbWUDxZyoCS
	 iwfvkfUsYguYRPxweWkuNJWbZJBXFPlBCXLo66KnNWi7lTx0Cp2URLv+PaPmn6wMYB
	 vWNm6bc1exmAQ==
Date: Tue, 24 Nov 2026 12:40:14 +0000
To: Hyunchul Lee <hyc.lee@gmail.com>
From: Ernest Borowski <ernest.borowski.git@proton.me>
Cc: ernest.borowski.git@proton.me, Namjae Jeon <linkinjeon@kernel.org>, Baolin Liu <liubaolin12138@163.com>, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 5/7] ntfs: punch out the delalloc reservation of a failed buffered write
Message-ID: <179552401127.2437814.5296523363339090299.b4-reply@b4>
In-Reply-To: <awPTjheQrp6sxB5W@hyunchul-PC02>
References: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me> <20261122-b4-ntfs-delalloc-fixes-v1-5-0726f0dce403@proton.me> <awPTjheQrp6sxB5W@hyunchul-PC02>
Feedback-ID: 236360163:user:proton
X-Pm-Message-ID: 96cd9f2e223e2295cbc6d5f0c93ff9b921a6e372
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
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 02:47:58PM +0900, Hyunchul Lee wrote:
> Could this leave clean dealloc clusters reserved?
>
> For example, with 1 KiB clusters and 512-byte blocks,
> iomap_write_dealloc_ifs_punch() calls this callback seperately for each
> clean block in a dirty folio. For a cluster covering [1024, 2048),
> the callback receives [1024, 1536) and [1536, 2048) separately. Rounding
> each range produces an empty punch range, so neither call removes
> the reservation, even if the entire cluster is clean.

Yes, thanks.  The test only used 512-byte, 4 KiB, 16 KiB and 64 KiB
clusters (either one block or at least 4 KiB), so it missed this.

Triggering it requires a folio with clean, uptodate blocks behind dirty
ones after a short write.  That takes a hole below the initialized size
already read into the page cache (a write past the initialized size
drops the cache first) and a copy ending on a cluster boundary.  If the
copy ends inside a cluster, patch 7 calls folio_mark_dirty() to cover
the rest of that cluster, which dirties every block, so nothing is
punched; that makes writeback write the whole page, and I will look at
narrowing it in v2.

For example, with 1 KiB clusters on a file initialized to its end:
pread() 32 KiB at 0, then pwrite() 32 KiB at 0 from a source that
faults after 1 KiB.  With v1 the three clean clusters of the first folio
keep their reservation, and writeback allocates them but writes only the
dirty blocks, so [1024, 4096) reads back the old disk contents after a
remount.  A failed write at a lower offset than a dirty cluster in the
same folio keeps the reservation until the inode is evicted.

                                  v1                  v2
  short copy, 1 KiB clusters      4 clusters, 3072 B  1 cluster, 0 B
  short copy, 2 KiB clusters      2 clusters, 2048 B  1 cluster, 0 B
  failed write, 1 KiB clusters    4 clusters          1 cluster
  failed write, 2 KiB clusters    2 clusters          1 cluster

(clusters allocated or reserved, of which 1 is the written cluster;
bytes of old data read back after a remount.  Same results on Ubuntu
26.04 and Arch Linux.)

v2 adds an iomap patch before this one that passes each run of clean
blocks to ->punch() in one call.  A cluster no larger than a folio then
reaches ->punch() whole when all its blocks are clean.  A larger cluster
overlapping a dirty folio has dirty data and must stay.  XFS and ext4
punch whatever range they get, so for them it only means fewer calls.
The iomap patch alone fixes both the short copy and the failed write.

CI runs:
  ntfs-next + v1:            https://github.com/xerrni/linux-ntfs/actions/r=
uns/45386115143
  ntfs-next + v1 + v2 fixes: https://github.com/xerrni/linux-ntfs/actions/r=
uns/45386121459

The cases are in tests/delalloc_partial_fail.sh in
https://github.com/xerrni/linux-ntfs.

Thanks,
Ernest

