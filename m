Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795825437;
	b=R8chlcVg/cPbaBaRNGlCOcvZbhLGmZY/TFVYse8bDqqGwG7afJsNCttLJI9xz7Sf4iqB
	 D/YXO9nCDFmOYyOX4sXrW85/JdMQp2SU8swRJyCDdfqJr/6wDfITgk3B+pTfvlZVS+iku
	 y6X4GPIFFEsbZ7eSD9wCzGv9dA1X7HN+9PmasDdB4QiAOVZcTyGWBNYbPgMD306mPwSig
	 cU/QcYE3YsZIdiJvOD+kqBfzNTadbr/Knfza2K2B/Jxua+SGPvsSrVBkjUV8rEZXAgI09
	 XwHBQCRCRMN4C1OzAzeer2+DEJv4mcQUoDxXfq6aykDd9lSoZdIsTEUSmfxccOpT+eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795825437;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=UBKf2DMMbkMXRFILq1FMa1FiaVBhOkjwnOibVfgSAP0=;
	b=KOMmGcKJPakGd/S3YtlrO8AVgAVHNpQr5TGHkkKqLMrqcS1fn7lv8TNaejpwsQHjJCa/
	 5JPtnzHDlhIo6QDnTFqwSVu+dHPef3LoNVI9DnqyjKRlh1+OqhNovib0dInJKqc5W6+1u
	 XxzoE8xcHxn54kXiRAL6iLDwLWhOZwUj4HwhRWUIQm4UCsZsxI2g6QDyCPRXxjOK0fPi6
	 bzWwZfc+Jx3kX05N+9857Ea+UnAqvii318LPrxx/S7uafa35unnlX9jFogZ7w5xgO7YfN
	 xnh+7oQ4H9m80kIkM1tVrfsHjNlyQHL5W0I4B1OCroGVSTTTPCVZpfI9rBwZthJRB6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeclS2Yk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8B606A31F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeclS2Yk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE13A1F00893
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 00:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795825436;
	bh=UBKf2DMMbkMXRFILq1FMa1FiaVBhOkjwnOibVfgSAP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MeclS2YkdjU9LWp5lw/lH0mynGCq9o4mvsKBC99R8TAbrKbVVNUbpUG25HhTcOI5S
	 rmd1LJmtXd+bsXu1GCiPUKzbCJ1IQLpYeVY37vtiup20cFL2NvMhAYRLjl4cc2DE0K
	 65C49d0nZZ2qBBnyJ+SvEq4qjyZSIJWWqGhGMjDOhh2awanpS6tR07sqQyvt8EeG/7
	 lGuazzgCW3I2PQrJsvJZ9Mnc85pD613bNLSxkGlCJt9iZHVAFSH6/Blfbx/BEU8Bbk
	 Ngp0UwrMhbxWFr5HKIbYNW7HeERGaPM75aAkWtWGDn0u9jINKcwbnso5owIcU2iESa
	 tJjPiq51PG/bw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c5126505cb3so1132388166b.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 16:23:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE87tZnUppkKEaWa69tImbsvyDyUtTN/255FGTbtPq0kzw9BYym/VHLB/Cj1wwelb4mIURrmgg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rpyJs9FbOCqdF9npaJt/w8BxkRtGNWTWcf6GxZRKWmZRHDGvT
	NoJap7eCNcuFG7Wlux5DhN+LuC126IjY1/JPa7zofuwgt0UoyNWDek7/4rwl7XiEjEXxc/q6JoU
	k0TO4PF3Bk66mf/rrVtevbFAqxV5xqwo=
X-Received: by 2002:a17:907:7f91:b0:c50:c747:a4ce with SMTP id
 a640c23a62f3a-c513a4b083bmr2267377366b.4.1795825435408; Fri, 27 Nov 2026
 16:23:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795797772.git.metze@samba.org> <f8e60e33c424c1efe397e94bee170a45823e3d95.1795797772.git.metze@samba.org>
In-Reply-To: <f8e60e33c424c1efe397e94bee170a45823e3d95.1795797772.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 28 Nov 2026 09:23:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-+Jr6bn-Pce2x4gMsQbiWqparP+dJ87V+x-Dq7Wp08VA@mail.gmail.com>
X-Gm-Features: Aa3M54q1mhkdljTqaw2Elt9O4l1jN2fdGSiSKsJD0FSxldCTnHcvIoB21ROvpDA
Message-ID: <CAKYAXd-+Jr6bn-Pce2x4gMsQbiWqparP+dJ87V+x-Dq7Wp08VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] smb: server: use a counter for the nonce of encrypted responses
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Content-Type: text/plain; charset="UTF-8"

> @@ -36,6 +36,10 @@ struct ksmbd_conn;
>  struct ksmbd_work;
>  struct kvec;
>
> +struct ksmbd_session;
I have directly removed this line and applied this patch to #ksmbd-for-next.
Thanks!
