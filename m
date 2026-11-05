Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890643;
	b=Ay26ldeSCbn/6gbKtdFvMU5cPJpD9dwB7IDjK6SQs6kNM6WgzaKHh+HFQL7HzIqZxlnE
	 uIp1aTGxhUrdF5q+hQKnr3Aq88fgsbNzb4mQg9J0q6+d9kBKZtCXK8L01o+Vx2Xvr+dta
	 ErjO3hVbBLcNA2sTL38xhsM1MA9ulfDm8shwFqTiCXVFEx3sk0TM8DFgCIoX7LfbVWO46
	 O/9e0cV2O1EnsbAwnyXMBTSqQow/WYeYrQ/CU4pPXgF/3V2loIqjvBgmfSMDtKjkyoWk9
	 WXJxqcQd9epxo8ASjzorSLUHMDuwQ0Y/4XFFkShgo2V9IVFrM7lJb8KHWe4oe47Ipbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LAh+fHBX5S66jM7YRVkD+ulSCs8XeJoMda5fYkmtiaE=;
	b=CDCep8y9JNv2zkFyojXo4mXyZfv2lbviNzaXCxk9ABULRf1pCA3g2ugFvYyiUmQ7fC2k
	 egNPpnXaoN6rJh/jiWTOwRNKMrPZ+IsAF6ZwXnb3x9b0sfd5yREzOhhgrnYGxHT1BHK4M
	 asSg4Odi5qPcDq0V1RPO8aOP4n3TJLzUdgZGvE0EgTKDTWTTQYglQXfYlCudi0Hct+1oD
	 U9runc+gUh1wPLgbp4u0SYt2S9HxKeeTFwJeOKZLqVql/bJueKw2GqPocLmZMuKoxDz4C
	 GXZX7/4X+i+BWFy3yiwUsWnS7SmHlQwfEn5sExbNuduVMFkulztMqAwERA/8Yjqzyvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FFicVFFG;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D5E606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D5E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FFicVFFG
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a1947498bso5594878eec.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793890642; x=1794495442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LAh+fHBX5S66jM7YRVkD+ulSCs8XeJoMda5fYkmtiaE=;
        b=FFicVFFG28O7DsFqcOvD49oFjNd+LS/7lAbf58ZGjBb/ARluIGEWnFD6Q2Y4X4frcq
         oYLDDZWVdImMpDkRCoTa+Obj4Oda/YGU5FfIyOd97AbrxpvgysKXTsFZfyNhN5/dTsWN
         bwsW70Zc8DDZh0BxIWQNyHuqk+3ihGVMCJ2AzXv+zzB7wHE2ir9g3VlcPAyYK4VNkOfo
         7zfMXGKq7ruZuazM2bjmZatE+7Ya5JoJCZtUJ1p7/9arTLOjUOqlE5qw5ZZROIcnHj9u
         XP+vba7vEW2rCDBgPYs65sFjmi3d+X6TW4yl/9VESaBUwFc1AGHWIXTXRTscx2OilQme
         7s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890642; x=1794495442;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LAh+fHBX5S66jM7YRVkD+ulSCs8XeJoMda5fYkmtiaE=;
        b=T0UW69FrghTggIdDhkvWPn2qOo1qAMQPO/iehcYPOWgQtZRh4dE7E/BhgnpI6sfke+
         JqNa50ijpBd/5GhAsM1OH8wS+uEkv9kEaKxVa3szcGrxL2j4MPgoJw21ybACrMa/YBi9
         e8Z5AqTRgDwiNFsEBdi7tnH2bH+SaK3BqahEffNbIRKBRC6OCp7+ux/MO71Dib+SybJX
         tiR/tIVwOZQmkadk02/juoMv+ydEHnAGzLQ2zjN7HwvroC7J8TM5G7zkKCTz9KiBuuMn
         /WadOqeKjnCvTGJE+WyAyXgIK/akJ/HdADTS5BDAnKq26RaCXTaTHiWYGU4QwDP4Vv00
         tOWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBTmgZNyFOH5MT6OjQfyEHh86cyf/iXaqAlmWWH+vSxbOtr/uPPkXtJz5L+9I/wMO8Ln2sVvE=@vger.kernel.org
X-Gm-Message-State: APuU4Z85mJgWD8bz6rQbuyYDnxhGLs8saSG8kyvNumnHaQO/DqdzPSw7
	9HfwZ/E39aMZWV4TP7lfk1MoXb7QC0bfaj387kwJu2Z26NVbdjyOZYS1
X-Gm-Gg: AYBFou3tNE09SpOYBZWZSidFLTxo1FThR4XmlzGaCHoiJzBIshLum15/RgNqV4BDZiN
	5PtcZeVgC13jgrGg8gU573uxFrQyZAtd67KKqsVYPlQRhnu6tbFwfNvtXvud4A9JwWP/hfTUmAU
	aIuQJOGY9h9uww2GIkgfT83va6rFdrun+AKEbxL92npGtR2pDS3SbUj0jwfqalGEnDIyZ+Yu6YP
	UYykRgxqFk1tpGLPPeAE8Y/qVYhjQUfC3c2nQhvcA+93hPCI7TrGm6GdVrxEXZOJAIkdO2p0mMa
	LEdpg1TEHdcB/8N3Ay+SDHQvtDXvdjqMPwh1b6i23QZyAQSt91fZlHaNZVWrf6kZWCkm/EDyEUf
	tmPipNl+bNXDITMbO7PKwU60EVrQQugh8GXPFd8oCjPx3Ic3aRWjZLxcMOiAX2c1SvkYbDhnoNZ
	gduiyYSRw2uxccOhLdJxbQLIusfnXMk4uTJJbziLQGUxCed9t4Vowm1PNuowuq/h4zcT0IycVrj
	Fn/r38F/8cj/y5k6DMw08GJw7HgvgUNGFN70+qF3MO2WnSR7g0JRN7VHM/02E5DDddm9+3XieHY
	JVdnQQ3YC5VlDWZuiJ+qPobvGvBlb2t5He1/i/T58dA0YU+E
X-Received: by 2002:a05:693c:6393:20b0:369:f291:49da with SMTP id 5a478bee46e88-36a4243f71emr28876543eec.40.1793890642366;
        Thu, 05 Nov 2026 06:57:22 -0800 (PST)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm23369977eec.27.2026.11.05.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:57:21 -0800 (PST)
Date: Thu, 5 Nov 2026 22:57:11 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: fix waitqueue deadlock on chip deregistration
Message-ID: <20261105145711.GA92894@rigel>
References: <20261105-gpio-cdev-srcu-deadlock-v1-1-6047117030ec@oss.qualcomm.com>
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
In-Reply-To: <20261105-gpio-cdev-srcu-deadlock-v1-1-6047117030ec@oss.qualcomm.com>

On Thu, Nov 05, 2026 at 03:47:59PM +0100, Bartosz Golaszewski wrote:
> The three calls to wait_event_interruptible_locked() sleep while holding
> gdev->srcu. In gpiochip_remove(), synchronize_srcu() runs before
> gcdev_unregister(). The latter fires the waitqueue wakeup events from
> the notifier callbacks, so a reader blocked on an empty FIFO never leaves
> its SRCU section and the removal will block forever in the former.
> 
> Since rcu_access_pointer() is a plain READ_ONCE(), we don't really need
> to take the SRCU read lock. We don't access the chip structure after
> checking it. Remove the lock and instead make the waitqueue aware of the
> possible chip deregistration. Keep the initial gdev->chip checks as
> removing them may change the error codes visible to user-space, for
> instance in cases of a non-blocking read on an empty fifo.
> 
> Ideally, we'd factor out the common code into a dedicated helper but
> there doesn't seem to exist a clean way of passing a kfifo as argument
> so let's open-code the three call sites.
> 
> Cc: stable@vger.kernel.org
> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> I've had it on my TODO list for a while. I vaguely remember someone
> reporting it to me but can't find the reference anymore. Please feel
> free to add a Reported-by: and Closes:.
> 

Isn't this the same as patch 4/7 in Adrian's series[1]?

Cheers,
Kent.

[1] https://lore.kernel.org/linux-gpio/20261103-gpiolib-chip-removal-v5-4-aambrozewicz@nvidia.com/

