Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387600;
	b=mkCWEz5P65NrlunfoPnvoWSCus5XFttqzn2fNcQcabUE46DJqiEVBzyiR7Kx7KrBhIBi
	 h4luSt87lAv0v2aAB7Q+SNAUG73EskpgV048sr9vQ6LoXPUuwc3TxIRbVXBoNgmwDSBgO
	 Xckqbrp5s+PQmQFjKdCW0YV3NKuIRbdbUAa05CJnyuomtw3Ga4oSQOyDzd3MoUJ3PtxMo
	 nXyZX0CNulRiPCNgCZm2W3a9wme6qIE45OPBk9bQOIPmqGu3AR7Dy+k2FjHRCXZILgKY0
	 ulOtNNuhI2aGB9cykh0kSZqAZnLoi/sMakys9BYvDREmDYNQ40peMm3kK+5/itF1v9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387600;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=50p3zI+Ws44mGPjo5k7TaGpGNQJ8ZUfr5PuOkAq9Jzw=;
	b=LuGnaRTZhTpPm4Pmh6TAWBRJMeYZ6zdbHWJCblfLX3dA32sAnnCATKbazQQsLTmR0xmW
	 4Ux8wk+8nnzpQ1vJXHG1vfiE4PKDsqi9kpc4P6Nb95lfsqotsk2aSzHaZB1ShCjSLEADc
	 XM9Z9+0HEqLH8GYp6Ne3GOlaVwGmUvYodvA+fvoC4Dti5jXhDnoLwXhAH1e1Etiocr0BF
	 jFF9gQoUIY0So88nFEEygqmTcR3yUg1Ho4jNTA5eAXpXrIrQs0YcjWswbQlDc6p1mSfkU
	 ftkDNphXgkVgZlsZrr1Th3a8Dkf1LinwLTY7OK+KxvZRnXmYA5CI+tsLS0O0NRsecGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAhx6Y29;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA5606A33B;
	Wed, 11 Nov 2026 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAhx6Y29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DB71F00A06;
	Wed, 11 Nov 2026 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794387599;
	bh=50p3zI+Ws44mGPjo5k7TaGpGNQJ8ZUfr5PuOkAq9Jzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dAhx6Y29SAnBcPk0PWPLRDlI0f6onEfsRrzeIclaRU2LbxS1OdsTakQUobxMt3Jut
	 Iw2v22Xz16snkKrPfdbPLV5dUpVKjbbTwDGpgU3y71/XtrkKqSUMBd66rWXOyvszSG
	 BhxhFWIkQQDXzcr8f8WberRFX5bPxTX98LFU9oCi7Awxl8A/neNapHUjDE0HmTTWC1
	 VGrsTX05R0r9FU000VACBF9YsKMNIhMZotKrCvKLXSfZDQY0q26BUgRO381p6SNgHG
	 jmLCrcOWgr5xYB3DcgK2EBYHl5mpXAZTDsVL7TumCK3jSWUbHqImhkHx9pkOGIbnk/
	 rxLZEEeYXrjcQ==
Message-ID: <fadd2cf4-5951-4e1d-bfba-1f107a191dd7@kernel.org>
Date: Wed, 11 Nov 2026 17:59:55 +0900
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
Subject: Re: [PATCH v2 1/2] ata: libahci_platform: reject invalid port numbers
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: hansg@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261110230332609vrNKZhiIS1EGJIhlnmX1-@zte.com.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261110230332609vrNKZhiIS1EGJIhlnmX1-@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/11 0:03, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ahci_platform_get_firmware() reads the "reg" property of every child
> node of the AHCI controller and uses the value as an index into
> hpriv->saved_port_cap[], which has AHCI_MAX_PORTS (32) entries, without
> checking it first.
> 
> ahci_platform_get_resources() checks the same property against
> hpriv->nports, but only in its own loop, and hpriv->nports is itself
> clamped to AHCI_MAX_PORTS.  A device tree describing a port with a
> "reg" value of 32 or more therefore reaches
> ahci_platform_get_firmware(), where the "hba-port-cap" property is then
> written past the end of the array.  Values just above the end corrupt
> the following fields of struct ahci_host_priv, larger ones write outside
> of the devres allocation.
> 
> Apply the same validity check as the resource loop and skip such child
> nodes.  That loop has already reported the invalid port number, so do
> not print a second warning.
> 
> Fixes: 18ee7c49f75b ("ata: ahci: Introduce firmware-specific caps initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
