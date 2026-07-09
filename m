Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60257395ADA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559097; cv=none; b=fqIO8vCOG0L/SfcIqV19KMtP8sr5JKuQyk4KvRMdf4cu8udlerhwiaDOut1LBzw8hNoU3DYOAm+UFlJxWwpjRwWP+0yFUFl2tIT/BwoQPTgC/XnrzZbzrYbAPoH7s0APtMRzbh9m4LZ6pf+828pFt3z7WnbBwcyQoYHoKePf1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559097; c=relaxed/simple;
	bh=2biBtVaZJzKXatDYC3rlJQqfuxkG3+exhbxe8kSacAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpJcSO06yf5FCEjwvLjuyJH3QIVzdPwz9g7ETtq02DEr02CX6SFp54tJOEb1WY/E/mRyb4GBKRUDzjFhsReQqlN9ko0Y47YIdS76KcKNEm9YMByqBc2F0l+KD8GCTx2u9w+B50kwksCfCpPfcXoGrAmQEgKPILRGC9WHQ+b9fNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeC6Eg7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeC6Eg7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC591F00A3E;
	Thu,  9 Jul 2026 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559096;
	bh=nNcE2gtya9jGC2DcKGhJAdZybci4wsyZY9OoXAOEefM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IeC6Eg7qOMaCycaotm+pp0ADFz1U/fYhT74nBwfyXDj4qhXLiwM2maryLcE9kOFz/
	 FhdCFBagg3nLvxPTHgtGNKQzY4N29RBmt0RNTWRWNSZpC9cQhiTXJ/MX1ua+lO/JcH
	 RtddHhEB1rS2dMjEhR7RcfeXi285A6ahBH+1MeeqrOoNDrSxgzYayxryHoNQHahlG0
	 BYfapUbEV8jLeT85B7NDpbC6YFEJnMDRlcvlvpOw3PMLhKQfS946K5i6k7ehtD4vAy
	 mZBktJ6cg2g68duFYDlL1eRea6mw7akKMbVg4pkhjWLWm13dS262JDv4WKgBpTA7vc
	 xxkDaAfyLtqNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Keenan Dong <keenanat2000@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Sid Kumar <sidkumar1@gmail.com>
Subject: Re: [PATCH 5.15.y] rtmutex: Use waiter::task instead of current in remove_waiter()
Date: Wed,  8 Jul 2026 21:04:48 -0400
Message-ID: <20260708194323.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708150527.3212183-1-sidkumar1@gmail.com>
References: <20260708150527.3212183-1-sidkumar1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Use waiter::task instead of current in all related operations in
> remove_waiter() to cure those problems.
>
> [ tglx: Fixup rt_mutex_adjust_prio_chain(), add a comment and amend the
> 	changelog ]
>
> [ sidk: Replace scoped_guard() macro with raw spinlock operations for
> 	5.15]

The backport itself looks correct, but I can't take it alone: upstream
this commit has a Cc: stable follow-up fix, 40a25d59e85b3c
("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued").

Could you resend this as a two-patch series: this patch plus a 5.15.y
adaptation of 40a25d59e85b3c? Also worth considering as a third patch is
74e144274af399 ("futex/requeue: Prevent NULL pointer dereference in
remove_waiter() on self-deadlock").

-- 
Thanks,
Sasha
