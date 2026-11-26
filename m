Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685960;
	b=uv3AcMIpIk/hsgvruZ8x+V39qlaniMv22HdOA9OQmi/RrDGsaeXtC3rSCPYZkwZB9jNx
	 irRKh2NHPzXc1XTFbdT1b12hxG1PDmpyU8cnIbi/p4lgSb+XoFh7Sta9eb1GvHzQDXJ9Y
	 3N12CtfKvR9S+22JzIp6+ZIKd8QGllyhLI/QROo7GUEi1u6aG78sAGhwOvn2WiQQ35AdZ
	 JoUziGwpqoeUG7k55Z6skLkNQdmqXtD9CzcLeKoBeDBKkwrGuQ4KsP1yM1DOyXTi7TrdN
	 jEAAjkvz51ZSRokQT4oQPPjjTFH1PP+MeH8OvOmYVcXwoh7YKfd6oeeCV3VJsGkkZ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685960;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kz/JgbfHTGHT03E4Z95Rm3enHUNv9FOlOSaYbRPY6QU=;
	b=1liCEK8wa07Ip+kt1/hxqa1/aOSstCxLi3ERs0WdytAvGQ+EF8amhp1w39xSF2KM0g2T
	 Yzwf4BYr6QgNLGZ2ST8DGJV4AxqqzSDnZKFetdz9JCEzrX8bHI1DjoptNcCFqb4Q9C4Gg
	 DqLaUzcs8YDjUtkQyccPy2XVnW1jmw05mSj24PBcaqrbcbGNZlHW+xLU16bF0LNU8CM2q
	 oAbhNoRxqst0Kr+rWhwkoocgDQ0fY+oAGwI316pLuyKIoKMQxQHaIZ+qVt9q/U1/tLH48
	 W0Pxeb6aaEtlmALMRfYbxkQw5Gad1U8UHMhDePdDcWGqNvkV0etV7SbWxyfXepPAh6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C347606A31C;
	Thu, 26 Nov 2026 09:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C347606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 3839DC02DA;
	Thu, 26 Nov 2026 10:39:18 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	linux-wpan@vger.kernel.org,
	Petr Vaganov <petrvaganoff@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	phoebe.buckheister@itwm.fraunhofer.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net] mac802154: fix uninit-value in ieee802154_header_create()
Date: Thu, 26 Nov 2026 10:39:12 +0100
Message-ID: <179568594695.1960449.12773877877903526209.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120084537.31991-1-petrvaganoff@gmail.com>
References: <20261116065235.27348-1-petrvaganoff@gmail.com> <20261120084537.31991-1-petrvaganoff@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Petr Vaganov.

On Fri, 20 Nov 2026 15:45:37 +0700, Petr Vaganov wrote:
> During fuzz testing, the following issue was discovered:
> 
> BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
> BUG: KMSAN: uninit-value in ieee802154_hdr_push+0xa62/0xb20 net/ieee802154/header_ops.c:108
>  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
>  ieee802154_hdr_push+0xa62/0xb20 net/ieee802154/header_ops.c:108
>  ieee802154_header_create+0xa83/0xd20 net/mac802154/iface.c:396
>  wpan_dev_hard_header include/net/cfg802154.h:525 [inline]
>  dgram_sendmsg+0xc6d/0x15d0 net/ieee802154/socket.c:677
>  ieee802154_sock_sendmsg+0x8f/0xd0 net/ieee802154/socket.c:96
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x2f3/0x360 net/socket.c:726
>  ____sys_sendmsg+0x960/0xc30 net/socket.c:2581
>  ___sys_sendmsg+0x285/0x3e0 net/socket.c:2635
>  __sys_sendmmsg+0x33c/0x950 net/socket.c:2724
>  __do_sys_sendmmsg net/socket.c:2751 [inline]
>  __se_sys_sendmmsg net/socket.c:2748 [inline]
>  __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2748
>  x64_sys_call+0x12a8/0x3cf0 arch/x86/include/generated/asm/syscalls_64.h:308
>  do_syscall_x64 arch/x86/entry/common.c:47 [inline]
>  do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:78
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] mac802154: fix uninit-value in ieee802154_header_create()
      https://git.kernel.org/wpan/wpan/c/b2c0ed45f1ea

regards,
Stefan Schmidt
