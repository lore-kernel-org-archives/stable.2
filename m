Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588726;
	b=KPDwM/+qhVIVhRAA+C/T/BniMfOniH6d4SX5T//E20oGbI85+rWFbxmvtAZt3jf1cw5f
	 8nETkV0uxpK1b+Ke0kzU97wVCo6Yngs4aUqU3Z9mKqckaAx+5OgF5vPqug60pxH5Cpk+H
	 p5dBaZHo1GPEiWbk8Fgx5gAXiNbdnjjmEytOXUAETwGnnKXRY/71Hq9hS7W0i3jVyZV+q
	 YtKTqMUnqhdNhyxUmw2OzFIMCTYwBwpV7qWe7rw7/S13hpbJEhYeGVC6D8HNvetLxnNJp
	 +eNfjDRQ/nyazQrLwZXBId6NqZa1ULzY9dQyUZ31Pybz2/jRcFAfZxtQoL2qwBrLM9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588726;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=XrLsm8yNe15oQtyztYgnund0Iae4jM4PKuJX/0+Hjf4=;
	b=ZZXDRJEoYsPugQczgyL/UrVD5Ohzrtf0yDY+J7pNuvWFCCIXThluE6CTq1rpKnqfExxe
	 hBd6Hq/8ZGeqjQwRpjESAdwa03ilDTYhq0zHwpvYXsrLQcShkOHlbq3IwtHIK7E9x+ALm
	 hG6Ew+1aJPREtZk0wFetjVNIrRplxRNEzbuazxmfekc9FiNnCfcyI+Z44rgEjW/H2ikTE
	 k8rHC+lB/sA+mozhpV/baFur0+n926gbZtja4pE7hIUZAgXejrVUeF7fQzwrQD9wybwaF
	 Mw5DjrMDeedLUA8xjKO4aUnDgheVx0cQBt8/m0dEnYQGO2+Dwyw2vQGhhxVmQL+MVHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqgYjlJJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC1606A319;
	Wed, 21 Oct 2026 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqgYjlJJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1E41F000C6;
	Wed, 21 Oct 2026 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588726;
	bh=XrLsm8yNe15oQtyztYgnund0Iae4jM4PKuJX/0+Hjf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KqgYjlJJPL7TvmfwLOYlBdju8BPi9bVa6f4P0ubTSSA/NHVIeDiyH2aUDl/0SO6oP
	 aKiNzp9Erq16obrCttp3hCpL/NlxuHOzXmV3zKtcNjqxJYK4BqyJhziO0Xw+Gflm3W
	 yqU1OR9IHO5vsHGBOkfU2Wk++lC9MVfF0ltYTXjrmMDpbqJ6dM8iwfPN7YX8OugZl8
	 1vis5a/JPEVM+odE9CUpsSR9EZBWqRPdSANxxxz/ss8eBgcJORUd2DU3Yxkjgc7iKA
	 XbaaGzwREVATwNvg0O/LWJiS4TeadkdDjv8NqAgggY9u5c4CdW+Xg6SOiItrqw8+5r
	 Agw1aKNfPXPuA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
Subject: Re: [PATCH 0/6] fs: fixes for statmount() short buffers and
 listmount()/listns() cursors
Message-Id: <20261021-pfosten-gentherapie-einladen-8b2af28a086c@brauner>
Date: Wed, 21 Oct 2026 15:18:41 +0200
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

On Wed, 21 Oct 2026 13:46:53 +0200, Christian Brauner wrote:
> shaos reported two issues in [1] and [2]. Both are real.
> 
> - statmount() reserves the empty string in the seq buffer before a
>   handler runs but the early return for "nothing emitted" never checks
>   that byte against the caller's buffer. So ask for STATMOUNT_MNT_UIDMAP
>   on a mount that isn't idmapped with a buffer smaller than struct
>   statmount and we write one zero byte past the buffer. It's the
>   caller's own memory but that's still not ok. I'm fixing this in
>   prepare_kstatmount() where the exact-size check already lives so that
>   unset strings keep pointing at an empty string.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/6] statmount: don't copy the reserved empty string past the buffer
      https://git.kernel.org/vfs/vfs/c/6410ba49924f
[2/6] selftests/filesystems: check short buffers for statmount() strings
      https://git.kernel.org/vfs/vfs/c/4620c3aa7259
[3/6] listmount: don't wrap around with a U64_MAX cursor
      https://git.kernel.org/vfs/vfs/c/db1ad1eac126
[4/6] selftests/filesystems: check listmount() with a U64_MAX cursor
      https://git.kernel.org/vfs/vfs/c/7d9ebfa4e4fc
[5/6] listns: don't wrap around with a U64_MAX cursor
      https://git.kernel.org/vfs/vfs/c/f98c8e0d1536
[6/6] selftests/namespaces: check listns() with a U64_MAX cursor
      https://git.kernel.org/vfs/vfs/c/21f54bd8da86

