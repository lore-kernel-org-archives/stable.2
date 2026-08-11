Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3603F6C3E
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484385; cv=none; b=SZObvYHg5kiyvPwwntDDyBJrI1cxPngS3/oTHv4LU7XZjcmB09Ezpl+v+hTr+lq6A3YJn24KQnLDzAljibbj4H8GVQnvh2dDkAHxk1Ckn6zMvoJvCJFtBmQml3YtbCBLVVlIoCifegpY8QIH1M+Gk9mT1SePjz18ediqJXMg5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484385; c=relaxed/simple;
	bh=Lu4czVDBOBoKMCVqeB6++zrpWjBzqrBzCBr7IB+hP2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfrWvDUmGBDjP5uvRDYFcAcdeftUoQ06mbMbjfVzkrRARooFVzve1ciJt9JCFPXA4JFf4UeX8oAGgwpoaBCrkp8YhuYPXwKMtznlYlgQXm3qm1paF3tAqZY+Mp1R6lSVITBShXL2nMBXKoZsi+B2JBdSKsmUR8gfjEyVlK1lEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HZNOa6mN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HZNOa6mN"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so430529a91.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786484384; x=1787089184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lu4czVDBOBoKMCVqeB6++zrpWjBzqrBzCBr7IB+hP2c=;
        b=HZNOa6mNJQr9KBzmKV5PPNy9Ar3keCGw+qkL5D1nhGsE/XGR8BO+azvSuvK5f7P+zW
         KezgtXFzty75OFRTiY744ZT885uRGW0K0zu8P7yao1JSTIOpFuPn8FbtLlVBuEGlcneh
         eLeMKsBPq3sWHJaKbRxeKN8wVRik5KYCyGtRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484384; x=1787089184;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lu4czVDBOBoKMCVqeB6++zrpWjBzqrBzCBr7IB+hP2c=;
        b=eqHQINMq1R6rLx5EX8oqIk7PWR7BAWWGX2ADYBIx/ejp3w/OmNxvSeuc7GCO29Q5Pg
         gDvT8sz5CVYACFo6CbNmL6kV1Mvsh4pOoyiqP1MqNjigagP7IyV0DrX8GJqPFUHRi7pS
         OAl2TsZcnwrLI5hnc3xAktRwPX/Ha7Um66BKa0TYwAmO4dpa3xnZPxvqkSUwl+SmdYfR
         dEqvAwHqixo83V/I8y/ugllHAsunJz+PM8ce8pV5ITX6RBwEAggEEYLjBtPiNWntwHaJ
         mo0G/xOx3W4ROv8Pa+T3eYk6M9d2UFi2kps+mBS/lTf+U3hYSXUa7+JNsDs0f6ngrrbH
         cr3A==
X-Forwarded-Encrypted: i=1; AHgh+RrLMEps/XNamvrHnVZDXavdXt6aZsMrf0ELCPcT+HOhFJD6376APpFRAox71+bfPZpCRUTUa40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLDqZXCc3+hCtuuAHiFc2HtWoOB136SVMbdDV1AsOQE+zd8lZb
	MzhQh8TmaBJwDzPE0gWqOkdyNLjtk3Yp2ktln50oqr8HSATagSSBWm7kMxRI0TmvBQ==
X-Gm-Gg: AR+sD11aG0X1PtPVK/nTr1lYuOlRfaAjf3BDUhRyOKJkgAC3xmIjiV3ORedJbQ6a3AP
	sHD627K2b1b3KwwX1dvurXkq1wluIXBWV2vXOD957cwcWhdDJCbE9VlVINhcutT8P3HbObStbJt
	IuFZjJRLbdRVJXMQppQ820RsPRyGsKV1HWG1eAOcM8LzCgMeWaZA1978Khg9ahmL4NRLPvbTGIZ
	8rvVUu94Je1Voy10Kp24r9OZMg+biy+9zigIYEvLj/hLSkGMguQD0xYkWAX+NyNIjP8dUQYoEJH
	2Eee7oWGnlFGHsvsKB1eQrKCos02kokNC3XfWkQ34JtFHPtt9gsfIPdQSyk6FesZi9b4QRLF5wf
	mx9tiqdeiU/i+pe6moBzY3zctLSkGu85XrGn0k/YJn5g3eBJG7f8ustUfPeP+V65FHkJw1D8ibf
	6R4SLFyvPQQVXLaGtTO2oRZo09DA0AwqWRoxRAPWehMd06Jm0a49OTzJfje6bvD+FvZaGMFTl4X
	On7RnxTBt6WkLaJMvtD48RhT/Q=
X-Received: by 2002:a17:90b:440e:b0:38d:c74d:29c5 with SMTP id 98e67ed59e1d1-393014b609fmr30801a91.19.1786484383845;
        Tue, 11 Aug 2026 14:39:43 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79fa:d268:80cb:4947])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-31cf628e2aasm3197805eec.14.2026.08.11.14.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 14:39:43 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:39:41 -0700
From: Brian Norris <briannorris@chromium.org>
To: George Valkov <gvalkov@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Dan Carpenter <error27@gmail.com>, johannes.berg@intel.com,
	kees@kernel.org, bhelgaas@google.com, s.kerkmann@pengutronix.de,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: replace one-element arrays with
 flexible array members
Message-ID: <anuWnc6MKyT8J-O6@google.com>
References: <202607150932.F2A0836@keescook>
 <20260716001728.57799-1-gvalkov@gmail.com>
 <20260716061638.GB9973@francesco-nb>
 <alh5y74H5bJyDSSP@stanley.mountain>
 <20260716063246.GA17850@francesco-nb>
 <aliAaHF3NgwAZ60v@stanley.mountain>
 <CADOrJmYnAph_TgxGTx-36ugkjjsiH=1T6uzmh4FuQ=EOio2m0Q@mail.gmail.com>
 <CADOrJmaRjN4XEZAyaWR_4g2vTbmmaSeFdzJ7r2ncsZkbvAxQsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADOrJmaRjN4XEZAyaWR_4g2vTbmmaSeFdzJ7r2ncsZkbvAxQsQ@mail.gmail.com>

On Mon, Jul 27, 2026 at 03:16:54PM +0300, George Valkov wrote:
> Any update on the progress? Do I need to do or change anything?

Your patch was merged for the next release on July 21. This process is
(unfortunately, IMO) silent in wireless land, but it is reflected in
Patchwork. You can see its status here:

https://patchwork.kernel.org/project/linux-wireless/patch/20260716001728.57799-1-gvalkov@gmail.com/

You can also see, for example, that v1 was marked "superseded":

https://patchwork.kernel.org/project/linux-wireless/patch/20260712222334.7134-1-gvalkov@gmail.com/

You didn't send v2 in the appropriate format, so it didn't get logged on
Patchwork.

Regards,
Brian
