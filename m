Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798937;
	b=M21wUNPz4m2RJOsFw4c5Gdu0qj64KYffN3e2uBirfXGfG5kSc3uLYr5tBepblRJzfN7q
	 Iu3Ob7nPoCqpEdaEOIu2eHIqEv3i7JaXsCjB0mP77/DQv3nOfONRjYRofYhNo+BxfPCkG
	 kQaqx+V3+RVhIt0M0tsD+yhbLCvosAqjvfBzdLyan1pqjrvRodU6An2G/2vJDFd8Y3DPq
	 /3l/kg2m0KthO/4QZOMINL/vnQW/LdNmDFK7DrkdQsFFlEx+buFQVeRGJ8bG+9n8u1pBy
	 JaM8Dqo34afj2NJzu9RssaWQ/5Oa5XB6b0OEuU8NxnDwWZ5kba8w+ldG+qxoK4OS/hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798937;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZwTP8BT54IUS+BF2n7egz5afrvvOLjskAPV+sHhSJ4A=;
	b=oyRUJK1HbI892oW0yDJ34bKlQ4jxsXETnf4g9AVvsCLouabkBKZ/Gtd7Zw1+HR62xogn
	 YpEIJ0ZAijkQrOFWpzTMau3LQWQPzfmehm5oW9/8VPx//2IU0DtXoZNq59kp8SwsP+W2r
	 aYwib86xfxmLzry8iSOImxufnxyQ7ABAHA4PfnvOaIBYDcZoNxrlpesSuOMDST26q1/M7
	 dSV+4u6dydMVN08N9AOdl25fif4ovlgxgikkgh2hNvv2n6VOWKWOMKKL6E9RZaFFmd2Gu
	 Gi7iNXOko62BBpKUTn/RZWB45UV9ph5O1zv5FRnlGTIxT7Rv7zjB4jb7M8i6e+5RsMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4AzAz0Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C4606A32C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4AzAz0Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1FF1F00919;
	Fri, 27 Nov 2026 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798936;
	bh=ZwTP8BT54IUS+BF2n7egz5afrvvOLjskAPV+sHhSJ4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4AzAz0QD0OSZQhnndeVps0xcLuQUbQqZYuZBeZ/jx4G+fSrT1Kp/wAOOLMVPIvxa
	 G6metmdc/oEWg+AsIOmSfsoA3DD9HjJaYiiyVQULbfYJGix7zS3ESlz8MjVdAw5SCc
	 r/Q3tBS+mtZI1Hriw8O4IQ8w59zdtJKPWQf2lQ//UQEJTQGwb6cFwxtev3dTFJsQxo
	 GnNP7dRHuPTuWcRFbzQ1jk1zIlbGj0ysZNMNRn4AlIGCvstZ8l42b6gEb/IZKkRkgf
	 6gbefo9VwhGvgXi4Zo3ep1p+hMLfFh/2aAjLgZrg/eeik44fRwlD+h0wsn6oOWkQdK
	 0mTqst/tIsbow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH 6.12.y] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Fri, 27 Nov 2026 12:01:13 -0500
Message-ID: <2026-11-26-1-daily-reply-0025@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125151648.342825-1-kapoorarnav43@gmail.com>
References: <20261125151648.342825-1-kapoorarnav43@gmail.com>
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

> do_div() divides a 64-bit dividend by a 32-bit divisor: the divisor is
> stored in a uint32_t on all architectures. The driver passes 64-bit
> divisors to it in several places, so they are silently truncated:

Queued for 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
