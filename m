Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322061;
	b=qwtqcTTnW3hyIqxND5GbWooaZVwgB4q20nIE0T4JCe/WCmvPkGBnhkHKYHwjoHDprdiP
	 /rZ2x0CaLydOxjx6Ly7eQAU/2WhJB/YcP0/xwwek3+cnTHAtjogyY5mmNKxCpM6KP2fQA
	 VsHL/J0XnsO5YfOiaECQAJp25qH75xUR/p5ynCDUQk25Xzg1t9o6weiE/6QYnCAXyDldz
	 PkR5VBFwcuZD9V9Qlh/g8QeQw9FTRHOfn/aJfTn6gmyNJweVinF4tqAvAm1bbPE52a459
	 Zd8AfiWYKoLGCICsfqmF5JAAF6oHV4bkOakQdpilBh3x8Wj+1CePbmrGg88ik7JItbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322061;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=KyXEQvhhvbYBNTKWxtCEeL0C1VjaH+7m5+BuhzMfTsA=;
	b=LMKSWCWs9hmmJGcrO9WDPHu+9ibs5a3D9r4jm/9zaDO83tlFqR++KMCdmCLpGzhckD2S
	 5c55FVI5ao1ixFvHjasN3wXu+UKmpf3F4/T9OwKOF4mhU1DaWriElha8GNcL2XIpmuzS/
	 IpLDS0+nhEP9NA4xGQPnTM951fMaloFcsyiKw0UKzfa5aROR7cQT9RjGn67N5I34Oa/FH
	 WgTkaprJCBRC9uQU+pgNa8/iVDVLLb7pPtkQcVS5rfZu+5pdCxbdi2AIMwv9FwyG2RZ82
	 hG28q4erd2URH8SDYNL4IJamHAdpK2my6XW6prybrB4m2t8T1s5fFysg33PYNVIBvAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyoJY1r4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018C60A2605
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyoJY1r4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB471F008BF
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322060;
	bh=KyXEQvhhvbYBNTKWxtCEeL0C1VjaH+7m5+BuhzMfTsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hyoJY1r44Hfo4INbPlsaEsvNsouafEabkAWIXoqxv6HldmSF9wgi92NBH9mO/NXqP
	 7ZS4K7tjFi+7pjONpCukTAKCDhaBwUkA8kiRvoF7yHAfX41EIIMigvkiei33wXssX4
	 uzQcPUOQQDArgOnHRU0t5I19+eV/gAVW69lHZO3tXsRtYJiHFAebh44T5BS4Vwb0XR
	 Q/NcabtsfRtTGr8c9BgE7i1Iq0aGQJao3PTPHEQQ1ApkndV6sueCbjGi1Zyuyh+FmF
	 9DhXQUflheQoiGd84kl7TIBUb+cNwy6/tFV7HQXfEIyMoYTdNqW1ZVyHtB/wECog78
	 Kv8e2HrnDUwbA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so2776028a12.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:47:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErERYOKnt8krbl4mr5bAWOSv5eXEjXPkMTHPuWelCf+tHyqopipddGYV9owFsCyo70MrKo80xwM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2SOLhByvdx0Jg8yYnxR/Tnrqmo7M76yoegI6F1i7q1La/DLCS
	NMAXPpT6dWwIc5AncRRR1O7Wcfu4baYcK4NdO1ceqSfxjcLMAKo3Ktj/ctoheo1CfUlKuFZZFp0
	VlRmmxmiaC99viLj0g++gYv5jDp8uzJ0=
X-Received: by 2002:aa7:d582:0:b0:6b4:16fb:b9ba with SMTP id
 4fb4d7f45d1cf-6b756b05b75mr1604589a12.36.1794322059147; Tue, 10 Nov 2026
 06:47:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKYAXd-Jo-ObBDs-AdGfaM+QmDsot3gj1g0oJiyDKczoUDg2TA@mail.gmail.com>
 <20261109194144.22814-1-mike.michalo@gmail.com> <20261109194144.22814-3-mike.michalo@gmail.com>
In-Reply-To: <20261109194144.22814-3-mike.michalo@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 10 Nov 2026 23:47:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9FgSFui-RLdywqyciBdxcU8_xZkfxap+qQK=evVqNYqA@mail.gmail.com>
X-Gm-Features: AclHuK88dHBDDOu7sgSeVl2Sdnz_lJKjB9tYyeuwVC2odqDlQh0fO1-02CBID9E
Message-ID: <CAKYAXd9FgSFui-RLdywqyciBdxcU8_xZkfxap+qQK=evVqNYqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ksmbd: sign with the negotiated SMB 3.1.1 signing algorithm
To: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Cc: stfrench@microsoft.com, icb@fastmail.org, senozhatsky@chromium.org, 
	tom@talpey.com, chenxiaosong@chenxiaosong.com, ematsumiya@suse.de, 
	lsahlber@redhat.com, hyc.lee@gmail.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +void ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, __le16 signing_algorithm,
> +                        char *key, struct kvec *iov, int n_vec, char *sig)
>  {
>         struct aes_cmac_key cmac_key __cleanup(aes_cmac_zeroize_key);
>         struct aes_cmac_ctx cmac_ctx;
>         int i;
>
> +       if (signing_algorithm == SIGNING_ALG_HMAC_SHA256_LE) {
> +               u8 mac[SHA256_DIGEST_SIZE];
We can use SMB2_HMACSHA256_SIZE.
