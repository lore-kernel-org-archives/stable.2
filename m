Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0F4D9F7A;
	Mon, 28 Sep 2026 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616684; cv=none; b=KoOO8Q5TaVWE6t/S5lAA/VF6WM8rQd6bpCB/WuqA7OLjItYD4/+lRe3W0rJJoQv25vaxZTVJpHYEjHceKIE3yW1+/C4nliILpgvDL1NAlr4GksT0Xf7tJwkRkGUgpPbB1nkXYlYsk6ZOuaWeirkYoXhsNHEduykT0djYMmYWvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616684; c=relaxed/simple;
	bh=gtb8dE5DjWNX8LLndwvWwB55+9YgbDbsy5qnxIngP+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ip+P1AJPJAn/QnKAckIH9XKVr+WcDLI4gshTiVBN8HH0QWdS2JW2JSUM7/wFtDCChnaJj26D3w+RKcmHkx1xEdN4vYE3dVybBB8dHt9761TtIIvmvRfox6gu1o36Vij+zRR94cjZzyg4twl4wyKploaVl8TPXfFx/MYF8gCxQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4RaGLWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4RaGLWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A25D1F000FF;
	Mon, 28 Sep 2026 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616683;
	bh=pHJYtikXFc1vtR98MlddK6htj5JKY/hiF30Xh6nEIVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f4RaGLWKRoCsV6GG4KLOh6fMDi4ah1JIdK1MBKpu7hjXmO2nrbueJD7zIo0CpJKPA
	 H88Eo/vbrSK5LwOn7SBtecAwi94cV1p7VAf7ihJKX/NinsBoUs8Zr5S+pKo6xfBDzh
	 z0ChSz8ZoSAsLDnKQG7EchwPA/8fUnxKNqQ8+3bcZIQj4ShfpTWpJCLaykw5LQpv1M
	 RBNr5uJ3djA8OBw2i/qBKW3AJmGdd/Hk4dE5vAVBJgerWYuVzTOX9KYCbdUEqudhSM
	 +VV9TtRG9w0X/Zf7mWirGfKuMl1Gv5UuFNcJN5TFuqVpBYxbHLD/5ypv0l5hXrZarg
	 mohyTf/X9Vehw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199113924A68;
	Mon, 28 Sep 2026 17:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: SCO: serialise sco_conn lifetime against
 sco_recv_scodata()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061660764.34603.5921039762584362076.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 17:30:07 +0000
References: <20260926212145.1343318-1-qwe.aldo@gmail.com>
In-Reply-To: <20260926212145.1343318-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: pav@iki.fi, luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 26 Sep 2026 18:21:45 -0300 you wrote:
> sco_recv_scodata() upgrades the weak hcon->sco_data back-pointer to a
> strong reference under hdev->lock:
> 
>     hci_dev_lock(hdev);
>     hcon = hci_conn_hash_lookup_handle(hdev, handle);
>     ...
>     conn = sco_conn_hold_unless_zero(hcon->sco_data);
>     hci_dev_unlock(hdev);
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()
    https://git.kernel.org/bluetooth/bluetooth-next/c/816fb1590a4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


