Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18738B122
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043837; cv=none; b=Kpg17h7oXh/lA91WiDstNeloscLNiZdI1yeCgqcCbiZxAimR+1kAe1s/L5n7FR2P3vA4kBZNDC0oNK2/oQ/VqpDwK6/dz7WwD+X88r7X4R/QUna+42nRvAtSUsXzcE6EJLiKEHiYSOeqNvsMkPGrs2lQdk27Hk6Rsy4H66jKAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043837; c=relaxed/simple;
	bh=v8Gh5JBcR4/gtUF80WLQapdaKlB0bE928cRz6R8div0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bufYnda/sWF2PXCJAvcr/4joEgMtbB3S+Ox3T/zT5i7zXfW9ZyN1gFPqeL019369uFBrU0p/LoZS8GFHX9YzOOalq/p+GYbFh2B0CyL/wvPA3V33v7DeM7VzA7tu52Aqi9mCe0LGkNMglEGGL5FwXEDEoV4DECMQl1HMHiSE+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgNgW99G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgNgW99G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F741F00899;
	Tue, 22 Sep 2026 02:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043833;
	bh=UJv56dNTQj4eKixoW9NNq6TiZJ0Fy7fcYP6UcsVaJCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PgNgW99GqCpvQbrn8cr9eXjChl+2adyr77xUEbxTHO6MRPgjp4pDktQg35rgFC9Vx
	 Il8s93wh2jpaQCv5HqzfqoN912FfLvSyYt7eJE/fth/OxLxIZaNd9jh1+D7AhbxpYf
	 /TP79nCTVHUn0zXhcDUJr9e/Xygll8JhGQLnodAhDN6or25/pwAzQ7tyUBRV6eVZep
	 muoV3Xw/PzwfBtjQCtXBnL6oiIfN+D68EUVMvF85667N2ySC9Mb87gg7Zq5zRABgSA
	 Ws7jzOAdBhCcwk2KVfk52572LuWReUWeXTCCqu3Pgc/Bq8iqUwUDCHid9IxNYYb9YB
	 97vVK6q03JNAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 5.15.y 0/2] Porting two fixes for the cpsw Ethernet driver to the v5.15.y stable kernel
Date: Mon, 21 Sep 2026 22:23:42 -0400
Message-ID: <2026-09-21-daily-reply-0005-re-cpsw-rx-mode-work-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920-v5-15-cpsw-v1-0-208e80dc0f51@gmail.com>
References: <20260920-v5-15-cpsw-v1-0-208e80dc0f51@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> As requested by Sasha, both commits are now being ported together to the v6.12,
> v6.6, and v5.15 stable kernels.

I am holding the 5.15 version. The Fixes: target 1767bb2d47b7 ("ipv6: mcast:
Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.") is absent from
5.15, so the WARN these two commits exist to silence cannot fire there.  Moving
rx-mode programming into a work item behind a !netif_running() gate is a real
behavioural change on a tree that gets nothing back for it.

6.1 is in the same position and also needs nothing: neither cpsw commit is
present there, so there is no half backport to repair.

6.12 and 6.6 are queued. 6.6 is in because it is the prerequisite for the ipv6
mcast RTNL set I am holding for that tree, which does give 6.6 something back.

Sorry for asking you to produce the 5.15 version before I had worked that
out.

-- 
Thanks,
Sasha
