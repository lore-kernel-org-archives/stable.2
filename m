Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0560658F09F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964424; cv=pass; b=ZMQ/GqMPeoZk6rOvXhNleRUO5u2/+1YYNhlQLgpp/6iFNc1+1ZKVt67cMffJVL/7OAmroVfJaMDvk9mXPt8Gj9vgC6f6P4PrD3w9N2nrkyjWCTVIrjrqdRo1vSWAArmg05u4rldx6VYNuggQ8iF65FTDJwVGsUpRqpAsLH3aUTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964424; c=relaxed/simple;
	bh=sc3bVyIxBh0d+wj/LxXIb/GjWX9SGCKPaM9V1MhQnEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZmgPc7Ug4kpA/V5CBGd5dshwD0AUq8WMKjd3HFNz06PtrqXcELzH9bwL2nL+ClUUTUIdE1iqPr2gZ8BnloGj8sfPU32gL+AfllBaIta5/OD/ofOUh6hzFWaD86pcAl7YIf8NvsU8xReYrdr02s6025zZ8vhsQho7gAmFWUV+1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STCVCevf; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STCVCevf"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b1b1d128a0so3253116eaf.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 07:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788964422; cv=none;
        d=google.com; s=arc-20260327;
        b=QNKGLq5ICBo83Hpqa1mn6JTDRJg/14p+ky4/WCuN4J/w4ZL/OjeX3fENiJKmr3o1ni
         QKUtSfYOyD8QOa2Eu18VKn55lX+/zE9oxs7cmMVz1KG/1XhGRCk+I0gK9AhaC1WFEz6v
         b8u6xMjQ5Y+VPnI/CKp6ptoPlFXgXACHMbCDt3R42BXjrfWHpvbFIy9nlds+zELMry9Y
         bViImE/llT7nbCacK+x/EGTcrX17X17ZivUEeCZCEluxTjmF8x6D7FC5yM17lc4gLFJp
         DesGch/yb4jIwVz4dhk2ZRR/KlN5iObmK1Icjkkcwr3dINka4z8BBr2QdVO4sSSY6mHl
         gFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JrAGYZtQxHWbWrqLOMN89bORD52IltCr3/3mzUcj/II=;
        fh=4kNZiYeScguEHmuN3zWJewOIoG4z9YNoxi4Qj3L6248=;
        b=F4UjyM3e1hB5a8gny3jyXpD0Ibqb6SbZ+70rbu17jWeo/5Cq/4pqVY2qzZEJ/i/iQf
         GOiH1zuPwc3OqaELALjXkbOU780vFtSEoXTHyzT+YXo4bxcOnFaoOnt2SVxTsRxIx4lt
         aMH25vVSMZhtWGeaiW7lhPvy18BunR/exyO7twkXXawNlUtR9WMODsro+QIiNOMoQi32
         LFB8WTp07BXcM1D3Q5S/bNl93psXmTTXLoglYHPLY6Rpq8+BkOuFuX2kUQ0bEI3Iupq0
         7uvcjx+YbLi5GXgAJEJl521OCOZndgvYqoWIm85P6La4y12Kl6FgGb+dElk9zx+OJX2K
         P4Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788964422; x=1789569222; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrAGYZtQxHWbWrqLOMN89bORD52IltCr3/3mzUcj/II=;
        b=STCVCevffGVH+xJ1jeQuPH5X1mkSgNWc2NriIhxtgsziNN7QI3lmYqGLuAKyb7O2zu
         IfZCetT/FLvnZQZuElChnQIsg10KU5yBZNU2VuSKJ3ht4RXyIhBquMI1rKXYSBFjXE+c
         5dybE61/AD70k+BS1eXVCYtRYqe27S3XigX4EYhyWQ3NZd5UDtUG/F6xgg7D3VrxyjHs
         10nz8esO0orh/If4viN12m2H05tHKPxSd9LL6b31n7xkJAI551TQVhsazs7tEYIKU7Dz
         OOGt9iai1HBLRhF1+QnTnFAho/i0T9RNPsEm+2eChTXcv0VBTCUupBJcR6MEL+x7a5Jf
         ADFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788964422; x=1789569222;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JrAGYZtQxHWbWrqLOMN89bORD52IltCr3/3mzUcj/II=;
        b=lS7J+uKi0X/mNQQNtIDre2B7UFic4Y1hL4c0FUyS9mgmqyjgg3miino5bp+/+y4Bzd
         howEdJJS9om6ggOuJltG0xk0ATqv8pYkUlvrzN7Lggdtc4SxmN6vx2CDbVV26jlLa7vg
         BtPr+g+LRHVR4TYljz3uPWjy+COJW6eV2gFMrkhlqK+2gpN2kuHYJuVT2pqWoIJ8MISk
         ZEMpQgJnaObfYvO09G46C0SNl3unja9pHQTHEeSp9KQ4puXcsg/P1UqhE8bB54Qv7Wxx
         Ag95PHQMdVEZ9+GmJ20HSvBmt72G3UaLXuZ2yMgh+VN34YKJ0DV+3k/itm9/COFaRmh+
         CWHA==
X-Forwarded-Encrypted: i=1; AKwUvBwkYmBzthxMcAba03nU5Rj0JWu3GnwSjMqaaK0ClJCoPYhfLmqvFqcltAdYHlvAWoBqxiM6VnA=@vger.kernel.org
X-Gm-Message-State: AFuF++nGNNEy4WuiqwBdPka0M/zlS6nVAHcMBAgBeS0NWtkGYPLcAasp
	L83csS3fuvODLgV2uvreZFfj1q/2aij7cjg1xRB4qn6l65LIILPBT9Uw0QdzIOwg/8UQMIY6O1x
	lYub0rMHI4jAvzeEtFP3GMYXk1vfMURk=
X-Gm-Gg: AYBFou3w/gWyCbQ1i8vA5vEItz2YdhZDyorKNCJqUThwSMXUtYFRjIj+64n0aO2Q6rp
	hz+2cdeN4IFDZEQiIpZo7KUEcZxAPMeXID142hx0XF9m+sfn6RIdyGpcpDvl0BwhYP7JiZBRoRr
	dTTnOJshSa+48ktjZEvdmAVZc2ixv2UpGxKXG75/6cpnQZK1QhTN72putcyVdXmpe5laEPCmZFx
	5NxdA/YJ6SkJPAezdT65G/x9MQ9uUe2dj2UuapAH00O/UmH2usE+26WfgQP8vxzbMQWKIClKevr
	UGTzWw5QknkuXCowXwqCw6ZyPhJR21XyhdskMkiHB22iKQIs7kbJZea4/OXjg8b3njGcWeML0V6
	xyZUlsvepWbJgHA==
X-Received: by 2002:a05:6820:f034:b0:6b9:3295:76fe with SMTP id
 006d021491bc7-6b932957a7emr9354112eaf.8.1788964421691; Wed, 09 Sep 2026
 07:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909131253.2158486-1-dinguyen@kernel.org> <20260909131253.2158486-4-dinguyen@kernel.org>
In-Reply-To: <20260909131253.2158486-4-dinguyen@kernel.org>
From: Rounak Das <rounakdas2025@gmail.com>
Date: Wed, 9 Sep 2026 20:03:29 +0530
X-Gm-Features: AcwNN1VZvuSDtTgNoji8VaCpiSitHoNDPvAc1bk9oPNPvkeAKfWaadrsviD1jLA
Message-ID: <CAPYTKoOmFpCzw5EydwxRdq3LhKP6p+osY=gxvy+KOZWQsXu-qg@mail.gmail.com>
Subject: Re: [PATCHv4 3/4] EDAC/altera: Fix code leak on dci allocation failure
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: bp@alien8.de, tony.luck@intel.com, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dinh,

>         if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
> +               edac_device_free_ctl_info(dci);
>                 return -ENOMEM;
> +       }

This file will not compile since the braces are wrong, there is no starting {.

Also, another thing that I noticed is that 2/4's Fixes tag is missing
its closing
quote after "probe()".

I will rebase and resend my of_node_put fix once this series lands.

Thanks,
Rounak
