Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475425;
	b=FbtkB/bDsQ8gNC5aWA7/LoLkV84bCpBHU0Fx00l+5oHcaR5zICnBNKEbylGcexz/n5vh
	 H7Bl5NK5q+nMD/x6Co3Jroe+xIoJHTln2n5Y1FXCEBhGbeJkGz5Wzcj+AExvW9r3ujgF5
	 /5SHatrjVulpm8mMTyXq4AainLICMN6eBlagyfD9gtHPXNp5TZfWW03EAZmQvVMEoQ6rA
	 2jlE8RqIYTaIxpEsVlDxs8ArK+Po3WtmjA/bxOp0hxl4NAlbEw/U8BOLAnFh2+m5RxmLT
	 iHs9dNfSHJmNfUfenDilkqEvzUUNuYX6GLHyIxI6dHCbC6hSJ7jhNdqjTuuErD52LPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475425;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UweiNxwHTgAt8ftm1WMDIgqwHu2JV76yvvj/0FyLrMo=;
	b=ImWhOYWeG65XxobKgLTwf/6BLdCmFOTNquFnW8fHBwfDTLMii4/AX8zbRNIv2lAudoH2
	 E5hRcy/NaiJuEFYNGHSO+eTspZ0v04VPw001XiiPJNeUsJpkT+pNu0FfuHwcm3kNhQHhY
	 kBL/c1yut4XXSmt6zcK8L8ie3G00XgJ+/KyYNTI/7e4/xJ5+SHcyo3zEsWlGFZ9LFXp+H
	 X6elM2edAQXFSJ8gSJrRVMmhjz9JRkcD+IFV1LhEUnt2VCE6orhhB09qMzX40OmHOKPkR
	 wjMc5en42hs0i6Ijlbz71MDKfCOH3qHACmLPOolKKOd0glGsgyd+fxloom5rxffr3RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="InmrsLK/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F49606A687
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InmrsLK/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BAD1F000D1
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795475425;
	bh=UweiNxwHTgAt8ftm1WMDIgqwHu2JV76yvvj/0FyLrMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=InmrsLK/C0w81AoTH36Guq044eXaHTaE9H2/e/a2WMo3/qsvxL23gpeZhOP0ejjWZ
	 dgZTX/5kwmWZInPfAYHR24Z+sEjy5hk6lUjV5XJwM3zYhVQCWB2enw0ll/AG2iKmdG
	 tGtqeMAGeAUHaoUjK0nOO9ioUkOcvK/1/yYCLJcFAE3aFkIyhoPpEKOP86o/i/t6WZ
	 8INUX18DckKCnHOt+78cEI5f0Eoc+iNZifXfG/lNW/5XcWJ/axKT4i0Omq8U9LjieQ
	 U6zYdPMSDOtG5ryj51D5CPm4q/cF9Ar5W7DPRUg1giWvf5fvtC45QEnqAGYmRgn809
	 u/PU9e6SrOeDQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so6551077a12.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:10:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEPEH7QGOutlNZQadypcWUFkzKQZkyBo5NNZIMAMt2NDPn/3JKAR8a1cT5nR/sVEpaPXaHfcy8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gA9+zfoYgbzDg1y6zXbrBTK/0xvEZJIueUh5oY+X2TaapBEMg
	hdfBNeXeiTxwV2V+r5lAilDFFrFcjwAoWW4IuoZrtln9XGVeqblA7xvM6bWCYM2WMKFp/fmX0Gs
	51nv+GTy8xXvYKcoWCgGgagis93jcTLk=
X-Received: by 2002:a05:6402:210a:b0:6ba:4bf3:4a7 with SMTP id
 4fb4d7f45d1cf-6ba4bf3066fmr8378296a12.23.1795475418624; Mon, 23 Nov 2026
 15:10:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122160149.403491-1-icb@fastmail.org>
In-Reply-To: <20261122160149.403491-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 24 Nov 2026 08:10:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_4V=XDhnkMgZ7AyumGW+x86wxMwP8Pk-04aSYXYeHreg@mail.gmail.com>
X-Gm-Features: Aa3M54pmdqZ2Mt_rbU3GRlwVD6xqCo0bkVzkOT0-8D6p05zezDl8vNMe6n1NLTA
Message-ID: <CAKYAXd_4V=XDhnkMgZ7AyumGW+x86wxMwP8Pk-04aSYXYeHreg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: return only the control flags of the parts in a
 query reply
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 1:02=E2=80=AFAM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> build_sec_desc() copies the stored control flags into the query reply
> and clears only the DACL flags when the DACL is not requested. A
> SET_INFO without DACL_PRESENT stores the control word as the client
> sent it. Its other flags then appear in every reply, such as
> OWNER_DEFAULTED in a reply without the owner, and SACL_PRESENT
> although ksmbd refuses to query the SACL.
>
> Copy a stored control flag into the reply only when the part it goes
> with is in the reply. OWNER_DEFAULTED goes with the owner and
> GROUP_DEFAULTED with the group. DACL_PRESENT, DACL_DEFAULTED,
> DACL_AUTO_INHERITED and DACL_PROTECTED go with the DACL. The SACL
> flags and the other stored bits, such as SERVER_SECURITY and
> RM_CONTROL_VALID, are not copied.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
