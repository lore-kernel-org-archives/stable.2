Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA44D7974
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579963; cv=none; b=LicXpIo9eNLXD8mlVuD/VBr2cujWpeFVazclRbua5L5QH5Qjx7zrY57GX8AIyEdcZt85k7MIClN3FzmpLN0z7qLgjpO6Q3UDuMG6Srrsc2v7bRo8e9JpWvBIXyCyqTgqKmJrraOBHU/+B1yF2JNTR5cu+g29ECVu4e7+z4nWKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579963; c=relaxed/simple;
	bh=7MaHX5Khe4czDQucHPkA7rQSGwChp73MQfgrIuIDsFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rxnxjse10fBOhGR9QFC8o0JDrxMADrTFJABt2RB1kDhMPrMz4QIGSpZj9yUQaBNisvJJfM7QoQ13EASu2/L+E2o9Oc3RT4z7uoFWZk064eIOTo4ooEygL8rg+a389HwIsOMa8iFnX9syUsFN2MunzpDNk34Suh3wGVC36VKJYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alU6nCQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alU6nCQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5FF1F00893
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789579954;
	bh=32+oDyoFESxqHqBnox8/Lmr9Se4+wo4fXsv98uxSdec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=alU6nCQZk5xNBr1xOqKi9u73Op8brwQ1qowxM34xg2VFR94DCYy9spAJ+1OlWM4jl
	 ajJb3z3oDB2jEk3ceT9dIy5mwVYxNdpRk/vs1yaevWnTzFJmQVkwxXaMQ6/Hkcc6MJ
	 yFYd11AcPaIp241Ew+87Th8Hh8DbYhGsfSQ5XDmKwcyiLWhGHpKHAvcBby37clbQO8
	 0iHRyvUatNkoZP5WrvpX4otvq/+oyiCmAtV1yb0b+WI64lzoCuvEohMDhi+md6H3Cd
	 K9JuMHne7d72WiLecUM5Er9juBTrv+hgkitZI+XM8A5rc2+XuguAo1pWdWpGN0PK3G
	 nYKqNhYedDrLQ==
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c9031e714dso486069e0c.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:32:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy+9igM78nfObwb7Vz6nf2nFkN66H7r6K0XcJ2ycBq4JaKwGn6BjcKjNM1V30PAdC11xT4mDLY=@vger.kernel.org
X-Gm-Message-State: AFuF++lJ7ncGpnOH8GXmZxFlxYdZ1RYJALwA3j4tW1IIEraZ4iHj+rHs
	ARK9A/XFZ8cXZhSyuGY1d62xzB4BXSSXRjZLxBzPsFYbhFEkZNKaxAC92bTuq4SPH/wh0AwMwPI
	ekdzjIyHH2Pf3q0LrQKbIX7sqsK2emzQ=
X-Received: by 2002:a05:6122:1d43:b0:5c9:a60d:3277 with SMTP id
 71dfb90a1353d-5c9a60d3a1cmr203449e0c.11.1789579954058; Wed, 16 Sep 2026
 10:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916171829.2087132-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916171829.2087132-1-vulab@iscas.ac.cn>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 16 Sep 2026 18:31:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4zcpuz0N2KW33GMecGLyEw0LRsXKenh4AwgW8DyC0fpA@mail.gmail.com>
X-Gm-Features: AcwNN1VKyht7PLf8O8YAf4X3uMXkcE5VCSoZx5WTNTzb2NGjZVAKpLo8bBEd90g
Message-ID: <CAL3q7H4zcpuz0N2KW33GMecGLyEw0LRsXKenh4AwgW8DyC0fpA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Fix root reference leak in merge_reloc_roots()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, wqu@suse.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 6:26=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> When the fs root read back for a reloc root does not have the expected
> reloc_root backref, merge_reloc_roots() warns, sets ret =3D -EINVAL and
> jumps to out without dropping the reference returned by
> btrfs_get_fs_root(), leaking it on this error path.
>
> Drop the reference before jumping to out, matching what
> merge_reloc_root() already does for the same mismatch condition.
>
> Fixes: 05d7ce504545 ("btrfs: exit gracefully if reloc roots don't match")

What tree are you using? This was already fixed in 7.2:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dce6050bafb4e33377dc17fcc357736bfc351180c

The Fixes tag is also wrong, it's the one mentioned in that commit.

Thanks.

> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  fs/btrfs/relocation.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 3ebaf5880125..6c826be41749 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1850,6 +1850,7 @@ void merge_reloc_roots(struct reloc_control *rc)
>                                  * corruption, e.g. bad reloc tree key of=
fset.
>                                  */
>                                 ret =3D -EINVAL;
> +                               btrfs_put_root(root);
>                                 goto out;
>                         }
>                         ret =3D merge_reloc_root(rc, root);
> --
> 2.34.1
>
>
