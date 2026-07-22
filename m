Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C13603C3;
	Wed, 22 Jul 2026 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681440; cv=none; b=X4wrZjwgYx6nJX8DgGpbF93w+T4qcVCF+cQ91nbLN+WTgvy/REE6QoO9uPF/np0goegbvinKNSjCIkkCBGI/9jzn8Ykz8QJ43MenR0PwLrPBdpPSfhICBiYjW9PXqWnA6bm7cPI46eLWCT+cy+gf2Iu5SwXi6y/KVRFwn/L8/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681440; c=relaxed/simple;
	bh=iHzmYmm+Q5gAcLkHgUK4G5YbFRF5HvYDCFmSGsZCDVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d/S0mSoKi74+Gubs1ZcEJHtOyUHR1fAZZe94iO7K2uW0JnosCykJnnlZO7fRyEAExWhzRgc+G21Xjr3NSW/EHw7MBr4IeAnN+weUjkMbRajXz7Cyci5K0Xcj3anBkVjokF3thGmb5fIpnZIGNMtB+eyCLohSWJbULSQIxu1vfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdnew6MU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdnew6MU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FDA1F000E9;
	Wed, 22 Jul 2026 00:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681436;
	bh=Kv09oRrqhZ0MmSeeXoULdUWJObG2LqKXWdMAsWFhR0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Fdnew6MUGvAyJWBerEFF63RLuKQDQHw4Qk1G6XanTR6Na4f5TxRedLJXXfbQQCaTm
	 MFuF+xdBFizzES+3+l+pxCbQZfgLCnmiuceoNbXS14kHIM8QoxRtnYrIa/a28167gA
	 nljkIONU4rCOqxvMRFVlL5C/D9WfwKPV3U432mO+vn6fkqiOqGvTI6KBJa0kPByChU
	 R6e9z6089NcqOUvTBP2qtQ1XWpRgw4Ivjh29qmj0uUWBf61uSLuug+xeAXSe1rD+JP
	 lDYTOxnVZrcslNk4o7DV9DfPpn+dCGdvfCEWo8n1QtFFXIcrPjq15WOod8dL5PuKBF
	 pJ6VAuxBMPQag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A40380820D;
	Wed, 22 Jul 2026 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: intel: skip SerDes reconfig when rate
 is
 unchanged
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178468140590.1181429.17240708889792397256.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 00:50:05 +0000
References: <20260713171619.192452-1-bre@breiti.cc>
In-Reply-To: <20260713171619.192452-1-bre@breiti.cc>
To: Markus Breitenberger <bre@breiti.cc>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 yong.liang.choong@linux.intel.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, bre@keba.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 19:16:19 +0200 you wrote:
> From: Markus Breitenberger <bre@keba.com>
> 
> intel_mac_finish() is registered as the phylink mac_finish()
> callback for the Elkhart Lake SGMII ports. phylink calls it at
> the end of every major link reconfiguration, including the
> initial one during probe.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: intel: skip SerDes reconfig when rate is unchanged
    https://git.kernel.org/netdev/net/c/0ab78ead2481

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


