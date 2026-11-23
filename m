Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475398;
	b=BKDCU0QrdJI5kBu1RNyOOyMXQbg+OMLy6zC7onXQ+yXUDPiiUD0KMKvBzQHArvvG3n2T
	 LskTZ7keEgBrJCUok9GGu9tzWywnrSl6JkihxSPTtUOeoIt8sgk4fvI0BqeJLDBUTRXc3
	 IzSHm9tDcMm2LtaW1aUPqqStmeCfM5sgI9zI2xMxDyJPdpnw/XNge+2JOWe+4+5J1r5fD
	 pPnZdheDQ8QIGb7x9lMeV2sR+k1+58PIvekORjrn6DB70BCzIje6ShyNGTSFpRVofjQij
	 5ACpwPqqau21EXKWIkc2lOiB1XgCaeoziW/6Oya39Ft6Dy5HGeFOxtle3Te3TBx2oCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475398;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dE4EaqDyK41gAj04ZPpghBrG/bBl2Jc6ioru4NaQWk4=;
	b=EQ9536yO1E1UFEdtZcExy5jrJZC+uL3UWeF149y9d/mhDd0isJO2f4LtjMhf17ACr9yI
	 vLzp9jLR5uolqgboeEEeqEOhjkIKVS+LB0Zy1g9nM8Ja8DI5NntqOFBqaErtUOkG4ffRe
	 vznzjaY7Doxlg05gyPtjhBEqVPnLQxSVHHt83ZYmZ774GEFfI9W/y+QhB8DKBo9J8vLlq
	 g7kuyQaEQV7HCzCKhGw4KGTWQz+R3XG9J0Kkp0wj/OW1/nfkqH1hJt9SUVL+DNNiBlFc4
	 NrNQuGBjfmCrLO+9d0Y+eN0uk0TN5mnne7bMskjp6jdMDf9MgmywhwD/8vROZukU2BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlPTtXXP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7043606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlPTtXXP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58631F000D1
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795475397;
	bh=dE4EaqDyK41gAj04ZPpghBrG/bBl2Jc6ioru4NaQWk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WlPTtXXPaEhtS0UNcttHmNX9yIWLASI3pzLGLNt0v8NJfuYvC9Ale1DYta/z2oe8W
	 Qrw2Vb2UHID1u77Hy0264Rwh1aEwUYIwu2VUKorji0Bp96MMOyq1Gk/nkgON2L3G3i
	 6KpfsHkq4894oIuyQE8TGjf9sedVbEdCo70GWSTzu4oPfddMAQwZ2g6TzzDetMS8Rz
	 cCvYZtCcia/etrczLHrv1hRNmTaOztxzZRfOrwXAz6W0YIuJyMugf4v2QJ09fsd67P
	 sX5CV8em7aDuLHIV+FaXolM7gnaBLv14/W01td8TS1ySmSNcKuLgXLAKPRZOlG04lT
	 G/ygW/91HhIfQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c513a854320so640782866b.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:09:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFAjLQRPcX6rN/Dghqinw4blguzqgafiEHi9gJ6XhXRevR+eg+GZoDlm9GV4sCuhJNsPL/yOhQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mG/7hzRMFsJPJPvhjfsgjxdcj52srqWJu0qa2nxjQMwwhefuN
	uH5NjTD94neogi3eLfjWBrjTVdSYxrNyonLqzTLkqS34V4TbCN1xt1jHWQgR19cGPNE7DOYGWu8
	KxJn4UtegJpZcF+/8rS/gRp19MLC3sYQ=
X-Received: by 2002:a17:906:f8d2:b0:c50:bf14:8eb1 with SMTP id
 a640c23a62f3a-c513a84d84emr825676166b.14.1795475396432; Mon, 23 Nov 2026
 15:09:56 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122155604.401963-1-icb@fastmail.org>
In-Reply-To: <20261122155604.401963-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 24 Nov 2026 08:09:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-u5tFFu1W1qSD5v4crSdRXc1VdD-n2LKRbWo=GS2izEg@mail.gmail.com>
X-Gm-Features: Aa3M54qCrHEh_Sq068v7ffrEsHDVyhRBFdMOgL5-5OEMKKg3aevGtdGfOT_QBM0
Message-ID: <CAKYAXd-u5tFFu1W1qSD5v4crSdRXc1VdD-n2LKRbWo=GS2izEg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: reject a security descriptor with OffsetDacl but
 no DACL_PRESENT
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 12:56=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> parse_sec_desc() returns early when DACL_PRESENT is clear and checks
> nothing else in the descriptor. set_info_sec() then removes the POSIX
> ACLs and stores the descriptor as sent, OffsetDacl included. The
> access check, inheritance and QUERY use the DACL at OffsetDacl without
> looking at DACL_PRESENT. A SET_INFO without the flag can therefore
> store a DACL that was never checked or mapped to the mode, and that
> DACL is enforced.
>
> A descriptor without DACL_PRESENT has no DACL, so its OffsetDacl must
> be zero. Reject a nonzero OffsetDacl in that case with -EINVAL, as
> parse_sec_desc() does for other malformed descriptors.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
