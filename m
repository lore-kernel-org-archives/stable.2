Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468594;
	b=2gKDgHjvsQDkgIzT/gix9y2glsUckI4/dQ+ctwqiyF183zCDflZPjJ2Viyf6qwJ7dswC
	 IB3NZql0QNqE6fDc/tp7EUEckrfra8ZOTHJweNwj8hYH4IeM/EuaalCMyp6DfZ0vWoCuA
	 xXFFobe49lfSz8+Cmig2yVx4lg9aB6SHkBpbsezb0DbRWaB5F71yBnhUbvwgP706XVgw1
	 y/lzQWKKaM3ieLleW81b8BJ5IRQ0u8SorhZZrap19RA61Aenl1ygIMYOB+sdfkBLi8tKV
	 TvpNq069MQG7aa/TF4e82Php2LiePD0uo1UASIe8OZmgFVakvNQ4jqeJ5ygkr8g875g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468594;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lMsj9nudmBv/iI5Os6pRVy6bLDebR7965kvSPVwO+Vg=;
	b=wkfCEn7bF7CySKl6qoe1zR1lbT7+Xkqp2azJfHqLzpnugN+LzM6yK9Lff8xouMS+NkQ6
	 R9yF2XChaLD9R5GtCHg+uWQy0ph8JveDBNLy/dOyST3r8AidwQzokAEL4IGMht8LdU2Pf
	 6WgCNGPh2jCs1ALJvCMxFz/OMnhZDwAMxRYXVZaVwRiWmppWGpOwwVO9c6fo47eeD0qHc
	 udZGOdi4i66R1TF3bbfTSrPJI2vUj3N/qT5PdX07E3gviE5qnE/KW2r6y67P8yKzC6CfZ
	 I921fhIfhSj+wYmIPnVvzh1B1+lchDYSApUxJoGAkJanjzPoHQbEQXgNQAhUduwzIcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZPX1ieU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087AF606A331
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZPX1ieU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91C31F00A0C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794468593;
	bh=lMsj9nudmBv/iI5Os6pRVy6bLDebR7965kvSPVwO+Vg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OZPX1ieU+LbZoavvKaae8CDwAXx0pXP/AVuIjvVIEP0B5iqW5LhQXjbWE2Nmk00ow
	 thRg7jxz6UwzjBfNsrToylEh9RR0J02ECSLdMFzun+Fy03Ax7UAvIp7YXgdR3WaIL2
	 2ip22Ghvkzq1/YV9OKlCgCgP34BE6rJWRjVrD1lvXNG+iF7B5fIUf3qGjn/c4nG2se
	 ZJcnsTVICDY7h74vfvoDzKA5u78tH5xp8jkmt8jT5DLdRnoAVMMNrqSfCLxIjqt64E
	 7S+AwaS1E5uYdLaDoPSv8bRPQqNEzzPOfry0H6Vv/RErkHpEgi+8wnZpx4COFPE6vQ
	 +lcdFr/WJdCeg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so814133a12.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:29:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGG9QrtjsdvWPIbLd/Vby4AfzlGq380r1WfM5ZzD1es7OpvxLbajlS3FQFyNd4CUiTaABoU6KQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z99lrm/wrxLOfdRfzKh75Tkp21ED2IY3gIT4HYslK3SUS5MfAxJ
	4qr5wF8K9HnyUvluOVsGboxuFfTHUohRIY7/MnuGV842LLpkmh0R2oMLuZvpYQjmNNW/ELvLWum
	OLuFmUrIZaOOqsuE3u3UAqJrxAvFb+HE=
X-Received: by 2002:a17:907:ea8f:b0:c25:4d9e:bb28 with SMTP id
 a640c23a62f3a-c507b396562mr148147766b.3.1794468592306; Wed, 11 Nov 2026
 23:29:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111222534.839117-1-koray.fra@gmail.com> <20261112031157.677256-1-icb@fastmail.org>
In-Reply-To: <20261112031157.677256-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 12 Nov 2026 16:29:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9u1EQWXwxiGfdTyvsDCRoYpDTo97A-hqjPKZ868S+3sA@mail.gmail.com>
X-Gm-Features: AclHuK89hAf45QYH6l79cOyFN2CoMoYTpTZ7STKRVcYi0T6MEFvVcHL7RDTmuoc
Message-ID: <CAKYAXd9u1EQWXwxiGfdTyvsDCRoYpDTo97A-hqjPKZ868S+3sA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix timestamp corruption on special values
To: Ian Bridges <icb@fastmail.org>
Cc: koray.fra@gmail.com, senozhatsky@chromium.org, tom@talpey.com, 
	chenxiaosong@chenxiaosong.com, hyc.lee@gmail.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 12:12=E2=80=AFPM Ian Bridges <icb@fastmail.org> wro=
te:
>
> Hi,
>
> On Wed, Nov 11, 2026 at 11:25:34PM +0100, koraynilay wrote:
> > When a timestamp is being sent with "-1" or "-2" as its value because i=
t
> > should be ignored, as specified in MS-FSCC 2.4.7 FileBasicInformation,
> > ksmbd would clobber it in both the xattr and on-disk value by setting i=
t
> > to -1.
>
> I tested this with the ksmbd code from ksmbd-for-next. Before the
> patch, setting any of the four times to -1 or -2 stored that value.
> The access and write times on disk moved to 1901, and the creation
> time in the DOS attribute xattr was overwritten. With the patch, -1
> and -2 leave every time unchanged, and valid times are still set as
> before. smbtorture confirms the result in the commit message, the rest
> of its results are unchanged, and KASAN reports nothing.
>
> Reviewed-by: Ian Bridges <icb@fastmail.org>
> Tested-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
