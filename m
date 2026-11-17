Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927243;
	b=HcxwQvZsk9JNAQbKqtTauz8HdXNPV035JDXOEnJurj3Ox5/S67suK0ldSwae3BirNX4C
	 XS04A50Ny3Uxe9aqSZnjy6HU1eNnQrSJsUD1iKhCZG31vrUn5porjfGr3J93U4HjHKeQ0
	 TEjIlaT/cyGPc8vh6z1B5I7xEOOvpjnPM6IA7VjKxQw6Nr2IZFIj8pIJ9rQeUJ0J+3nYB
	 Y3Sos2ZUBSmGYvW7S++HtuZMJgPiVUZzD4lSe3g5OVAuQQYo5TznFh2IfInEIKedEMR7c
	 OOTIvmwBGbNP/Y8zIgFg0YIe8fQ3+8BjZpJttKQTbNYP15THGlBQpTt8Co8xVmLPYsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927243;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2AcM92XwkeB/9GLpKxLhBOpnc+KvX4qwBiVBcCFW2+8=;
	b=xcbcuU38XQjl91rNHT5pXBdc5wNjZpoQvbrTLFB8dHB0Zanul+kWmz708ga7TKK+Utga
	 VlOvUouBYeK3+NDbdO+7FafYFJtybZDkkGJEcsp4l8w8gWmLWMUukZyH88HkIM8TPezNL
	 mK3JLs2IzPQIq1tAWJ1ZG1CfSSrnycU2A0ED8NFLUlsIPcINkwFHstb27G+/dNQ7GrOKn
	 0DkboT7DwXFguCfEcO5c+khPlqHjn2rF3mWN3FmjUSH9zQ2rk9Ik7D54krkt3mmfNz+JF
	 Pu0azBbvEwN5DxFdmG/lMF8ewSrYUc+UxG3NsE2eV/YxwHdZFmDJpBUkprtMMzt3Hug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYjQ197p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A3E76606A31C;
	Tue, 17 Nov 2026 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYjQ197p
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ED2451F000C4;
	Tue, 17 Nov 2026 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927243;
	bh=2AcM92XwkeB/9GLpKxLhBOpnc+KvX4qwBiVBcCFW2+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IYjQ197p7q4UE7qFSVEXelN7gmm/CXY5s2z/UVhq1+9ix0FVmXnAhJfCBk7LKbH5/
	 pULorTc/ddlA6iArQg0zCwka8oVADy/wc2xKR8ccUQmWPLlE3/O096qMAhCHayC25g
	 xMpDi1F3Vcs3q4YbYdEDvhbahPcCr7N8nFt72FEjwqBUDkS+Afbrjop0XECeKxpsgG
	 U1JGs8Bh05lte4yWdsoXytMLsy8RZUDZxEjZNmVKBQyuRmU7CipWWY9rUZt/H7aYKl
	 z1BoN3rGInLoQPlVXd6gBlASX6swJLoAYxu8IxtqDepzK+EeZoqZcn4tSgnEWM3ap9
	 S5MOGS4sZPjcw==
Date: Tue, 17 Nov 2026 16:53:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] keys: serialise key instantiation against
 keyctl_chown_key()
Message-ID: <avxqh6gZjjJQ3a17@kernel.org>
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
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 3f1f0fc..df31d10 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -441,6 +441,7 @@ static int __key_instantiate_and_link(struct key *key,
>  	ret = -EBUSY;
>  

Hold on a moment. I have 1/2 for this.

I was going to make it as a review comment but it is separate bug.

I'll response and  attach my fix as soon as I get it done, and after
that you should send a two-patch patch set with my patch as 1/2, and
yours as 2/2.

Br, Jarkko
