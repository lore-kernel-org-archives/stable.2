Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918059;
	b=jBmRZYt99YwdhKKCfl6qSi6nxehsBsizgE9ne1i61BOuYOQNCe7oEkrTXAvAshmxyDvX
	 zllxRaL94VM9IkPOHDb2wOs2gzL8v+tZrJd0kM+Mdwmv/q2LKwOwhOGvTrZuhNOOHcSzR
	 Vjmzwd8pjKV0vy7V5KldCr3nx20M5YmsI1cuO/iCUldEdwpuk5dwTnGdKLnPcNGG/Rvsj
	 rwlu9lu0H5jd/uJwUP8LtR0MHt4dk6YCze+wxU58e0Fek/SkoDFihrMt3erbf7o3Khs7t
	 W1GSs3ow/y4lpr3BsQZoSoiLNTPzFX+b6GHYdK2OHKbBVBl4jxfMYvKeNRp2DAetjrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918059;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iIWyxXCkV5ahjt2ebCV4WwQbZmTr+s4l0TyythVjJvU=;
	b=wiwTfOOJsffo2n9hlqMUtF/zemaFU7+tjkWqrGXEaoz/wNchdZ5Bv+GH/qni0alluWzq
	 +a/3rkA7ZVmPNTQU9jj1bbo1fSr44f7W1WW7lvf2JGgXbV2wbgwd92vJZmw7WuHJEqr4g
	 5PEMW+SjxljAsF4lXdlBAdutMIMmWcIH7q2yDvyadgP+jcpnPdWai5ImQu96Jdafw3Hnv
	 g6Nnz/7pPHnNxBUZ20gquvVuFsbCFoG5GauxPvBeyD2LeUhhPx0ETpt806CXTwTLkwclJ
	 HGi3KaI0MMyNNux8Hgv7o9J1o3X965lvDQd1f+fUJJkJj14MiVFJ0V2oDY4d6fLJ/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpTQOPsa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557E606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpTQOPsa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5061F008A5
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 22:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793918058;
	bh=iIWyxXCkV5ahjt2ebCV4WwQbZmTr+s4l0TyythVjJvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LpTQOPsazkS046yyu7iM/H6joY8tK05w+5aAecGuEF859grYWgXiB0qwH94f0v91u
	 H9ZGV95ZVEp372EQYcpdhqBDbwWyETlxO2MXUA+Kfpvgf4kaeZdumCilG321pHF9fQ
	 ir6w9AtFriLkQ3QBwri1xhrULnMmAqYMi2mSQZC/w5ZUVw+on9rPT+jT/CJx8win4o
	 jfxSzyYGtPSo7RvCK6NdMtRJ22dkTptcY9L4IxSHXlxoEvTOO3Zty8Frw2PEg2OQK6
	 mocIswp3bXfJLwXQtJFWJf++XgzHtVg258tnU4Nh3VhIx2xXS30WX16kqoEB0VDvM6
	 odTsR0MKM4pPw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so1195643a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 14:34:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByHn/64uGo3Sb7B0513z8E+dS1Bq4Ny61Wb4Cvxuftaca8j+4BuOi30AJ/HsnpEQtZuW72E5wU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NlPqoF5y9AaQZazNalru+iFO26ysf6FC3yjE5xRLJoevLYYjZ
	pNClfefZ03I32ARnC75RjLR2S5iIQ/uV4SG7mJltF8U+PMz1uZ8Bf26Bd5FmfdGFlPOu3cJb7+b
	r/OUtSVMbCMEcI/kNXlpundEVzWNVsIc=
X-Received: by 2002:a17:906:ef03:b0:c40:2439:4d9a with SMTP id
 a640c23a62f3a-c4d207ad09fmr313558066b.28.1793918056929; Thu, 05 Nov 2026
 14:34:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105173838.1882328-1-wahidzk0091@gmail.com> <20261105211943.696696-1-icb@fastmail.org>
In-Reply-To: <20261105211943.696696-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 6 Nov 2026 07:34:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8E-tBJhmfYdT7bwikCj2dN_sk_L5aSrAjyKX3-4wAZCA@mail.gmail.com>
X-Gm-Features: AclHuK9MVVizSVLgfQxPDF_PUbcOqVST15KpDkJmfqMFUIuoIHX5YpXWT38l6mk
Message-ID: <CAKYAXd8E-tBJhmfYdT7bwikCj2dN_sk_L5aSrAjyKX3-4wAZCA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: refuse to read a handle that is not open for reading
To: Ian Bridges <icb@fastmail.org>
Cc: Wahid Khan <wahidzk0091@gmail.com>, smfrench@gmail.com, senozhatsky@chromium.org, 
	tom@talpey.com, chenxiaosong@chenxiaosong.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:19=E2=80=AFAM Ian Bridges <icb@fastmail.org> wrote=
:
>
> On Thu, Nov 05, 2026 at 11:08:38PM +0530, Wahid Khan wrote:
> > Return STATUS_ACCESS_DENIED when the file is not readable.
>
> Tested on ksmbd-for-next with KASAN. A READ on a handle opened for
> FILE_WRITE_DATA | FILE_EXECUTE | FILE_READ_ATTRIBUTES hits the warning
> before and gets STATUS_ACCESS_DENIED after. smbtorture gives the same
> results as without the patch.
>
> Reviewed-by: Ian Bridges <icb@fastmail.org>
> Tested-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
