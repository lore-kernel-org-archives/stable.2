Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633633;
	b=vIQFRYuKCefyt00U6eJrjyyvqYhXnXpiJwn8KG4l6Zr7OpmLVURxg914YJzlVb125JsD
	 mTITQ8inQuPzbqxZ6yBXI9IgiOgXbhYRBKEb9L0pQ5UyHAbS4nTh7PbPuHjqNmZ4MidlC
	 wJgUuGLplF+qytYkdCYeDeQ3JWZHMdxqIR4CXSVIXaMU7qxOeOuZSxqlpDHL7rpRTgPeR
	 SiQimsPk/Dat8H7ou1ab8tgvMxjYf4vHQvA0TnjwF0n1F26Ry9O8iQNJuROT9wrjloBEP
	 AveUIp6VxmlKJjCPCtHDFTl4DWoHz3swwsyecJDjvR7f4Jl/hFYa037d2LqX5QYPLXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oyiH8KxW4iXXTpuxCrw2DNTT9U7UsOP1QJQuaLjnOsk=;
	b=MsoQObMEmymvAl675YhGllpPaBRSgUFCDEghVn+4rFwbCz0T1m25J99qr9buHV+k1Ntj
	 QUIwu8Cmhy5vUbhfzbOUaa0giBzJMsBOTstCLwEopjo5HOSNMfkXsohgIKN4Tbah1HD1v
	 k+ttnFUlrTprLUx+zbeBFid1Wfgf5CuqQ5QkHuyaPI3tRAOFjaTl7sRgGtyeq2oR87LV5
	 04gMKYGaAmozQxKN2wS7gD6y7iuWixJuylJGn8NA376G64/b5xfmsmsJvuYpgouqCA6X2
	 fh8yJAp+N/WptCaa8PDGVHdzYi4qpr9wHNW+18kbJoyjzwbOHw6qULI5oR7F+yK4QJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+2JJMp6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBA06072EEA;
	Mon,  2 Nov 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+2JJMp6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF9E1F00A22;
	Mon,  2 Nov 2026 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633632;
	bh=oyiH8KxW4iXXTpuxCrw2DNTT9U7UsOP1QJQuaLjnOsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+2JJMp6uZY/bpveREdKtKY8CADb7bq88SXxQuMoaXUQvF8wIbmsNzwb7pFmbe7NV
	 V75AWJzgaXjeEg+p/gyxbbiT1dCnl+s3+phFK43ai9MfmAsirRF/R4Lij77BYL1XMz
	 p+8VOjEc8LQYikjnOu6oX7OxLWMFf1wm20/feMqZHJsQHSt5SRKqV7yqEAnk5swoes
	 2WsBxB3TWK2fzSNcQOt6D2R8RYrjanqwfUO4Y6GALEZN+60nI/dX2Q+kD6LgWdpEz8
	 53jogXFUq+BxELKOqXhmQkwCRXt6o3q4HZApHP+J/qPYcQryUVy3Gb4VVrPYY923cB
	 X0WECcdvM5roA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Itai Handler <itai.handler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Vasut <marex@nabladev.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 5.10.y v2 0/4] spi: spi-zynqmp-gqspi: fix runtime PM, then stop on shutdown
Date: Mon,  2 Nov 2026 10:33:37 -0500
Message-ID: <2026-11-02-1-daily-reply-0011-spi-zynqmp-gqspi-5-10-v2-hold@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101163154.2274099-1-itai.handler@gmail.com>
References: <20261101163154.2274099-1-itai.handler@gmail.com>
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

> Marek, do you remember which platform it was and how it failed? If it
> is still around, could you give this series a try?

1/4 and 2/4 are the code that 5.10.199 reverted in 1ceaf0d3a883 ("Revert "spi:
spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe"") and
649237ccf440 ("Revert "spi: zynqmp-gqspi: fix clock imbalance on probe
failure""), and nobody found out what broke.

Marek, Michal: can either of you test or ack v2? I'll queue it once one of you
has.

-- 
Thanks,
Sasha
