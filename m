Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586438;
	b=3t4g63fQmiV4kww1unHUfDA3NHeq03rI87rgZXWA5XOBBAoFzeP+No6nD+8QQ6QZNQLl
	 bqEev8TnkSzalmS1fQh07IRg6OAbufVqEADLcJspCSZbskdRoafDLyuQhE2yyVwlBB+vw
	 1Fhc/eLxkIAwNsw0agkbSFaWNal9z+y7nxzOgGzwlwR4bxZL8xWMBGSqW05+idHW/p3nJ
	 6Fdedl1qfgTU/IYw5/fNB96zjWr43fFuzXOqndtkMkoh3DtvD1gbNhAwm2sEcPWM6dYEo
	 KB4doytswvjeWOg8eJfLC2KNY6S7owMKp2yIxMFvpH/m0HDYJqdFzm4mmMr6U5ArNbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586438;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=begCeXYItBquDA7XPxAPGQfD6bTzxdUZkl6PgZ90LxY=;
	b=Sfg55gqI4FOykmzjMcV4s8Mq4mVLew0/XrtDoIZS1DkGZ8efDYECgTQBCxlHGl2azmiu
	 UfMqbAzMQ1HuX7L03lmo+CeW43bGNUCskVY2j5jsFbM/7S/g6T26JdBiyD4J2DoA6tA02
	 9vT/zB9PXyzeGO7xdSox72SVRbxxGJdPcHi8EZP5vhZdoTtuSW1huTjf1yRmj/+kR/5cO
	 sjbfgGupscjd1/ha6keJgIBnIORZPAzlrMIDFegIyuUBtrgcG7l9/LMDpvMcbpBrNd/KA
	 /Ml2t1SpKJxiMssykORYQDNAds3QgKScYUSIKa/1Vp6RzXi7WvkbUrdS6W6dST5XByg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfZKjZ5u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848D6070211;
	Fri, 13 Nov 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfZKjZ5u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFC01F000C4;
	Fri, 13 Nov 2026 16:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586437;
	bh=begCeXYItBquDA7XPxAPGQfD6bTzxdUZkl6PgZ90LxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kfZKjZ5uvqxS5KAFPGNsMiAHRTOLIA1kA0J0AxXhwebpfcqRyrHlYZE/C+DdeIJxV
	 g4z3sLIZmmqD8rZrgpsXOiY2bf5HXyJmiDbUIKu4c++jJ7jMgVXULFKnNFjwzpl5s/
	 zH/SY7j4nGsdSWU6eA5zrDyfKVqup2U1dlwoJfTtU7ieqD9G7LZkO76HS+dps4SdaD
	 vFpMFHSGcar+yF3a+sCmBSdMCAAXMVIwb6cvlazR1/1NxL/z7XPLsMN01BmfDHGdBd
	 O3zz5cPaLJvfe4iEsIaSXAIQ8DDOcgU6Y6F9wHrc2frmLQn4hSMFU6mgEqpiDjWI35
	 i6gEpNqlssgMA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261110135615.291884-2-cassel@kernel.org>
References: <20261110135615.291884-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libahci: Stop the SW activity blink timers on
 port suspend
Message-Id: <179458643686.1838286.2574003795414454789.b4-ty@kernel.org>
Date: Fri, 13 Nov 2026 17:13:56 +0100
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
X-Mailer: b4 0.14.3

On Tue, 10 Nov 2026 14:56:16 +0100, Niklas Cassel wrote:
> The SW activity blink timers are not stopped when a port is suspended.
> Every command goes through ahci_qc_issue() -> ahci_sw_activity(), so
> with SW activity enabled, a blink timer can still be pending when
> ahci_port_suspend() runs, e.g. armed by the commands issued just before
> it, and ahci_sw_activity_blink() re-arms it as long as there was
> activity.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: libahci: Stop the SW activity blink timers on port suspend
      https://git.kernel.org/libata/linux/c/3cf33dcb

Kind regards,
Niklas

