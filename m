Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573279;
	b=nXOa4QFelnX9LC2F5+EnWjg5CR1VHk/28N3YLh9WaN5/nXyvO8f8Vu810dFm9AoHEXUs
	 WSnl5AkpowCsuzQx1ESqtF2vqQV36BBNVZHnsDuhfEbAQXWNASAEbUwH9Y2zmpPkRoRIt
	 Uu3PHNTDzPxkuE3ofiAKHWIPKaWkG/AITrO5wxmYxLrYB5FIi3D6V+IBQyhzS8DFYnRgQ
	 S/wOn43nCjzRxLxNvZk4h6KpBg+44WQkQqIboGL62IhHex1WI9okVI6WkDnKkMFm/m/p7
	 WZLdlAJ08VFm2vyJ0pA2jZCTwxKQ1UR9QVyeWpRv6r05L6P/FH9wfFtLpJFtSb2MEVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573279;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BKXgEbrCq6fjyJzmt7uyeMsKlUcOMIVL4E1Y962hiaE=;
	b=tjw3NgAPo0XLjpj43H2w5Ze2BNcrW/WIqLJoQ1quxJ61brlschwKCsIwLvgY+3YHTgBk
	 DbFgpEzZ5Sz6iGQyfAPyoAk829V+rK34G6rOY6pr9jGyFBGlC1l2IB7sIekRImRvHmYQH
	 bEpP3rW85Hd2MeGLQ7A8HKSzsGz6EoSH9OCAGAIYATgnYLlOC5Kwm5z7eYfY7FO4ZQlDJ
	 KPtAHQwEEpmrUbYG9zNHwcBiXovy5nyQI0dRDcwSvmq/KGhWyQvKRAaGy21CkUWLZyB5u
	 1kBoVBkX1RofX/jOe7o+iUZYgSOKCC4EgPeGB31cFNxQMkEA+yI0FbdgQTWXg2+ECdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W75MT3i+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29070606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W75MT3i+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076E61F000C7
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573279;
	bh=BKXgEbrCq6fjyJzmt7uyeMsKlUcOMIVL4E1Y962hiaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W75MT3i+hx0dL5mhgFj2Hx4U3pwxoDnlsi8JyjD5FPw6aY2z8veFL5RohzrcLAkA/
	 wMbZcP4szlTsDkJjUQeQNhucW4JqATAoHVWYVnrS0Jq/8rWZ5mdhWmhLgXBcj0d8ZW
	 +GvnoaBwW7C5BIk4VDrZJIosD0bHi+UIjbl5VPPneBNTmvPX8V+nsWo20cDJo4GqfJ
	 B3QnLtCFSeZNe25Twadz/19RvbvETm2kMj4BVksoqjf68PME0IRLYkT6tlG0yrX6S7
	 JOeswx2mvlcGR+o0moadKgxA0v7su2vS+sq4Hm/JCfg7fDLxrDTNTLqSZgZbnK0S+4
	 PUlDLnn5s2FrQ==
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67c6f1019a3so1020472d50.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:34:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGXQ+wnAbW1Q/WPjx52CyXM05F816+eDOVF3GX9yDljx/h7bGA3sJv3eYk3kjI2dUvVYXxRlMs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9t+piirweAVYMhdWlnB1LdvdiNabi6gMUpzPESnEBK96+7Hz4
	xq9FoUSUMCLuxqbNcfQhi0EpUxVNoF8T+4qhCUAdcdQ/tl0qQhJC4DkEcmvM0QYHuCnsvOSkyTS
	9pVr8tUmyR9V2RhwTS3lUyGTDNVpPLX8=
X-Received: by 2002:a53:ac99:0:b0:67c:fa4:a5b1 with SMTP id
 956f58d0204a3-67d897064c1mr1072575d50.113.1794573278285; Fri, 13 Nov 2026
 04:34:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_BED06C76C024128D13E6854C2FC31BF48A06@qq.com>
In-Reply-To: <tencent_BED06C76C024128D13E6854C2FC31BF48A06@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 13 Nov 2026 21:34:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-TyDN515MbXDh80LoMSgAKOybHOGc7u7Z3jp-FFBE7iA@mail.gmail.com>
X-Gm-Features: AclHuK-TuIfZZXwI0PrQLPteNRVtbSAXHZq4HOFEaAZMk1Haq12FKu7MnI9ge6U
Message-ID: <CAKYAXd-TyDN515MbXDh80LoMSgAKOybHOGc7u7Z3jp-FFBE7iA@mail.gmail.com>
Subject: Re: [PATCH v3] ntfs: don't let a fatal signal interrupt metadata reads
To: xkeyC <xkeyc@qq.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, Baolin Liu <liubaolin12138@163.com>, ntfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 12:26=E2=80=AFPM xkeyC <xkeyc@qq.com> wrote:
>
> read_mapping_folio() returns -EINTR when the caller has a fatal signal
> pending while it waits for the read it submitted. ntfs reads its metadata
> through it and treats the failure as a volume error, so killing a task
> that waits on a metadata read turns the volume read-only with
> errors=3Dremount-ro. A read that is part of an update also stops the upda=
te
> half way: killing an rm can leave clusters allocated in $Bitmap, an MFT
> record in use without a directory entry, or a directory index with
> entries that point to freed records. Killing a mount makes it fail with
> bogus $AttrDef and $UpCase errors, or leaves the volume mounted read-only
> with a bogus $MFTMirr or $BadClus error.
>
> Add ntfs_read_metadata_folio(), which waits for the read uninterruptibly,
> and use it for metadata reads. Named stream contents, compressed data and
> the read-only bitmap scans through ntfs_get_locked_folio(), whose callers
> do not report a volume error, keep using read_mapping_folio(). A named
> stream write that is interrupted that way no longer reports a volume
> error either. A killed task now waits for its metadata read to complete,
> as it does on filesystems that use the buffer cache.
>
> Closes: https://github.com/namjaejeon/linux-ntfs/issues/98
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator=
")
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Fixes: 5218cd102aec ("ntfs: update misc operations")
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Fixes: 8506a8031ebf ("ntfs: validate and reserve bad clusters at mount")
> Cc: stable@vger.kernel.org
> Signed-off-by: xkeyC <xkeyc@qq.com>
Applied it to #ntfs-next.
Thanks!
