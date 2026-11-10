Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320929;
	b=KVG+G6eHDAWWG4L+thgOvBVTsMxU+JxuHt2IDCG8xGG8B7Z65/5TOdUi+ou0aH4aktdE
	 ZNtntpgpNyjvzXWZZFX+LGjxgY0LaPhNHpwCDr+djliSVRkq/FF0wrMS/+nxjEIIG/1Ln
	 HAkF0yITHP+Y4YgMh/rv4Z8ranBZbAbf+GAFWz0R0wUUFHJuxOFTBls/cYoXBSKACN1zk
	 0Ff/B1hmozO5E5CtLsj8vjt2LZAXHQyk8Vmmv90u7vV3pq35PWvgDTf+G5WskL8rGoaKl
	 Y83Z6G9Qc7zmhdJXCpvDUKhuddt99bdrdWp9De/w6aW1z8aJsPSMG5KigFJ7CtnzvZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320929;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hTplsrgAQ9xqtxIf9pTXzacL7isLuWlgFx6IOikQwU0=;
	b=z/Fowb0vb4uC9St5paqrrShwgqWUDZCIkZSenXUCuVz/S2vflyi2QaVRtEna2pPZh/aM
	 8SnMSKwll5i+RCwMAALP9kk0Jihc/FizSkUZHqUX7maTzmylbrBmlKMRI1Jjx+vtJAYpj
	 6bC4kyJvwQ6o1r5X3Hj8IKY6k19/AbEY8/1aSl2MIJC/XyVo1Vtlzh18u4/otuhvOd5Pd
	 sJyuSo7TGi2N8itRSjBrey25PCicrRTImirKsvb8SWFWL8i9g39bKnlgpNxOWdeHKubXs
	 sEkSSXwr9q8fhDlEoumaGdISu1th3jGVvizwxDgqOmEDi62mndKdQtPCq3NsLKUXSDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feMvmicr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941C606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feMvmicr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60D11F008A6
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320928;
	bh=hTplsrgAQ9xqtxIf9pTXzacL7isLuWlgFx6IOikQwU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=feMvmicr7zLGaL1Pc6AjRarPmItbQ/xVekZhQ/wehNoRzBuhRf6uzH/w0dfgvUxjS
	 8q3xneSal1QDc7X8ki+9MW6/lHBwxCJXACiGJFvc/ZYM00B99kvu9adBarDLlnhjI/
	 fOIpOJXUHxAYR5fPR869O8/V6CgO4wvvSi1PQtKhqFhnhK071ZZuJeAS6Oa8RbnY5h
	 S7JjvkzPGXKpwSnJ6HS6bh1P/MT9Qd2ihfegHMSHe/BK1kKukgSS+HdjUrVLTx+Ugv
	 stOa/pfBs5mse+tjz1rbCJo1Fi/Asv7XCoLX5/m2EQruvyvpkPIBII4CwCWl9M+yaC
	 /7dtTe6ytWVCw==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6767d92cde6so2269058d50.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:28:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFVKaNd3AnG74jZOMmDe1jb8Wkz0yWvuH6i9tQBomUc0oAMROKTP5wjAUbkmXl6NEUuE6/YNCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CSnf313HmaS7TWubT37FJhFNsfFaZxfULSvjzB8Oirqg4snnr
	NJkQdDLqMcSCBMiGUWvDa95SN2gV1tA9FPPc0HNVjT+9y7L9Rd0/4I1HnmgubsopwGM+Od62FgN
	8IVpFzX74bqqCGSyGK2YCGWOFH6+jFDk=
X-Received: by 2002:a05:690e:134f:b0:67b:fbde:ba7a with SMTP id
 956f58d0204a3-67c568bcbd7mr1639184d50.85.1794320928054; Tue, 10 Nov 2026
 06:28:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109195813.24238-1-mike.michalo@gmail.com>
In-Reply-To: <20261109195813.24238-1-mike.michalo@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 10 Nov 2026 23:28:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-YAkeXs8K_EJyWFqOSFJ8XHWSt4A4D6BtD2uqVp6Bnug@mail.gmail.com>
X-Gm-Features: AclHuK9sFG4Af_a2IuBl1KesEPg4xBLh7HHkfluv2QH0-NYqb7AYPRPkVA2LPBM
Message-ID: <CAKYAXd-YAkeXs8K_EJyWFqOSFJ8XHWSt4A4D6BtD2uqVp6Bnug@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: refuse reauthentication of an expired session as
 another user
To: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Cc: stfrench@microsoft.com, senozhatsky@chromium.org, tom@talpey.com, 
	chenxiaosong@chenxiaosong.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 4:58=E2=80=AFAM Michail Andreas Michalopoulos
<mike.michalo@gmail.com> wrote:
>
> When a Kerberos session expires, its owner can reauthenticate it. For an
> NTLM reauthentication, ntlm_authenticate() only compares the new user wit=
h
> sess->user when the session is still valid. An expired session is in
> SMB2_SESSION_IN_PROGRESS during the reauthentication, so it takes the
> other branch and simply sets sess->user to the new user:
>
> - the session's open files, tree connects and other state, created under
>   the original user's identity, now belong to whichever user just
>   authenticated, and a later Kerberos reauthentication is compared
>   against that user rather than the original one;
> - the original struct ksmbd_user is overwritten without being freed.
>
> krb5_authenticate() already refuses a different user in this case, and
> the valid-session branch of ntlm_authenticate() does too. Do the same for
> an expired session: compare with the existing user and refuse a different
> one with -EKEYREJECTED, freeing the newly looked-up user either way.
>
> An AI assistant was used to find and fix this and as an independent
> reviewer.
>
> Fixes: a47634cd729b ("ksmbd: expire SMB sessions when Kerberos tickets ex=
pire")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Applied it to #ksmbd-for-next.
Thanks!
