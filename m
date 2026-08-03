Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEE40F75E
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764668; cv=pass; b=mJT5kjm/ufLeOB7XJngV8MqHjeus29nX9KnFLP4w8Pwu7tMf7k1IoXWXRyo0GUc0Qe2kYIuAdPp7xnJPq9t77qD3hnfYlj6fZqoNEymK4NUAt8H145CMM85OUPRsu6tIFapxGIACEiYPgjfpih+DXQ/9kniD0e0Ny2VybBW5IAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764668; c=relaxed/simple;
	bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0Crg/YtpDW3dvN/fwVyZtnDa4sH6Ny0iJMK1VNX/4ups2EDTF2n1DZQAc2IbC0maREdJ05zpvfmPhk8/bWwZ7i7p4ves5n3gDVygJPwUZjF6twJJlYIXQQ2Wit7Uq8o0hgv1qB2FAL3dtjA2tbl5dYlDMBVkGuNktNw4XjfH5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6Zhn8sj; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Zhn8sj"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb61bbeb25so2390554a34.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 06:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764665; cv=none;
        d=google.com; s=arc-20260327;
        b=eVg4O4yR3YPBZMf5a5xAVnaQUw0DJ1M4ez3FBpjISZp04NEUWJyO+7fteF0hFCebjb
         QWQyFD7ftmvMIRpglbH0QtZJ+XLInOpdU013wqXVUufB5BvkGeBSVeeh3qzMOA7rZ7ol
         TaX7Dxrmi6cVw9EBbRPfQ0EHA2q+eiQwQHEExDjq64QXt5YDYnwZnqlIQ3QzJa5ln762
         fXbaS3inmRm507s912HqFo32oobGchHAirkIM3qw8Q+wHDPfhPvwPlXhrobq+c0IMo0K
         OVMuR90586xZhfO2LQ94rARiIlZqbtFjvUUeI7iYWmYlvHQHa2LJcuZ0Ib/hMeWji/iU
         ylVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
        fh=R2klSKwljGUSQfPm6ViTnb0R8H63pv7F81MaI8UmHgk=;
        b=pdjICPKQfKGb1Kdnyi2vL5SybjYlu+90PFmp3QG5zKZHY7/W9oG/iurfJ2Z096eQlH
         UVRCRIACEWKO3GO1NW+ImFLjrW1S4n8UM/im6+hmqJQTeQN7DaATMnCiLhM9HYXZ1SOW
         abEylgej8Tkkyl+68aE3SmO2IrL6vUh09mJrubZODiei1nMoAs8MIE6YYVso8BDaszEI
         EP9RQ5QhRN7GCRcHZ3q+qDfhfEcq1fKxPn1Jao170T6uzVJD8bRn29VjjwKSI/hOh+vM
         Do6t3JgTrFaE3/aWK+E3441m02I8QGRHhRSrKCHLOVfvH+065uc4CfmEOQlFET0VfGrt
         7UnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764665; x=1786369465; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
        b=J6Zhn8sjE+XyLcyWXfSz6aZ71s1d5U6dYdebQaqfb+dzP9buwutzjinyB+JAUK7R+R
         TI8lNdWG4Lhjk5KC2RSbaYs8Btpw9J21tV9MD1widy5QRPH2ZkGsV3wx94uJ9XM1/V5e
         ZTJ6yD+gI5GM0YkX+v4KcOoB0t2xJUtkM1L6VCmSCGHmBXp2J3+DgZJllSbO+Yxeg+Fy
         27AIYCbaH6NIcY8+MjYzwzKf3GXHBSVICMCFoeLiCcxEUPFP5LDGSDMS2iEZ/m1OuYjE
         szpSKoimyPNN08P9KmEH+F4rf4p+3w2ciDHdUOVqzNr3/WpcI/nDf5gdvxsEri5M6cwx
         NVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764665; x=1786369465;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
        b=Kfx9ugVxSBAwoy2gK6FogFxLjaYsd1UcIoKSISNDOFgyhYGDJYucoGmTYX6MefuKXL
         rbZIypRZ4/M3ZRXWoQdXOga+XbkE7VHL5v/5QASxE+HnsiqCtVqwyX7sMNDKUisaz9rA
         cK02eNWiZyhQGYP1dNzq4ze+2ccLiVknSYnlXwR4yveoaO/7usXX3DmhzOAFnmJJUtBv
         4B+zIWUDzdeXBuB/f6KSwOkqZ5qNKrmifDn6NT4lsh9mW7ZQCNCI/mYQbiM0OBymwc0X
         1jBMJMvpBCLhJ/evuhi6y6uoqJ5cWn5kxNe3hXV18CYrfDNxxSGQWf3DRK3kNEwudSGP
         UnZA==
X-Forwarded-Encrypted: i=1; AHgh+RrHu54sLBeWALNx6g3qnTYlGEqIzx/XASnW3TrfGue9e7zaEiVtYUN9R8COMKo8UfZedzeTSW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPxmvJtuWXUiRm04pib/PV+pulxt5JqRevwFgkwsAHXB4E7c5
	mEnni6WTOGWq70DLFaAizTO+saLJyOyREDsP6OUmaUU8HgNyAjAogRmMpFdyyx/4Rp3F6yzo2qg
	MuseB4Yw03b3rM7S59ZwkEIzfTWFMtA==
X-Gm-Gg: AR+sD13SFvMkX3dr0S4DF7r79ACF5E6NstqOsYQ/uWa+++LFSQj/Tt0OAyrJ3r/Zufg
	k3rNSVyyHFC7WtTJz8LVh9lGSFCZKZWpLZN45fvlM7r6tXv13+jNaLaJ8C/LhLcVuigTHY9RuL/
	4+nPJ0Qz8DXbFGhm/V6scTvQnuO1s7GCHUnqaKBQIHvKisAl28Vi8o+25z5QL31rXQhFg5Lp6GG
	ouZNULvk53YgY5uIgxSd0X8P4RNDgBH7nPEhwhWKPcIiKIFXKT3/5SWLRpX89gYHwGc8toXmDOq
	6vbOdPLxoa9TqpPwPmZ/mvbBjH9Fg2Wj4CnpQd9cv+dtpqzCLQEOekT2UYwBHfR5bmk0i6MKA4k
	2
X-Received: by 2002:a05:6808:6c93:b0:4a3:26b5:7c3a with SMTP id
 5614622812f47-4af5e30be0emr16237560b6e.15.1785764665292; Mon, 03 Aug 2026
 06:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729041656.51967-1-rochan.avlur@gmail.com> <0b6c89a7-0c09-4244-8238-be12862328a3@kernel.org>
In-Reply-To: <0b6c89a7-0c09-4244-8238-be12862328a3@kernel.org>
From: Rochan Avlur <rochan.avlur@gmail.com>
Date: Mon, 3 Aug 2026 06:43:49 -0700
X-Gm-Features: AUfX_mzLl8Bbo7jXrfLx6YCf4GoDb9_Mldf-p0zY6jhglAo_lFsBPVJtMy0w4x0
Message-ID: <CALbtPkWdgFcrJLqPRfqVOsNgkSSB7H9+NhegeBqfU6LfdyF7Mg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Chao,

> > f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> > &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> > the idmap that was passed into the handler.
> >
> > Since f2fs supports idmapped mounts, this compares the caller's fsuid
> > against the unmapped on-disk owner rather than the mapped owner; resulting
> > in the actual owner to be wrongly denied with -EPERM. Use the idmap
> > argument that was already passed to the xattr handler instead.
> >
> > Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
>
> Thanks for the patch.
>
> I notice there is already a patch:
>
> https://lore.kernel.org/linux-f2fs-devel/20260716025908.608098-1-zhanxusheng@xiaomi.com

Thanks for pointing that out. I wasn't aware of Zhan's patch when I
submitted mine. Happy to defer to the earlier submission.
