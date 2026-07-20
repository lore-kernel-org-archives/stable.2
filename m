Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776539060A;
	Mon, 20 Jul 2026 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578844; cv=none; b=Ga4AxgLx/HkOApR5pwKjwVj1lqu0LFQXsN0Cj28pdmdmI72ZPjghwd34hzmMoFolqkbCeoTvx4TXJaDs39qXGu2oQSnNooVTHoKOkL99Szmq0kQwFl2+/NjuPVFwvI5EtcptpDzClxX/ddZxHBb0x5fq94wVL2JFqv5jfbMQu5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578844; c=relaxed/simple;
	bh=Ba1J+CMd2ox1+61njIKXY1SgE6iMQIWZiYaGK4AdwxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F7slCoBKQN4H0EzJtuXBp0GHWpO9+WgIm+gGoCZXZmtlKRpIeiDoJ39cilkfBIsVHnHCnnNwUQsDmqb7KPjYu8G76ZvQQu3XK5ZilxQ0drfKP7QTuORMWF9KEGytZok58YW2pFEwZCC7NeZVqef4NOKIwg19ILv0GNrLC1Av5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuQUIfmo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuQUIfmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711441F00A3A;
	Mon, 20 Jul 2026 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784578842;
	bh=8ksusWd6L1q0B1xnycc0Me636psjG/W11hwItRTC+qQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IuQUIfmokuy9xK4Z5U+0kPwXHniwuBt0cdhED5MQokOBoiFqZfKoDxAQdmXL1dvIX
	 MDmwPA6GO8grSdaVy4xM0Z3mm/gsF/XBZMBpakAqmmpYVyZDSxZO9+xp55FEBvBQE4
	 lzkrFajkihPLs2JFW173nVJoVPBizEnzJokeF0XufS55pSLWeIaC8CCOMU1MnOabSe
	 FlMXl+/SLND21vp/XBBpbYHVBq7XnmKRj7vZoDNiNqyXX5aV7XaHq8juRQ1o2ErThF
	 PpZOZvdmeFt58k5AJoXmG7xOnbNC6BE3HOYHBb9dXX23/N7M2E60net5g75Eex6zsk
	 FcjQ6volee03g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B0B39244CA;
	Mon, 20 Jul 2026 20:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Protect UUID list traversal
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178457881239.4151939.8896306930179003502.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 20:20:12 +0000
References: <20260719162427.2902105-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260719162427.2902105-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Jul 2026 00:24:27 +0800 you wrote:
> The hci_sync conversion moved class-of-device and EIR generation from an
> HCI request built under hdev->lock to asynchronous command sync work.
> The worker holds hdev->req_lock, but that lock does not serialize access
> to hdev->uuids against add_uuid() and remove_uuid(), which update the
> list under hdev->lock.
> 
> The following interleaving can therefore occur:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Protect UUID list traversal
    https://git.kernel.org/bluetooth/bluetooth-next/c/9348bd469f56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


