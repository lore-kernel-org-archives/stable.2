Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932503;
	b=xqrtPqAI8W6UM3oobPN0ShEZvUfVpenn6VWoy3eHxOtQFp/s+TzwgavV0mBRbT7yiVEW
	 UNAk9niu2HWML407dTrcMKfoCAO0U09Nnvxv/9gPmJWC2nUtbA9gXaXvtcyFvbc/ucswj
	 2DpoISyTVh7ierPq/Odn40oAPTOgqIJ47OYfQTYEnWkfyYrX9kCPvuGdBt+QRJAwkO2gX
	 uXmgfmxVueyxqi41goFtS/Oxje8C9+xmytt0d3Uj2xempafdmVkCd1Cx0yTlVzCYsAaWb
	 OhdAKQAdMUTSjbRLxKoL2n16WuZUN0Nt29EVDUKFqVPaC7Ea/CVlAlWo6UJ7Dv/b5JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932503;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5Sbwiu099EEmkll6l+3qxwbiHX0TRA9iUayOe3qQEAY=;
	b=NLaWLK9wXtI49wjay5sytsESRs46rOj3uFWOwkQmreB8bWiN45UXYOFRLWC5bKDidQ2x
	 KMjOzDM6yBTz213EVmSIHEuPrIxGV6rbTOVBPxKJBbzV7FmdLgdanpD/1MN1euEClJTxQ
	 bzm9ANPBr505YLD9XVCsjMsITKy5dy6pBRCYxOlTcP6Ifz204Nd1TECquLdtQuD/Ua0v9
	 bUzYoGVrS4cQmDuuiFc+wRcs3JbwmedmFbUZDpesmcrH5Pb8kvR8hmX3GgAKECPANY5Ym
	 dvjq5Eqtq2orhPtfNGi9V0FbDXBRuCVrZyFxeq5J676SkhxaUEk/5CnAa3cZa44ccOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BLIU/e/p";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F1FF3606A31C;
	Tue, 17 Nov 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLIU/e/p
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1B8D91F000C4;
	Tue, 17 Nov 2026 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794932502;
	bh=5Sbwiu099EEmkll6l+3qxwbiHX0TRA9iUayOe3qQEAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BLIU/e/p90vTcWhqUlSbvXNa4REM3DwnSJeFrxkE9qn6bLbWOLgaDy7GJmPG3yz9h
	 gmLjXPKyk/1DDMZ8s+FCkc3iWzbFoLCx4Uol8auvP1vLtFyw97v2M3V72d444l87+2
	 TNQGnKvO8fkNIKN20bxd9aEom9DgptKS4B+TojXOmXQDMSG2kkcA2yqabIV42YWVhR
	 wzlAJAOFVW5e9NcLgqEwBusqyVVnEGEqLRuAAmxBOLJiSeVUyouYv9TeWxnOkh6jBK
	 UVQAuoV1ywvcnJsYz4xgvlvhVFfwUcQFGFaKwsVxez5Gibs2zcy7nUry39OGVkp8lN
	 Oh8rw8SG1FJeQ==
Date: Tue, 17 Nov 2026 18:21:38 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] keys: serialise key instantiation against
 keyctl_chown_key()
Message-ID: <avx_Eu0rbWtwPDGK@kernel.org>
References: <20261117123353.1822-1-enscrpt@pm.me>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117123353.1822-1-enscrpt@pm.me>

On Tue, Nov 17, 2026 at 12:34:12PM +0000, Sinan Turunc wrote:
> Subclass 2 is an unused lockdep subclass that is
> only ever taken inside key_construction_mutex. Subclasses 0 and 1 are
> already taken outside keyring_serialise_link_lock by __key_link_lock() and
> __key_move_lock().

Delete also this as there was no bug associated with nesting levels.

And this does not need additional fixes despite I forewarned about that.

I'll wait for v3.

Br, Jarkko

