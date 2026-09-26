Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843033F5BE
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436438; cv=none; b=UeVbwURNzY3ZTbLTNBHc5qWnyeSksdsnlTY/2MoV2UwXcGm7HZvNCQUP+vTUUImrGLcklMal4IkyGfeU0mBbbX9EM7isApmfA+K3luuswGoZeaLMFMq3pzvcvaIrpE5TpO170HwfJKBH7VnbMVASXXlV/RkPiReslPhCpD6Cz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436438; c=relaxed/simple;
	bh=n3BWa9N+TkMxStfjdjbKHqumRxK1i30TJW9C/fFA8vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WY8nEmhIpX8ZenNYZizLYRnT1mJEOvXv3EBItceYAcxPL4VVzNjUzPaZh6Lu6Sr6/ypiQBtdwveyt9IDH/nhFOQSDs7/N+/Py3lpy6Ifmd6Zr5HqdLDtn5sntOazTK777rJo+cfmPH07pSL5tUeyojGuhKoLnaRiZVXteRcFiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le8b+r2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le8b+r2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAEC1F0089A;
	Sat, 26 Sep 2026 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790436437;
	bh=l9IyOBupFWtulH+Gz9qmaU8NYVc08VS8DkkELT9Mkfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=le8b+r2bMxTJJvIPIEoJyxlgKyLv5Xi0D5g6fZMHD2fRT1ubWC50+RnyemLdOGdY6
	 0Ood5cZooGoh+H7GWfSrYYtFzY5tl9BTaaCvVwwapvhNVR5DPgy0pbxSG4mnU6uFZG
	 tDBeB8YMHp6OCgQpp6kc9tY3tYiIEKboZepRTEdY8Ewc9H/Hsf2o0/AJKTBHAyyUMr
	 OFI9NpYYrVTmF7/bpqF82545RCYxVfGkiVPGfusvtuWkX7+qkAkiFTIWVQSy9VXjDL
	 p1IIYJmcCq9FnhMdukgBKJgjtaTjR6KWzWsW6LxKmXDBLnQEKJzjOp2TaeZ5eVmg6H
	 HcA/C5bdUY16A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-mm@kvack.org
Cc: Sasha Levin <sashal@kernel.org>,
	rppt@kernel.org,
	sayalip@linux.ibm.com,
	Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v6.18.y] selftests/mm: hugepage-mremap: fix mapping alignment
Date: Sat, 26 Sep 2026 11:26:57 -0400
Message-ID: <2026-09-26-daily-reply-0004-re-hugepage-mremap-alignment-6-18-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925172129.2962208-1-luizcap@redhat.com>
References: <20260925172129.2962208-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On upstream this was fixed by a914785f6349 ("selftests/mm: hugetlb-mremap:
> add setup of HugeTLB pages") as that commit aligns 'length' to the
> default HugeTLB page size as part of what it's doing. Since this commit
> is part of a 50+ patch series, we backport only the 'length' alignment
> bits to fix the test.

The change itself looks good, but the commit message has no upstream
reference line. The SHA only appears in the prose and the subject differs
from upstream, so the backport can't be matched to the upstream commit.

Could you send a v2 with

  commit a914785f6349da754e1226420bf4e51961956769 upstream.

as the first line of the body, with your explanation of the partial
backport below it?

>  2. This should apply to v6.12.y as well

6.12 has the same failure, so please send the v2 for both 6.18.y and
6.12.y.

-- 
Thanks,
Sasha
