Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2143C8EB;
	Thu,  4 Jun 2026 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531561; cv=none; b=WT4/0sEDrdtjVBA1lxwryHejGb6Dbbv73MdI/uxm32S1Ugau9n4DtxiLM/fXeqY4ryUgmZz2BuqiVFWM50j6HPHYzaiu68pQ1TCYXaOIZXTEgi/7UHNSerhJpBe3sHTvhZ7HbuauMWOfubnafduCo3Np8CKjecD5X2sEkbLQEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531561; c=relaxed/simple;
	bh=FOQ+g21fD38nz+kDpjuiZiHGQwoDcWHXvmJJb6q62WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYiy68lG0FmWSnVXgp88AzR9cMz6k67i4CoL4hR8kEQ50w2f+3UaVpEyrMeOhnyBDdV+C1Z5kyJZ508lWF1zi+URf84eIoDWCRaUWzolBeOnjHuI4iENzCLvxWe4BNln933/3MeVXh20AaN5A+Mu8S8YINTp8aGSqEuJdY1XUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQWHrAK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQWHrAK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B8C1F0089A;
	Thu,  4 Jun 2026 00:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531560;
	bh=GQXv4mn29c7uJ5o4xkASkf2rQcC8NTXHp5zWDTL4P8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQWHrAK7+a9lgawgYqgW8Syjq9PgJ1GHcnD2CLEqyJ6BP0vOUvkVYl4y1CWae2gLS
	 Q0BV68QGYP/Ln8L/yq9Z3Z1pjPk0lwtAP2rAGPFruVEFLOzapW4ekvj7LE44jENZZw
	 eWYMZ44GzF+UsPoTkwb5ACKNwoWN81cHyjVdOgOXPhZ7xeHGOdVVvhti6N2b0GfZIt
	 pHssbNEFlem32NE/bztxsQgiy9/Lj32imgf8yaKdWjpv1MvFdHWGiOHjSOMgSjFvbb
	 Hh5gbFuzJdO0F42A933iKnVsu5KP92OMEF6+unyxE60OfiNNkrjaCaNDHHxHbfkX7h
	 dciEgVB9YbAMQ==
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
Date: Wed,  3 Jun 2026 20:05:45 -0400
Message-ID: <20260603210831.item010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603080912.2022575-1-rob_garcia@163.com>
References: <20260603080912.2022575-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] soc/tegra: pmc: Fix unsafe generic_handle_irq() call
> (resend, regenerated against the actual 6.6 tree)

Queued for 6.6.y, thanks - the resend applies cleanly.

-- 
Thanks,
Sasha
