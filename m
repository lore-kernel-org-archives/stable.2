Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487747;
	b=1fkVcyUnXNlTfp3y5muFRq/zQ/KEVOcHR9hWADaTFCYsE/PTXPSIWA1FS6a4QAFQ1E+C
	 5La1iNXM0GahxP4WHxjsWHMEm2cW0Cobs6YeRzKw+e3JqC3WYVp9286K5qKTq/AT34U7D
	 OIqv4Njgp1Ge6lHO0r8h4vpZvpiK5uQiqfnnX+QXn/VDZ41MQB0+pRq/NzRscfR0+YvDs
	 W5LQkg3yT3Wsj+7SUobBYPK/9wgcjXIk6qvUQQDJMs3MTVbGb/vR6SC/PWCteV9VztjZw
	 3Vsns1yylXzgm6yYStwJ2xmmbC5tPNLrghRzBanWZ0wahLG1XzODOLomzVGaVq9WYWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487747;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=wnFjFy7epBjNWRNLyw8f6LRnczufzKHnOkE+iAdWTCQ=;
	b=D4pmQGswnz0OqVYvOOrlDQ6WG2EmdChiAKPIzKNEDixZnGQFxXo/FjWEUPEMeIbV7rft
	 jNeSppnR2pbdolOvPTya8qS9dVHBORRDSzo1Z2+zfX7MAt3fuWzDLIWwFt9rB/KVBPoMH
	 NfgmDcmdFu4awUMIWBpjktlR011/nUIAmLXBFHxRjrEhaEwDO3RaLLDZBAVIrQVHq5i2t
	 SaEk1LbOze+RKYIK307PcUGuc+wSq+pJ1HhSsVkxcaefF4pUaqn3d2yLwrS1NkDWRNKgf
	 I8YXY0w9NbU0+p7WMtNIEvzM/hTUFiMc6jigAhpG/5EVRWeR/OK4pvpvCmBZWKIke2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XSk/FTTs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF2606A327;
	Thu, 12 Nov 2026 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XSk/FTTs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552D51F00A0A;
	Thu, 12 Nov 2026 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794487747;
	bh=wnFjFy7epBjNWRNLyw8f6LRnczufzKHnOkE+iAdWTCQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XSk/FTTsAPiFBZCKKRfoqo9X0VN9P6Je6F2pachtiB4RmHIp7pXVvoILNXR03hZj3
	 JWzWFiLfoF+VLI6mU5H8hJzPl94PpmOl1zMHZRuR9WOPohFmyaMia/8W6MxvR9HjiC
	 NZcmLicjxcSeE2S/YeBZbCK2fHblEiElQZ/LWgGcjjMRrIvYKf12qKaFLZdXcFrUty
	 K+viAggid8vFciFhI2dNC+W/jUv1NFF4N8gZeC+Zc/aSan8uq3Vh9o/0sHHoe3haZq
	 0jFSPG35fDUB9xkRwYNzgjfUGZg3BYvuFaofiPno8saHFTRStYhtphQrBeTCiZgdtE
	 w/Bx88wdX+APw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: rust-for-linux@vger.kernel.org, chenhan <chenhan0017.work@gmail.com>
Cc: boqun@kernel.org, fujita.tomonori@gmail.com, frederic@kernel.org, 
 lyude@redhat.com, tglx@kernel.org, anna-maria@linutronix.de, 
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com, 
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
 tomo@flapping.org, georgeandrout13@gmail.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
In-Reply-To: <20261031103206.24051-2-chenhan0017.work@gmail.com>
References: <20261031103206.24051-2-chenhan0017.work@gmail.com>
Subject: Re: [PATCH v5 1/3] rust: time: rename the rem_nanos() divisor
Message-Id: <179448764511.621816.14570615601029612760.b4-ty@b4>
Date: Thu, 12 Nov 2026 13:47:25 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Sat, 31 Oct 2026 18:32:04 +0800, chenhan wrote:
> The argument to rem_nanos() is the divisor, while self holds the
> dividend. Rename the argument and correct the documentation. Drop the
> architecture-specific implementation explanation from the public API
> documentation; the argument type already states the divisor's width.
> 
> This does not change the function's type or behavior. It is a preparation
> for documenting and checking the invalid divisors in the next patch.
> 
> [...]

Applied, thanks!

[1/3] rust: time: rename the rem_nanos() divisor
      commit: c6dce610f733d16849e5a8d491ddf080b839237c

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


