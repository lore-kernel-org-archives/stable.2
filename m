Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5646B23909F;
	Thu, 13 Aug 2026 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629158; cv=none; b=LMaan1RJ98x2N5+HOHYlGyFcpj4hV1yvxcWgByPLIUR/m6EWy8qVq5pMZVdBOyStknlKt2VyqTATBq67F05JBQ3Da9pV+dHYBA3h6Fk4y7pL/7mDJ96fPpEFqnmUy7+pgNHzNgHaTlXHR7nfbi4HVNobIJ4NlMPs1aINMcooKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629158; c=relaxed/simple;
	bh=z+qu01YxpWynLq8/YIcR1FOoyXXFwXYFq2Jv+/OQqbw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qaAK2l6cfBfRITMBu0oXOZomvojmCTVNpUs67eZqflu81eHvmB0to+DDgwYSZTpp7gAj/XCml9Q3Q73DOi/THExge9Md9cFnlD+NbRl3giN4Tp2SDyu+VtdF7d/b8XNtitHWk1oliGyCociV0/3qHiqYno3IRbfD3qVvgWoK1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=DJJk4H+D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Odl/t/rc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="DJJk4H+D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Odl/t/rc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 98F52EC027E;
	Thu, 13 Aug 2026 09:52:31 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 09:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786629151;
	 x=1786715551; bh=/CL92jBIrGFN9TBtjCs00sly5y6noz9+KxR9WPKowzc=; b=
	DJJk4H+DwhpmSa0jSea4BBwHdAFoUiOR6mryXP+Tnd5soyhiYKdIhV+o2ExUcGTL
	/c1mNQXtNZcLaq8nBkinsVKPpRtcuxZvXMPhnmgv02fcvie0NYY/o75xsygGAYTW
	cNLb3pQpV/Z6SKp3LWi5vOUXK94FYcMPxmRd8ZrYrj+3/IOpOF0wkXOn273e37b3
	cwAR+0ep3hCvJe+jBvFxMrSOHPZswZxqCKOJdHSn/2Jgv9r5HLlbcB7w3oo/R7nM
	tln0xJv/xRF2lf1HjEcCi/syMohxdwZxlhj0DCUKgBObuO1FORJlGzOk6h8lz8Z6
	Hs5aPq8PYzLWqBKxeDKILw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786629151; x=
	1786715551; bh=/CL92jBIrGFN9TBtjCs00sly5y6noz9+KxR9WPKowzc=; b=O
	dl/t/rcfVJ1qrUZ+CQeUDh6IEoGuuB+XUBg9tpLuyMWLbx/xZQbIyWHdLfcjzvji
	XmDQz0jw6wAGsDdzLCq/LZDSM8cGR2VCRtu2G9rnY+0HC0srt2XE8+YbqlqMpbp8
	iJWlbHt4c6DlF5tWHrMPKqeBtSsOOCM/ijJivs6vjllMfuPyPFb6zKYlZ5sPzuGy
	yHgSvZCVm3skCBUEMSgQSQWF0Wh4igQvk1QfE623I30pcJaIk1Z0OcmtclBU0Inz
	DUDVaOWsYhQohhgaRa7Q+8oHFMAEMvo80fnGQBye1CFUG7HEmybp1PLvq2FBw4wD
	5V3E3RJh3jYoW7d8w5mwg==
X-ME-Sender: <xms:H8x9al9B78gED9d6YPIINQiRlLlORDumw4_NzzpIIEKhH0gMLm9PxA>
    <xme:H8x9akgDvQPCILrjRMnGJ3K8xmPhQkwFdsSah132KFeLqr6_9v4DWy43k6qBl_4Ty
    XY9uX8aVXqmm5T-8Hc2f1TEKuEAbV8d6bcgYXMX_PKcNwg9cS5onn8>
X-ME-Proxy-Cause: dmFkZTE3g4wZNRvPnx2i2raJjLxTkAjrfW8TD+tMyZPVnYxtqSg5Hyl6qSyFU11DLoi+/A
    loBnC+wX2qLWG+B7ZdwQien673B/96LF5FOBvLBnwKB64eS9RQV+GRnzF32vOUnaDiXjPF
    Q8TKjRx8TEK/PxW9HAgxNFpqwXHb2p4yHhbtyNUvE119mdpYzy9O7q67111nMWxzEZVNDI
    u+gfDQvRsnxHLnu0b6eoq4PWcC47yGlibm1EzuXc+u8NeYBsOWx0t7bQm0LL48JnRY+k7Q
    mCq9g83E1tpEwcLHwsQ6bifU6T2XfksDj/3dX96CI937AYrpAzU9W/5E2UXE3vAQdwXDnD
    Q8gBhFFmLiyZi8KxmWYo6nHwNDR3h+cXH6/5oUfNTruqZ9FyqTReYb6mQjRi0VXawbspa8
    gAjQ8e0QKkQwrZBa9ksImnXhVsSJ97l3hoUjZsar8WL8f0klC+wFHjF0V9stNpWHGogV6G
    b6ksmF5A8pijD2PLozD1fHm9/rpX6l49Mgv41tGhFMlsrkkzcsZv8Pm0+lyCuWHBDx1mnA
    k8/iT4B5iN65D/SUIf9BBdrBLF0r/t9ZLoDjiwmeg2U7AdO4IkLJgvED2V6gnRLQcq2F58
    GjF2GpSZmtVjRjyMaCZHbSx1vFPE6c7faDQKUi7s9+nZdJr3gdEwZYcNUYUg
X-ME-Proxy: <xmx:H8x9ahZdlMmhYO0PdGJ-7nMococErGJ0V16lpTeW8xGunyTLA86vzw>
    <xmx:H8x9atUbohFzbe1xIoUUpLp0Fm0Hb-6bNBqwM2SqZ66zT_oeg014NA>
    <xmx:H8x9aoNn4wbw0YwGXX_qK8HeNn5LpX0qI4pDrzlfHovD8CFt22W-Kg>
    <xmx:H8x9avZ6OFawpCMZSm7lQlQ4e8GT14XvAsQ7U1yvRH3xxFPs-kOo5g>
    <xmx:H8x9agKAeCMoSAmJ_2lt_rWJfH4KIEuT4PcYWxcUt9CtQU0wYNF3edD9>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D841B2CE0078; Thu, 13 Aug 2026 09:52:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6uA8SAIDAIg
Date: Thu, 13 Aug 2026 09:52:10 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org, "Mark Pearson" <markpearson@lenovo.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <d25d6a9c-609e-4fa2-9b26-23cded2b58a8@app.fastmail.com>
In-Reply-To: <20260813082049.41209-2-thorsten.blum@linux.dev>
References: <20260813082049.41209-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix current password length check
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks Thorsten

On Thu, Aug 13, 2026, at 4:20 AM, Thorsten Blum wrote:
> current_password_store() checks the password length before removing the
> trailing newline, which can reject valid passwords that are exactly
> ->maxlen bytes long.
>
> It also passes ->maxlen to strscpy(), which truncates passwords without
> a newline.
>
> Use strchrnul() to measure the password length up to the newline, then
> copy that many bytes and add a trailing NUL terminator.
>
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface 
> support on Lenovo platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Keep and reword the newline comment
> - v1: 
> https://lore.kernel.org/r/20260810132018.156868-3-thorsten.blum@linux.dev/
> ---
>  drivers/platform/x86/lenovo/think-lmi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c 
> b/drivers/platform/x86/lenovo/think-lmi.c
> index e215e86e3db7..d0ceb6aaa69e 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -438,14 +438,14 @@ static ssize_t current_password_store(struct 
> kobject *kobj,
>  	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
>  	size_t pwdlen;
> 
> -	pwdlen = strlen(buf);
> +	/* Strip newline; setting password won't work if one is present. */
> +	pwdlen = strchrnul(buf, '\n') - buf;
>  	/* pwdlen == 0 is allowed to clear the password */
>  	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen)))
>  		return -EINVAL;
> 
> -	strscpy(setting->password, buf, setting->maxlen);
> -	/* Strip out CR if one is present, setting password won't work if it 
> is present */
> -	strreplace(setting->password, '\n', '\0');
> +	memcpy(setting->password, buf, pwdlen);
> +	setting->password[pwdlen] = '\0';
>  	return count;
>  }

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Mark
