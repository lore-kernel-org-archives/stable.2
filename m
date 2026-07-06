Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E442BEC5F;
	Mon,  6 Jul 2026 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346913; cv=none; b=Yir4cy1M+h3zRKbPqwCFCaoczy6NfkIYi/8phn73jtvTVH/MgIL6uTXA4qjiKDUkXMu9kE4W02HuTkJNG4VL1T9R6jgw14gsB4Rf/wrVie/k/lkifCJMmRFe0KWpZWfSZVjBTmNY/zIktefsZglFTOGcSipiID9fl86IMz1urA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346913; c=relaxed/simple;
	bh=omFLfqHUMtKGYUCSITPWHFqJ+Ge4dFOsW3TBIjU3gVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyPY5TcLtlr3LtMIeFW0mvXOfsJCUrP6wsFgDYoeUb1VpAYKmvDEd/yfxZ4xZszKB+ZbdRNQ2dMj6PL6dneOGkNAZYmzuJ/UwalIP+GUEA0U+XQwGG8R9nBjRR1Zr8LuBUFEFVQKt1RVueigmJBlprIJvIICwe1zt0RbMx419Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHOQOImP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHOQOImP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E831B1F00A3D;
	Mon,  6 Jul 2026 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346911;
	bh=q8+MGqf6q/NjxeYoH9XtM00SPb6CU+uTf/7HC064t/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHOQOImPKLRO/2IJTruEda7JV+JW5MVwANnHnnu3CJwAat6r//4ICi+MHJ/iCOM7h
	 R3uw70Y6fVOpmJG6bS3J0yJiped6pg+2BMmi4wruVsWZT0/KczzabLwn1wonJ9bF3c
	 rx355/27cmiFEV1e4YXsp1CwaGNFGWjKyYO/gG3EJym4E92BxadFQ+ozNyNbdi/EDd
	 G2XhWs5c2FnyRN1gWSzpuh/iDmoIWfzuTW42o8zBtNQTWxWbGZmChhRUhvpwdJ7m2b
	 i2ECLse1VPUCTDAkamN/6LKKwQxgL3/MMccPKplzDjrlfoLnl2CltVvKcfAH66wpT8
	 +s5eISYqi0TiQ==
From: Sasha Levin <sashal@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 5.15.y] wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work
Date: Mon,  6 Jul 2026 10:08:22 -0400
Message-ID: <20260706135124.draft-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706102512.1429947-1-arend.vanspriel@broadcom.com>
References: <20260706102512.1429947-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The upstream fix uses timer_shutdown_sync() which prevents the timer from
> being re-armed after it returns. del_timer_sync() does not have this
> guarantee.
>
> brcmf_btcoex_handler() has three mod_timer() calls - two in
> BRCMF_BT_DHCP_START and one in BRCMF_BT_DHCP_OPPR_WIN - none of which are
> guarded by timer_on. A work item running between del_timer_sync() and
> cancel_work_sync() can re-arm the timer, leaving it pending when kfree() is
> called.

Agreed on the analysis. One thing to note: this backport already
shipped in v5.15.210, and 6.1.y shipped the same weakened
del_timer_sync() variant in v6.1.167, so this needs follow-up patches
rather than a v2 of the original.

> If the mod_timer() calls were made conditional on timer_on, setting
> timer_on = false before del_timer_sync() would be sufficient. That would be
> my preferred fix. Alternatively a second del_timer_sync() after
> cancel_work_sync() would also work.
>
> Also the commit message still mentions timer_shutdown_sync() rather than
> del_timer_sync().

There's a simpler option: timer_shutdown_sync() is actually available
in both 5.15.y and 6.1.y, so the del_timer_sync() substitution was
never necessary in the first place. A one-line follow-up converting
del_timer_sync() to timer_shutdown_sync() makes brcmf_btcoex_detach()
match the upstream post-image exactly, closes the re-arm window you
describe, and avoids a stable-only divergence guarding the mod_timer()
calls.

Robert, could you send follow-up patches for 5.15.y and 6.1.y doing
that conversion?

-- 
Thanks,
Sasha
