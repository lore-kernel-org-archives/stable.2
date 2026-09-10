Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6649B5C0
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.192
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077555; cv=pass; b=PumLDOCJ/hTQwGB2on/Gqzmy/4Arj5u1M2Z+dE5NaqRdrnx5VRpbPkIxTVuF4C5JbQDffY877sQ9yVEuBBK56EuYyvMRuwbJ9Kql5+vQNj6On3EpWJV9FCrOgud7gWILFu8TnXpkT/en3vraUeOCanGpZo943f2SlPZr1CkL+WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077555; c=relaxed/simple;
	bh=7O3jJm0c41YAE6h2jaPwatlZgF1tan3zNIJ6fQguYG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vg+ll0UF11ytG7Z11J3AbqjUpDNXhAE5+/lYsEtDcTHlVrPdEOYnZ2hfMSBTENDx8uHiLtj8VNHdJ9ggIiZocFzFKycXFC/Aczt90ykyPnckQbz/xOTB6CL1sIJ3n4H5pOpZQ1P46rDa6Hf3tAKkb/z3MJp1F7JmcYPjlBcnxGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riXkeP2P; arc=pass smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riXkeP2P"
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a4492f5cd1so55073b6e.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789077553; cv=none;
        d=google.com; s=arc-20260327;
        b=CchJbXdOML3oKmNhI5EM1DcFxiIvD/3CwiChljn4jd0BHixL4C9z5RAL8ku7LcEyC5
         z9gD1ZeKRUfwJMZje/Q5/mlsE4WgKwz0os+lVPuxEnVC2JajAMpkDyrULK2d6ADxK0K6
         rq40qa9hDNZJs+XfwFiwOPdp0MXrnn9YBHAtPXpNFojLMDWYY1Ufm1yKO3ioRAH5HIWa
         m8RlPKbeH4f5xD2Rm0CBUONMuLlyxPiXvp+IL2KOfE3O7qwPh/tUtCfVpk2NrQQ56Gkl
         mMra+e/yrdQakKtK7mY5qFFJTukOvMRf9JfhaVmuficAriSwZMwL7Mu5bLfKEioSDyVD
         pwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vhUoQL7wkoYsIcfA7GGBkDOFiAJCtqQXdF5vmNWuMPM=;
        fh=h0m6LwCRvFc1I1a1meFcqrHoroYlrfrnRcfnsnb7Tkg=;
        b=KSAj0A7/czybicx0s0XsPjekT/e5HnlAjhehQ5/tIfxi9PlkI0TuiezDiys8FdG2Ea
         ODpsl18BOlckXs9iZghMr56o+mVkPP1qV+4zYsAmOSHJhdbf/IWI899Z33foFDqbu0P1
         6iMg1DRJ/SNhLqOvpeGIUlQOYHRNb4o4Ued+8QvV805YNQYuo9Q5ZAQEygCFwy5ijANd
         HOmxk9RZWNxj838/r9C689Xp6eVUgCosYWfhsWc0Sl4nxf8/mfET3PEeDR76eWSk3lUp
         32udkuSKLxgZ3jEhznE8PKxQYz9TOCjbOeEqPfUYFPTn6BC5RHjJlGP2wxwA7YgKLPRU
         NDQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789077553; x=1789682353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vhUoQL7wkoYsIcfA7GGBkDOFiAJCtqQXdF5vmNWuMPM=;
        b=riXkeP2PgUrPBSCU+zQhXKtAH+pVQAEEjkAB0wRg9nNdCk3WO/HN+vjy/RGMwXJYdx
         IQCGJhueCPBzil8m/agBE+lmQOSE9uxniWv3T8rGj2VYK8Yu8h4wUBxJ9FOvDDOhCKvN
         8ZXizcGkMzGowubWSxy3kfFdmxgqEBamOx32Bnc2W9kreHoqTmtN6b1D2gnjhJVG1Hu4
         PSbyb7o7rcyjXqz2pSourHhz5KR7xipy+Bf+KtKZ+A09cVMYZKxtPcKS0DAHLmfEfc6J
         HbXuSUikPUK/+h+l3eaZPWnL0CwYNzSexhGIIx+6GZjRK4RPAcQNx1ryEdRMkBj1iEVf
         5rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789077553; x=1789682353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhUoQL7wkoYsIcfA7GGBkDOFiAJCtqQXdF5vmNWuMPM=;
        b=M4YLwZbPyRVRBV9CM5rQLbAw/5PB3F3el9kR3LgQSOeWyTDEiKKYUNCce8yz+AHVnl
         +66j4UstgfJPUcWt6tZQRJQCoumMuGIS9/mQszGGO5ipB2jT9uHZSaa7Ocrlbs+CG6C+
         MZ3PWh8l2NZ/i0vIbOjVm/O+WRJB1BjSRuSa7NUeF6L8cs3+bp/zakRJEMDBb1HE7Hrq
         dJUvEBOYYDtmi+DIWDSrZ1VYNiLv6upHiFW5KQJJ6Wp5irnkivYLyW9Y84pEp56rpbky
         qNMgHuPkfGsOtNL+VVPgQ3ftPoj6HKt/tsUU4vGyEFMEeeYos24u9+8+AnEqtvW9bVNb
         ni+g==
X-Gm-Message-State: AFuF++ke471/lqTLUhZgxOiZb9cU7RoZvVzNXLfHnAtBOU9Y1bBrm0t7
	l00fW0shar8m6Df0V78mrn34UE2QtWuvvmdnfystn1LrYtftPsdVKa1V2WiG9Wb+tqHqsGHaF0H
	c0/NNz8zO8RrJnG3yyTtDnXqhwjjBmgXNArzTj98=
X-Gm-Gg: AYBFou1n0Wr5gsmZWwvfSfrbLsv1vOpUHcHVnHwfUnid7OmAWFhA7Qh+nzUNaDLf9q6
	0VED2eAPm+hakuH/ItKHG5gvC8RzCPbZcSyE+6R8C/z44taqpFdTFX4CZe1WkFZ/ou0SJaEQ2Mr
	xI3xsrjbNsX+aE5YxSroqeUgMMT8j0PEZoZsNYIcf7WGQquPvATxeSQu8MaotZQkLkYtW/qM6wN
	HUeDg6ts3Nd2/PgnBy0ni+Bvg1uBb4tpKqzIv6BzfNZQIkRfeAb5oXrNx7LxjM4X8DBKBUSI38B
	ewozKsgSRczeXkHV2zTvNnMGSCl4WHVFX8cWmnbbLHq763yNV0Hv99PNUqCzHXPwwcHV729fTLP
	r5vYRU2xa
X-Received: by 2002:a05:6808:d4e:b0:4b9:e5fa:8a18 with SMTP id
 5614622812f47-4c31b9f100emr753162b6e.29.1789077552909; Thu, 10 Sep 2026
 14:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908192213.1169088-1-giveback4fun@gmail.com> <2026090924-idly-theology-e828@gregkh>
In-Reply-To: <2026090924-idly-theology-e828@gregkh>
From: Sudheendra S <giveback4fun@gmail.com>
Date: Thu, 10 Sep 2026 14:59:01 -0700
X-Gm-Features: AcwNN1UuvH6RryRY5HMItEh3lfbIE2a1j3ypD8uwAtv8RIEb6XcWjjKkCH1TxP0
Message-ID: <CADggw7+k+B7xFnWztHP_BD6G6a3T0tyoG=7JpYWJ6KmjkgyxKw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y v3 v3] fs/ntfs3: Change new sparse cluster processing
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, almaz.alexandrovich@paragon-software.com, 
	skhan@linuxfoundation.org, me@brighamcampbell.com, jkoolstra@xs4all.nl, 
	syzbot+7bdfe1182e4c50d2a21d@syzkaller.appspotmail.com, 
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, Sep 9, 2026 at 6:27=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 08, 2026 at 12:22:13PM -0700, Sudheendra Sampath wrote:
> > From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> >
> > commit c380b52f6c5702cc4bdda5e6d456d6c19a201a0b upstream.
> >
> > Remove ntfs_sparse_cluster.
>
> This is very different from upstream, and there's no description here of
> what changed and why is this needed.
>
This is a backport of ntfs_sparse_cluster fix from upstream into 5.15.y.

In patch v1 submission, I had missed some parts of the code which
Sasha highlighted.
In patch v2 submission, I fixed the missed part but erroneously
brought in extra code.  Sasha asked me to respin the patch from 6.1.y
backport - commit id406a037d93b7
("fs/ntfs3: Change new sparse cluster processing") and add code from
commit id 50c822fcb367 ("fs/ntfs3: prevent infinite loops caused by
the next valid being the same"), which shipped in 5.15.202

Hope this helps.  Please let me know if you have any questions.

> thanks,
>
> greg k-h
