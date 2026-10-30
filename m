Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377130;
	b=fGKN0I/5UR67xHlfWV0XkZ2Z9qCWYwi6iCVHJ9nn+O+XIsenkiM4hyhwZj8dQkPXttXk
	 hNlWS+sApfyVDSAMShtMT2rvKT3ZMrb80iMH1aT480gtbWqSAN7v0LIp36MrR/DqEsN9+
	 kIthIoKLSMGjHYpp79785fdF4M2noUrm1+3HW0AraIeHTVT99UQ9OIjMWnEuvNCkqfuyb
	 JxFLnV7mjpo3qZ+gSZQjQJyZyVIG/w9Pb80M9HJ1w0p2Wqt5iyU8Ey4wHdGeMOdZ6SWPc
	 iYLanBwszhonqtXngeEgPu6OxjTmYAac8nFvlLA2clY/sD6L1PFghz1PCFNZ/UPSCpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377130;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=QiunOZWJx+P+5gQcCuYIS7lFeRX3edP9D5k4etkLsa0=;
	b=ar6FrKNYx+V0EwQFXyrGFYBulE62BRZ7dT3XL0jNf2Mp2zhXG3RSxZQ2d1tLUoWvGF8c
	 Z3+ouWcEBOyCLdjQ2a7C0utCIt3KuAn+gNnfVMpR1stPm+dYI3UVulhAuvP4Evcq4c3mG
	 NO2J8WSYLayrGg1A9oyPGybYizEjS5dGxlYJIf+cMO+PAerTZMyNt3npuz91FgIORghyg
	 sfWjYsDCnpDwuh5wG0ywaMtoDhCP8S2ydDGFpfD7ns+8Vrhzmyq5cclqDQqzyqf02fFol
	 oHW2apSYj7+rSmnRotxu5Weu++ReREsyyYb5g+RHHmxdFXBdJfaaN9R0IS0NT1akB2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hK3vCiYx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2021606A324;
	Fri, 30 Oct 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hK3vCiYx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB561F00A15;
	Fri, 30 Oct 2026 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793377129;
	bh=QiunOZWJx+P+5gQcCuYIS7lFeRX3edP9D5k4etkLsa0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hK3vCiYxVd5d68ZX+j4+jmqrQO++VKvRotjb4ascRXLOIkjCsAsmVGzml20dOJ2L5
	 21NqVJoTn0/c86x1Ah8Di4xbpagHabKkfEofhe20JZBYDh1FlvZDAE7Fq0KWq8oWWg
	 wwz9gy0/RWSLtud5i1zkky6bAx7N/PavtuDi418bY6pkt6cWi8+DpTf1Cb+TYMWxBs
	 J3P95pTvQqZv2KJOZBiwwMPP4WLBZo7rJE49cVI7oNO3XUUP4z+NMXcYEsJaUi4PAB
	 neCWv71XjQNjvbndWPXK2spv4TF4QFIMipttVGK7aaOZeOPbAZq1q/fojM7mS5DMpB
	 uo7T5N71bXzWg==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Daehyeon Ko <4ncienth@gmail.com>
In-Reply-To: <20261030-work-dcache-obtain_alias-v1-1-a1f7e44536d2@kernel.org>
References: <20261030-work-dcache-obtain_alias-v1-1-a1f7e44536d2@kernel.org>
Subject: Re: [PATCH] fs: don't fail __d_obtain_alias() for unlinked inodes
Message-Id: <20261030-senkrecht-nahmen-bewahren-1c6cba73eb7a@brauner>
Date: Fri, 30 Oct 2026 17:18:46 +0100
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

On Fri, 30 Oct 2026 16:55:52 +0100, Christian Brauner wrote:
> Commit 669bb5af15d4 ("fs: make sure to call fsnotify_inoderemove() only
> once when inode is dead") did two things. It made dentry_unlink_inode()
> call fsnotify_inoderemove() only once the inode has neither links nor
> aliases left. And it made __d_obtain_alias() fail with -ESTALE for an
> inode in that state so that open_by_handle_at() can't create a new alias
> after FS_DELETE_SELF has been reported and the inode marks are gone.
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

[1/1] fs: don't fail __d_obtain_alias() for unlinked inodes
      https://git.kernel.org/vfs/vfs/c/a522dd871024

