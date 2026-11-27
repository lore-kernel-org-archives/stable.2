Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798907;
	b=yV0iaQPOTGoOLmohLBGyC/51bQPZ60MRTUB0Khs+n6T3rmdTsuXdES+Vuq/bFo7muDjL
	 iukwf08B8sDAN7Aa4tI0jibD606aIRRN2T59cAMoqQ6Gexs2QZXks6GuX0BjzkNuqY+dq
	 /iRJnat19QVtcMBlb2yMSAVb2cXtGwz6EdViuAKdNCG6D/YVCud4ZAhELlISbT1YeVgXd
	 Cqw2clW3GYhRDMrbIHTdtxsKEtXB69eUbTgZoAAY5Ofc91w9f8OWRQqsT/2Ffk2Xm5t/w
	 OsJJJGGwHUy1XG3Sent31Dn+C5ghtbgNtMeH+6PKBbIOgxOIfI75SctvOZ6eaMp4Y5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798907;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vVsVRgy0gzJIVDd0T7YDpsF3P6XzAm9x5p8uBrrFcdc=;
	b=krudM9+KhQ2nHNeY3SP1x0SPZ4KCHrONIHZydcZ90AOJKkuaMPEtqykYIMViZUttOZ/4
	 kfmwoOMuY4Djurdj4SjXVAKKqb72cdTwkGu556jPdSzN7leXnTH2XNKXki8eujsG15uVJ
	 mh1kBvLEiJkYvJ1RH+y6Feie2GQ4/CjNfeP2sQjdMnJyh8dxUXDu9MKhuMmI05e5rAdYh
	 9uFfANuYA3yTM/NYVfTzyKr9XakPTKTb5Ayb8UeDNfUe04ShVd6yuv8QVJi90t80vJjfB
	 G/4rEfMdEWaQgUFEAM0FC0jm/IUL1F0mjDWh3AE+B7O7AYt5gbWxHMrxWo2FOQ60oKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1lnJqeD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB6606A31E;
	Fri, 27 Nov 2026 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1lnJqeD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480461F00929;
	Fri, 27 Nov 2026 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798907;
	bh=vVsVRgy0gzJIVDd0T7YDpsF3P6XzAm9x5p8uBrrFcdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1lnJqeDQcN3bSQX8EgH6876QrL/pyyQu/V3KVMH9zUpD2SKisPEK3vOI2+heZwSy
	 ttoqJuPMJa2zSQ7HwI5tcg++bo+BovgbdjfYo2ed+z8LWwbEhyhZYfz6DJChsMl6z4
	 v1zXmV032pnbEp4ReDBCS6yFF18GB2qR0GSqXiWh12I6LPaM1kOvPyX7zekxV6AUhg
	 uTGugYY6Esjk+rfagoJnqXKslXDRlGzYASwlrjCK+JONFXKQnpGcPHQ1oqkh11Tliu
	 kzc9NDwppkYzr/FEtBvr/x64YYdhbSnNWLHkyHliWitufWHFNCY44R40dLUwKjlWpc
	 syX/CYtviEBNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	cratiu@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	ipsec@lists.linux.dev,
	jhs@mojatatu.com,
	joe@dama.to,
	kuba@kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shawnq1@163.com,
	steffen.klassert@secunet.com,
	willemb@google.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.18.y 0/5] net: validate GSO headers and preserve XFRM inner offsets
Date: Fri, 27 Nov 2026 12:00:56 -0500
Message-ID: <2026-11-26-1-daily-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125195735.57472-1-artem@trailofbits.com>
References: <20261125195735.57472-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please apply these five patches to 6.18.y. Patch 2 fixes CVE-2026-53091;
> the others are its prerequisite and the upstream fixes that followed it.

Queued the series for 6.18, thanks.

> 3/5 fa90a3145c03 stops xfrm from overwriting inner header offsets set
>     by a tunnel. Without it, patch 2 drops VXLAN-over-IPsec GSO traffic.

6.12 and 6.6 already carry patch 2 without this one, so I queued it
for those two as well.

-- 
Thanks,
Sasha
