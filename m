Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B143355055
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948735; cv=pass; b=SPwPFFfBP07GBYQYlfEczmp4VdTUvEsIkFd4OvNb16/9baPDNeobA3ETecTAhhDx2mEg/RRoN+9R4umbHEE1XBwntUXqIpif/cvzO43KDFUzllFEl35K8BeYJm+z71javQEzccW2L42q8XLFdWmFrL4ux6hV9gVafPSRvEfeap8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948735; c=relaxed/simple;
	bh=B2/oSlFs5R6t2oDTm1eJJJBzuJEmWWzsRxIbdDpedRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq+3sXjFG6a9wNjJ2/ZT6eCT5mb6OAkldYpHV/rbWbfmhX0eF5OpE3Oj/KGyl4zTSVj7oJ6WdRqf/tvCgYJ6AFrizmh39toVSwN/SBH+sLHjphj9TN42x0OaTzxy5X5YMJNe1rwMXj6m6WCar29cTmIx25kI5BVpTm9gNgmH298=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck1ZHVQ2; arc=pass smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck1ZHVQ2"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c073a616ab0so55383466b.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 16:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782948733; cv=none;
        d=google.com; s=arc-20260327;
        b=EqHH6czIpI5wEtLonrt5Q2K46pm52ee+O7VxwDaW2RXvxpMSm6gb7hEmu+zBwZfpnJ
         fPG/Vaj/sB1mcV8vy9l9ayhmPfb5/BeVlmPj5ACTLiMX83XyNLrEpAfxrdrxwNhu7Qf0
         +TAU953GbqHOeIpUB/VmNCAFJ1opSPjMYhLbL1j3+/I14Ezhh8/hoERbntaKO+OEb3Xz
         zMc7cRBSppaiKH1w71ce+Za1zDj53QHejouB/EFt1TeAaCP9Ux7qSOYph/LditV2hY5Z
         KmJ3FHeTxpKNWb2VofB116xFuzum2qVrCFS0/a5D9aTngZcUWe6poO85Bk/jft/QPVnn
         KYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aEtvomiAJhh+AZYjRz54TpoQYzbI+CDCJW/Z4a3FJPw=;
        fh=AiNCcs03TruhF9byD3ySiToacWo7+eIR6tVOSrYnIhg=;
        b=SBpyL3tywGT867g6yMMmP7/4qrXUJH61h9E3NuO39dHse/YzQSQAiI6WBVc8kBOWop
         J/WxsQGlHi/Hl+QPrRvXUGSDyNfBs4JNb+WleOFdf5vTXBFLwbTi27aEvvDbk1zCgEWZ
         hPHykdhlhC+S2s5ySTsfszG8FZ+A7oe56ew57TbsNpfDicR8uG0z5h870crj1/O8rfNY
         wdQLsUWLpDTmd3xSrIKJ6pQQfj1yP675iSgWQUrQEHSpz3Noxac3AzCJu9nrJD//cUlV
         u5SIf3UovIDtiUzVuySxKKRAa24k9qppavex7hYlSEHMGfidbnEAKeS4w2AyFvjBu3+I
         Ivbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782948733; x=1783553533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEtvomiAJhh+AZYjRz54TpoQYzbI+CDCJW/Z4a3FJPw=;
        b=Ck1ZHVQ2BQfIHHzlRuBsdzS7MywXDj3BtH0bMluzfCLMrZTlfx96MZUXVSHZUimref
         SuEuVLOGU2KQ2ybepeXJpjbBQafhMQpaHQn4ySaL2Pw+npWzF0G9rCVgzJBHlBJqcVNn
         h/pSJStketr06qaVjIR1e1eU00HZCErVcnYvsgj6tJ+rP+glkE3lcXL9ZzUZ1Qm7Ew0C
         x1kKh6xPTyWWADUj+kCDrqPENS48Yt0HxutCpGUi3lMsamlahZ5YSF2/EjyI+JlmRBXE
         Y5Hkg1qAemQr628SMJa+Mm+TSQjLZbu/XebkfnJTY5t9h1PNNzPAAADHaKPgqOM7aptS
         Retg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782948733; x=1783553533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aEtvomiAJhh+AZYjRz54TpoQYzbI+CDCJW/Z4a3FJPw=;
        b=TvJx6jsO8VrF9L86SHOITM2ScMupfmMfjSAsSQf+l0BGkJzXwq7G/UeRMGhgL3lcMY
         aO/YWkZDyC8DSec+xLwrUGJS4ZiobYmwmhWfs0UxzcDPWuLUKgpedVz18fXacdL7wZXA
         CvV+iwRyE62EF3BA377vTe+5FsGVEMN/x0P5watjBV6QBSBBv5eebuPYvlWSQ93d0vWx
         9zZa6W70g1sAm/FcGQPYM28RwPLnflswtD203FHBamDtJwTKXhTfpe+n294aIEeLpRe/
         fpkpkjTZmr36t7LX83G3HzPC4761tLOAt7cCX/ejeBzoTapFFwcOHr0rKxe6ZJPhqmC7
         mEXA==
X-Gm-Message-State: AOJu0YwoUlXvX6sFnZY5SHCbVE2jCoFFcwtoWjXgdcA2vhIU/EW6hgx8
	SrL+Usb5eVdi1RDpdoSb1oaSwKeIfJ1ENDVA3TjfCB448NEA7TerFeXUkrlrwygsdVTBowhJWLr
	QX/5N1AQjve9M562i5b12FYoM26SWy/k=
X-Gm-Gg: AfdE7cmjwVu0I2IVe8Z0/Whb8JZhvDmJclBhnypMP0Z1ylr+wdQVL1ILB6swT5w0ykv
	eflCr4MJvWrueLVyhH63XfrdRz3QkBXev9Rf5dMaaXX5LXR84qhsdgoNquCrwCtYZZsqwrCs8w1
	EF9wBN6bJxv1Pr4hX3eax0KEVWSjqH3NQ681kkz61b1Uj6dX3+eTGkbqsl8tlnH7kJF/QP65G8u
	aQ90wGcJ5xsoNQrXVgfiemX6mkCPMA4Wv6SbTSnWcnpOWhxSIYFtrzjw8FS1svmciuNU8vGFQ==
X-Received: by 2002:a17:907:8b9b:b0:c05:b9db:68cc with SMTP id
 a640c23a62f3a-c12a9ba9198mr177161866b.0.1782948732444; Wed, 01 Jul 2026
 16:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFTRC0=hdHvug9=JyiZ=XYowdpqp9TAgXbq0YpDOEnzmQUWxzQ@mail.gmail.com>
 <2026070140-segment-schematic-0a38@gregkh>
In-Reply-To: <2026070140-segment-schematic-0a38@gregkh>
From: sdj asj <sdjasjbuaa@gmail.com>
Date: Thu, 2 Jul 2026 07:34:13 +0800
X-Gm-Features: AVVi8Cch7N2hDd21kWVko2dWmYAYAPlToFThimgAcOq9SHnpL0FdK5_1bQ4P5z8
Message-ID: <CAFTRC0npKw0pwHufN1ck8znkmJB90prND+r8_qAyWvkGt3iemg@mail.gmail.com>
Subject: Re: [stable] Please backport ntfs3: reject direct userspace writes to
 reserved $LX* xattrs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, ntfs3@lists.linux.dev, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, 5.15.y and newer are the branches I meant.

ntfs3 was introduced in Linux 5.15, so 5.10.y should not contain the
vulnerable ntfs3 code and does not need this patch.

Thanks for applying it.

Best regards,
Zhen

On Wed, Jul 1, 2026 at 9:36=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Jul 01, 2026 at 08:27:36PM +0800, sdj asj wrote:
> > Hello stable team,
> >
> > Please consider picking up the following upstream commit for supported
> > stable trees where it applies:
> >
> > 5b08dccecf825cbf905f348bc6ccb497507e28e2
> > ntfs3: reject direct userspace writes to reserved $LX* xattrs
> >
> > Reason for stable:
> >
> > This fixes a user-visible security issue in ntfs3. Before this change,
> > the empty-prefix xattr handler allowed an unprivileged file owner on a
> > writable ntfs3 mount to set the reserved $LXUID, $LXGID and $LXMOD
> > extended attributes directly. These attributes are later trusted by
> > ntfs_get_wsl_perm() during inode reload and used to populate i_uid,
> > i_gid and i_mode.
> >
> > As a result, an unprivileged user can create a file that becomes
> > root-owned and SUID after inode reload. The issue is reproducible
> > using normal syscalls only and does not require a malformed filesystem
> > image.
> >
> > The upstream fix prevents non-privileged users from directly writing
> > these reserved $LX* attributes, while keeping internal ntfs3 metadata
> > updates working.
> >
> > The original issue no longer reproduces with the upstream fix applied.
> >
> > Please apply this to supported stable branches that contain the
> > vulnerable ntfs3 code.
>
> What branches are that?  I've applied this to 5.15.y and newer, but it
> didn't apply to 5.10.y.
>
> thanks,
>
> greg k-h
