Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288712F6918;
	Thu, 17 Sep 2026 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605672; cv=none; b=Sa8B2u/50AqHI1nHafeHt6hLPMjNIeft7qO5pbIgbmAYd48WoTjKFd+YjKKRJlaHOVVgs0+rB02jZ7cisSpOrYnxvLjo+LzQts4XhjgR+hhfzGMs2nRNdmbr2V1FNHtIdrWzRA9dUi2tqLIGPZl5oPRGaUv3fNeeVIgQQZfHGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605672; c=relaxed/simple;
	bh=W9YB818l411adOkmziOAlaBiVAzIbfmylnxCTNfrfGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WRZaHnWVRhNtKD8TgePhYtLo/PPTg+vnFac723a3wkJ3VzM3Aznl3rHGSb+AX9Zo8oeSYAl3XFf6J+lgSykDyq2MrmvWwBRy81r3cgbjYbIkOJmUb35iFNYpdrfpRH9LwvV4aGSJb58CM22V84Nc8ljp9Zsdwy+QU4q5I9yPS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z66XF+QD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z66XF+QD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEED1F000FF;
	Thu, 17 Sep 2026 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605671;
	bh=ISyx8xREtcGkNpZB5bo3T6XPq7SAooVkMufZOS4MZFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z66XF+QDIR4O4LaJmsr7geQ7LBX47xi1ChgTnhybttOoAsCdr0q3ilxld8+giLMhx
	 jJFgj1eDrjn9IrX1+WETlhRoYPUCcbOpu5SeqOeDiWZPUGdVbGwZnHYecIqDfV1sGy
	 jd5sAkmnTnXGzuHuM9RlQNkZ0/LwA/QgPBt5BWi/IXPxVO/pjlkQfg3msdOZmZzvRa
	 bTn1TQT0N1qpOj5OgHePAKGjiB6JsfA90mgS4Vl9t/HFGPxBc+ws3U3gQsG6kc9KeN
	 XNVstEKB9nMVfyphFn6R2LQ1uKNN8v+t6snqLad1Z6WB1pNBDijYQUeX5ZiVrzYMwD
	 R+XtzX2Nq4b+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987439E9601;
	Thu, 17 Sep 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lan743x: fix RX checksum use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960560463.3354472.12591893896649452394.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:40:04 +0000
References: <20260913-b4-send-lan743x-uaf-v1-1-73d563d08ba9@gmail.com>
In-Reply-To: <20260913-b4-send-lan743x-uaf-v1-1-73d563d08ba9@gmail.com>
To: Mark Amirkan <markdamirkan@gmail.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Raju.Lakkaraju@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 17:14:09 -0700 you wrote:
> From: Mark Amirkan <markdamirkan@gmail.com>
> 
> lan743x_rx_process_buffer() adds each non-first receive buffer to the
> head skb's frag_list.  On the last descriptor, lan743x_rx_trim_skb()
> linearizes the head and frees the fragment skb metadata.
> 
> The checksum-success path then writes ip_summed through the local skb
> pointer, which still points to the final fragment.  This causes a
> use-after-free write when a packet spans more than one receive buffer.
> 
> [...]

Here is the summary with links:
  - [net] net: lan743x: fix RX checksum use-after-free
    https://git.kernel.org/netdev/net/c/a9ce4053dc94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


