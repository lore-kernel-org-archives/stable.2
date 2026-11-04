Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781878;
	b=0VTv9p09avIv6cWaalAqhBREtD9xDkwpYQaUR9xtPSwU+RVUD2Upjy+hqWXU6W2o2q+i
	 HW3KK/2Eqd2/Raz1NY0HCAf4icJtw86C50G0JX88/Mkmu1Jr2Lwf/YChTk3uNpx1yZ+/T
	 GBDP0Op86E+QeI6zh6mFou4xNLC0tgc4360goFRjLnpRfsSR+Q1iHgLOnZ8Ee3FqYdewZ
	 iaauvV4vm09cHm8I1dk6RXfJuikjKaEyohkrKYjE+d4FUbWYSx9ez0owiKuxQHO7dbb6H
	 ilMDFDBdVp45dcNK5xz8Dy8++ARYUJuMu0yl7n19p8smsJIqqEuqywUPyXAfXCCyOpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781878;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=cxrCkQFSuOyT2sjaoiQVObpyFNJLzTlcWOT51iAX9JU=;
	b=R2q3562LZB9WRUlxyMZRBd3PbDXRhALbGXYYweGrIMac2UfES+/49ZmUkuGokZJvylOR
	 h57wJepz6m6Hj/qCOeXARlRpMCpv3LKzoOMrINYRsqVtAIh08samF8XcOGQnsqSBo8xpZ
	 qRigHYOZqzdnTeyXQTfrVpLGvnMg17DqoPKUgIcgLDUj4C4KfRWhOeklLC6AVbM2vY2VC
	 RUmGcBxYdEKGlOCyvJBkyW6bC+2G+jPEhozhokYWg46T+fmy7xfsjqF8UyTinAwYSXWGZ
	 z6mcFPZIaTcLBdRs7V55VwocNSJNrNKTgUyK7yWoQy9TwuGdd0CpjILNk4c6Sm0bdQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYLOlPsd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C263606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYLOlPsd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAC41F00A02
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793781877;
	bh=cxrCkQFSuOyT2sjaoiQVObpyFNJLzTlcWOT51iAX9JU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kYLOlPsduBjpIXnoNusXVF/cXOEOFqqKNv9+1VSUd4RD8x6bk5a1K8x8z2gGjc1VZ
	 cizbM0P0cK2PKYSVlgWcm/rp181SBKz5GnuM86soqg8vsDvhE7z3nbs2zADxdp9a5e
	 OwMvQQza7UO2zF2uhqdNpcdumUIExnKjfyKWozC+GFnsiPTwr0V1rPgAGTFL0/5c7/
	 ifnAu2Vxw75WJ/vsfEMRHheJ0yP+2R/ocsUoDU6SgmitE9pACSkwJwyF3wFlPb9QbX
	 2a1qxNkf+q1NIsYn8Avi6Lwn9v7mnEF7DZFgmkFD0+TYsinXc7d+DoqhH7/uZFrOjj
	 SlF4IzZLxEHxA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso70631066b.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 00:44:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByf11d8/7JIhd9+Q3nkL5uIDdCtqbQ9wjLKj7cQ82hqVwLVpXO9W8cqnkg2R+9FV1zmC3Dq+fs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qDMZL/Kqejgb05FZS4ZdCLp+XXSH3JyM09eNg9kTIamXSwwe3
	4y0dHJnah88FAck8Utowkm9DvzFqU7akqE78QWzOKPqWZErlJZY+AX01XWLCV3qOBdN/WgqzBPI
	wEW1KPg4zi1NjWUElwPvHDPG5T59pz5U=
X-Received: by 2002:a17:907:fdcb:b0:c41:f29:72b1 with SMTP id
 a640c23a62f3a-c4ca7aeb21bmr1310103866b.47.1793781876535; Wed, 04 Nov 2026
 00:44:36 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103150458.11591-1-icb@fastmail.org>
In-Reply-To: <20261103150458.11591-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Nov 2026 17:44:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9xNLn1Nk1QzD_Kep1TcgJmGNsT+UTg6Ed0DjjmRRW4+Q@mail.gmail.com>
X-Gm-Features: AclHuK-JcfuZ648DJ94l5sf55_9ZhNmAEUfsKztm_X1MvB-PgWT_Vi8TDrhO1D0
Message-ID: <CAKYAXd9xNLn1Nk1QzD_Kep1TcgJmGNsT+UTg6Ed0DjjmRRW4+Q@mail.gmail.com>
Subject: Re: [PATCH v3] ksmbd: grant a caller what its groups and OWNER RIGHTS
 ACEs allow
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aamir Ahmed <elb12345@hotmail.co.uk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -1531,7 +1557,12 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
>                 goto err_out;
>         }
>
> -       if (*pdaccess & FILE_MAXIMAL_ACCESS_LE) {
> +       /*
> +        * Evaluate the DACL in order (MS-DTYP 2.5.3.2). MAXIMUM_ALLOWED takes
> +        * its result, and so does a caller that only group or OWNER RIGHTS
> +        * ACEs name.
> +        */
> +       {
Please remove the redundant braces and unindent this block, as there
are no local declarations requiring a separate scope.
The rest looks good.
Thanks.

>                 ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
>                 aces_size = pdacl_size - sizeof(struct smb_acl);
>                 for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
