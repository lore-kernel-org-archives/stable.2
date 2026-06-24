Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380A526F29B
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309673; cv=none; b=IU9xPoT/5hdwHZbg1fi91czMvYlw4ZL6bcou6cjtDuGYD01MEwtAIJLe3rUVURyVZjV975GFrgUyOn6kYBJuQd4px7t5pDNQb28vZzwhApY+0S9DBmMB0GWis0SDm97r/y+ycmjnWYIP0pi7exlwMa1jm6Hj0qaa/6Olibed0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309673; c=relaxed/simple;
	bh=sqz/nCl4XMoZ5TKKVVNz5tAI/LScRoJeM9WbyPmJx3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBWX/PWsN5XK3JqiTh5ZIbWeBRhjES7ciRiD82fHCWV7QbD9+nGT8XFFErGJ2qlWxcor8fc3o1L3HliZoZU7dTj82QLnfvh+Uq2aFl2q8mJ23h8ZBXMyK7ECS+t+tXGcKGTh3B6V0Zz3eAP9+WLpSkNHYItEuVgf6yJDMSPSd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=KstfDJkD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="KstfDJkD"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-915b5ce94c7so93377985a.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782309671; x=1782914471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsEoW4DBoKT0fUYLZPdL7MZJTkz7+GAlNaoQ4msQnkg=;
        b=KstfDJkDlEZuT1HYy2wLN0zzVO7os9Mav9CMPrsd7Kv98rDcLUS7Wg5ukVEMLr3LVG
         wrMAP69DjNNNzDVB2ZNOfiTOc1hFWk6LOgZdLKLlC+joHQiuqFZ40e7hNzcPh9oWhGY/
         2G/O2HjDTmBS9oRGG1S37xQaTYUM3wBJHlcPNdyjlvsE1IDgBr7ovk0ZlAyLMvD5K4F2
         s+LsOd3mFqtYmxhVb2PFHtvW7RF7jgiJBAVwWIQuzP65aYXobwjDznATwWFVkYABsJXZ
         LVH9wW2TsSZf+p2SWTS7/3e2nLXqldUfpW6QUJzVbbrD9x+kGVzbxfNNIV+4CBNNqAON
         puzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309671; x=1782914471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsEoW4DBoKT0fUYLZPdL7MZJTkz7+GAlNaoQ4msQnkg=;
        b=LSvXT0WjVyPXV9BSFSqMVxYUmENC2NPjvxg0fuwzZa9baKoOF5spSNp9cXwd0VzhNs
         jWSl6Nr2lOhXBQl4sRUSgz5Z1qGRfnhp2N1AD7nzfBtgjatUfRXa84hsaIs97ZFZ+SmM
         TyoaQhI2jAbzR8CsEY79rTQX9QSdv27/Jg+KDHltBPFTXjmHO9o+xX5bsrxtNcYcyNpP
         9tVGrZfu7TMVBV+zRpsSd74P4bmL4YNHwFcNJ2kiUvIn60ckXJGbFvk6n6BE8m1y2ROV
         uHGvsrB6gIqZZpmA3tM8lPa8nSzsEQHn2rHcQwSF9MEw36SKFZOmqG03S7Rp8JTu+tfy
         auxA==
X-Forwarded-Encrypted: i=1; AFNElJ/ukKjiLEHtGXwO6lV6mWH4k3YCMtXlcsI/UApfVImCCGi9OogQNIwYGleWBpLkFTF/OTAuxC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xnmQsd/TJjnV1pK8jRdIu1/X4cjj0b3I8WdeJAzlD27GfZlx
	BulJXlvg1/0Wk9J2LDo5/29cyVsUZUmfZqaOMfG13gPBeLCkr9nLUvsMSh1kBs4l2Q==
X-Gm-Gg: AfdE7clg+aNnUC7oLXt0I25BOktweYD64ZmnpzpBm320lD8yyPep+OVJNI6/qfl+qjT
	n/WhmQrRcQBJ3B7y0oQa+4LXLGNDRvB/+v6g33x4IV/0tk/Maz6NTRH/LAHLc6jFzQQzIw/A+XT
	68uu+++nklBNEmJSgdk2KDouojdTsvRnhMpO3/qx1Z3xOM0a58g6ZzEtr7ENKVvaCRJsjekURIZ
	aOiOuIl8IwetVkPTO1K2zcbvcc2KX9Ml7pXoAt1wlQZfvJdEZmIlp4qSiqsXXaho5NuOxpUXFtg
	A1g7cuQFjsgoUJH98qQgHea2dOn2F+QcPnLRWtwhXQLGRdxuz0cyem24zxjdiCglvyiuyMDNQ68
	Nq7OmaHnOHJiHwFj9I51ZHTDOjjpeC7z6DG5n0CXgrA4XOq/uV6yVx3apCC9C+wmjPgygRRtnpl
	v8qhPnK3J2BiEV1H/wR+CZKJubAmLZQRQ9
X-Received: by 2002:a05:620a:1a09:b0:915:cb5c:7f70 with SMTP id af79cd13be357-927800a2787mr561454085a.29.1782309641938;
        Wed, 24 Jun 2026 07:00:41 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bf55sm552191785a.46.2026.06.24.07.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:00:41 -0700 (PDT)
Date: Wed, 24 Jun 2026 10:00:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
 <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
 <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>

On Wed, Jun 24, 2026 at 01:36:28PM +0530, Nikhil Solanke wrote:
> > Actually, the best approach here would be to put this single change into
> > a separate patch that comes before the current one.  That removes issues
> > of making more than one functional change in one patch and improves
> > bisectability.
> 
> Before? Shouldn't it be after my changes? That would make it easier to
> justify the changes. And just to be sure, you did mention it does
> align with what the intention of USB_QUIRK_DELAY_INIT, but it does
> change its behavior when the quirk is not set. Atleast from what I
> understood from the documentation and an LLM's summary, the device
> needs time to prepare the full configuration set. So, does delaying
> before the first header read really work? I can't test this since I
> don't have a device that requires the quirk to be set.
> 
> I personally think adding a condition to check if the quirk is set and
> then delaying before sending the first request would be appropriate.
> What are your opinions on this.

Well, put it this way: If you change the existing behavior, that change 
belongs in a separate patch.  If you want to redo this patch so that it 
doesn't change anything when the quirk flag isn't set, that's fine.

> Also is it fine if the string lines exceed 100 columns?

In lines containing long strings, it's okay for the string to extend 
well beyond 80 columns.  But then you should break the line at some 
point closely following the end of the string.  I'm sure you can find 
examples of this if you look through some of the other source files.

> Also, is there a need to check for krealloc()'s return value? Since we
> are only shrinking the buffer, there won't be any moves or completely
> new blocks (at least as per my understanding). Do I still need to
> check its return value for completeness' sake?

It's a little tricky to track this down, but if you look in 
include/linux/slab.h you'll see that krealloc() is defined as 
krealloc_node(), which is defined as krealloc_node_align(), which is 
defined as krealloc_node_align_noprof(), which is declared with 
__must_check.  So yes, you need to check the return value from 
krealloc().

Of course, you could simply try not checking the return value and seeing 
if that provokes a warning or error from the compiler.

Alan Stern
