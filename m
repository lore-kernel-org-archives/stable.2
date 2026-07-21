Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0EC45A2AB;
	Tue, 21 Jul 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672448; cv=none; b=AU/hKwrDzd89fZvO3TTBDKb7ZrjCK0jHKigBdsG857uSl6GNYFaKHFzmh8EOTWAhGM+Pzyy7lha3V1kShk4Omu2csgajAEHLJolIqvcdCVrQcbqhUp2Cw7znceAWC5ZIj8a56kohUw3puo0+vlzpIh9tUK2zL69QQxr7YFMukU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672448; c=relaxed/simple;
	bh=QIQh1LdMMndMhz+L/LERUwLYT3a3pIfoXWq1+5CF3d0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WC0qCHBpdq4npztDRXX1ZJAuqs5l+dzlnI7uqWyUdy6uVL0/NYagwuGmYeJOSve8cBPHqnQjDnuBl7CNcXAjFEOZprreZtN6Mwzub7W1IfGwfy3AtkM446koq+jX12oQ01IyGLqEkxshC0/NWrUZbi0WgmFtQCRawHHT03Svays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUw0X5F1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUw0X5F1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9E81F00A3A;
	Tue, 21 Jul 2026 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672447;
	bh=d406LyygWXzblmhEB6WYT/uTq484gzGIOF02k4unhqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IUw0X5F1XlHvov5TFySN8S69WLT74DrO4pNYBUXvZQPKw2FUMJik0ktfMoa/AgFhX
	 Aq3PJ7igVktzEAK4apEW+qiuVnMGWlLnO4IL87kO1DdymWOJ9kX8/fwW6n4PNmeykq
	 MiOb6h/MSrDcMAepqtcew0o3WuB2X8PcMCEMSSF0Oyu1V0QF1PgspSqESejaNl8UTo
	 qG2UR7kgJ/bonmNbs4++RYZD2k49GoiCf/YcTkR7F2hSPz5V3O97DDc7rxeU7kYmfs
	 siI2y7aab6znkBprnPFGLgKZklFtVMZmrHs2q+rcZEOLDvyknCjfRfpkGFeubcatlC
	 ehQNIX3ViDAxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AFD380820D;
	Tue, 21 Jul 2026 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qrtr: ns: Raise node count limit to 512
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467241614.1119846.11186866513095831620.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 22:20:16 +0000
References: <20260713145901.212396-1-youssef.abdulrahman@oss.qualcomm.com>
In-Reply-To: <20260713145901.212396-1-youssef.abdulrahman@oss.qualcomm.com>
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jeff.hugo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 16:59:01 +0200 you wrote:
> The current node limit of 64 breaks the functionality for a number of AI200
> deployments that have up to 384 nodes. Raise the limit to 512.
> 
> Fixes: 27d5e84e810b ("net: qrtr: ns: Limit the total number of nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - net: qrtr: ns: Raise node count limit to 512
    https://git.kernel.org/netdev/net/c/ff194cffd586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


