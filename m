Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA363C9ED0;
	Thu, 16 Jul 2026 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238314; cv=none; b=MaESoFhaPwSFWCssZU3DOFCtpXGp0lc3HweTrefQxuiymsTHCH9SCMXl8lfTHjn1l7z0VXzmq5gwQBJecnLWSOsIAYCx7x/lfpzqk+MVPnnOVFt3s1k+GhToVudIR8hb98KTrollxzKqZaIjMzoO9Qt9vO/NI+cPPDQej/eYhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238314; c=relaxed/simple;
	bh=4wkUo21Kijbk19y3LtsH4krE8n8Lf10gQCBe9Cww2EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkwGXN2cr2P3SdQHQmkgtowDysGB3521yAVTkdPYnD4qSEkN3Jm4iZVQ74otcfupeLEsJZSYH8Vs8uBfwYBnhfzu8Ipvw69EnVeymwZDnEI9FMO7imPu7HiWKqpxplFfvgiKf4Oxz5uQ+TDrsC6gGCVSpBh5e/EvqHKjsWeZCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=DXK1SF2F; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="DXK1SF2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784238293; x=1784843093; i=smoch@web.de;
	bh=4wkUo21Kijbk19y3LtsH4krE8n8Lf10gQCBe9Cww2EU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DXK1SF2FLB2/KCdRwQZyezgLfhV4kb6+FKpB79mLk5iPKejbVZ+FwEc+Lsi308KC
	 dH6juxZ/r4bHeZzFuqeOR90yn1ksinpRBrZa+4uMVZ616aEsG8snHyXDIXNs3gVHr
	 QQqlT/gf5WS8N7EeEVIs4DRvmph7WOYDIvnPHfOzW3wny07NG0QcYu/IYsoiPlYRI
	 B6JdBRdafzyQnSg9qAxXUQAFlyCv7F3MZDZ6iUVW5PYxnMYCQn7TYLBUGFjHALWFT
	 u37RPn0zV75z8RcEJD4+777wEhTYJxYUwayVCKREqe/HjHlxxkdncexdaTURVFAn5
	 6sPE4nt7OasuVW3Lzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml4B6-1xRYwi3xO8-00eVYw; Thu, 16
 Jul 2026 23:44:53 +0200
Message-ID: <b19f5c27-cd0f-4000-91cb-5ebf1c119d45@web.de>
Date: Thu, 16 Jul 2026 23:44:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, Soeren Moch <smoch@web.de>
References: <20260427115804.134231-1-smoch@web.de>
 <2cbqhvfjszzuanp4i3rohntkxpfgftfjvzt66te3wkohsvw26g@yv4txuy74tvu>
 <465b1dcc-8e96-4edb-aebd-52937b8076d0@web.de>
 <6ayf4vt5wiftgz4myxpyze2wmmuxf5miakq6ffz2k3r6beiztu@lh5z5zjnljad>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <6ayf4vt5wiftgz4myxpyze2wmmuxf5miakq6ffz2k3r6beiztu@lh5z5zjnljad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hVG8vXu7T1C2kr8YJru8+r3Mj8ICajKhvDroMCNdjuJLf45oNPe
 wyo8IsRedGGdsAwxg0RyczZMQ5m5s00woAgG2HUbBxscyVmyJF1QiOY9wM1K7VS7XgWcOW0
 9AbgjTgH44O6chjYV/6acQGCjsgELZ3OvR8Ca8BJLlH98572MlphVlBLKbYoo5Pas/lxIM+
 HBHUUtnPWkeG1bbrRkm+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TuD9fFAk0O8=;h1XMfjGRJ44wAJze0yBhUaOj1Vv
 IlD2/oxsNL7H5HXFZK7Hcdnm8GrpwnxQDvIihMvc7Tq0S8sVa8eAqy2tEomCxv5406ttNMmM2
 Av97WU4HsnGDobbH6yX2JGfZB1q2rXFPl0cwdQrpCbdXRzijSt/5PnnSrTR3EokXPjqZdB5Aj
 UlLWxYHVZghKZITw1V6WsltQoD+WCH/fUOi76r++KIXJIFxdnZKucd07W6btu3SCtBSQo9UYW
 eg24jUFqVOJM8dExFcB8zOn1kj7KnpnuUdklsXyRuIPp9qfveHpOFrCzGaO0nBOwJqVpivSDI
 NgrlXYRP1s6GG2W0o5r3jvB/xV5meft4fjLV9cc46pIgdtmbtsRZN5KrB5NkhAMnPJoJ2IPJp
 cKpOVRqbZQ5OtATrJHI/prOMEuTQXp+HdH/d7HvHF7ZIPyYbGgjDffOfKLl/ik+p23nbcZ4pE
 YJpU6uOgots5RNkC/Ts2YyUFA/zrPr/DDkR0Msgocw/o3+dlPOO0VVP+nR+WeIWYLZmBhwm9T
 aHmXR2dEVr8z80LZw8vyNw7BRoQfbsyyuC2RsodVl0AjcSJcYB/TltByYO7OTqIpTC9rOtUT6
 lqOk+xnBeqXwHFHaKrygQRwdikSP8t8KcoZvgI/f69p/aWtUs0GGQ25tp57PSfuptKAeazQR7
 +nixFeERAUG4KCQPspvshxhY0FvurMAg+PUPjkDks+VoNcGgB4sc35Nzy/I4cTlhhY+tJoleD
 OHFNx8idlVKZxQQodKuCA0nTtBMgMx2WnxU3LaZhAOUzBqc1crhHDcnG2xGNADb0JJ4Jkolq3
 2jYC0zG1unXv4JCnHmWrp5JoTf5Iu7JVmHxxIU0osWCRV6hDlZmB3Hk1UVD9Wciz/nflbdPfb
 0pwnRUTXu4OqBV0pR+x/esG5jx+nn1O3cmTdslR57+0TNHTKZTMhBO03gyv7q6Xk02JiLP6LK
 RCRfPBoVhqEodI6SF5XZvyH6NX2zcXtZpifOeWs6RIqkGNyxJAja+GFONgVveNsmA4eWI63XP
 R5RLynReLxYeu6pmjMsCSr/ea8kY4vvORSAo02J0oYNHpc3FCih0pIYl284NjAjIXdrxgASUo
 4F6hDhaG9zhuOykixZTYMpWuE4dzsnJN4tukHn4BjSK2lmk+t1dxPQGK4WQXgQkUUzmK4nHJU
 X/NtSrzewbmQ8iIRfQqKYy2nVC/fi0DOgrXPin8aUs+MQKPcYzAE9Glu4ArQRmVSZHC7WJcxi
 Y9nJ82yVT65lywh2/4w2K94jJ0bpElW7PDTxPIHkslWsDMXtd9TxwJ+IWEK9/WI3qe15jDQQY
 kAOmHlo0HyCEPrSPpY/9dGwmov/cRnWnR7Yvr6EUXO8u5zbd6kq6C/BZ9jaa/oxjX6IBlTyqu
 r+3yB+7FBhjS6/wWROgSYn8Ao4AuOmf7VUR4CcQIgsl/KqQhuC0pmysnb8qvXxDQarp5/d+jW
 DX9rZz2lJMDvFfFEXVATbjrHQfTRmvjEbdqmYfc5LN3IU8FjNhdB+VSkCtd/eKVfwmCkNlA4f
 +jmFPtWZtl97GGNjKIVBrdoRzpxF3C0B5T810OEeFmxcOkZGPDqJ5HtwYofOf0h0fbs3vAxta
 CpuDTxPHqqIUHIQPV0jkHh7KwBKRs5MdZ7J8XOdzAtZfda4ObVjqoGNHA2B/ID02c2Ji7YfOQ
 9QC12tZA/5czAh8HOFRTUj1hLxUgQx/fPevANkRDTrwu8uH6UUfYmaYaxM/eWqIMRCiWRSlIn
 L8c8Z3ztkriTLk6cRgoJwVf9uLKs/IYPGMRjm40MCT0w3lAZb1ZDToKoT1HTBaEkb8yFI9PCl
 wnHAIN+B60v+0KhFHfA82RkQ6SeREvGR2bLZhelQfx1nto1NOMxNCtAjkJHjAC2MdIFJkX8Y8
 h6eIb9UFFNS0mfoRDXcLlWOKPoGJ4g0mT3P3flY4vLNQt7Ma9o9WzHy+YZS4QkPUs/yNU4KWs
 TDra7ybg3lIWnEKM5wL8xjgMP3xGwrhFDLECbzlUT/1IIOWoUKHe5xSdoXWKWzmMqzowpselX
 +QHC7AQdFGlSGiY8/a/F1bCyliR58htFk+KAMcCu6ejqeDQff1WpvldZdulCUQFwv0aAVJCZ6
 KXpL4/jFzCyZuo8r91+hQTY/kgt/poXXLdTMi0zoT95za4wUkJq3eng9F1YyXNMF06a+PB/oK
 mVrN6knPAQqMt1pBq1NzQpp2kl3nelCkd7UkmlVds/0HSZU07dTMW19/T4GyQ8QTBF71DB+bm
 oP0C0z/G0Z5v7DUU74BdT/TIXr2x+PtbTrVvD0+2NCsV7Bmqkc2Nl0ovHia/c3m8Ih9zd61r4
 radhRABUcKVFtLvAf+GCw1kkA8haT2DogORw4sDZjb3Vfx7ltHgm4JAK45TCL+0PGFhv2ElNU
 VvAwt9QiheZm8/0TojSEu0C9C1hg0va71Q7Zqh7dIWCkJ4Zvmg00GWX2heLfiCZlT0iX5PRle
 /lJDrMEj6PpZYjm7Xat5Rus4JjHsnHy+2BnLUHwVPSo/HQq5wIstKKNxv7jQzDEfb+UWVPjN/
 NFb8aQfaVOnLhAfSZY5u6W+OH2zNS48lik7BZpa8meELxvDciB/cNUW+q0X8T88CUHglJO+CX
 Sx2qjFl3nYi6duR6FIquwrBKBVcMUa+fflg8IGXWWZU8oa2COyul3xJ8pjXd/LCYzWr9U37do
 dOKKQxZPZWb9RgQKYOjJuWlsnfKw4SxhQNUh9g0d11dKxMS4yVtXoWlXZ7ogmT069jVd43Rjv
 nSFKgW9O4eGEBefVryMYcOsZjISkwQLbv7B/xwNJEmtB51WzEGNNAqF/0VddobvvKM+j++R21
 Wnlq7P+LwIK0o4OJfGJntyZ3VxfepZ8eIcyU1I6d29EvVgWK+ouYYIHhhV8HCZ7kXlp12ixfG
 D42B0mMie1AfdeRLBQaiVPY52oYmj4+92j+ccpLAKvq0UmtnkhsEUy4XnowMrZz/6K0GSa2xY
 SN3Sw40Fsyoe9OY485Mzod3TROCNQqJZewFd+1vmpDGvDIiIZEBzXhOLvcUMGrmug8hpyPUfe
 VmGNDLPTk/zE7HbUgmFR0uv8SzuIcMT1+lRIhAEbyTqwWOA5JaaA/s/g4i0m7D9JvxwrJxtQA
 8lGXZtP10NC2R2BUsfq6cKjw626uq/tz1e3fwIpoKRBPvWQ0EfD2Rqr+89OFyYKiZZ3RYeC9T
 nkzoNktcf5JTpoWwqfS0t/Tex9CE+V5oClTx6JWDAyZQp8ngSlM7vIJdrQ5IzsYatccmF29bl
 S7N5EY1LvfLz6wiKISXistCASARwK0ZE9s8q5vRw+m4KFnARfS0ITmMSyO7i6x9lqZouPBT9N
 lPeGWKi9c8NWjB0dxh14ucNmuEdeAXj2Hr4jVkNfz8DYuXxZeyKb/DcRRScm90r3MTQujAGfH
 1TXHXCObbctMI0N5c2r0hhWM/+yRE7vnK5URA2rK7DoxmL5eh0eTPov7kk5MCxqbwakugh/eT
 4JU/YhyWIPbfQlrkXiRLBi/VubV/k6cHTCnIbqguZ7bRuAtaMN08ewCgyG4sDBl1M5yW635x4
 SlvhljWV6Xls+aKsTy16ExpQvgoHogXBr1paRYse1OgSwCZyAjEIM8HZiK7X8YBu7MXMujyY9
 5un4m2i/CeCnBL1tbQqnBShW+3WEWjMm6qKbc3N3nHfFaygr4kJC2IujGkGZ96u1rl9/zuk1T
 nvFclDv9j1FpTuhrFwnlHo7nOQzfVSm25RpoOljJ/Dh/87rGaSqWnEccg2k4iN3nsiqm40rmk
 64/zigJ2w2d8SDRvMDjBJOCSXBscqCh7pqao93o/S3e4kKHTOl7b9m04YkjrOZ8BBKEP3lpR9
 Rs/ldzowsn5LtpcF+RhYfS4t0t0dSiFOyFG3IzBkCVhdUdO8/CiZ+5jY1MPaKw9j6N8AJulnr
 oQVbd5fYFkZv8itU4ib/S2D6/Rej767s229QXK2j6K8Eo7AS810rKCyekDMc5VSrzw28m5ZbW
 JTyXTi+FoUgHPeJ/olZmZrq7KjQZnEVLRogPbHloY8JdhOpMDuHMSFyLNb+DD92ktaOM4iC9/
 IJvhMxn6GnivhgOy3Rv/B9GQLB8ejMiOsIXT21whmMjZXbSmKxIYBQvQRB0D6U0nIT7RPU4TV
 sF8ObdAz3B+g4ZMCYKfEhF7EZ7IG50ZF0rbVFrKt9QyXEyyHZGH4rQ9VkliPLNefCdUCoRuLk
 Jda+ecM16tQj+vQ3+OLAP3+k2Y9K8YMz01GLuoDVRh5XQh9ZwD4jDAaiKmFOdyVTn98WHE2a5
 Gs4HnC3tMvnt4QBiTs5DODk1aUDqueOb0CFO6XayZ1p7SYpci0s8LeXFx+qrOVNf3gQfADeaV
 B4QX9AADbd/g0szU+wrUV//XaSbFfX4u6SlxuWFqKWDsqUjj8oggCGaoCxW9Uj/GXYdDpv9Fx
 ppv2x5RqyD1oocwdOtRUCfnrTvYYDr+vbHtPz4SEsyfStqZjZbMKgHTdbmNCM+FtqB1zLCcMk
 21S6QaDxHYi4qUhMfdzBN7kmDgydPDZ0Nsj5ldj+UZE2tWA9RsGZr35h0GpOpUbBDAoqfQESW
 gmBYUVOWBSwtfBD0MEv+a+0HCE1zfpd4alGMQRQApJMo/wi/vO84EZBwLZOmgeO3OZTF5bJno
 aNG+vh2WHU5KYr+adl0iMuMGDr4/P9V8LB+N/qoOicc/e5YK5yr2Qg0emUjmjT3NNGdljhBqt
 k1a+MJYmoIhWMeOE8woXFPiKFEbPn0ZQRH3C/i9H0sp8lVh/+5xtFSwjtpyKHt5fa63YVSVTB
 DwxjNUyhY8M4uzpHApEZNIT1hENyKUAm1TChAVyi5Jyg8sk/M5LZdrAvYKvz9Ho8fxWlCcSu0
 g8Bl7UEtcI2xP+sVGhK9M6G90B4YoTpI8Z659W+ESxdCSP+USeP+r3qAt2yHUMMLh25IbRfkJ
 GsX3K7vPJ1y/wS/9GvdjO/671b+QK2I9TXu8nAvBzeFfRlOa82FLyWmOyMXRIvrwwH5oVsFUr
 UteqVGpMWxk27IlzoF96xOCVmPr01ESRsRlt+J30ZISGDDJHT8Dx6p+LEyl7ZMNNMPkVUEhFk
 JJ19FYRca/aYEc6zAW796PsdafdCvMZqzVYy8Erd0gZfXpZgbvV00vBwNo2gmIbetPupY3WvK
 4oZ5EPtS7D0HkwCJTciEEUVo2oU+7IoUEsxJS1TB6ab1twLYiHRDc9g7uTbAcOmgJa8TLjyYV
 6w+fLaHQSEHFaVrrPUX/UxEFYVswXzM7XPRFC9D8w4Ly3iE+gh7IzxYmnB8F0qxCkFADv4S5t
 zQINJtcBQXJhcQOO2hDymY4hjPDeNaxLQHrY7ksPW5bIWkLm1TKP3TlnhM+c7MiRlpuwtrh+e
 5Vi8ChzsMjSRo6VWZ5/VumMDB64E5LxuRHLN20uD58HptBcDox1vFpcoiuLKgfQq9bslkq4Fq
 UHXJBA1FgDGOluSkcFk+pkqXn2tb8+pxguDEV7vO/CgL9N6T+feiMh13BLWf0JQma5Ux34Got
 tqtjJr7tDfhc6hTb3T6vQrKLTVtZ0zi+el8gEOVgGOwsbK5UxrOp28x917ngiWq8l73UVKB+4
 hzdYYcUflRMyXxXALiut6S4ZUNcMHoglPVtfuIA+xFRi99XGjoldPWkbxnbIvmumu6neopzTH
 q6Rm7ejFHR9KRs5VEUDtxSiQCoLfnFhypOwpSWiLFmWPbOIfp5ZqymZInlploTsGJ4ruEZae6
 fT1SJScnrwBAAeLJ/G6tG/MdV8Cb08qItP+smqF3kxb3Dq1jEXjDndD5FcCp0nnDvW0mbGxI8
 jEQVrAgbpl7xfGCTUEtbte8WR4tYTTYvGwnRBODQSElJN9gfkDzXP7iMMYLeWlOKKwRvbw98w
 FDiFvp+PiSdE



On 15.07.26 07:40, Manivannan Sadhasivam wrote:
> On Wed, Jul 08, 2026 at 10:52:22AM +0200, Soeren Moch wrote:
>> On 06.07.26 12:29, Manivannan Sadhasivam wrote:
>>> On Mon, Apr 27, 2026 at 01:58:04PM +0200, Soeren Moch wrote:
>>>> Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
>>>> the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
>>>>
>>>> Even though the Root Port MSIs won't be received by the iMSI-RX controller
>>>> due to design, this chipset has some weird hardware bug that prevents
>>>> the endpoint MSIs from reaching when the Root Port MSI capability is
>>>> disabled.
>>>>
>>>> Hence, always keep the Root Port MSI capability for this chipset.
>>>>
>>>> Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
>>>> PME and others won't be received by default. So users need to use
>>>> workarounds such as passing 'pcie_pme=nomsi' cmdline param.
>>>>
>>>> Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX to work around hardware bug")
>>> This is not the correct fixes tag. Correct one is:
>>> f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
>> Thanks for the fix of the fixes tag!
>>>> Cc: <stable@vger.kernel.org> # 7.0.x
>>>> Signed-off-by: Soeren Moch <smoch@web.de>
>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>>>
>>> @Bjorn: Can you merge this patch for 7.2-rcS with correct fixes tag?
>> I can send a v2 of the patch if you prefer.
>>
> That'll help.
>
> - Mani
OK, I sent a v2:
https://lkml.org/lkml/2026/7/16/2092

Thanks,
Soeren

