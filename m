Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749D317144
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975301; cv=none; b=co1+rOUYFnF0fD05M7W4iUaQT+2WLtKRqixC4KXIePgrJVqnCGs83+LumjW/TLOaRjBNPuR1BZeZ3IAmfjV5CxNo60csMbcKWWUeQWHE3I30SmH8faihG0wMs91ClUR87XS8Oik/vjTwjvby0UDkMEaURqx4GQ5QneMwOhTwNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975301; c=relaxed/simple;
	bh=Nz7WLagweYcsHnwgsirP2pm3D+368zL+4idFN9qy0Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcYGxnczeJD7lFgEZ07+fiUGLHBDsV6OjQW28jRWhm9ZAME+V34JBOlRTAbYYAM9S5R5fyJUvHVJ/S6kEiSnVLk2J7AgT436wdQ/jmXaSIp3gBI5g0/Nd1D3b0Nfg+Ej2qWjioBKC5FHcDJ56fijRi2tAKr9mht71PQo6m729mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=eboCDWbJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="eboCDWbJ"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e57a753f9so282813885a.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1786975299; x=1787580099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r5iv3a0Q+hWK6jjkQP2327M84DXDyYow9v5uLkF6NPo=;
        b=eboCDWbJGE8+P7JEbZIijeX5HFG7qoCm1Cxo6HM4LpAj3PUkz3/VkNG1/zHol+KukV
         4Q5l+UOjSJhKxdqzMBbLbQjNvsqOyjhNoXPqvkHNgRQ7opj/WbvWmbj+tSc+qotATCUI
         pro2CXj58lySzKY2lhCjnn9RDWIvEShqw6KWRqVQ+tZzZmbGkI0Z+PH4G4Isz5VAb289
         9HwOutp5JwP8tr78n6sqB3AXlbHv8PK/Uf0G6VVMiOIqrlu0qTv54nmxqQj1SyAzy1bF
         NUotSJCnteyGHQ4N78GT6rCI9jRos3c7yYozfZZis4H3UBUf1Gl1XR4rTSUrDJf+4/+M
         M30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786975299; x=1787580099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5iv3a0Q+hWK6jjkQP2327M84DXDyYow9v5uLkF6NPo=;
        b=RxXd8MPcgmIgqzZFiIJ9GLXg9D6NjI4hsMualLxHuFdqVJYYQUNkFNmvwAEzbIAoJj
         MQHEI0W+8HvoCJi5bXFfY+rtjQ418PtixrLGmMJUQJp3jxtxYh5IPhVq+4lHGS95HAqv
         88R6Aeym/7x74LAqd7t6uFRSGLVSsHVXSV2u84h/KC+1LW9ccVcP2YIaNrzd7tLVmy3z
         LqejIhqBcC4QbUtqstE2ffOewDWv62/KAB4VtovsiuXpEUws4k529gt7/gPimNznMZXk
         5QCOR67eH8LDAHqZryT9HQusAGqOAGSw4K6hRny5Ih4ay0sgOQvCaSIYa56U5zcbsD+p
         NY2w==
X-Forwarded-Encrypted: i=1; AHgh+Ro4OEAtVKKCfkkl19H2uy9ZCb9P49t1WQ9qsPEHVcH467nDmnaGCdiUGMTnlIEdr7asEsR+ybI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQbcw9o6kB6PXlJKlRH8rjeKzoPCkYc7hrzjGHguVl8tZIprBN
	RgmDsP5vypQgkd1+o2bn0xCJQDnPIzAVs9bfTKL5SgwK4PZDj/rEG7JW/GRmZLM7mQ==
X-Gm-Gg: AR+sD1339+XrIDviG/r6tE+OtJx3laG8kSOhYyDyBkiL7rObF0eBMOjNpyqZB6tdi2R
	L8Txfjn/Kzim36JvwVjAaMH6m1ReNtsD0hSpK0J5iPndfJKFV5dJVo7almLdSwxhE0JI7btJNqo
	th6m2JHF7U8Hyf4vFEYh6vQMlhGiebLc8ZpEKMX8xlcJLSwgwQTfODxZOSIYH+86TqhFlm11VNl
	8rozJF2wU0ZHZ6YJWq261ODPL59VqBuY5ixtJxHrGngYzkHBMwXB4luypOg9eo96MXSBA3G1KPN
	K0k+eNA5eUWwiJJs3pPmwBc3fkDuuoqZBATEZsXE+ejTJ6o3hLOHevvK/QAnqibkdQFQhDZlXxk
	iCWDyvOrex8d9Mj+yiwIN/r9oy1/z86DsLq3YLbbZwFzV05UFQF4ViFIBz1KVt8WfvZbw/BPUFZ
	K/6WerFD4jj2aLUQ2VarYsqsJwo8GTCXhlN77WCDfph8T4IlPazPpHFhFE3GnfS8GWCLwHk6pad
	jm1hjo=
X-Received: by 2002:a05:620a:4506:b0:936:eeab:307e with SMTP id af79cd13be357-936eeab311bmr1271697885a.9.1786975299020;
        Mon, 17 Aug 2026 07:01:39 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033fb9d9sm52544485a.38.2026.08.17.07.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:01:38 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:01:36 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com,
	christophe.jaillet@wanadoo.fr, kees@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: fix null pointer
 dereference in fsg_common_set_num_buffers()
Message-ID: <e52c5913-9210-47cd-9a97-ab00547f53c4@rowland.harvard.edu>
References: <20260817110839.8201-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817110839.8201-1-jeffinphilip14@gmail.com>

On Mon, Aug 17, 2026 at 04:38:39PM +0530, Jeffin Philip wrote:
> In fsg_common_set_num_buffers(), n can be 0 as conversion to u8
> using kstrtou8() in fsg_opts_num_buffers_store() can return
> values from _0_ to 255. When passing 0 as "n" value to kzalloc_objs,
> it can return a ZERO_SIZE_PTR, which passes the null check for
> buffhds. This leads to a null pointer dereference later in bh->next
> in the do while loop. Fix this by adding a check for n = 0 case and
> returning -EINVAL if n is 0.
> 
> Reported-by: syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=791be35f1fbcc85d06d7
> Fixes: fe5a6c48fd95 ("usb: gadget: storage: get rid of fsg_num_buffers_validate()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>

In fe5a6c48fd95 ("usb: gadget: storage: get rid of 
fsg_num_buffers_validate()"), the code that was changed originally 
required the number to lie between 2 and 32.  Even 1 was not acceptable.

Alan Stern

> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index a50743caf083..640d3bcb7bf0 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -2747,6 +2747,9 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
>  	struct fsg_buffhd *bh, *buffhds;
>  	int i;
>  
> +	if (!n)
> +		return -EINVAL;
> +
>  	buffhds = kzalloc_objs(*buffhds, n);
>  	if (!buffhds)
>  		return -ENOMEM;
> -- 
> 2.55.0
> 
> 
