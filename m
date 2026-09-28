Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA7D4F4022
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613984; cv=none; b=l1/CX5zl4Klzicy00A1yx25YrBHxCQlUMUfVEiFryZATLU1oVWNu8ifcT0rIanfvGSBbt/g9fNJETh/tnzKPeGqkdzbpYGPfUuXavzqawBZs/TJmeU28sJvyhdMO2HahNC442U5f5IGGo5OMDfU7vUUUw+HBsXa5/mpXPOIos1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613984; c=relaxed/simple;
	bh=ezhUKkceAwXrQDGGsgfZU8xdczqQSgBt987Un6aHSbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBLOWRqkvGzqSdfDfa/2pVyiaHd9gaaq7IjuFtWTMMkiyiHzr5nud5K7nJSAZFrDSRhIsnquv30G6/U3Q2PcTwxQLH8qJCRKZGgAWw+aA6p8yCw1BeEMr5qiCPxbSxODS7tRUIqQBjr01Ni4dBJ3rb4PeSECEmvAc7mjrhOFn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7oQ2Uug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7oQ2Uug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3C81F00893;
	Mon, 28 Sep 2026 16:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613982;
	bh=nMoSf8ZGgsGGfkcZq1/hLtiQ1AOGsg6AXH8ke+G0XQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e7oQ2Uug5rroqWVveD+k0dChjJcOvYiNl1Rhal7+bdVsfL4lBLD4pMTfRDBUjJRoQ
	 mq5u9LdbBgtGQdJBNxHD+p7zDdBObRAKrUVvFyTlXQzauM2E2N2q8kz0x22O8BHgzj
	 GkePZ2rqs6JIa4r5JHG74N5SH0DDB4isFg7z2V/bV5pSk3ALqJtb8huPewMb4pts2F
	 hh6eyZ+a5Ymu5mBMS97M2wnmVG3piJuhYpScLG76zdMPCUMMcmrAnXMgszFaFp6NvS
	 1i8D0CV6JK+qhLlEe/uZKGI+MpOcRbTccZLugvb7HfDvvhSuLwkm79OVtS1g7SbaXw
	 jr2Lh+XJFNwSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>,
	miguel.gazquez@bootlin.com,
	thomas.petazzoni@bootlin.com,
	"Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: Re: [PATCH 5.15.y v2 0/2] netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 12:46:06 -0400
Message-ID: <2026-09-28-daily-reply-0007-re-nf-tables-splice-list-rcu-v2-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928-cve-2026-52988-5-15-v2-0-519003db6b26@bootlin.com>
References: <20260928-cve-2026-52988-5-15-v2-0-519003db6b26@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> A conflict was resolved: One hunk of upstream commit was not taken since
> not applicable to this kernel version.
>
> An additional patch was backported, which adds list_splice_rcu(), which is
> required.

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
