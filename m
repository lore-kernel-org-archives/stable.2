Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9233625C6EE
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790472778; cv=none; b=d5haIoY2yKPb+tJ5cxyyHPrhIr8NHwlkR1eKje37XnsJHK+khxAgHsjV8cg+4uChO78otSmSdd1bJHnvxn6RGf+R0IEi4SPoXbEmetonVNas6rg1Jvx4FAsdlSn+HryMq/IGF6yOnvG72Hh5jOiwM0GCJXnlAf5qoC7CHLnPJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790472778; c=relaxed/simple;
	bh=3RqPolZNKqfuMrSOidK90RRpD+aYp7x9syNCo45Ffto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZN3ErmzfbsToTOc5+B3L1oiQPBChPVLJN4gqYivzGUcLpdpRO0ZVWGDtItSnTrn0UZ7QRXbhKdtFumCCLIzONTYCj+zb4c2iBwLLjhJQ1BkJjF+3NQv+VNHPLiYEAnCpOKxWWKJUlHnbYW8hwLQAWeehlgWwc8c4pCQMmH/YEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C461F0089B
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 01:32:57 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so301686066b.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 18:32:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwxi+a812i0erxCQr1Ljz7qj68ZVLJhIDOkq3xvLUMyIsfJj9ZAL+1tTkvFewO16sKx4ampEpo=@vger.kernel.org
X-Gm-Message-State: AFuF++msLjyiaGPzEc1EEg6c0zqoFnfK8vPtms+Y7VaULTVqzdenEHv7
	BG10YBec5fL6d/TV9ADUMKoSKsndzc+TpXv9AfoBTrrJSl9YL7Wl/z30D2GMXD73F3tLjcFUff6
	A0JiTzalLdrsR8cG2FodBRxAIK3CfXXo=
X-Received: by 2002:a17:907:3e88:b0:c2b:898e:24fd with SMTP id
 a640c23a62f3a-c2b898e3d80mr282661566b.33.1790472776127; Sat, 26 Sep 2026
 18:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926080224.1671214-1-zhangdairui@gmail.com>
In-Reply-To: <20260926080224.1671214-1-zhangdairui@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 27 Sep 2026 10:32:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ATgduq==_gWm5sHpNds4TtMt7d7_tt=MGSNjXzkH3oQ@mail.gmail.com>
X-Gm-Features: AclHuK9ZWgEJltsKQmjyLPmsYfmFQKQYQZoN4ENIdlG8OhR9JsjSxA1cuvIL-q4
Message-ID: <CAKYAXd-ATgduq==_gWm5sHpNds4TtMt7d7_tt=MGSNjXzkH3oQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: verify transform SessionId matches the decrypted header
To: Dairui Zhang <zhangdairui@gmail.com>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Paulo Alcantara <pc@manguebit.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> @@ -10890,6 +10890,22 @@ int smb3_decrypt_req(struct ksmbd_work *work)
>         if (rc)
>                 return rc;
>
> +       /*
> +        * The decryption key is selected by the transform header Session=
Id,
> +        * while the request is authorized under the session named in the
> +        * decrypted inner header. Per MS-SMB2 the two must match; verify
> +        * that here and drop the connection on mismatch. A compression
> +        * transform payload carries the session id only after
> +        * decompression, so it is not covered by this check.
> +        */
> +       if (((struct smb2_hdr *)iov[1].iov_base)->ProtocolId =3D=3D
> +           SMB2_PROTO_NUMBER &&
If an encrypted request contains a compression transform, this check
is skipped because the decrypted ProtocolId is
SMB2_COMPRESSION_TRANSFORM_ID. After decompression, the smb2 header=E2=80=
=99s
SessionId must be checked against the transform header=E2=80=99s SessionId.
