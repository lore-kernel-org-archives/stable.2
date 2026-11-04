Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818793;
	b=MfZLEnjsw4EQAdUY7ZymHOifyYx377jGTpJsB6XLfYihdxxGMxiwdAkgJjgRmw9JpPMy
	 Vcpj1yDE1vnyoot6UbYzfoUNS04p7QzM9y+z2KyZZeYSQQPL4Ndj3EFVIAg5PsSqUCy7L
	 ZVShSNKhqIwe9evo6hhdlwASS455z4+U6wD+1aJxScgnYBcQ9y2uhrN+T+k8AAS4DpWD+
	 wY5fD+WN8TWJqcr7j6nVYa97iekK4RBCer/Q/y4LQAeBQ9GFAIGCQC/17Gyqe1AUdXy0j
	 DsdtP6l94G24N+FEYo0+JNlM6UtuOkMMBpLoAG2qaadESAgpuMtVAkKqXg7SCpAiJMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818793;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=U5YU4saxnJTeNwoe6kvpcWy7vnNuqiTY5SpblJDoGjM=;
	b=YiJXG5NezjiLQL4mroeDk/HCT3OucjxgwHW2W4ti9pv8LWrJlQu5K/NeNE6KED34DqVe
	 7vg9TJnxmoXveNpNA5bzHtpCG9wtyjlpC6U89OhK8Tj/+0R4pCW/Hy2BOAcTZ+RAD0J6k
	 XhJURougEuGe6XjRFa6awYz16WCU0uP4QmEc04ZxvZfBoehqCjlwbkyAsp34WuunSye7a
	 JA9pLx/7AvTonv93MpDSoaOQmoo3HBzk+JxykPmIlp9f8hC2H8GhqddEeHVgPIBBktB7V
	 JAjqqUO7Pm07TZF57HSi4uZTn9IL8UNZRlL5ILBTULcATxWnkucZ6gg4T9HBEIaMGjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lZtxG2b/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE8606A31B;
	Wed,  4 Nov 2026 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZtxG2b/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BB11F000C1;
	Wed,  4 Nov 2026 18:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818792;
	bh=U5YU4saxnJTeNwoe6kvpcWy7vnNuqiTY5SpblJDoGjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lZtxG2b/cSDkF9V30h0rcrAe5BIggwcCMhjdRsohDuPTf5xQpsrWNVb7gBU0Q35fs
	 YRk2gWxMWvdFOyeKxNzZ9g4iaI+Gic5Fxvb+GBngUf4x2L654czCbnbA2gFBwDLmVa
	 WcLmhfB9UI1SHIKoUuRnWrZR8ACaKLhXAI2+i9gr8ctj0EKG4aGL9l44yugbfEckbS
	 QQpdXKiPyMrRkIQLDip3EQyXT7AXcbzkEL9T69ouTSSwyuYQF64MBNbQXST6KUrv8E
	 9KCetbeybQPoPFXHllEpL8BEaC/oDUIpkJKBTFE2LJ2rDbQ/YB3QFEXsJpSt4X6caH
	 xYHQskebWUf7Q==
Message-ID: <c4eb1d41-8b61-4aca-abad-22cb61a4415e@kernel.org>
Date: Wed, 4 Nov 2026 19:59:45 +0100
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
Subject: Re: [PATCH v2] memory: atmel-ebi: Disable SMC clock on probe failure
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Boris Brezillon <bbrezillon@kernel.org>, Mark Brown <broonie@kernel.org>,
 Andy Gross <andy.gross@linaro.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261101190733.121473-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20261104185308b845fb6d@mail.local>
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
In-Reply-To: <20261104185308b845fb6d@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 19:53, Alexandre Belloni wrote:
> Hi,
> 
> On 01/11/2026 20:07:34+0100, Krzysztof Kozlowski wrote:
>> Unprepare and drop the SMC clock reference, if probe fails to avoid
>> resource leakage e.g. during probe deferral.
>>
>> There is no remove() callback, presumably on purpose so only error paths
>> are handled.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 87108dc78eb8 ("memory: atmel-ebi: Enable the SMC clock if specified")
>> Reported-by: Wentao Liang <vulab@iscas.ac.cn>
>> Closes: https://lore.kernel.org/all/20260917101623.2146392-1-vulab@iscas.ac.cn/
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/bug/linux-8e236c81-01b2-4274-a213-11c3f31acfc2
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>
>> ---
>>
>> I independently developed the patch and then checked the queue with
>> pending work of iscas. That one has issues and other complains from me,
>> so only credits for the report.
>>
>> Changes in v2:
>> 1. Handle of_platform_populate() error.
>> ---
>>  drivers/memory/atmel-ebi.c | 27 ++++++++++++++++++++-------
>>  1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
>> index 1e8e8aba2542..7dc2f7add1b1 100644
>> --- a/drivers/memory/atmel-ebi.c
>> +++ b/drivers/memory/atmel-ebi.c
>> @@ -562,7 +562,7 @@ static int atmel_ebi_probe(struct platform_device *pdev)
>>  	}
>>  	ret = clk_prepare_enable(ebi->smc.clk);
>>  	if (ret)
>> -		return ret;
>> +		goto err_put_clk;
>>  
> 
> Couldn't we simply devm_clk_get_enabled() ?
It is not this device's clock. Is there devm_clk_get_enabled() variant
which takes from other node?

Best regards,
Krzysztof
