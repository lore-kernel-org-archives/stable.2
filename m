Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D46480947;
	Mon, 14 Sep 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396274; cv=none; b=V67gFUVzKbuqH4YSRlAG2jGthoJX9/Kv9gRTtRgvcJkQLIFrhXCNxCiMsx2QovwW5ulNf0nw+sg5brKEjJyMWBVjY+1TOo7fwZMWzTQssJvUsNFie3BWTQa97NCJbCOaNoITNN1MZQr9sNUlk+mqzKXU1jPlDBWQzHHtS5KhtNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396274; c=relaxed/simple;
	bh=f8sy2jPrUkUc71KHP7MAq06gUSKUxaMbdjJoToIyDgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NHuss0YX7kUDxuUfmabDlq1BC3X8zN4gyh96dyYDCwMtx+gg6267JF5NtkexhLS3nP4L5+01fitiej3TA7lBiAr7jXAIYwAZUGtBDoSsvREUfdefw0Ve7uARO53kJ/fb7qPlhHkFx9Knk6crUqoscZ3IUN70+xCW+NTKhStApmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMAp12zM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMAp12zM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6D01F00893;
	Mon, 14 Sep 2026 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396272;
	bh=xX1m3zLAl2wUJvPGDhwIe38PMBzav/HSZY/DlJfCCw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WMAp12zMWj3Qf2IwOfR0Xjk3Gkn/5n5AFfJGvVmq2cUsUH9rYV3+FDQU7toPVnK04
	 bKmNAk6Nwgw6ePpOVFVGxS9YdC2P6trFP7/jd6kEliDgWTCP01WqBnco5jlIwjrLYp
	 630CD4LonuDN8lbTTjwMM+PJjILlfh5KO29cjq7g3CmrWhTh/GLEh5u/lEy/PIXk+Z
	 bmcIYhdY6jXhkaXdXv0RrPl2aATA0Sj6/nSOwD1YHIomvGcg7t4tJk7DCjLrhRW5a6
	 KyFAm3txS7Z6JYBi968WMlV236ADnmuckU6sif+dmWc1CujjGsWhEmZVUsb/24PdfN
	 GaXfFEwnTVEZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C63924A67;
	Mon, 14 Sep 2026 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: keep dst_type with dst when reusing an LE
 connection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178939620713.604238.4398893815001595564.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 14:30:07 +0000
References: 
 <20260913-for-upstream-le-conn-reuse-dst-type-v2-1-ed1d5dd4ae37@podgorny.cz>
In-Reply-To: 
 <20260913-for-upstream-le-conn-reuse-dst-type-v2-1-ed1d5dd4ae37@podgorny.cz>
To: Radek Podgorny <radek@podgorny.cz>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 13 Sep 2026 22:28:02 +0200 you wrote:
> hci_connect_le() swaps the caller's identity address for the peer's
> cached RPA when one is known, and stamps the matching
> ADDR_LE_DEV_RANDOM on the local dst_type. On the conn-reuse path only
> the address is copied into the connection:
> 
>   if (conn) {
>           bacpy(&conn->dst, dst);
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: keep dst_type with dst when reusing an LE connection
    https://git.kernel.org/bluetooth/bluetooth-next/c/1e892ee7af70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


