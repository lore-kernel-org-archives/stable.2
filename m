Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496392236FA
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645582; cv=none; b=ASK3TxlGsfAkwIh5UFRW98vFJJhIm29VsMu1hyU+SZl82kF1h8REZIlmj9RKegRJJZ7umnRBQYCXuFVI685tcrX94zPkH1V5bYiEwJqnlCVDaL7DOY4hxVFce4lN8RlTedFuzro+ouMznZxmPCqZTdN/05HCeXjMFARZ7JKP8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645582; c=relaxed/simple;
	bh=6VejKzLt3Gr3nB+nx9CMUqtI89w0F9tZjfyzX3CuSos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+8MAH0PPaVJYKBSd/+wX3iq+Gj2b0vm5/OghR/Wrr1xw3S6C39BcG2cm2oIGNW8hcbaT065VAStIX094WUVbcIuANyUaWu2K0qo+yWZ59G+kd29LAR6zbS9OySIz/GjF02f5kVYvMpHdiC4d5cT2qDj+vBM7B1Dz6Iqszy7F7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC69ZpmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC69ZpmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67501F000FF
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 01:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790645580;
	bh=2TzV3oO1/AVpQ0DPkrFZRyPS6Zl8EIf9ZEQeAlWPbTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MC69ZpmMq+cTiZl4kODGR8cXtmO8pe5GKl7gbvHOnDow1sXyjul8OxBMAu63K7ohz
	 cZ+19qtqfZk53eFzZDpnAy94WE9r3HnkYtaU9VD3LUYLhLlfHpmW0nX0BCY4floEzV
	 hL+qzHIsKJDTaEM6KKb5MnVNOCD3q0K7h+OcUfecKOlnvSjwEzICLHMExkrVkLR9xD
	 JXqq+ZurnYt8fp3BMrnup8XdyLehuLjAmo12mGyMHMYvOXVK9suxD5mInAQugVW9Lx
	 wEJ1cOJnJ0fGfEV7W1YZQER64YmhA4tMevoBnsZiqJYPF/WYKWTJzvljAbk2ggrI3p
	 nI2ztuR4+L/Ig==
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2afb4e9977so419128666b.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:33:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx8C/UMby4tJPPmHro2Um9rFkDXbbPw+pRzFaGzfbAU10vLXUz0qSa/YECqLFuh0zT4NhOqZsk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6vyr+tA9oELp3Np+vsUpt59B+Pw/n/x+EUr28boxrM/FDkmFn
	NwxNe6/wBHnSSvOoKGBZwaOCKNTWu8HGiWH8/jpWqGVENkTfGTKeBbup0vAwN+9yAprnrbEpCZF
	zkO030i9za4B8CZBfFkXZabwNQ1eWuZI=
X-Received: by 2002:a05:6402:5019:b0:6aa:734a:a081 with SMTP id
 4fb4d7f45d1cf-6aac8f72887mr12241454a12.24.1790645579601; Mon, 28 Sep 2026
 18:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928031300.1782690-1-zhangdairui@gmail.com> <20260928162047.1829104-1-zhangdairui@gmail.com>
In-Reply-To: <20260928162047.1829104-1-zhangdairui@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 29 Sep 2026 10:32:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_mC6ah5o6ctyYcuqj8HFi1nd8tWCxaFHekt43Z21JqdQ@mail.gmail.com>
X-Gm-Features: AclHuK8hGU17doO-oGN4PpwZ0OPBz2C3qzdOOHTQq_2c_Wq6tiaO7pVa1gl1V54
Message-ID: <CAKYAXd_mC6ah5o6ctyYcuqj8HFi1nd8tWCxaFHekt43Z21JqdQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: verify transform SessionId matches the decrypted header
To: Dairui Zhang <zhangdairui@gmail.com>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Paulo Alcantara <pc@manguebit.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -11663,6 +11722,32 @@ int smb3_decrypt_req(struct ksmbd_work *work)
>         if (rc)
>                 return rc;
>
> +       /*
> +        * The decryption key is selected by the transform header SessionId,
> +        * while the request is authorized under the session named in the
> +        * decrypted inner header. Per MS-SMB2 the two must match, so
> +        * validate the decrypted message before dispatching it.
> +        */
> +       proto = ((struct smb2_hdr *)iov[1].iov_base)->ProtocolId;
> +       if (proto == SMB2_PROTO_NUMBER) {
> +               rc = ksmbd_check_transform_session(
> +                               (struct smb2_hdr *)iov[1].iov_base,
> +                               buf_data_size,
> +                               le64_to_cpu(tr_hdr->SessionId));
> +               if (rc)
> +                       return rc;
> +       } else if (proto == SMB2_COMPRESSION_TRANSFORM_ID) {
> +               /*
> +                * There is no decompression step after decryption, so a
> +                * compression transform would be dispatched as if it were
> +                * an SMB2 message. ProtocolId is not checked on that path,
> +                * so a crafted transform could be made to run as a valid
> +                * command under any session id in the payload.
> +                */
> +               pr_err_ratelimited("Encrypted compression transform is not supported\n");
> +               return -ECONNABORTED;
__handle_ksmbd_work() decompresses a compression transform after
decryption via ksmbd_decompress_work_request(). It would regress that
behavior...
