Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7DA559CA1;
	Fri, 16 Oct 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174995; cv=none; b=ugY84iogLWMGfn6fono3CvQSxxoEVIVv5OfoNkDIoqld888r/iT7XlDGMh+PhM+J7OVDssMvaxL7t5jpOEZ7S/CwCq2bI4v7L6taZj8C58KodBFCy+r/EQtYYaZZVgxmxOm3O4RdevyVwKSLPUmxDtHyqAifv+dfzXnDg0M8NHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174995; c=relaxed/simple;
	bh=qVBSnUD4BgzJwb6WzTTR109yrom7lWL9sVQngRUV8Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbGpxOLpzltbmXnPZ3Sv4OgTNMeHgjcmGT2G+CW9/p6qP3zPQzVqvFqDPN/ujjvFn4l8lDK7B2TcvuYruAE7xTWSXEMVk4lA7wykxEvsVwZ6ron1y0WlAQ4z1n/YRwti8EPAtV/0BLimbzXfULQUPC1ryi4DsrEg9B47hJjmX2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na8l5qdA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na8l5qdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADF01F000C5;
	Fri, 16 Oct 2026 18:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174993;
	bh=y4DNCOHevBaY9/bPtpQftddtYBlzg6Uu8qIMbHiYP0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Na8l5qdAqJbULdwoHDY3lFQ86obytQYc/gGvPjPxv40BfmpzblxSpw8mkn/zbKy9E
	 NH8io2yv1sZBuX+V55kEnYZ30uBPuPUgeYDlAopCXos01feK/XyoiL4PEYzMrFZmnk
	 Y7tz+7rtsVylqeAEiJrwQUI0k/wLeJl/8jWTRIwnJVcm1ZXXTsOIZ3bANIaL6VtgLu
	 IrNZBFNx25CiPN4kqu8rid58nkiHp9oDJW0S9bLOwcqLiINPwIafgW3u8NlbDBPndl
	 xkKSgHha/95LS0zyKWhepMAiNPUwYVDqhFJKVwTif3UHNufJ8a0199Of5DXVCqj+2y
	 Uf2LKhJZjlOcw==
Date: Fri, 16 Oct 2026 19:23:07 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
	john.fastabend@gmail.com, sdf@fomichev.me, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, bpf@vger.kernel.org, stable@vger.kernel.org,
	sashiko-bot@kernel.org, victor@mojatatu.com
Subject: Re: [PATCH net v2 2/3] net/sched: cls_bpf: accept dev-bound programs
 on shared blocks
Message-ID: <20261016182307.GL363352@horms.kernel.org>
References: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
 <QDISC-PYC7.v2.20261010165947-3@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-PYC7.v2.20261010165947-3@mojatatu.com>

On Sat, Oct 10, 2026 at 05:02:49PM -0400, Jamal Hadi Salim wrote:
> The issue:
> Follow-up to commit 120977e2c096 ("net/sched: cls_bpf: reject dev-bound
> programs bound to a different device"), which derived the target device
> from block->q:
> 
> 	dev = block->q ? qdisc_dev(block->q) : NULL;
> 
> tcf_block_create() leaves block->q NULL for shared blocks, so a
> device-bound program attached through a shared block is rejected with
> -EINVAL even when it is bound to a netdev that owns the block.  The
> offload path (cls_bpf_offload_cmd()) never consults block->q and drives
> the per-device callbacks for shared blocks as before.
> 
> The Fix:
> Accept the attach on a shared block when bpf_offload_dev_match() matches
> every netdev bound to the block, and reject an empty block.  Every member
> must match because the offload path broadcasts the program to every
> callback registered on the block, so an any-member check would re-admit
> the wrong-device attach on a mixed block.  Every dev-bound SCHED_CLS
> attach is skip_sw, which becomes err_stop and aborts the offload on the
> first failing callback, so the all-members rule is the offload path's own
> semantics.
> 
> Iterate the public block->ports xarray (913b47d3424e, v6.8-rc1) rather
> than block->owner_list, which is private to cls_api.c.  The shared-block
> rejection reports "Program is not bound to every device in the block",
> distinct from the non-shared message, because a member can exist without
> a registered callback (netdevsim registers its block callback
> ingress-only).
> 
> Context note:
> This patch is not an independent fix: it re-exposes the shared-block
> replay path that commit 120977e2c096 ("net/sched: cls_bpf: reject
> dev-bound programs bound to a different device") had closed, so patch 1
> must be applied first, including in stable.  A stable tree taking this
> patch alone would re-enable shared-block attaches on a kernel whose
> netdevsim callback is still unchecked.
> 
> Conditions to recreate the bug:
>   - CONFIG_NETDEVSIM=y, CONFIG_NET_CLS_BPF=y
>   - load a dev-bound SCHED_CLS program for netdevsim device B
>     (prog_ifindex=B), pin it in bpffs
>   - tc qdisc add dev B ingress_block 22 clsact
>   - tc filter add block 22 ingress bpf da object-pinned <pin> skip_sw
>   Unfixed, the filter add fails with -EINVAL ("Program is bound to a
>   different device"); fixed, it succeeds.  Adding a second, independently
>   backed netdevsim device to the same block makes the attach fail again.
> 
> Fixes: 120977e2c096 ("net/sched: cls_bpf: reject dev-bound programs bound to a different device")
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/
> Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatatu.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

