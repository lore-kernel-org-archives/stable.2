Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157524;
	b=ApXVsDlCQu8ItIJc8tRSwFHmcct87n6zWducBEX7Yl/sVmvAMIT8aNg155hQuBV6di2/
	 juBQToZw8KDNGk53j+F9JO/ambKueQFvpnJyCmCgpgZo0VGbyfY711DY4YxiLq147lpRF
	 bt/Axn+LkBV7Wdx5QRqc1UBO112BCveKyy84mnMAHtdWPm7tU8JUx5374rLjTz+/CWL94
	 2otgzsPpVd6NEhcJaEWb4568bvp/tW6y9bOF4q+8r9fcLCKFnBBGQtFCyZ/Stcn+RHrWD
	 4pVEY8+7SGMnIbYVmSJx7htLMtssJMKMuMguP7CrUleOGyBv24xj4JRpnr6enEF+KEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157524;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0z0AzJNanfrVB85wgMFdgJJ5GkqCfeRb/cYUccsjyJg=;
	b=EBe4itJKLmQTGYabJnQPFNlnEbddXsLS7Hk52IyVV6UD+y1F2IhwfMT+pu7Wu/1eRl2k
	 d1z/2KnECRXtvAUGTiN5Tu6h6leygPWGuOk+xzmvAHaxMSMAJpiu1XA9CBRl7jbpDqo9q
	 2wy/la7fi6852ipgQQC1sNS4qbxQS5wPlcSUonQSEaNk/Cgsfr/gwqpBei7fYLWeHKDjU
	 IA6sW0uKKDg7LWeF46LMLHSgqlC4QXEvp1gxmINSx3R2C/oCpMmVdsTZX3P1jTQGHnOzr
	 yXgZUwKApZ3Wdav1xzFD/WVeWOpBh9x9JYIhffzTMhpwSdpV22W1ppzPn1GXpDzvNWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jcMVexTx;
	arc=none smtp.remote-ip=95.215.58.190
Received: from mta1.migadu.com (out-190.mta1.migadu.com [95.215.58.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3145606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3145606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jcMVexTx
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ro9VE7XGMtGJmsM9mnH8HIatHqmwaoWhZDuLhhpiHfI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795157521; v=1; x=1795762321;
 b=jcMVexTxKDTegToAManw+obcFWicIYkyNWBbQ8bHPCWoQIHS8oeNmQEtnoc/bqLFcE+AsWYk
 E5gvqiIkV2ACvfJguuJ26FIkKntFy9f//Qh74GihVulthqtUrTbP1pAWX2XuMuoeTRR35PbGo5H
 /3N2qFbMT7WVqAGzErsSYReM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef437e63efd8efa5;
	Fri, 20 Nov 2026 06:52:00 +0000
X-Mizu-Trace-ID: ef437e63efd8efa5
X-Migadu-Flow: FLOW_OUT
Message-ID: <18426bef-b231-4685-bda7-665becfc6528@linux.dev>
Date: Fri, 20 Nov 2026 07:51:58 +0100
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
Subject: Re: [PATCH net-next v5 10/24] net: dsa: rzn1-a5psw: Fix MDIO clock
 divider calculation
To: Prabhakar <prabhakar.csengg@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 stable@vger.kernel.org
References: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261120002549.1908299-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Clement Leger <clement.leger@linux.dev>
In-Reply-To: <20261120002549.1908299-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/20/26 01:25, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The MDC frequency is hclk / (2 * CLKDIV + 1) on RZ/N1 as well as
> RZ/T2H and RZ/N2H. The existing calculation uses the wrong divisor
> formula and can set MDC above the requested clock-frequency.
> 
> Calculate the smallest CLKDIV that keeps MDC at or below the requested
> frequency.
> 
> Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port switch driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4->v5:
> - New patch
> ---
>   drivers/net/dsa/rzn1_a5psw.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
> index 7fd2652813ac..df3b3f75b489 100644
> --- a/drivers/net/dsa/rzn1_a5psw.c
> +++ b/drivers/net/dsa/rzn1_a5psw.c
> @@ -11,6 +11,7 @@
>   #include <linux/if_bridge.h>
>   #include <linux/if_ether.h>
>   #include <linux/kernel.h>
> +#include <linux/math.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_mdio.h>
> @@ -1104,7 +1105,7 @@ static int a5psw_mdio_config(struct a5psw *a5psw, u32 mdio_freq)
>   	u32 cfgstatus;
>   
>   	rate = clk_get_rate(a5psw->hclk);
> -	div = ((rate / mdio_freq) / 2);
> +	div = DIV_ROUND_UP(DIV_ROUND_UP(rate, mdio_freq) - 1, 2);
>   	if (div > FIELD_MAX(A5PSW_MDIO_CFG_STATUS_CLKDIV) ||
>   	    div < A5PSW_MDIO_CLK_DIV_MIN) {
>   		dev_err(a5psw->dev, "MDIO clock div %ld out of range\n", div);

LGTM,

Reviewed-by: Clément Léger <clement.leger@linux.dev>

Thanks,

Clément
