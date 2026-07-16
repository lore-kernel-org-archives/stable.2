Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5804429028
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224911; cv=pass; b=SzhdG7lRCUfM+CMmJMflRhmgXk3yJQSJGHl9PJPQoeL0AdCqfwGkzdVdgaJ8BFPubLEb+7gvI471uYtklJiQdyvK6gZzJ4x2nNxsqONdaRWZRlGCK0QfXHdihF60JFZoWsYLgW6Xw8k9OmPxTFSCZUxQkpPVyZLFace0U4qdQKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224911; c=relaxed/simple;
	bh=NlWgQiSP7DRr4zrZ4wLm8Qq9VDA5rd981ldTnRGuLes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+kUmosbUAQVgCJAJ/vFA1QmF62LwTvKlycDkJsdVx236ZLu3/kzIMZHAdedfkwzizbRrSvecTHrrxXpMmrgE6yBj+epZ9VN/P6K+VoRBqYi631iZkZn3xJM2QnY2gzim9g0U0fnqPBvPlY8MKisZsU4DqlSkZHzc/TezGhyB1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUlRsURt; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUlRsURt"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dbcb505578so36903977b3.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784224907; cv=none;
        d=google.com; s=arc-20260327;
        b=MLOJDuw1JAzsMQlGwF4ykA8pm8tDNyIplQY+xq+qenoA5WUWoTQepgfZ8FD4qkVQrB
         NGy8sfDkPsBg4AoXn3Y3/DASFW8bg5m0IRU9FA3GeEsYwO7Afs8oMCvG9ERpi+oynDda
         BuUHFLrH6ViQx7EjyOfCMA30wq6t3reQlwyQfHbGJGn6YqfbKbudIPGeHUri4DLGFqZh
         TnV7oQndOI1kVJp6tJP2QNZJ0b7ckG/K9OaxtXDw533i5Y03jS31VjBVs40ge+vKa/UR
         IYIElt9rH22VNZSLcgZ2KsYTlXjO9C6uHI+4VWaXgR462oUuxbuGeFwFLANQzBERxWzF
         1UGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NlWgQiSP7DRr4zrZ4wLm8Qq9VDA5rd981ldTnRGuLes=;
        fh=iCko3LKOz4kKSYhK1vWXTEH8gDWoHjSV+7VOYRUhWHQ=;
        b=ah3bk6lHbFCs/RkPBnkyDvJMmk/vNLZ5Iv/+wVzlSWVJFGENwjjGrhhD6Wdm9fBU7l
         rqCxLxxEUT2Ize+GuS1fn8X8ruxo9ed9FWJAhDVjNC6X+mNDGSSlglWQoXa483QMrFwG
         mDlrx8fXRCjDqu27L47ljb/YqJcI7AGFZvQguYz7cvJkdY/zEKj1g/jWSWVZGfpRddce
         MkPmNOl7fn4S1bkYoDQKGiRx/QWRwcP1vsGlQdGWDfqCMDE7bdUWlfezaaxT9EgIUgZ6
         Vn7NU7FW288jPy4+e0hX3T3FbzoB1jJqdiEC3UYFi2SGZnj8eB7dZI8+ucZ7o0anjvAC
         TO4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784224907; x=1784829707; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlWgQiSP7DRr4zrZ4wLm8Qq9VDA5rd981ldTnRGuLes=;
        b=SUlRsURt/PVjDt5Wt+cQVzZLPci0i7tXIBdxziQjv51JMBMySi7Yj7Sn0HrNk00+r/
         eYVc2a6dbgKyilCnQva9r1WWtu2WlLUpAs9i34awMOl5VSvDLpDxy5gEQHVo9tyMznen
         /DV8CSABodP4BGY8GhGgQJHPEjz21HExFQyfgOaNnrDTtLITmjAQ+uQGTDCdH9p9M9IA
         orsKCRxJ0ZO7oYGTfhCWoSyODSjNtBAl/tqzp0Iq0OcgQIb0jhpuXVr30Z9ZN6ny4C9f
         IWsJukPT1+Rr/Y3EOWVU4YW44WqDdPDTVL+68ABG7yq/fPRd2xTyeRUQnhKqoIU7oay2
         0chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784224907; x=1784829707;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NlWgQiSP7DRr4zrZ4wLm8Qq9VDA5rd981ldTnRGuLes=;
        b=ZuUDeaNPQOkMOui0SUZirRxkPVEesImgoMe6N4q0e/qUM+QNxpnrgm+cN/gvG5Z6Pd
         qaoUvbItNRLvDYyVJePwkVuJyspFuNyuowmgXYC/Fj0EwFzpfb5W0n1iHGQjkCW8vmze
         iE7fE09l5YgEPLlpqmOQ6N5MKChEajRtrjzUeLIAlI3gse4QE10r/xREHTTr09l5RMrt
         cvjWOCBGlNDl6b8kdrzLfC/JzVtFyOa3L12nl+ic23bwyGWQHIXgIpiC3tqpIrZZfd01
         yDVsB56NRF9EC6FGHvYB8AYn+HljJ3MqqirpIGEqkVCVbuk2W3jkQ28LSHVZ856vkkr4
         nE8A==
X-Forwarded-Encrypted: i=1; AHgh+RrSW2nJe6HAFgjDqIjs960nfKCiTqyGg5j8fosH1HpDQFuQOCKf4jzeopt4G11MJoOWy3fAKg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLPa43M2Neu08tpCsyvv6Yah45cOUzZ376ZcbZCtPQvZeBnUM
	DK1gWD6FgcxdS6XEMyTjbFPhUpBSUHRMoJ1PIjpKOJoDbw+bxIVB1yCP0DJ8t4t54DAsgbTDLp5
	Vx4pUZ7Z+gZXo5mCbeiZevcMdeZ1MEdI=
X-Gm-Gg: AfdE7ckpGj2dANEn58cvEn1SGUZnlUj9qcESXF864ltWhg/WpqsAeCY63oBRLbGnm0Y
	+w2w8mvL566DFMj7wYN8gM1I4gxzizBwaxGPlwOvX0ovLxQbdWoVPJ+/Qc37FuVeAuvxSrTxgUW
	ZDMREl6baj0f2CWQOT2vk59DP4hQbHsiOTR6IuxVsH5u5F87ruRBWCDZIorwlWrlKT8bqEA8JLG
	qay6rZIk50992ezFaa8JQm2qq+haSsM9R2Cs1hyEReCTdyLVXOHnyQAhNA5zQpwU1dfoARZ4ExU
	Bv3rD17xhuAmNuVf6C9Ys7+BbgG5WVrsQ3KDKdCZxYfO
X-Received: by 2002:a05:690c:31e:b0:81d:7a2:f044 with SMTP id
 00721157ae682-81eedd74086mr2650237b3.28.1784224906399; Thu, 16 Jul 2026
 11:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712221709.7099-1-gvalkov@gmail.com> <20260715145228.GG56330@francesco-nb>
 <CADOrJmYwYs08REP3eSwiTQegcKHFLwW0gpUexhomLDtO91ASMA@mail.gmail.com> <20260716085942.GA99146@francesco-nb>
In-Reply-To: <20260716085942.GA99146@francesco-nb>
From: George Valkov <gvalkov@gmail.com>
Date: Thu, 16 Jul 2026 21:01:31 +0300
X-Gm-Features: AUfX_mwrCfcFVOdlkh0EXyX_NrDHjDde4iio3zfqW-JG-yoohhSGDLwO2m-Dnhc
Message-ID: <CADOrJmbJAfNoyAuRq5OxP17r6rCAYFFJPy-Nvj4D+1zv=heK2g@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: fix freeze for 60 seconds caused by request_firmware
To: Francesco Dolcini <francesco@dolcini.it>
Cc: johannes.berg@intel.com, Dan Carpenter <error27@gmail.com>, briannorris@chromium.org, 
	s.kerkmann@pengutronix.de, kees@kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you! Note taken and I will try to do better when
I submit my last planned patch for this driver, soon.
I wanted to collect opinions from OpenWrt members first.

Georgi

On Thu, 16 Jul 2026 at 12:00, Francesco Dolcini <francesco@dolcini.it> wrote:
>
> On Thu, Jul 16, 2026 at 11:26:54AM +0300, George Valkov wrote:
> > Please backport to 6.18 and 6.12, which are used by OpenWrt.
> > Initially I did not know that I could insert
> > free text between the commit message and the patch.
> > I apologise for that. I am still learning how to use git send-mail.
>
> Please see Documentation/process/stable-kernel-rules.rst
> It should explain everything you need on this regard.
>
> Francesco
>
