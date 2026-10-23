Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785782;
	b=Fkfhb/3UreA9wjTVWtYJtSd1g1QCMD2LpZIZ4AIHKK2UUSCmyNBQS74nos5vWJUZ5o7v
	 QOAiE2tTjeKEW9tzPmgxLa/aslYCY8+ZyKsTf5baQnsbgFMKFm+uhG/3hZI0hbo8vdnFG
	 HJXdcz9kQjLt9uQ01Kkvp7syZzLgJ/glnFD8fUuZz5DR2vKiBVBqnpXIOQpoPsZClPToO
	 h6+qShvao3yzW8ulnOH61pQN4wTD5ODYGFV3UdjX7hKSPoRGzDo0xXK2vdavVYZFCH+vY
	 tJS3E+niOGyvMqyaiK1nCREftJlxkBY9rZv//52JwWdf4cN5i5hzQE9mAiwnIBYQlTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QiyCyneuUDuNDL5qH6E5xo2Hf8pBoAK32lE33FdNhKc=;
	b=smfEjORFcS11tC+xvtJDrK9fzNEy1mPCWLfnhBrg8d4Zcfk+nCq4mlR76FaSS67Kytqz
	 Rh/9cekvaqUy/yOPqwZpPBYn8zc7RuzEAJxGZ++2204N1e9RHC9J8kC1uEpExCZQj74j0
	 RfG85cbVL8Of7ZBZ0Bn8IyjoSBXgWh2X3QMpd6EPC7RozGYoJPJWXwiEIaqjLDSGo+0fA
	 NExO2d6315+UqSAW4LW2li3OTMaN9B+tBQ1Xo9gcNRv2jE36jlDqTuFLKlJEWGUcO/qAg
	 QfisUFDol7Bb9lN4YxgCmRmm1gcAhp7cYXDqdM7QMFC1+MTN2oiTrM15VRIQLVHbNOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xiv8wUNC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219A606A336
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xiv8wUNC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A741F01829;
	Fri, 23 Oct 2026 20:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785781;
	bh=QiyCyneuUDuNDL5qH6E5xo2Hf8pBoAK32lE33FdNhKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xiv8wUNCF4HRw4rTWfgVfUSsZlO6cMZVUUrIpsW4LMzkrpStTtxMl9UoDD/UI0wiW
	 4b0Z1oKIea5geIkXSDeHhFqFpQ8tCRRXJ6Xx/rw65JUJsnbcqvVlLDYS7q007KyIcB
	 Oj2qDscdtXCLaN5AMYW3mBpgT0FsdRohTI/YyZ4nYdrxkB0DPzjCutoPAhGe2a6PDv
	 QpllZB30tx/orvdIvw0FmcqPb767pTi4WJ/EEjldEj93Y4KVOGMCXdm844vs3LiEDU
	 FXR2MTsedaAU7KD4oOpx4JG7Fw2oZUvzApEC1H0tJ0NkxE6OwrG8yFtS0wIfgmNVbw
	 UY3nVadrAT0Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 6.12.y] perf: Track the perf mlock gift separately
Date: Fri, 23 Oct 2026 16:02:42 -0400
Message-ID: <2026-10-23-1-daily-reply-0006-perf-mlock-gift-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021155349.1698340-1-ljs@kernel.org>
References: <20261021155349.1698340-1-ljs@kernel.org>
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

> This was reported by a user who saw secretmem failing while running a
> simultaneous perf record.
>
> Resolve the issue by simply giving perf its own field separate from the
> rest.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
