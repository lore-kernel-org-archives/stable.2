Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996203DEFE2;
	Wed, 16 Sep 2026 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581688; cv=none; b=H7pAkhhHbCS8eeGkQfEMuGbF6glJ0zY+oA7t+bhJ/3q26SAfs/xoaSNMgAUZ/iyVDzFQUCRn7MUQhg+IYP6sT72aGOZXEZ4Ld47A2EI4bPJi+vW+zuRgaXqc8P4T17ys4fXP1pZjtsRJalr2Olx0tEvm45Hdm82URiXLV03yYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581688; c=relaxed/simple;
	bh=xq+NrP/NZsNKKKc8qfp/OJcpLSCXxPeQ6EL6V+OKRMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jb8NbSIjoYz6izO5a0Y/SEzpml4+bmfg1nwGLECUGu4HpAyCBoFiblMXVI1+7orj6H4Xf1Xg8fEbJUzDIr67crib+c2AJlXqEPJow1icY6qyhmUZSkj/ZiTd6VUTfmQvjp6STBmP7zTEzHza0M0hi4xtI3lNYSCl95CRjBxae/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak4mvxp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak4mvxp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8551F0089C;
	Wed, 16 Sep 2026 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581681;
	bh=lwvkcrQgm42L6xbnD5EVCsfzQO25TuFmRY5psDGdPCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ak4mvxp5WWBANWNIuNCEoKDdw2UVJXBK/xdf0Y1DPeJFP0tGW+P8BoYuh3AafJ6qZ
	 cfnw/4nbfZZ2JiTdQIrMmBH9U4YXEaz6d5AR57NE++Fz5ACxpesdDsd5cYpzIVPyjt
	 DACBkHBHZadlWl91HYUn3WE4EYAEWcShWm1NFrX6Bx+YYWocW86FZnsXQeSjZe4s3S
	 XWkYDIdYXZBI4ejsOQFw/302zkDb1DJTmEu+sEk6hzVRwLhdFzGl51c/ImNyqacrH3
	 Lq5uQWc2Sb+0WQSzKtpONiL8FOdu4kvr+Tu++P2sF9qBNoblHP5ekuesTtPb6czdGr
	 R+OGl1nrKsYKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567EF39E8A50;
	Wed, 16 Sep 2026 18:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sock: reject out-of-range OCF values
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958161487.2777538.9063119432058649087.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:00:14 +0000
References: <20260915160359.3107468-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915160359.3107468-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 13:03:58 -0300 you wrote:
> The raw HCI socket security filter has 128 OCF bits per supported OGF,
> but masks the 10-bit OCF with 127 before looking up the command. An
> unprivileged socket can therefore submit a reserved OCF that aliases an
> allowlisted command modulo 128.
> 
> A conforming controller should reject reserved opcodes. Nevertheless,
> the security decision must apply to the opcode that will actually be
> sent, especially since controller-specific behavior is outside the host
> stack's control.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sock: reject out-of-range OCF values
    https://git.kernel.org/bluetooth/bluetooth-next/c/e93fad891c72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


