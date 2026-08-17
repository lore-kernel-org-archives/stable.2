Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DC3A7F68;
	Mon, 17 Aug 2026 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995999; cv=none; b=cyhMeyu/d0eUNj3vHa7w7fPF1GSu4v5ynW7QgqCvjANOTxaupohZYGKI+606FyNpVIakGAVo2RHldpzE/aFFnPV5ZIyI6DOit0ytd5G2gsG8Rj52Ymtk4Mh9k5/coXG9M2WxSob1YsVjIAPqFF3JQHxc+pPL5PJaIMDs/TCZtKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995999; c=relaxed/simple;
	bh=IgzScUnqMk5KpoBtylhThrPO4wAP2VTjcO/33qzWPEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JmT6D2PqrryLfD64Vzmgoq1lmEmJKX9XUgWEQMj9anePMb8NfjfnpO273CNKMuaVCAEs1VXHGYtjQ41D7j+PHBseD4DKojhPdx4sHA8tj340aK+q9nQ//BOQEa5jJsJn6/JcfryxNhBaYlOJhteqG36J44/lQ4w2J9npxQwxkw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXE9SNbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXE9SNbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AC11F000E9;
	Mon, 17 Aug 2026 19:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786995996;
	bh=jYtufi31esdthh9skm50DsS40oKA05LQqbajS7Trxzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EXE9SNbuoc/FVdgBY3XEwncT9Oe1hlZbedIMw2pfqDCgd+yI5VThgL3nQEqLF8z2O
	 6BQeLZvK9w3M+2GJ8Zf2jN31swsywkBchOlK8KLCYSQ0vDSenuRGA858WO+hQHoXbG
	 ROq8+MWxb4TfjQljoc1JMennkP8rOmRFld9dszNEAAs4TAJY9FAZp9YI//aVyHWgx+
	 q2x9NjTIM6mbK2he4cFc00s2cgvDB2I2ESU9OCi9lX5x7z5xQW6858PD/5jv2hqPal
	 +jxMTenqk3m5yC48AXZp8iPP+BrpIQqNBK934knQNQKweJ0gZ4NcEZFXsNGz3x5Hf9
	 9v/dW25V+jnrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C13926262;
	Mon, 17 Aug 2026 19:45:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: npu: load the firmware without the
 sysfs
 fallback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699594816.1691257.16349624064991937172.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:45:48 +0000
References: <20260811181717.19339-1-sochnev.v.74@gmail.com>
In-Reply-To: <20260811181717.19339-1-sochnev.v.74@gmail.com>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 19:16:59 +0100 you wrote:
> airoha_npu_load_firmware() maps a missing firmware file to -EPROBE_DEFER
> so that the NPU can be brought up once the rootfs carrying /lib/firmware
> has been mounted. That mapping holds only as long as request_firmware()
> reports -ENOENT.
> 
> It does not when the sysfs fallback is in play. With
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK set, or with the fallback armed at
> runtime through /proc/sys/kernel/firmware_config/force_sysfs_fallback,
> request_firmware() hands the request to a userspace helper, waits out the
> full loading_timeout and returns -ETIMEDOUT. The -ENOENT test no longer
> matches, dev_err_probe() turns the result into a hard failure, and the
> NPU is left unbound after stalling the boot for 60 seconds:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: npu: load the firmware without the sysfs fallback
    https://git.kernel.org/netdev/net-next/c/a085e68b1390

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


