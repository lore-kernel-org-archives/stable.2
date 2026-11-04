Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753392;
	b=l0uzHI2npJnRRBCpqbfviDSMHT3bmE9lB+PZEyELcpDlbFobQtXNIrNQ6YH+EPycjmhK
	 MqTCV/LIT4lRiBnQ9Ea+ujVkgPUtYNZMlr8a64Sf5T3UZg4ve/NlZ/rx7jIYCnaOjrLzy
	 o39eOkxgXvamgwU8IumAYfSl0hIAWyWNCii+K/LoCnp0+ofnscxlasehqq9IgSby7tQJu
	 72rTLS0Xh6QUJHF4O+ajvjVwLg5a+Y0odPzUiHrxf8daxZ2P6bEi8rqxL7zDXTe6kgTay
	 ZsZctsbewc09Ce0BCa5XiKOhf2nQK7fVOkZGEvw494A2sZjrnCjdPXjGEhBqeAhcdrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
	b=diPmu1DxgEd7KENoiCj7I/+/aMc5CS1K0uJE2BLJS2d5Yd1Yj7tlvNTBjA4nqcuJzpgk
	 BKLVDoUIppoGaLJVqW2zJewrHFWy79u90B8I2O7aNOnQo9yn6ihiMk6sDmDiyP+RgophH
	 NQpUFAITc1c/PxkZmWBSDHBtBrz4ZHGGGt6FSUw1OY7uKS8JRTGsK72mbHKNe2CkZCtcN
	 Xz5pFrfSXZnbuoiwTusYEJRHW+k4P9x8sBB6f3+B8D+gXw5qAD2tTt38fY3g+KP0WQlNG
	 fKMhvH/52o17p+wzoHxszrb0WLfL8hC5LkL9LXJoLadbUWTp12l7Ll6fOe9pOOOXtTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT+pUP2N;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32450606A333
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 00:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32450606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT+pUP2N
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89ff475a152so81621b3a.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753391; x=1794358191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
        b=VT+pUP2NwuZcLnfpE6RBehWP9rj7p+v+tKoR/WVHOzz1v7CJgJGu6gqjY1V/YGEdmw
         igNrVOnPTFLv9xvYK2tnZhcPD4jqAzwLjDlQ2iFsJIT0vgZOsXkUB60qRSrv68Heg2+2
         k5XkKmMrKWtBUKDoGvgF6CjyKJx7mmzehyXgiMW8Z51NtcdDEa4LvP5GkI/GPk/JWdX0
         E0pyc83t8pyqA1wDQ4YMhv4IP3UIHbsnnJtT4+s3TyxuI9ePzpN8dD0BzwPhXNBIUBNN
         GS4KAdHBqzLrJ9upnMsWdUfiG2GuZuR+cDGx90+hJalABWpp8S3bPmquj5j2mZuikn7l
         6bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753391; x=1794358191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
        b=fSA2fWzayY2LZ0QQSRvBFtjnw0FuvHNa6IKANr6fd6jqsxASQM5w5xWGGkQIjCg9py
         VGEyKsEFDeeunGPald5aXs87NZNKAjnEAptjCKo4r+wzqFQlnhlCynZ3jvPQPj9Zf9Au
         vIKXF1GCrOhVkczme1/w9fch7wYCgAkwFjSEL8DW18rtnHpm5M4D0UJXPpE7NvSy5TAg
         lVx3Fece/Ypos4nj2alxx3klzuqrZPVAQo1OPv5jlbYyZTJtVVqYmsbH7CaEbRUCtwoC
         41/UdxOUzMMKvii5oKOLaKG87MC5xiX0SQU6BoNHWQHgLdkCPQu6NpLL5CHgsku0F1D1
         CTfQ==
X-Forwarded-Encrypted: i=1; AKwUvBycKxvQIwWe9zKbWPeimgs14zzGoDIrZBeIPlSDbr+n0RPJ7i5SGZ22LNh0+Zc2AFYfY59TvCE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JMZ4XbP5Cgpnv7yz9+pkJwArTf8lTuJIDFrGbDO3qLGQ31qh8
	e5jLrkV36UhMBillo6DPO4oIu61XKh3RuelVp5hXe1oyclVPM3yrZS3v
X-Gm-Gg: AYBFou2IWoqIPiDIq41RioL1StPhihUYYTWSn6bcsYxu60VJsNKzla0iy+mxjUYLtQm
	l94qKq5yIch+IdZkdTZh2j5e+Aw9rw+HRUZYd4MyrFEmVQJJ6VHiA0YCa1B04c87+LndEyVrGEq
	wDhE8WFpgTb2905e+CNG3woh/rHtjIBwuOnAPIgimqWH0JYIyGzpYZeBckEJZ3QopLyD3Al8S4+
	X/BbXTorvX7PmqjAPjwgyLBOSmFx5MN95lc7tpeDSz/hpxzaVPyaaLMc8tcTJeD15AmCTwz76sG
	fD/UgmUPZ2hWJCwUR2HEKxqyJzHHdKWUHo+KicQMrMvNcrPN7UX6cpaRnIOGRcD4bTPymFSa0P1
	pgRcd0ft2HE5R6zEAqDvup0DIwGP6GnUrCAc4jLv/oJEo8VROzVOJRaLOSlQPcoGO8XUx/3y4/5
	wdMh0u/nVc3R13D4+SBYPKdmg7sWbNVE/u2ecyicE6ULD/2fk73xsB9BRa98Sf1vpRKDezxE0Sd
	nt4lxRF+X6kp09buulxZXvqx+1DFp/O/OrBePytgf2D7fE6ZqUvUB6RlJvZAmJn2WzmqaRq8Nt/
	PeEiHVIgPiuAaInM0Bydc2vgTfI7g/UzsxDMwIM=
X-Received: by 2002:a05:6a20:914b:b0:3e2:9470:5303 with SMTP id adf61e73a8af0-3e928953948mr11828504637.15.1793753391239;
        Tue, 03 Nov 2026 16:49:51 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46440cc7sm329325a12.3.2026.11.03.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:49:50 -0800 (PST)
Date: Wed, 4 Nov 2026 09:49:48 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-mm@kvack.org, ntfs@lists.linux.dev,
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 17/34] ntfs: don't set SB_RDONLY after filesystem
 errors
Message-ID: <auqBLEvcurRZfGj6@hyunchul-PC02>
References: <20261029-work-fs-sb_rdonly-v2-0-2f44f64f0b66@kernel.org>
 <20261029-work-fs-sb_rdonly-v2-17-2f44f64f0b66@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261029-work-fs-sb_rdonly-v2-17-2f44f64f0b66@kernel.org>

On Thu, Oct 29, 2026 at 05:07:08PM +0100, Christian Brauner wrote:
> With errors=remount-ro every ntfs_error() ends up in ntfs_handle_error()
> which sets SB_RDONLY without holding s_umount. If that happens while the
> volume is frozen through bdev_freeze() thaw_super() sees a read-only
> superblock and leaves the s_writers rwsems locked so every writer hangs.
> 
> So set NV_Errors and a new NV_EmergencyRO flag instead like ext4 does.
> ntfs_emergency_state() returns EIO after a shutdown and EROFS after an
> error and the write side shutdown checks use it now. fallocate,
> ->set_acl(), FS_IOC_SETFSLABEL, FITRIM and ntfs_mft_record_free() get a
> check as well. Errors while mounting still set SB_RDONLY, nothing can
> freeze the superblock before SB_BORN.
> 
> NV_Errors already refuses a remount to read-write and since
> commit 521978c4f444 ("ntfs: sync the volume dirty bit with the recorded
> error state") the volume stays marked dirty once errors were recorded.
> But the dirty bit may not be on disk yet when the error hits and
> writeback is refused from then on. So a work item writes it right away
> because ntfs_error() can be called with mft records locked, and umount
> lets a pending one run first.
> 
> Unlinked inodes are left to chkdsk in that state. Their mft records are
> freed with direct bios while the index and bitmap updates of the
> deletion can't be written back anymore. And writing to an encrypted file
> only warns now. It called ntfs_error() which let anyone put the volume
> into the emergency state.
> 
> /proc/mounts keeps showing the volume read-write. Writes through file
> descriptors opened before the error fail with EROFS.
> 
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul
