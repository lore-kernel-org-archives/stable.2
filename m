Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154518;
	b=YSUGaJc3R3S0wIv24oZErNKiFrhwnZBlZoLGiVpvI86GgALa8aoIWu932UaUmHLX4K0s
	 gkG/EbTXDn812St3aWv1cSV3+50qK+qVdX4coJHZ4RmwKteOh1qdlAWemG2tZNPhvUwKM
	 Rmhn5nG1DiQhTbmxc73KsvH9Ig3eJFQsM2bH6enIkT12zfu46NuRwRr1ShpgeSznS4Lp/
	 qFwe9hpUdTzGMPcEoxCqqmoTAgVYhi08ggexCcYzfbCbtKqmSr3TMlQtBEIaZ0e4XVvAT
	 mwHVAigKVi4YgoitNeVaEG9H2w/IRA527bDPcgWx0zBEaUPqpSSJD75LONwi5YEBXzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154518;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MfLnJK7wEETnWhNL1VJ9v2r2Cv1i7NwWvlx5qMBHHgQ=;
	b=hxusiBv77sNxzFXjh59Q94lY5rFM8mFL5bX8IiHBO1uIWbKlpFPmhh6ftGB6GXiGIBzJ
	 4cLY6iSE3jhCIbg7yjY5UnGV9FIUWxSWGlmO3mcOfflpSGSVGSwJalF7R+lC2QHYjcatK
	 w8DDyti8DlOLGEbSdMtemSwplO+I2DbG3ZNyQ/plxRwg9mTuHPkq3u2hkPc1u8qkeSm6I
	 vAtLIholrDgD26BSeQnyDPYWx69aFBHlgrm4irHzhv7jeipfq5dOp35+cCss0AoMxjzTn
	 y6keani2XhBkUS8bmj6hgshEiqjDQUaS2MnB/XsYf3C9pSo3FsJUHPnoFPVPSy7KIcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EcK0Q3PH;
	arc=none smtp.remote-ip=91.218.175.30
Received: from mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD3606A527
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FCD3606A527
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EcK0Q3PH
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+fYMFB+pYYrgt7QtO/hE8IfWmoajzI7XXfxThypRgF0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795154507; v=1; x=1795759307;
 b=EcK0Q3PHtXb4lcmZnMgLSMfUJJiq4KI/qSGiqe1yWgPhPBGj8bqaO+UU5WAL+9O0eKJjhCjL
 UmpGdzoPde10CKYn9UGW3LLRtkkM3Ue8KapJdkJsY/VVXJ55MdrzZwwL0UB3f7lUp5mlWKmkUq5
 82CJigjsqUtkv1oS/EEN215g=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fd24a32bd353097a;
	Fri, 20 Nov 2026 06:01:47 +0000
X-Mizu-Trace-ID: fd24a32bd353097a
X-Migadu-Flow: FLOW_OUT
Message-ID: <d0f5f347-a5f6-4e84-b773-f29ffcdab156@linux.dev>
Date: Fri, 20 Nov 2026 07:01:42 +0100
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
Subject: Re: [PATCH net-next v5 08/24] net: dsa: rzn1-a5psw: Fix LK_LEARNCOUNT
 write mode encoding
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
 <20261120002549.1908299-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Clement Leger <clement.leger@linux.dev>
In-Reply-To: <20261120002549.1908299-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/20/26 01:25, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The LK_LEARNCOUNT write mode lives in bits [31:30] of the register, but
> the driver writes the raw A5PSW_LK_LEARNCOUNT_MODE_* values (0, 1, 2)
> directly. As a result, adding an FDB entry writes "set LEARNCOUNT to 1"
> and deleting one writes "set LEARNCOUNT to 2", instead of atomically
> incrementing/decrementing the counter.
> 
> Use FIELD_PREP() with A5PSW_LK_LEARNCOUNT_MODE so the mode lands in the
> correct bit field.
> 
> Fixes: 5edf246c6869 ("net: dsa: rzn1-a5psw: add FDB support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4->v5:
> - New patch
> ---
>   drivers/net/dsa/rzn1_a5psw.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
> index 13c46cf2c420..7fd2652813ac 100644
> --- a/drivers/net/dsa/rzn1_a5psw.c
> +++ b/drivers/net/dsa/rzn1_a5psw.c
> @@ -5,6 +5,7 @@
>    * Clément Léger <clement.leger@bootlin.com>
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/clk.h>
>   #include <linux/etherdevice.h>
>   #include <linux/if_bridge.h>
> @@ -545,7 +546,8 @@ static int a5psw_port_fdb_add(struct dsa_switch *ds, int port,
>   		goto lk_unlock;
>   
>   	if (inc_learncount) {
> -		reg = A5PSW_LK_LEARNCOUNT_MODE_INC;
> +		reg = FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE,
> +				 A5PSW_LK_LEARNCOUNT_MODE_INC);
>   		a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
>   	}
>   
> @@ -604,7 +606,8 @@ static int a5psw_port_fdb_del(struct dsa_switch *ds, int port,
>   
>   	/* Decrement LEARNCOUNT */
>   	if (clear) {
> -		reg = A5PSW_LK_LEARNCOUNT_MODE_DEC;
> +		reg = FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE,
> +				 A5PSW_LK_LEARNCOUNT_MODE_DEC);
>   		a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
>   	}
>   
> @@ -963,7 +966,8 @@ static int a5psw_setup(struct dsa_switch *ds)
>   	}
>   
>   	/* Reset learn count to 0 */
> -	reg = A5PSW_LK_LEARNCOUNT_MODE_SET;
> +	reg = FIELD_PREP(A5PSW_LK_LEARNCOUNT_MODE,
> +			 A5PSW_LK_LEARNCOUNT_MODE_SET);
>   	a5psw_reg_writel(a5psw, A5PSW_LK_LEARNCOUNT, reg);
>   
>   	/* Clear VLAN resource table */

Hi Prabhakar,

It could probably be worth it to add a small a5psw_set_learncount() 
helper that contains these the FIELD_PREP + writel.

Otherwise, LGTM:

Reviewed-by: Clément Léger <clement.leger@linux.dev>

Thanks,

Clément

