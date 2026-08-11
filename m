Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BA3382CB;
	Tue, 11 Aug 2026 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476580; cv=none; b=SqGe+arRR7/ytgJmxzFRWc9HQt1DlfsTerlrzTR54fyPpTgQ+QdySCRLj1ytvmRyRWAzEJe7k1N5E09vUJJedMtLa3PvbLlCbBFju1ctyADISXnz/4hjLCD6lr2Euu5QR2q6jpFczaZDq0pln+c8FzV/EbfgBeVPRDVp1he7DYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476580; c=relaxed/simple;
	bh=/TVTsv/JDA5GDpCVwGK8jBtBJMbNQvua97bmqQb+vvM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JDTKRQlct4rxyEuI1uEzTfq1Ms9KLWFNC9dpaUzsrt6YzRo9CDxHpdhpLtsl7HAWS9/DINtNd0CsSXaBJagBY7J1qEmZzMry/iKp0reNTPDaDc2s9IyiSsxfvr5LW5JgjV54WZgzcgtkGBp1A+VLpLi0A1SZ0xaPB+cX+NwYkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=ivgHvNQA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h1SNYEXi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="ivgHvNQA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h1SNYEXi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFF7C14000E3;
	Tue, 11 Aug 2026 15:29:37 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 15:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786476577;
	 x=1786562977; bh=RoZKUScy/bTRw/ISa9+60nA/jsMxL7OAANP1TmdBSqw=; b=
	ivgHvNQARnx3KS3AIgKlBjxjFnTTOR4IJ2TODKVcSEKjfRU+nw0Z00FbsklSEhT8
	CJM9i6IT1xMH7AjaGgze3jY7IwvMdTTyNTDMuhMUkghJYWkmoytESJ6aw3NLaXBa
	UQwzVmVMlNRC9gzb56WiGvVF8iSLVtbwIQY4tVJvt7oKTU0KAAyR7c9PjBUmnFm6
	6eEu7XilwQUFduQAQDBeCrU4yqOfTVDOx5o8mlBcz3xMjCcUpvlGgmA/5Nu+B0cx
	l1FZw8BISIhkomzaI94aQWRCAdf9eCY+aLhbyuIreT1RdzF8i2GXxb/oYJgxYHn1
	hrnSEIKEpJjIwFvqkVhU3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786476577; x=
	1786562977; bh=RoZKUScy/bTRw/ISa9+60nA/jsMxL7OAANP1TmdBSqw=; b=h
	1SNYEXi7F/2XM5cVz8ZeTTAp7mju3cUnzes5ekD2f8CPVueKBhUpMPRxUmr0NaHU
	i6FbWXik6yJByZYirZD5Gj2OZiDyXHvYN7dg/Z0RstPfddZ/2E+qowP69Pu2MzxE
	owQLZVBR4XIJCmaMpkU04iVJOekQNTeKLW7o3/+j0Bte3lT/xaKpWVrcogxkDJ+d
	wPPxqGrbaAH2CEKJD+SotSvW+dW+DY1FmZ/i31J+cxF9ELIIajaLgM9Dj9u5LzBj
	r/C0MWZ8R2bT4B7RctM4FCmh2vpY4brrBu7I/QbUpRktxB5Mas8KBkkJnTOiT0iW
	4jPLuhoTlI6IzbcG30LqQ==
X-ME-Sender: <xms:IXh7agmo2FawyDZHOpEJyUG1Gopn0Ed5_rwNro8VK5oPz8zIocspSQ>
    <xme:IXh7aqp1EjPSVtCBLQz90PYO7rFoYB6xRbS9Z1aV8dw7i8YKtbJInrh6S2g2AwDwz
    SjJmAGLgZHg6EzU5h458LFaVhAnDbZl6cpxS-IYd-P-bi0DCmQ8xX4>
X-ME-Proxy-Cause: dmFkZTFUvjaeGVStv4f7WFbB7cB5PYNg8NvgudaEG3f/rq7N+ESnj8BdmKobzcZ8+yvUle
    /O/CZ2pbyVS+uCSJ5rFfY1/XqNAkS6vom6JtIAWdJoCYN5e/XS21fWE5uGEg/xw3wcFmPu
    EUK6QzDX9HX21o2faVboLSo/Q9hkxZcBUxoVkl2jpawZqE6qwWLMLBeKaVIZ1ABL7fW4WS
    0FbQ2gYYqdEnuly9E3L9hq7ZByorgKcCpVTKVd1rC3iiEI0nDhjUNJsCyb7V80ckLVLHRN
    o1f95331OZ8IxMQXgTnAVdFZG3pCzxGJ5tByCI2C0ef4lpjv5M8vvRqL1t3Xhq5Ala5KQ8
    6kf4YA1sT2UVSZ4NPd0PDTXtVONhR/mQbanZ7O1T7oqmNkCMOHLPPyZs9U6zuaZTZJEbS2
    cdKW//NB7OUixvrY90Sp81QJ667R88FzCUhKiWbpXtOMONvJmuQSjkWoKHVBZ2iqECV9w/
    lNMXk5hDaY7CLZywktUiebJa+IrlsHReoWgQtYtvBKX/HyPJxJLJcg6EHf9eQj2dij4NuA
    m/95ecYFaogXI8ymDNtp8JlsBRMrCvEk6WL408AuBeM8g81n2LBt15YONDyHZYQiBHqR+u
    dhahFRn50CzWn5ipXq1nqqogR8HoqZp1fqpWCS9JkDMYfOdOE1ts/Ajk/3Hw
X-ME-Proxy: <xmx:IXh7an5qz8vo3v-09rOubI0ZnvuwUSw86H2m7A4vteM4OiEH8Dtf7A>
    <xmx:IXh7am6pDgaolPKVxVogzDE57iPI5Ah_HteNbsn-yyB9J6972P6C7g>
    <xmx:IXh7alGGHX4pL-tMUGFvHP8XY4yZoYJOZay1sF2ROtb6b7PTdkRitA>
    <xmx:IXh7amX0oiod5LwFnPuJ4_u8FFkbFdAp246KkZ9aU-AFh7u8qtrzCQ>
    <xmx:IXh7audQ3y9VrfdGgWyTcEeadQU_1P5_Rk8FFbEU3uluKyxOqF14Mvrv>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B989F2CE0072; Tue, 11 Aug 2026 15:29:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApPKnL0XRmUw
Date: Tue, 11 Aug 2026 15:29:16 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <a4d9ab1a-683d-49d3-93c0-d533fb96bf27@app.fastmail.com>
In-Reply-To: <20260810120830.149804-3-thorsten.blum@linux.dev>
References: <20260810120830.149804-3-thorsten.blum@linux.dev>
Subject: Re: [PATCH] platform/x86: think-lmi: Keep pending save state on failure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On Mon, Aug 10, 2026, at 8:08 AM, Thorsten Blum wrote:
> In save_settings_store(), the opcode and legacy password paths do not
> check if saving BIOS settings failed, but instead unconditionally clear
> save_required and set reboot_required, losing the pending save state.
>
> Check the save result in those paths too.
>
> Fixes: 318d97849fc2 ("platform/x86: think-lmi: Add bulk save feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/platform/x86/lenovo/think-lmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c 
> b/drivers/platform/x86/lenovo/think-lmi.c
> index e215e86e3db7..cc0a85d1b832 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -1347,6 +1347,8 @@ static ssize_t save_settings_store(struct kobject 
> *kobj, struct kobj_attribute *
>  					goto out;
>  			}
>  			ret = tlmi_save_bios_settings("");
> +			if (ret)
> +				goto out;
>  		} else { /* old non-opcode based authentication method (deprecated) 
> */
>  			if (tlmi_priv.pwd_admin->pwd_enabled && 
> tlmi_priv.pwd_admin->password[0]) {
>  				auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
> @@ -1363,6 +1365,8 @@ static ssize_t save_settings_store(struct kobject 
> *kobj, struct kobj_attribute *
>  				ret = tlmi_save_bios_settings(auth_str);
>  			else
>  				ret = tlmi_save_bios_settings("");
> +			if (ret)
> +				goto out;
>  		}
>  		tlmi_priv.save_required = false;
>  		tlmi_priv.reboot_required = true;

Curious - have you actually hit this condition?

My main thought is that if the save fails - chances are that something is pretty messed up and doing another save isn't going to fix it. Most likely you're going to have to reboot.

I'll see if I can get an answer from the FW team on expectations - but getting straight answers for error paths without a repro mechanism can be tricky.

Mark
