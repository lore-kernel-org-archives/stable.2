Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794738297;
	b=NCp0e4+jNLhMFQcINc+iCQ+GlTlRa+C+dmpyF5yCaPnO9n5B8IFZyoj7NGoHRsxrxHEO
	 qPa5pB7P43XBC+AwXk5o14acbw8T3+VL39ItqawrjsYhUCWhvEYkwOnEd3JVgbi+4PHLs
	 B+1OYzTj5RpfPODNNMN7diHmSKXL6DxC7vjTmNqJfIQHYAL0mYIlAvGWP0QTH3Yl2Xiyw
	 /2hMd1H7Ogx33Xxe2KkgQk/VZuEjlmAp2myw+GRxKmQ+3kZ9HnxfrVrjkdnqR2RXKr1cU
	 H4ShEe1/EkXA2psjNgR0nJhgdAypBwR7MU88NL7kKDNVQmynd1bCRr2g1hxIh89IDqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794738297;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2WmaPkAU61cRhma5/8IgFi4ZjEc4nvEL6sRH/PjYwmU=;
	b=QHYrOssp2r57MQndF7p6M3zz5yTO2I4NzkfB6SRngVLnsX/uAJrLj9F+bhHYCyUNHz5P
	 +l7n9VRyxhv6b+nFt0u3uMgK9+Tdjehwwz1m69g0W/DIbhBSjvEhH2aFxN8qjAqUWdA3N
	 nlURHpPwhiqxqlnXEQfLoK+5nzOjsacbVtAvRwh5BjnSO3hQIdFEnFEyvRlI/2rV5t8zU
	 GiEH5fTI3k+J7Ec6Ykwem9CEPeMERyZuy3JYhci9u7chJQsJC9+tKK/bg+7ATnIXzboXb
	 bcSEhAjqmyyrfqZMFYzBUx3B6lyGjlofBVLMkLJ7vge1l6Fkk2HaPzfYQVdp9Th7NHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6bNlPK0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7ED606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6bNlPK0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0191F000C4
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794738297;
	bh=2WmaPkAU61cRhma5/8IgFi4ZjEc4nvEL6sRH/PjYwmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V6bNlPK0X2sJNy3jXVTsp86Qt8FuRhELj2BvpwxJv1qE+nYVOXKRt/ZRLM7ianC/c
	 VzFP98fOOo7xtaD+x0R0B6AJjXRraS4lVjsWRSRvkHdcQHZq07+3nfzNjSJuOwK4n/
	 kFA6lB6PJDOmxupYFCgbTAORutbOzNGjwPhYFNsc6HcJuaCNDIr4q3cWNRaLAjJHLB
	 ZhQ15nXoUu8NsY+Nu27Tk6CIYm9w3ZJryYeMQUrpg+q2rEL9QV0ISeEl1Oy+3CeHgO
	 OUbymSi7Qwo2LLANrLCU2mmC0x7N1NXGgbPjxopbrWsd1bWyl1HUf6XRNhG2cWU7O/
	 SfRAZ0fMxtbXA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d427836e9so332797166b.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:24:57 -0800 (PST)
X-Gm-Message-State: APuU4Z/tq0mFq7W6Lh1XgzHduA7lpvAWPJG97YcEXJE3IHidwrnr8eqj
	O0JCEbIxGidnQR7aakImZCx9JwzlUERCfapRTGf43I8iUXlwlU9+kmrrxKakyWNSTAXO8MkXYyv
	qJRvAxTHBLrmKdxyCzGQO5mNICUDoSdM=
X-Received: by 2002:a17:907:6d02:b0:c46:9ca9:f524 with SMTP id
 a640c23a62f3a-c50963b6917mr599880866b.32.1794738296075; Sun, 15 Nov 2026
 02:24:56 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115021340.17611-1-mike.michalo@gmail.com>
In-Reply-To: <20261115021340.17611-1-mike.michalo@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 15 Nov 2026 19:24:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-s5CCyGV+v==Q_bS94TKTCfrQ-e6v6Jy=e7_4Hv86Hnw@mail.gmail.com>
X-Gm-Features: AclHuK_Jio81fyLVp_TbMcOOHVXnCXP5NnO67AUwJWpWak2mm1WhNrJBvOJrR8E
Message-ID: <CAKYAXd-s5CCyGV+v==Q_bS94TKTCfrQ-e6v6Jy=e7_4Hv86Hnw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: refuse EA names that contain a NUL byte
To: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 11:13=E2=80=AFAM Michail Andreas Michalopoulos
<mike.michalo@gmail.com> wrote:
>
> smb2_set_ea() checks that an EA name is followed by a NUL, but not that
> it contains none. The xattr layer takes the name as a C string, so the
> name ends at the first NUL. An EA named "DOSATTRIB\0X" with EaNameLength
> 11 passes smb2_is_private_ea(), which compares all EaNameLength bytes,
> and is then stored as user.DOSATTRIB, the xattr in which ksmbd keeps
> the DOS attributes and creation time of a file. A client with only
> FILE_WRITE_EA on a file can so replace them, which commit 4ea46ea602fc
> ("ksmbd: protect private extended attributes") meant to prevent. Any
> other name with a NUL is stored under the part before it.
>
> An EA name is EaNameLength bytes followed by a single terminating NUL
> (MS-FSCC 2.4.15), so a NUL inside it is malformed. Refuse such an entry
> as one without the terminating NUL already is, with
> STATUS_EA_LIST_INCONSISTENT, for both SET_INFO and the EA buffer of a
> CREATE.
>
> An AI assistant was used to draft the patch and as an independent
> reviewer.
>
> Fixes: 4ea46ea602fc ("ksmbd: protect private extended attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Applied it to #ksmbd-for-next.
Thanks!
