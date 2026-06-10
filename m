Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC044D011;
	Wed, 10 Jun 2026 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104818; cv=none; b=VWZ5NJUqdfXU4SNxgX92WTC0okqQASwpvJh1AXnJw9AGAoaFpgv/6vUV3jVczt5KNFyD4Q6spWvM7WwqDb6DgYKGFBMcfWGEuzSWB+nTBzVqRYSxaMn5DcRt4buK6YpZK47/fvcj9DG9nSKaYuzBOzYmecClRzdjaoC29BAb8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104818; c=relaxed/simple;
	bh=X/T0jM7Q9ZMKdQgbeggkK0HroYo//gTvnOjebobtQ4A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e5z5jYdwLzR++2Jev14Gf8BeGl9WXQUu4KHrIh4TxoEkccP4WoCdbZ8Xt0bjYQUPHq0PIO783mm6Blc0xmfSnP2BG4o2B7ox/SjykevtvoVj+fE8fZ2Ln8GwqyHdzK6SaIPKuwcwjNlOAmDAhAB/PHpVHU9ZPpEwWKkIRnUbOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/yc6mrz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/yc6mrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071481F00893;
	Wed, 10 Jun 2026 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104817;
	bh=gNRQLhOVdGA2ab/3AC1JW202PoMX7RmJP2/Qt1Lgh8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U/yc6mrzg1CuHR/o69EMW9P7ENIgWEQdIPvoqh8Hhw9YC4UGhXFMEkaq+NW2s8vDs
	 +dOxSHfD0B7orTmW0fAXp7N22fYCTVV5yWt5O2MxLjPPqomtlWEYXdWQK3kyqewHms
	 GWVopBwMQRV+VWXovhVWmw47PQXi3KB1xacUUZhh5knXQgMlPqdyxOJ8f4iX8/2ePr
	 o3H2ItDychu3UFrSa6dT/FKJWV6J7v9DfGq4ExJIGtyDPMIDatB1Rxe9KndZtvizmY
	 lk8C4e3MfrJmzP4vBSlTlyY8iQmECMn790/Dv9fgMAGTkEq7YieLaEUjfIqFpSfLAc
	 BQYSrkcN8cqhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1971E3930D5F;
	Wed, 10 Jun 2026 15:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] fddi: validate skb length before parsing headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110481488.3089075.3852844559802039006.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:20:14 +0000
References: <20260607112408.92988-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260607112408.92988-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 yangyx22@mails.tsinghua.edu.cn, wangao@seu.edu.cn, fengxw06@126.com,
 qli01@tsinghua.edu.cn, xuke@tsinghua.edu.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Jun 2026 19:24:04 +0800 you wrote:
> fddi_type_trans() reads FDDI header fields from skb->data without first
> checking that the received frame is long enough for those fields.
> 
> The destination address spans offsets 1-6 and the LLC dsap field is at
> offset 13.  For SNAP frames, fddi->hdr.llc_snap.ethertype is at offsets
> 19-20.  A truncated 15-byte frame with dsap != 0xe0 therefore enters the
> SNAP branch and reads the ethertype past the end of the frame.
> 
> [...]

Here is the summary with links:
  - [net] fddi: validate skb length before parsing headers
    https://git.kernel.org/netdev/net-next/c/04fc949bd3aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


