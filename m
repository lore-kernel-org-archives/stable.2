Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE022D949F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941249; cv=none; b=tMjZPQck3bhx6ODk8NlrbP66gGo6PS+t4ha6U4kPtMvid494Q62PaTn+M8gaZhTqMArC022dRnvhCXCI2ztardugxzpl2g69M3MNgU7NjG+QkfE3HJ6+VBg/zwTvXBtn72SzNpTkln2S0eSZwmRbwvKEgpQRDY8fU+3IK0lb0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941249; c=relaxed/simple;
	bh=FY2Xzf3wLn2fGGx/a1iXLkT35UksJB//gdtXIVzPN8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J00kfX21BMPBKkgu2Jhzgr1AlVloWhHVPRmiARJRoQg7sD7Sz2ni8jkPEkvhoMrDG1yLRqdG4mf7layoEkxD0oDFzWKD6cI1218/pphs6E0gq1DhAbJcCjb7YD0tHq+upJqiLj3H82X+aPgZnbVG7ukF/ifrF+Al9MpmDlqse/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAevDUkJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAevDUkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59CA1F00893;
	Wed, 14 Oct 2026 01:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941248;
	bh=ecLJTqh3fAwqN7F1uGjwvClLTajsXhFQPtXbet1M94Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PAevDUkJ+yQqY2kwyhblHUE5AFkS4TFPBQI/9t+FJWOogJKSK4GE+qC02Qbpak/c+
	 Q1LqbS5MlKWMt+qjCrrP7Fv4az2AaSBtE2I0nwsSbCWFV2P8P1RPXsp/roH6kjELSU
	 +UGiXncz5s5guzAd7v4SjAK9W79dV44+FxwznCd1TZis1G93BTJ6VSNtg5/GfPyvaL
	 KFfVJHzBzRyaLiw19BE3kCl28+dMPnsPjDg6pNJ97YI0EQcvM++G99bahrgPkbERto
	 XPxhsNYIaBYdsnte6Y6yI8DUg4H56bIPgmDmo7OY09JKBEtd0CaqLtzyJAN4ruTesR
	 FNyBfDadnxWxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>
Subject: Re: [PATCH 6.18.y] can: fix unique skb identifier regression under RPS
Date: Tue, 13 Oct 2026 21:26:58 -0400
Message-ID: <2026-10-13-1-daily-reply-0007-can-skb-uid-rps-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013074325.288386-1-socketcan@hartkopp.net>
References: <20261013074325.288386-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit d4fb6514ff8e ("can: use skb hash instead of private variable in
> headroom") moved the per-skb unique identifier used for raw_rcv()
> duplicate detection into skb->hash.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
