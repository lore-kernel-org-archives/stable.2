Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FF38424F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789250756; cv=none; b=pSeC/sKKeVqWEpE+zXhWfTNUruI4jJzVXJsWyn3phQcTvBWnjnIyTUYfI3N0BWaDlcRpx3hjHdjoTbJRIudCOkIMY9ZGzEYzYmHbRGvQ1495LDxyzwbND7sLXv9yH+dGNxYvqWRhoLRxI3Yi2SIkNA1g3Ncu1jlPKmpqju5+KG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789250756; c=relaxed/simple;
	bh=lQIhg60H3bu3SYlDaMceEA+s42Je7buGnpMKC43nVaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lv5JPUzBN254xguSdZMo6IjDQa026Aw+v60TfRaHVU5RBEv9skdULVq0wAkvcM2j4f0iODYywuQLHh6Jt2lkFnMRJeGpB/0v6x20im5fRx0oc5CB0lBWQoOr2DAW0ddZb0qmKMgAvCAGU+SLwWIid4/hQdTz0rNlU3N4RxfTuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=K0U9tgDA; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="K0U9tgDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1789250741;
	bh=bK3SHPytoMltHJRz+d8bS9oWm8DhW6FF6gHXnP39+cg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=K0U9tgDAaVmlDjuHAevWRzy0xAXVvsoonxv00GA7/jDg877c/O4uXuYl/215zxri+
	 OZoCrjrT/etGvx0IZvzu+CZJDZHyZAZJav4Nm2FHnhEcoIKuPFCBQ3Gowu1b9g1UMQ
	 oUUgja4+5ikeD/XYN/vsdOX1GH9UOxohbF5zUFHo=
X-QQ-mid: esmtpsz11t1789250735td833b7f5
X-QQ-Originating-IP: o3ewcjbyXFuaKthMVzT/fhqw/sdkORJwglzixg/JK58=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 13 Sep 2026 06:05:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10090393401742919414
From: Wentao Guan <guanwentao@uniontech.com>
To: pschneider1968@googlemail.com
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	gregkh@linuxfoundation.org,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.18 0000/1518] 6.18.52-rc1 review
Date: Sun, 13 Sep 2026 06:05:31 +0800
Message-Id: <20260912220531.858986-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ef6ea817-371a-4038-a73d-274fece32f4b@googlemail.com>
References: <ef6ea817-371a-4038-a73d-274fece32f4b@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NkL5+hAx9LE0qO0MiJ86XSSF6HVhoJUsj+E0MZtFRhEupTMavwPc5ZRi
	cb6tlLyrYuRkmH0DMsuOjV0JL0U7p1NYoG8X+BNFi8DPObUYaioBqAM+tTYgwa8Rzx9OgHD
	rihKzeassj/aSLFF9eBw7lJoUnPvxquSeBVOlDoPnsUx4ODAY2Rev42hv5gfAa3sxQDiwEf
	uIF3Pk9OtVxCG8sLgAnAcdVj1kpHb94MFIT03HKAK6i+hbfHXEVX5QupO4CEHwI//4/ECZ6
	qHhGAIa5JnsgAa/UP7acmjw01P85mEI0D7gwVNxPmiff3RRFsvDVXgcYHjBbJSTuCBU8Pcr
	8K1z/tY2YcCudmYqB1CkkSarrkE4HXZ56XHH2rHjoTN/VP/ScVosEL9vjjoSIYZo4shDe3a
	+4wzS+1CxoUeDvemZ/OI2JLAV0EmRUXGCtDcEgxPJGajRTkqZn37T9AJ+/q3rBqchD9gA9j
	l9fGycouXi/UPoYCQEPC44nLq7OC+ezw8icuoqIErBqqQRyVLYgNp/oeCbkHdkOElitBuNm
	M8Pc89neLghKaRyuwZe8+qUiIUOVeN/GHkw1NkOiE1uiwHQDmNahXSf149eeWrK77JqtaQc
	9NJL55IBTFDSqeyIdlmu9g5gI8ElwlXCOCxDHxjykR66YeMP2ajMuxT/jE4w8+9Z6VjRoyM
	t21pOYuTXHcGHph8xpVT/dX756frd6SVuyC7AAIVQVYmRCX7ACOcvPvA1IfB+Ril+QQYapQ
	/KZP4qPyCCnHXoo9S2Rf+GQtBldl/WC5nARPBlRTStBF1FPD9pg39GEbkN3GrlvX5CgBDMz
	R6FqXvn+ItwrfxbTBUYKnMpU2zqNBTLOgdDwxhbKJteKn4luwhby4pWIKTI4hX3KtDmPL/f
	U7myyjlKmjvEhlXiGYJLwuU6MZFP6oziKXg0hpyCweV6XiwehBx0zaHRE6l4TaJu2KSfzBJ
	8t8LNiSxvYw3/22rmNlZ23FPi5ZdAy6H404jdZu2OXSBrJu2B6KDOirPjP8rHoRbCHdTqGp
	d3BOhe38yHfVXwU5f/JiNFCxV7kF4aimDzJMcmw70px+3A60suVpYAo4YmrcNspMzpTnF7V
	g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Hi,

> Am 12.09.2026 um 08:36 schrieb Greg Kroah-Hartman:
> > This is the start of the stable review cycle for the 6.18.52 release.
> > There are 1518 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Builds, boots and seems to works on my 2-socket Ivy Bridge Xeon E5-2697v2 server.
> However, I do see the same strange dmesg warnings that I see in 6.12.110-rc1:
> 
> [    2.397237] Driver 'sr' needs updating - please use bus_type methods
> ...
> [   84.031323] Driver 'ses' needs updating - please use bus_type methods
>
> And again, these warning are new in this rc, they did not appear in 6.18.51.

Thanks for your report, i see the warning is related to the commit series:
("scsi: core: sysfs: Make use of bus callbacks")
... As it message describe ...
    .probe(), .remove() and .shutdown() to eventually remove these. Until
    all SCSI drivers are converted, this results in a runtime warning about
    the drivers needing an update because there is a bus probe function and
    a driver probe function. The in-tree drivers are fixed by the following
    commits.
...

Best Regards
Wentao Guan

