Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184484;
	b=zGkLLM11TfH2Q+aplFge8n054XJ9iJmDCt3Iq5bUGti3o0/iSRa9bG1oLUzm5ax6Ojp4
	 zOrI3sf/OkV23e14wwKvEd9VdkBcbnFBdhAQsUMiBSzhWOaUQgYyODAw1QzM0B0crNpT+
	 U8a8OJGh8AGnHxZ/g6Rljf7pCdN5sdE26INfTyvnPqqtmKpYGlPBPlSlaECTvF4d/xqKm
	 T/2aeQ5VH7GPkkB7zaR2HVdg6rwRJnGLQ22n8WtoHe4/ZZYvjksw8SBvU6qniQt+ah1ZQ
	 9TOPKKBWJHibZiP+3udDb1Wts2rzE8xb3sOhEUekbflYdaQthTHzb7nPgfU/qNAxEHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184484;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M71yMEtictCMah271Ix4egGmIIgSaFbSjft6U/0gZCo=;
	b=wWj0Xadx/YvTDEzwxffeMRfbf/rEPneGg+Fos7yYdEXqWUuTS201ImYtXi5G2jN65t5u
	 +bH+nIGGsspqIpBATR9MK7tcsyMAnJFhuE4Gl55o79E+MErDsFbpHReTXmU+bVqGRJaB+
	 wAXyJzgl0F+us9v0IFPnKXA3dAjgivT83a9RlkSm+JmdMV+alSwC/Uyovf7EKcP6EpVzC
	 A3575QfouNVKYZIZFlBV+Os21DBc2Sf7/aAi1xeMFYmtcm+xplGaGYhAkgO5KjUzN9UJu
	 ipA3uTcEKDlJjAiMO5Kwj6RQqOpSta9T0V+RmTzR/S9GADDC5b6ryjCC6xhbeQS1zCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AcpFwkEM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59141606D81B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AcpFwkEM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195961F008A3;
	Mon,  9 Nov 2026 00:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184483;
	bh=M71yMEtictCMah271Ix4egGmIIgSaFbSjft6U/0gZCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AcpFwkEMF1jYPBgbkRl9GcJW6OwUZYZGlhApyi2Td08S25QfquiNKk5Jwhe03pRaQ
	 nCYSs4N6MbNENc1vJeZxkzs3QGGGvJyTCmcZdyHFaixGxpxRv5a+5IfpJyqZd3tk9B
	 J8hjd4myhp5AyB0DPBKIfVqLEu+VlzNgQ7tNABNlvb8H0AO0gJ6IwCBo5USGeboEV6
	 HgtZmJYJ13/mtF9lQ0iMNT7kpRPb2/2vGpnESotX5T+j5bLFNaxtgOCSjQt4bRnNN1
	 XjotcQHSdZS4iRF58+xwJs74jBbmZbdNNt1WZxC4mjzO7Z0RdQEwzkkA/ujk+dGkAS
	 A6oW28oaBI9pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linkinjeon@kernel.org,
	cenzhang@linux.microsoft.com,
	stfrench@microsoft.com,
	gregkh@linuxfoundation.org,
	Mohammed omran <sanhokh30@gmail.com>
Subject: Re: [PATCH request for v5.15.y] ksmbd tree connection UAF fix missing (CVE-2026-89788, CVSS 9.8)
Date: Sun,  8 Nov 2026 19:34:29 -0500
Message-ID: <2026-11-08-1-daily-reply-0001-ksmbd-5-15-uaf@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAGwSD7R7MPL6ANw71gAh4U7YpWhfRZQyaDrSibxfvy5CnZ-SiQ@mail.gmail.com>
References: <CAGwSD7R7MPL6ANw71gAh4U7YpWhfRZQyaDrSibxfvy5CnZ-SiQ@mail.gmail.com>
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

> the ksmbd tree-connection use-after-free fix landed upstream in
> September 2026 and was backported to 6.1.191, 6.6.160, 6.12.114, 7.2.6
> and 7.3, but did not reach 5.15.y (5.15.225, the latest release):

Thanks for the report. 6.18.y was missing the fix as well, and it is now
queued there.

-- 
Thanks,
Sasha
