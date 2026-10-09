Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1F473C8D;
	Fri,  9 Oct 2026 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555619; cv=none; b=VEzDN+VbPnepcxKf+Dm6+uiNDsx/zkpPRVJwVMnzxmJgRL7gt5PY0kD7gfKWV9WR92+ddik/4xU8t5KXyZ5FDAn1rYDuo2BQU4vgoG6o/s7aAHqBXThDW4YzywAESmeZCglXqiiiyzSRbyd7wcIokQbdhYT7uwVqpG2jstFqILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555619; c=relaxed/simple;
	bh=93bPqpFoIPN6Z9B08L/aHkYpIJxgxnZAssE/H4dKJnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=trDdA1Y3bXC/0XjG7tKau5OADvz7h38MiqfVIQgRB4GbLlmpXHHGbDL/HVAxVpJgy5HuF/rSDqIxw2oSRgVnSER9+kfBuaT8p3FBGk9RfpnakUvUHvlVTARxDQltT3nR91Knhubq8n9qFWIhT0E4WhHLLXgdTX+wjwTUsOT48DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVfZMWoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVfZMWoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7801F00893;
	Fri,  9 Oct 2026 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555613;
	bh=X8JDPuCITIvBYfPyaWuVkIqvHqaAXP03lLiDoXVg+Qs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LVfZMWoCIktdy+yKzzIjin7yREvDYZnSa1RlC5KSqKMoeoYeHI1aTHMiTHZ7mtc8w
	 0IzTrhcH/JIHYyf8CpJcMVGAaMX0WGZ5Sh0C45XXT4sc3JfSQhbADiBqtNnDmWQC0y
	 /wrEKQ94EQWZYuAmLHfHPlhkiTNbKrOay/Ua4yaiV2ldRaryEqChD1sqTJQby+Hji2
	 cEJZHRx3ji5XQdeBy++stPIno3GB1CDwS6kFvdBSYfOyT7UBAsTi91/cCbR9zfDHr+
	 aOaBE7qi1GlfPjYTrBGNBJAukQoOrxdJGZAH9zD4zMx5Eckvvu7TsDDP2oWTD2gxZQ
	 B+duQTArN4mog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772B339253CC;
	Fri,  9 Oct 2026 14:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_debugfs: Pin module for debugfs file
 operations
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179155561201.812174.6892291542337327416.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 14:20:12 +0000
References: <20261008050140.483853-1-dungvn2345@gmail.com>
In-Reply-To: <20261008050140.483853-1-dungvn2345@gmail.com>
To: Bui Viet Dung <dungvn2345@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 12:01:40 +0700 you wrote:
> An open debugfs file retains its file_operations pointer in the
> debugfs proxy state. However, the file_operations defined in
> hci_debugfs.c (use_debug_keys_fops, sc_only_mode_fops,
> ssp_debug_mode_fops, force_bredr_smp_fops, force_static_address_fops,
> force_no_mitm_fops, dut_mode_fops, vendor_diag_fops, and the
> DEFINE_QUIRK_ATTRIBUTE macro) have no .owner set to THIS_MODULE.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_debugfs: Pin module for debugfs file operations
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0352b2c4a5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


