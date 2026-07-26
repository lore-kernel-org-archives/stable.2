Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4D38E5E9
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067507; cv=none; b=KybBrTNaZM/3KO80gGVLc+Ff16M2wxqH2lC5zcEF9ZFHqP9Y0srC5glel3kJynABsJRxaPq69A2HDYcHOaovzbQv9OVYGKyTv/ism+PeFKOat3gx0tPn55KtCFMSYZz+mMEEifoOm5lLQEEOcVsLjsWm+kuYxs1AoCyFHL9pVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067507; c=relaxed/simple;
	bh=jUlqVdAS4RAg758tPM+EVqKsR5WuyOwJXfExecdVS3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DM6v4mUyhuo53t9ex9c5nOGEEQaynODd9X84/oSmcSOI/4tORPbRjcM98pf52dXpF9SGy0/QiphAnJTx1olm+s8rg5ioL5c8CpB9oO2J5X0l5OPel9+au4JcEzZU5zQsh0HqzpPIbniOCKDm3vpE3uO6xloiXuXxnqApBQI4qcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqANl/A4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqANl/A4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29C71F00A3D;
	Sun, 26 Jul 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067506;
	bh=3Kpflck9u12WX+tQQv6Nxi/tvsumbGzNYidSC9+Jdqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqANl/A4AtBi+rUGnAGhUJGF+CG/brCI/nq8/1EcqGANQIZZR9gU8zKXNV4LGWFYq
	 7/ssAH+rcK09qEK4675v7hSDk/cpYzUJch9dkZaDaeaAYu7ljRau1J9tWqZVuBmrb4
	 FO1XRMgJ5jjVMG3Zsih5yiXSz6E19oS1zXtchoDffeqj+P+wJUNyXYkXA+L6NmgjUV
	 ucwlHKn2Db5V121RzKkncDVvDNKnUHcsWSgo57f0Q185W5ZiSezSWtVkxx/XXZivNz
	 cqwVmAulLOP/5fhhPlN5hzbU/xp0qDiepkPg2m4ZyQWNQ8xGvG71KTA7L1EkWF02xX
	 L4w1gnoipzt8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	thomas.petazzoni@bootlin.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Miguel Gazquez <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 6.12.y] iommu/vt-d: Fix oops due to out of scope access
Date: Sun, 26 Jul 2026 08:04:48 -0400
Message-ID: <20260725192000.stable-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723170133.2299823-1-miguel.gazquez@bootlin.com>
References: <20260723170133.2299823-1-miguel.gazquez@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit a6dea58d8625c06b9654c0555f101742481335c3 upstream.
>
> The global static blocked domain is a dummy domain without corresponding
> dmar_domain structure, accessing beyond iommu_domain structure triggers
> oops easily.

Thanks for the backport, but I don't think 6.12 needs this one. The oops
is not reachable on 6.12: the blocked domain has no .set_dev_pasid, there
is no PASID-level replace path, and the FLR-reset flow that reaches the
remove-dev-pasid code with a blocked domain landed after 6.12. So the
added early-return would just be dead code there. The fix is already in
7.1 and 6.18 where the path does exist, so I'll drop this for 6.12.

-- 
Thanks,
Sasha
