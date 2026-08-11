Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919E4756B8;
	Tue, 11 Aug 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476605; cv=none; b=WVHlmQEEd2Ms2u/bVTjXALBwtFUjgY/vDPz3M1DrGPNBg7TSSXv7nqUpRjHme3my+y1QA2/XGxTRBSJMhdZ+jr1Jp+0c4f6jpA0FDGlZ92vlvTxEHOZnGsLdgMlOn/5v1ulitzX/kHHPdzu0cErIp7kag2AfnrWzm08YjEnzxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476605; c=relaxed/simple;
	bh=YNZL2ufSlEy0CLqIsAH1zp5xzwLejlN89SPjnzWXfi4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tjlH3IAWNPcx6dB0Wn+Dn1yLQl/sqa2Qkc+2j5GOcGSWKJChiG/vCpz9XEt81e+SnqyPsbTHEnUVqMj3UBddH9Z6u1XSyP3A0h3SsYtDhKMvU8konNQuiNR4I1Vq5XxtpsX267W6fujEFcNBJ2qqo6RPk/nfRWI5uX7YR9KkP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=SFhpzzD0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=edV2Zf/U; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="SFhpzzD0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="edV2Zf/U"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B19B814000E1;
	Tue, 11 Aug 2026 15:30:02 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 15:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786476602;
	 x=1786563002; bh=e0xF6madJv9uPFYJr46rMqOvvTrgBfAm3UejIvfWZCs=; b=
	SFhpzzD005vlrprtxsb4iCKgOouM1PXv4a5ViLiaT6nS7v4VmVbaEG021Gx2Tcuv
	78I37f5dm/i9s09bavIoXO7GERGWPDxHQz6DJautpwaxGxdWqHI97iNhapSl1ghA
	c/8Z9rvxDjfLsUvVKMnS/TlE7xJ5Sb2S8NM2htt47AVAuOSCc28RtEqXcoLFoP8q
	ocr4KcaxeLqngEo4XD0XlQllLA4gi99E7nGi1WUcdcZujU+IzJv8cV+C1bQ0Ufqd
	U4ObTHrvgCyPGSjQa7NkZzR6q8uesaqLTVd94/51+JwAIDplDg9Hpcm8CcQCgEc8
	iexaQkJENGTeQsSB30QKkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786476602; x=
	1786563002; bh=e0xF6madJv9uPFYJr46rMqOvvTrgBfAm3UejIvfWZCs=; b=e
	dV2Zf/US7DAsUJs0uLcvc3bKdfZmYgq10eONjb9nmv/Or42QgnOfJ0oetjC2OdQZ
	Hzp3oJWHXdVtH7ZC4JBVCYZjXaK031fjQ+IpvK7ZRDKeGcQ6tzlO/Wq1w2JOHRSE
	AjfHvYGKx7mZHwqcadyiDLByDM2e7ew3HT3Ir7ptYx8QxMF9JeYEzOrxGy0d6k+h
	pyLxXr+319zlqUj9mjC9UgJy8L3JP9RX8OQ6Hu9vLEcq9sb1EVf3StrRAlmNo9QA
	M7ucE3C1LYxpWjv2xdmXU+hDfWNF1xElcLA5L6WsxiZLPScLhZR6i1pWORrbw3De
	0BA4VP2TZE4LXuBc+2Igg==
X-ME-Sender: <xms:Onh7agdQbsTPewEFE7GqYzM8SuWg781LERjD9FlVLqQWzpwj7OKS1Q>
    <xme:Onh7atAw4XKvBjzR1v8lkFILL3Djlfqngd8SI2DZWmWOq1EcLIWG3TFFZPUBGpPjX
    u94Rpj4ur1HGCjkX3FRhFVJ2vuNhQ2x4NiDvnHN9r8Vk3JU2Ameoww>
X-ME-Proxy-Cause: dmFkZTEBCmee97f3uzfuWd2xPwnnjUYb/SDKXnLe+rohXuyDJnHYw5Tiiz6rISdqUMwCrM
    jSm0CB7qY2gVoFaxoiKz1fE3YQBsf72azdaXGB9hy8qTJ6zE3qwOp8GiP0/g9hdQ+Y8a+7
    mLpjOWGOztJ7wHyfCvhq/+2SBeV2joBsFm1TlzvMXPyuQbxoSlOc+Soys7xpORnWsGpH3w
    SsIeSL2b+m4lqZuW0Q7PqMpr9DrIcJjEgCqFR4mLIylOFLqY9n1aC6V9o5GpWZziSZlKru
    4lgfQ6OcSfyoLvfp+WfmkQyBefFGEFj2Z+JdxFK8dHKlrycZ/obRE18s5CSYqKm0VrrVLD
    pAWNKYd6un3RyYyeK3hfYXmeBKbhKe8X9oLpBGy9xnkPQT4m6nzusoLMFwuTReNq96c7JO
    jeSp2dg3TURrVyCXYpg1A0r74lzWR1XUFE2JMcDEVHZwDtYe1nHE394WOrODvxm8/Xr9Pk
    nhaUii8iuIvWWTpMMFMLbG7RVQfgP/+gQyywNYzZdkLJhjSCvTII3GcMsBjgmRofgpmcGe
    r6ozEvzK/1iioLBv/ifHuJM4H47lwb1E0gxWMLw55Efsx+1E+EVdAwkuBupVReJZmAcyBa
    tJIHGK7bjFTWsCI1eeXW42yZogsd5Pa3NvO9oqmE8SjblxjSVcZK9aZvxi7A
X-ME-Proxy: <xmx:Onh7atwOJchdyCSy-Uu8JzsdWcMEPj_kBKnSNFjIqZzMC0BwtVHL_g>
    <xmx:Onh7anQZ2nJlj60Y3MMMONE02tVIUFuaDC5U0QT3BX14zE_ku-jxrA>
    <xmx:Onh7at-c6RAJGXo59CSWXAzdQ4NOcX5frasFU6j_W3j83llylS0GnQ>
    <xmx:Onh7atsitPbVFAC5LgnYWOWif8KASz-S1YUfE_SXVrM9g8etAlYm3g>
    <xmx:Onh7ajWojBviWBksCrNMH-ScZu5LaM5y2nHbC-GqooRdh6Dt7jpsSGxr>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8FDC32CE0072; Tue, 11 Aug 2026 15:30:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFLpGHKBV9SR
Date: Tue, 11 Aug 2026 15:28:46 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <9068b9d7-09bd-40c5-b288-76d4d4e25c31@app.fastmail.com>
In-Reply-To: <20260810204106.165895-2-thorsten.blum@linux.dev>
References: <20260810204106.165895-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] platform/x86: think-lmi: Free system certificate signatures
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Aug 10, 2026, at 4:41 PM, Thorsten Blum wrote:
> Multi-certificate support also allows the system authentication object
> to store ->signature and ->save_signature, which leak when the driver is
> removed. Free the signatures to avoid leaking memory.
>
> Fixes: 5dcb5ef12590 ("platform/x86: think-lmi: Multi-certificate support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/platform/x86/lenovo/think-lmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c 
> b/drivers/platform/x86/lenovo/think-lmi.c
> index e215e86e3db7..e3e683bf3469 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -1456,6 +1456,10 @@ static void tlmi_release_attr(void)
>  	/* Free up any saved signatures */
>  	kfree(tlmi_priv.pwd_admin->signature);
>  	kfree(tlmi_priv.pwd_admin->save_signature);
> +	if (tlmi_priv.pwd_system) {
> +		kfree(tlmi_priv.pwd_system->signature);
> +		kfree(tlmi_priv.pwd_system->save_signature);
> +	}
> 
>  	/* Authentication structures */
>  	list_for_each_entry_safe(pos, n, &tlmi_priv.authentication_kset->list, entry)

Ouch, this one is an embarassing miss for me. Thanks for fixing.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
