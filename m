Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0092390212;
	Tue, 15 Sep 2026 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457436; cv=none; b=j5P06gQF0dUlCg4lsKDxz+85mj7qBMMjBSpraitcXsZa8+vxmnI6GBZSE2qWlN2g5BTsyGmNWao1D7p3b3nL6FZOZHQX5uc8z2jXo/JlSSiaalf6tCr8RRRwdiNy2OMstrkV0z1e+F9bJ3WvY2fSsx/p0TM7Snejf75Y0EwtOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457436; c=relaxed/simple;
	bh=mR9/lwyEnnhes5Rs53Qbjz9K+oUJyi/GqF3aEAiZkFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lapFVdCY4Ri94lwM79tWgT3ShUOk/ijo+z76ttVdT5g3g3NuNjBCTyj1qS8rc9LFLgB0U4E/XgIMpNWiEp86sc3sFh2YYpA0pKXlX0SNYCCvqwTMnC62DvGVlES7tJbFt26Ckg/CbvAh4bXMYL9KPO0y+EbQXbbwgdxKB8ct80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ian72JLd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ian72JLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269261F000FF;
	Tue, 15 Sep 2026 07:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789457434;
	bh=lKRIjL8U68hpYB4JrL02iKgw2lAfaABiPkDTv+XGsr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ian72JLd0nsExFvCUXUX5ap90mqaVMjO+AQVR9GH3tiDjqjc3KOXZcKpqMTd+R5OV
	 Faan1Qz/WR6RrfVSbI9ArEukF9DTn3VBfHJ1Edijm4K56UD0kbK3qo0nfKdqXiJTzm
	 36Zyx9VENt+kU6ssvtKWZo8nkuXPgOt5xErQQlMXx7BeAdvClST0k42e3EXZHp+/GP
	 OeXKnLIxmW6WaTQAqMHcO6RP5iKJo52No+4cAtf6Bghosh+Z505Fvrw4Vd02o6Bpqq
	 wjSG1tCcyGvJWmvWbLy/eGbk94LT19q1UtkmOa1rQvQ+lOO6SFxB8RItW6NPREVreh
	 tFT0Rw6wKJJBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mtd: cfi_cmdset_0002: cap the write-buffer chunk at 256
 bytes on an 8-bit bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Orgad Shaneh" <orgads@gmail.com>, vigneshr@ti.com, miquel.raynal@bootlin.com, richard@nod.at
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260915071339.15172-1-orgads@gmail.com>
References: <20260915071339.15172-1-orgads@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:30:33 +0000
Message-Id: <20260915073034.269261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mtd: incomplete write-buffer size clamp for interleaved 8-bit chips
--

commit efef65c6e8de323e4294fd157f7f865d12e35292
Author: Orgad Shaneh <orgads@gmail.com>

mtd: cfi_cmdset_0002: cap the write-buffer chunk at 256 bytes on an 8-bit b=
us

This commit limits the write buffer chunk size to 256 bytes when the bank
width is exactly one byte. It prevents program aborts on 8-bit buses where
the chip advertises a larger write buffer than the single bus word can hold.

> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_=
cmdset_0002.c
> index 517db2f2707f4..64fde81191d15 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -283,6 +283,17 @@ static void fixup_use_write_buffers(struct mtd_info =
*mtd)
[ ... ]
> +	/*
> +	 * The word count of the Write to Buffer command is a single bus
> +	 * word, so on an 8-bit bus a chunk holds at most 256 bytes no
> +	 * matter how large a buffer the chip advertises.
> +	 */
> +	if (map_bankwidth_is_1(map) && cfi->cfiq->MaxBufWriteSize > 8) {
[Severity: High]
Does this condition properly handle interleaved configurations where multip=
le
8-bit chips are used on a wider bus?

The map_bankwidth_is_1() macro checks if the total aggregate system bus wid=
th
is 1 byte. If two 8-bit chips are interleaved on a 16-bit bus, the aggregate
bus width is 2 bytes, causing map_bankwidth_is_1() to evaluate to false and
bypass the clamp.

When writing a large buffer in an interleaved setup (e.g., MaxBufWriteSize =
=3D 9
and interleave =3D 2), cfi_amdstd_write_buffers() will pass up to 1024 byte=
s to
do_write_buffer(). The loop divides this by map_bankwidth to compute 512 wo=
rds.

It writes a command of 511 (0x1FF) to the bus, which cfi_build_cmd()
duplicates to 0x1FFFF. This gets truncated to 0xFFFF on the 16-bit bus, so
each 8-bit chip receives 0xFF (255) as the word count. They will expect exa=
ctly
256 words (bytes).

However, the subsequent data loop in do_write_buffer() would write 512 words
to each chip, causing them to abort the program on the 257th byte.

Should this condition check the per-chip data width instead of the aggregate
system bus width? For example, checking if
map_bankwidth(map) / cfi_interleave(cfi) =3D=3D 1?

> +		cfi->cfiq->MaxBufWriteSize =3D 8;
> +		mtd->writebufsize =3D cfi_interleave(cfi) <<
> +				    cfi->cfiq->MaxBufWriteSize;
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915071339.1517=
2-1-orgads@gmail.com?part=3D1
