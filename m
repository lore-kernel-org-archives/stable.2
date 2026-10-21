Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583803;
	b=FDOZc1gbvX6GokQ9Z3GYua5siyahI4u/hDKDRClRJUyb6K3KJ5D3gZ7hpsjsqbpmxVE7
	 M8g6UzCRki3X1/byAtemeCoW3anplPBbQxRD0mGYGzzAcwxDfrES0D5jkGIQwLYOFr1og
	 IMehWaHG9PtzmYoMuRPmkX+iemUHYcoa/ZvmoMaKw+tDdEeTbDL1wSpuBfY9kRODYsSOh
	 euCcXuXnZlky2nJfjW7pZzf3+M2FsHIDBj2jGx3enmFHezE3Rc1NaGu1kq8OmNlILchF2
	 0muNxtdX/XLpEbos3qmyDD5p5e0lSDL96pmduz0Am6CQ8I0aMgnTSwWO9ttomDoEKLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583803;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=057g4fkzojSmZ2w31SqHnYt6IBK9egcTQ3a1+8LQlYo=;
	b=Jfi4uSlgzmM38uU8V6NlIs67Vn6XeFPEGalivXBtxUtscOaWvl0rABt8tBZp4tVzEDWr
	 qvSkr6POi+CMZs6Qe9swgZY8SrqDylnA8hZNRWMz6177B0Af0xaMg6guvi4bxZTNRTSnX
	 P3FRL6UbrWm1yISX4C9RRJXUNQVvMuIFp5bYXC153LXoMIOGs44CC8tMzSE0Hpp+8mdqb
	 +LJ4orDpSu4StNq++wODlFk0Pq6QLwxXmXjFHe6678emeQWc98dXcGCU/IFCQeq4TViFd
	 OlYSGyql1eRUHpJ1UddFpI6zRgntkGEd1/cI5W/5r9vwBwpyz1wq8nsrQSzAG5V5/kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ydt/0mHF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789A606A319;
	Wed, 21 Oct 2026 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ydt/0mHF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D9A1F000C5;
	Wed, 21 Oct 2026 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583802;
	bh=057g4fkzojSmZ2w31SqHnYt6IBK9egcTQ3a1+8LQlYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ydt/0mHFXuuUnlKg0e53miPmv4SeXWaNYLSgFQtRU1iEp6v77etS6tX50CNHzM7/0
	 ycIWfMsq+WE80qO/zFUnz1li+LWFKjZu0UXLNcYy/0PzpJmYpOuMMjX1oV2kzquHU9
	 RdoF2dOIlk8t57tUH49Eb72f7nw1PIcXa4mWBkZ2+BLalv2OgrhU5F8vYEXOjLaEOl
	 IFUfii0crzTjXdybBqa1WOlzaY3YX1AZTdZYxEN4iAWn9vOBtoSPyNQd75Smr9EfXD
	 iUZaWC2RhSRlQLeC5FX/i6AZazZ/86HiK00WyB6+gSPLgw35nitBYu8hz0k7v1jnqL
	 G6/LsoVK6jAkg==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Nikolaos Karaolidis <nick@karaolidis.com>
Cc: Jan Kara <jack@suse.cz>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261009142431.713875-1-nick@karaolidis.com>
References: <20261009142431.713875-1-nick@karaolidis.com>
Subject: Re: [PATCH] fs: don't lose inodes that another LRU walker is
 isolating
Message-Id: <20261021-lesbar-rosig-immer-78a7ce2261ab@brauner>
Date: Wed, 21 Oct 2026 13:56:36 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Y/iaCQhSTOToIAabGiKICrDvPJx2LEbcHo4TbLPi6hU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWFGmptdVkBRQNFGq68ULPZVcA/sY3rAps16F12+Vq
 zptU1bZUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHGVIY/HAKvud5tqbwg8P+/
 QlLB9U+lhXFG9/RnJpw+l+lfahHgwsjQ6/njyO9jYnsbN2dPuTkvaf4SdqXZX27+1tsRLDj7tfZ
 9ZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 09 Oct 2026 14:24:31 +0000, Nikolaos Karaolidis wrote:
> fs: don't lose inodes that another LRU walker is isolating

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

[1/1] fs: don't lose inodes that another LRU walker is isolating
      https://git.kernel.org/vfs/vfs/c/3f54961ad92a

