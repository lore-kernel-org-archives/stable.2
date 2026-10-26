Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021793;
	b=lClPhfH1a1pvP9moc/OmUnqFddu6maw6YhUYj8OEEfOvajNpWJQK5P2UstspHMLYVLd9
	 fKV6U4igeRJ2Ihvgfaum5wbDyspNMMA6Ybf74Wa8OTOqevKlzgTi9/ZzAuNo0riHlUCnw
	 c9NatIJE5aAg+Xy4tijXrgVqWkkGyaNt0QurVlH2mvD5iiY4VEVYbQS1vQ6qEWCMNvQX3
	 6j6Yg0gA0lK4Q74qvIBtOo2NCd+OsMqkZLrj2SZRQJb/7mB8nNGbQbYRDBN5G+ZyRKOyA
	 O4XwXJk286O6noEvQ60xOuWgY3AAB6zjLqgzn9Gisrjxqf1I2THeE3H3seQCMmFlK/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021793;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TLbxcjc9HC/bzrb00HtQdr6XFdlMjDXglTQf+OuewPw=;
	b=nO807PRkicIEn5eFOnZELhzbOVSjLg6s1rqaDq+l8/pO56oDvQ57hMPhRp+wWErTxYR7
	 m53bBXE7GaOQbKAb/HSQztBJ1EZArgPQOC9fii+VF9mSiodU167dR5Je1MvIPj2yQuph9
	 5Jx4A5v3UKlmSIXF+PvJhNm2XgQTCpsCr195i/QzOYFKSu7KUyroown8By0TA/3i4ckrn
	 7ulw2wlL4k36WyIybSaVeulxHd7uMhwYN8/nPPumNBlvgIbE3ZgepOXOZwznT4tVVBKGN
	 ryPK+KxfTLhA93V+xzYkoeNqSRKjMWWmaUjV/XQ+RMGhrZUkt+FockUMGZm/Z2KGXWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZTPUJtW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05E606A31A;
	Mon, 26 Oct 2026 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZTPUJtW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E731F01829;
	Mon, 26 Oct 2026 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021793;
	bh=TLbxcjc9HC/bzrb00HtQdr6XFdlMjDXglTQf+OuewPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XZTPUJtWABGcedlMro6yimEbn8xlo60A7Qc8l4MW5KsLnAVkqewN+JtiFH+BZNwHa
	 UF8FcEhomFiGAdDhmZ5KthOuCUwLNV7Gt4Tspz2lRzEdjnin1HAk1sN174Cg9GQoii
	 sqLcXtUONkz34uYcdGsBIaDM85pd7zUPdu/+fUHh1iRWA9OKXaoewsV28FWBd/lUV0
	 VHaFgYlLzQHlGRJq7i4PwjV+c9lFxajsapWunv9GPOqVRrbLUYg64wg/lVlx6rco8j
	 uAufYyaGQeWolhc48Sa6TqTzwIr/pioMvBItowZ0vXtudAu5+DQDwz9DTCqxNRalti
	 /Rev7H41aedTg==
Date: Mon, 26 Oct 2026 14:36:29 +0100
From: Andrey Albershteyn <aalbersh@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fsverity: Explicitly require FMODE_READ to retrieve
 hashes
Message-ID: <at9WRK2L4GtBjo2v@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261022211522.1489943-1-ebiggers@kernel.org>
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
In-Reply-To: <20261022211522.1489943-1-ebiggers@kernel.org>

On 2026-10-22 21:15:22, Eric Biggers wrote:
> The comment in fsverity_ioctl_read_metadata(), which justifies not
> checking for FMODE_READ, doesn't consider that the nonstandard access
> mode 3 (ioctl-only) exists.
> 
> Opening an ioctl-only fd generally requires read (and write) permission.
> However, there are gaps with certain LSMs: an ioctl-only fd requests
> read (and write) permission via security_inode_permission, but not
> security_file_open.  With certain LSMs relying on the latter, such as
> Landlock and AppArmor, an ioctl-only fd can be opened without the LSM
> granting read (and write) permission.
> 
> Since FS_IOC_READ_VERITY_METADATA returns hashes of file contents
> blocks, it should require read permission.  This also applies to
> FS_IOC_MEASURE_VERITY, which returns a hash for the whole file.
> 
> Meanwhile, ioctl-only fds are a rarely-used feature, not known to be
> used with either ioctl.
> 
> Therefore, just disallow these ioctls on ioctl-only file descriptors,
> similar to what was already done with FS_IOC_ENABLE_VERITY.
> 
> More specifically, explicitly check for FMODE_READ.  This also covers
> write-only fds to non-verity files which otherwise would have failed
> with ENODATA.  This change in error code for write-only fds should be
> fine too, as these ioctls cannot be usefully used with write-only fds
> anyway, but it's worth noting as another technicality.
> 
> Fixes: 4dd893d832cf ("fs-verity: implement FS_IOC_MEASURE_VERITY ioctl")
> Fixes: e17fe6579de0 ("fs-verity: add FS_IOC_READ_VERITY_METADATA ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Looks good too
Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>

-- 
- Andrey
