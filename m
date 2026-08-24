Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7546E002;
	Mon, 24 Aug 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590268; cv=none; b=jEwmxZB0lb+oFHMVoGT8xWWHuNTWr/X4tLU/6TvZVEJF+zY4DBUNs5gC/rRJHiIX5Tm5WXdGIQ+TgFWjhiIi3ZjAngtySYLg2/MoUYllUKID77UZiJeBKwJt4ZinxarVvxjKCYzvmLGVBXKtUBAbuY8Qk8ZSRZYirNdaPCa/zEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590268; c=relaxed/simple;
	bh=BE0jL4ik1HAZPbcNkv3o+tJrXgHy7UNKNVOByIRoncA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CjfnCpV01akCPZKA4FwvPqDLBGJcZh7PlZg6hPTn5mfCLt1l0NaS/hM6wuUbYZ2gPr4u+1K8ewu3W2IZ8fTlFmV4GZctC30eDlgrEXWXsLW8H6hGUr3dQxNfrKVfdG4rxR0KWe+6Rd3R8JNy4eu6Gfl2zAbVfsx1A4HsIl0WXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa7B2Xot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa7B2Xot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB321F00A3D;
	Mon, 24 Aug 2026 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590264;
	bh=o9DM9p8kHTRfmwXvkHwgp8dNOQD92bDHRYyRFwOKfpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fa7B2XotEUKPpxqqJOOKwqrb0uXC1gxaPGcpL+hIn36hZe+r0RKOdX7eujUpO06KK
	 maupBDLE20DJB88PRLiaeKJZwVh619CIlOlkkuRfQ+//2kSt+pJ06jIf2y0MoO4BS1
	 nz+wRgyDamXpOUe3/AiR/cQ9Mj8LdNOvpDThRhJbxEt4KW2Bfm3C1eJ6ulro8o4oPO
	 kZ+jxtK6BLnVHVZnobzg+rMD0t80y6+XILVAsNIBG8OLsl9RWWOrFEF8PInnt+WRtm
	 Efq+YTxKeB0kCTSfxrvWRsqAvDQXqYkhdLfQ0gaq2U1RAANz0lbrrTL0jzeD5LH+i6
	 DJ89AVI8k6T4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D33953924478;
	Mon, 24 Aug 2026 16:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize security confirmation
 handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178759021163.3014491.6954824460297136867.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 16:50:11 +0000
References: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kees@kernel.org,
 kuba@kernel.org, ali@iusegentoo.com, tim.bird@sony.com, suunj1331@gmail.com,
 gustavo.padovan@collabora.co.uk, Dean_Jenkins@mentor.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 23 Aug 2026 00:43:41 +0800 you wrote:
> rfcomm_security_cfm() looks up a session on session_list and then walks
> its DLC list without holding rfcomm_mutex. Since RFCOMM session teardown
> uses rfcomm_mutex, krfcommd can close and free the same session and DLCs
> concurrently:
> 
>   hci_rx_work                    krfcommd
> 
> [...]

Here is the summary with links:
  - Bluetooth: RFCOMM: serialize security confirmation handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/40c621391de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


