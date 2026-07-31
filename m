Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76D41F349
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501455; cv=none; b=O9f2IrPRjSa/tQm8Zf7cchDNQ2mPfi1N2BuVfXLpfdYY7NPOVJgORVfuMeVuyJxXiO1BQn1K5g1nJa21D0pjLQyVCYFESuK1+A6WfvtP+lTSDdrItBfJa8NaCh+ykCA7WywE0VSzEQFuOr5JmEHBCpnQZ39j+GxSNSXrXsZ+UZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501455; c=relaxed/simple;
	bh=YqebT9clfnPMsC7yqrCtUYusj4Rz5asoem6l5jV5TlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHx1RyZ0I+UyC0AZUY6nKTL/ciCYOsTMsPN3NQegPvpQkmh6iBtdWBBeotn/SP9LxwklhNiy+pFldvaWdK6terChE7d51ZkO7vRvWMVAx75hlYB6++m4juVoBA41DMvRpVgWZ0g9mKjJGK01WUR8eRw4vUiIrSERl3d0fZNbZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz4ZHMw0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz4ZHMw0"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69fc2261f2bso1623206a12.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785501450; x=1786106250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zxJ+yA42EHLQdUzb/+RpNk8wZMGnUA7//ORKkd+D1IE=;
        b=Hz4ZHMw0aOrm1r0slpGzgaDgIn9QEZTm1bne/4F7C0kHCoyRsnL8zLlG+eZUGeINR4
         o1HutbwOsUCa59j1poSqzGdSiFoO7ZsuyJf3gNOrFG618xiLCzukBskuldrQuY0J5Vkv
         MPhwhKhGOHLs9Vl6AOUm6+mmeMLtTSfGyRxRsYXtfYWPXePsqAqfPCZojLLDA2zRqos0
         KRMDoHB7ZXdu0sFxww632T75v2e7UtMCX8U5S+OgxjDC2YnVKfqSWf5Ei+5v50OYD5ag
         Sc8gDKza9uFRZ2n47On/Oj65SUhPe/ahnAgVOhOAekLcOxd7V660RjP5BNag7xq7EQct
         d4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501450; x=1786106250;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxJ+yA42EHLQdUzb/+RpNk8wZMGnUA7//ORKkd+D1IE=;
        b=I++EfRDAVTSDMr28HCN65uFi3/eWrqgsAsr+QpXZd8eURbkMbKUHQwhTA/1oI7G1HU
         /TWXdYA8ausvYWqC846SP197xivwURxxkAImdhCOKRgwpYghLO8h0DLMrknW++KO7jLy
         hNYJ/XqVwShxavdSOUWKvXZwSpamvxKE5hJ72LP6emhNaMiUAmYL98x9sgBCsHnYash4
         dx9CAX6Vh8PpHLSrCFmvjq3u8eybMYuVKy2VDK3RONjEHRzhpw83lLpwfc2DfFrIr/nF
         DTG0bh0s4uwnybsrY9JhRJMFzdX1YQqvuvVb/xa/EXE35pPiaREHYcnx/5h4oXd5+yEL
         gucg==
X-Forwarded-Encrypted: i=1; AHgh+RrtNqwutygoEW9wWAgYNVHjBGbf0/51oDlG3N+KbAL6G+5ZS/vayGE1+mu5Kg2rPhNoH0/1NL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQFIhwctlKgXPG4NYdgE9qldFvX6YYj6vgl9cyHo5sceOhToS7
	u2JV/wpWZVGl2LXcAcKLTCKknkEkmzJXhZGH3hQwymfM3yOfuOBaLKZe
X-Gm-Gg: AR+sD10cz1lNSnys6GJ52OrY/Eg4QbNk5xlRnLz/pqumUCDm3v/osOIUfyxSW8qH3l2
	d9bB+Aqbh8wZ19aC7mwphFN9YUnyLofjDVN2PRqKEDZsOB8FTIRl9Ip0zdZWFrIPFFIqHFAj/Az
	zyNoff9H+sq/VwdauXMBf9jQ1uxYilRBrdNdC7nRuBue+aMd5mh5j/N5QZHeOWDLZcFScxQAhQn
	y9bSoPL+wU8NtqTmZYr1USGBNWEJqJ/l/mHJExeDgiMdsKzhk2Nr9OoULJdX6G9+tA5HwkpMhFG
	3c6ZDBPCXsujvwzBa8ckrt9oJAGsb0XhMlCpZwvFGY4WZHnTqIvQCTJmhQvcSr5ZqHttSQhJ98S
	kOJ+cDT7jmyoC9VRsla6j1GLp3D7BuZ5wPQN2V0D6XgQCbexzyC0sjVlj3qWoV40Ez+gQeNBFiF
	nY+RUMnC1bjUjmYgiqhEuESgPFcfyd14kslUw+5mLTQUOB0X91UD4GhOTeghhouM9UACRzIHYy/
	rxBjMN1zotx+2kSY5mKRrkyxOERRUNJdB7bmsQ7vhcZXzZXCAphAZlaq8hoWzDJ272kRkHQQmEI
	GcRxM28/9+7R9rJqnFK1SQcGeipj6UF0gnwIywV+m5haG9Di3PIfWaQ5ZIe9WrB30Q5cuWg=
X-Received: by 2002:a05:6402:51c8:b0:6a0:1704:de29 with SMTP id 4fb4d7f45d1cf-6a098d07135mr979233a12.33.1785501450131;
        Fri, 31 Jul 2026 05:37:30 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c660febsm1308537a12.28.2026.07.31.05.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:37:29 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:37:28 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: core: do fallible allocations before the
 console can be registered
Message-ID: <amyWRaZN2kSiv3YQ@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-2-kmehltretter@gmail.com>
 <2026073056-embargo-rejoicing-87c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073056-embargo-rejoicing-87c2@gregkh>

On Thu, Jul 30, 2026 at 04:28:10PM +0100, Greg Kroah-Hartman wrote:
> > Cc: stable@vger.kernel.org
> 
> As this can only be duplicated with fault-injection, it really doesn't
> need to go to any stable kernels, right?

Agreed, I'll drop it.

> 
> > +	if (!uport->tty_groups) {
> > +		kfree(uport->name);
> > +		uport->name = NULL;
> 
> Why set this to NULL?
> 

It's not necessary. I will remove it.

Thanks,
Karl
