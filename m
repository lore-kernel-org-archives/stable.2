Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CF408628
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706386; cv=none; b=hygXGaylqUHeDzT3tiNdO19hrd8++WCMpVyvum+fkcq4JnOTCYqJ2y4s6t5WMAzNcPr9mOwK4PodA4BMHJV2AIjTXn6pylj5E1GD9TMynyBEUczJjDNdEM76elZWyzYjAuSWDJ1jdJgbuTZn2hHB8v5ovHBkE7YpP7DLcb0/QVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706386; c=relaxed/simple;
	bh=g3zJJtTxT9naXlpR9ttb1eTcMTdbFiQsVFTEbMXOSSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSZIIjMvvETCsLvynLlgQoxmz/tRsZsjLpFOqW/4uTQ7CUeH7gLp6U0KvcIYMmhvgTasvUorWy60B+qCIN/W+5xWAYWTyZcxKQuK7BSAkFLvPlJBzAw/xp8+bDwuQZLJhOWpJB5lPUKkWJADgO0Q8NvdojbxvIpdko9J8ldiN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8KWomKN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8KWomKN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf52d15d88so41198675ad.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784706384; x=1785311184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g3zJJtTxT9naXlpR9ttb1eTcMTdbFiQsVFTEbMXOSSE=;
        b=L8KWomKNvCvicHpxqWGaSFOKa+sBEHwKaubEQhbDeRggU6txYBn0RVV+9qodPSd5VT
         F3XK6gnwmI6hQR3hChO+UBfnZ08WNaNZMtmdc4k+XwrlDXlym2vPHZsFQpM/gqVNVcMS
         sqgoIkq/739BI6Kr9TlbXnbNXY8mQGtBM/9MZNDrGNYdfoDeSl8h8y77ScEBTPipwHOY
         xFhfOAo7p7kWozlTHfhdQVQA2QVPMIVL0NON2m7b2Or3vBuQkbT7DBUfDpDDZu4Jjw7F
         NMrScrLm9AsBHJQzl9+FXbm4fniJ+mmFPWO/vK/9VPcq2S/GXYZqlZ4ZJgXxaG8dFrTY
         v60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784706384; x=1785311184;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g3zJJtTxT9naXlpR9ttb1eTcMTdbFiQsVFTEbMXOSSE=;
        b=d+ObM1RKer6rrpLigUBqFlJCVxM1vLYSXJUNKMGc1f6NWL8uCZPiFz68NAo3TdxNRk
         10WvfnSvOBLRapR0KRVUdz33SXcRp8azoSsp+3wuNAboo0HQYnQGvjW2jD1wuWVmfz2H
         LDpnoADOoxy9nCO5O6cQGxxQyD2rqIOwlnZVcL2eClOis9GHEKVC6cgl9DZ4cnIkoG9+
         MNFEKC4YWpizhyl0Mp8mwflHp99mok7LxIgZunTUVbzE9d76xQ9b5qHGXSPWFtM1YDfH
         +qz6eu98BC/9MomkvG63Pcw3ZgmvrzeYKzE2pKs0IhjbN1vZ5lemlZLFA9K2ntNrxNm4
         PYIw==
X-Forwarded-Encrypted: i=1; AHgh+RqqysaTWsIEYvQueo3DeuR+iSiltCKqf4ez1qJTKapC3bqGCDw951L7cpI9/KUC9o5YatoxZFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFVfRjuYdbp4qGJGg6dMnLSA6AzmUU/fjeeAo3mEmx62b/NkP
	IIRrUJ7nosXjvNnf9INt20xbAofPzyXO2+juF623qGe1GQs55ODzhothu8Brvg==
X-Gm-Gg: AR+sD12D+sqzyNG3AFW6MIH/eZhXma3lDiP46d9PRb847wjj6CV3V7wbTXfQnfraMbF
	Af+A4MJgnOS/6RpExf0ouSE9qnBTB3H9MrgcZx7i7D1wWT7KEchuZ+LzJxqy6GASc5vBpWuxduS
	JB0xrloXkmcOGb7AKHJld+sg0lQNuxx4UYjsABTYBYReRyJNt7Nk1S+O6/vjVu2Q8o/YUujuVeb
	2xMCtOx+Gsvcs8pV6B50luoGkugYRad2vZGAs1wh7bFbq6+3OXaEEqJ5x2KsNXs6D3ZOViry3M0
	uYbn4YrEKYm2oLAjMxTI5eGQ0aXOcRKN8mpw9sbUKYovJZJrEqO9BWJItVT5wBSb5OPLsJuBBMB
	AXx8ZTlFONGU6isdQ8HB+jKwhXCcT1Hl7BegdoVUE6uLhqmWV8FvqAI2LRXQODHOX5ow9tCco/C
	BzBgTtAFNyRbFtITQWD6tEuFLXJFDFhjNjJ+pC88syEJsao4V9valp2Ri4sQYe4IKHkjcKKok=
X-Received: by 2002:a05:6a21:a347:b0:3b4:71c1:ab29 with SMTP id adf61e73a8af0-3c3ad7a3204mr24450589637.16.1784706383962;
        Wed, 22 Jul 2026 00:46:23 -0700 (PDT)
Received: from archlinux ([2405:201:1b:20ef:3bd0:b711:249b:6c29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm3971839c88.0.2026.07.22.00.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:46:23 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:16:18 +0530
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: gregkh@linuxfoundation.org
Cc: alberto_e_88@yahoo.es, ilpo.jarvinen@linux.intel.com, 
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] platform/x86: hp-wmi: Add support for
 Omen 16-ap0xxx (8D26)" failed to apply to 6.18-stable tree
Message-ID: <amBz6RYUlG5NshY0@archlinux>
References: <2026072021-said-startling-e2c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <2026072021-said-startling-e2c4@gregkh>

On Mon, Jul 20, 2026 at 05:28:21PM +0200, gregkh@linuxfoundation.org wrote:
>
>The patch below does not apply to the 6.18-stable tree.
>If someone wants it applied there, or to any other stable or longterm
>tree, then please email the backport, including the original git commit
>id to <stable@vger.kernel.org>.
>

Please drop this patch for 6.18.y. These board quirks depend on driver
refactoring in mainline commit eeeb4c9874bb7, so backporting them to 6.18
isn't feasible without porting significant driver changes. 7.1+ is fine.
