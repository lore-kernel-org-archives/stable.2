Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9721F1534
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043216; cv=pass; b=qn628YGI7HMSl0aH7Dh7SzBwi+fYzdaYRY/BdVJUg45VNTCx2rbeybir2ugdGo7nrNGt2qA/+qEyE+eEQyol8K0hrZ+8/F2r/ftvYpm8HKvHy3ExsglVp2Q9Ed5LUzNmqJke3ByfMvFC3eogxsciztwoV8sqeiqErer6ckb0YWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043216; c=relaxed/simple;
	bh=Ap/YzZGyzo2cO+qILnS+HOrD1LlO3Fjr9oA3SoqgiQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnWG/fM1E+tFWO1NvU+iXyf/ovqRP+GrZ9s2Z44Bqe5NRWEEjlm8Z/osAnBm0iYB7nVUH+GC4cIoL3s0lu+zgQnyj0iuC8amnjrSk6tDROTC5fTe8nhHqwxhNjz3sYn59jZJd0QTJQRblEkX/jjCjjkuaCs9Ynw8qoKx0vOzjlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn7o6r3g; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn7o6r3g"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4ab201ecso3171431d50.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790043214; cv=none;
        d=google.com; s=arc-20260327;
        b=dO7Bbv1PkudVG5ZNUFlnmyx7pGuTicWT9f/C2UtMxe7PiqLyR+m/sOjZRiP11CejhE
         q8uKTOCLxHrxP/+SF3LPJVn4J8YMgULfmJ0cHWvag20cCNNK6E+DTDYfo/Ck3m9+J0EP
         GHIdEb13aCrm8N7Eom7SZP6uEdmEy23UkgTZpSZpL7/jIiwMIB51vyciIItCvSkfwykD
         g/cDYZvQautPDMeY3us5QbrxQlLrDd9ZLx1yTjjxSZUXb/Uy7+/cBR8HDjfKNuixhlmo
         7ngBlAuGLQQMqagTaeZTUyVRm3nu8xdTxHGzJHrY5T9mK9Lbd49X4390HerSjjumw6bO
         l62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OCxAavhsCK8ZFakY3+2+r6Yw5rmMKHTrZRwA8H/yqhM=;
        fh=0wZwb3ScWYKsjiSSa6QXgbMjw+w8qwoIsq/XkSDtUTo=;
        b=Qizc8oZZ+OBPry4rWabDQa4terRJmhhYPDnPTE7esNY9Cu69m7mFk8sXGI/VWrQuH3
         HvO+nTMpKAWoSvJR1CY2aHVXQ5+DFLTbHFP4qGH0nCfO87lYJVA0GbRUpTUHmNzMcYBv
         kAOxRTqBztIbzHfGRAssRNWXU6aIoSXVfxPJYLMEE9DGHgclfutDRpkOZ9l4UmRjMfUC
         Pg6QrIwiChT73+t1En8Sw2dRHy1/w4Oippwa7LOkgFHeixRy2XYWodG6qZbq2HlvUs/K
         r/JhO3frmhXqUUIlajB2yYLaghOCbl+SHfR3v4RjfOi6iMNNDqac6IVSpJNfN7l8gcjs
         5yig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790043214; x=1790648014; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCxAavhsCK8ZFakY3+2+r6Yw5rmMKHTrZRwA8H/yqhM=;
        b=cn7o6r3gMueb+t4GKFvoTSxKU1SJovRPQ+4SbRkDpdy3j/ZIb/rqwd8WMrH0u94Gt9
         dzrto80zXH5FL8YnwxOAAyG2KHbw6QXO9XnR+iYVc6kQxrxUUhSNMBPdaPnM8laUPYW5
         DzAkkf8yeyLQGHxr//dkZNYMfXhGv/bAgEMFJp1g1H8K1ytMAPUq6LZGSHfAE6prNAnF
         V54tcvc1AMnt3aBhOI2QT7UDypM9v3QVVTnTUWwHIapQfQmo9r9gVmLHX5TeLGHzNzHU
         Qnw23dIP/MquuXx7AXzJioBQ2Pr7xOOiDOb6oDFkKEDhrZKUJUeJTSqilIl0LKC+7l8V
         p3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043214; x=1790648014;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OCxAavhsCK8ZFakY3+2+r6Yw5rmMKHTrZRwA8H/yqhM=;
        b=VnQGOQbImhyzL1ED6XFUt0r0rw57m06XhhmrlDrl+3eSGXJFVX4gcUa7QeG9fw7WCV
         hWK2pud8ePdRY+4tyG4kQjsgOY9MsRATFT2RTOSR4CnFE1dfHwHw/7nbaoD5wMlTdRtA
         6g9Fju26WKGHoWfdDK0eJQANj1C14BROJ5rYRSa+m4pnkqMBeYOyEuRjacfSmW9DLEYO
         HS+kW/3rzg/aFstaqZmgqIUjTHgbte50y8GqfpLXxbgUFASwgP0NyrEhh5cKC7b/F+mU
         sRyBkijLw054SjDdN0QFU5FL1gGF/VszGiAhWw/yqBNf29On7npl1q1pQ7o+qzr53rQt
         iqpw==
X-Forwarded-Encrypted: i=1; AKwUvBwRad10KgcWz0IiJlyU9BfbSrEyzl17uS0s1zkNVLj815awwRc4uiXh0i+lc6Zggc+60cB06Dg=@vger.kernel.org
X-Gm-Message-State: AFuF++lFb60rFb6F7zT2GxMbPnkcfcDfFo/gq1nSqDahvMwOVknNA70+
	bX1nMEUp86maXFYOmONKY+XzC/T2YGfqzKPTE6tAG1VsFAX1+/F9vHdY/t7Zo5CPVHIfJ5DfGUa
	SovPDo8QTwb1IUqp1DYmobXNJjIeXnJA=
X-Gm-Gg: AYBFou3jJS3HeOwPXdtG/AcT1GQbdI3PmliX4ofAG9wY99BcUKNZF/7sCJ2XGbJasEx
	UcNqepVHFbDSZwAbl9QcH1ZiPHeNmQUMLrC3wqzIwKOH/EJyZA/+k1D7Ref5h8juFkCuLJovQNN
	5HlHqIWkaG3/lGOmz4P/DkGYpUDJW4os6G2T3PJIKXU6id+NdmN7tQJ0vqdaaqq2npbmXdM+R9J
	44VMQZrajZEork9zdr12cEeAoQezeshnjchlrpEXMmB9J0vGK1DjksRXmmjLMxDewQsn47yUNFH
	jTWSneaHffiFUEC5fCMk4sE/AVoXfz8uTbCFoqPTN9gs9heMNPhk5ythYQ==
X-Received: by 2002:a05:690e:4192:b0:672:99e1:11e3 with SMTP id
 956f58d0204a3-67299e1168fmr2220506d50.128.1790043214123; Mon, 21 Sep 2026
 19:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916063118.2924049-1-lgs201920130244@gmail.com> <arFJ_2HfXWuWCsUO@quoll>
In-Reply-To: <arFJ_2HfXWuWCsUO@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:13:20 +0800
X-Gm-Features: AcwNN1VtWhrPTDbeTQKN8w96m2efeF0oPfkRnX5dnHLNyPZ4NdQAmU7V51gzM7I
Message-ID: <CANUHTR84U+tLdA6SCqyB9p0PnZ_Six0nD688goE9q8K2qvXb3g@mail.gmail.com>
Subject: Re: [PATCH] net: wan: farsync: disable PCI device on removal
To: krzk@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Kevin Curtis <kevin.curtis@farsite.co.uk>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:15, <krzk@kernel.org> wrote:
>
>
> On Wed, 16 Sep 2026 14:31:18 +0800, Guangshuo Li wrote:
> > fst_add_one() calls pci_enable_device() to enable the PCI device. The
> > probe failure paths call pci_disable_device() to release the matching
> > enable reference, but fst_remove_one() does not disable the device
> > after a successful probe.
> >
> > As a result, the PCI device enable reference remains unbalanced after
> > the driver is removed.
> >
> > Call pci_disable_device() after the existing interrupt, tasklet,
> > mapping, DMA and PCI region cleanup to release the enable reference.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/net/wan/farsync.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
>
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
>
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
>
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
>
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.
>
> Best regards,
> Krzysztof
>
>
>
I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
