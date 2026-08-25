Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84B3FF8AD;
	Tue, 25 Aug 2026 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658592; cv=none; b=OCZBBsoyqw7wNJz/wMH72g99v+2gKCdwbKv167aydY1dkbqDu9qZG2245T35McFfbfq36KLIOdhCDgShkBuMzTBwEuTN6I3uHmE2YE7b5XntaDxOMQcHqHW05pC3fD7COI4s1sv1vdcoN9MgtR76Yd5xUbmnBuCoWg7LC5Twc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658592; c=relaxed/simple;
	bh=K9HLkIPmB9mfoubfIXzGGSCkeF45Tq1N7AaeMxZv2MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm/hbAbEX3UpNSBZUvq3xo2/VcA7RzD/mZRExmY8U4k2DMRLo+SC/CMDyYHnrNWmt/QDFN128VA8i5b6WMNMFQITLcaCZlluQo3wTyDwwX1IdGtSsv+KXIejCxfwif7NjfM2j5KRAXqRDywQOCiBGxJUXYD5N5/Rvy5hPjGd+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuvBgON4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuvBgON4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26611F000E9;
	Tue, 25 Aug 2026 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658590;
	bh=cPViORCFrxsxEx74yJ3PYYV50HrV9rFpBBd8ks58f/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EuvBgON4gsbPw6cZPX8Q1Nw0R9iD4fuVsTuPvYR7lW4CKeNW39xECMmm8Anf1ta9e
	 Wo4ujbzFMsQjseuzVraShzS9j4EqWTOG2pXKg9dJYYmXyHbAc7Hn9knNqXJQO62hod
	 Mnq3Yw1BwsBsevMav2CF6yoh57au+B1ID3w7USmj/0NjXH6SdN5ahyTmIspJmVkyCP
	 Awwf8pa0f0geY4lAxBFClpPiCZ0aBrepwvJf82NdxouPHUTxVbIte49XozMvzeqU8S
	 +1fjKIVhwlje3SpHdFaULXuC3wVFQSJJph0FrlKZED90FyUgllkDUauPHAMsY4aPJr
	 sXPMSNSaLz8ZQ==
From: Sasha Levin <sashal@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	stable@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: Re: [PATCH] Revert "pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power domains for Eliza"
Date: Tue, 25 Aug 2026 07:49:31 -0400
Message-ID: <202608250010.26978953f092a26a@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPx+jO_WgxJSyW_ZPYLrYaQMJMv6w918CQupeHoPSr7JPxqa8Q@mail.gmail.com>
References: <CAPx+jO_WgxJSyW_ZPYLrYaQMJMv6w918CQupeHoPSr7JPxqa8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 21, 2026 at 02:51:24PM +0200, Ulf Hansson wrote:
> Applied for fixes and by adding a stable tag, thanks!

Thanks - then there is nothing for us to do ahead of time.

b48a0a0a76cc ("pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power
domains for Eliza") only reached 7.1.y (6.18 and older have no
eliza_rpmhpds table at all), and the revert will flow into 7.1.y
automatically once it lands in Linus' tree with the stable tag. No
stable-only revert needed.

-- 
Thanks,
Sasha
