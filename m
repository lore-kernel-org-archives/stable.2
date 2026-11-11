Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434116;
	b=a4TM1AzbR+zs4Twk8o7vrIwPkMLfwf42GGX3ESxdgkl0DVcgLBRxu9Bv9kkVADwsLoBY
	 6F//jJCEvucihh3Lo8bFKTrrNrNUyThVeVQG6HNW6taNLkpcMRL7lLt2D7eBP6fNXc8aw
	 FrrqYNEVC/4gjsBVgwPQ/SYnUWERuuD9HruqRsXoyPkLKYzPnTK7Z6b0gFkwrIwRKxDdO
	 vCXFAx56P95pGWr7e1g71s4Bt7kObSY7i1evtmRmyYG6/3jbTSMBaqvT3p0SjankpjT1M
	 qHnGyDMCgyfCoVFI2zldYdNk/rKRkAfjKHp4f0Ee31hvR+p2ukFE6Hhb1f348LuqnDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gGqXSFwavD0g276x23/DLKngIIulDCBL284IUyEjo+E=;
	b=o6n60zPolmBeeXpqd+lAjnjszcwI/fBOBJsVSUKyFy+pFukRttDW0dV0vDTvKYND0fwu
	 8uK9bXm4mR6/EuDyXaOPSgvdjW1zbS80H0xt6jKKwibcrwJd/x+d6oe+I+VdPC+WyDs/9
	 SNeuDZAKwkQgV0S9V1KzE5OTlNFT07qTWR6hpP4xdMlbuwW+OBVbWO69O7tLcHBcjlqoH
	 esAT7u4k4LW0LtDSyW6Otnc2GXAXPnwmcHjEdTbLYWpTSnPu35hNFYlef7owljwdzcvkP
	 qZwmS63tZvqqUdAZHQ031PNaf36C6uXM3t2x2cLQshw9UrAX+C1U5LmX8VxrQp/0HIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AE6fk578;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D660A6F6B;
	Wed, 11 Nov 2026 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AE6fk578
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CBD1F00A09;
	Wed, 11 Nov 2026 21:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434116;
	bh=gGqXSFwavD0g276x23/DLKngIIulDCBL284IUyEjo+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AE6fk578DruC2Wkdn7+BgBiNyjW4OKIxxHJltchyV9H6fsX+0SryIVDOOZfBkIXy8
	 eraXQ+l+Y9ewW5zJ0bFVRzdohiVhmM2xk/qdTgBQhTxRl6B62/VVyIPntUMiXgYwMQ
	 ZuQst4HFM2h4KUMBIk10HwvjZXGtPhLSFoUPMfm4m5stYvWzTFvu/gPLPvJwM/v80k
	 f1/T1hzlk2z+3ryaJM7IH7i95toeAvtjACXEPbascrVavcgmKxSVczfSTcx0WYfzZA
	 ki9sbdfDU/bb6Zsu6WReJvgKHEralIvd9kSLlapoCHDMUkKyUyFx/9+Fg4anRa7re1
	 s39NtszK8pXkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	devicetree@vger.kernel.org,
	Georgiy Osokin <g.osokin@auroraos.dev>
Subject: Re: [PATCH 5.10.y] of/fdt: Ignore disabled memory nodes
Date: Wed, 11 Nov 2026 16:54:51 -0500
Message-ID: <2026-11-11-1-daily-reply-0018-42feb81d20784b7beb03@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111094817.600994-1-g.osokin@auroraos.dev>
References: <20261111094817.600994-1-g.osokin@auroraos.dev>
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

> [PATCH 5.10.y] of/fdt: Ignore disabled memory nodes
Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
