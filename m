Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896331;
	b=qQ5SM9au7b/dLZG2NHeBUE/j/hKmNJ3iKvjGRpWSUkPeyFqFfhshYOLCizEfNt2Urz+R
	 ZnXWV/AMMR6B8Fah351bdesL3ho+dZAdBsmrpWxiCL3jEA1Fwh2dte8nPbgI89FwprtnU
	 Jh0qG2jlNi9VmragdvfpZkmY51rUbc5CV0tsFf9qtzdqyEJc5zDmHPckfetdZPGZbExeX
	 xs7rrLtfKf0FjZNP9C0mYR3vd0wfPHdXDx23FNLcwe17I4kdDkymyvdhFtgyZTTJVrbU6
	 95/crhRPpumswYKPJk9IPEbWzbgNHUC3eOKtfVgXBaeeDKswBR4unAYj0xGCQj2Oijg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896331;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=RdsDOWQ+o3TSZXXBqT4r40k5Yn2DHNIodg6BnWago4g=;
	b=Ebbc2z3f8xMP+QPPmuHk/uBcOvNWGwwh5RKV0dlFBf5fiYmE8AkAKIr9ROMau3j3VNWo
	 wIGcaxZBa8XGOZAXcY67vvl3+klUdNvODh2p1mXO3UGoXT4ILPWwF/S2QN6uwydWUvrlc
	 eQlQMEir5OlbaSl+MNZv9VVuHc9dBOOF1ky4oOnGTa39AtrcNBvKCmSODNxb3h8eDQATT
	 I54Dyjv58InoVsBR+pf+Ezyqy6JwdK+TlOksVUo4DvXygfWsJpCyNf7O2Iq7m8SXCkVcj
	 uTPLqOpq9qnsm6xbd7XY7Y+di4d7KC9mSPfdtL5e7pRqopnSphmKsaWdur94Fh167kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4GurPdD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C43606D833;
	Thu,  5 Nov 2026 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4GurPdD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46D01F0093A;
	Thu,  5 Nov 2026 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896330;
	bh=RdsDOWQ+o3TSZXXBqT4r40k5Yn2DHNIodg6BnWago4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j4GurPdDp03B81DyPR5Ixv45ciW+nKGTCzUcp0UmZfYdh685gs+5b47bcRL79ctqG
	 MCStEpwq0io34NjXNi7qh2MoehfC5RPinO+r7dj45LhRy/MSfgcA+qdczDinTCLLh2
	 sildGL2epOinqMJBiBi6Bm/Tsb6k8XAabQDVDPvkkdxYoO5oj8sG2+Pvdbt0Qm2IyD
	 aeQgNtGdrbBGvIySeaz6lahFMh6aN7UIONWWZsB8t56aORtp3fC9gg2Trh9UyWJYJ/
	 3ZcNjOK2C9LijyiJ2+aigGLuFVzW47EQhv45TD3TZO4p3RqgbjsyWO/+p3GIOHjSlN
	 Xdyi6wPDoso1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA39D391B173;
	Thu,  5 Nov 2026 16:32:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btusb: fix use-after-free in
 force_poll_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179389632955.103975.1644847337972087743.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 16:32:09 +0000
References: <20261105055639.12824-1-25031212351@stu.xidian.edu.cn>
In-Reply-To: <20261105055639.12824-1-25031212351@stu.xidian.edu.cn>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, byu@xidian.edu.cn, wencheng@xidian.edu.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Nov 2026 13:56:39 +0800 you wrote:
> The force_poll_sync debugfs file uses the driver's struct btusb_data as
> its private data. The file is created under hdev->debugfs and is removed
> only when the HCI device is released, while btusb_disconnect() frees
> btusb_data unconditionally. The HCI device can outlive the driver data,
> for example when an HCI socket still references it, so reading or
> writing the already opened file then dereferences freed memory:
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btusb: fix use-after-free in force_poll_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/868c886f45f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


