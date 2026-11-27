Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798939;
	b=yIJg2tE9NUxikkTPKrmqoMUmoOjd0Q2/hdJfoI467ZorHIip3atJaOx3u4IEPm7MkmiC
	 K2nxdNFQtZ0HjgcLqQLQ58qwr69gtgnAl7sfF/IM7Af4uFk+s3f2kf+GRNOm67zoluJ6O
	 MVHrFkWJBg2/fwYtwcYmEPRgW5A5GPxrlVyQUNU/u+/szTjmwajElousm9+D7vtg6cxDP
	 31Jxk0DcewQAEtX+QyJfDVMSsKv83D1LjNM8lsyU2mhPldwP1Sg2kLSkySpm1VTSdEkpI
	 38NLoSo/qekuYNPPI5IRcosjwNtspfHlMm4uV58lxESvCDSjS/kndDsnihfIzmfdxLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798939;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dWddCE8isoxERk64d/YFSqDchEPMdEv18H3tDbYNnGA=;
	b=MMTqC2LEsnR1UALiLsR/qWFu6I2o+bRfBU/IA1BBDqGPNoz27zhSWCqLoUbigET4ZUeA
	 Bjr2abAdaTXTe3FrDRdEMtkMjbpcZ5ipPz17Nh/z099bE1G//EvtD2FEtVvVtpam58Qp8
	 6hNm4rUph3bi7aQXcJpPlhQJJT17mT7UgUUojZrywhL6pyb2DN06X2lpsDyTn9m8fsuoP
	 L2JO5nqYEpfveasRtZ1iaMqkbjJHzH+5X6DA+JDOyTAk+r5wbohpZItE3HqYIvjSt7qWe
	 v/qFbEIxGInzQuz346LCcg0+JAouQa7A6eieDq6U7GHP2LrVQEhVnNOaXWPsrKit4Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2FjI8nd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8B606A324
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2FjI8nd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA5C1F0089B;
	Fri, 27 Nov 2026 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798939;
	bh=dWddCE8isoxERk64d/YFSqDchEPMdEv18H3tDbYNnGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2FjI8ndPnHIxjfkNBmVuCkDW6YmOrAbXAsZgcaNGSQY/Ezx4WtFpj2b7zSPj86q5
	 Kdo22WxhnmdiyZP7oKRa6ZRT49f384l2f/41V2gcfCy1NU8/09jwyBDZvW5/AIkwuh
	 I4UzdbYmnzL32MONpZdFFZuNROOK5pE78P9RLNJnCR9geFwsfBb8oVFEB/g/W5VtV/
	 VoF0u5TIDS6HsG02bQjG9UgjBTfy1R6Hn7lX0K9U3nWRgxDyhLyrSAxObsWpIgkL8B
	 H6AAQxIn8N0EqNH4HBShxEuXCHxOKL1YNvmQPG7FDEke1oqZ70Y1iMik110IbSyWrL
	 CTSq76pFLgkvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH 6.12.y] iio: imu: inv_mpu6050: fix swapped accel and gyro startup times
Date: Fri, 27 Nov 2026 12:01:15 -0500
Message-ID: <2026-11-26-1-daily-reply-0027@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125151747.343007-1-kapoorarnav43@gmail.com>
References: <20261125151747.343007-1-kapoorarnav43@gmail.com>
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

> struct inv_mpu6050_hw declares startup_time as { accel, gyro }, but
> every entry of hw_info[] initializes it positionally as
> { *_GYRO_STARTUP_TIME, *_ACCEL_STARTUP_TIME }, so the two values are
> swapped for all chips.

Queued for 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
