Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC22F8E96;
	Wed, 12 Aug 2026 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493912; cv=none; b=Es9N+/2V2o4bFPJUt/ewmBWYZ+8M2IdC53kkro24peUeAlP/dDhnHxevtnbgcCK+RaYuZdu70ruU41WugrCWOG9SzVfFEXkGPCY7zbiCVYmeZlOSCC/wYJY73zKYu1T/2B8vu4qgRuzvcoo2sl0YCc+f3A5B/Y8KbJOBT/+fKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493912; c=relaxed/simple;
	bh=f4akE2LkzXLwbAtcxV/2m6//dB/3cMrWoDA6A2d2MN4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m2L8WzRXQpxSawDNGHV4KvnjBV5dlY+4JmCuYBOUHiSUlvw90S1dUXGNb2QKUf/Spm6uEaVpNYrVpn0i28t4MSuFCM7re0MTPgnS3uROCjSYh8aabB8DjbHbUtjVPDNgDSSCFWffJCWnlv8J0pZw2TG0zrDySgMlygXRxmA9+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=dsXbGvrS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J0k2pFMe; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="dsXbGvrS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J0k2pFMe"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBFBB1400181;
	Tue, 11 Aug 2026 20:18:28 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 20:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786493908;
	 x=1786580308; bh=j5Oj2Obz0+ZHSH6TE698GeMZh+cTLbZ3w1GhWZGgcUw=; b=
	dsXbGvrSywgIBZhmeMwhb3X03N8O1iNMVFeYzmFe22eMyrwvZlldeFA8AF+/zVTW
	OJRXxVJi0ccdwHI0/0EnlTk8kZESX5ITO1Q4zm/1I9IMWMafyO9XV0RGPhJ6B+4m
	k3JqRygW8nMuhE+nMoj33864XQLi1O41smMWoyYvpf3OdP6MWD3cLPQw4FXG3FDh
	4boWmu52Yhv+V8hKZpUOBvmAEp80d27wepvvNMbBZl91b+YH0aKHtBUArGjObHum
	hRZHcjbZ8pds3uBbRnKP+oYAvoQH5mz/gIjLo5C4KYvIhLoIO1Vp9pdbJSMNHshe
	trwoKYuPvhQ0tMJQjhSMlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786493908; x=
	1786580308; bh=j5Oj2Obz0+ZHSH6TE698GeMZh+cTLbZ3w1GhWZGgcUw=; b=J
	0k2pFMejbRFmKjTPXYNNtdEMjMS9iQ3j1MOcvCop0Y4IpjOQMBTlM3394DeFXcqR
	KI9hPQ2bzpm3+dAyvA+Dh+H5x1Xoh9QYmFy3y5u7HyT/NGuMfUN60qa1YZgf3h/2
	ACZDyMs3x6bE0AAP/Q4oDnMVsod2mOT3UlGFC8YKGpsp2rExgbbirbEhKvgRw56V
	jUCpWa6ANF+UlAun0pMtUhShZHb1aqD+CNwT6AAo2wwONNY8+VIKsIW5jRzfx6+z
	Bkvb9QGFmZ53iG8Da1rs9+97BO2ZS4MBdQtBYxV1mmkxVBRLInHDsq/XdrNx6J1g
	kggwWRLKNqd367co7vl5g==
X-ME-Sender: <xms:1Lt7atZxorH9C20w2Y_7z9vQlp-ejSwmfEcgfMLQaLqTMdPH76UqrA>
    <xme:1Lt7avOPR_VSmvLFQ5-bS1CfwKDfmmEQPHL-of--hcmhTohky0nqSoTeSev9W8cVX
    mjHnJgHTxpOudp51VUBZZf8sykWWyfValYuFYMOuw6RRTKySZtRWAU>
X-ME-Proxy-Cause: dmFkZTEA4qugiSiHGoKGdZf2ew0TkXZ+lBiRfkL51Q6IFt86j+dRbUmmPNDlOVWXLgknza
    CcFRaQd6Ft/Cmbeg2oDfoVN0swgIs+jfsGYNZqIdwGnyoqKU8Kk8qgRWU0j6EoixyQYjSe
    JGc0l4/k8pnD6Bh4kA8Q3ywVsNj/xvPwzJarw+jddmJCaO/epS16fvkEx0ScZys3ZHTjav
    bA0r8KOSTnKgctwB1LMS6ewYvCPgv4Yk3FoVuLLj/K0CxwNKXljgvCyq4cie2K4lI+5+WX
    h2eUnRhfpzkjW6QBAm715+2Xpu6Up4Z82LOQgi9UtRPKgJnalE8UUgWfg7QQNhE+4kLgrh
    /rPPBsiiR2zbGWdkkKFX3z26DPVGY3tynj5dJdxGQ/ty6eltuHNEzkhVgAvcNHFka2iYsg
    z6/2SglyiC4ONpsnjvxpQTIUkmHwNMnGPSIEN+TN+7lmqzqO+Tf+IqE0aQjDGXwKc/SWsc
    hCPgq635iz1HxdXmZjt6lTZGBlLCjcID0JQeuJ77Xpp55Ywic0tqaRoDFqsaTn4LYs8AiV
    iw6mPl88/BvQ4jEs/fFQmMnEisfUQ8CG/yox3VyabnCBVdZihUwuZSdx0lbDK/1F4QO8CH
    V4A1QkQTfg3EfHpKKvzz/r3VUwLBHOE5g1Kifxlj91oYSrzqUT0cqDUexUOQ
X-ME-Proxy: <xmx:1Lt7agV8n2BywNkTqI0PfOCTdDnRdsjhbirOsnz94dpaO0ZtYLR9iQ>
    <xmx:1Lt7apgBfSWWmZDLxa9awDYmRjeDSvcLXEc4qr-DNYVNQuOJmXh9sA>
    <xmx:1Lt7aoptSA8BvOCPIs8Rca5eekdW19FYnx-UvXqkbmJwWbGFgTjcYg>
    <xmx:1Lt7avFVGk0Q0ej-fwVitWXAokK7Lv3zEZyH6sznfiBlRL1IjTjGww>
    <xmx:1Lt7ajWC4ln0XDIs4f1r-LVkM4yzySv3CAAImUlus8xyFULotYEZ00pK>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 500132CE0072; Tue, 11 Aug 2026 20:18:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASsTb3f6X8qB
Date: Tue, 11 Aug 2026 20:18:07 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Thorsten Blum" <thorsten.blum@linux.dev>
Cc: "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 stable@vger.kernel.org, "Mark Pearson" <markpearson@lenovo.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <66bc1fa6-0e25-48a8-b117-7cc157e42836@app.fastmail.com>
In-Reply-To: <anuGJ59lNNX7YouI@linux.dev>
References: <20260810132018.156868-3-thorsten.blum@linux.dev>
 <15a1d7e9-f882-44ce-a24f-89b266e80efa@app.fastmail.com>
 <anuGJ59lNNX7YouI@linux.dev>
Subject: Re: [PATCH] platform/x86: think-lmi: Fix current password length check
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Aug 11, 2026, at 4:29 PM, Thorsten Blum wrote:
> On Tue, Aug 11, 2026 at 03:29:28PM -0400, Mark Pearson wrote:
>> On Mon, Aug 10, 2026, at 9:20 AM, Thorsten Blum wrote:
>> > current_password_store() checks the password length before removing the
>> > trailing newline, which can reject valid passwords that are exactly
>> > ->maxlen bytes long.
>> >
>> > It also passes ->maxlen to strscpy(), which truncates passwords without
>> > a newline.
>> >
>> > Use strchrnul() to measure the password length up to the newline, then
>> > copy that many bytes and add a trailing NUL terminator.
>> >
>> > Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface 
>> > support on Lenovo platforms")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> > ---
>> >  drivers/platform/x86/lenovo/think-lmi.c | 8 +++-----
>> >  1 file changed, 3 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/platform/x86/lenovo/think-lmi.c 
>> > b/drivers/platform/x86/lenovo/think-lmi.c
>> > index e215e86e3db7..860224dc8c21 100644
>> > --- a/drivers/platform/x86/lenovo/think-lmi.c
>> > +++ b/drivers/platform/x86/lenovo/think-lmi.c
>> > @@ -436,16 +436,14 @@ static ssize_t current_password_store(struct 
>> > kobject *kobj,
>> >  				      const char *buf, size_t count)
>> >  {
>> >  	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
>> > -	size_t pwdlen;
>> > +	size_t pwdlen = strchrnul(buf, '\n') - buf;
>> > 
>> > -	pwdlen = strlen(buf);
>> >  	/* pwdlen == 0 is allowed to clear the password */
>> >  	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen)))
>> >  		return -EINVAL;
>> > 
>> > -	strscpy(setting->password, buf, setting->maxlen);
>> > -	/* Strip out CR if one is present, setting password won't work if it 
>> > is present */
>> > -	strreplace(setting->password, '\n', '\0');
>> > +	memcpy(setting->password, buf, pwdlen);
>> > +	setting->password[pwdlen] = '\0';
>> >  	return count;
>> >  }
>> 
>> Change is good.
>> Only minor note is that I hate to lose the comment explaining why
>> we're losing the CR. Can we put that back in above the strchrnul
>> operation?
>
> I removed the comment because '\r' is CR and '\n' is LF. Happy to add it
> back if needed, but maybe a better version would be:
>
> /* Strip newline; setting password won't work if one is present. */

Good point. Yes please.

Mark
