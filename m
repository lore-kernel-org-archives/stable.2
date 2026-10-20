Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520410;
	b=PXiwGMMiK5ZFplcsBEF7juaDPbNonK2q6Qx0CU1gKYhI43+XCoMAv9h0uWXXtbde24yi
	 YtcyjMlW44kKMM/52Y3L7YnbiFsn+z0YqhZU0A9RxIaVi9Zt7yQx0SaYQ9SzP+xfiIR7n
	 dnJbDyiSUi6PAOv0uar/GBfWZ5P+fwy+RDLd4Bh2WUaa7naTx8y8fV7GGMaxZBoGVRutY
	 O/+NO3tF7LW1c/cp0TxGahijxVoXx95mXLx/ObYbs9Q34+EPcZm7fNoxJE+lTUdkhV9+f
	 f8jxbKK+DaKOE82oDlSanHs4ngNsFZFU/6EccuNqVn0xbwAclHfzg0ugCW4xyj9OU2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+n/hPo5fOiljDc/oHHs8RKbP+gZvCbO7EhE7WET76iY=;
	b=lU3s47K5eC90BaHD3eBZpLeooYx27wOgqL8Da0IEh8yhodrDuSA6hFBZnpI297UuREvt
	 GVqW6aujxxE0VSA75DFHafb4b0vR52KauFexNsnXdGSzHvlIAbyz3YmrSVChKvO2tNePW
	 MH+JW5jThnsJgIz3XXKJW3ngQfpOWkugiiGUunifyWSfZQhQqbVVELuE1DSx1HtSkHYz0
	 tLIwkxQztX3PFGUDw6VBliuCxqQEWua/OekyV2MjMVgRkam25ZQ58a91oVkAC0Z2M43Hh
	 AdxU+bJ1Yex6W0tXrY5MBUDrHITDCoX3zXZUcaL8Zz6gLS6AUn0+482AMHbYuCnuNmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4kVfmG2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E92606A31D;
	Tue, 20 Oct 2026 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4kVfmG2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816AF1F000C9;
	Tue, 20 Oct 2026 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520409;
	bh=+n/hPo5fOiljDc/oHHs8RKbP+gZvCbO7EhE7WET76iY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G4kVfmG26mRhRUlzlqSul/RUernmbvj2BXG5lLf9OEdnfZ0tSl0ZqPk/r3ilmRgo1
	 uvd1SYZoepKTDn8XVcpvO9ad/e2jITEXGlmYtcsUnZW4hhw6dAU4IYCR3Rie2fHZzf
	 mu953NXP6zJKwtC+0iqmaIdD4kOujoFfRGKzPfUJLgucmPE0nGm60McD+Nee/h+X/y
	 mSS6BLTFU6se3ZFd3LQrSrruHdzYJfEvnfqhrpe1UVKTldVmNBzh3zlHghJnCDHTag
	 +rUIJ6TPaQ/Ykp6D8GwofFlURPmiQJVvvZGGK9aQzhgfD1ign3vNtltHInQsL/6gic
	 1J3dHHaQELZDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773973808209;
	Tue, 20 Oct 2026 18:20:09 +0000 (UTC)
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
Subject: Re: [PATCH v8 1/2] Bluetooth: hci_sync: re-enable legacy advertising
 on
 resume
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179252040802.143064.15180267545340405578.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 18:20:08 +0000
References: <20261020105150.2863631-1-valentin.kindschi@fiveco.ch>
In-Reply-To: <20261020105150.2863631-1-valentin.kindschi@fiveco.ch>
To: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Oct 2026 12:51:49 +0200 you wrote:
> hci_resume_advertising_sync() never re-enables advertising on a
> controller without extended advertising.
> 
> It restores HCI_ADVERTISING from advertising_old_state, then calls
> hci_schedule_adv_instance_sync(), which starts with:
> 
>   if (hci_dev_test_flag(hdev, HCI_ADVERTISING) && !ext_adv_capable(hdev))
>           return -EPERM;
> 
> [...]

Here is the summary with links:
  - [v8,1/2] Bluetooth: hci_sync: re-enable legacy advertising on resume
    https://git.kernel.org/bluetooth/bluetooth-next/c/f633dda3283b
  - [v8,2/2] Bluetooth: hci_sync: pause advertising for the scan address update
    https://git.kernel.org/bluetooth/bluetooth-next/c/9b3b269829fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


