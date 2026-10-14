Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA6305688
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941265; cv=none; b=XI4RdordKiB0WeM4E0BhA5CAjcSklTmgTORENqNUOZeJphIs6AJcNF3RJFA6ZL8p84MXbgL4I3/HmE8jVu8dJ4r5mWfCgKMHoRbp9Latoq5vX7anfjxpGsT0OY0KYXW+XiD01cItZAzAKJ9njhB2449JxMaxh7lU/fLB2Z8OYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941265; c=relaxed/simple;
	bh=agqfEFAoVFbTRcmeT+6bbOnAO/hCrjnuNfuvpCNpYfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4pK8RM8AP48RvbK4b2vOH3wPqKiXXDjf3xJL2viw5zOQ2n9LbxEOgSK9Is49Zc/tFFGfo3mob6Fb5LRvU5Dlo5Z88sWyjeaku8iDav5Q8zYTkSESsqfed/f1Qev443zea917c9/zolV/+fyHEdgxI9Yfiz6RKMHmceTz/stOME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1zxojSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1zxojSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043F41F000FF;
	Wed, 14 Oct 2026 01:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941264;
	bh=/V/ueQnzWJ+lDfbiF/wOUamKBovYD4EvmqL75Erjc+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e1zxojSNV50VBxzDmsvEVD6JQ2wJgADZINOTsG1cj+1+yZRPYBtIx+SRKrBVdtJAH
	 kcgi8gXdMZRdRl+RQeW44nSCLsvrGuu7dt4fUMw7CXjdZfwKiuiUy6zcM+1CVBroGI
	 5ssF+oFufROg17rY/J+lT3qpnaXKc1CEbSUy673/LQEjIwoxEPTsN820ty+GzgvEl4
	 I3Hzt4DfYPRyHG5PKjhJb4zsLXbrxPJw5vM7ynPgDshLCjsrE3JVPDW9nWYYgHcVyo
	 ZAU9y4xGK+a0mABIB2pXajEZfrDPj2GRUQsPm1xkimLxMcneJ4lqjp/xnkbgDTVdTL
	 YctWqXQQe7zGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kuba Piecuch <jpiecuch@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6.12.y] sched_ext: Generate qseq from a per-task counter
Date: Tue, 13 Oct 2026 21:27:14 -0400
Message-ID: <2026-10-13-1-daily-reply-0024-sched-ext-qseq-per-task-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013090229.3584603-2-jpiecuch@google.com>
References: <20261013090229.3584603-2-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> finish_dispatch() uses the qseq embedded in p->scx.ops_state to tell
> whether the QUEUED instance of a task it's about to claim is the one
> scx_bpf_dsq_insert() saw.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
