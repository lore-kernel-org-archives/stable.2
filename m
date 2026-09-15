Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3C3CCFAF;
	Tue, 15 Sep 2026 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437821; cv=none; b=fZJyjNdImnufBSQOlFsJd99+Dq2YLeWyqSuASbazD3ROJ33tGEJJTwhKr6HMl9XFEJHK4fwOFgjhFhZi3S9rDru1Y9+QzWD0XAAqX/hrO6lbfh1zmroOiy/HFlZf3e5KtZgMMcfGhYLniGtNai4uP9PvXc/fEQK79PSKCd+EsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437821; c=relaxed/simple;
	bh=Vqp0zBHD2NMJ9c1GV25gWCLyZ8eA3MTFUIiwKFgM4ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzttt2xrDOlDMYmnbnwnUrMBL3dGZJjs9uc1R5sExrSW5gLgKbeeE3JUcI+0pUPeEiS2mDZkQZFAT76G3q+FL2XijbBPky8fu6eO+EEirJTcL51X+xE1XHzojF9dn4pR8KChOlHng1kgTh3DMzMcOodsk3tsVcZ2whz/av63c4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TF+Ete7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TF+Ete7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAEB1F000FF;
	Tue, 15 Sep 2026 02:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437820;
	bh=mrHWytu78dJbZb5mW3FsyVkJxRa6zDGIfcHBrfWiJZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TF+Ete7pwnQc3OH9X8zvjivV/AzHkcP0F3l10mL66641bUL1GUmHTPLr73UeQbOcU
	 89wzHqOANqZZ5Nu/NPRS0BLT/jT2scYC4+zD3MiY+96OeNNTGzUnzgtaggw5F2BafO
	 fMFPk2FoVqJF1utSEfXOjfkGiXX9x+UyF5nb7riKKfcKz8DNn3AEyC9w25YwnH8Z97
	 AV4oDcpC6uaRoankzxKpHh9qvuJyoWiCxXjsTTMurajNHogbRHyyw5ABH7TD2eCjmK
	 sSDN0LYoYLOCgUK6Yg3X22TOxKQ2qGEzeQkR0xYu4NDxV/SYj7o4Fpb/9DIU4BFDq1
	 DuzzImZVQJWOQ==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	jgg@nvidia.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 7.2.y] iommu/arm-smmu-v3: Disable implementations during devm teardown
Date: Mon, 14 Sep 2026 22:03:17 -0400
Message-ID: <daily-reply-0001-re-arm-smmu-v3-devm-teardown-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aqR/n+VtlgpjJrAV@nvidia.com>
References: <aqR/n+VtlgpjJrAV@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Patch itself looks good to me for v7.2 stable and v6.8 longterm.

Queued for 6.18, thanks.

> But v6.12 longterm might need some extra fix, Sasha?

It does, but a different one. 6.12 has the devm teardown conversion and never
got 9ff145a25c5c ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on
teardown") at all, so what it is missing is that commit rather than this
ordering fixup. It does not apply to 6.12 as-is either, because the
tegra241_cmdqv_destroy_vintf_user() hunk has no counterpart there.

Could one of you send an adapted 6.12.y version with that hunk dropped?

-- 
Thanks,
Sasha
