Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA04DE703
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070462; cv=none; b=n3SHKeTf3MlIkHAyH74hJHKbYaWd000xg4GZObZSuDmhyLagTi0T6c0OEoZAAYc6QW5sMsxJUBToWhYQLY0MtQN7Ph2VR+EnocNaIsc+NO6vzucur8bn5Vy8vq35Tw9QzMIUS6sCJfgdCneWgoPfbY4EJMj7DmRrrOLWVLn33gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070462; c=relaxed/simple;
	bh=2CUH3YGiPlXy555Q9SI3ZYnCZbH8YDJQaUSBvfvqZ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYQvqP5X3oMOKpf7TmL8V4xLCgQtZulMaXrsYr375mZ2MYRC7KZ7rilMT2xnRsxPUHRZXRYRtig8cAjZ2IKmcs7cQT9C4xdfcK1MCKbo8C8lMTTZ1HbUxGh6RGFVUxSYn4t+RCW1ZiPGuc0eMpC7GjJexwLiWHfU+8Ec7zGx0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvNBStGl; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvNBStGl"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so1623046f8f.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790070458; x=1790675258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1mHA714llFxRbL4YpV3zzI7qdHUQEj56NbS4Oyhz2TE=;
        b=UvNBStGlptbsfoizP0M7WPR8TBH+UhYLVyjoEPDRLeSoLNQuh7GLHz3T5/m0+UmBNZ
         RHrrzsLV0K/1tL1nA+hHnjigNFBMWMqOHkC2hAp9rehOuAlFe8SvIs8Z6CpW3d6rTbbu
         qUN4yFety6ERn2Pq27SISc97Qgyi/FNkA/2oV0hESNH3CrGFm1JB7EYRbfKMluJjr8oK
         ttR4FN9+EvyTCRmk7aGWOVeyliElH3Fme+P3KYATNqyFatLBn3k0NH1gwluMVxzIirTx
         DTowTIQwxpjvhHhSZOLcG5y2+hQWEt9qDuVNyafBzvAUvmydtwW4n5iPhqIUqR/Rgbej
         XPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070458; x=1790675258;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mHA714llFxRbL4YpV3zzI7qdHUQEj56NbS4Oyhz2TE=;
        b=0lf8TPo7WX8nB9PHUf2pcdlCoLPs/UuwdXs04jGWNDpH3vtXeRh2Pi0COrcCuRaDFB
         Yp2y6hW8vTFn2ohHc/vFKqXZyC1M5JUCzF5w1yF8Fzsyv6Vva/CWMIHHgBylSuj8W4jE
         +NqnpA4BjzcKiV1pfnJK6zwmgxQtZ8o1s3r0ESNoMKKGrNevf+pbvpIE8T5eoMBlcusP
         WzJvusWoL0UU4s1SnMfznFdJdClCMaLSxB8j6VnDJOQond7MVyjvCmS5m4/FWmiSKIQL
         5AmfedWT3LTIK53UrDnMvWYwCD0bRTVAIUUgtd7Ue05CsrCGxtst7lHwUhi2GYmD9dIb
         Ha9g==
X-Forwarded-Encrypted: i=1; AKwUvByiMxLg0lj/8sCmSEpxtCIAh/ZPf67oXUBfgKDeh3PxqTi2uQxtPtntC34SDqhKS15Oyru9z7E=@vger.kernel.org
X-Gm-Message-State: AFuF++mypXIKcuikZeXCs8GsBGLN0WkUd4vvqC4oZ1oV3LRL/pGX4psq
	8BECRSQfkgWc7FqRDMmTZUisGjAnzj+cEZnkGQ3tKFMDzCQ4NbFMhdOK
X-Gm-Gg: AYBFou3o2vm5GD4OBZFz1s1deU799YMNuTWDlIWpXx40761dGBp4JQz0FVUFBD++e2t
	Lo+LHvNHlvrWIW11LRKemYYvaPd0jWeH7CZVoZJWobk1QQYV0VtoyECUiByldszhPo2jxPCTBlE
	xy0i1x9pK9lm4qcVzYfBVrnapvR2it7YoMYd1TxOgMGGXMrKL+1Yyp2Gd3TlvUbncShloVvGBXD
	Vm+z55q3MBE5TSgxmgH9sL7ZXhJWztlqWF7jbe3Blz9Seu1IYMCd9czuYBKyWjX+LfZsdcgy0vX
	yftyPprBDFgjkLKCttI/RaVq3wWumYm8mER6izXJCriT9DzXI6P41f4pWSK9da1+3Az5pFxY4JL
	8o2hg+zlJ6HHfOrjMWFXuLhn9o0LzOsyQw3LsxR3LdNXSTv6+mdn9Y8/nb3hoqLndosxG1G/TYT
	37LLN6wbQNnpdT63xrDA2nCL7hOWgib17VdrWZcZldLwq1vPur61i+cCa/dovM8iEl3iAucOAjs
	t+VYq1FyPaj2aeW/Bs+U4F+4ROnGqNhqj4=
X-Received: by 2002:a05:6000:1a8a:b0:487:62d:37dc with SMTP id ffacd0b85a97d-4871e269cd3mr21320913f8f.32.1790070457566;
        Tue, 22 Sep 2026 02:47:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862773ee0sm3708938f8f.6.2026.09.22.02.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:47:37 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:47:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Harry Morris <h.morris@cascoda.com>, Alexander Aring
 <alex.aring@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer
 overflow in hwme_get_request_sync()
Message-ID: <20260922104736.0e7e20f2@pumpkin>
In-Reply-To: <20260922093126.141969-3-benquike@gmail.com>
References: <20260922093126.141969-1-benquike@gmail.com>
	<20260922093126.141969-3-benquike@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 09:30:24 +0000
Hui Peng <benquike@gmail.com> wrote:

> In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
> stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
> unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
> bytes into hw_attribute_value without checking the caller's destination
> buffer capacity, overflowing level on the stack when hw_attribute_length
> exceeds 1:
> 
>   BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
>   Write of size 16 at addr ffff888001907780 by task init/1
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x70/0xa0
>    print_report+0x153/0x4c6
>    kasan_report+0xf1/0x120
>    kasan_check_range+0x125/0x200
>    __asan_memcpy+0x3c/0x60
>    hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
>    ca8210_get_ed+0x9c/0xf0
>   ...
>   The buggy address belongs to stack of task init/1
>    and is located at offset 48 in frame:
>    ca8210_get_ed+0x0/0xf0
>   This frame has 2 objects:
>    [48, 49) 'level'
>    [64, 65) 'lenvar'
> 
> Initialize lenvar = 1 in ca8210_get_ed() and return
> IEEE802154_SYSTEM_ERROR in hwme_get_request_sync() if
> response.pdata.hwme_get_cnf.hw_attribute_length exceeds
> *hw_attribute_length.

This function is silly.
There is exactly one caller, the only valid length seems to 1 (is zero valid?),
not much point using memcpy() either.

David

> 
> Tested in QEMU with KASAN enabled by passing an oversized
> hw_attribute_length response into ca8210_get_ed().
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v3:
> - No changes.
> 
> Changes in v2:
> - Split out as patch 2/3.
> - Replaced the temporary stack buffer in ca8210_get_ed() with lenvar = 1
>   and an upper-bound check against *hw_attribute_length in
>   hwme_get_request_sync() as requested by Miquel Raynal.
> 
>  drivers/net/ieee802154/ca8210.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index a990a0f..8aa7ffe 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1677,6 +1677,9 @@ static u8 hwme_get_request_sync(
>  		return IEEE802154_SYSTEM_ERROR;
>  
>  	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
> +		if (response.pdata.hwme_get_cnf.hw_attribute_length >
> +		    *hw_attribute_length)
> +			return IEEE802154_SYSTEM_ERROR;
>  		*hw_attribute_length =
>  			response.pdata.hwme_get_cnf.hw_attribute_length;
>  		memcpy(
> @@ -2027,7 +2030,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>   */
>  static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
>  {
> -	u8 lenvar;
> +	u8 lenvar = 1;
>  	struct ca8210_priv *priv = hw->priv;
>  
>  	return link_to_linux_err(

