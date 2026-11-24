Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524094;
	b=3VGEyxapLPcH4G29eXKh+H33nM3smKXsNmvVL36A/BzetlQc8MzT6Td8lQhXUfPUWU3S
	 RXQxeYFWHibkR894zuTsmd2ZLTCBIsGKfsdZ1tL47GEh6iNHgecfgizxVYmA1DaDe9fgb
	 /a1EDRI+jA85rewT2ZqvUasTHZATBC2gtTx4YgyJXqgdUwIgXmZ9htlq90GR9zzkNho6p
	 s8Qkjt4qeVEwSdYvxT0H0XooGchAOVpSpnXFSvUUJdvpC+adH31d0M23w6E4/LqVq91RP
	 LiVrvmBPZ5GAb8ohviVCBDGyj6kCzvLh+DgdGgOXtiK+OiPDkfsqj/dJXVeKoen1r/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524094;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=AXISzIl2GmdrgiGiNCrKwwMWhjga6IdbyVL6t7e5v3Q=;
	b=ghX4LvX/KxYvxcMfB4PLvPGDUdmnOsEgiPHcSL3CQ0wXaTvhPyUGCMdQx3O+vRcPA1PZ
	 a5UmqtGaHeVh+i9vrZvmKyELU3Wjt9O37Dy0jWVXYp25v6b+o8NjsuQmvZJWkA+P4CnDX
	 KKZx9sBIy50mMOBwfc79sER3X7iThpGmRcHYHcgq8fssKBsm7gPtWgdDG1+hPmzzKBOBh
	 2HQmpKZ8XsG0xElurB2kp/ZOh+alq+z5O5BK3EBQZilIpX+caglt+HLY2zIanJgg0gq7i
	 ZSVdrr4CGreDSxEzRIfo4reP0NUYCD2WdzziK8w3PiNRFVAwX8g2NfpQDIfYsYnfQVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Iacf0nFz;
	arc=none smtp.remote-ip=109.224.244.25
Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD615606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD615606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Iacf0nFz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795524091; x=1795783291;
	bh=AXISzIl2GmdrgiGiNCrKwwMWhjga6IdbyVL6t7e5v3Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Iacf0nFzacgSAMU0Da/ajlV1EAEgzHG8ARPTDPdDf7ghexVQaBNkmvqktpWycGoFf
	 0f6xrJDcA73vBvVACjdUKHe5FxqzFJvqo0V4x2GvNq0ZFvfMGFRNwN2Fu2lotrJaKD
	 n9g3uiPuadkIwLDZGOhTXrNIg064QG+xGmwmT0Hr8HXBGNqRyQWNoubQ89WW/BINea
	 0qE+gGHFLxkRxpQwfmPNCBCoWDsh63kUq1iQqxjETq1wey5qTpH2qU2DnpD8HOxFjV
	 iHn+l6JxkgxMHPRtOAR2F12xX0DQ0TC+xZ5xceUlhOR7+tU5+kDR91FXJtPTsQ6d7o
	 wXD4GY77tdUoA==
Date: Tue, 24 Nov 2026 12:41:26 +0000
To: Hyunchul Lee <hyc.lee@gmail.com>
From: Ernest Borowski <ernest.borowski.git@proton.me>
Cc: ernest.borowski.git@proton.me, Namjae Jeon <linkinjeon@kernel.org>, Baolin Liu <liubaolin12138@163.com>, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6/7] ntfs: zero new delalloc clusters even when writeback allocates them
Message-ID: <179552408028.2458487.7065441678711617197.b4-reply@b4>
In-Reply-To: <awPUQP3VxjqgW9Lf@hyunchul-PC02>
References: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me> <20261122-b4-ntfs-delalloc-fixes-v1-6-0726f0dce403@proton.me> <awPUQP3VxjqgW9Lf@hyunchul-PC02>
Feedback-ID: 236360163:user:proton
X-Pm-Message-ID: b499bba2639c34d5bee5f32abf88e83afe610d0b
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 02:50:56PM +0900, Hyunchul Lee wrote:
> Could the buffered-write iomap become stale after this unlock but before
> the data is copied?
>
> For example, suppose a buffered write obtains an IOMAP_DEALLOC mapping
> for a hole. After the unlock, a mmap write can allocate the cluster
> and write another byte in the same block. If that foilo is written back
> and reclaimed before the buffered write resumes, the buffered write
> still uses its old IOMAP_DEALLOC iomap. __iomap_write_begin() can zero
> the rest of the block instead of reading the mmap data from disk.

Yes, it can.  This is pre-existing: on ntfs-next, buffered writes take
no lock against page faults, and the ntfs_iomap_valid() removed by this
patch only guarded the zeroing in ->iomap_begin(), not the copy.

I wrote a reproducer for your sequence.  The copy blocks on a
userfaultfd page before the write's second folio.  While it is blocked,
the test stores a byte through a shared mapping into the block where the
write ends, runs sync_file_range() (which does not wait for the inode
lock), drops the page with POSIX_FADV_DONTNEED, and resumes the copy.
The byte reads back as zero on ntfs-next and with v1, and is kept with
the v2 fixes.  This holds in all 16 cases (512 B, 4 KiB, 16 KiB and
64 KiB clusters; files initialized to their end or not; Ubuntu 26.04
and Arch Linux):

  ntfs-next:                 https://github.com/xerrni/linux-ntfs/actions/r=
uns/45292350658
  ntfs-next + v1:            https://github.com/xerrni/linux-ntfs/actions/r=
uns/45292355094
  ntfs-next + v1 + v2 fixes: https://github.com/xerrni/linux-ntfs/actions/r=
uns/45292359194

Reproducer: tests/stale_write_mapping.sh (with stale_write_mapping.c) in
https://github.com/xerrni/linux-ntfs.

v2 adds a ->iomap_valid() check for the delalloc mapping of a buffered
write.  ntfs_attr_map_cluster() bumps a per-inode sequence count when it
allocates clusters, and the mapping records that count.  If the count
has changed, the mapping is stale unless all of its clusters are still
delalloc.  A stale mapping is handled like a short write: ->iomap_end()
releases the clean delalloc clusters the write did not reach and, if
the cluster where it stopped is still delalloc, zeroes the rest of that
cluster where it is not cached and dirties it where it is, as for any
short copy.  The remaining range is then mapped again.  It is now
allocated, so __iomap_write_begin() reads the block.

Thanks,
Ernest

