Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438954DAC8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874354; cv=none; b=HwkNXBicuD2p+pvJuPVot74enLuOWQOmbaNcu/rjxFwQfi7CwshtFiD7MH0Km9TxF7ESGUS/kD52qKaztW1o3hzEMd6FvMdHEWvGxCK6gLCOExDZ0loXInnrUC1Mt94NfMXOYo3UxS1r/0/tMuBbaWXOei6B3kmePgnvEtYNPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874354; c=relaxed/simple;
	bh=JW8E21rO/guihDfBOIiypt5b2Kbd9O7FW/DxbvZgI+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZK+XTvGiZpKbhQOiU28JrvRrNYXRHT5tfP/bRJneepBfhGxwy6nS+w/X/CJC8dhTqxyk+pj3znVA6vI80cKsHKqbsokRinhGxwbCxoRrlwMu8iRMOWdemP7jzfYYoUNOH/d7By/fDxrQZnaqHtrufbRtZSk7YWAwvfXZZSlk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFveYJvN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFveYJvN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49557167508so55408035e9.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788874339; x=1789479139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KHr0816mueEvVlfbn8Ovuy39Upgj12tVPzmZbr/dOzI=;
        b=pFveYJvND6/CGC8UBm9wZVQuezI9TCKL/J0voAOemG3bcZk1bSa1N3RXxbN4RRIUeo
         nafz4EwHoTD4T8woWrTZK9OsjOnyZhLd+ods55Yex8kOIP4oStVbW7bWa1cqrjUFWNH0
         Wh6oFKfZMQ2ETWba1a7Mws92liAQRtiQbOyAXbRbdzRra/kKMakO2cWKuejtKB+GG41y
         lpc3yY6ZCs4cX7tJYV8vZ1GSyR5LZkOwk2Q3NnpiVzggDikYlZKbMRaEX/66IDXd3pcf
         rFnK299EiGvZCBZHURiJaLCo4BjAGik/vgKGzPCYewCKQnhlJWx0teodX0EW1ZFYd7Ny
         JhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874339; x=1789479139;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHr0816mueEvVlfbn8Ovuy39Upgj12tVPzmZbr/dOzI=;
        b=NsrRZ4f13SkgZUovOSBCIFQ19tpt5ceRI9TD1Dp4JgWQbFGgBBkj+KIV/2Vn4Ym9Lo
         AsS4r2qnw2bbStGpN0UcEMEeaAmKVjI0GbageAyKYbi1ysfynF4z4wtRRXN7EpwRdxYD
         b8C74cmPi+PGXmoB6SaKBTv3/1v4jAaFCcYUeWDFu13pvN5ytNDauEAjXXPLeyIn56as
         YFls36N18q/vGtpZ8pKPBB8thxTgfAM0S5PaupIlZ/z78O9VHecaxVhgtwnk31cEv940
         oHrufUKK8wC2RlUnvavCIh5wS7nXNcpVD4T4wPxGlF7ThQN01Vfb6oWokGerk33b4OXr
         ZD6g==
X-Forwarded-Encrypted: i=1; AKwUvBwDaUe5w3Odu2bJSZc5WrC09EbgFkwRV5XXF83HjBvcwvsgk0/okNhgMszDBv0BFC/7rlFcN4c=@vger.kernel.org
X-Gm-Message-State: AFuF++nzm1Gi4wRlqDSO/vzqt2nAGJ7Yry9za2RrgVZa6gwSzpMvmyRv
	ej+7qawH9jDX7wba2EK+IVRf6dVPDliLtyJbf1Hs5f8jwiqLJu9uL4Yx
X-Gm-Gg: AYBFou0a4folS6Jf3r2MAonlNw6qUO9mp+GHKS+nJE2cUekkQlmn+HELKLpNyK4mvyX
	MeTlxGVTXsSGT4GTrsRIEjP2xJYL9zzliAvyEHxLsORbMyFC3XMu7TAfASIAgtyJKzfvM7dkPIy
	Ws8eERyGsNj41i+LaBToamo3rHG5piGATzohMIC1r3XoGEGvOvIijfw17PQ3mqBRYkWbZAk3tdX
	Maa7kvHo4K1jSmIqZVaAdC2wS13W7MIm0of5adIdCrzYi9JGP55AqOzCsnQJ8M1DMuwgfrF9UOv
	xZyvCp8byhqgPXzPhb6HXiSLil9ZgBKxmaQRHqw3J7xPmNK/VSsaue29KzuggQp/6RnJuYyH1kv
	OIGqGfno49rexB/1klTgkMhp0SHwwBcBysGG18r6ruIjUYjMtb12pxoaMMBrDz30DmhxmFkGe60
	ZKzbpDm6j/FS9mYIaIg3uFaky7Gbi+G/6G5vXffrcMcr0hU0ZttBpKKx/YEYBB9yG38syXhVbX9
	zbrhsYP57iSfw==
X-Received: by 2002:a05:600c:4514:b0:49d:1e09:694a with SMTP id 5b1f17b1804b1-49d1e096970mr28504975e9.11.1788874338695;
        Tue, 08 Sep 2026 06:32:18 -0700 (PDT)
Received: from andreayoga.localdomain ([31.189.32.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm302377855e9.13.2026.09.08.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:32:17 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:32:13 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hrtimer: Use hard expiry when updating timers on the
 same base
Message-ID: <aqAOXfiVIJl3T5id@andreayoga.localdomain>
References: <20260907211134.3854-1-parri.andrea@gmail.com>
 <20260908110946.GE687043@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908110946.GE687043@noisy.programming.kicks-ass.net>

> Can't we do something like so?

Yes, I'll fold your version into v2.  Thanks!

  Andrea
