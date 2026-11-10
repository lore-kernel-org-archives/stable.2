Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344397;
	b=EAdgCFyzj61CSPaER80oqho5xugKAdl9SZodhDQItjGswukJ6qzmqEf2yAL7q1lQsnva
	 f/Z0vtWruVhZplW2SMhYEyuE3jmSNIwzyIa08gyksfTnN19ygYm+zv4q83NT02vMmn6aA
	 gMvk5ZVS4daxQOaCssTxX1I5N4DkIl2xOKmF/ONS+Lusfhv77eupb4nbzE8sGYdyD0ukC
	 W7k1VjL/T7gbHgIuHrDEBiaIxH1j4k21AlS3s5eXL8FuMDZdLq11a9AYd4yW4D6g1EK7R
	 yzXaJgrrGEyutVE3LiLyml1NHPfZ5bSHTvVqIBT6A54Wqpjx+AoDwAGGJnnAU7bqNgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344397;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IPB4mZQnoaznQP12xe0gnS734FPPoRMI5GhsOMc8seU=;
	b=Z7CWS00LRUl6xNj57SyMZiq3lHGtwQiLwXK7A8w7d6Hd2fwXD7eVSuuUw0afI1reXy4H
	 czYnVRguLUH5ACo732qbRNhbA6cV8alQubrjRJXtmh7VjioNV/qZcqQyrydAvqCcHruVe
	 cK+feAQVu2SN4mLOSQzts1Uso+zj0vLz5lk94wOVPwROZvSMQPIe61vjLF1icxXYPe1jr
	 ZWBiM63gEwkHpTSxtOLed24aVHOHLa4ZNcDNw7nMBvCK0EEYxkuJP/nybsCCrxWotPFNH
	 JgYdEtNy2NAgPVK0s0vBkw/Gbp3pDcePcgC5SIWiSU960qowuTrMicI349uwdx1ik8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTs77+3E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702A606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTs77+3E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E113C1F008A1;
	Tue, 10 Nov 2026 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344397;
	bh=IPB4mZQnoaznQP12xe0gnS734FPPoRMI5GhsOMc8seU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YTs77+3ES5YEhe+oBH47lXEqSLEsFXlaoSN5zAsHaYJkzuFkD8PobWN9RQ1teZTSr
	 EBAzz61ex+a+ScTp+H7z9ESp8+f4eq0DP3IKEGQvFmpxVyNniUaRjJfMS1NxEPYg7q
	 Oz0mNdj1ILDcqNefesbLBc0dDi1wWY510HtGNxFrw9l3lraFfo7uJRHo5viXkwThWq
	 004PSySz/8vauu062iZfI6Sr48zpOlNkhoShy1LHv8bo5NGVO9IrWjhb2QRDiPC99n
	 PU3/UmDh9KEloTlpjOnTwVgPEAlj/ByUxKOuCABZyYIIPkABuOQTvKHiNFDLvmgbEP
	 HJeEnRzIBeNZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	cassel@kernel.org,
	dlemoal@kernel.org,
	Zhao Gongyi <zhaogongyi@bytedance.com>
Subject: Re: [PATCH 5.10.y] ata: libata-scsi: reject data-in commands with a data-out buffer
Date: Tue, 10 Nov 2026 15:59:22 -0500
Message-ID: <2026-11-10-1-daily-reply-0026-libata-data-in@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110065405.45993-1-zhaogongyi@bytedance.com>
References: <20261110065405.45993-1-zhaogongyi@bytedance.com>
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

> ata: libata-scsi: reject data-in commands with a data-out buffer

Queued for 7.3, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
