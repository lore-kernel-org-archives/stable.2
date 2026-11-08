Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104104;
	b=Ba6Z9dPNhapFrJM8gEBKyFNWKTLzH7HTFEtyWc4IrAo0zVJQ0xJbzGzHwQvl6CU2P+lr
	 SV3p9S9B5ATESD5ACOxZtRJRR1YzR3lKcqfioy8kG9m15Y96JsZ020m0TCbcbeYBNwZ4Q
	 JJC73YtBO7nFZX/aCY7mrHR3jOpXV71J63xPEekVI4nlZjTy0uel1OGIX/bnRfhWl45zc
	 ikB4Aw7rRCrEmmP+cI2s/I1QIfXeNmxE2/kPeFOSg6jsnpNCXv6E1nP9Ca+2HDGYuRwGH
	 KidpjiVF+xg1rvQASrdXuDPxLaJDYsX9Fwd+iJ11c0VZCpl0HdUgHXO3d4Gfs/boUJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104104;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BfU5/83XMXk0vM+uXaProIt+1jhnjU7VuIvTMIQ6YKo=;
	b=HdXqSFxBR05hyFWd3DvVHfHtDc3hPoVdL5RULKK2nqEmNIzLwRqAqIyI89i5egYwQfYz
	 +/VkIAcoPrbmqbRrPAsr9fxGfgZFPWItnp52oDWSQf3hKHSZijv1xz6KBFQwX/Hxg6oPC
	 cjGlf05OOU+gDU2mHSyfwyQH6Z4j4yjzuHIdYRQwdf5ikFMP8/BmeQDEc42bs7JyAIVu2
	 R44gdxoF08bRDIr5RzZ6eaityTF++TpCrvbBROqih5uYJfB0StlUWubHarnY/IKN/60xT
	 dzRJvFvJ1UG3qdFHJ8pFL6I4pu2FGdXOJRVM6PHWuIwLryvJePSFYHKw6YeHBYyc91Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WM5vlv2F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A586606A31F
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WM5vlv2F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75611F0089F
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 02:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794104103;
	bh=BfU5/83XMXk0vM+uXaProIt+1jhnjU7VuIvTMIQ6YKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WM5vlv2Fvc8jxhx6oMAlqPiI3vRzR6SmSN3bdoBHu06xuoTE6JDwNhsvXiIvG6151
	 ssZz+gtzZs7Fu5C9KcQJx6my8/cr7adxO1s72eRprsNBOcw7a9GTiMQyPv8ERZTQxc
	 VPh4lPVby2Jvn1ChORbwxiQs9Df7ZFtTiukfawZowVhJ7l/bnxkAJYJkfVa2Mk9Im9
	 Twl7kmGSFwp7ONZWmt3OO2VK0DFgLyABcVNmEeghv68IT+Wp6Vkbp0fVpbtF/iVBZQ
	 0znABMoNoqkYlSobtw8eN8/67ykzaTVvq6O+2RPbiSeYEMXFgXSULjSB9EFgqGfrmf
	 H8r+FhILI0kvA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4682977f9aso11101366b.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 18:15:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwFjcz6CkqKhpkVWtvOs+Ue2M2OCjh1/FnGQJBawDwOiDFTecVV6OfNk5DKZMjr6exF0uQrmO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SjTqANGCDKJk2A6O4VsCBlx6jNqY6exEw/LIasa7MlxAowaXR
	BaNXMCBdJ9iGFY0Fw6TXkBovU37+/VGHWaZpKxzIN5QLQjcOVh3q59jTomdcbenbXBkgokxLxqc
	cHITxaQWbks6m5T/PK5y9sX07bfSQAAk=
X-Received: by 2002:a17:907:72d6:b0:c40:560a:461 with SMTP id
 a640c23a62f3a-c4d6d7d2fb0mr28458866b.33.1794104102530; Sat, 07 Nov 2026
 18:15:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
 <20261107192836.3908453-1-wahidzk0091@gmail.com>
In-Reply-To: <20261107192836.3908453-1-wahidzk0091@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 8 Nov 2026 11:14:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8LEoxzxZWO4ZMPTdLyGmKttOCuM-Snz23w7G=v_pj8mw@mail.gmail.com>
X-Gm-Features: AclHuK8IVXVsA_GIlZwkq86xN9S60haSS0KaSG4vU7bO7a-vVlnBg7_8thvU9sE
Message-ID: <CAKYAXd8LEoxzxZWO4ZMPTdLyGmKttOCuM-Snz23w7G=v_pj8mw@mail.gmail.com>
Subject: Re: [PATCH v3] ntfs: open a named $DATA stream by name when making
 room in a record
To: Wahid Khan <wahidzk0091@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 4:28=E2=80=AFAM Wahid Khan <wahidzk0091@gmail.com> w=
rote:
>
> When an attribute has to grow and the mft record is full,
> ntfs_resident_attr_resize() walks the other resident attributes and
> converts them to non-resident ones. For $DATA it always opens the
> unnamed data inode of the base inode, even if the attribute found is a
> named stream:
>
>   tvi =3D ntfs_iget(sb, base_ni->mft_no);
>   ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);
>
> value_len is the length of the stream, so it does not match the
> attribute that ntfs_attr_make_non_resident() looks up for the unnamed
> inode, and the WARN_ON() on entry fires:
>
>   WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
>    ntfs_resident_attr_resize
>    ntfs_attr_expand_locked
>    ntfs_expand_for_write
>    ntfs_file_write_iter
>    vfs_write
>
> With debug output the values were attr_size 13 (unnamed $DATA) and
> data_size 550 (named stream) for the same mft record.
>
> It does not need a damaged volume. A file with an alternate data stream
> whose record has no room left is enough. The fuzzer found it through a
> single changed byte in a file name of an image from mkntfs, which made
> a write grow a resident attribute in such a record.
>
> Use ntfs_attr_iget() with the name of the attribute for a named $DATA
> stream, as is already done for the other attribute types in this loop,
> and keep ntfs_iget() for the unnamed one.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
> ---
> v3: open a named $DATA stream with ntfs_attr_iget(), as suggested, instea=
d
>     of skipping it (v2). Same change as v1 of this patch.
>
>  fs/ntfs/attrib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index ce7c1b524180..c92d1b06afc3 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -4933,7 +4933,7 @@ static int ntfs_resident_attr_resize(struct ntfs_in=
ode *attr_ni, const s64 newsi
>                 if (a->type =3D=3D AT_DATA && !value_len)
>                         continue;
>
> -               if (a->type =3D=3D AT_DATA)
> +               if (a->type =3D=3D AT_DATA && !a->name_length)
>                         tvi =3D ntfs_iget(sb, base_ni->mft_no);
>                 else
>                         tvi =3D ntfs_attr_iget(VFS_I(base_ni), a->type,
This can still deadlock with a concurrent read of the named stream ?

Thread A: grow unnamed $DATA          Thread B: read named $DATA
--------------------------------
-----------------------------
hold unnamed inode i_rwsem               hold named inode i_rwsem
hold base mrec_lock                             hold named stream folio 0

ntfs_attr_iget(..., stream_name, ...)
ntfs_attr_make_non_resident()
wait for named stream folio 0                wait for base mrec_lock

Thanks.
