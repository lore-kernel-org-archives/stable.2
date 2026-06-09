Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230483FDC14;
	Tue,  9 Jun 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004009; cv=none; b=lvUNzP7R6lacPsknyrWATVgq14jJZhTrD6pXR9HV6Id4NfCsCn0HDSRGZNpcBZKAJ0kin3/zklJU/yAgomXyUgHhlZjYygDELqbMKVvNCP0moEsbEc12YThjIt/jFsGg28f78FuQgQ5mMkpB07owyYaGojsJ6ocgE97E8qsknB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004009; c=relaxed/simple;
	bh=MBFAi68cJtixTUTtV59+COSQ13IaoHt2+pFDOEIsZ18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=njYtxYVD4YLp/CuSx41avndFrBWJMc3sej5ma4YI4w6NjAV0iCFt98N+CJFWCvnhoxTbzIEYz4rQAMPx4IRVJZe/x29Lsvjwmeh9vo5wtILrf7TjT3VQOi0airo18Zi/1WkvOTklAQndwrGSIYwtONP+TtsW/Lx79Ohv56pI0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYe936jy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYe936jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44AB1F00898;
	Tue,  9 Jun 2026 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781004007;
	bh=B+0wrW3LJMtKIonMBpQtLyzYJHDYU4NBKPOvxGEYvMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UYe936jyRJW2+aafPUtPauKXAaeI3cXoBE1GRAj2h103ItuHEZOBZuqbk6Ob8TE8l
	 O2Pcc0ZkQ6h9MBuA+xzTnYSf8qjuSkE8bTSXw/DCxmPEwwE1DOqEaZr8J2lJ753h84
	 iWePXc63msI4+r+P/x+CjNPSQBr5nOQemGUhRCC24emzDS9gKKgqFTqm9u+Gg56Q4g
	 uN2t09RPf/fi28CmJVADKP1xDGYrTae8C9tecdB0ZTBAdnuBHu9YWBRz5pKNWaD9Uq
	 dRGDnm4wwGJAKBkMj7XTEXAOMskcggjajwitr16ujo9iRlzTXS5zJjMJXQykHnsevG
	 C4kD5vIR10A2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691039308A0;
	Tue,  9 Jun 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] hv_netvsc: use kmap_local_page in
 netvsc_copy_to_send_buf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178100400590.1968131.4057700163237910047.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 11:20:05 +0000
References: <20260604165938.32033-1-leontyevantony@gmail.com>
In-Reply-To: <20260604165938.32033-1-leontyevantony@gmail.com>
To: Anton Leontev <leontyevantony@gmail.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Jun 2026 19:59:38 +0300 you wrote:
> netvsc_copy_to_send_buf() copies page buffer entries into the VMBus
> send buffer using phys_to_virt() on the entry PFN. Entries for the
> RNDIS header and the skb linear data come from kmalloc'd memory and
> are always in the kernel direct map, but entries for skb fragments
> reference page cache or user pages, which on 32-bit x86 with
> CONFIG_HIGHMEM=y can live above the LOWMEM boundary. For such a page
> phys_to_virt() returns an address outside the direct map and the
> subsequent memcpy() faults on the transmit softirq path, which is
> fatal.
> 
> [...]

Here is the summary with links:
  - [net,v3] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
    https://git.kernel.org/netdev/net/c/004e9ecfe6c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


