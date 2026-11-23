Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465597;
	b=14SCCdQauwjGe7I9Z41awaFZXJwooup4sqFSjAqkZ7cK+b7Ju0/2Lqwv4ELBYelrxssA
	 ZE0+YNlSHj28Qt6MNtbb4MZUaX0Ktru9D55f/D4tSmljVkftvITAGQ/vuRggLqCJsnt2a
	 rHYVoUUMIwQkAhXhC/UvtRYnubzzBi1AB8boA7uc9qo2WOkAQMf1b7QeoOhPn8yyt/Hb5
	 JzKlLybMLTBnoIFFmRsMbEQOO7/Kdh0L/VkykRvfjLEQjQVvBvNOdbcKEZ8fEobKd0MCz
	 vqVkHy8Au7CtE4bb/o99iGwEIGKSsoU36si9OaAwUKP2ZyZFcYdQ444XizAFlhdLnQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HF7kC7ehUvjMLFdO+wj8zalglx6VqyJuBB04EXzZxKg=;
	b=GEM7zLyw7nWYtLqRguA4NuOyz+c55S7v1G8+ygloXGE/8cQeQEpE0Z5QJDXDCUCzyWyW
	 8fVWckMB+dIrfYNrhXcHzmoFPxuF9ZonG4+kjQyO1wA1AEfFfTPIBU/3bVGTIj7zgfSwe
	 Yw2DpvdyQ+h1T7rd8e8LaAhlVOEaivwpVZtdZYdWr2jBco0v066JApFVC5OtNsJOgve44
	 SC3Gv/vtUAVv5jAl3ROuCGkm47CmVdgajxHxJd1cCKDD0z/kSZ/qKblCmoqUBqfL5ScwW
	 2Xi/qFywBKg7zPFWouWAQzkslb6QBgeRBfvOC4m/1+quPcCK20h/ANi6tNYG8RNhjTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDQEEOjt;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A2606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 973A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDQEEOjt
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-385c497bf94so2973042eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465596; x=1796070396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HF7kC7ehUvjMLFdO+wj8zalglx6VqyJuBB04EXzZxKg=;
        b=JDQEEOjtQi4j7/aQ9NeZ5rJt2c9HVesTmaMZZFOcX4uaBY92kBL95IIrzoq0Ax30pr
         gLAHUHeWc2ooegw/GHvR3MNLB1ifvcF/Rb+AMj6GqueKAlA0shXumJ2NoRRMxxTwrH+1
         tg/zyLFCAvTi8L+5EVNsgXz/lb31rjVOip6dDi9mR5MkpS6APLMmUbbjVP2mKNbCTCaN
         ZaGVkza5xa2VByAMUz7668CZBKKugWiOUn/TL9N/OUPqxvTs/m52ZQf09LzwrJwS4B29
         8+Te87KL9Xzl0WvEq4cDDttiIo39RvGFfEeL17zFbFGZfjFA3Vtnvz+2eSnH6Jgglvtv
         DTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465596; x=1796070396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HF7kC7ehUvjMLFdO+wj8zalglx6VqyJuBB04EXzZxKg=;
        b=WgohTxVV1HYSsyacrAqS+K4rC5pGA41C3lFc34DkylC+e/8nkI+35Q63ONgDMorECG
         CtrssWIxMBKiMvWTI+cq8hu6eLsKMZNMH6zsB0SvDjIoYodhRU/Ff3FjzjRFziBVI9AV
         eXO0ua2AvkXnaiecX0zJG/WFlGrZRn8xAsXDdeaga8UKV1R1pMCmQU+91clD4lZ/3/g+
         NvuyAWBLA8202IOv6cGTl7eots0QtgihnDgl77zxDjG/bIPMuWpOK6UXla5Ml1XRfqHa
         eHGt8Co9IaVPUootj9PdPta8PpnKLSLDXZ0uHGjA4QlcBn3NutDZE2X69eSZytmPa1R7
         8OAw==
X-Forwarded-Encrypted: i=1; AL+hErFfIFwcLaA1Z4cnxvyMfbB8/D+ZGevuwyCsez+9n5TJXifcy8qwWPd7xdMjCZlsD5z/XTOaG4M=@vger.kernel.org
X-Gm-Message-State: APuU4Z811ipQJctzpkUPOxUexrTZ9yVsPbVCo9bKeZzB8fMBB1q49Zay
	VCyIZ97Sx9zevFw1GGRcDkezbPjzuGuizBmM9VN4+BVDaZeyxXG0kyIQ
X-Gm-Gg: AZFdTZc7X4BUbLuTxOg1aACWjZYk3JyX50/ISBmyVKWmt0pxX9AQdRga6ot09vcyRwl
	7zAxSxEvtMle204KcbEJEROBdAcinmnZAo+WQMM4EwAxZkGzY5bznaqe1BjwZobIi05eptxEDbL
	zTTqfVbSj+UaCjXBt6u6AP+sh0YHT5Q4tjlpjgkfJUwHYVKO9jjW4e0Md8Ow0wPumcMpRDgifFR
	eeYWa1Uc85M2mylQsKieviYIUwgUvH0SASQZP+tWeUOlLO8BsXKmFEOWJW19qHTYA0sUrhR6GuM
	Ypj040tD96gmo2VWSDBhVtudYKHiL8CXehf1SzF/Rq5DzWLodiBM8tb/SpfUllo9t6c4i8/IpIG
	nFf5z25ab1KRcePpRB94+jKzhPOSzBYdxEZiDpVCGDu7pZ378fN2NHG6zjTYqQl1fR2ZlV0HOsd
	ZrsOfsqfwuGLQKaGBe2H7UI5+dmVbv0eMzJ8TpzfCHrlFCWP+3q6WmrCEDug2515I7PAB0GB4w0
	WM+58Z+WZ48LUQw5NAuFnVME01ClL4D3bsoRpzD9Pe1j6sZUUqrQ83rWVd/vfgw37OeMRLFmu5t
	6TdLGrt7lohsbJPVGfUWPmeBq8G9IMfCBfCQukML/D45iDe6mQ83PUJa7SY2ZpuLlJzEsJI=
X-Received: by 2002:a05:7300:ce11:b0:381:a037:b060 with SMTP id 5a478bee46e88-3856e63b3dfmr13805896eec.9.1795465595743;
        Mon, 23 Nov 2026 12:26:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm36533049eec.7.2026.11.23.12.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:26:34 -0800 (PST)
Date: Mon, 23 Nov 2026 12:26:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Ian Bridges <icb@fastmail.org>, "Cheng, Wacom" <pingc@wacom.com>, 
	Jaya Kumar <jayakumar.lkml@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 10/10] Input: wacom_w8001 - use reinit_completion() in
 w8001_command()
Message-ID: <awShdGUZ-Ur-nLtp@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-11-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123183200.3900004-11-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:16PM +0000, Lee Jones wrote:
> w8001->cmd_done is already initialised in w8001_connect() before opening
> the serio port, yet w8001_command() calls init_completion() again for
> each command.
> 
> Calling init_completion() on an active completion reinitialises its
> internal waitqueue spinlock, triggering lockdep warnings and racing with
> complete() in w8001_interrupt() if a late response to a previously
> timed-out command arrives concurrently.
> 
> Use reinit_completion() in w8001_command() instead.
> 
> Fixes: 3eb1aa43ef5c ("Input: add support for Wacom W8001 penabled serial touchscreen")
> Closes: https://sashiko.dev/#/bug/linux-002efaac-c345-4827-8f1c-7b9d9226c713
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
