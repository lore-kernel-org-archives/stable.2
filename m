Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872702;
	b=JmObKpsz+/AcuD/i5443v126yiah5DhiaGml32/so6VSmtNtEwAdAMJQh5Y8aE/jVj7a
	 0UTtK+7419h13MGRUJc+C/4eRVCQPBLeKG+SwW92uXjULYvl04YAJqkdB8p09n/rCaiIO
	 7zOuJZf9HLBMgEk41f0M6CfRMgmgPQGgZNCESrY8iimOL4246ibclbcePwyIuyZVqit6S
	 h4kAbXPBa3n8Ya5Asaqd49jufUNSe8VucP61nMa89zPct7NfymU7TZrkWavdUp0sV2YJA
	 rnrYLCLx5zMTf8P94mrZnAChlXPNwKu5TI6q3XqSj50Aiadp4gzhl04Yvilui2On/VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872702;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dlz6P45Ihp7LuTcIRXeU9v8Jyqmw+VQKhtVDw1CaCzY=;
	b=l9ByrPLeqJo0fVt3W6Ulw3ta9URB1d3eXm/4oGLg4igwn7phrVJgikpCEdRj4S/SR27h
	 nN3uSfUZV7Y6vm/UQxFxFlq/1CIRP3qmvt0Gws+F09hsrJh6OZvHh4fvwbFjLL2zAQVCZ
	 00o3/J6vlOe4ncJXMpPNQmFoqzuqTG/LVYJOh9VwpYGMFnFjEhc++WFI/DAkgtIQIZIrY
	 9W1i61ARqkNFnTqLwylMgd1HGAyuU+nYRktWdOoUzJLTc/XvT/V4TOanbWLYB9ESuXd2G
	 y0n2ukGDRQUNG1QNkhiWOl9vQvG3SwWAZWDh2jllQVu9na/XPAg2lnoo9h5hBex7oeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2jbaaLc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD4606A32A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2jbaaLc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE92D1F031E0;
	Sat, 24 Oct 2026 20:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872702;
	bh=dlz6P45Ihp7LuTcIRXeU9v8Jyqmw+VQKhtVDw1CaCzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H2jbaaLcxIcBsUSTsvsbsHX5hciB+u/74M47XuJy4UKYtr6tPcGn47MP2bbeUBIR6
	 6q0GgfKj6USBYW5E6jiw1rsKDAzhBnIcDMVCfWE/2Ci+R536DuzuRuviyqVTZaIkhh
	 zSHnrmvbL7sqPeThDnvhobiAZ1dopR4skhnq3McwUNSyUuFbI+ZE8tmyQdnLDnyRyz
	 GoYKm/EO1doBH3lTxpubS9j2GR1gDIiJIcAQg9A1NU7Fzdq8bMC/bhwwec23GmMEte
	 kp99DR+HePxqtTc1soZyNI1rAaIhkF9G4GJJ3OpqlJeP1bDXfg7r+Rhja6ID4fZKMk
	 C5knv5tWwPcRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	David Carlier <devnexen@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 6.6.y] gtp: disable BH before calling udp_tunnel_xmit_skb()
Date: Sat, 24 Oct 2026 16:11:15 -0400
Message-ID: <2026-10-24-1-daily-reply-0018-gtp-disable-bh-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024094949.793-1-ue081723@gmail.com>
References: <20261024094949.793-1-ue081723@gmail.com>
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

> gtp_genl_send_echo_req() runs as a generic netlink doit handler in
> process context with BH not disabled.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
