Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D338F950
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338640; cv=none; b=VHvZgC7G67RUblscKKjBnsZkBmw732IUg9MCQUFVukq1o+2qQnGSWDgh+fVbNHXVJjKUT7FxCfaabkQvnwgKlw1+EdASazgm4CTviXHTd/s7eXCjbzZa0DjLtekods8vrwZw1j0uWYCS4fzfAHVfnSD1HiWUtUZ6V2ZWhQiPrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338640; c=relaxed/simple;
	bh=X+1zrtXejRrfQMhuaglFGS2WuOgDy+lVe5hYeklGYC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo3z1C9caEg+8gDVvVWyMxqA0oJoq6dxFrEfdkOEKP0rUmMobI/c4lpRG9QM8TytjJM2FkDkDJLpON9xmySEUiW5wj8OBdNhECmAOt8zvlK+PTKthe+ITIg9C46Xk1E/wxcxwto02BCg2sRE7dW0U8BK9P7w7sDNoyNIiW+twJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=kHxC1lV0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="kHxC1lV0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5363c8de563so12551591cf.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 08:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792338638; x=1792943438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wDrGfc+QmDUG23Iv3Y5ooeIfcPWkkBSGjgdvWGkt54U=;
        b=kHxC1lV0/lOkHeSP2hpxlyHtjyZuw31r7Bv4Va0TtkxTLqoGYok6LeWyH8YWtbvENi
         czhOXtS7hZZ1uXHhO1oE3qQ/zGWo/IIW/cQI0ZrmomNSjAP5QDujGfZUYJBRT4rz5YUb
         2ZXVlIm0HPnZUnWJpEHCFQeUyPgdDIY/HAk3UyJv65vD7kEW3oq//Q46wHPBrNqCbQYD
         AtReC4kO18K85DWVXKDRWxSFN136Ag/ylrGM9a74c3CWoMnC2OZUgj08be4uCJVy+acB
         JKZbUetPlCnrx4nvI/s6gGH6VOsSZcp5K5VRzjXiU2AJ1ErTQOuobceY+Fys/X5UiR9E
         gSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792338638; x=1792943438;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wDrGfc+QmDUG23Iv3Y5ooeIfcPWkkBSGjgdvWGkt54U=;
        b=RWOWQPrGICNp8C0Q44VhM0905agxtHLZsr9tUmfG96Zzb85pTHaERn82B8VsnievNi
         VM2kDjokCUYtsTZ5aiKwJzOfyeS5DsPIXh4pvX8rfD/8ZFPNazWfzohI/XLdBWbaTzWT
         cjSe0x8Ib7LjvWve9JRS8YZhqj3J+FXsSEO3eaUVqjUsLEPh1KWOd7WrPY09uKMDk41t
         q0rat4wvegjf8WeWKt/mufirpAJ0HmQzb1oJvh6G8Fe4ukFsYaVlpY/A+UzsMbJrejUN
         mL7idxjBghLlLNqTxKxxh7rZzXhpohBpvt7lGFlJV4FYjaBD6bKhMU9i9ERUqooxSysZ
         XTyw==
X-Forwarded-Encrypted: i=1; AKwUvByHnVl7O6/Xi22dPQU1Jhm6iEf4Toaw3GINLpwb0woW4jI5OWWdS95f0rdFYYKyidrw8KCcqBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKj1mKgI1ZjmLOm1IzqV2zLthvX5sY7BLb2yRxR0VUwI/34o4QN
	aGELDiQI4Cx44xE5aGJz7l28zc0djbtdQW1zEn4Z5Al6W3zIqETUKw5goUD7XopWLP0nSe7w9Dt
	Y+vWWaQ==
X-Gm-Gg: AYBFou1MyD3t6MsieXHn77lnukHtYGf5Djf3y7iXWwc9ZSdP8MPCWPE8izkZNdbrFpk
	/2LGRiBjWml1YqcUaib8+Rd4zezqItTaLdY0NIcEIbwcms3nQQMcOELWeZsCHQeQvzeClTsKF5p
	LuaAkHtfyYg6KrvoZpfrZWh3f3oLOoIAjEYP2rZWxEwMjQ4lFPYK0t4pciXAsP8KaMYdpJUO1oU
	634Qof2goWsOcekSsVD+90Zke+g53pblqbBI93SxnisWLI88DFEPYr5Qm9c0NKu2vG4Ngir1NJ/
	mHeCAevFKDK5erKnK+InUWJIAgBWhA2AIP0WhA1DBEgDdvOLPJ/aprVIRUsGILtS20IOaBzmVof
	apM8jlXvrlDrgkypOxSTix8e3YkJlvutDqn0wUDnNmFClPV4da7XHrIcl5sjFk/8skvBTujAa0d
	ryZt+bNLF08bnJtp9pKaARXBAlR7PftFiIgYQ7qFsFZQvVIejiw/68lhvnD+3jGswdTgR+vEY=
X-Received: by 2002:a05:622a:2b09:b0:535:1368:4582 with SMTP id d75a77b69052e-536460097bamr72026991cf.46.1792338637925;
        Sun, 18 Oct 2026 08:50:37 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::4791])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53656bcf751sm32924451cf.14.2026.10.18.08.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:50:37 -0700 (PDT)
Date: Sun, 18 Oct 2026 11:50:34 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: take filesem in nofua store
 to fix backing-file UAF
Message-ID: <17102759-8b97-4b5b-b130-c01ef0f90980@rowland.harvard.edu>
References: <20261018130519.65850-1-yuz08559@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018130519.65850-1-yuz08559@gmail.com>

On Sun, Oct 18, 2026 at 11:05:19PM +1000, Yu Zhang wrote:
> fsg_store_nofua() syncs the LUN's backing file when switching from async
> to sync mode:
> 
> 	if (!nofua && curlun->nofua)
> 		fsg_lun_fsync_sub(curlun);
> 
> fsg_lun_fsync_sub() dereferences curlun->filp (vfs_fsync(filp)). Unlike
> every other store that touches the backing file -- fsg_store_ro() and
> fsg_store_cdrom() (down_read), fsg_store_file() (down_write) --
> fsg_store_nofua() holds no filesem while doing so.

> diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
> index 0000003..0000004 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -415,7 +415,8 @@
>  }
>  EXPORT_SYMBOL_GPL(fsg_store_ro);
>  
> -ssize_t fsg_store_nofua(struct fsg_lun *curlun, const char *buf, size_t count)
> +ssize_t fsg_store_nofua(struct fsg_lun *curlun, struct rw_semaphore *filesem,
> +			const char *buf, size_t count)
>  {
>  	bool		nofua;
>  	int		ret;
> @@ -424,11 +425,13 @@
>  	if (ret)
>  		return ret;
>  
> +	down_read(filesem);
>  	/* Sync data when switching from async mode to sync */
>  	if (!nofua && curlun->nofua)
>  		fsg_lun_fsync_sub(curlun);
>  
>  	curlun->nofua = nofua;
> +	up_read(filesem);

Shouldn't filesem be held only within the body of the conditional?  
There's no reason to take it if fsg_lun_fsync_sub() isn't going to be 
called.

Alan Stern
