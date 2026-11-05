Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914731;
	b=3d2cRph7kaEu5+lAU4Dz7a34+bmkx9nW7Vfo8uFidw/ZQRAwL0XH33Ek3uqXRfnM44Ri
	 7HnHmAnc9xo3n43mfUzKHvdK8oZVYF92+ppC5dYa8UWOK1D5h2NJi99VvMpfxjpEPUAPa
	 9uBojdmIb2BmCft1EH7TlaWhBgDf/mxxw1mad3iqeYEUW83QCw+wicIOMTB0JnuA9koLL
	 L2RsY5rhf6s5xhpfukAyp+ff3rUkL4QZZKo6HMOsLq8QNETs7Kpc0qX1KAGfqdhkEFo1t
	 WEtEQGtbyaSgK5EbVDRpjhJ2ltujl0SiYzRxdAzHCxoFh21GdTyzsLVH0+SuyVECeIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914731;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=h0r+2HII2Bw3x8GbS9DCIhnhso5iPGJPaQEPn7qxf4Y=;
	b=aR+lBmlfIqv/iTcw0sKVvhfCSfaQXNdXAs/U6Jsjzyq6urKkFdshtAE/NHRiz5z0p5PB
	 4qSJY9kUzmdMBKSzxJF0V9qUCYXV35kX6H6h3THH4FXlxRqYjTgJfR7E4RCOJvjH0G6RF
	 MGtQUU3bM5MVIo028vemaqcu+dMM8Fj8SIOOIjdmcdUDDdZO5scRnz9193qz3RLH6gQMs
	 kGhGBJsQTNvCE1bgY/sdv19HnlL3LuOTZR6ibE5feKWyJR6Kz3sAECe+4XTxkIq4AwLyA
	 06dbsoaB/VmQPZP8TDu20NbllFnMBnxW5ceKwjQ8YbKOLIHaWgiafraKs2CTZL7B7kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsjGOjYf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1971606A33B;
	Thu,  5 Nov 2026 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsjGOjYf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373001F008A1;
	Thu,  5 Nov 2026 21:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914730;
	bh=h0r+2HII2Bw3x8GbS9DCIhnhso5iPGJPaQEPn7qxf4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lsjGOjYfF/x2gLEaNqAXt/2kxNgPVUg88bJPuvfotirBcHI12sxLMDFw6z5lYmyps
	 v5YLGHXYB2ye7WWW3qlkFuxK6MqAsuf7r0XkBc8wzT+tk28O3bpZOHXMXMFYIupb/7
	 W0Q1j7GIKo/2Jxz/WDVTy7tLC+G/oR2jYYPHQmvSbACdwe3GGgujnpm6jgBjtVK+Kq
	 laX6QlbwjPHpmo4vLsA0R30tp693GyEwVKE7ddQD7QdycXgxJiCXhjKfyLnoNiA+Rw
	 eMaEzZVsemBaK4Nsp9OyqCTOpyIz6YaLyUvlwu9SpbqkFPu7hdt7SH3s3KDftGHcpS
	 FJ1+PxX5QtrYw==
From: Christian Brauner <brauner@kernel.org>
To: Russell King <rmk+kernel@armlinux.org.uk>, 
 HyeongJun An <sammiee5311@gmail.com>
Cc: Hyungjung Joo <jhj140711@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260715115231.1585166-1-sammiee5311@gmail.com>
References: <20260715115231.1585166-1-sammiee5311@gmail.com>
Subject: Re: [PATCH] fs/adfs: bound directory entry name length in
 adfs_fplus_getnext()
Message-Id: <20261105-maschinen-freibad-abriss-1bf38bc75111@brauner>
Date: Thu, 05 Nov 2026 22:38:47 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Wed, 15 Jul 2026 20:52:31 +0900, HyeongJun An wrote:
> adfs_fplus_getnext() reads the per-entry name length bigdirobnamelen
> straight from the on-disk big directory and passes it to
> adfs_dir_copyfrom() as the copy length into obj->name[], a fixed
> ADFS_MAX_NAME_LEN (260) byte buffer.  adfs_dir_copyfrom() only bounds
> the copy against the number of directory buffers, not the size of the
> destination, so a crafted image with bigdirobnamelen larger than the
> buffer overflows the stack-allocated object_info::name that
> adfs_fplus_iterate() passes in.
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

[1/1] fs/adfs: bound directory entry name length in adfs_fplus_getnext()
      https://git.kernel.org/vfs/vfs/c/8b41fb1fc25d

