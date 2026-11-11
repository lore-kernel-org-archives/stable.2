Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385417;
	b=mL4mKBIPcg3GXjdLpcJ7pVIIEfM14l5105L1+FwkjclJsrl6gj9POORMV9AVTHMwjrLQ
	 byPRKXFCrE2H42LCwu0VavmL/rlLgot67Roxz3Glb5nK+RLxufTJouXFUfmHj2Km7WCTN
	 EGiOP5uRs/YeexY4wOkYFtmD/QNZ7YKKe/wRPbaOM7XTV7PORm6zhiaiAinChxshA4A0H
	 GtStSCf7Y3KhINt6ozNEDoEqLqKldUvE0xn+docww4Pn8Nh2LoI3Revd552/j87mpQUZO
	 qbbT6tr2SleFfz9219o/Jxx5dXjDVEJpHkAYA6zoGTmRnS7GQFeJLp2KF9hCmofmpzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385417;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CU4hnlrXZCd9tMMKXfDhfgcXLuc9tfgbhabHI1pc2r4=;
	b=1L65PUDTR+rJe16Mw1sEryIERF9cW60aALIy94poIEQdC2Hu+CNjpyVb8LZpqudB8ogO
	 4LAPBhCCd4YQ2WLbk5qaU2wqUzCU620TVrSSMPiv7V6HckfZQjXHHSQaZ5lN9XjIu+l8T
	 A5X6zX/jJhUjy94sAVr1IKySKa0HdbCueiyVq7ZIw7iTcp/POaKXs+RS1TNmy5RH2xn/a
	 cbh+rz1zAUKyg96mIKNFh64sUquNj2SmICGfnSerXtoZyIS88LdppiXvIVXUfQRmaILGV
	 IyOzCqeFJNLLxgBegO8FNW5nPguK+Q5117D3ntt3ZOtR0KFraacSjy6iymD5pkInCyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHbhhraw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DD606A31C;
	Wed, 11 Nov 2026 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHbhhraw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D3A1F00A05;
	Wed, 11 Nov 2026 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385417;
	bh=CU4hnlrXZCd9tMMKXfDhfgcXLuc9tfgbhabHI1pc2r4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=QHbhhraw3DXiSH2OvMIT8zikgFolnxYI6yo6kNp8HlhaXPyVH99BWHGiHmP4u+i5l
	 gCY6OIxgtJgGGUEY5+mkyI5K0SvWFVt1vAD8tzll9oMFV1RuxCsJI+x8CkYXmmKci4
	 5/nlB26c2WSshqzGzIWx3QfMGn0uSGOuMXEoQZRqdEOdI3mgXil+dd2chSNDlapZk/
	 U57EGNGL8C/dHFSRmjA3oszXqGQX55H8yT3v4xgq6t7FFviJdH9GeDEQu/qBHNYOFN
	 C+pwbW5PhGjVAow3SmrtaDSEo4a5DuBu9yzfl+kI5nXRDUP3RrPYLif4DTOzzXBHzr
	 kXUWjrU/oDQVQ==
Message-ID: <205eb014-0ebc-422f-8421-f9cf175acad7@kernel.org>
Date: Wed, 11 Nov 2026 16:23:34 +0800
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
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: wait for node writeback on the first fsync after a
 checkpoint
To: Seungbum Ju <seungbum.ju@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261103101208.4550-1-seungbum.ju@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261103101208.4550-1-seungbum.ju@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 18:12, Seungbum Ju wrote:
> f2fs_add_fsync_node_entry() numbers each fsync'd warm node page with
> sbi->fsync_seg_id++, and f2fs_reset_fsync_node_info() sets the counter back
> to 0 at every checkpoint. The first node page fsync'd after a checkpoint
> therefore gets seq_id 0, which f2fs_do_sync_file() passes to
> f2fs_wait_on_node_pages_writeback(). That function treats 0 as "nothing to
> wait for":
> 
>     while (seq_id && cur_seq_id < seq_id) {
> 
> so the fsync issues its cache flush without waiting for its own node page.
> If the flush completes before the node write, the inode's fsync-marked
> node block (needed by roll-forward recovery) is not covered by the flush,
> and a power loss can lose data that fsync reported as durable. In our
> traces the first fsync after a checkpoint returned before its node write
> completed in many trials.
> 
> Start the numbering at 1, so that 0 keeps meaning "no node page written".
> 
> Testing (kernel 7.0.0-42, f2fs built as a module from the same source,
> QEMU/KVM, block-layer FLUSH/FUA model with dm-log-writes replay):
> - block traces, append+fsync after sync: FLUSH issued before the node
>   write completed in 29/30 first fsyncs unpatched, 0/30 patched; never
>   for later fsyncs;
> - crash-state replay (28 cells x 3 recordings per module): SQLite
>   WAL/TRUNCATE/PERSIST, LevelDB, RocksDB, LMDB and an append log lose
>   acknowledged commits or become unopenable in 24 cells unpatched, and
>   are clean in all of them patched.
> 
> The same code is present in Android GKI android12-5.10 through
> android15-6.6 and in the f2fs dev tree as of 2026-11-02.
> 
> Fixes: 50fa53eccf9f ("f2fs: fix to avoid broken of dnode block list")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seungbum Ju <seungbum.ju@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
