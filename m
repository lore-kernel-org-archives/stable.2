Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B54367B85;
	Thu, 20 Aug 2026 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255460; cv=none; b=GlMmRsWvGUKlMXvL1wYTD5Tj90CWK5a5AZeNZuIjzQBDqoEnhs3rl9aLNW+L8uu4QUCNd6wio5tXoTnUSBQYXXXdSRZXZZBDOni81PV+4yFMIhOIBISp2J2Va0asKoKplMxwXMNDLvhLosjIV4eHWYGkEPdD9iSuQKatbo2amfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255460; c=relaxed/simple;
	bh=jfVC4X26EOAPXcnHKlMWJa+fPkEB2CWXZz1cAomQzpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L6+iCb8aSMD2RrfrMKeSa9KQx6THbZvVy8eVclix8SlkBKzf9D2CikGCppgyWU610TztaFH4/ksx70woL5lq1PXRijtvFjU1aheyxiK/eMptFuhfEeAnka6QInbEpBi3MCFISlPsq7vANL6bCpN1XKaFbbcAosKy6SON2IFjtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMg32WZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMg32WZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677631F000E9;
	Thu, 20 Aug 2026 19:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255459;
	bh=Zgd8g2CWWh75vQo+lLUqyOpuffa/PY2Xc8KWOvYEbiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MMg32WZxzL/KqI4y2Qpgd8FwKHofIJvqYhGjhbQmEkAw5i+UvnoCjv9QV+PTgJtgC
	 NtMh51R69u3IkeUF1jSYn20V73h/7Ybb4v07h79iAoP/D1b6ImwIlNr/ZPSw3R/3oH
	 ZPgi1zvPLxc6ESMjYPpuLtt43yXJvFRQ+74l/Xmc2OqCu4Pv5EVm2ziha/0lrxXJcH
	 vijbMhNYefWTkytPVdRZ0fg2CPyIPLd2lO1U6nJNMlMXqtk2yS/PTESvJBsrmKWVxY
	 HnHSJUNxS3k9GMpo8+pbWpLGWoJO5lkClrnfrQfMjLtucaR+LSzAzPLL1pzBmb8aQb
	 PQYn6fGNHRxQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C06392445B;
	Thu, 20 Aug 2026 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bnx2x: fix double free in bnx2x_init_firmware() error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725540964.453960.11612397406517093275.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:50:09 +0000
References: <20260815122149.951215-1-yijiangshan@kylinos.cn>
In-Reply-To: <20260815122149.951215-1-yijiangshan@kylinos.cn>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladz@broadcom.com, eilong@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 13667453960@163.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 20:21:49 +0800 you wrote:
> bnx2x_init_firmware() frees bp->init_ops, bp->init_data and
> bp->init_ops_offsets in its error path without setting them to NULL.
> The cleanup function bnx2x_release_firmware() frees the same three
> pointers unconditionally, so if init_firmware fails and
> release_firmware is later called (e.g. from __bnx2x_remove or through
> the function state machine), all three are freed a second time.
> 
> [...]

Here is the summary with links:
  - bnx2x: fix double free in bnx2x_init_firmware() error path
    https://git.kernel.org/netdev/net/c/d2796ffe38cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


