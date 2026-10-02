Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2733F8A3
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 03:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790911271; cv=none; b=s8MvTzlCotOvFgGq8q9bOtRTtuoVHJvbnBEMuJO7zDbk0TeotSlgIG+BZnhX8iNohePKC02hdJ5hTEGq5O0ekFwcy1N1qDWYNWuVSvUKK4hjCsGTKca8Wh5cKyKoeKyR2DN314KFpylSYzT5fx4nDn80cBGqpEEEpri2xmPe63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790911271; c=relaxed/simple;
	bh=9e/CIFXE1hRvmmBtn81dZMs2PO0YXmm+YvcEIQTBoeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnRaecOIzQJssLkACpSXSasSSTXnrRCBp3YxdYyOij4sHjg8vpd+AvDAhFDnrTyYCzykkVuMx4fpoPeU5MYeFhLmonE9DDPST3p0xj0hqpr+DNssE51TCGLfZaInl6E/+CglIKhzhxCS20/vMkoV2lMPwYrMCgnCTvhJyevo5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=G3/K8+F7; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="G3/K8+F7"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-9179c1f49d4so23982796d6.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 20:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1790911269; x=1791516069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9azLLJ0/w2SLdlZw13OtPeIgu3MHaV6UePQJr1K1VpA=;
        b=G3/K8+F71Mu2gcVcmNmfX6/T0m4YK5IngvZctDFZpfXuH37EGn4ONxXLR1kbHMTTCs
         imUM4a9H7D7YJuz0NAFTDbr5C2Hsj2HfiIgu3gq1wvXXihuNCYQponLgwoe4Mdl54Vpe
         bbGjH3CgSYzbAcOuB88MfqLeGoyCC2f34j9FQfIaLoUnwoItRDzigIC45EKoW42jA9qj
         fleey2Hj/+V9P65bGvPU3orw4OYfnuJfyyKo9UknMYaGqeGeuriurT763umfhfVfUrOC
         w8I3EF+H1bmeZW7S83RNhuW+f0VtOGGizIBZsw3lCmO599y4oIRuZfIW9z4CYXuWJsJ/
         5ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790911269; x=1791516069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9azLLJ0/w2SLdlZw13OtPeIgu3MHaV6UePQJr1K1VpA=;
        b=wtr6Vw8T/6UzOw9O/KdOkjnn7tVXiPoLleQMj7FdVqt8DUUiYgsXGGKg9SE/SbVslq
         33XKnLm9S6Yys5Nz+fDYQSfuJLujs+HHtFKpknvHkGIFFTgPkDgtrJGFBjFGA8I1v7Ub
         fROXPNfGhpfd7NeqOB4uu1GRfSQ64Gq0mXKeiMFX3Gy8ZIffnNRcGH1/h4N3U3XWVoEL
         fnTaBCRJw8fIj3iHp/TYP4EgMBTeODozL+4dV0Qq2FwNAX2lFSCvPGbXPfFtKxXh94gF
         EdPvh+9MFKaYCpkayOzn0Hq1bPDtcps21rgHnvALvQLO4HQkmr8czkAWLgkqOGDlLz0n
         kktw==
X-Forwarded-Encrypted: i=1; AKwUvBxcVMuBeO/j5Y865hUkaDUkeDz/9I+4p96613ym9MijswXrtbsDn5vDH8tztebbQf9z+6VVGVA=@vger.kernel.org
X-Gm-Message-State: AFuF++nrWrwE6MmROKUlyrUaDpFjwveY3yj7EVBm5HJkCtICyJQ7O5UH
	KpsTmFPKHwl6Cv0MqTAlDMbJc2gZk42qg8kKX9/ZzIS5y2+kjLvPMR2mU9QT76xIOQ==
X-Gm-Gg: AYBFou1Ya5C1vlEtejduwpkq8OU40qpNlBcR5u5TkbDe/5A4DBwiRrD9mtTThDCdNHm
	5ajpZdJm6U2qAXpsyjxRO+MsVGMmBddRSYsariASJtsYY9LCXE/5TtF8qA1LY68ymvhA05sDvV5
	lXU7WhNfsnhGhuxxzlpoTUJ9wFBBnjDv13jidsJTTAfhCAr8jyHiBB2DYeoUZSZMSxnc/GoGOhK
	mZ46DpV6WKUoSSxcvmjRyE8VdhJP6qpvSAp6w+lJavSO8QC//Slhnk9vVnqaCmJc7vnbsLcgM4R
	VTOhqHhGtstQ4YZu9bKL2kRu0hfXvSi/d9dAN97nJ3/JmW4G+NBvG/PaPbUKjm4CifypRIknLxo
	2cAftCLG2VlgtlqsiKTChRovv4YsfMg/TmA7ZE9QPIJ6rjyTgzWRrPSWnWyu8vwuogfH0AUZyFZ
	gd7VMjoh0wI2S8flPAmBv+EukhieV3f/M+Wrqg9jFXkd++YNATzX+J5X07bY1eghrDot1OAmUCY
	Fpupu75+TRf++3A9WklBQ==
X-Received: by 2002:a05:620a:4713:b0:939:fce5:f6d2 with SMTP id af79cd13be357-93cf16de7femr243905585a.27.1790911268791;
        Thu, 01 Oct 2026 20:21:08 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2d361bsm115242285a.45.2026.10.01.20.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 20:21:08 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	jiayuan.chen@shopee.com,
	jiayuan.chen@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ipv6: route: do not validate nexthop of routes promoted to reject routes
Date: Thu,  1 Oct 2026 23:21:07 -0400
Message-ID: <20261002032107.3289370-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001154629.GA1611116@shredder>
References: <20261001154629.GA1611116@shredder>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 06:46:29PM +0300, Ido Schimmel wrote:
> On Wed, Sep 30, 2026 at 11:22:28AM -0400, hengyul@cs.unc.edu wrote:

[...]

> >   # ip link set dev lo down
> >   # ip -6 route add 2001:db8::/32 dev lo
> >   Error: Nexthop device is not up.
>
> Consistent with IPv4 and expected:

[...]

> I don't understand what motivated this series.

Thanks for the review, and sorry that the motivation was not clear.

I found this while comparing the behavior of different kernel versions.
It does not come from a user report and I am not aware of anything that
depends on the old behavior. These commands succeeded before
21ec92774d15, and its changelog describes the
"ip -6 route add 2001:db8::/32 dev lo" case as unchanged apart from the
unused nhc_pcpu_rth_output allocation. As the commit also went to the
stable trees, I took the new errors for an unintended side effect and
tried to restore the old results.

I agree that the current behavior is consistent with IPv4. The syzbot ci
report on this series also shows that the old behavior was wrong for
multipath routes. With patch 1 applied, as before 21ec92774d15,

  # ip -6 route add 2001:db8:100::/64 \
        nexthop via fe80::1 dev eth1 nexthop via fe80::1 dev lo

is accepted and installs two separate routes: the loopback nexthop
becomes a reject route that does not qualify for ECMP, while
ip6_route_multipath_add() still notifies the first route with nhn - 1
siblings. With a netdevsim device, I can reproduce the WARN_ON_ONCE()
in nsim_fib6_event_init() with this command on the patched kernel, and
it is followed by a NULL pointer dereference in nsim_fib_event_work().
The current code rejects the loopback nexthop instead.

So please drop this series. Sorry for the noise.
