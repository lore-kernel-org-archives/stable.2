Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D533F37A;
	Mon, 22 Jun 2026 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147637; cv=none; b=scxAsGSvDjuaRmd3lHiM0wRJKU+DGgmjtiZoGYTtwpbor/7Vkp6ZTSgkYpMN0Jd4vww/Xq2i3mkF2lgYKGrXLydkzBboHKTRBrZ9Eum9kS9NtvZWZotiF2aGOzJoSOkLzxfmDOyUtSklY3Ykr7HgX/BF89SvxEETvMLQJWNdeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147637; c=relaxed/simple;
	bh=Y76B94b9hHBXWi8gLSdiewR8v6h211PzyMLJK8QtisY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W2B0twuxIQOXRqYX7C888oT0s/MoGySLGIHCXm/93YLX0jPDKyc1oYXod4kFyQA9djyyyTkzB8SZtOpf+4SCJOK8MZJiVyCUpnNdMgqs/H7quyPqet2TaGdN/Pj9ZDynmCUriPYz9LAPkTx3/X4WPhK8g73xBOMLToxGx3zlW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKTsEG4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKTsEG4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863A51F00A3D;
	Mon, 22 Jun 2026 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147636;
	bh=bnq2SHOZ+c/0iE/Ysp2xBQWEWnq5JGbiFHR+KRgrnKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LKTsEG4w7WOWcgatbdp8yLdVULzs8Es3PIDfM8avQhaWTrUO2DDueEtf0WPxtFDpv
	 ynBAQCT4BxshVRj/ll3Woz67xGRHXZMtuh9e0nT2mlu4VE7HHn2Vz9XsfN51665rfO
	 2HN6L5RckpOrprMlA10EOyXewtGddr2dQvirkpFwKeUSTI0WQO/nQGyAq6BVrz2JET
	 VpQyl660RaSL2119ZPj4yeXB9ImEGTNJFe8Mn8aJJhMojpUQZ4A/7JL8YbXyb82d+W
	 eoXxCe/AVptB8kKzHTJApw11Rrm5YorvJvl9iJ7L4bIrp6BQrYDrMaR5cYwkqYCWoL
	 q8UOHwcduM/Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A523930917;
	Mon, 22 Jun 2026 17:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: cancel pending_rx_work before taking
 conn->lock
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178214762700.1322955.1313476336537592947.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 17:00:27 +0000
References: <20260617153613.1139031-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260617153613.1139031-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 jtt@codenomicon.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Jun 2026 23:36:13 +0800 you wrote:
> l2cap_conn_del() takes conn->lock and then calls cancel_work_sync() for
> pending_rx_work.  process_pending_rx() takes the same mutex, so teardown
> can deadlock against the worker it is flushing.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock
    https://git.kernel.org/bluetooth/bluetooth-next/c/cfa697b22dad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


