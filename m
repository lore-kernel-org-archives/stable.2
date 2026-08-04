Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C23932F9
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821316; cv=none; b=tnS3W/uNCsC1uOji6bONDPEN2n4zLTc6m2XpM2EaVkz1QkRuziwOVtOHChtS0kEzgzjmtUHV+6oEkk46rp3Wrlqbli+rwAaDvImpIVgyrggVf3U/KT0FNnj1HDEmoCyf4qC7xLxotTcsU3lttbspK+zoXK2StWgiWemGNahr+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821316; c=relaxed/simple;
	bh=xLmovQy6eqBUDiJqbaKqkjv8/lbGY1eloaLsznaMOxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL7WDEblBafrS9wEt0LBMCRzB6wMTu/ho8Vk5hxuu4WJBXbek1ipVwLgMu+pxD08M3chsWEqe16FNSC+Nu3MQ3Xj3ne9HkjC+DsgNdfXWsJjUEqYtaa5klVdEOEVq61v9F3OqnHzU8Dm/eXZPkPKXOggppnBC8vWRUGo5EgVAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=ITBriL64; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="ITBriL64"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso3433753a91.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 22:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785821312; x=1786426112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tsAKhlaIH0uKdSxeDJ3Kz8LaG6giInRmw0bCqkHDsjY=;
        b=ITBriL643J49JfWgt7JfcnWKQZJNucnUnxUak6agv7c+eyJEOS/2JtEmzyarsqL3nn
         QVcH1O4hlhsfbHlOXXRJBUMcVi+mPtr5yfUSmGZ7LWnMsrAGlI+XUnpTwA9aZBC7HYSW
         1S6k72p7IC/bAFnzOArDNGn1onktDPOa/6Nwf0BzwFUTWBNDaYJbLo+n9q5gR5cVsmO0
         8U+ohO5XwiQap+RWc1Wclxcc8/UG7HKG0jEm10qFRiuKRuKxbNOQHR29V3VYb81lpNox
         OVoWzo3nbeG093t5rnF88z+aHcrbRXtIwsD4krk5R1gP6GU/nnl7znPbxi3OHnJxphCE
         B9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821312; x=1786426112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsAKhlaIH0uKdSxeDJ3Kz8LaG6giInRmw0bCqkHDsjY=;
        b=Dp+KWb1YL+jS0AnXPhKi92FbLutXZBTWfYB09rMD+oaYG/a8vil+QDGBascEwdAb5+
         e3Zo007Vn5AiHQ8Z3IXOuVUEU+bFOZG5tk0LE6fNMUdboGcdT2gPEPFw990GgiBQ7PcI
         bG8U6dckyhjm5oXiE7oQpOETldyz26FbLo1OvMvG3V/SxCKDdwUO3uwL0enp1aDRT6UJ
         l1uvinjjysQMPNJUc3iHRHDqKaRXopDqBfCCokwZ5FZWKfvuwgL37uoeBO0Xqz4esvyR
         b2BTaU8o71nIjtu724kE6Z8ok8YSM85KQwmTAXiC/bxj+Hf7AlavVJx5UIE7l1SUWxlT
         ILtg==
X-Forwarded-Encrypted: i=1; AHgh+Rrm/CeIM/+3rKXF1ud0TcT4TvXTSEqtD7f5dey1BTNCmkUtfak2PY1/AUDdhPP8DQOfaNeetwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKuysIUiTg0Y8ELy0EjhodqxaUzpFjgmHS7as+nOBy4oTgi8v
	Cs4PTt01HC/3IVnEfIIogIE0Rqz1iw4phzS05vrQ/j5jUjTOhaOQK6rPoAKRvkbpNU4QenkZiUR
	c+/HvGMg=
X-Gm-Gg: AR+sD11hf5tAdEp7IKyx2089NRWQ3SMSWx5pTN1g4NUW4t9m8o3zHleBz5HR7oE0IOn
	6WXlBbgeZNLCehbEEbnpQ3wb4/wEf6EASMkiQ73MHy6N/vNFQpdsLcYEh/RG4YzZy6cEDXSoNms
	7ewIiZpBTHO4WISD6Mzl3Pm1KcKlENNiPbAOib99kj/Gqtmf0ugvYviZJtmB970ReoBK14gSRPv
	tLboUbPzqRF1tFaWUx3B0nl4Gqqk4Ginpu7FTC6U/blw7uNw3FlzCjejex4FzNh156RLrxmdD3/
	1ZTUL39Lq9AGoFKa5UEQoF4mmtpIgiEkV0dQPlM3muOik+DG7YQrUAWN+e3YLtcHZL5zGvAhqFC
	I2PyOG+kHABH3iv5mgHA5sksuA7rKnJ9UDGJK0HM6wYd9RIwbZK1A+kGrn6/aGHyNkXVudE2kwV
	bYRbvzwYTbY1yC6VUiBd6137OXSFg7CTgM/S2qvIn+E0namZ1MpM38WQoVWtH3R7052PV43LGt6
	444O0EBMltFIEOdJ5/OwwieuP0fLzeQZ7nspXmVh0tJDJSH1cwvC8P/eMQH8KJYrn4QYNTeJk9F
X-Received: by 2002:a17:90a:d004:b0:381:cef1:11bb with SMTP id 98e67ed59e1d1-38fbc4d6369mr12153174a91.22.1785821311856;
        Mon, 03 Aug 2026 22:28:31 -0700 (PDT)
Received: from Metius ([103.158.43.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315834e1eaesm1534690eec.19.2026.08.03.22.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:28:31 -0700 (PDT)
Date: Tue, 4 Aug 2026 10:58:26 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: Fix memory leak in
 brcmf_sdio_read_control()
Message-ID: <b67xzhxq3c5s5v7tnwdjtmbfmye7mgvdbowhyr7g7h3xdkdrze@b3w5waih4oku>
References: <20260803093506.1647790-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803093506.1647790-1-arend.vanspriel@broadcom.com>

On Mon, Aug 03, 2026 at 11:35:06AM +0200, Arend van Spriel wrote:
> From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> 
> The memory allocated for buf is not freed in some of the error paths in
> brcmf_sdio_read_control(). Fix that by adding vfree() calls.
> 
> Cc: stable@vger.kernel.org
> Fixes: dd43a01c5cdb ("brcmfmac: use dynamically allocated control frame buffer")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> [arend: rework as suggested by Johannes]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Thank you for sending the reworked patch.

Regards,
Nihaal
