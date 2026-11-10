Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344376;
	b=zv4VWTm0CL743SpVezMURBr9zv2LlLnfEAvbY2SzhttRI3AQ8uKVj+pVd6JkPkYJBw8l
	 BsRMkKpVVj4IAD/Dqhh10CRxRZsU3ScZqoEptpL02Y5kntiPuvRZGqibudY8MDyVDidPp
	 34gYLZ7tz1ITlnCQrm/i6IhvSSQaRvebhL4neK0Gt0vDk6nohPSNVrkHKCqo2P4SN2fhe
	 24ForEtkiMnyxryod3dQ3Gel4zytHygfriLMxcH+qVUDY7uFSI69pdDI73BS/TPFpzhwy
	 RBC7vzjGduC3YIUa6YtnyyQMfSJDToiHq1FqMGLpYTo2IXQxVTmSihgMY3nJ8mPJDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344376;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T/Z0jxuuX3n/2CXRqait/lGKghuiYRxR4K9hyRBnDKY=;
	b=4xUv7bbpOHzJZa+d/cGldS80ULNm2I55N8eD3+BHKCHQ4tIcfDhyYklOlFlpYU4/gfc+
	 1rNKvuOHf9Q/9eB2y8MEr6VsohKr4t1X0h0zOsfLcr306NaJR5czKTJ0J/kP/J1SWasDF
	 V+rOvRO08Yw4olUxtSogCc8OQVbKJSTayjyFHUSjs6iFe+c38SnT/jZ1fYZgxKVnTT4wM
	 QawN4XaFYfW9Kt02eAuKlKyPdnH5bKBZclE07idf4b7erQSH2PwMhvSkNRGg0nzA2jVzF
	 MSOckfAJfdyd+Z4kxrz29LOUlvZRMucR5TBebsQ5l8OH+9Ih1kWe3qZhFV0GvN4z7xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RenRUrD6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D7606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RenRUrD6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF511F008A7;
	Tue, 10 Nov 2026 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344375;
	bh=T/Z0jxuuX3n/2CXRqait/lGKghuiYRxR4K9hyRBnDKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RenRUrD6W3/ymRY4Giv1hX7GpXQjtlKNtIsNXIPYBJoKSJMfkh/nla6KBq/3y5MCX
	 SSJrrynx4e/6KVTiBeF66cQE+hbjDOEnjql07HaRrHpG4bLVgTiIgARHEykUs4yged
	 LybLgPARdcapqwTLrOusDYIesTc2XA0jH/novw5ci2blwzyY4S9Iph5KNCYIizR3+8
	 gCXNEgmfAdsSj7AOVEXPay6wJk2pnrSbIc5vMHpsjJVwkc4jt8/u0x6KLYiA5UZUHw
	 P3+8FGPX/qv2esGqkhRtZ1RPGRdcfnYO3Skj52bCbj9igJ6YF1sDTgD3Qr9RwsQnr8
	 vs+Xr6xSwbupQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 6.18.y] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
Date: Tue, 10 Nov 2026 15:58:58 -0500
Message-ID: <2026-11-10-1-daily-reply-0002-can-ml-priv@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110175714.791740-1-socketcan@hartkopp.net>
References: <20261110175714.791740-1-socketcan@hartkopp.net>
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

> can: replace ARPHRD_CAN type checks with can_get_ml_priv()

Queued for 6.18, 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
