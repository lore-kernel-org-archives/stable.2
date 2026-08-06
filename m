Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82203290A6
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785987716; cv=none; b=aWFknb1FPaurlXLlrhwDFHiETRZdE8X3ken/k3RTysXgz+Uo5nQyX4IJVgO6Uh8Lr1DJh9z6qPNDMYbr4h5kXmSbvOOB8HU098V6Z24H4VrF1Dyt9e68getxGs3G3NyGVJqrcoPU7HQZ/W1s9N1aoFse/yPrCIPGw3u60keJNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785987716; c=relaxed/simple;
	bh=CwhYbikRvMaDHOlP8y3Uj/dg4iTaxackAEIaAerGW5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1N+jzlwgo+VcxtLKP67ae6N5X4KnDzhMkpRnib2fE33qUhQJ+dNKwUywNZj5l4Th7yG03yi0LUJwO2+KSaWtoAUahlC0Ip6Wq7Ciz2rF0w7JkcTWMhe5Lh5DZKx9Ahjp9bs+WsafQQMEp/Ol4lVNzpH7uAN7+P+5fR6j4hTadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gf2/zKvZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gf2/zKvZ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e507b079dso1118589b3a.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 20:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785987714; x=1786592514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jFSf2V0NRaAWT2/+cpciF/RWo86JJIrKrftTaJppXow=;
        b=Gf2/zKvZNweFlgUSkOXrNiACcJRwz4zT4etEwFrC4wiUuf3BbA5uPcVMSmLXigIvQo
         +K5t//Y7LMwEWscV6CfxH0hd7UDr17m3/eTXcwX5bmbDRFFPkMmS0ONuyqexTOtpC87n
         2F+BadGKsL8nOyTB63QcXkMO6gC/kDOiaa3Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785987714; x=1786592514;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFSf2V0NRaAWT2/+cpciF/RWo86JJIrKrftTaJppXow=;
        b=IF2prIeN51ijMSwufJYbX0uVvKwow7r6sRo3BAFrrkRDMC6VwR2l1cpIOXq30HOuKI
         6D7k3zwiofnZQF/RlnPUYMXJOR7WOzsSZqlqz5ojpodMy6GH+tQMzZYM1p4nylhkoPkc
         QA4/oG/fAltI10QalQLb7FqdHTzuXTjrA2tnUOzf/bNEsdLGJP9OKIJ0ZkutUt57DRNR
         GWpA9sFuJ/GKRa7HgGf4zOE1Xq9ctnSSqjgtvOC0Leqa5b56VuMTTrh5ZVDn1YYGBW6D
         DWavp1wXPaQ2NatFUhsE47Sl38Ii9ZrJe4IiQ6t4ouQFq4OOhCYWI7tBo7Uo9LohUOl6
         3VaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rok8HICSndlvihJ+8WAC4tu/xeflJluRNSrLXm7vYCaXB/21hAGZ0yepC2nHIdkV0HyACiFV84=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4MC66TQnVnTCBFCpS6AzedzqhOIlnJB8kIwMpyIbh7JYTlR5
	n/S0IWpDtf2LkG/MSAkoSRVaoJ1AWskeAYu/CnbDshXG/QPNqmKg7PMkCz1Ned88VA==
X-Gm-Gg: AR+sD11EYao8OdgS4Pp3SksO+ORJ20FQQyi28HO3UjxgqcOIwLcPqKloL4dflfYDF32
	pH7/gq6iqYaDzVQBGvt5cH5lN/pONI5vUX1yZD2ZTjTKyuX0QQfnz9Qv5flYKl+yLKSXma731O7
	Tlbekh8Flza2O6+BLuMH9sjilH5I4WY8/kzi+cKkJS/3nV77Vpcs6ByxunQ2h8X6MLql+aKyCWN
	9oafJrPreMxVezSO64CdrgRAhbORFbgGcCQgvvYpDIUUex7WPqXPuC7DO4IJYdQMW5eTg/daBc2
	P/QDkjq7dhd44ENZfBExMBMkQxSsb1Ent3yxbvj3eAmwyMhhb8eEsS2Z8k79ngID1otmZL+s9AP
	sC79pMoKlUhuEj58exq3xqXvUY+jqQVPRKGz4tHgzX+PZPmaxJzdS2g7FBe/lYFNoI/i8UAndnG
	XVhK/RO0+msQCuLMlZR6uQ2qIzav8vM8YTGUHZ5NVdsjab9genp6aqMx51loVB3jkjrCpabX9A0
	5ejyRuTSfHOPtgx7qKBptfhDEdg
X-Received: by 2002:a05:6a00:b806:b0:847:e2c7:59b6 with SMTP id d2e1a72fcca58-84f2e031181mr13517709b3a.11.1785987713953;
        Wed, 05 Aug 2026 20:41:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0adfsm408354b3a.15.2026.08.05.20.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 20:41:53 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:41:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org, 
	senozhatsky@chromium.org, xialonglong@kylinos.cn
Subject: Re: + zram-reject-disksizes-that-exceed-slot-index-range.patch added
 to mm-new branch
Message-ID: <anQCNYyJ4mI3l2a4@google.com>
References: <20260805184803.00F171F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805184803.00F171F00A3A@smtp.kernel.org>

On (26/08/05 11:48), Andrew Morton wrote:
> The patch titled
>      Subject: zram: reject disksizes that exceed slot index range
> has been added to the -mm mm-new branch.  Its filename is
>      zram-reject-disksizes-that-exceed-slot-index-range.patch
> 
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/zram-reject-disksizes-that-exceed-slot-index-range.patch

This patch is superseded by
https://lore.kernel.org/linux-kernel/ 20260806031640.536615-1-senozhatsky@chromium.org
