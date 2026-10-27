Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114825;
	b=g/uFI9vs4Z90BaxbEKA0q0D5VVCAGKnMbZKR71SU7Mgd0v2lQvEBEvf+4uapuVIGItJj
	 nH/KMkGiR6dxjBm6ne2D7CWgKT3zR4d/fH6QgQzRd1RW1m7wt/8zGvwxgQEUEQ4YdKrif
	 hRHduPij/OilltqDYvT3ANpafvrKUW54JKCv0ceXhTmcbZVy5ZHMmZW+ahkEGD4hjZqFg
	 IAwUgy+t8An46Xj1Ce1FWnXBwnAdiQzJxEOcTpakfL+ThM471NQ2l5LWF+Cex32rjB2st
	 OH1pUIOVA8fXJAQ7BYBOuir9M8YTXCkAhRdhbYnaIESo98zjmHujbOXKVynZSKPnDRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114825;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wi0StJVtvw/zinVc4sKSY3h0wecMwn/MhOcHTKAD02s=;
	b=TiP3e6I9DhFeC0FU92VuPQvze10gHPJfe9IEqZuOuUFVDHB6/OAHWUOe9Ifc2wSt1qQ3
	 IJh3fW2Lckl0coLVbWuvyHjNrQx+MGyZtDZ9zXY+zL5C931B07jStjDjNUam5iEMNHdT8
	 0tBeb22zxqaLEPsscCaYdmxg5iVo6K8O0k6M9FJARCTTghSfvbtB4EtjD/F8aO7garo/v
	 aS5NTlzf1G2dnIp+AsY4t+ubNEFuZFYbf2Rpj9dH2OyEvhwR9xYmatMWtz04MpQjIo576
	 yHZZ5OPv1GmwJ7VWMTrOiaIV9/0+1H8XvsRDYTLjk/yuoVv8lrUPm23SiClgcaCvliA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9thClYQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073AE606A31A;
	Tue, 27 Oct 2026 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9thClYQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D0A1F01825;
	Tue, 27 Oct 2026 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114824;
	bh=wi0StJVtvw/zinVc4sKSY3h0wecMwn/MhOcHTKAD02s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F9thClYQkOQH0DL1SCEgrbzYuEQiLDXX04oG3zeeQiS9/a3WqSz0HLsb81+jWLl0Q
	 VuOSq3y9r7DNp5PQcCzV/sa4iw3dxDA1RzLz47QtrwNJVo+seqFS7BblE9h+31apgG
	 7wEhg5JOS4GPxodIMZ2Iyop6JPEOTqLjJ69YFpGOmg/TbKzGm6x5Q5BBi6AoAFvPI8
	 F+b3zPpymGiuT51zSVXzkTa2V3ICWBTnyWKVK0IIzD0TxYOVUUJ4B1TCRxi+JvqdRk
	 Wuq/rOZPJn0OxbY0peUoiYPnM6yp2kHKKTIQAtv5BRDTtSSjTByBrE2gz73slJy67V
	 Ysy8utH+sZJ7A==
Message-ID: <c04f2ba8-fc83-4118-a26a-76ea8cbee518@kernel.org>
Date: Tue, 27 Oct 2026 16:27:00 +0100
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
Subject: Re: [PATCH] mfd: hi655x-pmic: fix IRQ action memory leak on removal
To: Guangshuo Li <lgs201920130244@gmail.com>, Lee Jones <lee@kernel.org>,
 John Stultz <john.stultz@linaro.org>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261027024609.117371-1-lgs201920130244@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGPBBMBCgA5AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJp2mE8AAoJEBuTQ307QWKbeaIP
 /ihHTkTW4KsN/DQ945JJbyu5tI0J80Wue7QyyLPglyKfhgb5cLLNPpOC8cCIJsc7+W3i2P38
 s2c1cOH6CYGE7E9ur3Vfme8NW2S2I/Z8VC7bZnzyS23wT17LrsdS/qCpx4o8U+pt/xdXDKph
 EGRYrIEmMpUWvyYzyYKGIe25FtaayIIKpq8eZYyFcp2f/sG5IkOW5uZzHPMPdcm87jU7fyuQ
 rAU2vx9r+ulUfQ/q9Z2roC/ode3l7t2pN7BCBCsUDp6JCrUyZrtT1e7EbA0ZRP3aOBNk2P2E
 DQOgJGjGdO5Yx2Y9LFtltu6JbsBJHi1syGRX3AtQYOMc4Y1WGoeZJmMlvKj2ZqqXNkcWi2DS
 IQEWB0uW6CqFsBBIMGDa+6OzdaVO/uAVXWDWml02Men3CILdI1MbVjoh8ECqYUY7OQ+JJvNN
 vnliuq5WM3Ghd3jg/LZZrxXjdIginRHFQCjIJYLKpLZWm1/iDFedcfzqRNYmTtqscdCNHW41
 oT3Z7BmO9xwdjuwBS6nmS6JJwkbf5Ot2QR4pB/DRU7ZwjT1qHe+9r9gF32wXVQatHNGK/VVu
 sfwOnkdxCWkp/qb2gdQRmZh+SedStWshigH6sNfuHBloF/q+hjMRc8b2m326OZdrbSHwY1Sz
 vti8Hn7n8NjdHO9LKB7BIdjkA9DA5WsqOuVCzsFNBFVDXDQBEADNkrQYSREUL4D3Gws46JEo
 Z9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLueMNsWLJBv
 BaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6eiOMheesVS
 5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wAGldWsRxb
 f3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA6z6lBZn0
 WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9YegxWKvX
 XHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt91pFzBSO
 IpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gUBLHFTg2h
 YnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/JoFzZ4B0
 p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu4vXVFBYI
 GmpyNPYzRm0QPwARAQABwsF2BBgBCgAgAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmna
 YUkACgkQG5NDfTtBYptX+BAApg32CkxwNucNEi8WfWA8oKkW0y8YDuY6ORMo9FWNGiT/OTy0
 vyJrLocrpn86zwfjVp+eCrssPYh8eqJfnWqmYv6ACQtHPYzPZQ3mSo8H97Z01oUxITzCxpXm
 ZkLgPIqtDPcC2E3dPM/fVxcyowM8XsaMA9wcsaUYrta8toOq2b9tKcjleKMfMrm0gQ9u7wUc
 QbLkwj6TCLOwucb07GXzLTNF9PZmaDUpKAZjMjmrW+le+SFvQbhamx0rxLWPR0NWntXpbCn+
 +ACch03p/JyTBVktxFsFyCt7pTPE1kEaeuXBTe/a2D9iQvRxRW19LvuO2e59/u1wYUiH/orz
 wbIC2S4dBsPAPihL3ztOU1yE86GPyQtSE0kU+/7snnLt4QGi6PChf3t5gnNjAzjUUovO8rgI
 c+5yN5heq5loYHgK6OQ9OlHzsPHO9e9MOQcKlFycs1pyijFGzDwdNUm/SchK8iWT2QApTx4A
 K9bCVaboTA2T77QYkRcRJYSsO1alGX0ome/hMLD1daXlkrNUp1HWa3K4iytLRXjCSIorWiGs
 n+q3krnpXu3TFkA8qtOFZMdnIiFuiq1yLT8hptsV5xh1TA2nsVvSYiaCr3q4s4BKjS/KrLDb
 qoxzw8ISjdUp4pA85vb6YLCmb39NgidD+7PmAr65lBNveIFynTgsja1rRQ4=
In-Reply-To: <20261027024609.117371-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2026 03:46, Guangshuo Li wrote:
> hi655x_pmic_remove() currently removes the regmap IRQ chip before
> removing the MFD child devices. regmap_del_irq_chip() disposes the
> child IRQ mappings and removes their IRQ descriptors.
> 
> The hi65xx-powerkey child registers interrupt handlers using
> devm_request_any_context_irq(). During child device removal, the
> device-managed cleanup calls free_irq(), but the corresponding IRQ
> descriptors are no longer available. As a result, the allocated
> struct irqaction objects referenced by irq_desc->action are not
> freed, causing a memory leak.
> 
> Remove the MFD child devices first, allowing their device-managed
> IRQ handlers to be released while the IRQ mappings are still valid.
> Then remove the regmap IRQ chip and its IRQ domain.
> 
> This issue was found by our static analysis tool under development.

More of postings by bot ignoring any feedback.

Best regards,
Krzysztof
