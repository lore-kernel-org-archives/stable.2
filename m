Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239639;
	b=hpVmB20+mM0/enbnYsHfCH4rBwRbg917n3EaQGNsDNhTHv3hzPYdCDHyFRb2uO2lR8OH
	 FVss2PvoVJNZ6q/3S5unRtuEtcQmvPiJU0iSVqnOb2HFABx5CTxvGa8nbasGOF4T3yYqm
	 oavPbXEzfjXr0oZRQ24hg6pbKEA5Rw2Xw6s/eYovA9hv0n+kbQasW36B84Cqd+ZODLZSv
	 vXtmlTuVZJolv7+ezP6z4A7YPkRCp/2SgTOlaj/KZM+2uP9kXOXFsmMaEbX5xU/A8DRB6
	 t1SeCVKMRIlKAa+rcH3vamWDP+V3wKG9OgY3J+bgswHlWm7JjSQwUCqSMFsBMPmo4Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ovV1pGl3N6GTethwH6xVoK0h6dAi7wGYhkz8uwN+qQ0=;
	b=TCya5c/02Vcth4p/3gy5JtIyyikGFWqFL/ngVJv9rDf4UCpr1i+kmRj8uc7CWYh0e/Po
	 Y6aC/gtbWyMlU3s9IWK1a+3LrGPPH8gox7kTyc++g/2oneyfelztP2MxONEsba6LAhVMz
	 +g4jHDNoRmvgx/B2Q1cHF0z4FOym4VrHL7tEATH25dzWkH5J2Q2Gmt97A8ZXQ96FeBmjH
	 3zeCpmkNbWjVaKnFSAe8pzHHY26xFBvNlHgFCn13TGMHTuJT2tgmfBXx8DpTAXXiLaUqf
	 am6hdTnnryGxaDONpRz9A2Duy1btm4QvVX0AX5iVbx/ge/9RfmqDGgAktE4ViXR2m2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=he+Kje6x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58672606EEAD
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=he+Kje6x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C451F0089F;
	Mon,  9 Nov 2026 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239639;
	bh=ovV1pGl3N6GTethwH6xVoK0h6dAi7wGYhkz8uwN+qQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=he+Kje6xhjQ9d2/zPMawht6XtgPMzKWhKmnPDkHv57H8V7Jn+h182iMJRbq04Vogu
	 nt0gpBG1HfGcGu9dvu7WlVXYNcbCg5CJd3gTS2zKbQkyZJTQsoG1wM7GzaANuh9G8F
	 jr8U0SolqbdAkzHc1QdlsPRFxYemeCfoP8OlIIrqN9Y+3f6g2BU4cAHIs+8rRQaU1/
	 5TG1/qbpf4ktmoMWxrJXjI3s5RB6fearLsJiwQFaxgVK1TLwqR3hHNY/pg1nyaeThx
	 MtxH9aDVAKck/gQ069euuSrXJBZ217U1jZoZgEMQysBDliZzig//BqOvPxE6hI/7pL
	 pnsrgio8hISCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.18.y 1/2] devtmpfs: make 'devtmpfs_context_ops' static
Date: Mon,  9 Nov 2026 10:53:14 -0500
Message-ID: <2026-11-09-1-daily-reply-0032-devtmpfs-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109120550.1776888-1-simonlie@amazon.de>
References: <20261109120550.1776888-1-simonlie@amazon.de>
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

> devtmpfs: make 'devtmpfs_context_ops' static

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
