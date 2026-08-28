Received: from mta0.migadu.com (out-44.mta0.migadu.com [91.218.175.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0531B823
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887327; cv=none; b=ouUvRgiaqIhdFd7RRkfnJDtrYYlGFmh/WaScFAiBxXuwOHUmp7sR23hLlOJNh/sfMYwhe28BNlJJynE2viQjMCNM8aUZVaMvRgf7ZrNPD+DjnQ7MsZ02MYwnw8VvXwIKo2XLz5kjvdJkJH0PpAeyQnG1G1N5ra1DkcwRLjaVTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887327; c=relaxed/simple;
	bh=Y7MwWHl6NJBPv/ecTi1oEv8BmOJQcKwIr5Mi4FgkMhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoE+IIEsld12rtywzFLN4bR2FJ5VoQXgz9zqQGLWQk33IKPpJRexZ/1rpB6PLhqT550ZnxQ7F10Ya+Y1RO6b+9SWxnQH3rHhMSgB5HEHo2rbBWQO+ypvy0aYKp29Je2S0mFqt4ymQhOP8W6jaIFmpLcESsgmGa2e3Fu7wwzmr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TCGKqa85; arc=none smtp.client-ip=91.218.175.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TCGKqa85"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y7MwWHl6NJBPv/ecTi1oEv8BmOJQcKwIr5Mi4FgkMhI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787887322; v=1; x=1788492122;
 b=TCGKqa85sxSLp/3OcP3+ycx+VCmKYiVTB4BPeN4/CD6CVP2J2kXKZ0zt+8Qw2jJzfn1XErJO
 +MT/h+4jL9UZMJ813rusDsi8Azptsw3X7CBMmoofcjK6s8ZFDmJKZdZaIBbPNec5GkI2MzB/mwF
 P6qYqUMWAObBNYbCvuyBlUrs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 83a847a7e7c0d7ab;
	Fri, 28 Aug 2026 03:21:52 +0000
X-Mizu-Trace-ID: 83a847a7e7c0d7ab
X-Migadu-Flow: FLOW_OUT
Message-ID: <eb9b2a50-70f0-4410-b3fc-3fda6a4ddce6@linux.dev>
Date: Fri, 28 Aug 2026 11:21:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: Prevent queue stop with deferred completions
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Cc: horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260827230233.94878-1-joe@dama.to>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260827230233.94878-1-joe@dama.to>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> +	if (txr->kick_pending) {
> +		u16 kick_prod = txr->kick_prod;
> +		struct tx_bd *txbd0;
> +

Please follow netdev’s reverse-xmas-tree convention:

https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

Thanks,
Xuanqiang

