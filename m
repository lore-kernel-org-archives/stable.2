Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489022;
	b=AJT1q1x5X4Gx2nOdYpwxGAU/qwKXVFgoI8WJwOOWYkc/z8YY+y3b00FKgSkYx0OpmrKT
	 8IVXLyCUoMQRLpp2NugTdo+BuwhWe2pHeByPRcTLctaT1lBjyIipx9/34OFE0rUfdsPCr
	 Ymt5YIefZIrok/bxSJYGeN8+bI9GvBA9JHgRtNXWX4URHKj0vpF9VoUEAIQRNv/VHkx+M
	 7IyH5eAjPKtKmz94xVgqlOkJVUGveS78OsrN9ZOrnDUDlOdk0no3zEhnm4gJgWjGUh73z
	 /0Wrh6JU8zOPp9bmRwwy+DX1g6cmrjxlzqowg1RjLu/4/KaDjHE+7TRyq+PLvvieWtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489022;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5lpsvBHvAxlpc1hwk1xYx6qm1Ra+T5Mj3gqvkbfy5tc=;
	b=LMfvk6FTWx+Arx0TRQ8FII8oztbtnB6bJILkbRLcXja4dRxNbkVSv4KvWEizZ5qWhgcL
	 NfDbN1p2qTEZlG7q3mCvLbWtN79GLbB8ZNGi0quCC8pUq7pU3C0aRG69/9hRZ1ggk5jNn
	 7DpDBU/k0FuLiWOkGumlysWFn0R24EeEBlhytvrGZZfHmHi8Ge/hGc6sJ16P0ehAhS+oA
	 VBDaRA20iyDEipdIEaTb/5D1F30ogPkgBzoqNa2PLAb0MWke/+VDTacbKxgfKnpv98aer
	 E1hxAkApRcxZNVU5LPuV+mOaGN5zNXdeMGWDubbaFZ8D6pdkxVc9jiriY2LUtOMOsxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L3LrkfZY;
	arc=none smtp.remote-ip=91.218.175.186
Received: from mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A1606A33B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D2A1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L3LrkfZY
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YIEvM8sHgjMXvgUVAE5uSY5439/NF7a2ha/iAy9npzU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792489019; v=1; x=1793093819;
 b=L3LrkfZYl0gjR3Vo12WVSvF7RcDabj6ykozs1ep9Cl2E7fudrl/9zjW0ynytHSug1SGDaJ2m
 fKUJkVQ6vdDsT/v6dM4r9ENYhCb9wTM/CtoFw/A1S/rMa5z/RbgHE4C2USf6A7b2orO2VRuqQz8
 YwngvetnNnlVbKg7Le+up8hk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 26a47b0b7a78b92f;
	Tue, 20 Oct 2026 09:36:59 +0000
X-Mizu-Trace-ID: 26a47b0b7a78b92f
X-Migadu-Flow: FLOW_OUT
Message-ID: <c23a3d37-fd61-4f7f-8bb5-64792ac7152a@linux.dev>
Date: Tue, 20 Oct 2026 17:36:52 +0800
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
Subject: Re: [PATCH net] pppoe: delete session hash entries by pointer match
To: netdev-bot+sinfo@kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <kees@kernel.org>, Simon Horman <horms@kernel.org>,
 Asim Viladi Oglu Manizada <manizada@pm.me>,
 Eric Woudstra <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261020092118.47416-1-qingfang.deng@linux.dev>
 <179248826539.3290.615848934021449047@kernel.org>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <179248826539.3290.615848934021449047@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/10/20 17:24, netdev-bot+sinfo@kernel.org wrote:
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.

This was found by LLM when generating selftests.

>
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.

It was triggered by a duplicate connection attempt in a generated 
selftest, breaking the existing connection.

