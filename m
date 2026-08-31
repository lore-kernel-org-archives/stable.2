Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69733B6F8
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173340; cv=none; b=XJQgZMubGMgjVIiVNqxZAeFIsLtRIOOSwpsMEyEUAnp+GeQgDf4RgrqiUxUtjjf2Z/mwZcAk2CvMowxhEKisrSqI7Liq793iX63mtszVLqhkvgw6We0EYaXEA5g6dpotccgGDo4cwIweByizlsmbU4m02P6Jrp7OhMhg5yymkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173340; c=relaxed/simple;
	bh=InUFVFoDCQ1R4NnYXlhWnvQLAIMQF3Yznq+IJ5k904Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8JpSWgKICs3PJAcLEeDvlbeldi1PjLorqMvvulDDAbFIKg21lpMxgOPtTAAwhbDJ17ZzqB5f5IbElIszlgulxNsfyi/gidxwjFmQqOWct4TqPAJL2Izpjsyoi/+wXualRnuy336enclPwPLxu1qKjPcmHVpMl9ukZNSy38G9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWMRIIrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWMRIIrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DC61F00ACA
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173339;
	bh=OBf49Cwts5N/xbDnDGbOmlCaZGVP+7okCnL/y1wmn9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jWMRIIrAGfb+pq1367Kkg9CZi2qx68+X67xeCZ3PmMIcW4Q/Hs5CBcsXTAkKjdS2K
	 iqe6QD8FG660SaMW0rf8B/pV7ya7hun8j0K0fBj+IEUj+C4gtAb/S/3kjSgfauDHYD
	 GvUPCkELvQb9CiRlCASMlFL4OytWBNS8FyXSmpER+FwtSj3AbHiMIc06+ykkeCBlvZ
	 1Md6MmtPVKqM5QaJAOTb9+ASBeEVMnZHZrnWOpG+JdhIJrbvtugaLn9A9VBFA1HCYq
	 D+1IJVbp6Cd9F9zMm80tJ+p8QCPzOz1AHVvA+2jQiIQ1rWGmBdF/51FnInMlHpxY49
	 8roKsTK6wUyrQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2530cabcf4so509725166b.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 03:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoWbEJEIxXW2hile4pcwv59QvWdeED2QsKlGqJm1vdBGQb7HdaM1wSxb0P1RV43kK1xl4sGjwg=@vger.kernel.org
X-Gm-Message-State: AFuF++l4eZsUDgSYPZ06eTU4R8dwwwssLZWSVEQTQuiI+ByOqYuTyo6d
	7ZyEoDa+QcE3QX1oNn2GQYRK9Fwkc5NW47KBRHXhqVi5PPvgl6DPJQ8ZpH9CiregiKiW+WA+lxv
	SduFI2yS5YW00foehdTZNoWiyR/P0sRo=
X-Received: by 2002:a17:907:1c94:b0:c24:d6f0:1223 with SMTP id
 a640c23a62f3a-c25ab4f3879mr159758666b.12.1788173338043; Mon, 31 Aug 2026
 03:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831083252.80732-1-zenghongling@kylinos.cn>
In-Reply-To: <20260831083252.80732-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 31 Aug 2026 19:48:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_-31u8GWP7ze4n3+T=irL6J2sYPAXqAdE1RF+Cpk4oVA@mail.gmail.com>
X-Gm-Features: AcwNN1WY4iEEhjrFcI0FdLJ6z1hIRAT0Ads6b1GC09s-OrqD6NRdaUYRtxJbir0
Message-ID: <CAKYAXd_-31u8GWP7ze4n3+T=irL6J2sYPAXqAdE1RF+Cpk4oVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org, 
	Baolin Liu <liubaolin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 5:33=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> ntfs_filemap_page_mkwrite() calls iomap_page_mkwrite() without holding
> mapping->invalidate_lock, so a concurrent truncate or fallocate can be
> in the middle of invalidating pagecache and rewriting the runlist while
> the write fault maps blocks and dirties the folio.  This races with
> ntfs_attr_fallocate(), which merges clusters into the in-memory
> runlist, drops the runlist lock, and only afterwards zeroes the newly
> allocated clusters on disk; and with the punch-hole/insert/collapse
> paths that free clusters after truncating the cache.
>
> Per Documentation/filesystems/locking.rst, ->page_mkwrite() must ensure
> there are no truncate/invalidate races, "usually mapping->invalidate_lock
> is suitable for proper serialization".  xfs takes its mmaplock (=3D the
> invalidate_lock rwsem) shared in exactly this path.
>
> Take invalidate_lock shared around iomap_page_mkwrite().  The read-only
> fault path is already covered because filemap_fault() itself grabs
> invalidate_lock shared on instantiation/read paths; only page_mkwrite
> was bypassing it in this driver.
>
> Fixes: 9c87959601e8 ("ntfs: update file operations")
> Cc: stable@vger.kernel.org
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
> Co-developed-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
