Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C7376A19;
	Tue, 11 Aug 2026 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476592; cv=none; b=PnjU/LcMR0Zk6OE4T4FPjqrzyh3+PdhsO84E7+N1FCVHsZHAPPChhtFOEA4A/AnUk4C8hAw7cvp+pVnO3Cm4Jby7T6L4XWmp+WNIep6n1zBXDUa8BVWkSOKWqrSKb2ynZCWBfVQA5ObsUJRPjInxs0Ai+yOb5kSUoB6wCEDFJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476592; c=relaxed/simple;
	bh=j9Gm8DDKjKyzBZozRxJ0PNn/0Ody/E4Nx8EqNyyC+Ko=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=duAQ3PSsfhllnwzUY+TAJpvU7VmvVnL7y/ffE3FaaC/m/SEedwH+z4WvdMmeggz7Uj2nnk1sAaNzaAjrx+LbYvYthVDY7GnTXK1kkCB9uPnJYSzGzHH6cMGSkFDCHrRpL7SFagQBbd/YH52sY5xRYAnR//99E16HTxrVkZvMe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=pPITMA9S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQTuUeM0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="pPITMA9S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQTuUeM0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B34EEC0031;
	Tue, 11 Aug 2026 15:29:50 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 15:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786476590;
	 x=1786562990; bh=wluX0IZszQoJFssrGt6NKxeLMe1Ht1JHlPzv6z66lHc=; b=
	pPITMA9SGKEApJ4r94Mctez4gcl96u3adJlSoHqsKm1eW5l90YjyBYwpoJQLayVa
	vJpuney53nQGEW84Sa+LRKzLmtK1Y+AisFJMyKMzt/mXdFa7+VSEukN0vWD4fmMu
	UYVKoi/24S2CUvKzKu+jdxPBOuhsrH4gCTO4CqDPSJmvcwjMu65u38NuuE7C1DP7
	N0stk2NyD0ofcgy4WYthDPpLQxPwl4oNtYxk3mqUqUAy5i15FkhZVKWhNiaWMlv5
	wqdPCpS/hmAa9raDnNT1vo7huYOSV2Oplz31EA/6RK1Kn1AYU7wtmDPrbojIeUZ4
	GB05NaWsnfyVWsZqDhu/aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786476590; x=
	1786562990; bh=wluX0IZszQoJFssrGt6NKxeLMe1Ht1JHlPzv6z66lHc=; b=U
	QTuUeM0BEzr/vNlYF7VkXKx+aTBMZoarkI3b3+BNX5mqRjXnIKDw/whTrErCcDts
	Ts6gFwbi/iLzmKOTj2IHBWXZmUJt4TrcDZZqq9KXUNXHe6RIkADd6FNtE54FImzO
	GxRc67d/Ncg20iobDoPlEMs/VXBMD7fKL9C+3kb6bzEuxI52+xujgW6WZWlqTB6i
	HkInNeBF02oXcVJ7bhUvjyjk5EHYzRq4RWXLCkvNQrUvUmvCz/Cix/fOTAmCmJ+q
	AqDFRLjQjDx22uJWy397jci2S2v0O8qS8KwNkNMIdNK/5Pvs1EOK1lqqKctOK9K/
	1Im1Sz3MhXmS7IWZvLzfQ==
X-ME-Sender: <xms:Lnh7asxlU1NzHE7s7nj0NRkjeT74aixLYoB6fIO7dC0uOGcm4pjH_g>
    <xme:Lnh7arFzlgMSbEaWrhAiCKkNDm-cVvq0b0mUnD4ALJH0criUB_sQgGMfVmyEZYyUp
    qYqm7kWo3SBoCkdlMfsP3YfmH9WL-nDRytIInVYDGnwuOHzqNVFbgQ>
X-ME-Proxy-Cause: dmFkZTG1V8LEMOPPwfcmXoJnOJmvTz9Sny6C2YseRbZIbHQqYDfXnZz84BlOSKwnyfAiel
    B/2fIcckO+L8dfSxIcIjGptFleWsoDro0ZHJ3NQVl24zChkAu+jNwyCQmhYoq7/ZnGGcND
    vUqjMxst/yts8VnlZdADgaa6sSXGxJmuDp8e5VizLzzy07nNTdwiBII3HNblsRd60PS0V8
    4sJkZoh3jtcACM2MsfyqUxkCXdv0IH/68CBtx+33wqhNE9XZH2itwLiUfM/QtyEB74qSss
    LplmW0G8MeN1ZgJqoMogDVWLPHg8FogHBvbCgfYhcCZroh7ldDBVNQjB2ITulluEQc5rXm
    DtczuKJXasqkDJArPV8QcUUhfthfdpPlN7Z8Pd7ohejLs9q5HrqcMiR/OGiWcPgYz8+96H
    14mr9NaYlcYD/M4EleIg1RZmHd5LseghHqRIg5qMc0shdR4Qug76eAJVKfx5OwQyjvYDum
    S345W80jpxsL8cmkYjpmXaI8ggSSd2Z0w5wsz7KSDV0Z0uidW0FHKYuBiheB8ruJq/rnNh
    SuohHE68YUP1MFyFOf4FKs6lLqhESsAZZz/m+mzEIAJp3Zb004Fsy8e9wgV9T+1XcwsqMo
    y2+GJjVfgVldp02rm4p3OE1BP21zwy40ASzPjZZriSYzi3zr25Wj17qQg5Rw
X-ME-Proxy: <xmx:Lnh7ait_fV5ydyDykRLZGx9jdAQMkyfhLOh9RyJnIVqy7n_ZVRtr_Q>
    <xmx:Lnh7asZ84I44WamldVbGFkPiLM5_VcOm_QwRwDPIkroHpr4-c1tszA>
    <xmx:Lnh7aiA0t8Hb1ouE573uVVxcT_khyNDEmazWjgkE7MWgaDCx21Wgzw>
    <xmx:Lnh7as-n9_KWYgGxJMBBmnJbrl3_8N1yWi4L943Gecs5FeAOnqgpEQ>
    <xmx:Lnh7ahFVAcJpqYKlgtaCfg1jBtNCNI5h3kSttPoo73reKqAVn51DC4Ij>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 01FC32CE0072; Tue, 11 Aug 2026 15:29:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASsTb3f6X8qB
Date: Tue, 11 Aug 2026 15:29:28 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org, "Mark Pearson" <markpearson@lenovo.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <15a1d7e9-f882-44ce-a24f-89b266e80efa@app.fastmail.com>
In-Reply-To: <20260810132018.156868-3-thorsten.blum@linux.dev>
References: <20260810132018.156868-3-thorsten.blum@linux.dev>
Subject: Re: [PATCH] platform/x86: think-lmi: Fix current password length check
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 10, 2026, at 9:20 AM, Thorsten Blum wrote:
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
>  drivers/platform/x86/lenovo/think-lmi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c 
> b/drivers/platform/x86/lenovo/think-lmi.c
> index e215e86e3db7..860224dc8c21 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -436,16 +436,14 @@ static ssize_t current_password_store(struct 
> kobject *kobj,
>  				      const char *buf, size_t count)
>  {
>  	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
> -	size_t pwdlen;
> +	size_t pwdlen = strchrnul(buf, '\n') - buf;
> 
> -	pwdlen = strlen(buf);
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

Change is good.
Only minor note is that I hate to lose the comment explaining why we're losing the CR. Can we put that back in above the strchrnul operation?

Mark
