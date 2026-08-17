Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F9260580;
	Mon, 17 Aug 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998655; cv=none; b=uPjUj5ChSDnM/shuB+pk5vCXH2ExxwDpDjaFUnz7thNZ3GULFyBB0/8rN0sY+CnuNT+B06xYSPlv46wYkJN5qMxEEx96f9QijoK/upc9S+It84CZUDJRqtqdQB2WiETPhYgNkZ0hAbab4p8XQFvLVWJTIZxPlsBS4WkEobN2FKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998655; c=relaxed/simple;
	bh=vT6ixPHciAFipXHjhWgXw+Nyk3MM+1lxF2dlxTag8Tk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IsC/sYn2yUy0TLkzyj8fY1282JX/eQ3ks70Q39HdUkz59ER6lyBjVIEpVVBFNCz4Dx8aTP8D59Xw6okpAPNihhsMaLpIJRXurDEz16mZpBlytb3rxdq4ECFyJaWcMJVac0C8oMOgg0xNe4GFd5htXOKIGLusCCF0xslDAXZLj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxkH1Mfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxkH1Mfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024321F000E9;
	Mon, 17 Aug 2026 20:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998654;
	bh=kVkY22kjDXiW4Qy7bg+V/tA9Qkmm2pRX7cE5XyGeqDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AxkH1MfyTZkTRSFMIvANn5E0B+gPpuZtFJ3ruZim6AwINZeFD5psf39curWSGjNJ0
	 8twaWFOZDMWVMJ1Ot0TnHaoqan1KHP8/HJpUETwQr7uL9On19CVLp2bS2qkINvUFKv
	 /FtnG1FhvR4y2yDWFEQv32MCGIVKemrz9X8hlK3C0ujQpQctAlj/wbXDlvuYo+pSTz
	 je+kUUtqOrIHiBcZGDOuAg9yqWhd4EDwZM3KVaFUIwnLeYKFSx5czbaVuIjfzQ1y24
	 7m67GF9WMNdmy5ifP06XyFkk2RBLKfZihPJ5I1MD1u6pO1V9llbraD/HuLr78CJPm8
	 GxbDnGBrVy30g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5684C3926263;
	Mon, 17 Aug 2026 20:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] vxlan: keep the last remote linked during FDB
 flush
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699860589.1725388.8513845366242579369.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:30:05 +0000
References: <20260810144115.821654-1-david.lee@trailofbits.com>
In-Reply-To: <20260810144115.821654-1-david.lee@trailofbits.com>
To: David Lee <david.lee@trailofbits.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kylebot@openai.com,
 dominik.czarnota@trailofbits.com, sven@narfation.org, petrm@nvidia.com,
 amcohen@nvidia.com, idosch@nvidia.com, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Aug 2026 14:41:14 +0000 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> A non-nexthop FDB entry is expected to have at least one remote while it
> remains reachable through the FDB hash table. A filtered bulk flush
> violates this invariant when every remote matches: It unlinks the last
> remote in vxlan_fdb_dst_destroy() and only afterwards tells vxlan_flush()
> to destroy the parent FDB entry.
> 
> [...]

Here is the summary with links:
  - [net,v3] vxlan: keep the last remote linked during FDB flush
    https://git.kernel.org/netdev/net/c/d5d4a7b538b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


