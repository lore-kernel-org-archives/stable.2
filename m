Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D793382CB;
	Tue, 11 Aug 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476571; cv=none; b=KiU/C1bNr4Rd9eeTh6dBLJ4ZMr1unq9OApsvYXndcAIHvzTOcjT2QNlTOHAOnbI9HsMxJPpUtxHE4vnePvvyg1aPLG+T+czsl89950/O/qNia82hASF4bRcGWuQR8TUJrzHRgixgMnwKCiV6+/EXXqqL44DX70/22LWIL9Abb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476571; c=relaxed/simple;
	bh=cPDAhT0Qagei4vQIDOXKHzRYx66XDdgXWkxENJy2ksU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mmCeUKRBCUoyQSd119pALFE7FIL93TOeQadwUYWf6+DSTsupq/RLf819eNxDc7S1t7z7otfhLy2zmhFOzTTIE2qnqbyrc/MfYenCJygOBUEzmaBxWPCf/+wtQyR+QLfhwJUQwqRlrj9NOllLbghOS9SLpwH16uTIVanSmJn5oCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=MEZI5GAi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q6yoq3Iq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="MEZI5GAi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q6yoq3Iq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D2451EC017A;
	Tue, 11 Aug 2026 15:29:28 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 15:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786476568;
	 x=1786562968; bh=W0kYAgqlA0wFcX3jimEcDwC3Juwj5zioDaW48VzmNuc=; b=
	MEZI5GAiEW0v+azSae7w7UR420ocoD2oiIuj5TKM39UPvHaK5NaIAOYFfC0Lzvyj
	0YOOpZy2FiI1tN4gJWH4HEQ+keFXvf3REGi7cv3ebNkbs5Lrv8jG532hsZBsB65I
	IY/CslR82aY3z1IfF4uC55M1gr0ky37jBdVB02LsfQUtevQ2l4byaS6mEEG7tvj8
	IURYY5A09aqEO8vU6ovJVaQXbj1YROC035ns0LMmzjF6vJcgeoKSyMCSznoy5Nlk
	aEHbe7N08+wHQKcTSEDgCw3V3qQsQle9ejaaGoFvPsPythySmnS4w2NYY4fTTMYV
	u3Cz90otpfFhYVOcW9AQfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786476568; x=
	1786562968; bh=W0kYAgqlA0wFcX3jimEcDwC3Juwj5zioDaW48VzmNuc=; b=Q
	6yoq3Iq0KZgqB7eg/kY+zTqTEKsvvn5EqFfwTylaMeYuFv1gVpejKsDdLFK1rLXy
	F6mQsqKOqlhX4KkmaesEHS9qczMUWUcArvMFQBJ+pLhj5n12duW60Ih25FAVTO7r
	VlaUM6c1HOfADrOrhz8awt23qRNcHm7dyS5LZTvd4HP0A0nuJrJRQL/fvx/+Ubnp
	HDpoG3icS/a10NuidC1eaTre/I0BFnl3zVOPKl9wO0OcNEWsgRv2YqZNHA75wcoY
	EqDBtak2VnmOI9yod7LSr814rW9P48seYkQNlbWaJplhRpb5q7IrKz1pZhvEc4eG
	tdtjhKIVcj/XW7RsR+XDQ==
X-ME-Sender: <xms:F3h7aks1XsjGus3GtYdrPRvtnvyHkJZmTNmLvWCwOhTxfkxSgxTONQ>
    <xme:F3h7asTmsPrB1VT_wQyt_OiOitXDUili2lP2KD1pV2qdk9LY1Jcd__ReHlp9Z-ahg
    ssUCxq4B-DTo8UgGs8x33_63B89sEH0G8UfIi9mWqspzJ5oFUWYjIE>
X-ME-Proxy-Cause: dmFkZTGjpPG+ohPDuue/ZsKnin9jXoENRu7hTX9Ft1XaCuZizubmG9ignzgktUogMp/Cdx
    o+MXfgBU6uen+M6UD8kqT0J0FYu/Ha19LzqPLJm3zlWssLloE7gDLhVQv7ccqW8DuYWZq8
    4jGMrEiemaraoqC+PjnjEuoSMFRhYonvCCS33OTDcaFMSFhkjCo3nrhCbzaXSOIyBZ/2XS
    OF1BaUTiMAZK2RGRrAewdcrJtMQbj3BCyUkDFiVR7D6MeI6zEd5oRNt4AI66vFfsfwAKN/
    5JbFakgQu7gWVV3HQrdjEQddUg2W7p0TtbK7jsxQzSeUhystj++BxkwWN9nFg1yQXRo0Mt
    UwGKc0TiXjw6CjZSHuGMks4bdUy1BzndUxZU4JDc/4SXl+4pimU/InYqAgp2lfW/CafKph
    74mR1LNWy/0xkjXqhbS+rfGN0I7Vt1nw2IO5DzxK75xt6rjeulGayTJK0Ff2AQEaq57O6/
    BY/atQqfK2HL7RvE3S0/uWd3L+ACdLyaMlS3Ts1FRSz6ZsmIEA9K2rRk4aRu0j1NjwboUq
    QoU1EaP37yScbtFMuswqB+bbWQvFKNZKyGcqTt/nt2br6Qc74nyJuRsaSr+BJMG8P7M8z8
    rhpXqoBvAIa0IFT1mVVouekFrSykTqCWgIi0o4r6jZ8vEpQUJetfAA5tOFZg
X-ME-Proxy: <xmx:F3h7amLPTGi5MKhjQ5KrILDKUfCl4DOPHI1bg2OM2v-Yb4VhjpxrIg>
    <xmx:F3h7ajEO66I811kVAtWWaxkuD-z8X6NrKIRSPBLxG-pdidcsmy7-Eg>
    <xmx:F3h7aq9AgaF44xTQJfdxQJ3qch5QF7-AdIQaci5dsb6Wz0UejNiSRw>
    <xmx:F3h7arJ6G1mjwLeEH5DNqqFP7E8Lu7ggn7jtHHYwSNPuG-bIJN0oSg>
    <xmx:GHh7ah41xLqEz07npF-LAZ3Ri1KbQ766jy-PpkMgM52Cuo4k7edhvrl3>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 83E922CE0072; Tue, 11 Aug 2026 15:29:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Azv27X2kd0kg
Date: Tue, 11 Aug 2026 15:28:57 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org, "Mark Pearson" <markpearson@lenovo.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <5f44090c-5b08-49da-a2a7-2ce8f0ede740@app.fastmail.com>
In-Reply-To: <20260810120556.149416-2-thorsten.blum@linux.dev>
References: <20260810120556.149416-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] platform/x86: think-lmi: Fix certificate thumbprint sysfs output
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks Thorsten,

On Mon, Aug 10, 2026, at 8:05 AM, Thorsten Blum wrote:
> cert_thumbprint() already returns the accumulated output length, but
> certificate_thumbprint_show() adds that value to count again, making the
> next line use the wrong offset. Errors returned by cert_thumbprint() are
> also ignored and their negative values added to count.
>
> Assign the total length to count instead and propagate errors correctly.
>
> Fixes: b49f72e7f96d ("platform/x86: think-lmi: Certificate 
> authentication support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/platform/x86/lenovo/think-lmi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c 
> b/drivers/platform/x86/lenovo/think-lmi.c
> index e215e86e3db7..441fca37b523 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -745,6 +745,8 @@ static ssize_t certificate_thumbprint_show(struct 
> kobject *kobj, struct kobj_att
>  		return -EOPNOTSUPP;
> 
>  	for (i = 0; i < ARRAY_SIZE(thumbtypes); i++) {
> +		ssize_t ret;
> +
>  		if (tlmi_priv.pwdcfg.core.password_mode >= 
> TLMI_PWDCFG_MODE_MULTICERT) {
>  			/* Format: 'SVC | SMC, Thumbtype' */
>  			wmistr = kasprintf(GFP_KERNEL, "%s,%s",
> @@ -756,8 +758,12 @@ static ssize_t certificate_thumbprint_show(struct 
> kobject *kobj, struct kobj_att
>  		}
>  		if (!wmistr)
>  			return -ENOMEM;
> -		count += cert_thumbprint(buf, wmistr, count);
> +
> +		ret = cert_thumbprint(buf, wmistr, count);
>  		kfree(wmistr);
> +		if (ret < 0)
> +			return ret;
> +		count = ret;
>  	}
> 
>  	return count;
Looks good to me. Thanks for the fix.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
