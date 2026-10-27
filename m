Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119464;
	b=KXfbwk150aYZbJ/yvdMFJBON8Mokq8YlYRnRsd5us5nNN4J3T6Qho0QgNy9QBYCjtB+G
	 W0ltPekvZ3aUDW/1I4jhd/9T8QWuFwwmMuVkw7kvfmOYusUyLAYSmtSUo0mbG2OcPQNGm
	 wk0Vl5IAlVjR7iV23uO28+t2BoCeZoS8PFukrexNNsB/UFFAKSiE5Ez5SW8HA/EztC4Wo
	 BCzJCYbGYbdQvfE7/9eoE0UjeHIzWXDfVkYsNhwHQO2FiD+A6ZkGGrBLTkjbzzS1PW8Od
	 ssUIk9ccWe9d6zb/WlAVUDn31J72aMvgcdvPTrkpxAPipxUSCyUVeCI5EyOPTisZq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119464;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PByByqtjwpf2F1B4j8nkJ/iNBLtHOWJlMjMnw9UUR8I=;
	b=cHMvZ+40Er6/uwtbxzyLT4IrZBTBM5zTw04SHjcM8I26fNMSwXkCOgWRuOl8jPIuB0LR
	 q3kEojjcIGpMVXVlUH9hhDyetT7e2NpxMPqKGgwLcbZL8PW8x3PeY1E2+j9l1gOQKUTOd
	 47dCd4fCw+m2amy1PP8UJRRypQEE5H9jWEsc/dOS36Ok4A+S9CUqBIBp7fxWbPGS3hrJC
	 YB7HEQSWGLiAtIpVo1kGQis8Pefe46AT2gXud67SJBJoh8tAFucUWylilgsA4Hv1/yBJX
	 XhjqAYW6CSwG5bbCMMH1LNz6DRFZ9kZeUAN9cHyMzv+5JnlxIpv8RBkNFGHiEE5tT9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCWy3KHF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAED606A31D;
	Tue, 27 Oct 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCWy3KHF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640501F01825;
	Tue, 27 Oct 2026 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793119463;
	bh=PByByqtjwpf2F1B4j8nkJ/iNBLtHOWJlMjMnw9UUR8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cCWy3KHFhNHmxagXyNBnkL9vclGpi+tM4IdV8nE5yJ7dAv9Y2Ky+LQvEnJekkmDtj
	 u9KJVnhAB33dWLgqx5E+yUFtJiWWyOiBTaiAt31ZLCNJ2s3GmJT4UVCXTkCLmPS1Mq
	 ZewG5/hI+9dIhAKt2ZuK3sgbvSPE0xnlah0zxwjzq9GSuE/IWvo9MCCav/8rjnie9t
	 lyrlrSSVk6KTheK/1a7twfU5fgdHhGhmE2nODekvPEPJ9jHlKzDrtzVkD4L+MHhh3K
	 /9etIo5uLDf9lJDKBy9SVVQgKf//edO/IENZJB50yJR3BPl26pXS36VtjN43E7dH51
	 miqHW0x9qdmBw==
Message-ID: <585b45bb-a9b8-424b-abd4-66d53076b501@kernel.org>
Date: Tue, 27 Oct 2026 17:44:17 +0100
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
Subject: Re: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Lee Jones <lee@kernel.org>, Mark Brown
 <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261027032609.119226-1-lgs201920130244@gmail.com>
 <f342a5e4-82b3-4044-85a3-10cad08595e4@kernel.org>
 <CANUHTR-SJTiQvo__wbqosSQV958fkHGY33YTRFor2=EwDTdXPg@mail.gmail.com>
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
In-Reply-To: <CANUHTR-SJTiQvo__wbqosSQV958fkHGY33YTRFor2=EwDTdXPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2026 17:22, Guangshuo Li wrote:
> Hi Krzysztof,
> 
> On Tue, 27 Oct 2026 at 23:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 27/10/2026 04:26, Guangshuo Li wrote:
>>> twl6040_remove() currently removes the regmap IRQ chip before
>>> removing the MFD child devices. This destroys the IRQ mappings
>>> before the child drivers can release their interrupt handlers.
>>>
>>> The parent driver also registers READY and thermal interrupt
>>> handlers using devm_request_threaded_irq(). These handlers are
>>> normally released by device-managed cleanup after remove returns,
>>> when the corresponding IRQ descriptors have already been removed.
>>>
>>> Consequently, free_irq() cannot find the IRQ descriptors and the
>>> allocated struct irqaction objects are not freed. The associated
>>> IRQ threads also cannot be stopped through the normal cleanup path.
>>>
>>> The probe error paths have a similar issue, as they destroy the IRQ
>>> chip before the device-managed IRQ handlers are released.
>>>
>>> Remove the MFD child devices first, then explicitly free the
>>> parent's READY and thermal IRQ handlers using devm_free_irq()
>>> before removing the regmap IRQ chip.
>>>
>>> Also update the probe error paths to release successfully requested
>>> IRQs before destroying their mappings.
>>>
>>
>> More of postings by bot ignoring any feedback.
>>
>> Best regards,
>> Krzysztof
> 
> Thank you for your feedback, and I apologize if our recent submissions
> gave the impression that we were ignoring your previous comments.
> 
> We did take your earlier suggestions into account and subsequently
> submitted a patch series accordingly.
> 
> For the more recent patches, however, since they address issues in
> different drivers, we thought it would be more appropriate to submit
> them separately rather than group them into a single series.

How this that differ from last time, explain me please.

Last time you sent x separate patches for subsystem foo. I asked to send
them as patchset.

Now you sent y separate patches for subsystem bar. You keep repeating
the same.

Best regards,
Krzysztof
