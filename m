Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF92583ACF;
	Tue,  8 Sep 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885103; cv=none; b=pFoiyoEzyyjMTlUoY+HQDiz4yDUwl15NAuMZ+YMzBsC04NxGN9D1NCuFQcxcB2hHksmQs6ibxTGDAY1FnxGEtecRYEA7XQHYlfsvM1z2m+BN8IOIBDXGqb0ZRJKxUB41g1pKDemliGJHxQUbbVAuO3KOZ8Nanf6X+GMqBGr6/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885103; c=relaxed/simple;
	bh=rkA2D6D0OJGb/uHX8Zeilbg4OreW8AGlDL3eOhH+eYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XDdoDijqIlw0G+4ttedk1ysVliea8WMrIacxlIVpULlvV2IOvXa8VE00azi81FrLMCJUxVzkCSXMQDo5ekTQKER0eS3i/BIglop4pXzSJmwIM9TEdmNf+G7OmAonciAuy5gA01r/mA4TwERWAJhLbD853K1M4OtVdp88iEHKMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcTUm7Wk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcTUm7Wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AC31F00A3A;
	Tue,  8 Sep 2026 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885100;
	bh=cm6AtW/nTOo0oUVjEr/M7VuSZqpzyHjLjcpMah5uueY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kcTUm7WkfZhoFjB4APM0TB9BjaMGcnA3L4FbcZRD/dg2Wo7zeB9gsP75kX8igNh/Z
	 6uUucbUjxBsAvVkkO3MKQvzSJ/6By0YtYXkAF/DywY3ctPCbzUE/AivOLtc2behDYB
	 Ce6hs46udeHWhADYXjlrbn6HGcI5CGN23QHHhS+cATup23BCUQEoRptS6SYGQNtDov
	 e1W7Z7sU8pJ+JldUD2cxIq8CnE1dCxaK9hpu6OJisBrCKPQTAwYY+8b2VLW4noyYdL
	 az0ur/0Mjf2srqm0J0KDPpYJZUt1/Zpx3Zmbw6xEnG7zMPB3WCvXHaYfuywgzhiKcN
	 bLAhjiOZJ7E2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19D4A39EAF6D;
	Tue,  8 Sep 2026 16:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: eir: validate service data length before
 reading
 UUID
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888503863.3627954.209106965339274612.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:38 +0000
References: 
 <AS8P251MB00013029B476B1D2E05DF190C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS8P251MB00013029B476B1D2E05DF190C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Sep 2026 00:37:43 +0100 you wrote:
> eir_get_service_data() reads a 16-bit UUID from the service data using
> get_unaligned_le16() without first checking that the data is long enough
> to hold a UUID16 (2 bytes). If a malformed EIR entry has a service data
> field with only 1 byte of payload (field_len=2), eir_get_data() returns
> dlen=1. The subsequent get_unaligned_le16() then reads 1 byte past the
> field boundary.
> 
> [...]

Here is the summary with links:
  - Bluetooth: eir: validate service data length before reading UUID
    https://git.kernel.org/bluetooth/bluetooth-next/c/334ddae615d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


