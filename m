Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA8225A38;
	Fri,  9 Oct 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565811; cv=none; b=j3VS3ZKMuQg7uTSgazagfwI3qehjGb/10NeQoDDc4DcPTDQYkNxvzTppKROVEkPhHbRqA0N++kw7sd3MpKb8KRr6nbNhXapc7PiHgpUX/ah3+/v+hviLFTkUelVe9NV/TC/iHbBXUKRi6ABEXm34o1H8Sj8DgXBYp3LFAGg9aFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565811; c=relaxed/simple;
	bh=KaRJ90z1TbXAFeQVM+8LhfMJYA0arBUoY3wDAURj0l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loz1gWBQ5lnw7tFc9a0TdTCzly2nbtlSLeiLbZXwQMYNJWh65o1FgcgMO9RPg1AECSp8OZXw56I5wxgsyu1/HdaJiNRxOWLkwrkGyoSAHhI84fjpKETSuB7sVbLzX7J+qH9BYeGHq4UQ21tzmZoEFijPCrSv3FVyfd6Q501HunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afbn0NU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afbn0NU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844491F000FF;
	Fri,  9 Oct 2026 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565810;
	bh=HunNinc9SG89+VIP8TJHVz99lCk4BIchEcSpbK3f13s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=afbn0NU5k5bTg2MpxIE9kaUIxkt9fN5EC+rAqpkBeJjKNhQXcdlQGp/yVilaM9F2t
	 +Bu/Y9+YmRX81zzCaIL+1eoZ8LUFC+H2MQZRqcN4qaBcmgBA97bbYyIbsI9cJk4f0V
	 4s1kvxP5bw5QilK6yp1c5ee/o2xX05xKoIywDNH5Z1b82euOcWC3zHyDofEoDxbe6N
	 yrmaot5PtIIBWrYYR/vHfhYL7/dfVwus1HTZ3t8NRx4AqLYuugSzF+5YZ6QkVazC2E
	 0x4q85Or+LSDvkpBf4zyRjLQX8jMhr0pUPal/qyhuL3r3H8xHff8MJx5myCPU3xGu0
	 GqDwWkIMW5V+A==
From: Sasha Levin <sashal@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>,
	=?UTF-8?q?Fabian=20Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Joe Damato <joe@dama.to>,
	netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Stefan Fleischmann <sfle@kth.se>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on macvlan/vlan with bnxt_en
Date: Fri,  9 Oct 2026 13:09:38 -0400
Message-ID: <2026-10-09-1-daily-reply-0001-bnxt-en-dma-length-fix@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cce34174-a70a-4e59-9c35-fd74309b0fb5@leemhuis.info>
References: <cce34174-a70a-4e59-9c35-fd74309b0fb5@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> FWIW, better wait a little longer till a fix for another regression
> 447cbe95ebb9 exposed in another driver is fixed, too:

Eric's bnxt_en fix is in mainline now and does not depend on the r8169 issue.
Queued for 7.2, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10.

-- 
Thanks,
Sasha
