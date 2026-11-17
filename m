Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906785;
	b=LE6a7x70YDqSsTL0Q7WxjNmDjYVD+r3stkALKEJQX+Qa+YisHxS8dav7y75b84EClDvH
	 jgP4cjCBamVZPJJkAAJ/9/Hw3UwnD8fwTS7bBqang5LyDFe5pKu3rdDGrE3mFK4Lu/NKX
	 jHhamV7okl71fZEG9Pp4gG3CPCPZ7Sh3rfi4v4t1edUHao3IuVXLhOJ9pDqZSL14M62M5
	 FFHrSiG+MC3lUmJUouxi6SnJOWev/nrEB3uXVPycO8ZO7k9vqLDLf0VT0BQ00FkAs4gVd
	 naEUhBG1baLERrgSqAa80mULWgHr/p3QJx07gejb8nfpQWmxBpGVWDiQLWGG+rwdrHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906785;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=jHmFKQcEpErH6yTd+BcsBpSAeqJz4+fdKXvQPpS1SzY=;
	b=UGVJOFWRDro3tCMpms7mEfr3811YP1CCl/WVS6pbyumahnDQM4W7jnO+R4F5fu2e3X5Z
	 Kl+8CFxwQVHs5VBxMhthdAjQbvnT1FpHjziRIC8ZnBWpndI5T6F6j/8+gLa5VKIwCE6nQ
	 as1u29Jy7iu9s92RExOe8U4bKKhS6QwyfQRVVlJfjyJXZvbOqg6PR3TW1pKmrZnuZkn5H
	 /h3IAKp9WJPFRAe+eGrQkuR8casHERjVdZfSJGUSN02pZIowJaceUolnKQk9d86XQ7c4O
	 vD/gxNvXjseNo8CCgadYC7+8T/bYrp6GM4y0f8n1voKPeQshuY/ARBX5+sl9PLVCBRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QohGgGDT;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D9606A31C;
	Tue, 17 Nov 2026 09:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A61D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QohGgGDT
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E715A1A151F;
	Tue, 17 Nov 2026 09:13:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B28265FC81;
	Tue, 17 Nov 2026 09:13:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D7C611BC0493;
	Tue, 17 Nov 2026 10:12:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794906781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jHmFKQcEpErH6yTd+BcsBpSAeqJz4+fdKXvQPpS1SzY=;
	b=QohGgGDTtw8azbIR//VvfGrlr4V+zs72XDzrDyoJRb0V8W2WTIhMsS3Om45in7H2LQEW79
	y5ssLoKHMOcRF/+IV5057ZnzwjPoUzMav9cVjrADQiDTi/ngtIi9W0tDHEewPhs5aHjR6w
	e54Y8nkGdm8O0wjLBZUwxszXdEB+Ki+9uTLld22EhInWUrVgQGF8K5kfgDzvE/t+azc1oQ
	XEvKOOiOer6Uvhtd+3T59zk6YyyeWOZ7RbGJlmmIAix6Xe7iS2HWD+uXi4/dM9a3KjopYJ
	8gb8TbQdW9aL++PfMCZtctJXUqPtztwaNOaUWyr6BdJvb/ff8yfekox+qYfnLA==
Message-ID: <a0b1ea81-97bf-4a16-895f-5b6820a46c61@bootlin.com>
Date: Tue, 17 Nov 2026 10:12:54 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: re-enable on-chip parity checkers for
 XGMAC ASP 0x2
To: Zxyan Zhu <zxyan0222@gmail.com>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 horms@kernel.org, 0x1207@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261114015554.2187341-1-zxyan0222@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261114015554.2187341-1-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/14/26 02:55, Zxyan Zhu wrote:
> Commit 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC
> Core 3.20") made dwxgmac3_safety_feat_config() bail out early for
> asp == 0x2, assuming that configuration has no parity protection.
> 
> Per the DWC_xgmac databook, the ASP field of MAC_HW_Feature3 selects:
> 
>   0x1 (AS_EPPE):  all automotive safety features, with ECC and parity
>                   ports on the external application interface
>   0x2 (AS_NEPPE): all automotive safety features, without ECC or
>                   parity ports on the external application interface
>   0x3 (AS_PPE):   all automotive safety features, with parity ports
>                   on the external application interface
> 
> The reset value of the field is defined as:
> 
>   (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 1) ? "3"
>   : (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 0) ? "2"
>   : (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 2) ? "1" : "0"
> 
> so ASP 0x2 implies DWCXG_ASP_ALL = 1, where the internal FSM state
> parity and timeout (MAC_FSM_Control) and the on-chip data-path parity
> (MTL_DPP_CONTROL) features exist; only the ports on the external
> application interface are absent.  The early return therefore skips
> enabling safety checkers that are present in the hardware.
> 
> Drop 0x2 from the condition so the FSM and data-path parity checkers
> are enabled again.
> 
> Also update the safety feature descriptions printed by
> stmmac_dma_cap_show() to spell out that ASP 0x1/0x2/0x3 differ only
> in the ECC or parity ports on the external application interface; the
> previous wording, "All Safety Features without ECC or Parity",
> suggests the on-chip checkers are absent from an ASP 0x2 device.
> 
> Keep the early return for ASP 0x4 (EASP), which selects only ECC
> protection for external memory and has no on-chip parity features.
> 
> Tested on XGMAC 3.10 and 3.40 cores.
> 
> Fixes: 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC Core 3.20")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>

Seems correct to me, couldn't test it but this matches the datasheets
I have.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

