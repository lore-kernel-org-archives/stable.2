Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832232;
	b=KvdvTh/x2xbgDYcxvcJiUmSXhP8rums8iqx4W1J88KYfga+UgbCtHt9yFEwt+c96pvUH
	 RG7EHYHlGmpBv86C7EplZ9100T3AQ/I7x1R7+GmD+/H/57igjo6k8aAV/+5ZrHMr6JkfQ
	 gO6ppEOLmX5naPipo8oFDpK2h9uDEaMphH8bR0FpnWleq7FZJ4DNdIupX+vJ5eQhBEqLR
	 38lnGEJGPzF0lANuAl7UtOXxy1lvCftWyzHykedm6ZOmgfy8QNJ7EZoJao4yuW1mqjwlg
	 KNf8SNmZtGDCwZWqhPOCJ4VW0k9TWx5SfTHyoAm2oEKit5x8/mh0ptn01F8UI7683AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832232;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2rkLY6y6+ClNNLzzESKqswesvWfc3fvsu05JVfc9L34=;
	b=jsfhLDFNnoNtaACao/SLI3Vxmi4QWjrJTFvRz88UrqeeegG1ErR6ZoEA9lJqpfRU2xmo
	 RIT8ieGClXHU8ACv7kSPMtszNXtTrNoaRj4Eer01zjhFNdgzQuP/6TdJHhFzsdiRt4KC1
	 TKJS1X9ugIJzEDzXJb40DMIZVsH0z6M0RfjHnDSMQW0bUuMpQXJKmt2KFgZik3NI0HGw/
	 DHeYmgE2AxKvdrD5yOc2zt7qR4lNVBOEZ1j7beoKf7GAaRbX/e9P9OUJb+I/zah+nQNux
	 84BUwgskzbvX8cLayh0rDYzOAmIx0GmQHnMnNDp40O4AjLVRw4HJpjmslMQfxtYiUgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtiVx2yc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250C606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtiVx2yc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36A31F00A15
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832231;
	bh=2rkLY6y6+ClNNLzzESKqswesvWfc3fvsu05JVfc9L34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mtiVx2yckBtGxjgyq2jK0ld8nk086LHroqX/mF1C9u60q5YnJHou+C4Gl2qEJh8Zl
	 EM54MwpQ2gbUuZ5RxO0VtMS+ASVwuXLfxwNO2b+Hx/dpAogqf/jRo0qsBeKIig/ml1
	 w/hL6lJpdUg7Zgd9jAsCIYvT07olqait9nrZOJiUa+rQ2O/r+kOSIkh+3a+4xiOxb7
	 9thLkwXKV65WPejzE76MZskqSduOgUDIYTwP/6EKL6Dz7t1aClBxDsnsiJ3K7JVdum
	 NBLdensF7OVFfCA335wlEIaD+3ElUeeQECTyTD1bPvyHetmzQjxl7Q1EMopmz8XiIu
	 xtvuAJH0woqzQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4697404c2bso175709366b.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 14:43:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx7mMOVA7N269G3DIWzjOnKlWeCTodBAj3PHAztvuLneJzMR9xm9Aj6EGeXttqcx/iYVW5tNl0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oNkoE+rfAxXyMJpRFMEBzMPAoWBOG2wc4N/7Qq+fP53LNYmel
	itOu6jPWbbno5aLfRSkjrgZ9IKT4N7hlrBR5Abw3/R7EIUTJYvPE/HGxzJW9Y7xCEe6QkqZ/SXx
	cViButpeLPGGDlc+o6j7pd8gp9jN7YWE=
X-Received: by 2002:a17:907:3e96:b0:c49:b9b9:26cc with SMTP id
 a640c23a62f3a-c4ca7a68457mr1455407166b.23.1793832230305; Wed, 04 Nov 2026
 14:43:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104185804.195058-1-icb@fastmail.org>
In-Reply-To: <20261104185804.195058-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 5 Nov 2026 07:43:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Sfd91-Kic7rg-_Zfzip9HcRy6k8w=fTJ1skDonS9Z_Q@mail.gmail.com>
X-Gm-Features: AclHuK9EFmOzCcqJH386Xw40dE2d_X2dJooISE5fjAA1xzRZ3mqpcKFtb2l4oZY
Message-ID: <CAKYAXd-Sfd91-Kic7rg-_Zfzip9HcRy6k8w=fTJ1skDonS9Z_Q@mail.gmail.com>
Subject: Re: [PATCH v4] ksmbd: grant a caller what its groups and OWNER RIGHTS
 ACEs allow
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aamir Ahmed <elb12345@hotmail.co.uk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 3:58=E2=80=AFAM Ian Bridges <icb@fastmail.org> wrote=
:
>
> smb_check_perm_dacl() does not match ACEs for the caller's Unix
> groups and refuses an owner named only by OWNER RIGHTS. These callers
> cannot use rights the DACL grants them under MS-DTYP 2.5.3.2.
>
> Match Unix group SIDs (S-1-22-2) against the caller's credentials. Use
> the ordered DACL result when the existing SID lookup and POSIX ACL
> fallback do not decide access. In that result, deny ACEs for the
> caller's groups limit what it grants, also for MAXIMUM_ALLOWED. Count
> only the exact OWNER RIGHTS SID in that result, since compare_sids()
> also matches shorter and longer SIDs, and return only file access
> rights. Preserve the refusal for non-inherit-only object deny ACEs,
> which ksmbd does not parse.
>
> MAXIMUM_ALLOWED still excludes group allow ACEs. Including them
> requires corresponding changes in smb2_open() to avoid breaking
> existing opens. An open relying on group grants can therefore still
> fail when it requests a maximal access reply. For the owner, that
> reply leaves out the rights of its groups.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
