Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470665;
	b=W1D8KfsTGNhVtu4m/Kgliil0sTI5UhXrNsPRigibAfugfKs+YjBAL9cughJgjOusbWQC
	 wy4DKvBS/eslBccyO5r2C4UXc5REM43t04Am+cfXdJG83LoYjsFs2zRl9dhEYlgrbgrsg
	 Bd7FHqx5T/9TSk9TpP/1ZlvBPZvbUWs0dSBB1INU6HHGDMb3+5+FNX3DX8rK/IYhFc4Sn
	 oBY3RSIMADT24xnCcaacjtjEGOgZh2tp5x+roz0594/VvTpmAEeehgjwVk20M7wYLkoVM
	 0QJXbDoE7b0XNPo6agUJEae5mTsTiSVkTuDJb5hEV6jyjQTPIcwFPs7SIMay14s/vsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470665;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=urX3RICoBxceIT+XA28WODylzdo5p8L+qYkoDoKFlCY=;
	b=Axnb1DmHy0MeJX5WQa3TJ9I/s1aJ3lcVcGlJ4aUKKCBWBvIqF+Rs6QQcOG8yEYI1GcNF
	 iXPJ7EuClSjf0cEyMY/MNDtVx7SR3vwVmkSrWTRBoxSsEiWn0XVwyHQmTwYCBGbmNrPd3
	 57fsA2dQePyac022cQVOOvGaOPqu0Zn/MdRIsILJXRcvF3MSIMXogTHIYxvt48DIaNKi4
	 Lgb7tvunmc9zElwa3R9ahLPKYxbtwXc+PI8ew35LXnW988dZdGWYLKZ8Tc1JjQ1tdrvxG
	 vxYuhiq22pY7Py7Z+g7dyrHtYzyGlp+hij2EtwYieiSKxvH2smN6tA0kL/mnTe+491g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K/riakyQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3BC606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/riakyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C3E1F00A05
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470664;
	bh=urX3RICoBxceIT+XA28WODylzdo5p8L+qYkoDoKFlCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K/riakyQl0ZGUvrkZE3wkobQfHGpspERskTgajQQj/qINJJI0GLsxHgkd8Hi9FYu7
	 mIDzNXJZrVVjrkcka2mNlSgttDcw2656pS6kX5W/YSsfmd6UnL6gGstMDNY04NYizW
	 CcQAgR3TNYPBUhIWSb8p9rzhI5aiR1cQNikDKYmR0T9I2eGtnY69TpLmU2FtDc0dnS
	 LHJzkmmH5961CTcgoqHDYKQ9PQQoNvbKVdgCYEGFTLDILSPbeij/DezJsOXm96Bqc5
	 i5qoDTIcO0jhPJ19VN4jvEAAt+BNHX179Xi7vTdtRjOB7y/ZZh75Dq7QnpnBDFtEbr
	 xk7i2jquiZvPQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4682977f9aso514227266b.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:04:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGzDao9AfQKgIYJAgCq7SgpiV6VS9J63RjIcQTShohyAeA6Cv33BQtG+e8ajED5jqT2kRh1qZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KZxiV2jGiutf3ovFlTn06tFpmwC/U1rhbWrwL3l9XeLCLIkM6
	fu5vj85/o+ksJZiVGvQ0TkYgB8tbp5hEv33huEnMekWkBCaySlmXiOrv9eOYE+DrE2cg7r1qNmJ
	W0ZlZIAptv7BjB9t4x+HLc9LtWrqF+mU=
X-Received: by 2002:a17:906:4fca:b0:c50:6005:9133 with SMTP id
 a640c23a62f3a-c5066aaaac4mr342294866b.8.1794470663283; Thu, 12 Nov 2026
 00:04:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112045238.4688-1-mike.michalo@gmail.com>
In-Reply-To: <20261112045238.4688-1-mike.michalo@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 12 Nov 2026 17:04:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9h0jr3BA3tzh9xLP=Kb1Az1C2d+iEFaybzqdZ9dq84zQ@mail.gmail.com>
X-Gm-Features: AclHuK92ID_U7ycQrHXwV5e-9b_Q98zbuWa52wf8PsvE5qRXVAEL0gUhY9EpaQw
Message-ID: <CAKYAXd9h0jr3BA3tzh9xLP=Kb1Az1C2d+iEFaybzqdZ9dq84zQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix out-of-bounds read in expired-session LOCK check
To: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Cc: icb@fastmail.org, senozhatsky@chromium.org, tom@talpey.com, 
	chenxiaosong@chenxiaosong.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 1:52=E2=80=AFPM Michail Andreas Michalopoulos
<mike.michalo@gmail.com> wrote:
>
> On top of linux-next 20261105 with the four newer ksmbd-for-next commits
> up to a4277e7b7682, under KASAN, with session expiry forced by a
> test-only hook as in your notes. With well-formed requests on an expired
> session, before and after the patch:
>
> - an unlock succeeds and releases the range; another client can then
>   lock it
> - a new lock, and a request that unlocks one range and locks another,
>   both return STATUS_NETWORK_SESSION_EXPIRED and change nothing
> - a compound of an unlock and a lock returns STATUS_SUCCESS and
>   STATUS_NETWORK_SESSION_EXPIRED
> - READ is refused; CLOSE and LOGOFF succeed
>
> These results are the same with and without the patch, with no KASAN
> reports.
> I did not test the malformed request itself.
>
> One difference, for the better: a LOCK with a bad signature on an
> expired session now goes through the signature check in
> __process_request(), so it gets an unsigned STATUS_ACCESS_DENIED instead
> of a STATUS_NETWORK_SESSION_EXPIRED signed with the session's key. Patch
> 5/8 of my v5 signing series fixes the same thing for the other commands;
> the two patches do not overlap.
>
> Tested-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Applied it to #ksmbd-for-next.
Thanks!
