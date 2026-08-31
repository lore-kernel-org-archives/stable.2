Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415963E16AE
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218141; cv=none; b=JD+TS96pz1r3m9LCpeBD/PZmctQ7Eap9nFpoj/13cITePKgVZAytMSjtK4FYSZtFzosLLeYGTwRU57rXoaneNZlz5iZYXDN+Y/Ns0KQ3CKHQFLlQoGSSqJ2Hj28QrmdQ4Iab9eArxYFiGjBlTNf32eG4aBPoiACftddJ4K80pjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218141; c=relaxed/simple;
	bh=nLjNT1G5JUYYPrhknY0eB9x0ZjckXKrDo9yhKokRjVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhHiJsMWUXmkQ9Hknju+FuS9KefZF3IeVtbFfLJAGJLTQPxvIXx/3QgXAhPP+34yQ/ayklXzhgT+2hTbZS8F7YO8Pv8cZLAd7FKlElZuuIetnLLGOLWT2mJePAAFVLtRorZe7PUt6TYyrZxe2x7UV9f+27NDEajuhPwnrfnHI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDowiLX+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDowiLX+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso4502475e9.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788218137; x=1788822937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Cbbg1ZOVRL0U5f2uy8yCobIVDqIxQsXjzjOSTe5SUM=;
        b=NDowiLX+9lFsVlgSpsbSBI75OdoGWkBcd3+W3sPqomHUJpEOngiZS3JDPCNK1zCk4D
         PcT9p7Nna0HxKYETKWidlLgKKejGVXkefLQCYsmapqoXMMXjOwnN/bL19XZlsyqt44Ao
         iAzD2ha+jTDygPTOv/mws4TcV37rJ4rQJo+0hg4NJn5xqvKQq9rqFtypGeCFvGNYL9yf
         wL4rQSduJCopY8p2S0Oet+5tRnKQoH5kWpK4ERvz2J53riqnNK6rp+mSgeWsn6KLmSh8
         4LbJUyeF8HWyWUKI6vTvLDaOC2J31Wmjjr7D0Bvn1WXm3mFpepcxRKG3saI/T19WDCC+
         VQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788218137; x=1788822937;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Cbbg1ZOVRL0U5f2uy8yCobIVDqIxQsXjzjOSTe5SUM=;
        b=V2JkMAwH3MOwCldkzkRejk03VkmoqD77cgvthhn3L0QY9mTpFUe933pdfE3wkMs/hR
         t8WLExt87UUVTIh2b0OnsBkEJfzpm0DFTUe33whl3Y+2vP7kCLvsle23dS+hdy+0FGsG
         /xmziPK2NaokMc3RdL58Nu3h/juDLMe8SXcoMsDaAZOT/eGSdTlExDZ9Ryt+I7adgzYx
         x282hUWW52rWv0jBaubnzhg9dAdUHEMcbNJUUL3vgEIL8JWAaJXYzwwPJFRsCK3RaqAh
         S6rrvJJeKe08FdOuC23s2Y0Fyn+QBiLRjjzb4tzYJmYx6Nw/UbFliodG2SEZIgzBQy7l
         tKKA==
X-Gm-Message-State: AFuF++n6qwR0zDiqedKqLDQXwEvWEbQMFscP/eVVx1Ul5rKAD/UWJ8YL
	T6wTMeyvr36PXtHeMOwafrwxdbGoSKfJtVOZGmGhUh8H/qcvFvmLAfda
X-Gm-Gg: AR+sD139UV/3WsGye3zvB4Yl1AgaHAycQLVuD/DHWbCyPcRlQYm5N+O5eFQFjVM4tAA
	GsK3bOQmo+n1jgTmrQ46Xn63EX1FjDxZTBWN0HKCSaUSy9c5v0y2CS1VZg2Q1A5Hu6VAX9Z7aVc
	Z5qJE2duTc06FtGmgXz2h95VNqjkpJjr+nn8/nfNMTAEzOHaKdJr3zZoL9Nt41G9tIS91Y6NLsA
	J8zHMCP0krUNmL1j6nJ8fIs7zUID7wk8SaLKqvy9PhX7GQZwSdEmAnQ6y2XGuyMU3eAZo9bK1sz
	0ODwM7ubUlU5atNl6BN3qSfbchs7JDw3fps6fXTdeZxGAjI2f0zsIsjHp40i69BGl237mNmPoI3
	H1mhLc9mLdvz6aodGdvQmJqXHqJ9cEDygFbNcBFlZeDUbl7yCMeVi2H764dNc4gSsMGvzI7OwFO
	rkiu+1RoCTG+uYOyl0GuO957v0h+lvEKJPT506+MbiAHK4hbh1BYsWiskO5n+JQixJPsqr8DEGU
	yk1zEjdbA6RtoC5cHMARsBC3ZXaSywuC15/Vsm8ay3ok5sGX0z6fRh0YNtuy/O47XwrxuT4CyL3
	UEv2B1a/V+VAVruWxZa4RINfqTqHjhnsfVoOfWdr5VEFVLNb5fcVvTiHVKHO7WA=
X-Received: by 2002:a05:600c:6819:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49cdd41ca5amr23361785e9.6.1788218137195;
        Mon, 31 Aug 2026 16:15:37 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d6e9cfsm957147f8f.22.2026.08.31.16.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 16:15:36 -0700 (PDT)
Date: Tue, 1 Sep 2026 01:15:33 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mukul Sikka <mukul.sikka@broadcom.com>, Keerthana K <keerthana.kalyanasundaram@broadcom.com>, 
	Stefano Brivio <sbrivio@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, Bin Lan <lanbincn@139.com>, XiaoHua Wang <561399680@139.com>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y 6.6.y] netfilter: nft_set_pipapo: restore cloned
 mapping table memcg accounting
Message-ID: <apYKQbvpIWvY8Jqi@gmail.com>
References: <20260831194905.45045-1-kmehltretter@gmail.com>
 <apX9AZoNkpVrBMIE@chamomile>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apX9AZoNkpVrBMIE@chamomile>

On Tue, Sep 01, 2026 at 12:15:29AM +0100, Pablo Neira Ayuso wrote:
> > 
> > Fixes: a4983e89e3b1 ("netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR")
> > Fixes: 32bad10de347 ("netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR")
> 
> This two Fixes: tag do not make any sense to me.

The two Fixes tags are for the two stable branches:

- a4983e89e3b1 is the 6.1.y backport
- 32bad10de347 is the 6.6.y backport

Both backports changed this allocation from GFP_KERNEL_ACCOUNT back to
GFP_KERNEL, which introduced the regression. The accounting was correct
before these commits.

I used one Fixes tag for each target tree. I am not sure what the usual
preference is here: one common patch with both Fixes tags, or separate
patches for each tree. Which do you prefer?

Thanks,
Karl
