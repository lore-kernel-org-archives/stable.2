Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF348C411
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635730; cv=none; b=I4RPhVGMdv1+f57mENoVkK1J1SsD5YjlazgL2/SvdfWiFtfcXneCIoBNfdb7X268LvXlX5veYVWZ+6itUrDnI2sffoZtePriByYOY5Vrv75g0aSA7rnMGCl55x96ZiUKS0GHecKChAor4vQKh7J+R9Ser2Tu72aW47r+mSUBMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635730; c=relaxed/simple;
	bh=ZYzMXr7UTZjp4ArM//rwhJdbk2TiZRAXMmtWL0OBb6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCwOVcjN+m9/IDL2Z8PoP58ixgLm7La354Kk/t7Q7W5jdnUYiWpgit9kwdHr/4+9SRC3lI/wTs/uV8aLtNe9jF36hVqe85nkaATBJqLjUYcFzBW/3j08Z+hzgE8azqiFCK6/w7ueh3wwkTF2aIAI8xMFf2mgZo8a1/QnlTQlSww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtrDUHYu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtrDUHYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA73F1F00A3F;
	Tue, 21 Jul 2026 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635728;
	bh=S/KnCGoGBZSxgC6YsV5ujjTwGFNhZ+ifeB8gx0+cctU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JtrDUHYugAUsftt4PdLDdimczlQdOhRdpIkXegAk1odG+ke2I2hq8yeSjM/4SNuJk
	 IamZIWRJETFoQjYVFEzF3txBtGEFkqIisks2cCJH/n7ihcFW0eZgzUznCtd08R94Cj
	 TqYiSorX+Ow7jb31iORRiFqvNb+qn9YfPjvvxhDb/lDoWVtCO3dzEfuD/TwQ8s/AIC
	 Q56tMmcwS9O6KbdDM8GSUGCCrJFY7RjUaRQantvyLR7XJ319XIRXU3IyBRpPnhNqle
	 cKKNLH1MDFDRCzgwDCISAjf/UJUMzrz0AvbFUGfxIGn9EwHhYxdMFSlgpGr8A+jfdO
	 fnndOJlAVrh/g==
From: Sasha Levin <sashal@kernel.org>
To: Sid Kumar <sidkumar1@gmail.com>,
	stable@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Acs <acsjakub@amazon.de>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH 5.15.y] netfilter: nf_tables: restore set elements when delete set fails
Date: Tue, 21 Jul 2026 08:08:39 -0400
Message-ID: <20260721120236.100005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <afa30b9a-07fb-4f21-973a-72bc7ceeb9e4@linux.dev>
References: <20260624213654.2762749-1-sidkumar1@gmail.com> <afa30b9a-07fb-4f21-973a-72bc7ceeb9e4@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 21, 2026 at 05:07:00PM +0800, Jiayuan Chen wrote:
>Is this patch associated with cve-2026-23111
>(https://fuzzinglabs.com/repro-cve-2026-23111/) ?

No - this patch is the 5.15 backport of the CVE-2024-27012 fix
(upstream e79b47a8615d), a different vulnerability. CVE-2026-23111 is
the inverted genmask check in nft_map_catchall_activate(), fixed
upstream by f41c5d151078 ("netfilter: nf_tables: fix inverted genmask
check in nft_map_catchall_activate()"), and that fix is already in
linux-5.15.y as commit 8c760ba4e36c (released back in February).

>I'm verifying cve-2026-23111 in latest 5.15 stable, but I can still get
>garbled text by running 'nft list maps' like this:
[...]
>Does that means cve-2026-23111 is still exist in latest 5.15 ?

I don't believe so. What you're most likely reproducing is
CVE-2024-27012 itself: released 5.15.y still lacks this patch, so
nft_map_catchall_activate() doesn't restore catchall map elements on
the abort path (there's no nft_clear() there), which leaves a freed
element visible to 'nft list maps'. That's exactly the bug this
backport fixes, and it doesn't reintroduce the inverted check - the
nft_set_elem_active() test it builds on is the corrected one.

So this patch stays queued for 5.15. Could you retest with it applied
and confirm the UAF is gone?

-- 
Thanks,
Sasha
