Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D652EC0A2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941250; cv=none; b=ubKKBEzh3RWFDmyfnrOcc1QZZxIXOZwAuyV+3PU9mXlrqxMtlRKshCTrY5yF+7m2D6+nHJa9sbjuD11PZwicgTm9hwV3kB6ZJVHfR3h12CJ5PshvLsViLtpgCIdLWVpsyNyUkX3gNofB8weScjv2spZGPOAIJNEMIRwENiAU1cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941250; c=relaxed/simple;
	bh=hUAOIHr64vCqlFVy2824qsJxjKwsdUDdkYmTOrwIZKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlyQdzccfBUI/MWtfl+PEG0cgnuTUzuaIHoguJqo7jBtIQ/1ohWb2uaJ3ShNDLJO1qc4q/I3QBulLSQmSKnRETPZ9xjblDswK94yfChwTScgx62u1fpjxhnAHg3TjwI7GLuzHRtX5CnF6qa07Co2APAXpjscrlsa6bT5UueNEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy4NmmwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy4NmmwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E5A1F000FF;
	Wed, 14 Oct 2026 01:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941249;
	bh=Y2RtflXHlip2Pb0NHNUz645SXt80FlWphmSXtfi/kJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wy4NmmwEnlKm8XCDOiKKs+Ep5+H/Xh6EA63w6eoE1n2glx//SzaMqUKj/zt28SAID
	 LOHYBTsPk8Sul8RIxjMpZSTvX5HBMnLyWFlH8NRSuzkyWkXdOpaHFIwKm5rIKsIASr
	 sAw97+ydzBmdks+1lOB44DAZeQ/sGJpSbfEr8oYKBiw4D/ZD4cNyLfSQJIewXap0Po
	 VYMQgK4BW8PBkif3/G4lkyoO/EnLsWJVfn5QYT6RpQWimBCs3fuDsO3dFc2hrBxV7H
	 hyKh0POPG90XTdn91vgRPoFxYqRKo15ESsDiKlb12mf0vLEzzXgp4uehfV5DaJ/bSm
	 M54wc7WUdjHnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>
Subject: Re: [PATCH 6.12.y] can: fix unique skb identifier regression under RPS
Date: Tue, 13 Oct 2026 21:26:59 -0400
Message-ID: <2026-10-13-1-daily-reply-0008-can-skb-uid-rps-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013074306.288368-1-socketcan@hartkopp.net>
References: <20261013074306.288368-1-socketcan@hartkopp.net>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
