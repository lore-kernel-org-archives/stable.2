Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10352F549F;
	Thu, 11 Jun 2026 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216413; cv=none; b=cctZ/+7Y/GDSM8UavzHExpSi9ma23ijrHUWWmlLLtsUN+Nqx2wdVZBMX2xZYGrCBCWR77V7ghaHEbuidsJ8T6MQ4vj6fTAxsj/h0nioA67VmHlUtmf/U+C/XqQH0TKvSaxdgzXKowipkUUbLb1JCR44jxUMsPF4SHWfcoalSFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216413; c=relaxed/simple;
	bh=wjYLPNMgwXIe942a/D6Rh7N+qvKWaLydMg/rZsocfsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EKbsD/VvRXUaYOsJ8vUqrVpgHwAeDIq3Sm64nVXYjqWCtXoCh3mDjD4j4t6mNhFZ3xHwPWYl7EHcaHpi5yCfcjf5fJyivzTDSb36TC/volGki+DaLZIalTAK1IZVjuDL9WQZ3XZscSxZE8cEYKX6JAMuZDrdi+7boZdi//j/Kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsWiQCa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsWiQCa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B3A1F000E9;
	Thu, 11 Jun 2026 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781216412;
	bh=bwKO20aIj6Z1fgQW2J2GQV0+X9nndAyXDu+Xqu+HI4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MsWiQCa0Br76RkRigHK0t8ZR/79wXVymmTTo8lOAo+NHanGloK9uS09gxePMb5gZP
	 20FqsgpZ5hVybuGCJpzZVo994QcqmOdYtBoqM9ULrbyaN5oEvf6ZPy/XEqWPZb3Mqa
	 qOMUofP6E0DoQw/s6kRiM5v0rJFEj9IEqZogFGfABIp9Ji4Bc/c31gBdc8qSwF0JTH
	 Dc/z19bw0Tw5ekP+Uc0femzoxXh3MF1q9X52ZXhNrnynEW/MVHjjXbwfPz/64AMaUN
	 qrjCB4crw09UqbiXi3N2fn+6iR+/pSD9gMCG6hZakXXs1VcxbAoEP7H5oJgruy746g
	 AbaxOn5wHBezw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09653930FAD;
	Thu, 11 Jun 2026 22:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bnx2x: fix resource leaks in bnx2x_init_one() error
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121640938.386394.3435821664297211443.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:20:09 +0000
References: <20260609074610.1968721-1-lihaoxiang@isrc.iscas.ac.cn>
In-Reply-To: <20260609074610.1968721-1-lihaoxiang@isrc.iscas.ac.cn>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ariele@broadcom.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 15:46:10 +0800 you wrote:
> bnx2x_init_one() falls through to the common memory cleanup path for
> several failures after probe has already acquired additional resources.
> 
> If register_netdev() fails after bnx2x_set_int_mode(), MSI/MSI-X remains
> enabled. If later failures happen after bnx2x_iov_init_one(), PF SR-IOV
> state can be left allocated. Also, failures after bnx2x_vfpf_acquire()
> must release the PF resources before freeing the VF-PF mailbox allocated
> by bnx2x_vf_pci_alloc().
> 
> [...]

Here is the summary with links:
  - [v2] bnx2x: fix resource leaks in bnx2x_init_one() error paths
    https://git.kernel.org/netdev/net-next/c/034b95cf69e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


