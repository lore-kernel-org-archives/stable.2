Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B524E73AE;
	Mon, 28 Sep 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610112; cv=none; b=YzYzotLf/vrb+PKn9D49moqvQL+js8dAZwHOKrFnxouKBX1uAXllDOcjY3gtVoRbkGCBBG0GD06wsxNzS80X68n2f4RWeB7NRQjn1c0slPjIMmKDU54O3uzdEvwOBhEU3vN0KzRjMAoWLsNqv2T654DcgjZn+dFRpfgfS1O5pIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610112; c=relaxed/simple;
	bh=FQ6PI6aBvOORmKr+YpQs09TPlRqxpWRpj7pxNkw++Rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Goxyr0eW4W1QlHg0FBRaKWT+lPJBlcjlAJ2Y9V4Rup6kXNJXTlkU0Dhw89iyIby/66Wx1JuAGYLrz8wsrIx/olVfIqD0wSpEPylhs0CuQmhVR75iDivaOD6FW+foNMbn4GyPBsh4JGuR/a2K2jfvNmzTxPA9j6rvLchwJ0nSqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVSVAxTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVSVAxTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCAD1F00898;
	Mon, 28 Sep 2026 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610105;
	bh=XkcfXbhgmki/IWwXqIyzW9WPSw+AgD/WGJH6WTi1zyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JVSVAxTWojgF/SPikETykZ5wWbGVMSsolTRIr7zS11XViylwFY5XoXmc+x0w7ILCA
	 I62ehViqtDTQRuwyfPy9mOJTbbuLBT57/TIEsK5obDG03YL8KY2DC2AaN/YSJd84ho
	 0M/glbOBvmmzs09Ct2iDVVFfjb8Uq/o1lG3IprqwF6kOO85bOQljrbImNsDbe+cBmO
	 56UrH/HwzFf77pp5sPphMUIs03Y5FlxT1gmFSaEO1ZBAoR/Z2M1kfdfGHGwINK9WU3
	 ip2yco2zH6b3xrCbC7bmPGipDA8rd9OyC9Gr98OKPN8664i47hnNlMl+CdkIf/6vIR
	 rTdDK+Hi7Zl8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B483924456;
	Mon, 28 Sep 2026 15:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Serialize SMP remote OOB data access
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061003014.4169639.17182222641620066835.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 15:40:30 +0000
References: <20260927064250.3692041-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260927064250.3692041-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Sep 2026 14:42:50 +0800 you wrote:
> build_pairing_cmd() looks up remote OOB data and copies its contents
> without holding hdev->lock, which serializes the list's writers. After
> SMP finds an entry, a concurrent management Remove Remote OOB Data
> command can unlink and free it before SMP reads its present flag or
> copies its random and confirmation values. Removal can also invalidate
> an entry while the lookup is still traversing the list.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Serialize SMP remote OOB data access
    https://git.kernel.org/bluetooth/bluetooth-next/c/81a2345f1984

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


