Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AED47141A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248222; cv=none; b=P6c9sm5j5aP5xCKR+epm5GZEBVEHewF4o9HQ7jnD3RA36YV+29+JJCc7fSrah7zbvUDopb9YJcWKvt5BKsQqYtfJZEftsDqmsRaaFoYhSEDyMlLp7c3+Lf6TzXd0t18uhBjxhWmS1GQonkNdWmpZ6c5NK6t5Jsdz6jrSWF1UzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248222; c=relaxed/simple;
	bh=azL6pMfssI+o4ECBFo82B22ejlVXeit8z7j5FK+aJfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOVIJi6HFb9B9L8TxbyL8aFRssTbNSW1xdI9LHzl0QgfOxbsEd2GJzLtBfQ+U0hkenzAPgOAPMECUte74ngrt/0vH1tRqIvBFW9aPTaEjRtnlv8xnDejWo4Xb+CqPg7qDjHhMy5+3G9zyL31vfixX1v+fQ53921xb3+K/j2rlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKXuBNHU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKXuBNHU"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aec201b582so140881e87.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787248219; x=1787853019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jFMUvzYyyAGffP4UVV5ruK5O8NFOvkXY87WGr65ihE=;
        b=EKXuBNHUhQabJzXgvkEafdwQxBYUfaB8PCYxTWoXW5+SJTPQcDSJiAaOiE8TwcPI2G
         9GQBntgiatGHZQtjpC72sClJe6UldGgTDYyUaZHl7VSRmZEs4pUZBzCynYn373dRpH4/
         whSIPpmNh+WmH7i1BE/lCxCa08LLJYjs4hU4MZOWn2NnTUUpglQXeuCPmsmFKQp+FjT6
         RfpJGHoXV3wrnR/v+R9/UeCcZoWDCjkm2w/d/jiqM2n5lQduGxTF+lvT6/RtVGt9YYx7
         B0qWRE/80rP1a9GvBEU1Xuk2AtFtBrT/w5dRchJsouqdFuA+cHJhP9rMygbb6PagM4hS
         3I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248219; x=1787853019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jFMUvzYyyAGffP4UVV5ruK5O8NFOvkXY87WGr65ihE=;
        b=BCMtk0uVqSyJsWsKosQbst/WYGjWsMcuIUNJT+BdrEfas4/sC3z8uFNJ6PEgEPJbRL
         fMznUWI9ASr238B96oFDczCDJ8VF0zy6vDQPRcne4xhUYQ4OWWUDcSPf0Mi6pxAY61cd
         i1HPKG4YVikSeE2MWo9DJpcIWg4/fqBKq4c1cdJBlvqN8iQorCMdaH8W0xZynDhJLOEK
         bT4xZEEap40RjOD27spmgidaE2kbdpiDrQkD/aefyVLsCLgnV2c+Z70wC3XWpyDfHfGK
         ihdXvdMVKX2CQlZj3JNZsh57fdA7X9VtdCTW4k215IEwQ2jXH1xRthDUl4AOQatxkvdt
         tMgw==
X-Forwarded-Encrypted: i=1; AHgh+RqRi024wsD863uMUitcGZwPuZKSv6ExEnu0comag9qS/AvZ5pmMEsxqPr4oWVLnPhn3LZQSYBA=@vger.kernel.org
X-Gm-Message-State: AFuF++l0hLmd3s7Ry16/A2xi/zk5/jtvNACLXgsrLnpPTFiDBcf2XNoA
	g7y8FbZog2MbXUR0oV7yhmvuUbqzwIDtskM/aKade33pk1WOEBIcwiD+Cgmq6Dkq
X-Gm-Gg: AR+sD13LYpcPj2TR7t3a6+9evBqdtsnMdWcBpS3Ac3Xv6+0w6l1m+AtogR9L07NrW7g
	RyBwU86PLJWGOVh0mJJGV212hBRuhHNJ8zADe6Xy6noqFqaP1lcjxzDvYqHIIysqWEY0lEo+FTu
	yoGv9FLeBE1ZPn1fTr2/zx0PQWEI8u9U8Qpp3a7gPOd5xstAXzctCx5CzqtUmUAkAEygZmJhzi2
	LyA+81QnEoRTTX65MUw3OwspgZCvwlDEio++RhzbeaoxVX8sB2Vfb0GpZrQpl9cN6hpHeVNO1sb
	UNCeGOtUrkQC9cIy2gqMTwQfVDyPhN8cBgKxcuR0pW48WWMK+z/SjoaKWdt7kNNev0bWOJ8Zu0M
	llgVHG7aJj2JS7xC9L/HaxbdEbMDKZbMRmFs0cVgaivp0OGFhyo1pFvcE0OAXpdX8jph7lVleL6
	7WXTHrdF5plRCJ3ouByyhnGFk4dxTItj3cmRkKi6m+Y8PT8faFacTrTDljhXAG4PWjShKf15LMw
	WE7KDM68F1X5++lKpI6AtPwHbkcr2st1mykCG+OtLnOgOE5NAWLCyLQuSqKaFU6wPyDszIToabM
	Lhcxd15Nrp5h4hV9tSi5ovTPg1GUxZ9XeB5WY4t9yf08Yrbm1zx/8koZ7u+H6Da7kpaeQPo=
X-Received: by 2002:a05:6512:304e:b0:5b0:22a6:6b13 with SMTP id 2adb3069b0e04-5b48408197amr57328e87.0.1787248219056;
        Thu, 20 Aug 2026 10:50:19 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a476-1a01-141e-2b69-987c-d72d.310.pool.telefonica.de. [2a02:3100:a476:1a01:141e:2b69:987c:d72d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478860c85sm1419706e87.35.2026.08.20.10.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:50:18 -0700 (PDT)
Date: Thu, 20 Aug 2026 19:50:16 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] selinux: preserve user SID across nested backing files
Message-ID: <aoc9pAzSVOzCaHS5@gmail.com>
References: <20260820061349.10542-1-kmehltretter@gmail.com>
 <CAOQ4uxhgMNvFxauLzm2PQif_D164+rJqmGdU5T+XDfhMJTVJnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhgMNvFxauLzm2PQif_D164+rJqmGdU5T+XDfhMJTVJnA@mail.gmail.com>

On Thu, Aug 20, 2026 at 04:32:28PM +0100, Amir Goldstein wrote:
> Sigh, this is so confusing.
> 
> The fix looks correct to me but I would use a helper selinux_user_file() akin
> to file_user_path() instead of open coding the condition above.
> 

Good idea. I initially had a helper and should have kept it.

I'll send a v2.

Thanks,
Karl
