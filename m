Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01738839D;
	Tue,  2 Jun 2026 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424501; cv=none; b=N1R74AzYwG/FvB9dciNSxApQg50nEm+lEYqKqPTnCTgjyr/PI69MEgVJGJGXpQR3V4g5hX2CC573vEmNl1e0Zeeeu/xc9tu2DwvhvRe7EZFoMLmrKcfBGr+PorUDFIhdt8PcNriAr/Vz3o8cQGq1GeoYzaZW6/qpGysmVZL3o/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424501; c=relaxed/simple;
	bh=VX8/5J1UHVi6WOFIgYIpOxAZUnFMdQy0KtAPIzqi6VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSytDIV2n2wz60lA5/KOodNO+UEBDr89EYIY5TjXMXuU6VAtBpZJLws0/30E3nvH5h4BDEszpMyR2h+eEnSuey368ajg3kkY4pr0iOYqnYiJK2rex8bByQDvWSzvNTHqypdPs8xT5DWoRzaJUZ3t6kNJhvIfCH5YTTRBqcxtIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbJlZNZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbJlZNZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB1D1F00893;
	Tue,  2 Jun 2026 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424498;
	bh=BRXmaFtHlGtmlACxC5RELFhg8zad2ITbAOk9CjyKfFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbJlZNZ+lDckIQHwqLqi7pwz3DgXXMoniCMFQMYrqutjoc8Um5Q9oG4p8QhWTL41a
	 /Z9PpXTzCEh2emlG8ENEFmtD5bInXIzumSvFwDHnx0m0ktbfM8jhSfCiCyxlt7rIuD
	 bq0Wdcvdk57ruf6L4AhaqAnvx9Y9a0KlwImQSbGhSE3AYL/hLP+qldzTnOz0asE8GO
	 U7d5J/rQMlBaaIBgowckw6nNSrtN+cZMa4x3BNxfKW3q9bOQXTbH9Fmin+rxN0IBff
	 APiCEXmGor1Z0PAEhAO6s9qgCkXOrLZi+MPlrh3+Jxrs+GmBxRaz/arPHwWU2s/1hj
	 kcJJvyoriEZvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Prathamesh Shete <pshete@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Petlozu Pravareshwar <petlozup@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Meng Li <Meng.Li@windriver.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Robert Garcia <rob_garcia@163.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] soc/tegra: pmc: Fix unsafe generic_handle_irq() call
Date: Tue,  2 Jun 2026 14:21:18 -0400
Message-ID: <20260602180500.tegra-pmc-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602025812.3535026-1-rob_garcia@163.com>
References: <20260602025812.3535026-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 02, 2026 at 10:58:12AM +0800, Robert Garcia wrote:
> [PATCH 6.6.y] soc/tegra: pmc: Fix unsafe generic_handle_irq() call

Thanks, but this doesn't apply to 6.6.y.

-- 
Thanks,
Sasha
