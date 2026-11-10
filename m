Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344395;
	b=xalZ2K+L3af0xYjx4BfPfLAK8IpHHvJxjozTrz+Y+E8MDCLLlPhrL8T5Gi+oMWu7OQ1C
	 tozH+ZCZ89vAQYywhfZToMa9kaTGm0lOISNluurjBTmzcVlmoq81jYW7aBXMKW2XiWcu3
	 V55hCqG+uXg89rTUDbgV5lW4YP6Xhso7N8CE0XX23PlWXv29XOcSSU6ucJUMMru4Cj1M3
	 m1QQx5JImACqQlzeYiXnlJDdHVyDsEgWTJ4C3fIA8BmvCJo62h3qcy7MnHMbLRaqlYnl4
	 nC6UOTKL9NeUHcqIHk2CaZh9pwedIh3jMv7UxHHEh1g7xhUI8NwNe8QxlfHv83vHO+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1GJ3MBgUDiTITXXwqLFNTuUG9LCbVFESLvcTq3fWyuY=;
	b=nnnmSv7gfeZ/BpSW+biMdK/ooJOFnjzZf2SRcp1iBIFNW7w+I6NDoJmZPd+FH74VlUat
	 NTD8x4I2sXSgKbsED13+P/PTR32m0EcHKp/fHyqXeubvm4PMrM/CUjiaW4cWIrD51e/FT
	 FEvoRzTY0DAviDjDvAc9AiaWIJRG2IBF9LX2oHsTHBDsaIUet8NM2ujGg/rNSOkM8zp71
	 qujqFpBh9erX6vI15582Ujd09lBuN3mj/gqyHacJ8S9u9Jn0bxeZWXOjIB8fMrBpMUINv
	 46mqqW557l4W25msBwxAiwLr1mIB3F0tupbs1LhXx0Xe8tM8cJuUsO717Y2eDMc74Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in3arcny;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195F560A260B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in3arcny
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE131F008A4;
	Tue, 10 Nov 2026 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344395;
	bh=1GJ3MBgUDiTITXXwqLFNTuUG9LCbVFESLvcTq3fWyuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=in3arcny2korCEFMPOVLgxOfaBvEATZh2e760vCKNQDE6Q9yvQpI1tyrVAPlbksam
	 6omv1VoVi+O62nOOcWiK+tngEx1TZPUdextovKIN3CHgrGrWajPfqttIFbLrRd6Xya
	 VntNQW4+XB7F6qhs+KaR0uJ2O2T2XFFXKUN7RpLLXfq0WRP3+uwhmbs9SHIAJck4g7
	 jhyVmWCmJNc9HeTWbiCg193tPY7rb2QzH3e8n3NC02py+oAW7YAOmfBqj/pUCf/WVS
	 jZ6eaf6T3M1jpnoVl+rWttSQqWpw9GZJH168dYdIemq1rG7TK6SgqrDpuX7EF9W8zC
	 hF9wnWXbIIhRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 7.3.y] batman-adv: tt: only transmit local ROAM flag together with DEL
Date: Tue, 10 Nov 2026 15:59:19 -0500
Message-ID: <2026-11-10-1-daily-reply-0023-batman-roam-del@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110184016.42617-1-sven@narfation.org>
References: <20261110184016.42617-1-sven@narfation.org>
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

> batman-adv: tt: only transmit local ROAM flag together with DEL

Queued for 7.3 and 6.18, thanks.

-- 
Thanks,
Sasha
