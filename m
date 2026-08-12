Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0343345D19D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552017; cv=none; b=WHO9YUZl1TuYbqMBVagNcVCRsOQUtOMHr1Z6BJlQT2TODhDxf/oFNVXGVV5hSocZuO6gB0pKiZXh/pZhWxo/uP4G5FkLZGnX/1rPvT/XKjnJQgegfvSsM1aEUbYbRpMFX6nRs0+fcajqI02D4FrU5YuECmJUHjyExeg7Ba5bYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552017; c=relaxed/simple;
	bh=uJkodnuk87w4njpgv+rcb+OmQbJ266xjQ1DsGcUDN2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fULBBRdUngvrD4OF9XRPCtFiPXNenZlQqecWfSJsGvD9TlAZSSBSucVPyWLqtniBxx6+SwpJaInfkXr/P2mSZvCgu4GeWpPZ6dMjVfZH4syHYImcq5aa0o91NfuPeH5cAnor8uD47GdiHOw7WLqaiYWPwkdNCFdcoIWxoe9XZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFj41kwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFj41kwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F7E1F000E9;
	Wed, 12 Aug 2026 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552013;
	bh=fNi8l12e9P6XYo2cxhnh1nlmuEpwxyELzPkLw6Sx4Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFj41kwtt5+IZf5yvOqdyfIadA+rIg2Sd4AXSv8Akp+tcFhlSs8/CA+RKzpW/KPmh
	 uWtEydHy/cVz8fvjS+siE33eFhSFPpKSDJ7Z0BVi+Ozg3aWO5Twp3wsFJgRUzRlkVb
	 heMV7HbyE5XOdBP0+sUsRBdwAkHIBCO3ylOdIqAlKRFdX96FWfbKuJwKdwBzntU9XI
	 CQrf7ViMYRcaPh5nzv5Y6Zg3z0b6ktrYXMw8mAGgxP4920okI2yoEnuAUq7bOD7M5k
	 GwS0KHYqo1ScRg3wIbQNLhlFFbEePsXVpzZNlqgMajmdRsSr49BK5Tuxb1XDzayNSu
	 Ks/Efy3kNb4BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v2 stable 6.12 0/3] s390 KVM PCI backports for 6.12
Date: Wed, 12 Aug 2026 12:26:40 -0400
Message-ID: <20260812161500.10003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dd24992f-c226-487a-8587-bc824c1a4707@linux.ibm.com>
References: <dd24992f-c226-487a-8587-bc824c1a4707@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 11, 2026 at 11:59:44AM -0700, Farhan Ali wrote:
>> While you are respinning: 0cfe660559e8 ("KVM: s390: pci: Fix aisb
>> calculation") is missing from 6.18, 6.12, 6.6 and 6.1 - only 7.1 has it.
>
> Yeah, I can send that as part of the re-spin. Will send out updates for
> all the relevant backports.

Thanks. Please include a 6.18 patch for it too - nothing in flight covers 6.18,
and if the respin lands 0cfe660559e8 ("KVM: s390: pci: Fix aisb calculation")
on 6.12/6.6/6.1 while 6.18 stays without it, an older tree ships a fix a newer
one is missing.

-- 
Thanks,
Sasha
