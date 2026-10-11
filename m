Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C235255F52
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698810; cv=pass; b=YkVH096DG+u1Tf/nPoUYN9tTYEDL5HExaO3/pf+9ecNz0LQiC1GOHgfmRMfRbcHWXLiroQytLNMednhZd5Y2AgC/N9FpUFNdBsCqQOwD5ZR70dpDJIoZ9PZB8pIeS43I0kH+fNNTP/iSCiibVSto1Dv0O9OdXzq0gh0oq1ou5BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698810; c=relaxed/simple;
	bh=L0xjsPO0dageaCm5EnmOV3npT9NMmldJ1OdH583Oiwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUFVOVLNcR44N5RqEqNlng2MQUn7A2wZZwL+LBYrEdWR1dE5+ggJ6VgPX5bb8yh/ni8ZDLmFbgp4smtVmqq4MUeL+zBBQDNC7VTW6i7GJX8KACDMXpsd2aK+JzDgZ/ECa4ECQd6Cb9nBVq+iy+2eexAeMDRNPkmt4khtYLDw6R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEznfOEw; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEznfOEw"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8aea5b3837cso459017b3.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791698805; cv=none;
        d=google.com; s=arc-20260327;
        b=NQ8t8cdOSlqMwqRbnN6HtjqKRBkTgYNpGmyNIL2yy/+4/RkzPa+MOrHwjEzLdeo8KI
         WFnbUwSeQi2TDD5swmbGsM/wcD4B6A68xADojyhDwWF+luwoeymZjmDq090sD3uzkzxC
         84xqvz6yQgR+jBsPVZPbEcEXlfRZrE1z+pjNp3V7wlj+qk7l82Bv3h9i3LPWpduuvnRy
         E2OyLaHWlATHv4ho24Q4BPc8018DhKUvbUW0Amed0oXO7Gu53VvF5PyaTWHB03X9exyE
         zpTydFLTZGMJobpQletEKB2PNgJ/WUNT+T3MqqorEOkQXumH0BclCIB1bfrabCeShogA
         hXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q9QEKW7arrkNR3tpw3Z2BxesbCJ4by5YCPWmZN+zoiQ=;
        fh=pIhPVEcE8D3q8vtc580cYDQbNt5FNJSmD0S8NDLwFEQ=;
        b=dW9Gy49LEno/K1dKUUo8dzVBCM97+iJmjGGU24Fu+7JEi4GfT8kvugyYMR61cMzCKk
         6m+z2AxNQYn0Qo/KDvHRNOqrIBO4FzeEwBa/cnpj0U4VeGGqYLY9xAApktv9rSTyeiA+
         FNNy11uTJhCnfCpGoX7J++q90gbZK8ZsMDjjcL7vru5Jd0QOhUwzoT1Iw1j1x4+7KJDy
         0c99ElEhq60MpGybuGUPAwRJdn4rPU2uxCfeEtr8fe1hrDzUiZnIeel4O9BAo8U7rUCq
         bQGWvoNSUVpV30iCFQjY+Q8sC49TkLAqq0QbYjpsGaO3U8J6l63zGc0FEZt9qrjd6JHK
         5EQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791698805; x=1792303605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q9QEKW7arrkNR3tpw3Z2BxesbCJ4by5YCPWmZN+zoiQ=;
        b=UEznfOEwbJiCvdZDg0O9q+z6qNTOJFH4EdMnu+j7Peqrzk1B+2MN4ofnYDgcLjv1FV
         b6cViZccom06sMsmJicubIugGsjqDsdzTFBGCz0nTI7Hioq6BeuLiS+j8UIVXeA5zZDR
         uDf9wGjLWqktnkZApdID0gukVetL6mJbVwtBBLV7k1+Lx+XLasFtmH0Kv73lRkO1SZlQ
         mcxIskdoCF0nORjNETt8AKmcl10Buiw7MFMGgmVcYQtizoFC3MqEbaYfQqjL2a+6iPUA
         qVx3zI/x1AuMcYpWCJf4QfWdcwHG/i005MawWyUntJeXFZt1A7TIRjyhyyfGku6xaklc
         7ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791698805; x=1792303605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9QEKW7arrkNR3tpw3Z2BxesbCJ4by5YCPWmZN+zoiQ=;
        b=xTK4eVncLo4qJvyxj5oKwYQt2YrvExMdXLiyjdcURD7bkQU4D1DcOKxfuiHicebS7e
         h6M+br3fzNSoToH/i11aXwGvQUyw3BhJ4ML6XwSMB/N/9sVeH0RSdZOXoYjOZEvo9xdQ
         yxl0j9gDZFyeFtjo8/H+AsuBVlHadk2Oo6BexbUbdeNfu2U9T7DeBhts3wXtXsi5Oy71
         lpDe3o62UljswRzySqiDmG4PUSXwDXWrnVeu7zmwqlg7aSRa81TdxnGW7uADlByI7sg3
         meMHCwWr+i42iEVgb1fWoEJV35lQIGv3FPsNHtTZfIgM0KxumPHAj3+XLI6AfeyBD0ZF
         0cKA==
X-Forwarded-Encrypted: i=1; AKwUvBx2hYDvRE/rvDIVa/35wjpoe8syoGPsTnTIx7gfpuoWhahtHdSMqM33OdrDik+zF8Ck4Lovl/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzNNegPSfsAcDsI5NVqtlHdQBiOSFPr/VcUI07hBD957gW7R1C
	QslF55oOUKsA5Z0ld9r84PR/F8X9VvCy30KHkevsnK2paJgvzh5LKB4aClLFtd6T/gzenscLShQ
	wFbjl+tHyJzIg7O0MvJFa0CCR4j/2wwk=
X-Gm-Gg: AYBFou2mpauv51VXzsRKGiLKb6LE35lj5h0jx6wX/X0+S7vIVOmWrg3/YG1qtNbj31c
	CuENZfswlGmR5okI5dQZ2Mu4A2ZrWXqAgDVWUtSjHuVTp3f8B+klEAFn3oTkIGhMv6YVtXnCwPV
	vcIbf35SQm6ceajVY9ZBMKKRNn/mm4qnKmal8qQiCC44HDtgXgPRjGDOg+mnW8nPEqC3saUnto/
	d5zzQQr91+Apyba5xXVZ2k+uh6iVSAM0+lA3CcQ6mypqIbOArtGvTj3LDPVjfJin1fXzkSnrr2V
	AZnkK2UQzvAGJLrHbojWd2Gw2OTegMrernJ7FNHn6dyi2XTn6lhBwYih8w==
X-Received: by 2002:a05:690c:3346:b0:863:29e8:a9bc with SMTP id
 00721157ae682-8b07ed65de6mr41630957b3.2.1791698804847; Sat, 10 Oct 2026
 23:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011055955.1487087-1-charsyam@gmail.com>
In-Reply-To: <20261011055955.1487087-1-charsyam@gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Sun, 11 Oct 2026 15:06:33 +0900
X-Gm-Features: AclHuK_Q2ERhKi5UKeLKEtH53kUObVOxPUwVMIZwD4utFinQ8ZLZT4N8mhh3IyI
Message-ID: <CAMrLSE6bvD9dH_KGU6bgkKPSE4xnrJatj_to7NcJyxp6+NNBHQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: match the full EA name in single-entry queries
To: linkinjeon@kernel.org
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard this patch. I found that the same EA name length
check was already proposed by Ze Tan in [RFC PATCH v2 6/9] ksmbd:
support
security.capability EAs: https://lists.openwall.net/linux-kernel/2026/07/17=
/194

Sorry for the duplicate.

2026=EB=85=84 10=EC=9B=94 11=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 3:00, =
DaeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> An SMB2 QUERY_INFO request can name a specific extended attribute with
> FILE_GET_EA_INFORMATION. smb2_get_ea() compares only EaNameLength bytes
> of each xattr name, so a request for "Foo" also matches "Foobar". If
> both EAs exist and listxattr() returns "Foobar" first, ksmbd returns
> "Foobar" and its value instead of "Foo". It also returns "Foobar" when
> "Foo" does not exist.
>
> Check the xattr name length after removing the user. prefix before
> comparing the name bytes. This keeps enumeration without a requested
> name unchanged.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> ---
>  fs/smb/server/smb2pdu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index 12a43efdb53f..a49cc3a0c9de 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -6738,8 +6738,9 @@ static int smb2_get_ea(struct ksmbd_work *work, str=
uct ksmbd_file *fp,
>                         continue;
>
>                 if (req->InputBufferLength &&
> -                   strncmp(&name[XATTR_USER_PREFIX_LEN], ea_req->name,
> -                           ea_req->EaNameLength))
> +                   (name_len - XATTR_USER_PREFIX_LEN !=3D ea_req->EaName=
Length ||
> +                    strncmp(&name[XATTR_USER_PREFIX_LEN], ea_req->name,
> +                            ea_req->EaNameLength)))
>                         continue;
>
>                 if (smb2_is_private_ea(&name[XATTR_USER_PREFIX_LEN],
> --
> 2.43.0
>
