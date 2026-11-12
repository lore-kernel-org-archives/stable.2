Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486606;
	b=JoLx9/IslufYQ64IxKwfPQ71feJMoQ4vKGicG3heo4l+RMzwsT/V7WB/jHIUTABOqNgw
	 J7LNfHxgoPZJeajZQPCk47wfaK9kh5PEsoQZcRvek3vqeQ6TYcHX68CXth8LcSoA1BWwY
	 iN8HuF3FlS7Vk/S2M2umXCGiLHRiN2diz5px89g12xPSc+Tcs5pm/tOtHlcF+n6OnTCM9
	 xr5+6JARWXYBE0VgylWeUEk0EtfJVCp2hVMor/HfOP1b8Hrdh31lAEBrkLNDPQrp9D1TR
	 UZ/FlIpmcshgRAVTGP8zlxqCa5PwEX0J6g4IwTKlp25LFWC9PIvqI0Wmo0JjaE4UmJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=k3st0dGZek/XsHRomjt4q4del7I8E56wk47WUe3AOKo=;
	b=3yPTD7RfVPy1zWjQdX0uyHGYvQkCcmkETX+islS6E4ei8OQu3mQJ0S3MzdPjfaY/Grr3
	 kh++Ycu4B5bshhZCV9/ERvhdOdbfFWvL26Q0fLZLykfLP+1JOZ/mnXEvOc+JOaCePXQyx
	 HWkNPPvscTloA40U8zAq84NU3wstXMNUBH0se9yR98aCBnxnUYeaKEVbd4AdljRVdiftV
	 7uTfbeiTPLEgFM2EWDaQ85VfiotzqhjvhWCcOONKGCZKVK6EvPqrJgbNR++6llyeRvuC9
	 BMvOIt3UkHTd8C8oSTPRwg6BIt+WhLZxDPbv1U0kMTPiPV84nqBlYqXnnatAOuWB+jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKqsebRM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1D606A32D;
	Thu, 12 Nov 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKqsebRM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AB61F00A05;
	Thu, 12 Nov 2026 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486605;
	bh=k3st0dGZek/XsHRomjt4q4del7I8E56wk47WUe3AOKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aKqsebRMd0yXwvS6TBcPNOyVOGCcbX55hrQpg8olSzANZtrmkOxtnCtE/rE4erh3A
	 Vg2f7r4G2ghiH+VLI+tnQOwCVUbrYuX+17iEIDG7OL/6AYBZPIKrmhUDIT23aystjX
	 JgAY7UP0k6yBvbBBvam2JciKuFF7xV84BZfvy/c6nHRPcZgHJNVbmoPYHG99shnwPj
	 A+/6uIVKlQX8FaK1Y5wPuSth8gaFs+H1+ae4GB/9PcWdTGwmGnwyLDQwUolS8grEo5
	 IpkWc0+D/hllfv9uHVnc/aBS51gWXXImTTD/SAyFiBOIAa6O/u2MFaBofxkaNGAnJh
	 /27VhnoiSCHUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9943D3AA9F74;
	Thu, 12 Nov 2026 12:30:05 +0000 (UTC)
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
Subject: Re: [PATCH net v3] net: dst_metadata: fix memcmp overread in
 skb_metadata_dst_cmp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179448660448.2065860.8508505178205062232.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 12:30:04 +0000
References: <20261109082410.206140-1-jpsergent@gmail.com>
In-Reply-To: <20261109082410.206140-1-jpsergent@gmail.com>
To: Jean-Paul Sergent <jpsergent@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, i.maximets@ovn.org,
 sashal@kernel.org, kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sridhar.samudrala@intel.com,
 kees@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  9 Nov 2026 00:24:10 -0800 you wrote:
> Commit 3fcece12bc1b6 ("net: store port/representator id in
> metadata_dst") dropped the options_len equality check when converting
> skb_metadata_dst_cmp() to a type switch, so the memcmp length is taken
> from skb a alone.  When skb b carries fewer options than a, the
> comparison reads past b's allocation.
> 
> Hit in practice with Cilium geneve GRO aggregation, comparing an skb
> carrying 12 bytes of tunnel options against one carrying none:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dst_metadata: fix memcmp overread in skb_metadata_dst_cmp
    https://git.kernel.org/netdev/net/c/74a7db839308

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


