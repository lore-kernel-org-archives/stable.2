Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A3361959;
	Thu, 10 Sep 2026 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069878; cv=none; b=lj+I6YfCeRSjBFsbeGjmdbMKYoo9X3OiapThD/iLD/oKD9qSxYKvaZUmV4Y9qWRURwSyxSlcPi6ULgtoKfoVnJ1JSg/TvJauATSv88ou5QmOKKFaM+ASOuvNgoYwhKIQPv1vH77uEtMJ9TGEyYKlgLPYtpZ9lU41neVyTG1OMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069878; c=relaxed/simple;
	bh=+TLJJaEmCJ/1/Msf3ENzwQ9wO+N77vy1E6kFychptwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Svm283OiCJkQUcgY+05+WJPvR+hxDITYYCrQsB+jT5IB6LcClMbkv24bg4DxUg7K3KnPVEMJNMkkK7HLZ8829RdilnLeI87bqHUQwnW1a4+xvReYMCXnh+DtPnICanCxC5zqAQIdfCbqzQ+aGPE1VHAhpY1Q2N+4YcUoyk4cg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU/bCqCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU/bCqCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C0F1F000FF;
	Thu, 10 Sep 2026 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789069868;
	bh=jAQZGFrAtIqvNeMZFEctdK1yW1GhoxGQp3cTSBDzVXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YU/bCqCMJCqfX9ldgeeL8lrK8XbDs1q7U00KArI4Vqp8H6aTIbImQPZklBR9x8eec
	 PorU8A7EV5PsNBXgfKM46EgiE8zeH8E3X94ox/PaXmD2EtY+70KD/7TwbwZDVANrvv
	 a+PPC5/7V3MFTXaMjYIaRps4tMOegvJh+G6nqZyObax7sH0CbfPB2v8LXK3L6j0p9p
	 XdQO3SonyAhqERrIx6smSNG0TQeJq+ty4OvwpHEIhyY85WN2dXVnMIBCH5sZNm6FnW
	 EsRzbzeZg8nMMgVpG8kgfvuC064yuqng7ptqMQEkoOEG2jGN4wAr9DznZKxYhDq3n8
	 vfVg9/ASKVlAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD7380CEC6;
	Thu, 10 Sep 2026 19:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_codec: validate vendor codec count
 length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906980564.2055460.13921415718571070478.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 19:50:05 +0000
References: <20260824155736.54542-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260824155736.54542-1-acharyalaxman8848@gmail.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Aug 2026 21:42:36 +0545 you wrote:
> The Read Local Supported Codecs parsers consume the variable-sized
> standard codec array before parsing the vendor codec count.  Although the
> initial reply-size check includes a vendor count byte in the fixed layout,
> it does not guarantee that the byte remains after the standard codec array.
> 
> If a controller reply ends immediately after that array, calculating the
> vendor codec array size reads vnd_codecs->num beyond the skb data.  Use
> skb_pull_data() to validate and consume each codec header before using its
> count in both command variants.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_codec: validate vendor codec count length
    https://git.kernel.org/bluetooth/bluetooth-next/c/803d146cd56b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


