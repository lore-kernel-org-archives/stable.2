Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CC38C2B8
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082774; cv=none; b=s++cDeUwcgo1ruDk12FMabzGsx2f9FXmVG689VFe3SPpNG367CjgWAh6n3opOehGEes5zjstkCqXBXdG4HI1R71UxRtqHfZ1t+PIwQuegQYhoQgJAYepWRFtRslLkhr39f3nokWS0v4qOSN1SHIZtim3S7bM1ioVB1LZFOLoAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082774; c=relaxed/simple;
	bh=Z+X3CPEK2lQ74uBcjEJs3GiYIfZC6xYB/GEbTUf53RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VB5XzWYpc50H8QQCvmYJgPFAIvxN0PSgt64SPGT3i5hjxBDUfVsBgdO71CKSfno/KUfrDZGH3t4pOW+/Y2d1aJwl8iUXTEJwc+/9dH4KR8Y5m+HNqVGXTE2fpNkMulV2a7zruFj/FXYSuYwzdPcdXT8+b/rbm+y2NNdoC77ZRBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNE7TE2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNE7TE2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9EC1F0089B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082773;
	bh=lA7/YFjFFdLuae3oYEHQvKUO+2y5XR4FrVSWBLg9fns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BNE7TE2ja2dOTlTH/c0eJGh8MYCnz81oCWuFnAHSZYYVTrjIHzkqsCAt5ixGNGQ9W
	 OE/KMQQSNYzsTR5lqur2G2fafQhT48Lk8PNoRmCmqoXwGFc2N1MJN3suZtBs1yL4K1
	 5B2Y/MjWpvdGB5XeKp/NbZ6Ykhr8ytuZW1YGKMTqqkW2hh3GJhgToxFGyBQ8nBsfMz
	 4anePHtmgH4bKAZ38/5RZI2GABxBEaS1f9DVKtXTmLl/27akknkOuc5jRS2GhxLCaD
	 BAqLTKE7XVR8tug5J4dsndeN8b307C2fvnqoMMP/offovEJjPId4tdIDITaZxjEAVP
	 MiJbJq9o75Ysg==
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7db0so499151366b.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:12:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwb7hhmVUI9Fgp6OHUe15fSHcsdge7XuDf6hP2xcX7UQdqsifWUiEgNuemPQmRc4ExvQYf0CVQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mkFjKBJ+V1LflzI/Ejfa2ySl8hD3GbeF0MoaMIPfLSTLEaN4/x
	cr6coHfyqv3kM2utvQZaNcAm7L1coCckpOuj8VD2IiclKmC9x170C7/a6Zk7Vn3IsFF6bRVd5DY
	9AP7N4fqt+LYAw6erwZLWsnKdrVffVgk=
X-Received: by 2002:a17:907:c002:b0:c29:583a:c291 with SMTP id
 a640c23a62f3a-c2a15708b92mr1253803266b.21.1790082771808; Tue, 22 Sep 2026
 06:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922101117.2140385-1-zenghongling@kylinos.cn>
In-Reply-To: <20260922101117.2140385-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 22 Sep 2026 22:12:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-c-OPp_WxwR6raLb8OvOGmYmJSKQf+RQdH_qmVw5mjXw@mail.gmail.com>
X-Gm-Features: AclHuK_YsIx4l9qDUH2HoFkiUaT79KZv_g2vbHpgtY8SDQVgf6KjcajKrD5Vd-o
Message-ID: <CAKYAXd-c-OPp_WxwR6raLb8OvOGmYmJSKQf+RQdH_qmVw5mjXw@mail.gmail.com>
Subject: Re: [PATCH v8] ntfs: mount hibernated volumes read-only regardless of errors=
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org, 
	Baolin Liu <liubaolin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:11=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> The hibernation check in load_system_files() only converts the
> superblock to read-only under errors=3Dremount-ro.  With the default
> errors=3Dcontinue (and with errors=3Dpanic), a hibernated volume is
> mounted read-write and the mount-time $LogFile emptying writes to it,
> although a hibernated volume must not be written to at all.
>
> Drop the on_errors term so that a hibernated volume, or a volume whose
> hibernation state cannot be determined, always mounts read-only.
> NVolErrors() is still recorded, so ntfs_reconfigure() keeps refusing
> remounts to read-write, and the $LogFile emptying is skipped by its
> !sb_rdonly() check.
>
> The check itself must not apply the errors=3D policy either: it runs
> before SB_RDONLY is set, and ntfs_lookup_inode_by_name() and ntfs_iget()
> call ntfs_error() internally on corruption or I/O errors, which under
> errors=3Dpanic would panic the machine before the read-only fallback has
> made its decision.  Temporarily substitute errors=3Dremount-ro for
> errors=3Dpanic around the check: nested ntfs_error() calls then fall
> back to read-only, and any read-only transition they trigger is
> preserved even when the error is not propagated to the check's return
> value or recorded in NVolErrors().  This is safe during initial mount,
> before the super block is published.
>
> If the check reports hibernation or fails, set SB_RDONLY and record
> NVolErrors() unconditionally: hibernation safety takes precedence over
> the errors=3D policy.  A volume with errors recorded during the check or
> earlier in the mount, e.g. when loading the LogFile, also stays
> read-only, matching what ntfs_reconfigure() enforces for remounts.
>
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Cc: stable@vger.kernel.org
> Suggested-by: Baolin Liu <liubaolin@kylinos.cn>
> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
