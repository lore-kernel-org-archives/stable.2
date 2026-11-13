Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529218;
	b=EctPZRS76BushtNhrLdcuKoeMEVLRG68h3AR5Ty3NDmChNJSZ1CmWASmY/qub0IXGPhk
	 RNgusmtoZ5oh65P+Kd3x/8ewzzEI4+MHRvsGwh6/WjNjH9MglItS6Y7xXoZh6ij2tOWFN
	 FKEiZ1bx0NMjtuWJA+rd8O5iiJlJ6rTkvAcfHFABTNf3h6ez3fFsEBpgpvNiCDQwJN1L6
	 T+6LAPFPud9JHbTwcThROt38FMsogKtlPuHTowhGVHFcnlrc3zY9rbcfvAJafSMSwd7Mx
	 nyypxLTn35M3S1nTLoprtkGlHB/h24aUBDpEFZLW9KKTxNJiekEfUOWidvYDfriFlGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529218;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=irpFSAngvQPvQ/Z7PnpTpBU+snu8huRE0DfEz3rgdbw=;
	b=aeJGIHuoaBWn0LqopJzWrdXfun+zBpCDNnxUvAEmlk6+TMKuZSYAA4ah6Wc7JOYP7knC
	 WpnSIJUgSlS78OkIifMImW0lswcMXCLdM4IV3g282VmyB80mJK3M0IkdS4bu2JShSZhOv
	 dZFBYnghQObjBV6GuPzhsBvrDVxDtdyOiXJDVBHL7XhaFoIpR1wj13GS5le7tigtf0CqS
	 Zz3lF9KoD3oj+Wu8lxdeBfw9aYJLJVyQFAhSOiLFaBSS1D5GMecnO7pVxsvEkXxAy6n1D
	 GwA7T5Lr+3zdr0T1I4/BfmlzM/pYSlKu2+tzQg3ftzWy5TB5efRGk0Ysgtb8NtXmTYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WkHgt//E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD4606A321;
	Fri, 13 Nov 2026 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkHgt//E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A081F000C4;
	Fri, 13 Nov 2026 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794529217;
	bh=irpFSAngvQPvQ/Z7PnpTpBU+snu8huRE0DfEz3rgdbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WkHgt//EGCBfxs6kZIcK82f1xFpgitlyh6zLAxMYyZ2RSeiONeZFOWh29Z/gRy7dQ
	 ACRxIyyZPzGD0zKxI810GUHRSQmlGY4u5L826OLvH+qDmSu3+Qt1nPojLaYZUgsyhW
	 8bq+6+ke3OHug1DA5A0wsUJmLJL2n1FqCv5EppnaflTsz6MawSQHGmBWcBXVb+3WDo
	 t4MAek9n9A/Skz6hSceqU0ydznDgmdjCm98s5UQA+pmS+dllVNvKguTa7PzDN0F6bS
	 twCptfeX8v2Bl9dxSO66hArcM+HD0r9EDZDtu9AQicIeut6zZAyzWKq/1XHltcewOI
	 JG5weBcb8E3Mw==
Message-ID: <589669fc-4cb2-429c-9960-1c89efb597f9@kernel.org>
Date: Fri, 13 Nov 2026 09:20:15 +0900
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
Subject: Re: [PATCH v3 1/4] ata: libata-scsi: reject reserved bits in 32-byte
 passthru
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261112220120113cXLhRk6iDVvhfgGPoZ5vJ@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261112220120113cXLhRk6iDVvhfgGPoZ5vJ@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 23:01, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ATA PASS-THROUGH(32) has no MULTIPLE_COUNT field. Byte 1 is CONTROL,
> and bits 7:5 are reserved or obsolete. Interpreting these bits as a
> multiple count can issue spurious count mismatch warnings for multiple
> commands instead of rejecting the invalid CDB.
> 
> Reject nonzero byte 1 bits 7:5 with field pointer 1. Skip the CDB count
> comparison for the 32-byte form while retaining the device multiple-mode
> check. Also point to byte 10 for invalid PROTOCOL. The 12- and 16-byte
> MULTIPLE_COUNT checks remain unchanged.
> 
> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

One nit below. With that fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +			/* Compare with the cached multiple count of libata. */
> +			if (multi_count != dev->multi_count)
> +				ata_dev_warn(dev, "invalid multi_count %u ignored\n",

Long line. Please split it after "dev,".

> +					     multi_count);
> +		}
>  	}
>  
>  	/*


-- 
Damien Le Moal
Western Digital Research
