Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4E265623
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 05:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786511246; cv=none; b=XUjD6xzrAybjWc/e1+suSc3D1N9As+3h1D9SP1i7zaCGLlSVNRVQ555bAUkCWRzrviP74u9g18GQkIPQtOq8/G1Q2sD/rO2fcen2Q6CHs4hgurz0nuXcLoGFFX2BZlFZlwY0F/NphDj4Bk0+EV4m6ThkDgAd167WpqDFTxJT0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786511246; c=relaxed/simple;
	bh=xdr/FFYfWnJUmcdox5w6aHTt/Z+k6tz/pLsaEkE6Fvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTP76aNLk7/FwDPzy+j4GKl5OWzSqcFVGgT+lXhD6D4HB8cL74oPD7Iu5FupX43Y1O8zcbwO/j8rlMKNacoGTN/hYbUWRvI71XTIjK6ozEzX/0sYgUc6YUkSCaJevI32qM7GI0zqJuRI4HkiPWhoaqJ7NMGW1+ZdUNa1+FgQpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J4hnmaKa; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J4hnmaKa"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso854890a91.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 22:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786511244; x=1787116044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76eyEhFrkTubm0JcS7WMtMOkfl9mDynN+RSxghBPkWM=;
        b=J4hnmaKaV3zMO8BM5RNEZ5E35F8nr3oTv780esz3n2vX2ohMeDOhbP13mex5NGqonk
         v+Axadm1LM/zxPYqMC844Umnqx9VznsFz8ksebX/4aeWkGLi2oQKioHGpZ4xvOYdlHAd
         +n9wZf/odPRoAOJuDgjFDiVPvCFZxLsVoqlPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786511244; x=1787116044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76eyEhFrkTubm0JcS7WMtMOkfl9mDynN+RSxghBPkWM=;
        b=oe02u/1vw6wDm/m/Xv9VIoI3RiFc5AkuqjJ/SIHlc2lulWBs+RFvukS0R7Vqtu/CGa
         Gsh86zF6XGpxOnk+sxBo6TEZNvcW57QZFCfnONA1bHgwHm0huM6ALZT+CcBRS6RYSukV
         GBx6Kb7pbcmihVSHuh5pFxn3cGHrcyu1v91z0spk0YFAdoJI7kiJJtkNOPho1aIeUjfB
         1eKqyqLAXBjaOFWINRkykMdtaAuKvT6zmieZ5b1b9Lz8tt/6WyrKjWVWJi9DCLMQtWQ9
         Euve0X1G4NrRcxhGityV7fFun5fESyHETIB8zCE+Dw5rRjy+33PRr6+qwizkXhc4UzUP
         W+Xw==
X-Forwarded-Encrypted: i=1; AHgh+RpRX32I2+xPLnAiEfVAJKBzh5HoJwST9y+SZzb3O2P3YfxGXdBq5wORi3VC7xm4McyIr7vQwgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DSB3pbgBkgUehHkTI0I4fnBAG9gI2Rt/3SLA2mlRD5pIkQsX
	SYpOLOC3Nkhy3RNlIxFxG4MrRIx8P5/0WsBmEeGIFjjM4Cga4rFILFXrGlD0BpIc8g==
X-Gm-Gg: AR+sD11Th63jgV3m5GyOJHdGoFvg5/+HiQdtRkwlBkwtiZvAnba3Ex41AdgXVU8hNPg
	QIbwIDyb9p3sL4eBBk1MlxePvElVvZugD4P467lAJNe9YUp8v6kVULHkNk6tDHeIYJ0E9VRCCCj
	j7xbSEB1tadej78K1CGluuMBNMfeQm2B9rjNmy6ATPhwBR3bD4LGASfFBdXZJ/IHtqOIg7Oyb7/
	jmBx9e+Lir1NK3EMcce8NWnaUf+ZrTftjXYnz/y//dfozT5QuLIQVZdeIEO83P2plcyPg4WpHZh
	NQVlEoK1uU6vI0ZEM0dEaWo/5glKe+WcMtfhsQB56A0ir3KPNSWdZQcIB4G9YzrjqD+Mre3GlwC
	/XqzGfhqFk32z/EQ5C2+2iDG1N8yVZ8gecR5bl8kJafUPGZUdRmCfUGk3rrSPpeCF+tOScmGF8Z
	GkDnOd6V9Q6ef+Rae+qUlNEWOTLgGPp/opIm2Rpm/mKCFr/iSGbqbAuchLUbhh8oyRcWuSW8bD9
	UPsXrnEr0NFf3GDLuH4aRqgvDSL
X-Received: by 2002:a17:90b:2f08:b0:38e:2f21:3bb5 with SMTP id 98e67ed59e1d1-39301513ef9mr2913619a91.21.1786511244086;
        Tue, 11 Aug 2026 22:07:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:6d46:aa38:60df:e1e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f908a82bsm2052641a91.0.2026.08.11.22.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 22:07:23 -0700 (PDT)
Date: Wed, 12 Aug 2026 14:07:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: "IP over Parrots (with QoS)" <opensource@rfc2549.ca>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: 6.1.y status: 2abd5287f083 ("KVM: x86: Check for
 invalid/obsolete root *after* making MMU pages available") / CVE-2026-64561
Message-ID: <anv_QkW6fLzPy1_z@google.com>
References: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
 <ans1SMXHmdB3uEoe@google.com>
 <antH6ysN2SPR2gyV@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <antH6ysN2SPR2gyV@google.com>

On (26/08/11 09:03), Sean Christopherson wrote:
> +Sergey
>
[..]
> > Now planned.  The fix doesn't apply cleanly to 6.1, and the resolving the conflict
> > isn't super straightforward (though it's not thaaaat bad either).
> > 
> > https://lore.kernel.org/all/anpVAhjqvBvIuoa0@google.com
> > 
> > > The security tracker [1] for the Debian 12 stable kernel (6.1.y)
> > > shows a vulnerable status.
> > > 
> > > I do not have a backport to offer, so this is just an inquiry.
> > > I am happy to build and test a candidate on 6.1 if that would
> > > be useful.
> > 
> > I'll post a patch today and Cc you (unless I get goldfish brain, in which case
> > I apologize in advance).
> 
> Actually, duh, Sasha already posted backports[*], and his approach is much better
> than manually resolving the conflicts.  Testing that now, I'll ACK those assuming
> all goes well.
> 
> [*] https://lore.kernel.org/all/20260730121535.2208491-1-sashal@kernel.org

Good news and good job!  Thanks.
