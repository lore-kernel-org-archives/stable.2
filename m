Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5D4973A7
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377615; cv=pass; b=pugi37Sl+KnLj1GumizUfKs5yxMDVeiIBIu1HPfh4iYEZexGF2mR6BJFUhnZAo39x4rBEN+W4jfVFa+FZdIchj5mkUKOxSedcuKrSUL2uf60NAMeLaqpEs+RQ7KDuuBYi6tJ6SkD3GK+OEIcZWUJedloS2qRCQC85UZ+BEHDa0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377615; c=relaxed/simple;
	bh=7o8IHTHMGS/voyHQzhmgvEE338B91PLKSiRWBKqVlo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZIuEsPghOgXNh23ipfpZBaXan85KtWzs4P4O2xDeO15mFkmHO65/Yhl0YwnDRC+vlZmvCMA8JilC03QI430a2Se6d84+na9KZfuXk6x887M+bR0uMDibj6kYl4F2EwBCQzKS7JnwuwillV2Hl7r7IwDoNvdhzfPvYU59ZCcii4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIxG2N49; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIxG2N49"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so933741a12.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 05:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791377608; cv=none;
        d=google.com; s=arc-20260327;
        b=ZM1rTZPAjwZI3CMDJqaTxc6+EIh3smjXdm5wnCOQK4ZvV7Pda1iRoi16EpOR6LOTBv
         zFOXpY232YtnXY2dbScm10GOxZ+i5e2x6j4euH4mK/uqIYW58cRJR5f4mzEemxibJlr2
         QMCy9TgTvblMb1rM4XzJTl1pyhrBaCvXw3CX3xd9uPqQr8nOxDJbKYa7kJdR8i04fCxW
         sgBkWZY1+nMrOTkCgZIax6IoiZA+fU03ghPz8hEAIAwoZXn0JZkuSV2yzkTyKRH8FrVh
         HTMkwvtplnxgteYNY844hUKen7yMAFyr7luwA323GByZ3ujJB1poKd3cNNdzZxP7QdBW
         EqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bvmAYJ9uVcHWwdsdUVnTxzhHRQGok8mw2i6i7B3HO9M=;
        fh=sF9rU6wxYNblM+Pw/0Pe8aNM8ViE/W3VJA8D8x26jg0=;
        b=hh3tkllY2SIalykSUdbZYCD0QPkLdpYP+1fTEmgAg4Q23dAlVrN17Fm5e+Ogj0kFR2
         f/zUh0GWl815j9hoc1r2MeKpSYfNTjs3Ly/yDZzYqMSXq0CC1AZIjJB4Wzhtp53zjBNC
         qIcPuwzran4Df0afQ/aqCZ2q0VKzaedSxNtem9bXYYUCHwqhXpX+bqBd3CVCUB0Fa86K
         K8nj4kOHM6mTg4UikBskRQfmFOO+cDrQchoN9jCwDej4xDS+DVS5t4WBSRAyYToF9/xY
         mbKv7vR2lkCDpVqdBRKtMvTQgzMJVYeSuSiLtVoRZ9AMTdQ6ZNgWCOD+yMgPAfv6ArvN
         qEng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791377608; x=1791982408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bvmAYJ9uVcHWwdsdUVnTxzhHRQGok8mw2i6i7B3HO9M=;
        b=PIxG2N49285eXSYCZn2gLCqbp8bjI59uxYeCx2TPVnB5M0DbL482ZZcECgaviONelM
         eEEhQLo0LzSIvpd40MbL6Jq774G3ddQ5daIuSeyaEpVYvxNWS79+jgzJuP3Yzz7ZRcy0
         gjYMa9CKknD99XA6mq5iOskjJ5jdMtDrd+OffKAvyWhWtX0yetE3KOIPYWs9hHJrqdTm
         QHqUFyxtwgGT1J985bMrIsoyps/R08+1Jv4QJg17QJWFMrwWhc8IN68dGUIKCaQ8MDPy
         47zjW2m1Ftde0iIMMJu2UyOdbFtZF4gza3fBOcFbFJlniC8WsAD9yqO1lDRyTdDqzpdb
         4o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791377608; x=1791982408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvmAYJ9uVcHWwdsdUVnTxzhHRQGok8mw2i6i7B3HO9M=;
        b=U0w5cNuWLQ/YaYWXozeXOq40eOzuMJGbDsq3gb8P/fJ+IciukLq4C+VQ4Ku8YEuWZ4
         VzjneaJSqWqTe4lekn2q3tQ/lkRZxH0Ep+lFDTD40IWTQU/ALL4jPXumHeytqNxoV0Zc
         OhzTu8iT5Xrx/B5lRz9zYZPNxxswTeVUlNRInL5F+ylTPq35y3gvUQ/3vRQ67arY8eFf
         32uJh65V2uh4Y+OVuar+KOSWIu5m+VOPz6dLA05ELOGXFkNks5AuggBSMl4pVklqQAoI
         RdTYRzg/6+23Zh2j5/0efO+CzNIPF8RAirhpZm4xlzsQEntLfwQxmrYiN0sCMujzweYv
         PJ1w==
X-Forwarded-Encrypted: i=1; AKwUvByuetS4uJobhPHGL7urD8RU6Cyl4I/rn3c6eXnU+M3aswDEGK5t63WVcvnr7oxo3rwlbPaTSeQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n8jRdkget6PGqT0/Dbvh7ZYbimQIIQ0aGW0w0eLAY7CDtD8X91
	YaURZpt4z57pojuJJiIZ6kH0HarZ59GINXkeRLNAWXwEO0FYgRl3xK4vnHnwaE/mM5H7vyFHzA2
	7mndWSVdhOlWX/3ma+jRAgI11/rTZIRQ=
X-Gm-Gg: AYBFou24aGM3EaUjppglqhA4cUGqVfrrhBt4p9aGyI6gq6Zda/kRcDhYu2S47kADvrO
	s1M57fn/E50RDhMoFzdzx4MBLH8gJeAVFwRx3Ny0KxDd1zqUEuhuN5oUZ9UYC8zSF4a2ebC1Rvq
	qfh3UKL0AWLVvM3Dc5DGX8wH5nrQMAJdPMU6O78XpQ/ayK6vUzbJqddc7hWizqZImB6vgcx0ntQ
	rpKkM/zQeonn8IEUUmrK25iBk2FZG3jb9sgE2eHixTSCEDqQbas+CF/mYEeAc2RF3BD1TlNY9xP
	yg5WyJsrhxR3GmJ18nsA+Ik8r+lKwYJl6WxJhlYwRZ4lBp2eXRyMH8KPdD5TRhB2h8SYnkMvzUn
	vKwFepWVdByGsaXrfZrgikZX03V0jGRAQRLcANrmhQPbz6j2RXaA1D/RXZCKd5BBo
X-Received: by 2002:a05:6a21:394b:b0:3de:b0cc:b0ed with SMTP id
 adf61e73a8af0-3e134043d29mr1761808637.18.1791377608192; Wed, 07 Oct 2026
 05:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007095128.1370109-1-benquike@gmail.com>
In-Reply-To: <20261007095128.1370109-1-benquike@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 7 Oct 2026 08:53:16 -0400
X-Gm-Features: AclHuK_HAnf8AxibDk4DcYXebRklfeO2nu44MIRw5S2vZVI5Uo2hAuf7krbvADw
Message-ID: <CADvbK_dOXrS+3JnqmRyssAJQ0v+WLig-i8Nk-M65Qg51AtskvA@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: copy zeroed stats to user in
 sctp_getsockopt_pr_streamstatus() when !streamoute
To: Hui Peng <benquike@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vlad Yasevich <vyasevich@gmail.com>, 
	Neil Horman <nhorman@tuxdriver.com>, Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 5:51=E2=80=AFAM Hui Peng <benquike@gmail.com> wrote:
>
> When an SCTP stream output extension structure (streamoute) has not yet
> been allocated, sctp_getsockopt_pr_streamstatus() sets the local stack
> variables params.sprstat_abandoned_unsent =3D 0 and
> params.sprstat_abandoned_sent =3D 0, but then immediately jumps to 'out:'=
,
> bypassing copy_to_user(). As a result, when an uninitialized user buffer
> is passed to getsockopt(SCTP_PR_STREAM_STATUS), the kernel returns
> success (0) without copying the zeroed stats back to user space, leaving
> uninitialized data in the user buffer.
>
> Refactor the !streamoute check into an if-else chain so that when
> streamoute is NULL, params is zeroed and falls through to copy_to_user(),
> copying the zeroed stats to user space and setting retval =3D 0 once befo=
re
> returning.
>
> Tested in QEMU against Linux 7.3.0-rc3 using an uninitialized
> sctp_prstatus user struct passed to getsockopt(SCTP_PR_STREAM_STATUS) on =
a
> freshly created stream: on the unfixed kernel the user struct contains
> uninitialized stack garbage; whereas with this fix applied, getsockopt()
> copies zeroed stats into user space and returns 0.
>
> Fixes: f952be79cebd ("sctp: introduce struct sctp_stream_out_ext")
> Cc: stable@vger.kernel.org
> Reviewed-by: Xin Long <lucien.xin@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v3:
> - Re-target subject tag from [PATCH net-next v2] to [PATCH net v3].
> - Fix Fixes: tag SHA to f952be79cebd ("sctp: introduce struct sctp_stream=
_out_ext")
>   as suggested by Simon Horman and Xin Long.
>
> Changes in v2:
> - Re-target subject tag to [PATCH net-next v2].
> - Remove redundant retval =3D 0 assignment in !streamoute block and fall
>   through to copy_to_user() as suggested by Paolo Abeni and Xin Long.
>
>  net/sctp/socket.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index a2235905d2ee..bc5b78ab589a 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7568,9 +7568,5 @@ static int sctp_getsockopt_pr_streamstatus(struct s=
ock *sk, int len,
>         if (!streamoute) {
>                 params.sprstat_abandoned_unsent =3D 0;
>                 params.sprstat_abandoned_sent =3D 0;
> -               retval =3D 0;
> -               goto out;
> -       } else if (policy =3D=3D SCTP_PR_SCTP_ALL) {
> +       } else if (policy =3D=3D SCTP_PR_SCTP_ALL) {
>                 params.sprstat_abandoned_unsent =3D 0;
>                 params.sprstat_abandoned_sent =3D 0;
> --
> 2.47.3
V2 is already applied by netdev maintainer with the Fixes tag fixed.

We can drop this one now.

Thanks.
