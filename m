Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F587375AB1
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379240; cv=none; b=jA+RR63YDtBZg8oqCU8sXwP0jV7tmbP20VKzzCZcHFOIwudtQaIPjvh5dUwf+SucA/i2830Ss7ZSLmdzPVOoN706gAGgxpykRqdBuh+FH4Y8NxLq/4t6iOqMeE8TjWzDAjKYQeHECSjDGS1qJSWjWM5CgcyVvmw8T99p2fQlDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379240; c=relaxed/simple;
	bh=QDGPUWOqDLT+tWvtADBzv5pk3CSy/WH3jH+6pLYi8e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urGgfd+WBK+i/XZpPP0OSzFks2+7Zje2u/RzHQN2gqnoZT4ja11xHKz7Vs2xgQxs26xlgXJaRysfxrpASM8lPOxuebyG9DaP+yVkrPMnfh9NJVtUsvdkQUMx44NwXDyvL16XgmKwQLbVouCZtpSD2YASCjTC9euMPby8yHt/rPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4oc2U4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4oc2U4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC241F00A3E;
	Thu, 30 Jul 2026 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379238;
	bh=IOOQL5rMwA+GobDxZgieGvD6zX+a21qbiT/oeSzsTzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4oc2U4eBp+2hR0SGb3KT1ZFgsXryfgzMyw0R7gYp/pZ66qA1954hw3nyBhtJYGll
	 uAnRke5359RBd24NuslFP5hHCI9uN6fZ8ZVcsVBZJG5cmG7Ug2J+s91MVzD966H0Mm
	 uQsFrIhps2nyxvPLDfUyn+vUX272QZ3yZjy3Wx9nwdFEw2bu6nSM6Pjs5lFCtLQaGi
	 JfhNt+7dLpEHWdlv2cNFUSeZaGOGIq4NmvX3NWwR3yC0BLSEkfIy/UbjP3kDC2hMXk
	 AmKVCPAdnl2ZVeaehN9VaEEbf2vBrcU3vILApi0qkRwjG6WzQraGkz/gDTyC9MJZdY
	 z/ThlWabJPUYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jia Yao <jia.yao@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH 6.18.y] drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR
Date: Wed, 29 Jul 2026 22:40:04 -0400
Message-ID: <20260729223316.stable-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729143759.152317-1-jia.yao@intel.com>
References: <20260729143759.152317-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR

Queued for 6.18, thanks. Agreed that 7.1 already has the same check from
the earlier drm-xe-fixes copy, so nothing to do there.

-- 
Thanks,
Sasha
