Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573806;
	b=Ixme9X7A1KQSmh9bouxlpaUp5tNBVH+Wpn4gQ6Z1d0jCnogvGZN+aqOyonnfotvaxD2E
	 riStXxCOPzrbhonJGUn1W7t/3MLtq7yt4j8p98Qk365eDTRmYgyL/G2otNTo6jKY2S3l2
	 vMYatdZb8CovXNiaVG/RipRCGDi9pWzy2dwmJwGEuk0SZp0EmSMF635alBQNKPS7B6kqL
	 8MD/Sy9FGxpq0VrS1Yoq6TyyPH6snx+0/XaSJNAQslF/X54qlmnrLA8LhGsOD7AN6Amjq
	 nMUr5j/MAoc2U0/JQOFMFusOvjL39Yn4cFwgtyR8lUyc+ehgu9KMrJ8BTVXwNyvwi3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0QZ08iDHs+Ow3Sx9tiq8e702CzR1vrTFyVV35fbK6nA=;
	b=uaFyYbFlGKRtvzCq371CEz+DB3dsxaRr1ArK3Vi/vzkG5UngXQLsD20WsAdSa7MyEZV0
	 2hvyv6qiBu2u7syJCqKNpFHD5D9Gjz9OZAR5KZXbBo9yb42CCeayfShjJDUA00eEKHoyc
	 8TwWyHkT36nCwFLFKZN6LM6H0k26yR7jXnf+o+6BLxV0kKnZs6VrM/r3J/PpPu9rIi7SX
	 kJUHc5UWT7X1xpQl7nQ+7e4nqnL/XbGtPR2iW2bOlpBtJ7yI2Q6Fon3qsR+EqJRH059fi
	 x9WRUmXzvz0k7lUSm68sEoSAaAZsLGSj+jzuWC6ep/4UvKN8mnXeGOyq8qqaJn+iK3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9kq+WbG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37213606A327;
	Wed, 25 Nov 2026 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9kq+WbG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B901F000C0;
	Wed, 25 Nov 2026 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573805;
	bh=0QZ08iDHs+Ow3Sx9tiq8e702CzR1vrTFyVV35fbK6nA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T9kq+WbGqN8buxFv1TOlL1Cx7UTgDEq5Uzd1vhUkRZ7Fb9zyBGb4o9xD49momEBM6
	 zTM7HtN1n+hKzb5H+MPJHKxWJ3pulvLM/e9z8IFLWZf4Kb+m1F4JuQcN/4Iyy7ylHk
	 eisidnLuqJB70ncmMAqa72y7Q0b6iwME48LgyEtaL6JTl8uFiC2u70t1Iuj5ZrilyA
	 lew3k+Cgt5pUHLS+ES8z+tzjwCXpX9u7ZQANaRnNeDPlquip51e9tenFr8Pvk/CuqS
	 bJOeI1o4kElOFDgrykIKVJ5ftDKXHVw0gATF6pnZ2beAFzX+s6ue7yELNvB/qgaHHk
	 Q27+yI6a9Mq+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774593808209;
	Wed, 25 Nov 2026 02:30:05 +0000 (UTC)
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
Subject: Re: [PATCH net v4] xsk: set network header on skb at generic transmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179557380428.173698.986256979639257221.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 02:30:04 +0000
References: <20261120073917.63158-1-kerneljasonxing@gmail.com>
In-Reply-To: <20261120073917.63158-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, alobakin@pm.me, netdev@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org, jamessawyer@outlook.com,
 syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Willem de Bruijn <willemb@google.com>:

On Fri, 20 Nov 2026 15:39:17 +0800 you wrote:
> When constructing an skb in the XSK generic transmit path, neither
> xsk_build_skb() nor xsk_build_skb_zerocopy() calls
> skb_reset_network_header(). After __finalize_skb_around(), the
> network_header offset defaults to 0 (pointing to skb->head). The
> subsequent skb_reserve(skb, hr) moves skb->data forward by hr bytes,
> but leaves network_header still at 0. This makes skb_network_offset()
> return a negative value (-hr).
> 
> [...]

Here is the summary with links:
  - [net,v4] xsk: set network header on skb at generic transmit
    https://git.kernel.org/netdev/net/c/ef7bf0628915

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


