Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734283822AA
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199333; cv=none; b=SqJpxidVUWd0mxVKpnNGIJzjEYhbkKbe7ugcPS4kTt8+4kDR8f2QTmyct9JSwGmsfDJndrnVLXfl15DmWJ7b29hXhcr5AUhypyHA6dZkb6RTIN2QQ/XTrnTc24KfzRG/mA/aY5CIaFsfBY9aHT0HJpjdzYBYNrg8/qOb9ehCFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199333; c=relaxed/simple;
	bh=/kc7PYWlypYVZP3WwE3BLRaLams28RAM1V7UJYCZVTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0p4CnORcs/K+7ODOa69C2L/lLbYQUht8ZjGz5iG7LbSppGaMxpf+qeDq3ZTTu/CWhP6SG+Zd/Nb4YGau70zppQEuuPNCn0DeXRG0KtOyg4ySUSDH1kWGzXAicfr/BrdgRhhTrSccZL9ib3+d6ujhxBldNerUq5G/tj5sW6kj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHv7odrE; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHv7odrE"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66e5d39cfe1so1655452d50.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788199331; x=1788804131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qFhzGXcio2yqCPX9oQAAIfIvI6f1pTpkLcuZuvtREFY=;
        b=MHv7odrE8SejtQpE1GafynAeRlP8HCsgYitHwn58KMTCPNJtsmJiACkoFWQmfi+j7r
         csneJbE5rxxI3RXjzKvworDy6oUKt3D7wvzpUHFOkhjS3JJthI0Ogw9itXOl7BIaYuqC
         RSr+u0UXNoxZqA8a+AU5GiFwa9UA+chHvi26rn9I984WnQ8bw+2Eok0qlWmTcshc9ffF
         V6QBcI4UJWjIopObC5DkUH56sy6f1SaZTswgn3jgqLVEUU7Xej2yEceoKT9N9Y0Clot5
         2argFZBAXVMVjwvL3C1BeelL7dVyGc6djBBeDRWYT5sN+qZQjHpNCWsg4dhZPnwTCKHt
         L7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199331; x=1788804131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qFhzGXcio2yqCPX9oQAAIfIvI6f1pTpkLcuZuvtREFY=;
        b=NmqbLp9myxhln4AbmqGOX+BgyER8SEw89kSUWsbJHw/yN8Lvoi7yI2OoRKlfRWnIvV
         BDCWtBk2vy8L9ABJfymAlvcFPV5+XT/O/5wJBlhzJkZdzMCwODc9uxj4LsDK/q3V0Msh
         ddn5d2to7OYjuFAVdgf1RUpCqswDU3VySs+8vpCgTEgUsgVJj+es7UtEAefRbbYkJLu8
         2zPCXSIyIsQ4Zm0d4A47nSm+6S145qPA2Ef7Ud6D+v5FtpmMK5eEdifPncqM0bpus+uR
         0qOW70uNC7Pvf3SUmPMOj9UjCkfUEdx83dShad2SVW8i9lvQ6k4UJxu4A/mRau17vCiY
         6Mjw==
X-Forwarded-Encrypted: i=1; AKwUvBye/oChVYuzy+QnEIU4B9YZaFfFAIxDXyxOkI6LsvZm4crQP4JsQc+q/92iDGJmeBX/xHihUy8=@vger.kernel.org
X-Gm-Message-State: AFuF++nvoFS8b1Kr5HARN1yVlauZThp6GQJIXk3hipvuGmPpd8Ntu3J0
	1tqRSpHJ3+73xEWPIWPM1syKp0r60130w5enp5O4OQn2+QfCix3V1OkJ
X-Gm-Gg: AYBFou0G2gQtnFM5Ghz+Jbk4kpuD56J+ghu+sD7w5NCXjUMRYqRRlDkpiUFbzsx7soz
	LUQ8Asu/y4+6Qa+Mc0L7ZLsD6PkNc3DFYcRV7LXFtIswSeyO3Jbc9Gm8vyXAyn1a0YmAM7lYTnD
	z0oZaHbIj4XOxDM34d6YJUwPm9JHaB34KuVaSi5wMXSR2iw/ULAGViqyalcKx6V+FZ/3sQw1HnT
	nuyE/2Lh7DBSbomYSIIAvmSRlJBTh1ug+Xssl90nZ4HaeFcfBMmabtNB2GPvbHj8Ng3q5e6eUDY
	QuidJ/Ip8lHJV7aeROwFzmAi6FCUnhlRWK9ZVYxdYiqiNex5oMsjMLuCpHIIKkwoHVG8At2ryJp
	aoMJwmovPmzPwHKUzBGhgSaMS06JxagaP2jyHKLad+9DUASbugRNc1xHz+qL4uiQkPmeOLh4ScZ
	smr/1I8ACa4nlJTZ/A/L03g2p3W6qN+KiiiPuGjp6CoDGtIEIYtPNeBW/IieWs/aR2NwUwTgQKE
	9nW0v7J38udCjjRwDdAd80uatw=
X-Received: by 2002:a05:690e:190c:b0:66f:7717:a700 with SMTP id 956f58d0204a3-66f7717adeemr3379779d50.21.1788199326215;
        Mon, 31 Aug 2026 11:02:06 -0700 (PDT)
Received: from hoboy.vegasvil.org ([172.58.167.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ceb0a3a09sm73932946d6.16.2026.08.31.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:02:04 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:01:56 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	arnd@arndb.de, john.stultz@linaro.org, jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v1] ptp: fix NULL deref when adjtime/adjfine are
 missing
Message-ID: <apXBlBvh0vqSzhyi@hoboy.vegasvil.org>
References: <20260826101004.100979-1-xuanqiang.luo@linux.dev>
 <e9c97286-d121-40ca-b6f1-4c63641e7283@linux.dev>
 <ba8e71ce-42e2-4c92-b7c8-dd6ce900a5d4@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba8e71ce-42e2-4c92-b7c8-dd6ce900a5d4@linux.dev>

On Thu, Aug 27, 2026 at 02:43:31PM +0800, Xuanqiang Luo wrote:

> However, the PTP hardware clock documentation explicitly states:
>     Clock drivers must implement all of the functions in the interface. If
>     a clock does not offer a particular ancillary feature, then the driver
>     should just return -EOPNOTSUPP from those functions.
> 
> Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers
> 
> Therefore, iavf does not comply with this requirement, and fixing the
> issue in the iavf driver is more appropriate.

+1

Thanks,
Richard

