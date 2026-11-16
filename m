Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837744;
	b=sfm/ZkJrhlFA9pEax/r60/28jSd4EIFijVPK9xnkpEYnlFnJ1Mcx5SsvKAmRdN9krMEY
	 f8vpVV+smHvn3zCrrTKfO07WyFUSuf9mOY1o7URfkWTPii2sXXEeacYOe3tJVfZvHgYLu
	 H4gEr85k8zs2C28FS63QL4HnqHqOEUgM93XXgaS/bf4JyG3Sl+POLRuqpKezy7bCsRrfj
	 8nfFgRlJP9Hdxtxiz1ZyDLb4fpfh0OgKkjTF8a6yKyL2OhXFs7Gh6IxDj9T6ndE9q3BMw
	 nxOpUVaPW3jAgBtgqd03df/Z1HPnU4F2BB0IDgiVB7dYYCu8M2xG7gqQkz50TxBQvCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837744;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=boLpSwZovCNSbV6begV60ngPtUAPKB0G+tLPneL5NsI=;
	b=hpEukrAM10Zmmq9wc+D7GJYzPKRK7WLdl7K/esFGchJuBz79KTkBAv18NSZBxg2SDqRI
	 PAsO1BAOFROtgXOzx/6W3SkDRsiRrzmnxghLHpvD5KtX4G/cSjtzfA/vOZNNQq7ooQs5c
	 rp2zGihrWi6lbZaCKh3xuEUow9qspiwytbgY2hO8jdgnIlrbvhH6uY7s5P9HX67D9F87D
	 ck/zqS1mfLTFnPCSUpV+zSar6IBqQ1/z4b7jz3nF1b/U0DaJFN/H7atqYIyhEI8VVH7pR
	 3CMSOAJh4jhP2j2Yzm9ENG5Qr3aNYslgdcoLgRpMJ31mL1203zKWONGWoSqtoufJ5Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoJwrwy9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5B606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoJwrwy9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF0D1F000C8
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837744;
	bh=boLpSwZovCNSbV6begV60ngPtUAPKB0G+tLPneL5NsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DoJwrwy9RPsWJ6r6f+qOn0SlMC3i+Ua2zZOcX3/0fGWSGjRU18aF6R762WscXZsYn
	 9ortOczUXLtL8jmjyUaCx39k/sdCiyUV4ViIlBhwsARJ0BO474UVJimpfnl7CczfMC
	 9k5QEh9Vj0AwYeYi7TemGA8hak1XNepRP7IJ1QpjPS3AhP6T/6NTp9mKKHfGMOuqEP
	 tJUMgfGy8YEHzvXwnY33GVuOJRlFsi+ecYxc+mSeqdzMWSm9e26ozdcKYKmgXTY344
	 +09oWnIxDYNap6Ptgc7XkP0OzwY4QqWBYNSsqmaLBGl6DRaawz1kmHOpSdRawSNgyM
	 gVjq5QxBdSZkg==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-677d35fd1d2so3329025d50.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:02:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGt+aIHlK/tFAZMCSVOTWv1DtxRrIkGBThTJ2kC/6vyZVN0ukwu5nwMT0V39HcRQLE4OYbJjmw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ug+BZchpwymHbEcWY3XeHslKlq/dINMOth/Er1Znbur6/+efi
	172fjr5FXh4Xz9SlDSH+Gd2y8zG+IKASieR2jTVQG8vyktdD5crv1BJINkpE5YHHRxB2+uQgBLr
	6f4iuD0wqFY7iXIyVbwlM1NCL2GxsYls=
X-Received: by 2002:a05:690e:128e:b0:676:2dce:8e95 with SMTP id
 956f58d0204a3-67d89339c46mr5350286d50.13.1794837743410; Mon, 16 Nov 2026
 06:02:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116124753.2521705-1-icb@fastmail.org>
In-Reply-To: <20261116124753.2521705-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 16 Nov 2026 23:02:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd83pm2zOowa03S=LovSAHYWapbj1DVBN7EGKm8pubB5Zg@mail.gmail.com>
X-Gm-Features: AclHuK89cx2g8b9Yn2D97GID27FDj8i24KcoiqO1OLWd529Xrah391t8xFV_890
Message-ID: <CAKYAXd83pm2zOowa03S=LovSAHYWapbj1DVBN7EGKm8pubB5Zg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: do not treat an unreadable security descriptor as none
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:48=E2=80=AFPM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> On acl_xattr shares, a failed security descriptor load makes access
> checks fall back to POSIX permissions. An allocation or read failure
> can therefore bypass a stored deny ACE. Security queries also fall
> back, returning a descriptor built from the inode instead.
>
> Fail access checks and security queries on allocation and read errors.
> Keep the existing fallback for missing xattrs, unsupported xattrs, and
> malformed or stale descriptors.
>
> Propagate POSIX ACL read and allocation failures during descriptor
> validation too. Otherwise, hashing an unreadable ACL as absent can
> make a valid descriptor appear stale and allow the same fallback.
> Leave the descriptor store path's error handling unchanged.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Fixes: f44158485826 ("cifsd: add file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks.
