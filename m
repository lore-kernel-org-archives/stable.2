Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36763C8C48;
	Wed, 16 Sep 2026 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581686; cv=none; b=IkdtSERx9y/tK72PN4gZ+YKwJzGiiT3mXnybiNjc/5G3wapbfpejsKQ0n7iVsWbPq4yCnrFHV+sFb6UGzRvyNsIgriBCuau4nQP76npGFHwz9CUUUX6MpqWmgXV9gorL67nXtyeI63RPz+24UnMKe2UWnxGL/UJaF0xR7Z6L9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581686; c=relaxed/simple;
	bh=7plchYZfAV7zz3JB0+GrbOx28iR3jnm9RxDtiIkFcH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QQXgqY8gAiBUtqWlm6NFXtELytsgr8X2nvj71bnFS2h/f74hNukM7rXY3el2371JdM0BwcwuMFYqXnGUPhsVDQm2J+/uYEIAJpMZAZeFQaR94Ix51hh8EilOEZhrUQOSF95bcJrg1OVQm0F2T3ruYayUDGoWVypFYmdBHcyEtiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7Yws1y3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7Yws1y3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9411F00893;
	Wed, 16 Sep 2026 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581673;
	bh=wninkdtFLkXCH5ftNv8UaxF1KlhkBvnETXFaxvNELu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O7Yws1y3faHLJhOhBgwbkFKs4pCyMaN6UdUoBPxS82nGJQuvW2xomxEnrtqLoUyXZ
	 wecbt7pg3khw0qqOfwlqURz/zpiHXlCV+xKG8KJsBzWEr8bLVuMfRl6TYhELAv492T
	 oowZLQ/Q/MTPVxTPWxHAZftEjTlTKkg2kd5mbnwg27gwtbpt1a0q/vRJpB5yiJA7RZ
	 yA3y+dnu+9lFUdqirwuzS4CcJvQyL29C2c4Gi8Drjkazw701h2P5c3QdqFtWxkZseQ
	 Rjkqlj7LJOoMQh7/6IWiPrSTHaa3IAf1izsYI+42wg92YVsCFjgzcPLKe4OSTn5f/W
	 Skp2eu1eBJhnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568FD39E8A50;
	Wed, 16 Sep 2026 18:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sock: validate event length before
 filtering
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958160713.2777538.3303073061457173615.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:00:07 +0000
References: <20260915160307.3106955-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915160307.3106955-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 13:03:07 -0300 you wrote:
> is_filtered_packet() reads the event code from skb->data[0] without first
> checking that the skb is nonempty. When an opcode filter is configured,
> it also reads the command opcode at offsets 3 or 4 without checking that
> a Command Complete or Command Status event is long enough.
> 
> hci_send_to_sock() invokes the filter before hci_event_packet() validates
> the event header. A malformed event supplied by a controller or a vhci
> device can therefore cause an out-of-bounds read.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sock: validate event length before filtering
    https://git.kernel.org/bluetooth/bluetooth-next/c/b0a6cf99afd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


