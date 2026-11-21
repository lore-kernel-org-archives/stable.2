Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281225;
	b=1YkLpjU15lQs5OBRynDtr3SSqZRdQA2nLbRlOChB2BGGBHn7UtD9gb6X10Yu7VtUvA7g
	 mmZflcnfDRV9dwQZ6bmVp0kuNC8WFMPlXVHDsnFLnwBfVmv0Ps6nheGG26am+vmhMHUPG
	 FqbRm0cc+jN37bpLMGwcoMsy1ywgjThVYBhiSjiRTmta1OxaBaV4XpPczgEj6ArdCCxyO
	 SsOt3U07PMHvRVIXcv8NzCVF+yPXWeX3nlwGFcfSZ3mJ447VDYI535HWg564kQ6tUFmJJ
	 CVi7Jbw8qdIs69txICSSZe92lXTf4RaOQsfsKYeAYeI8uOLhfc7TyRwDxqu/U7Tub7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281225;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+dbkeCpIOXBpnkn067V3Q5BN+/RTkw5huCud+rgDHN8=;
	b=PaHudL446huRaKoXgOTnkGC++CDTBQbm96tL0TcCRWNXG914Pj4uIx25VUoRcLmYHQ9u
	 roaSKYRzh2C7zzg/b2MKkRxsYTcUhY/eLL5jmkx8pVuLvVGBuAULIdNBJ2AE91aj9Nbuc
	 Ki8uUKzu8ofBfqoK10TBFhNXwKl+6VnaLXPA/xbwGWV0xi/JQ8dh8HTXZlMfOQDxtGu13
	 c9h/rppgFnX7Ep8dzicbmrnIwJwBuU+pR4jO/XeegDY7HZITEstJeo88RD80FIv+qr67L
	 CVK4HnA3YzZ9ECzvbnfg0NDqd1hh708MJwXIDQz99tUEupNNj1Judl+j7apq1qbdUFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bFQ/BHQd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A71606A320;
	Sat, 21 Nov 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFQ/BHQd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40051F000C4;
	Sat, 21 Nov 2026 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795281224;
	bh=+dbkeCpIOXBpnkn067V3Q5BN+/RTkw5huCud+rgDHN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bFQ/BHQdO64OIlvR3MzpRqRJgppB5crwltAK+iGDe6j3tL0wdIDRVo/juoAtfCka4
	 AjHSJcrJPgM0FDT8FfvJzPaYjSlYrAS7Gb1PfFmb0chr12STn9af04ir242QeR/Grf
	 70Hq1rM/sRJiCFlrOmsqlTViWH2xEQhngwVBR7LiiuCraA1VVccwbTnXKkaoVazSlP
	 3wPFo+AWvmOxdEWyzJw5PO+Xu10BYLeMxBnib9GQ5dCKwIuOM8Vl2R0Vs4kARHh5/Q
	 V5I3iy7d2bMHwnj8Rk9IZO1xLbELH9mxupi4tj9MqSsSXtKWn7lzzGCsqhYqKabyQx
	 MGAqWnXnCcQLw==
Date: Sat, 21 Nov 2026 07:13:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"T.J. Mercier" <tjmercier@google.com>, driver-core@lists.linux.dev,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jori Koolstra <jkoolstra@xs4all.nl>, Ian Kent <raven@themaw.net>,
	Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] kernfs: clear i_nlink before deactivating removed nodes
Message-ID: <awHRR58WX_YwCDSG@slm.duckdns.org>
References: <20261120-work-kernfs-delete_self-v1-1-514a35d04431@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-work-kernfs-delete_self-v1-1-514a35d04431@kernel.org>

On Fri, Nov 20, 2026 at 09:59:59PM +0100, Christian Brauner wrote:
> __kernfs_remove() deactivates the whole subtree first and only clears
> i_nlink on a node's inodes later, once it unlinks the node from its
> parent. In between kernfs_dop_revalidate() already fails for the node,
> so a lookup that runs into one of its cached dentries kills the dentry
> while i_nlink is still 1. For a file of a cgroup that is being removed:
> 
>   rmdir("cg")                          stat("cg/cgroup.events")
>   css_clear_dir()
>     __kernfs_remove(cgroup.events)
>       deactivate the node
>                                        kernfs_dop_revalidate() == 0
>                                        d_invalidate()
>                                        dput()
>                                          dentry_unlink_inode()
>                                            i_nlink == 1, no IN_DELETE_SELF
>       kernfs_unlink_sibling()
>       kernfs_clear_inode_nlink()
>         i_nlink == 0, but the inode has no dentry left
> 
> The inotify watch keeps the inode alive, so nothing ever sends
> IN_DELETE_SELF for it and the watch only goes away once the watcher
> closes the inotify fd.
> 
> The window covers everything between the two loops in
> __kernfs_remove(). kernfs_drain() drops kernfs_rwsem and waits for the
> active references and open files of the node, and the clear itself
> waits for kernfs_iattr_rwsem behind every concurrent permission check
> and stat(). In a VM with a few threads stat()ing a cgroup and one of
> its files while the cgroup is removed, IN_DELETE_SELF for the watched
> file got lost in 16 to 33 out of 150 rmdirs, and it didn't show up even
> after dropping the dcache.
> 
> So clear i_nlink in the loop that marks the subtree as being removed,
> before a node turns inactive. kernfs_rwsem is held for writing there, so
> no new inode can show up for these nodes while the loop runs, and once
> a node is inactive kernfs_get_inode_locked() refuses to attach one. Two
> overlapping removals may clear the same inode twice, which is fine.
> 
> Fixes: eea5d2bb34ba ("kernfs: Send IN_DELETE_SELF and IN_IGNORED")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
