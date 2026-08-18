Received: from mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB92D5408
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058946; cv=none; b=kGqItaXH521DomyB1dcHQhhBpZaauJ7U96w/j609cvof+fFXZ3ezR5zhpkzFapaGMj/G4DKFqQU/Jq5gwEWQlj9Bwr5r4ytpLAH1zUbNmPxancUeqRrVbj9k9PWyoGFaTG5aWhOMBDuEDWDR1EbxOmUzZ0G+k5ne5fa3Is6y5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058946; c=relaxed/simple;
	bh=d4AEsAjQVAZ7vwOjVpYPcLqw/t5b03u3Gr3BSlgMvLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2ghYazgm8nXRtXlT8XewIdJINrFGPKJLh1q8roN+M11bdDfpjCO3fj/DUqrWY4ocNi2gVQIlNPJdr66hAkNRuZZr+VLxOQKdVCJVyeU1JF/7FI3wDrvw31n/iZGujwo/bs/N5uMzha105O/9RKkO0lAG2wQqjQu/laRtBQR//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lz8mOX3B; arc=none smtp.client-ip=95.215.58.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lz8mOX3B"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=d4AEsAjQVAZ7vwOjVpYPcLqw/t5b03u3Gr3BSlgMvLc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787058942; v=1; x=1787663742;
 b=lz8mOX3By5nFE7irYrDunKvCCGIuIK2YqVjPCTSxh0eG3YaAls2pSbGwL7fejWZn8Ds/N4U3
 xLLHaHPhv/sxZrLtKu9dBOklThN8VfZe9ujwaK12z4iWb6uA96GArHQm4j9V+rjYbrPS4jd0fNQ
 7cacUUzM7HQc4iRzynCGcPU0=
X-Envelope-To: stable@vger.kernel.org
Received: from linux.dev (62.216.208.217)
	by mta12.migadu.com with ESMTPS id e0058b7dd93a47ab;
	Tue, 18 Aug 2026 13:15:42 +0000
X-Migadu-Flow: FLOW_OUT
Date: Tue, 18 Aug 2026 15:15:40 +0200
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>, stable@vger.kernel.org,
	Mark Pearson <markpearson@lenovo.com>,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix current password length
 check
Message-ID: <aoRa_PwLxneo9Juv@linux.dev>
References: <20260813082049.41209-2-thorsten.blum@linux.dev>
 <daeefbce-83f6-f161-71f5-38730fe9c9d5@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daeefbce-83f6-f161-71f5-38730fe9c9d5@linux.intel.com>

On Tue, Aug 18, 2026 at 02:28:50PM +0300, Ilpo Järvinen wrote:
> On Thu, 13 Aug 2026, Thorsten Blum wrote:
> > current_password_store() checks the password length before removing the
> > trailing newline, which can reject valid passwords that are exactly
> > ->maxlen bytes long.
> > 
> > It also passes ->maxlen to strscpy(), which truncates passwords without
> > a newline.
> > 
> > Use strchrnul() to measure the password length up to the newline, then
> > copy that many bytes and add a trailing NUL terminator.
> > 
> > Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> > Changes in v2:
> > - Keep and reword the newline comment
> > - v1: https://lore.kernel.org/r/20260810132018.156868-3-thorsten.blum@linux.dev/
> > ---
> >  drivers/platform/x86/lenovo/think-lmi.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
> > index e215e86e3db7..d0ceb6aaa69e 100644
> > --- a/drivers/platform/x86/lenovo/think-lmi.c
> > +++ b/drivers/platform/x86/lenovo/think-lmi.c
> > @@ -438,14 +438,14 @@ static ssize_t current_password_store(struct kobject *kobj,
> >  	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
> >  	size_t pwdlen;
> >  
> > -	pwdlen = strlen(buf);
> > +	/* Strip newline; setting password won't work if one is present. */
> > +	pwdlen = strchrnul(buf, '\n') - buf;
> >  	/* pwdlen == 0 is allowed to clear the password */
> >  	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen)))
> >  		return -EINVAL;
> >  
> > -	strscpy(setting->password, buf, setting->maxlen);
> > -	/* Strip out CR if one is present, setting password won't work if it is present */
> > -	strreplace(setting->password, '\n', '\0');
> > +	memcpy(setting->password, buf, pwdlen);
> > +	setting->password[pwdlen] = '\0';
> 
> Hi,
> 
> I don't understand why is this strscpy() -> memcpy() conversion required? 

It's not required, strscpy() would also work.

> Wouldn't it work with:
> 
> 	strscpy(..., pwdlen);
> 
> ?

However, strscpy(setting->password, buf, pwdlen) wouldn't work because
pwdlen is the number of characters to copy, but the destination buffer
size also needs to include room for the NUL terminator. Since there is
no NUL before pwdlen, it would copy only pwdlen - 1 characters and set
setting->password[pwdlen - 1] = '\0'.

strscpy(setting->password, buf, pwdlen + 1) would work, but since we
already know that exactly pwdlen bytes need to be copied, memcpy() is
sufficient.
