Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8BA38D40D
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942865; cv=none; b=rqD4wWEAIofU0TT8IICjh9QgE6xf1u9XWKB5CBnGDAmi42lX1g7jDTNYsckhx1Ca4RV8oGRrz2M860OBkx7XSnUKUM/cj0heEVLRulz3IxW1o/f0OBEglkUXsXjqHCPovtN0TjNlGTpcILhsP7dJq2fpI4JBkcj1Ych97S0WMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942865; c=relaxed/simple;
	bh=9FrLo67VfYF3ZpnOVkaF8Rlr709oEukF8gtE+IPKx9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pnr0w12wUCGm/Ovmr05UgoygnrzpVB7Vp+A/eGE87gD1rlBEmdOh5eEiLfvhRkvCuPEhoCNJttIVQffkwmEnRpdU2/hjzzNyKRhNK7jb+7DxKrGw3s55/Qcx0A7SOad/8o7MXYt082eMtbi4S4iqHxNTqiIdq3tB3cq4TtMT574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSZZrx9Z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSZZrx9Z"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c19bad03so27495445e9.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783942862; x=1784547662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/WYgW+KJeYAWgpC3kzeRPmTrBu/4muElQjvrWC1UWc=;
        b=ZSZZrx9Z0qsVercscfNYdU+AKk1Pe8mahzDGSsoI6Z3VdL8OqYeqnsoF/S5IIFpbjF
         /GuFxpbJzrcv3CgAuVJFmxVcgYp37bCYty1R/6PFqfw8rtVbrkbIA0t+M8WPgLE2twiI
         0eU284Yb6xMWa16QAzx/4YucsJjVssm8673FMUZYxAKZC+as72JWi/3ztEBg9v/UcANi
         IlxWTJ+BkD3EAWATdngDmSw0322sisTkLmImpdpwzodFeH1PPmdFhdZ7aCQhzulQ0581
         jTq/nkUTs5UClzZYY2z6YETTAk71JH0zxDud+pwXDXcJIPQiMDnnBj0p/gH3nJFSxpJE
         iTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942862; x=1784547662;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/WYgW+KJeYAWgpC3kzeRPmTrBu/4muElQjvrWC1UWc=;
        b=Wo2XPdwFi3D70zkHqr+vtHJh+oEjyEkxQbsJ89mSUwXowsQeJa71pbZWkQqItu1SsS
         yE+85nP5o2fi6iGFEwGXEUaEknrAFl6X4CuIKg82ZrRADGwA5Xuedoa43O3ZTHExc+P+
         HXo46ej82wEnFgugDt0ZeikYP7qW6cv+4HWAH28J/zoaTmovLHnUfVBIkADBBJpBO724
         srXO1ArGGSwbw9HodmNlYtd7SOhjPbnv2kzH/5rZ8KlAKTr0RloFW8NuD8FjSttY3E98
         I7xhxcUT4zCDcrbgIIE+jOyBtLWmdVT8ISgZiniDsNA2Fjazm7r6kjoMJTeulsfo2NQP
         hycw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1BaHD+jccMNpVeUeOcL0RDv0IkHqn/Xa7mJZ2FGDc+NX77dlPhrf2s1Wqgq8qAp2lC7t8Wlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OkjrRC4y2kN2+Ika9CfaddyiyxFZriEtGCRVXmQs0X1wpz8s
	TZqrFaJiUGgEsEfHYDUwraRNkT9yqrRHLy+oKXtsEIUGShiOQ+uURzBM
X-Gm-Gg: AfdE7ck/6wvKr/MDW9H8FI7bWFwr+zpRyxaTx0Mhz1EtP9nxXaLlncgAaXR4SVpb+TI
	LVkiGC9IYPzktVdUMO/5K36bgXdBZRTE7KFPc7h0ELMq4rXym/18TbCtXqquB1lyLYz+Om66huU
	AfcAbm9CSYNM0GZ9p9XQusI3fa84y2irBq3O8kisOuTOjqMkltPRQS9uIlQqdZEAJkBrM4Hadek
	CZ0BzH2+LxjTsAC2PV4H1mfnjVU7Lg7QT3cX+0AOyU3n8lbtP7ZMoueaiZqwWJ4Ih3+c3aSSqZT
	qRYLq8hZkrrv/uZ0qn5ZaVZJnKxcVoqIlmQ04koxO4PO8RYiiZHPJQ47q5nBVqKGYsU1XyYviOS
	sjZdIIGBj2WjNgnLr2eAkUDx5VEN6nUTPnrr9M4pyy8RpKOKapGLLP+vyVwbmeIQUeslnfE4vW/
	McxGhDpCXV63FNok9QdLpE7kBBNRQY4b7TCA/3cx7JhiGoDzIQJJg/N50iGe5vLrji5/VBPLArF
	Z5ZnhC5ZBRh409mSg+5rEiFNCc2P9Gt815LsuFZ1SDZtTyaWe6FOwid7ssTCz6tnBk0f+moh5no
	gE1eVKTeJ2zV1js4hj1XXGtBzsWUdIf6EGbqTqjkT4hDqSrcuwzfM+46FiUCNYk/97dpzQ4XPpA
	YMVn7yWvhFdaXI91PHOjS9Lbfk1Xtq04LKA==
X-Received: by 2002:a05:600c:46ce:b0:493:bc92:ef45 with SMTP id 5b1f17b1804b1-493f8820951mr87046575e9.24.1783942862160;
        Mon, 13 Jul 2026 04:41:02 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f49755f9sm272718035e9.8.2026.07.13.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:41:02 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:41:00 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: proximity: hx9023s: validate firmware size
Message-ID: <20260713134100.00006272@gmail.com>
In-Reply-To: <alTNSJODSTsPWyAF@ashevche-desk.local>
References: <CAMyXUJnsV1GD0VmK_n25hqr_=A5Z=u_gCXV=oACgKuP3dSgwnQ@mail.gmail.com>
	<alTNSJODSTsPWyAF@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 14:34:32 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jul 13, 2026 at 10:31:30AM +0545, Laxman Acharya Padhya wrote:
> > hx9023s_send_cfg() copies the firmware into a counted flexible array and
> > then reads fixed offsets from the copied data before walking register/value
> > pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
> > make the driver read past the copied buffer during probe-time configuration
> > loading.
> > 
> > Reject firmware images that cannot contain the fixed header, reject images
> > too large for the u16 fw_size field, and validate that the advertised
> > register count fits in the remaining payload.  
> 
> > Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file
> > parsing functionality")  
> 
> This has to be a single line.
> 
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Remove my tag for the time being, I do agree with the change in principle
however this patch needs a bit more work than I expected. Happy to re-review
once everyone's comments have been addressed.

-- 
Kind regards

CJD
