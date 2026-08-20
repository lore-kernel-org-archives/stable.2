Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9941DED0
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224532; cv=none; b=CTRvrQyU1PZFBJzMI78GOO4HwKS58jmiO2J/aa9w7ppYzuJ3sxcFSDv+j4i9UenkPbnFITE/WPC6ZVlIKkCi7BkFikiYbn9QPsPz8rd+7FcAvtlG5PAxH8qcDbvK+IFt3fPEjGZHmlt/HPX/+AUzQIxmezqH7E3x8JaGOquKF0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224532; c=relaxed/simple;
	bh=l0pNZJFfzkYWFJzl8/RiEC49jZiTv++D5qRrBJM8U8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMKARhVY5lE70XDD2vMeh8u7woapITA5bVDwdjlyAjCkn5TYfHyDoXHsO05gCT18BPE718w41kiS0HsTohkjm55pam942CqM14d1kzTIoPYOClNPIKoJeKd/SB3lfC/UygwzyzQoBCr72HszBBgsG+mO8E9aVegmOnwc9JDX/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpUUIA4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpUUIA4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CA01F00AC4
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787224529;
	bh=l0pNZJFfzkYWFJzl8/RiEC49jZiTv++D5qRrBJM8U8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dpUUIA4ZJ8i3dkniOPbQxgtf+nw97tifq1TDA7RqRhUHo1M/DiCEBo8DismL5xLqZ
	 UmUWaDbRjSkxlqwGngs753xnipTJdzEdFP8CS3v7A4N9JC7E6m9X1MdoJzo/8ZQk5Q
	 OZOrf33Q9arTMS+TpKwZVGeRTtrm6yNH90WBfOeW3a4HIsWZV8QTrdJgl1QBuHFHHp
	 nT7vbGbyzyIOD8NCRXDA58c8tk7Jn8ZOlgJ7T2D7AUSa/OViY6cNyppiBaRG0hVmPW
	 cNbA9qOtaaLAhq6yJpaUPr44tDkkXhTsxahXkKNWY622pLr0qZmBdz115AVdGyJDEy
	 GKoNioGacgAMw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so3688365a12.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:15:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqE6hCxUTO+Qi+kANtdwV5HviFrDYZ27K/skEzceM3rCmauF8hkNwkLchr+lNgDkJZPoOv0/fo=@vger.kernel.org
X-Gm-Message-State: AFuF++l1eXoz9QBv+0Hm/dfHAnSpMBMU8lSMOfVh77YpM0bly+hihDAv
	nuXzOjQWkov0dFcWJ12QT91lDeT5s3OPxARRxUMAM2ZPzPqrDO6RncKfENl4r05gMDKrhgPyO5r
	jpm/zqcNDLxTKb9qiBZ2hPOSmyvo6aEs=
X-Received: by 2002:a05:6402:e0e:b0:6a3:6d83:ba44 with SMTP id
 4fb4d7f45d1cf-6a403297189mr8751598a12.2.1787224527918; Thu, 20 Aug 2026
 04:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820081410.152325-1-zenghongling@kylinos.cn>
In-Reply-To: <20260820081410.152325-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 20 Aug 2026 20:15:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9K-foqh6sd6ncmG-vKObkw7Gy8V7XRABMQ7YOCtcLnFg@mail.gmail.com>
X-Gm-Features: AcwNN1WmSpEV-t6mtjK2pddGFCb184unB7f03c-gYwRT5QfLjUmBrcwO1o5Jo2Y
Message-ID: <CAKYAXd9K-foqh6sd6ncmG-vKObkw7Gy8V7XRABMQ7YOCtcLnFg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix resource leak in ntfs_new_attr_flags
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:14=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> When handling resident attributes that don't need sparse/compressed
> changes, ntfs_new_attr_flags() returns 0 directly at line 678 without
> calling unmap_mft_record() or ntfs_attr_put_search_ctx(). This leaks
> the MFT record mapping and attribute search context.
>
> An unprivileged user can cause a denial of service by repeatedly
> calling setxattr(2) with system.ntfs_attrib on files with resident
> attributes, eventually exhausting kernel memory.
>
> Fix by replacing the direct return with goto err_out to ensure proper
> cleanup of resources via the existing cleanup code.
>
> Fixes: e791930240a5 ("ntfs: fix resident conversion in ntfs_new_attr_flag=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
