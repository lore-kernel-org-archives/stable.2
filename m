Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581145;
	b=A35uq1Kvb8JlxEhB983Rt/nAlkEv8PDsCrRs/V0yNd7Eu7lcgFj/SjllEfaLoSn/BQyf
	 jK3h1colq2Wm99zv4/72LX1EPwgfR7kybNmcZxZx/hCHwUAS8FflnzHQ2W4+FJcVsrRN9
	 coCW998z/wzid9Q0f8LmVyax6M+rRQkg3jSPEnzxRiHWVmr3j7FyPtuwC3EA7z8gKjodA
	 pt3q+/F7bvuUobvBtxxJFK5/UVQrOAjA9nI4/yerQOgIimh+IE9JFv7hssuudBzgbrWY4
	 CFriEZvHr0/JUl2SpnPvwqYxEBSIlC/kupCBeU1ZcuwN6WiEu88qU9fCi1oPRuuUcVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581145;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=X5CYb9ztFFOzd65gw05f3B6XcjV+RftTzdfSD60JPUo=;
	b=GFZ72/bOP5PEnv0D2BTc9YZxynHYZTrkEp+URAsFVCIiqcasghqZslRV8qVAhoVtAmlq
	 GVZVo2cnwbcFO6DBqPb9vpl1vH1ubIY3MWARK5K617D/JLhsn2paejjcfucnc2awZF8pY
	 3+oMazO1LQx1Q4mgAKTL81VfaqJAWg0GMKB2314MqHv8blW1ADadzdg8tqu42uwx2Q3uB
	 3XhVXzEJvTqs1TkvHnOhnlaS67GV4/DkO4w3hddM1Zm4wGNHSb24cIGHbZr4LWG67gwnS
	 i6uPEuseH0kxVlC+ntszjnFfb3E/hWlhFxgcxyRT9OTPFEtvZZQB5h091bljdkYSDTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBSL5YI3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF8606A31B;
	Wed, 21 Oct 2026 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBSL5YI3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C6B1F000C9;
	Wed, 21 Oct 2026 11:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792581144;
	bh=X5CYb9ztFFOzd65gw05f3B6XcjV+RftTzdfSD60JPUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gBSL5YI3wik5nDR14b3lzoBGE13IJgb8zLKGiwWXMPqTWC2G8EzKIE3GLs4WOb+GG
	 WXvdGkAylZcvnLRh+2+bSHxspiHGZ3DY8rQVoiUXYsz3jIsxNfG20oMZPCfETA3U5+
	 gaccOpozem0/jIdOII3JRRqlEwcMsXQxk4mkJI/tQNK1SSyluJpuCgEdTTO/QQhjRx
	 fATFDJLtEyl7C+QpHrzs695ZTBA1jMtffDGxVmtuQWyT+Cmbxem6JaCR4xka3Micyn
	 1we1sdvrepfRYSATx+dZOrsY2i46S3KqOvnKbsOhUa/N+pbP7fy3m5bgHSLN6e9BXt
	 elJqJnGRbreYA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
Subject: Re: [PATCH 00/15] super: fixes for freezing, reconfiguration and
 error reporting
Message-Id: <20261021-freuen-opfer-protokollieren-e42e1ab401ed@brauner>
Date: Wed, 21 Oct 2026 13:12:17 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2948; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KojECImsY1DCx38B84dzcRLRptaE8g762ZT520/nKt0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmCeyuiRj+/5lbkeOdWYc2JAkcpvtxu6cwtqXC9Z9U
 JXOOTu3sqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiva4M/7S/7y0J+c50WCdM
 4M3Bp5/fmFiFyuSppW9Y+IjpRm+xxBmGv2JKypcNW5/xVc15Infu7OZTwhuuabDLSJ0SWxLdfWj
 7XzYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sun, 11 Oct 2026 17:56:00 +0200, Christian Brauner wrote:
> super: fixes for freezing, reconfiguration and error reporting
> 
> A pile of fixes for super.c and friends that I found while going over
> the freeze and reconfigure paths again. Most of them are old and all of
> them are tagged for stable. Most come with a selftest under
> tools/testing/selftests/filesystems/freeze/ that fails without the fix.
> 
> [...]

Applied to the vfs-7.5.super branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.super

[01/15] super: don't put the remount context under s_umount
        https://git.kernel.org/vfs/vfs/c/c8b510a653c0
[02/15] super: don't warn when resume thaws a userspace freeze
        https://git.kernel.org/vfs/vfs/c/94a8fbf41dc0
[03/15] quota: really wait for the thaw in quotactl_block()
        https://git.kernel.org/vfs/vfs/c/7c72578b6bbf
[04/15] selftests/filesystems: add quotactl() tests for frozen superblocks
        https://git.kernel.org/vfs/vfs/c/11a5faf02594
[05/15] fserror: fully order the last pending error decrement
        https://git.kernel.org/vfs/vfs/c/7458e617f05f
[06/15] fserror: don't accept error reports before the superblock is born
        https://git.kernel.org/vfs/vfs/c/fd3f60631c5c
[07/15] fs: don't fail fs_bdev_freeze() once a superblock is frozen
        https://git.kernel.org/vfs/vfs/c/2cf7459161f5
[08/15] selftests/filesystems: add a test for failed block device freezes
        https://git.kernel.org/vfs/vfs/c/ada03c558995
[09/15] fs: don't keep a device frozen when its freeze is already gone
        https://git.kernel.org/vfs/vfs/c/f9ce47809e3e
[10/15] selftests/filesystems: add a test for thawing behind a device freeze
        https://git.kernel.org/vfs/vfs/c/247840d9af91
[11/15] super: keep the read-only state if a reconfiguration doesn't change it
        https://git.kernel.org/vfs/vfs/c/fa6c71988168
[12/15] selftests/filesystems: add tests for reconfiguring through fspick()
        https://git.kernel.org/vfs/vfs/c/1d36552c8e51
[13/15] super: remove SUPER_ITER_EXCL
        https://git.kernel.org/vfs/vfs/c/654a0d3ce35b
[14/15] fs: reset the flag mask in vfs_clean_context()
        https://git.kernel.org/vfs/vfs/c/5dd822b588c6
[15/15] selftests/filesystems: add tests for reconfiguring a reused fs_context
        https://git.kernel.org/vfs/vfs/c/7d162c765b37

