Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C471411F99
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407067; cv=none; b=X+4t01q0bfkgsAcfzVLODZYOL+odPU1Gt7OfAoqd+SUWY1dNQfb3n+WVuW8sZkq8ipVA6FMDh2/FiVw9ujF9p23GkU2EeA92fpg0DR/GlBZWaHdg1eFqVgzlG1koyRLklbIO7xG9u+eBwYd+FobwvPXHPVGC4EV3o3hsnfhxu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407067; c=relaxed/simple;
	bh=TVLG36AOigmhyMhJIxrgmdtUFhDEKFicRRrRH9CcOW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/qvhFIVyutUosoQH5VUPi5L6DHnB5IQohYfCVoAcJvWx4ooAI2VjqAMuAIwNXXmZHDTyRBC/Q3w0chsOGpI/9wFiLZi01LYWqc7d4hs3TTf3bpEvF4VcryERCwz62bwpV5xyw0i4xVMJT0Z+43s38ZtzSH9trz66iqWVZXPV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH6Vwtfl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH6Vwtfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245931F000FF;
	Wed,  7 Oct 2026 21:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407066;
	bh=OV40WBUCZOq2rcjvUrStiJoCYW8ezfpjr6XPANpQqN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eH6VwtflS6koOFDqQgcQ5n68i87uJaL9WGBay5l8y3TIL9cZXX0vWW3O3gFSTmzZY
	 /5kxutavBct/Je0fCNP4Skt1EaGe7QqV9/fK29dXKAoFp+jbwHDFYDH1gf9SfU/Lri
	 jmWqtkjsU6jfQ7bEvf0mH0eV9PPAiLFweH9/Faxb4MA4lIQeMLInk3PaAJez73ccWy
	 IEphDZlKbustVj6NRx8YUAZu/HBbSxLR35IYtqPoz8ed3Ohk9U2mp06ZeUENtXxDj7
	 k3GfN8ysM5h/Mhyvc0CcxkZNehtyqv/J9uSN1Ps6+mMZaYiIp+aHedWVYHxT+SSmhp
	 nQ4sYVUX6PSPA==
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] mptcp: prevent race between disconnect() and rtx
Date: Wed,  7 Oct 2026 17:03:40 -0400
Message-ID: <2026-10-07-1-daily-reply-0023-mptcp-cc-mailing-list@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d2282814-3b75-45b5-a110-f2debb8e2635@kernel.org>
References: <d2282814-3b75-45b5-a110-f2debb8e2635@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Also, this might not be possible with your automated scripts, but do you
> think you could easily Cc the MPTCP ML on these series modifying MPTCP
> files?

The scripts can't easily Cc the MPTCP list, I just reply to Greg's mails :(

-- 
Thanks,
Sasha
