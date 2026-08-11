Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8EB40B6C3
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480778; cv=none; b=s4q1OMtItm5Vzl0RvVnvf8JdUNDKgtX6CS5jn8BEyxDmChlf9N0H1yrAUkDF33m54OeCCl/Cpemzu9FJ93fJXNc8tjUALTh0BNipBjWCIOjiN5+e/c+6PPS2kcRqhCFCOECxHUEVUeNStOjOjoCOqHnFbQoH5kkKdYQkrC1f4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480778; c=relaxed/simple;
	bh=D2o0TEwznbSnrdQ/m8p3eHjT6PByyLCpzarc5zQ2xYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQFi2cjqGoEZe4Z5OkaZ3Qq8jUhJy/MNazIfJv/jJrfVP/KGYVDKqtJi+X5m6ZRIveHfDUa5CUPRDnHaMbhwAScLZ/ko1ET06WoNIvSlGykhnanWBhoPo7IbrsGoemebgnIXl12nuxabgDjItbB1vp35qmDjfdFZlqnAaKrNT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xYFwe1LO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xYFwe1LO"
Date: Tue, 11 Aug 2026 22:39:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786480763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvPs6sQdn1xCyxnV2mIq9/3mrxy3ZXv46BUvWDd2oFs=;
	b=xYFwe1LO+DpDHnFuOW7LA9/36w6d5AkDBgpMizyBvMLL39z7Gf3RiWHi/mLFNJMC+RZtw+
	CxOxiQ2Ln5khGyBXz5J4RhwP5cyyji5nufs7eiTauLRBNelKYn1bm5tUOzxZvgF45cvN0k
	eLodpIsZ2owkt6LGtj/kYhBHENCEnZo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: think-lmi: Keep pending save state on
 failure
Message-ID: <anuIdyiaqWHCjcai@linux.dev>
References: <20260810120830.149804-3-thorsten.blum@linux.dev>
 <a4d9ab1a-683d-49d3-93c0-d533fb96bf27@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d9ab1a-683d-49d3-93c0-d533fb96bf27@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 11, 2026 at 03:29:16PM -0400, Mark Pearson wrote:
> Hi Thorsten,
> 
> On Mon, Aug 10, 2026, at 8:08 AM, Thorsten Blum wrote:
> > In save_settings_store(), the opcode and legacy password paths do not
> > check if saving BIOS settings failed, but instead unconditionally clear
> > save_required and set reboot_required, losing the pending save state.
> >
> > Check the save result in those paths too.
> >
> > Fixes: 318d97849fc2 ("platform/x86: think-lmi: Add bulk save feature")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  drivers/platform/x86/lenovo/think-lmi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/platform/x86/lenovo/think-lmi.c 
> > b/drivers/platform/x86/lenovo/think-lmi.c
> > index e215e86e3db7..cc0a85d1b832 100644
> > --- a/drivers/platform/x86/lenovo/think-lmi.c
> > +++ b/drivers/platform/x86/lenovo/think-lmi.c
> > @@ -1347,6 +1347,8 @@ static ssize_t save_settings_store(struct kobject 
> > *kobj, struct kobj_attribute *
> >  					goto out;
> >  			}
> >  			ret = tlmi_save_bios_settings("");
> > +			if (ret)
> > +				goto out;
> >  		} else { /* old non-opcode based authentication method (deprecated) 
> > */
> >  			if (tlmi_priv.pwd_admin->pwd_enabled && 
> > tlmi_priv.pwd_admin->password[0]) {
> >  				auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
> > @@ -1363,6 +1365,8 @@ static ssize_t save_settings_store(struct kobject 
> > *kobj, struct kobj_attribute *
> >  				ret = tlmi_save_bios_settings(auth_str);
> >  			else
> >  				ret = tlmi_save_bios_settings("");
> > +			if (ret)
> > +				goto out;
> >  		}
> >  		tlmi_priv.save_required = false;
> >  		tlmi_priv.reboot_required = true;
> 
> Curious - have you actually hit this condition?

No, I was just reading the code and wondered why those return values
aren't checked for errors.
