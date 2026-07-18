Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92A345CDD
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784376314; cv=none; b=Ou8oRZUtFW6SMU9JevSUy1Me5pn4QyfmKhzrVWM9cDK9yWhU3qhhPBTp2Bl9ufMo8E2dK8sXg7PJVyNyubH5iIoTvG6nezJ1TmPK7ApbsOMiFcs+tJBCR+2wkz+civrHNUNgfCKQkr1FTA7ij9pQjkJ12c/QSWKDUjQZba7+I6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784376314; c=relaxed/simple;
	bh=UVQD7xZC19STANRHQeLYYOB6lofOMAO1isLrdP9clP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHnIccrSYveibMdcJlr2EmuMPbYubJwyDCEDtsSpEEd8dh0g+J4wosBmUtfR8JU13qa8nbenJ60zM+T3+fAMnf3okf0jj9lZKHpq0Nq+7MmEWnUIaIhTyo9ge68RYgblnFUCFNJdkIqvmHnFxLYVvizM+nY1LVYWevTQFZgDwoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b44ecTjp; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b44ecTjp"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e55b62640so585955785a.0
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784376312; x=1784981112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Up2YZHFeIMQmB6EqO7RZlnVeEM60lSIwrWpc7fQrQg=;
        b=b44ecTjp4hdjoe+OOrr4kGpa4Q7ndKzI09TU3MlJ72kQCbjsOq9TCyCPHKM2AUbbHD
         lgupABa4+TLiROvIwAuwyPb29i/3IP687gMvUGwp500bxFxb1AhulwPC8wa1qfB24YBi
         lX8zijbNiehqhMJp1p58kcHcWXAehwnNEVuGbGX5KI64MJsj4Pqvu4ULzou5/aAdTljw
         vnErVcA/Lpe0Ju0oqMIrwhwClHKS/EwpI35lbU/vzRZpl0/P6hfrs8of2gRfPNFt5c+f
         lpPKobDzYm5aDkWLs6oaBzvMt2wsKFUPtVeP2G5FwCuJnNgne72zZrVpc0VhBryMD6Ik
         oFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784376312; x=1784981112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Up2YZHFeIMQmB6EqO7RZlnVeEM60lSIwrWpc7fQrQg=;
        b=Iv4OVGvS7AeLjqfnLctL10IJ2B6tAjBdIVX5Pjo9LjJzM3cWg6+uIPOQTgKnK2s+Lt
         K50BGqc5B2+sgJvjazvyTXq4Cztie+ArAKVp7ehW8rC8NH6D1OJSPKyEeDylytFusLD1
         BMCbbHzrsH3mu2fxPcxj1UsPV8rF9jCv+ESexCbdAmasuUd4X9AN31zqfbe2+lvdMlM0
         p/Geir65PAU0bOLzHNeTqRU84a1uEjEJ8aSztL4LsnrT5mKOt9VvybWXJnoHoVQbUuSK
         S+LIOuRwh0gqWZ4MzxDYyjx6lDwCMJxaTVJLHFiydm2xiKfsP4DTCcCTmK9pEmOLxE5W
         umYA==
X-Forwarded-Encrypted: i=1; AHgh+RqvUxAPhYz+HKVDd6j9fc/TLPn/LZZ2EQzBLMfAOINiZpsgO2M/OXNp3wT8qslW4EEGg1minIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkke7x7F4BW6gCfrANL6WjeDuxS6npgYvuhQTFr++wShB0UH/4
	13TOZRF6aWJ57VDKwZhhn296ThB9ezhWfmWVg6lXPtuo6FMMg2+C//Q=
X-Gm-Gg: AfdE7ck02yS4p2RCj70pFHUvSA9lFxTOLi54TUiJXt+nRWspFyw7cmUJ0ou2fGLjJFb
	0uN2Q/DeWxnw6sudy4+g9VpVAsPGoDlsnWrmi/TwKd/KSaYEGBtgNEOHP5vgemyUpaT5h4QGJfZ
	OYrbCbl4w+2ljFP7aBeN/NTCoR/6qScsqwliKiHpSJdv2Reoi5TrhnUB2wNggWy/XbtDqaUziVt
	ZhCjm7TCoOKNMW8igK5I60PBCjyz6TbaazqrjVvzNw7Ua2dZHmbC38sKamXJHa5Zf4w1zYgCspw
	knBU2abI2aLAhNOMajX4N0R38/ADHlLWiFI2NlFBOZPmFeCHNc/+MDTFenTtQ6+Bq9lRqUX0C5P
	B+2Mfn3IU4Q5bt4hRdQnq6WHF175gWh9Qvahp/r5Goq8nzR6TcrE8+jS5Cb+bj/fGwrRiBQFIJQ
	zWs4egFDhITsipOkchEJ2s5nk/dHfeG/jLaQP//fnLZ0nMcahmO+/1ysY=
X-Received: by 2002:a05:620a:198a:b0:915:f27f:e70e with SMTP id af79cd13be357-930b3ee61a0mr648064685a.23.1784376311790;
        Sat, 18 Jul 2026 05:05:11 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b549629dsm389690485a.47.2026.07.18.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 05:05:11 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	hvilleneuve@dimonoff.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	manuel.lauss@gmail.com,
	rwilbur633@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: clear stuck RX-timeout interrupt on LPC32xx (PORT_LPC3220)
Date: Sat, 18 Jul 2026 09:04:36 -0300
Message-Id: <20260718120436.20196-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpsOr5ZVqa_eLs9@ashevche-desk.local>
References: <alpsOr5ZVqa_eLs9@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 20:54:02 +0300, Andy Shevchenko wrote:
> > +      * Same bug worked around for other 8250 cores (8250_dw, 8250_omap, 8250_bcm7271).
>
> This is 8250-port.c.
>
> > +   if (port->type == PORT_LPC3220 &&
>
> Why do we have this then?

dw/omap/bcm7271 handle their variants of this in their
own drivers. LPC32xx (PORT_LPC3220) has no dedicated 8250 glue driver.
  
I gated it on port->type because LPC32xx is the only hardware I can test
on, and I wanted to avoid changing behaviour on 8250 variants I can't
verify. That said, the read only fires on a bogus IIR=RX_TIMEOUT with LSR.DR
clear, which a healthy 16550 never reports, so it's harmless on other
parts. Unless you object, I'll drop the PORT_LPC3220 gate to allow for generic
handling.


