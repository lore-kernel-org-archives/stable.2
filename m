Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660657;
	b=hZd+uV0jJKe/IqQMV9dqBTxL1xWjFHkEsXx2fyimu8n9pMaCoeBz1dxeZf6N3URYh6Zs
	 EhLjOnMqas7GWdQFbYWENEc3nFv697HOQLkr4NTeMS2O/JUDx+8M/+uu+OQCBHJ5KJvuq
	 i/f/aSjfUk1mhf4IXVJ2Qw1qVjtA2gfVrmWtdxnJ6hISOAfNbrCjX2VsTPV/CajLUd1WE
	 +TeURivvVG/sRQltXjNhocgJejxKs+FvZCy9Inij28y0v3O/LOpHLBGAvuGOfdi5/K1gD
	 xIy2Sibl+7qXpBD7v5mebmaURoMebQKlGTscjEB8/v2wUs6C/FfnB7cQ+lgDJ7nWsuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2kq4h8stbmRwpSHkkjko79M5iC1GcJ39BIlnO54OGxk=;
	b=Zg7v7HJeY/JhjHbYpTtpU1D6qsdJfuRyiQN12qvxdlYuDu2d91M2kTvglTmYHpImvf1x
	 B2G9nUdYuMdaMI4XUinqumnt9Kjwe6XsSm/xLhnIqlZHEMY2l3nzG4cfazLsHrn+Dbkju
	 L+H/obelEXq/B0KHxw3NOw1jvH6JB2IaDx37q1PyUv/Fu3hxoLiPiygiADdc8uqXsEDmY
	 eHYjTjiF/j6C9Id+k4TMytwnFzjnNDUtCgdhtFiTbv7WzGGx/35kKtai/ZEmNgS++btIn
	 KGArySgl0l/egNBEtGSbFX3W3azdlrIZzCZcCS9ad97JUkUSJrttx6i6qO+JLs1BfhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=fLmbAXN9;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5E606A880
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 12:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65C5E606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=fLmbAXN9
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91f2b826fe9so21177726d6.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794660656; x=1795265456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2kq4h8stbmRwpSHkkjko79M5iC1GcJ39BIlnO54OGxk=;
        b=fLmbAXN9Iqc0pev45nnyURfiaA+qA3Nhv5XHVN6XKwwH5o58M77MBRgCGRM3yj1WvD
         ieMQnqFCxluHSTdhv/WRaqSI72EjJuhgmqDYa6RnD+T9yebaSrS/578evDIxUfk3hsZc
         NKCwWfuYP4UnmcxbRxPGeYEE9B7quhJoDRv2cRRmrnpCCMVyDAk2rpzvUYuO0jbCykiV
         jeez7BhubtWySp/YT+hiAkvuRJIRBXXI3HnQuOPAePCDEEY+7MhdI0mgTtMRyUcCkFaV
         vzWLcdIBp0x1VHPSRs/bHgBsLTnEi1h4tOIUrUmRBdF8hgHoRY/th183N/nQDmhfm3AU
         REIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660656; x=1795265456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2kq4h8stbmRwpSHkkjko79M5iC1GcJ39BIlnO54OGxk=;
        b=ek0PToiU1nbgMU3mwtlIYRa3tDuqj4qI58+03joRgQCDluxxBtdGjw7tntRwVLHr1N
         uEfLeC5spwbrG9tnAF+X9EgI7WPVWt9XOtGqL6wo5PtuzuvmYnCWNB+5jahiTQBwHcde
         yTap4aDleAytFMF2cJj2FvyX88c88RrIlxIj5AeOyn65DP1dzM/EqO1qNrLbfIXesVZQ
         qCbx4PGxsM77hfqmLpLlI5rl2jiJR8XZkJ6YZF5Rlc2D4aAv0Gfoq2rg4xzV6q0oHDrs
         WfgwDa+tKGcZLnyBsZMYPyWEPPjrWwtm1moWrOWbLy7fEjEhvkvTCE4U+O/ZWzCl2HcE
         6+zA==
X-Forwarded-Encrypted: i=1; AL+hErHOdBEFr1tF3wvZuKoiO16DCDgtq+7KvbS6+xhfaJ9bEif8q/GKkLezKSiMil4x961lVumjdaM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E9lP7mQoiiL9zfsyh7n0aQ8tq7toZbY56hArB+bQ38j9PQMUC
	vx/OyftH0+HnV6FC1uuOuAvd8uB3AQbzhvysETaPvwzyHhPLTz0ivc+Pl1wG4kOrlCzDUk9Wmg9
	KrKXiYg==
X-Gm-Gg: AYBFou25HevMaXOdeDboOy6lX8vvCC5yQzzyGV/qEUEatHCN8LiQLodCEhW6aWb/AhH
	tetfRC5H9BFfpwTDdWv/+oYMW1T+L7VMVrsjtmAaooUucCQcp1OFHKQglZqnoY5fxvEdvcJJwmi
	vg90k41h20+s9XWs0NFa+YnuLeLyOLcYiV79mKCSKVuatXUlpHRhbgGeJgBRjHf1Jwt1HXfs0tJ
	m0L+tx1JYkF9ZW8kycyRv1kW+KGYU8ZByyjU30K39wMIqV9c47NO+pEi0iS7CPfMUhX3qpavNAY
	JHYWnzRc8wS89ruzuCR/BzEE5rOOZFE/Alv4SwcLTg51m+6/pqYaGKEeNuKjfLTlVizSjJsqVQr
	/KSTIZyAN7d6jCOm1AupVaw46Up8drLrOAr54TK2vwYUt8zNg8XazixkfMDWP0D6lESKhLLcvqp
	ZN9KY6zXtsyQPQT2ts9O5huQKjzM6Psj8NuaGlbNrjQhwsqGzxh8AM2s4Gk8Z9NwuualVpSN5PS
	wHIj/XL1mNhT3VW2hM9vDQtM5V5s8IDV5WC/ybyC1Pbvy+dT2u9g8LQarDkdvJHPXZFaVkgvUIE
	TZFrjjdGGqyCpLl2zfYLtzgN5iCelSkoS+K7JFWZO4I396HMc36z
X-Received: by 2002:a05:6214:4b10:b0:91e:f04a:b237 with SMTP id 6a1803df08f44-91f242135efmr89847176d6.39.1794660656394;
        Sat, 14 Nov 2026 04:50:56 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23dbf30dsm42338146d6.44.2026.11.14.04.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:50:56 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] hfs: do not end readdir at i_size after an unlink
Date: Sat, 14 Nov 2026 07:50:53 -0500
Message-ID: <20261114125053.466665-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bf79e0f0ba166bef46dc5d196b0877dabe252248.camel@dubeyko.com>
References: <bf79e0f0ba166bef46dc5d196b0877dabe252248.camel@dubeyko.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2026-11-12 at 12:45 -0800, Viacheslav Dubeyko wrote:
> Currently, I don't understand how the issue happens. Could you please
> explain the issue at first?

It is the same issue as in HFS+. I have explained it with a small
example in my reply to patch 2/2.

Thanks,
Hengyu
