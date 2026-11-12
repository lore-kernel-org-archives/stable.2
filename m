Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503406;
	b=36nlP6ul2OPS1EzNfOTU5PLnN4RSJQAtJtNv6hfSeB4YrQ27ANQW0Gfxnw+b5gnZ2ztZ
	 XslufEwazwQpTQJd+Gw7k2ugCJ9cqXHMO3pMAXpdJL87Qy1zLqgr0iY1GYZ7d/LYKenEX
	 cFDVEJEj8Nw3SYoIxQ2wYnsxrD6sKNxQZxBlW8Mpn6cxTdVIPL4rQCENCg6MghCsm/PF+
	 ds3gxq7GUnNVTowm0XawUeQqQgb3pf78fENwrdshSRx0L/L+Z643owlN/xouf5nRRf4Vu
	 /EWVwAmRPPQVlRP8wx9BdNa/7Vo4r4Y2O6i5r/Ldq0uBRW3PSsBpfV7MJXkUQeQlMQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FIi12w0+HFjXOzn/TLNFjbglt3b3jQxLclVRnK0NPso=;
	b=JAqRWSOJx8YaXkf1E5aCC+kVjGX6z44PZX3rIXHhOm+cQCO8KghK8l0pTAYD87o+nGxO
	 40W4V4OdNRcXdNnKMYXeCA6rh0zcaETXKmIwNeIqzqSy4Rx0mIq+G6K9LzrAJnLrbWnk/
	 xoUN3Eiw5b3K9JK0TPXhMUiYfgQphq7KO5us9AiRth8SNUz+ffRujMbeKoBzxpcKWcmmy
	 DvLihX1r1wDSUZxW9wRfjbdajsqE+nKkf8IbQzNTRy/jnMVO0R9Edy83T9JjVyrMN78Ep
	 9ld8bjqZ+BYLBmFYSQW7CKQS+ninTZbVv/QBu/h9MlYg1hthuPQdltXZ4oS/Le+Unsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzNTFpLe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB93606A334;
	Thu, 12 Nov 2026 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzNTFpLe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069471F000C4;
	Thu, 12 Nov 2026 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503406;
	bh=FIi12w0+HFjXOzn/TLNFjbglt3b3jQxLclVRnK0NPso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mzNTFpLekqJ0MKB5gxkXYXJlwituz5djf/EFLwFJonsAjiumisu2c3RFV7Q8yHeuj
	 OQUDADAADojW1wFnbNrN0P8rN0V2izHcSjN7ZUY23g9YdObiPPWHC0NrA+tWbjxIHi
	 f0VnNBzbRoEeierL8Rfh2N0TiAz7NsdAX5qeo5GMg8lpxgIbuPPU2KIzPeuw4CUG8i
	 LzotlBgsbAWt/sefZaNTHmfxPy7eM2VWVYaAAHRTe0IuDU+bXiB7LxVcak3+VVzg8S
	 2supB9r1azosX3v7CWJFHRw/9Ek4h7AmjzuXE63RfbR6TvVmVhFkfom9TtP90Pe4Nz
	 xn161ianiwLOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1537380AA75;
	Thu, 12 Nov 2026 17:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mana: report RX checksum offload for IPv6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450340453.540799.10106995147021439469.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:10:04 +0000
References: <20261109142856.779955-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20261109142856.779955-1-hamzamahfooz@linux.microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: netdev@vger.kernel.org, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 09:28:56 -0500 you wrote:
> The hardware validates TCP and UDP checksums for both IPv4 and IPv6 and
> reports the result in rx_tcp_csum_succeed and rx_udp_csum_succeed.
> However, mana_rx_skb() also requires rx_iphdr_csum_succeed before it
> sets CHECKSUM_UNNECESSARY. That bit is only set for IPv4 (since IPv6
> has no header checksum), so IPv6 TCP and UDP traffic is always
> checksummed again in software.
> 
> [...]

Here is the summary with links:
  - [net] net: mana: report RX checksum offload for IPv6
    https://git.kernel.org/netdev/net/c/bbcd02741c4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


