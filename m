Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010025;
	b=A3mkj05RFyA2AY+BifJkZQrKTz7PMi9GOqpOaYhw7XOPUJhrOAvqk8ZhiDp4w+k8BLYA
	 HIU3+K9p1XYXyCh0B5NAtToUA9bKhvrkAztKhIk0zdW2wmcZk4/5rtGfbpHYkA4geHr7C
	 D5xmYGIVS3OTFcSnilqmHZ3IzUOwqE6A4eN+5v778Rxp57WrC3+2EpXRoFsrdL/YyOKOn
	 sDZ56kHHAzUTFmFpQOQJGJJUHVhtH+JGV44vhkTGjtAs4lWBo1xBeEaZDvXGH64tCywg/
	 C9ntpJj5clp3Obh7RNfeEYhUy2mQpkAahq02I9WqBLwSivRCjven1TOfg0C6I35SkGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010025;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=o7ezIVkxIIxFbHXUirO8U2Ygr063EQw7nBDsOC0esC0=;
	b=r74Y1MAVhgnO6jnmjwqkDLda+BxLZANCeTtJSXn9miMqNZauQAtIVmvfC7H8IWSt8WJ7
	 avu7Dm54lPbHzubkaxCSiJrzYQPK6I2b2f97d1MPZJFw5AqXmdxnPCihildVLwZgxMguK
	 Gy3V5/vNSa8iR5wNtm6PtrIO/Wk60pfXN3agjh0UPFwbFwuDj/UrPQU05GfJO5D/uQ5nR
	 A8FSzMSF333ypOByAV8Xn4AFM4WeQq3GogFnlNmjMfVNq5mggxXr2VhWMO9VJRvXMmLUj
	 9dxXKtyhPHd1hw0PxAa15VoPtKUM8fQJSd0P7CKhXlBVHKFR1DV3jIzpmsYx/ldP76Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbjdYjGY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D1606A31C;
	Wed, 18 Nov 2026 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbjdYjGY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE4F1F000C4;
	Wed, 18 Nov 2026 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795010024;
	bh=o7ezIVkxIIxFbHXUirO8U2Ygr063EQw7nBDsOC0esC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kbjdYjGYGCUs/NY8KUlPldKhJc9WsOzqbeGHCR4GYlOPfDSC63VCBtUCzZ3bHqQNS
	 0ARjlrzTQn8ZTSG2f1hLrgibvH9cK9D077B9LsZG0BOFphRHWkzi/YOH/f50Mu7oP3
	 tmGHcexqqrywHgm8PPCXOTBcV1G2YgYDCnY/OxOvKS+swJ3DXlWgcbIljadkUeKYgK
	 Bp248gi4PrywoGVGPfVvPzsTVADZfn5fVbhmeWrlw3d/64GL4gu+HgNzDgoPdh53iv
	 7Lga8h2Ou1VfdqQu4duKWr+Hqr8zWQpD38ZHL15CCQs7yaJ7JFbayCHPqVMCqZW20Q
	 lwaxUQZymGt9Q==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Ding Feng <dingf3ng@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlemoal@kernel.org, naohiro.aota@wdc.com, 
 jth@kernel.org, Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>, 
 stable@vger.kernel.org
In-Reply-To: <20261117173129.61028-2-dingf3ng@gmail.com>
References: <20261117173129.61028-2-dingf3ng@gmail.com>
Subject: Re: (subset) [PATCH 1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX
 in generic_write_check_limits()
Message-Id: <20261118-erzwang-einwand-kanzlei-a8960dafbd19@brauner>
Date: Wed, 18 Nov 2026 14:53:40 +0100
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
X-Mailer: b4 0.17-dev-04696

On Wed, 18 Nov 2026 01:31:28 +0800, Ding Feng wrote:
> generic_write_check_limits() stores rlimit(RLIMIT_FSIZE), an unsigned
> long, in a loff_t. A soft limit between 2^63 and RLIM_INFINITY becomes
> negative there, so "pos >= limit" holds for every position: each write
> through generic_write_checks() or copy_file_range() fails with -EFBIG
> and raises SIGXFSZ, although no file position can reach such a limit.
> 
> Reproducer (bash counts ulimit -f in 1024-byte blocks, so 2^53 blocks
> is 2^63 bytes):
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX in generic_write_check_limits()
      https://git.kernel.org/vfs/vfs/c/bc0dc4379463

