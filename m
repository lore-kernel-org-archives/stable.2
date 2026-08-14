Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78B2441B8;
	Fri, 14 Aug 2026 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715204; cv=none; b=GoHb504/8PKWXbayS+Npv4W+M6sI5yTS3vCiDRy1iTkpm02ZmJqIROt957pYUNOsuq0zJTeAq1gjqkk2wrqVAyOeUcrCnOainKqlr7VCQEblmidmpYauO0kObjoIgRFUpATtWF+wYfIa/B1ZsybSKZ5fWXJvG00rQ64xHy88JKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715204; c=relaxed/simple;
	bh=wn6CkkXpnyurnbGqUnAdE4aoeUL0qIiZtdPOAlMzK9A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PU55usYHJDscOgdPOcNArziRXOBHefcoXx9J3CAivSNFOJW0Xt3mrQrofsCrZEMSalkYPb6jN+DoGzFh2jJqz5Zu1TcwywkVx9w6ukQK/dkhymMneahfk2WZqkCnFdNXoGnBnBhQzj/rr4btPqWYpUNl/hwogZ47NVCuIfFxhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbtat7R8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbtat7R8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27071F000E9;
	Fri, 14 Aug 2026 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715202;
	bh=0lI4BJsPwNoANbxP5sP4n5OooZzqSIHTxgvK854xOGI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Nbtat7R8sBoVe6PIYSJr4JE57cGCyOc6YP8uTVN/uS/z28icnhuA9MRnydzGhOUMg
	 4D69/AC/wfEil9MFmVyr5Urs54BsR+Bze/XpYKvrQgTqPPnPOZacBEXvJ9J3ZdzfxP
	 PYveAAbj+8Yeh4xfvGjFVtWOrKDaircae6hAsNKOUSt8euiAoHQXAZkLXI03428uds
	 zFpP8mJZipqoUFuY2BBE1JWeIMhLjmKTYen1VG3aiqA0LArETxQBT9cw55mIYGCRf6
	 duUPMJ4+1EzbzqzsC+xGPthSIQufdh1Z+RSaTr5vE5nP+YvHHdcWRaDyLd5NUVoJfX
	 sIOFHn5+d7zpg==
Content-Type: multipart/mixed; boundary="===============5107549409603761656=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <64d0032d093c0b2ef48dfc68ab6525ff6a10b95852e3b21a34c87d8185679e9f@mail.kernel.org>
In-Reply-To: <tencent_2EB11B9074207E825BE3ACC0AF1F09DE0108@qq.com>
References: <tencent_2EB11B9074207E825BE3ACC0AF1F09DE0108@qq.com>
Subject: Re: [PATCH bpf] bpf: Enforce cgroup storage map consistency for freplace attach
From: bot+bpf-ci@kernel.org
To: 3472274613@qq.com,ast@kernel.org,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,jolsa@kernel.org,zhuyifei@google.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,corvus@tencent.com,henrymei@tencent.com,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 13:46:41 +0000 (UTC)

--===============5107549409603761656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The prog-array path already enforces that programs sharing a
> runtime storage context reference identical storage maps (via the
> owner cookie matching added in commit abad3d0bad72 ("bpf: Fix oob
> access in cgroup local storage")), but the freplace path performs
> no such consistency check in bpf_freplace_check_tgt_prog(). An
> extension whose storage map differs from the target's therefore
> operates on a buffer whose layout does not match its verified
> bounds.
>
> Reject the freplace attach with -EINVAL when the extension and the
> target program reference mismatched cgroup storage maps.

The changelog describes the check as enforcing "identical storage maps"
(matching the prog-array path's owner cookie comparison), but the code
compares only value_size:

    if (prog_map && (!tgt_map || prog_map->value_size != tgt_map->value_size))
            return -EINVAL;

Two different cgroup storage maps with equal value_size are accepted.
The precedent cited, __bpf_prog_map_compatible() in kernel/bpf/core.c,
matches map identity via map->owner->storage_cookie[i], not size.

The value_size comparison is correct and sufficient for preventing the
out-of-bounds access (bpf_get_local_storage() returns storage sized from
the owning map's value_size, while the verifier bounds the extension by
its own map's value_size), so this isn't a memory-safety gap.

With equal value_size the extension still operates on the target's
storage, e.g. an extension whose map lacks BPF_F_RDONLY_PROG can write
into a target storage map created with BPF_F_RDONLY_PROG
(LOCAL_STORAGE_CREATE_FLAG_MASK includes BPF_F_ACCESS_MASK in
kernel/bpf/local_storage.c), and value layouts may differ (BPF_SPIN_LOCK
is permitted for BPF_MAP_TYPE_CGROUP_STORAGE per kernel/bpf/syscall.c).

Should the check be tightened to map identity (matching the cited
commit), or should the changelog be reworded to say the check only
rejects value_size mismatches?

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 1a721fc4bef5..3743f6c25e2c 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -821,6 +823,20 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
>  		return -EBUSY;
>
>  	aux->is_extended = true;
> +
> +	/* At runtime the extension program inherits the target program's
> +	 * cgroup storage context (via prog_item->cgroup_storage), while the
> +	 * verifier bounds its accesses by its own map's value_size. A
> +	 * value_size mismatch leads to slab out-of-bounds access.
> +	 */

This isn't a bug, but the comment formatting differs from the BPF
subsystem style. Under kernel/bpf/, multi-line comments place the
opening /* on its own line:

    /*
     * At runtime the extension program inherits the target program's
     * ...
     */

The pre-existing comment just above (around the function start) uses the
same style as the new comment, so this may be intentional consistency
with the file.

> +	for_each_cgroup_storage_type(i) {
> +		struct bpf_map *tgt_map = tgt_prog->aux->cgroup_storage[i];
> +		struct bpf_map *prog_map = prog->aux->cgroup_storage[i];
> +
> +		if (prog_map && (!tgt_map || prog_map->value_size != tgt_map->value_size))
> +			return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31804018762
--===============5107549409603761656==--
