Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D683221DAE
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027449; cv=none; b=cDxHK/VQHkP49djYjtYJtXM4gVcnCuZQtzc8jQ2agb8fD+jhcUMaHDy1SXZ9xFXqMqMDSM54WTcunztoboxgnfUwkT5Nqc94wDgp+XY3Tql36nng6elXyeAoyMbxuGQh7zxQDQvnt7G0CKZdXW/Wzf16t8oC4SXvT87UNUFLFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027449; c=relaxed/simple;
	bh=z9IejdQXBKN2xrBOvxqP4WqQ2XxEUBaD7+MG4NCqXFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR3NPAlZIx74Opj1lgCKX76OFsSN1E+v95V+Xyg1XNrV5pcGW7N91HPOjkT6UaNciCDUOIGDMtEF1kCrbNzQXZfRulive7qiXQ34CuNLD69rddlHDjuCiJ56FqHiwVmjRdmYyV5TtHv1FRh9HrJqPCax8/9t5TbpuuLeGcvX/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVsKXYh8; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVsKXYh8"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso4994124eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792027447; x=1792632247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pr3YDdQf42YciJbBmqsTzbdgVNlR+zDd5aklF+kUUxw=;
        b=gVsKXYh8oI3j73RXdg+N2/50Yqu0mBRjs+mBMjNaUX0GZF5sKSXqMcJtCEfD0UIMZV
         bte7MaU4U7nLKZ8AaDOAOufyM42mSj4CiG0U2Xc85bTodnXiDMhqF+Hmk2VXZwybKJjS
         Zig8q5bwGvOldb5dpY5A77qm96ad50rbk5xX7BHm4I8rFCKnZF6Gvl9gr7hQVAp92Tk1
         cClODOok6t8KqSpbNEXlXAJ/W6noUWy+PTxc7VhYqgiCT5pOiLwjn/S9mAXMGApYMONm
         sb3v5zEmh7v5DQ5AUvs6fB2yxCnLw8NewiBNi791kbbDzpa10xjf7/65urLw932/m1mY
         1QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792027447; x=1792632247;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pr3YDdQf42YciJbBmqsTzbdgVNlR+zDd5aklF+kUUxw=;
        b=snW/WTLQoW2cKEKZNASEd9JHZTd4F11A09NNAtB9l00Jey9L2iyJw8GNzeXhM8i+Uf
         Ml7kzPhPp0n8YjnxeSHGpblSzg6iW2FbfWeQcaXEkjp9tORZSbkY+KrdlbiRoyu/f4ak
         mED+FcTNzgAms8lkMbNHG/OkGJevgk+lr89M+FTEXSdbv6qd9oQlgMOYUFf9wlyy58+W
         K4FE6vm/7M15aH9YFW7VYF2PrrYXeOO3buxhJhikQmOjtixTv/WCIY9+qi15tFaCLOCV
         Uujpufd3eZnmiB77BUsMhYRUe4IikVkVm6iMe/27Gr4VXz3HZ0B+S4aDVf9V6C6rVjiZ
         cOGA==
X-Forwarded-Encrypted: i=1; AKwUvBz2iicITG+B+jf+0WM5O8NX1fS/1ewkmX1b7PoY/V9McBMP4JjwASxwcmVVqznn+hXKqGGJDbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3awgWX4dzRkhuTH0wKtXu2as3HI5PFvChS0u99NLddm311kVE
	ksqrBlRyz+fF2ddTaGrKFrm0ZvM3Fj4f3QmykY6v4Vmr7oKK0hyTTvB8
X-Gm-Gg: AYBFou29fUgKGyZ0TDCx/1XIkjlVL4qlmupBosmWDEehZddFk82C3juJ+nyRPLOS2h3
	37pY9785Bb4V11tzNPJqvgtWAPEEr3+EAiR05e9fGjmvnylaJm6dJWSo6LM/01/fJ/sennqZTCd
	kaeTNdvKXmUB8vbaQtcbIt+o+BpuiBaEs9VrJzZHz/+Ed4hGlK44U1U8oyglMxpQco8xN4s6SSz
	Knf3uhdQgRuIGpyLKVJZC+7rV1JqBV5DlmcWunjar346bsWj/vwzEHwANUcHNfDrCKPc2OLXjHJ
	tUGODs1QQgQM2iSVrYcvjGQOu0AVySIh6JZPvzJs9P7gNErf7so7gsJxG0bFVqcr245c1Akg/c5
	WFoAa9xnqtRLrcc5FdPEVAj5xmx7Sik+jPv5vH+GromeYo0OCFbGutpq6vm4722d8WB/Ct+DbvO
	piMfzIPHB9XF9IOELliswy2Ecr+XVd9KzGnOQMxjkarsxHKfWscN/tVdYWGchrSDknnWAPSsVuu
	/MvYIdtlQLGD4Th0DYo8hrIRnukU/bOQ5VxOsk=
X-Received: by 2002:a05:7022:5f11:b0:14b:cf58:ce15 with SMTP id a92af1059eb24-16a638513c8mr22744863c88.43.1792027447321;
        Wed, 14 Oct 2026 18:24:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:821:261c:74c2:4177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1761ed641ddsm24901872c88.1.2026.10.14.18.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:24:06 -0700 (PDT)
Date: Wed, 14 Oct 2026 18:24:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Daniel Salmun <salmundani@gmail.com>, =?utf-8?Q?Rapha=C3=ABl?= Larocque <rlarocque@disroot.org>
Subject: Re: [PATCH 6.12 130/497] Input: synaptics - limit T440p InterTouch
 quirk to LEN0036
Message-ID: <atAmS2YluELR8LVH@google.com>
References: <20261013112907.864180619@linuxfoundation.org>
 <20261013112910.975677311@linuxfoundation.org>
 <8868e018-3be3-4de1-a066-5bcdf7aaf124@oracle.com>
 <2d3bf713f9e7457f884f1908@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d3bf713f9e7457f884f1908@kernel.org>

On Wed, Oct 14, 2026 at 08:08:43PM -0400, Sasha Levin wrote:
> > An earlier allowlist match can succeed while this second match fails,
> > allowing board 2722/LEN0036 to reach SMBus setup. The parent rejected
> 
> Keeping this one in the queue. The kstrndup() failure only matters on board
> 2722, and only under allocation failure, so c1df7e4e4951 is not needed.

In practice such small allocation will never return failure. 

Thanks.

-- 
Dmitry
