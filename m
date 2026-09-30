Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805650EBE8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778269; cv=none; b=ZEEg6QI31h4NKxhYuFWhl+JbkpG7Mt/5Hqi3mUHpn1910dzi3Y1giEdMxlch1ACW6e/DqxtDzTwq2GDFfeEcvrA39onaJlXePJAYIKCO+JgTpFCq5WcmaW200YYnW3A4Y/I0xtQoOTxHMeBRYxg0cc+Aj7l5BQ5so6Gzu1bYEfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778269; c=relaxed/simple;
	bh=IYJIMNtdJcCr4u6cOiHPBOmN0vaj7VFV7Qc18iDIhTc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jpNWxGDIFr304mtQtkHm1L3lnI/zME9NdZMmiMSvpJSb1uEWvpPjjtKBxfBfKsbMHJ99KFX0gYX3PC0O+x6MiJIGc3E9vpffsO0mcd1oFzKJov+OvZ1JWD+BWC/5g2dVisjElUKdYkZ4yNXr4NHu8lxR0M557m3eFMAVjxo1p1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gctlW0aB; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gctlW0aB"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4ab201ebso5185692d50.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790778253; x=1791383053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VSBcqx9koa8CG47lz1u32c2OePWRmcPOrAz/9TDxhs4=;
        b=gctlW0aBm4DLTLgSxnEHcWgiUl429uuP6GkZ1zsXBUrorWGOk3IvMZLNoWLUCTmPe5
         EHoxCT7Gri9p/hMd2O2WXit4LgM3E+bUJ3JiYNvuuZFKqG7DK6FwGLDP7kYhfGt85E4k
         R7Fifqx9zWevLeyGv63jc6PR399/An8qleoVSrkdWAbaLwvsGjkiQaJG7i8V11GCzBED
         9+LYHmDQEa3gbrg7mOohtHu+GgvzP1h6flB/0DTxyi4lVT9Ya0EETjTac7XbE7wjf/QV
         zWds7vuSOafFahbeolJxAJMChIvxkMayHd8RJ2l6X7YyGY8p9WArV03uZy648Kr73aev
         jiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778253; x=1791383053;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSBcqx9koa8CG47lz1u32c2OePWRmcPOrAz/9TDxhs4=;
        b=wFU1aN7YDlXhrc8kdTtjtWajPGx/hnYptdsU1wqWuJrruycW9H1aW+8/f966ud1zic
         8g8pXmsfuX5jJ+yex6oDwes4xAAuDtSwuzktOa5VLfUw3HI+51c40k+0rHA+BUyxE4m4
         D9MtdiGGRP052UPbcM/sxTYPV8SMzu8jzpPCVhCFX9NvFBgtYmGlqdDcoeY8/a9Qb4GZ
         QrxFuHg2CGcss2qWjewegCk6uC6hOr7QjNoWUh+51mHBoiOg6woW6MhY69mSsa87ePAQ
         pNK8d2uRdQ0j9+xUvzWgWWbyo9aIY/Uu3uyKtFrhdD0z10VJsJB/YTCJ+xWyLs7Xzk4R
         ak2w==
X-Forwarded-Encrypted: i=1; AKwUvBwE5fp2MYz/HVnfwv8NWxnxnJ9tHC3eMmULf296ItFj15VGnh34dbd7mtnOPQ0b6RJXNDPGrSc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4wiet0lk/KDS0U0jU4RldZeVvi4KC1VbuS9tfFvX+IST1+ajx
	ysMV3hj4seDNgeT99gtDZ6MYZWBCwnV+ZWTyyhKeTmVey+nynRPDyoty
X-Gm-Gg: AYBFou3LfAu/k8JXJdUNht+RdkZAbCPJkFqnou5Km4juQL1M/LSPR69FDYFq7pol6ZY
	5tazDd6VieZM3tl+L2uoTrq0Eo/McDb4mOPwmnjYMrRIMR+vAOxHlwURI5m6nHJC3Koni+8lQ9W
	hS/eeWW/r4+XK5Fz1oab8kzLJ+m48Eqda8B/3ES+avl25ZAb+XXPyzD5lq/cXHb0M0Nh69NW6rR
	pHJJpPq8Edcru5qJppM/mTXGEX7hhIUrRI2GSbPW3nH6i0DfYAOKZ6vBWwloQVM05BwfRb3HDA3
	mImtbUW7A/KrZvVyOnSVjuIGzSV4GA/2k3nE1HgIlBAC1uwPTzxhNa6V1u/GRQWR4R8dBSXTM4z
	Rn8o/ER2rwU7gSkB57xDdu+7RNbahUerZr9jNMBElO7akB8E4MGgSc4SwYPSYqQlxLwLpD2be85
	OlKoSu5NdNEQ600u0lXi70EVnmP2inxvLq2PU9KwMfuFmiIav7uJaGjeyAmorcNUNzDN24Bw21p
	DWNb6dmXh+6Y70ysu2+NqyS2EmbwYJ6YJgp31d45V8Z2k0N03Ur
X-Received: by 2002:a53:d014:0:b0:66f:c1bc:880c with SMTP id 956f58d0204a3-6768349e783mr477179d50.101.1790778253013;
        Wed, 30 Sep 2026 07:24:13 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6768152d0a8sm719338d50.14.2026.09.30.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:24:12 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:24:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: lollipopkit <a@lolli.tech>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.276ffa719c8ac@gmail.com>
In-Reply-To: <20260929153426.90278d054c98-a@lolli.tech>
References: <20260929045433.59435-1-a@lolli.tech>
 <willemdebruijn.kernel.570e0a646f4@gmail.com>
 <20260929153426.90278d054c98-a@lolli.tech>
Subject: Re: [PATCH] io_uring/cmd_net: drop unextractable TX_TIMESTAMP skbs
 instead of requeueing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

lollipopkit wrote:
> On Tue, 29 Sep 2026 11:06:26 -0400, Willem de Bruijn wrote:
> > lollipopkit wrote:
> >> Assisted-by: Claude:claude-opus-5-5
> >> Signed-off-by: lollipopkit <a@lolli.tech>
> >
> > Is this a real name?
> >
> > https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> >
> > "a known identity (sorry, no anonymous contributions.)"
> 
> It is not my legal name. It is the handle I have used publicly for
> years, including on GitHub (https://github.com/lollipopkit), and it is
> the identity I sign all my kernel work with. My understanding is that
> this is what d4563201f33a ("Documentation: simplify and clarify DCO
> contribution example language") intended by "known identity".
> The earlier CQ-full fix (3a3d93070c5e) went in under the same name.
> 
> If that is not sufficient for this tree, let me know what you need.

The commit you mention did remove the explicit reference to pseudonyms.

I don't know whether a github handle counts as "something we could check
back with" or where exactly the line gets drawn.

If anything, this does seem an outlier compared to other sign offs.
