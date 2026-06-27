Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF423749FF
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538990; cv=none; b=KwySDFCKEYmX1Z+dnusKizwQ2Mt7qarnSQlZPacY/OU5FAjXr9fITv9EOsIwqcTBLK3CzOD4fOag5X7vz0hZg6YBOj2xukaQkvd0wXQ980ERcEXBgFE0UyCwEEPNea2cNYpCav2TobY2P58RQw0/kcyE1tcNtXcpnTuZTwqOaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538990; c=relaxed/simple;
	bh=1AlcacmmfGnLSGC42haB1KmCNL6YGKCWUowghp+cB7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9P0SqkIJCnRQW+pVmUGZvxB/0btEYXxqQ5EI6VyxUUYfj1FT4rZzsFTifAmkFrhnQKGLn0XmimbmBMYC+SMqDNTgRxMBXvy3XO0JIoCjQP9fRtckHmGN9DE98NVjlVsLLPSR3tREme5rxfADAs0ilJxPxNd5bVvZAm8bcNZxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA8ZqyQ6; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA8ZqyQ6"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30e18c3e0b8so52969eec.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 22:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782538987; x=1783143787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqXoMKna19xGBHDnSKCZr4IKhjs+v6dxb7RGvIkniRE=;
        b=MA8ZqyQ6PSrWjZtMEprM1wH20EjXeNvxAFgNqRNBcapuRta7nxP1lFLjGyWF9qZqAv
         NR0qtZ7HQliE7M6kDc/aGIqbl7cc34kVdWralB6ny11f4nJ1ybp12BwerMX6Sd1Ws7vL
         2gKmoD47O95Jun/dLQdID7u6+QkyzLYriJADS2gpTfF7k8xUUciCXOp/iephx8dls+Np
         io1opYnfT71DmO3idkAYJ8rVUIO5HM5cPWD4wI8FILntjaenznB+XmljNEjVdjdWnkMG
         zrrvNAar38KQqLaO37l5R8pJEsxlEKDdwwuHxIGca5sNm6VCx0tVIBVQ1WxaDuOxIyRk
         eW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538987; x=1783143787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqXoMKna19xGBHDnSKCZr4IKhjs+v6dxb7RGvIkniRE=;
        b=SLMFFEF1uOTXeZxJ0mYbbSly9mMpdQ+Km6pBGK5jVdekiMxCBc4J16qaOWU651elD9
         GDlOLTSRqj1vUzk1ZW2qVMtgx1QrDHArgvjqP91+Dv1Xh8eC9H9C2ubLGgukJtKeeKkJ
         3XKGZcf9zpPmj/NoFOZ5zBmhPXNIHa5TKlSuFpZ0wA/3VfUU+n02PgNYD7A6cA/nxXWD
         MIfQ0CNRHjvQubEwGRFWvMW6jj3TC18FIZwCMvNVHMfmHNs828wQjUgjJg6LZVEPTix7
         O6Iifg1N8/Z1/KRs0nYS90yrpyStwGSzZDcp3J1AJjh+FEQqfglNDkuDdLIZCtcsHduO
         YGBA==
X-Forwarded-Encrypted: i=1; AHgh+RpiCH473GBu9QT33GDwKIFO7RMiLc7VS3qM7FmyHW0HkgBuemgY4N8E5D/7R0eryMfS6KSnTwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzId8L98Ls8wiZn3idYq1xA8tX14WPzuiReLACJKVFod9+3FiWO
	u2cV8zV6Q3hEToVOe2NlPa2t/jHMEvcHsMbayLheP6GGpOal0hIPiEHH
X-Gm-Gg: AfdE7ckD2P/wzQhrEMZzL+zaFtVbap5bGhncRtyGwcDWUMyyPb9gpy0Le4l6gqOIZga
	Kha8MH0pk64joQ9L0oIB5djNpqD+Fcpv6UvWO6EiRDZbftk8yl2ZQEMsCsLr7HSKigB+DItAIC2
	rEuxtV9cZObZbN2KWKq9INB6Kxs6+hDufCESVZAGopjQ1L6zfilJ4gIJzub2YxqtH0jQ9vaLKs/
	QE7xxnWbaB+imP76L8ZnBh2Id+8vc/e2kyKbPI1PSUmHa51BNBqT/mhlF2kxGp8Cdb3i7DXmAMn
	rzOB1CGeM+ChzPzej4ap7d35hIeBzeh1MXHP/Q/ozd4/cWziLdSQI2IC44Tgk4WmZAlQBcuuFao
	F8PHaSIaFCsdUlYS2UK0KVPiMzaEVwtNQcrenV71ccklII0aVPZFQvFa1uMN78+YqpYFehNbcba
	UK8DFytfTMO3sS/nej8MicwzBxdyfhW0Ltdqes0pdYSBhNz1RjsqJ/
X-Received: by 2002:a05:7301:9e44:b0:2f5:5907:3a48 with SMTP id 5a478bee46e88-30c84d14053mr8966083eec.1.1782538986692;
        Fri, 26 Jun 2026 22:43:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e062:ec60:2d87:502])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ca5f15024sm11181432eec.17.2026.06.26.22.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:43:05 -0700 (PDT)
Date: Fri, 26 Jun 2026 22:43:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: raoxu <raoxu@uniontech.com>
Cc: James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: gscps2 - advance receive buffer write index
Message-ID: <aj9i44uye8mHGjR2@google.com>
References: <460B5655BA580C60+20260624094739.850306-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460B5655BA580C60+20260624094739.850306-1-raoxu@uniontech.com>

On Wed, Jun 24, 2026 at 05:47:39PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> Commit 44f920069911 ("Input: gscps2 - use guard notation when
> acquiring spinlock") moved the receive loop into gscps2_read_data()
> and gscps2_report_data().
> 
> While moving the code, it preserved the writes to
> buffer[ps2port->append], but omitted the following producer index
> update from the original loop:
> 
> 	ps2port->append = (ps2port->append + 1) & BUFFER_SIZE;
> 
> As a result, append never advances. Since gscps2_report_data() only
> reports bytes while act != append, the receive buffer always appears
> empty and no keyboard or mouse data reaches the serio core.
> 
> Restore the omitted index update.
> 
> Fixes: 44f920069911 ("Input: gscps2 - use guard notation when acquiring spinlock")
> Cc: stable@vger.kernel.org # 6.13+
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied, thank you.

-- 
Dmitry
