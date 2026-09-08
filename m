Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401857D208;
	Tue,  8 Sep 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885101; cv=none; b=La7oO+WleQRboMnXfnsq5m7vi0V7HLxuBBF5rWbQvzXHJIENpNTHQXFAGkFGmw9eJ5dl7jZLKejoLVaIvpHuXVHuqdg9h7u9/ztXqT83T+N9HxrNEeVz/RQ+K9yS8txafy/ZZBP30kFH7I2IknSR3bL1tzeubevhfxmi7FE3D48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885101; c=relaxed/simple;
	bh=l5annypo21zKF02Uhx3OVO0qk/u9VM6qm+u9149X+a8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mDiCLWJrJmOYE1J4Z3WuP74Vudsd90k54J8+NlpkcGoH0uTgEhmlfL2cK4zZjwQXu7aWnRvraYLZYC4oGHQJEKQZ/NE5EQCba/1R8iwk62KkOKM2yZNWYI0mGWB+5nIPPoDQDMv6IhzGdomuUaDcrCpGlFO/8epn1U5ozvbNW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy6TDEpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy6TDEpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB641F00A3D;
	Tue,  8 Sep 2026 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885098;
	bh=ST0hto7nIGleKCNdmvzwXjYj5iPNxLDNdwzEKY2YKMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qy6TDEpoSr56q4j2m2ZVQ8/6WpjDSl4OGIYolf9RjZBx0rmFHYpxrNt/9zmKOpEO8
	 BVg1wknisgMGEjK8rBhg8kFDmL8Ti4niKYB0/ZuLgapTsMnlHNK2bR/U29iTefJF/7
	 I6+497eBdfh2KNs3PQHg+5b+m2GnntAxH1aYf/1B6yhuEnalvZr1Oq62+XYMRR8rs1
	 DJDFxVJE8txw32z2A6pKCmUYhOKJleMhwr/c6C8MMgDxPY44WfVtFEV36spdKudFTM
	 6hbhXDEY1t+mm9XXXkVF4qZF8RCTts2rwe9//0ZXb3CoKMB0Dl+T5wdbbyklhafabI
	 wzv/ITatLzwBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A3539EAF6D;
	Tue,  8 Sep 2026 16:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add device ID for Realtek RTL8761BUE
 (StarTech AV53C1)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888503713.3627954.5248734968096243658.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:37 +0000
References: <20260905-startech-av53c1-v1-1-3385f9bb220c@sj.dk>
In-Reply-To: <20260905-startech-av53c1-v1-1-3385f9bb220c@sj.dk>
To: =?utf-8?q?Nikolaj_Klitlund_B=C3=B8rty_=3Cnbn=40sj=2Edk=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 05 Sep 2026 14:05:12 +0200 you wrote:
> From: Nikolaj Klitlund Børty <nbn@sj.dk>
> 
> Add the USB ID 0x14b0:0x047a for the StarTech AV53C1-USB-BLUETOOTH
> adapter, a Realtek RTL8761BUE based Bluetooth 5.3 dongle.
> 
> Without this entry btusb treats the device as a generic Bluetooth
> adapter and never loads the Realtek firmware, leaving the controller on
> its ROM firmware. In that state it advertises and scans actively, but
> never reports advertisements during passive scanning. LE connections
> initiated by the kernel wait for a passive-scan report before issuing
> LE Create Connection, so connecting and pairing from BlueZ time out
> without any error from the controller.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)
    https://git.kernel.org/bluetooth/bluetooth-next/c/76b8d73b706e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


