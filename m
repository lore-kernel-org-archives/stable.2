Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462122;
	b=oZ7ml4TQFo76fR13jLWrf7rEBV4eck/l5X0XP9TSqtztmho0xCUnpLaEPkqxGksS3Tbx
	 VL23Nlhy/iLKgX0rfCVtlRn1jDXSWMZm7ygq7nYCnEQEYH+QINQa0NspxJfS+9UKldAAm
	 6wXdC33JCWEDsZ5K67sMuRhAVqurLwz7UL6U3WPx92L4QejtE7+h+nf4pNOPm4Q5hsgmc
	 39Eogsib8gX7xwxPKtBP7/05O2bNgBTj5+IqXAb8RZt7BIK7cgtKzy94SPLDnIraUsUWS
	 yD1IIiGt5m7nAShi2mdmBcHAydjH/h9WtHyV1V9QX/F4fxQSNz2wR9T9ol3u9Q1/cNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462122;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=NXY+q9Ti+/mmY5tIeLxmwKBspdSM1HbHB0dQsHfLd0o=;
	b=Q1vAsMOePYEjPpYVchnvpe5byBsqkZhAXWscrvyAAi5cgrd2glvbBK8zi419oyTe6AZP
	 Iedcu73UsIbHd02ikt1xfRaEAkWblvdxCuCQ7Pf4mh7LioOuBhFiBq1S3dNonzxM2EQp8
	 yv5/jH/emr+Si3w7+Ed0CbjALllItotFuCAYZGTNVxFtIPThckxWoHenIwjii2ZddMBKy
	 PFKWgyTQHFB4sWfloZoS5HEgmXfTpkcI1L3qpJ5rJ8YJ+aTgOcS3+aRqHPNDdpRjqCDSY
	 F+LJfHr6AnmrOeuxz6goF9B/Ezjcmcn1L8CNLito/qCzcmfEI+7iXHYmvSMgetz7kaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QvKm9dq4;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CEF606A319;
	Tue, 20 Oct 2026 02:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CEF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QvKm9dq4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NX
	Y+q9Ti+/mmY5tIeLxmwKBspdSM1HbHB0dQsHfLd0o=; b=QvKm9dq4gQwTMMPMxv
	OB4HHBUAQRb4mbKWZivNxBudF7mF6WH0K1jFS7B6eisAnJNzPGlPdORH7pip6xbH
	0fFBSZ00HuJm874aFqBk4abe3L1I0K7JnahhRPUniLcPPM+Ol/IAn9UdkKaKKMhK
	90Mjdx3zMFH+fdzDfui9sQRWE=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n_oVzdZq+DKuBQ--.57043S2;
	Tue, 20 Oct 2026 10:08:21 +0800 (CST)
From: shaos <shawnq1@163.com>
To: 4ncienth@gmail.com
Cc: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] timekeeping: Require permission to set auxiliary clocks
Date: Tue, 20 Oct 2026 02:08:21 +0000
Message-Id: <20261020020821.1400277-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019080324.4147815-1-4ncienth@gmail.com>
References: <20261019080324.4147815-1-4ncienth@gmail.com>
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
X-CM-TRANSID:_____wD3n_oVzdZq+DKuBQ--.57043S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF18Cw1rWFW3trWUuFW8Xrb_yoW3WFb_Xa
	s7WF9rKw1ktFZ3C3Z5GFW0g3yrG3W8GF15AFyrZ3y3KryxKr48CFWDZr4qk3W5Ja9I9F9I
	vF48X3WUGr1rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbxwIPUUUUU==
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8hbI1mrWzRbK-wAA3o

I tested this patch on x86_64 using QEMU TCG, with the reproduction
configuration and PoC from my report. The patch applied cleanly to
c03c1a14507dfaf8b856c2608f9ac216021fc222, and the kernel built and
booted successfully.

With the patch applied, an unprivileged process (uid 65534, with
CapEff=0) receives EPERM when calling clock_settime(CLOCK_AUX0) after
the clock has been enabled. An additional privileged control call
successfully set CLOCK_AUX0. The CLOCK_REALTIME settime and
CLOCK_AUX0 adjtime controls returned EPERM as expected.

For completeness, setting the disabled CLOCK_AUX1 as an unprivileged
caller also returned EPERM; the permission check runs before the
enabled-clock check.

Tested-by: shaos <shawnq1@163.com>

