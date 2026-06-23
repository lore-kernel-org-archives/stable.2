Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8013502A5
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 05:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191929; cv=none; b=CTbREXrsQ3bxPxTrInJEfQ/NXdSKTORb2Sqv2oU6OeLNItTTgts+zEJhzScZ31XdJUEkC6tk61fboJlGTtjeOAY83XIcARcfTi/SCKsGdwYISrcgLU47VViCC6uQHsZ8L+JlBWGTm36WpP3trMowHUppXv3LbJXK6Uz8pYEQXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191929; c=relaxed/simple;
	bh=KfJOqsyfmXXIKvwAP834CJTfx23DKu9FvGemclQrN5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJQnpWIWFjhIgvtm2MY2fQgAOROQmXaVf222RCm/Nq+67iEPxpD4YcvwN6SdMSVWnzi9WIjc8LdVqAJYboagN6c40oZnrIRPvINo9ILixI1nGvzQvT+OTXsilKVLLTVBcrdrCp0A+bkivlJAE10PDIFGzz2H8A9XAAeXnVPS6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBDbwnDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBDbwnDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2531F00A3F
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 05:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191927;
	bh=yhohV7YjvElsAzT2mfcS1W0N3pAPOcaR2oSGtusTcHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GBDbwnDBHTMRsgfQcWbxfWUQp7YgKqTISPM1yJYJblNm99oM8l8DhzBe+XW+hoK3D
	 ouC1pGqYPQcfVeeaafZrLKsFDwUZBj/3tvgp594WWTCUy+TfLbCOb3zhKP3jFSTjLi
	 W66d2m3DDKC1W3izsDRlalzJmtaVTHH/8cEwItkm+0Q7RbQqaC27kCbLO5SIyxTAwC
	 dbRUVNavNfl1Oul90k7f13cFJgfI5DsZWA5ys+WMshli+KsQnSnlaz0UljkgYuTc+p
	 Q0JrLZiGOz/KKztMNc1nxSVgxXXRENTACA5LUqYotMDxzmQQACYcoNkjViXmQkbGZ6
	 DMX3Mq2JONoUg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c07ea058c1aso827166866b.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 22:18:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ97G493jvUS06HMvYfrQlcxCW0HlFr8E1AJiO20/N+2SR2o/8yqnOWQ5mp7JzpOEk4ZBYWwhjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEepFAIB4D4yeSvQ+AlmnaNolQ4glvJkKmiqRoFpbI9+SBh5Ii
	lWita6oXblUizNjq2NDtpQw4QWVGwaIGCQDZgzk57LGsEgJzgeetqj5rv6NT1NWkwkFgAT20cf5
	VfsFwVZAZgj35enECAOFnGLTawCgpa+w=
X-Received: by 2002:a17:907:c708:b0:bfe:ed06:5a20 with SMTP id
 a640c23a62f3a-c10903d460amr43020866b.53.1782191926362; Mon, 22 Jun 2026
 22:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_61D9C47692BD8C4063364E24FD8181DE1007@qq.com>
In-Reply-To: <tencent_61D9C47692BD8C4063364E24FD8181DE1007@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 23 Jun 2026 14:18:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8ONFMMtCMt49pWTobGr9_OS3E06zzMJ90T7Xz0iud6Aw@mail.gmail.com>
X-Gm-Features: AVVi8Ccnzb0xyL_wYj8gawXqJZ6E0dSq_Wtlr-6nG5iY59gDQOJGiQeUUcLGv2o
Message-ID: <CAKYAXd8ONFMMtCMt49pWTobGr9_OS3E06zzMJ90T7Xz0iud6Aw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: validate NTLMv2 response before updating session key
To: Haofeng Li <920484857@qq.com>
Cc: smfrench@gmail.com, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	senozhatsky@chromium.org, dhowells@redhat.com, metze@samba.org, 
	chenxiaosong@chenxiaosong.com, linux-cifs@vger.kernel.org, 
	Haofeng Li <13266079573@163.com>, Haofeng Li <lihaofeng@kylinos.cn>, stable@vger.kernel.org, 
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:31=E2=80=AFAM Haofeng Li <920484857@qq.com> wrot=
e:
>
> From: Haofeng Li <lihaofeng@kylinos.cn>
>
> ksmbd_auth_ntlmv2() derives the NTLMv2 session key into
> sess->sess_key before it verifies the NTLMv2 response.
> ksmbd_decode_ntlmssp_auth_blob() then continues into KEY_XCH even
> when ksmbd_auth_ntlmv2() failed.
>
> With SMB3 multichannel binding, the failed authentication operates on
> an existing session and the session setup error path does not expire
> binding sessions. A client can send a binding session setup with a
> bad NT proof and KEY_XCH and still modify sess->sess_key before
> STATUS_LOGON_FAILURE is returned.
>
> Relevant path:
>
>   smb2_sess_setup()
>     -> conn->binding =3D true
>     -> ntlm_authenticate()
>        -> session_user()
>        -> ksmbd_decode_ntlmssp_auth_blob()
>           -> ksmbd_auth_ntlmv2()
>              -> calc_ntlmv2_hash()
>              -> hmac_md5_usingrawkey(..., sess->sess_key)
>              -> crypto_memneq() returns mismatch
>           -> KEY_XCH arc4_crypt(..., sess->sess_key, ...)
>     -> out_err without expiring the binding session
>
> Derive the base session key into a local buffer and copy it to
> sess->sess_key only after the proof matches. Return immediately on
> authentication failure so KEY_XCH is only processed after successful
> authentication.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Fixes: f9929ef6a2a5 ("ksmbd: add support for key exchange")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
> Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Applied it to #ksmbd-for-next-next.
Thanks!
