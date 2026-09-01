Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCDE472F9A;
	Tue,  1 Sep 2026 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255072; cv=none; b=X+s870eqWnynWk0Yt2rjVeFy7M5JZM9yOC4rEhuUYU/8p0VH74H8OFm6sGM1RHVdHWKt8MXKb2sO8ojFFktqG0+szaCvutYdZKnG+GnszMCkZXrwEHoIVC5qo0+BnAFzori1G/9iAWy0nYke7FAoADPJO7+qVtFiiTbsou5XCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255072; c=relaxed/simple;
	bh=ySarOAj2Ngtg8dGv3Zc0vmJS/Jel86X5L65TDiwzrT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GWTTiSSVrQpdFIXdzMe8NIzih3P0iggtHrMNP7QepjgSQ2BQ4VlU+FLPTzfxRcm9ns6QYHw2soDwom1/dey7mkQawv65rb4Li00rBFn5Irsro2VV2eZNhSEtsSXTBAcjSyIEVr7uLkyqBPbEPIX2IFuorT/8LyCWVJINeWEZi5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuY8WXLU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuY8WXLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331391F00A3D;
	Tue,  1 Sep 2026 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788255063;
	bh=PN3YfDnfO1n/4y3BUgaBKZa7e5TfnlqNDUTvPDXiRxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QuY8WXLUtuRqh3tPpRH98v4tavsTDOGqCY3ePm1nVXxlzOGIbVAVf5p/JF/Zbxi/Z
	 vAJhScsTftF6nII41ProNHxdOFMc1HIgZYcFSilLHVi0Tn/UwjhJXwgtJliJfHdBsA
	 CF0DB4+WZc7A2b/hDi/GYXLD5LdeuykdWyXwFFpv/SEGNbi+vDrBo4DoSV/0imVyx6
	 Kse0k5+7WYXH/ml/OwB8o2aAKVXUzxWkkxHjhqWaIgNrh/38fgTrq3DfSnUIvjqjav
	 2UCVC0vpLGccZ3vLKRnUuxlukG7vstJCmg3YVcA+KYnysS8O8WgpmtKePblZEP3Nqh
	 RPRVAQVYZ2U1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990B3924FCF;
	Tue,  1 Sep 2026 09:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] mac802154: fix data race and NULL deref on
 local->assoc_dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178825500565.1063663.12153518921874047714.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 09:30:05 +0000
References: <20260829230551.1787432-1-skwkevin@mail.ustc.edu.cn>
In-Reply-To: <20260829230551.1787432-1-skwkevin@mail.ustc.edu.cn>
To: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, linux-wpan@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xuanqiang.luo@linux.dev, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 30 Aug 2026 07:05:51 +0800 you wrote:
> local->assoc_dev is shared between the association path and the
> association-response worker without common synchronization.
> 
> mac802154_perform_association() stores the coordinator pointer and waits
> for a response. Its timeout and error paths clear the pointer and return
> to mac802154_associate(), which may then free the coordinator object.
> Meanwhile, mac802154_rx_mac_cmd_worker() may observe the associating bit
> and enter mac802154_process_association_resp(), which dereferences
> assoc_dev.
> 
> [...]

Here is the summary with links:
  - [net,v4] mac802154: fix data race and NULL deref on local->assoc_dev
    https://git.kernel.org/netdev/net/c/c037915f80c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


