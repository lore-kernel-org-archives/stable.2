Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016560;
	b=0gfXIQ06IxtJEC6P7SAI3F5qmghMxDGKkP51TOkLGiF4ih7ZaOk8iRVtCLRE2EC1ttvM
	 ZSi8JLL0K8seTwZzLW3lyAknNrfPtO2o4XW4BgTs2yxvNhPAHAifq6pNT1advET2z5Xdk
	 Wq+hTOvZnjNokUD2sSYPScrdYxeiBEP67MVHQ78B9gT96chErkq7bKqIaJd/ZgQ905QKd
	 3r6xnvMsN6U5MPIrklHs3tVh2Pt47N886JC43P/vJ1LFMEhJGz659Hs8ksgI9vxWxV8X6
	 GKD9znHpurxoK9xdiABZCQd9CSpopTUOPvKKbLZRIgG/MTG7nz/JEDrSKe0/IwsffHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RKQbSciVgm6q6OZuo/dZsxr8jfr4y3IcbTHmuYz4xRo=;
	b=BorLhee13ngApstAbb1pyqtKCd1u8APszrdjinRFlCZVmSNQdcfbkJxU+h/lmn6PLo4b
	 C1Vl7aQop8qxLUuCDlbAghfWytNMmzZx0lo2RH3Pvqp3S9QXCduFpYzcZ+TuWRk46QRVm
	 GAfiZQOiEaPyJDkh1fiMhHS9LNAI3L/BRkGLwOv00rRYJRaAlDuV52aUsv7/NlHV3o7w6
	 N5sf8iZwVRLBVmuWO5Jl9flmQ18QvDt1kLK51mp1j0i7JErVCMZpBlnFdHq4yTzVVwIvv
	 /ntxEspNejBND7KT5Ne0xhnhhYUCUxk85JudRfpMHShvKfmuMUC2/CeRjSPyfg2J2pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eXLibT/q";
	arc=none smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55482606A339
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55482606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eXLibT/q
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c15956ce07so1972324e87.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795016558; x=1795621358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RKQbSciVgm6q6OZuo/dZsxr8jfr4y3IcbTHmuYz4xRo=;
        b=eXLibT/qYFd7DQjxErpIUzZgYn49p6J/2rXvi1eenyjCr3QFswsL4rc5SfIIfFHC5D
         M8YYkzzmaAyOtRqEDzDA8z0pqP5cHILcIbQ+mdYrK1zwURohpC7vZkQrZ/XzlHzQdyTu
         Cqeb2TqSQBnwvVFAqvwgv4dbX1PYizJnVwdc/k4UlfiIBpADUrZXYbHLdZOzkX9k/NFl
         jzOf7d95kF9171GJnVs1GwerQ8WWTMu57mBlSynbufpCSYC5+ucFcm3JsdIq3+Uf1z7x
         Xpo4/5Fw5iDrOBm/wIcOXnc4415Abe4tUOBJLHzMRxU460QIOVPoCGNdggNS4ifs4wjT
         T6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016558; x=1795621358;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKQbSciVgm6q6OZuo/dZsxr8jfr4y3IcbTHmuYz4xRo=;
        b=Pa3eWbDPqn8wm5kH+c+pub2iktOMHa4m386jiTPuQYgiAA0H4LYMsSAKAo1ccmUdEF
         EbmPVW3eJr8ClbClUndztkp2sIeI2Ct0t1zHr/Swt5dAMtk2323UfVv0jydoySm0YCEf
         aeMdfaM6vls1Z8GLbFKQspFknqtZBa75MXeciAChBM+LxuFG65PFQbPA6pKzpPKA5siH
         aY2pd0Eb1fxT+KO3b7CudTW0qz9CrUit2zCZ8t7vJ5WrjnMn0SeO7XU5hlCf1N/BSs2E
         Ua/TqmPKTTc2De5z9N9UQPjvE8asDxLxJz2C/OhXp0JOd1OE8NVaeSL+56TPM5V3owTj
         QX2Q==
X-Forwarded-Encrypted: i=1; AL+hErE+21bqqffEmbbm4x7eUWuPBzgsgHEG9qLywJzb0TcLqYvpwRpsn8W4kTEzKIALdz+3OeFmLRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gx2yC4722pU74rbV+c7Kk0XhyvRZwAIkSNIqTdTxYcCj053Uo
	VcIfyZATCz4uo713Os0sgY2mFLMvJ6FmiySf+XwfmEjJZ32vwIdUq0qv
X-Gm-Gg: AYBFou33YddSChjYAeilTLffkzTGsbLsN4UeMXJyyzebO2gtwpaTAZVafuOgbMWjq7B
	tjBwPwQVt6EfHsMhmMDmUUDEx7s937hS6flpJLvup08v52QJYvYVMUa5KYrTmSnqOSkJPz6bbby
	X1bIjfOUJNR+lPmG3IWv73bnZbnKaSHVl5O3vyyTg3ro6dfLdufqnCnVFM/8TXAwVEelO2azISJ
	paTAbvqe/50YApKQ4Y6a7HLOS3X2IUhdDsIXpDfrjsSkZQ88zo5VUXetjpRrCG4ZUVZ9VGv0Lef
	/Pr+bLhG6MjbkRVBHH8R6nRRBo8BR7nzJCDlX4bkgl0eyaXyRdFlKsEKMMjGzT62dcHDanyJhgO
	2aNMcKh+bNZLFRi9PQR/45F3Vqccp4EurugR31+Dd9Hf+IdqbE1nc2DV4gy+mFsb0LVWMILK0lz
	y+6Xx04PCmK4Dhn0YJNC0BuJSe8TsUSJyer5B5m0b6sdrGWiscMLjcJXs6J++RZ6boQ/JfdjdIN
	bhGc0KXzSrSPv6JGdbl9o8DPe4wDac2mik/9FKwVHtB2S8GrKjKccY/MHsa8odqYyQc6WdeiY27
	g5yAp0rHzbhOwxRANgdJHVnLsXbd5SMR89BpAtj7J1ap/hxRSA==
X-Received: by 2002:a05:6512:32c9:b0:5c1:56e4:c705 with SMTP id 2adb3069b0e04-5c1a0e434b5mr2331156e87.3.1795016558031;
        Wed, 18 Nov 2026 07:42:38 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1aa76035asm631034e87.27.2026.11.18.07.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:42:36 -0800 (PST)
Date: Wed, 18 Nov 2026 23:42:24 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v6 6/8] gpiolib: cdev: don't report a failed line read as
 an edge
Message-ID: <20261118154224.GD46152@rigel>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
 <20261116-gpiolib-chip-removal-v6-6-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261116-gpiolib-chip-removal-v6-6-aambrozewicz@nvidia.com>

On Mon, Nov 16, 2026 at 03:47:09PM +0200, Adrian Ambrozewicz wrote:
> With both edges requested, the IRQ threads read the line to tell a
> rising edge from a falling one, and treat an error as a high level.
> 
> The read fails when the chip is gone. A driver's ->get() returns an
> error once its device stops answering: pcf857x when the I2C transfer
> fails, dln2 when the USB adapter is unplugged. Since gdev->chip became
> SRCU-protected, the read also returns -ENODEV between gpiochip_remove()
> and the IRQ being freed.
> 
> Drop the event when the read fails, as debounce_work_func() does.
> 
> Tested with gpio-sim removal (test delay in the IRQ threads) and a
> test chip whose ->get() returns -EIO: both reported a rising edge, none
> with this change. The HTE path was compile-tested.
> 

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
