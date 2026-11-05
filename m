Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879896;
	b=awz+unRVAPkACqPM3koIUNC8C0/kAaELQ316Cj6b0rNxyrSHfSBtm0ggc2PPhZODGomC
	 u1jj1jIN7EQlZ3etXPdgs0pL7sIddqlXjVHnJ4NbYsYlZgr8TY1tV0s7bj7TVMRwnQUJy
	 Veng6BVuLLQz2uGIoaSNKjTWa9BNX/vh/76ElYjxBIcx2oCiUSrLHK3sdPZgESAirjyFR
	 qW9b5yZPCC4EsqR6/JMR8Leh+E9Yqx2ha7sop2i1KOgRjvxNtO1FXccdp5GxddKhH4uea
	 61eL0vuVrQnvk6PWpzuuO2tdf8P1s67HQVcnejebWZy1i0QR6p31vUCWQgBf9tPiWjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879896;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=zBByXkNjVCE+LBHCR7ezhTaXQstt0LGC/bJIB+BFpQI=;
	b=lcvc34F8olHC3RS9ovjzk/nZt5arjK0NEJV4Rk8KnGSiS2DP4G+A1NYIPFAG/vb95jpx
	 rDZqTF94rfemMsA1ULvrMSqzj2bMSCIPcdAV9qWO1i+XeHa3m/j496P4KK3bGNROTD/DL
	 D0VJkwgHPbJEP2Equl2kA9uRqksK7st/EbwEvKELwf164ars9W+JSIBO0fx7wfCRAWIpf
	 fzjSglznJ0UVeTfBmcUl9+s9J9uwwji3r5DI23s/Yz2vGO9ul5JxM/YaBw4Clu+Lpb47F
	 uyTZ7GpoK6f8PMT7RmOMoLJTvf+anhncyoodmKcFBFRBmNCb2dUxicVMiNmzAwPx5Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1ljF0wo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D0606A33B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1ljF0wo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B99C1F00A15
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879896;
	bh=zBByXkNjVCE+LBHCR7ezhTaXQstt0LGC/bJIB+BFpQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W1ljF0wosvH1izZK3HIyyKMPS5Nl7Fo7AEZF9nLeRoL/nKfwePwoGhcP3cO13i5tt
	 K+PUL4PFr4udMC83cGKKjMr95u5F6AzyCFfgXmQwohvdyHJOb8o0v0L31qd4X8Q3YS
	 D84D/iJ2MOzYNBOxKr0Ue6tJCGWdPu2P/UCDDOMTZV/DgaNvOJZwMu+TMhs6DWycs7
	 ywqAr7SoMLXbegyQGmA4NVfAa7Qez7SAqekGZVKKuCwHNmKGhZyAsiDoMRt/E3FF4i
	 HxNTj+/zd2QYAjKzHwfDFqMcaLp/u4WO32FNoTqPqpziosA/9rok+DLCoyDXqwC64K
	 0WBpB7ohqvFvA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c445c95d553so255248166b.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 03:58:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzUoRtN3n00hsh4EWVERcLGVnvh1qYyTJ9MdFDK1HPUKrZeBmB7rgZjGCSue6IYc9ObJdkzXGM=@vger.kernel.org
X-Gm-Message-State: APuU4Z85sQzUyPMI2fRnZjyCaZQCJkLSsv+ke0Q5DKJWYpoT6bE0Vdbg
	7lx+3hIVeT17PcH9txMTuIlBhb/ECwb1JDKbFe/Z2e4NuQXK87fHKCxG2e33SAsPr5/1jUEKE+A
	h/HxIz4q25JCT/JwdC/5QWtmhMOhSmrQ=
X-Received: by 2002:a17:907:c5ce:b0:c29:5d41:dfe8 with SMTP id
 a640c23a62f3a-c4ca7ae82f3mr1627888466b.43.1793879894694; Thu, 05 Nov 2026
 03:58:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104183702.192452-1-icb@fastmail.org> <20261104183702.192452-2-icb@fastmail.org>
In-Reply-To: <20261104183702.192452-2-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 5 Nov 2026 20:58:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-a+UH4q65J9K4e=EscH7tkHC+eEu_HC_oEeVzBdi0Kog@mail.gmail.com>
X-Gm-Features: AclHuK913ysvhcNOT2S1DOx1NkImFakA1bWuvLx5kL8RLaniHar89jBvPmRxZ78
Message-ID: <CAKYAXd-a+UH4q65J9K4e=EscH7tkHC+eEu_HC_oEeVzBdi0Kog@mail.gmail.com>
Subject: Re: [PATCH 1/2] ksmbd: skip metadata-only opens in sharing checks
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> index f9fb3741ada3..920e94017bf6 100644
> --- a/fs/smb/server/smb_common.c
> +++ b/fs/smb/server/smb_common.c
> @@ -719,6 +719,15 @@ int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
>                 if (prev_fp->attrib_only != curr_fp->attrib_only)
>                         continue;
>
> +               /*
> +                * Two opens conflict only if both hold a right in
> +                * FILE_SHARE_CHECKED_ACCESS_LE (MS-FSA 2.1.5.1.2.1 and
> +                * 2.1.5.1.2.2)
> +                */
> +               if (!(prev_fp->daccess & FILE_SHARE_CHECKED_ACCESS_LE) ||
> +                   !(curr_fp->daccess & FILE_SHARE_CHECKED_ACCESS_LE))
> +                       continue;
> +
Could we account for O_TRUNC in the access mask used for sharing
checks before adding this shortcut ?  CREATE requesting READ_CONTROL
can still specify FILE_OVERWRITE. smb2_create_open_flags() then sets
O_TRUNC, but fp->daccess remains READ_CONTROL, so this condition skips
the sharing checks even though the request can reach
smb2_create_truncate(). For example, with an existing FILE_READ_DATA
open and ShareAccess=0, second CREATE specifying READ_CONTROL,
FILE_OVERWRITE and ShareAccess=0 changes the sharing-check result from
-EPERM to success in the extracted-function harness. The open should
be checked using an effective access mask that includes
FILE_WRITE_DATA when O_TRUNC is requested. The client's requested
access can be kept separately for the returned handle. This would let
the shortcut exclude opens that only access metadata while still
checking opens that truncate file data.

Thanks.
