Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738148F031;
	Tue,  8 Sep 2026 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907178; cv=none; b=l4vsAFXUkvIwn1q8fwYaNY0TOa6sp+06duuqZsO4QBkzWoQTLGwgWrpxhE92hfeo/qjFdWMEwzTUQsPf2gwXIi2RNFz4oj8Ig32PFck/VAZII2tI+DsJMd9iEbyL68Swir+qPK0NlpgsW94VJLgZPPdlHd0oy8Pq3RbSlyfS7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907178; c=relaxed/simple;
	bh=K0Fp3/8MPI78w3plDQwfDIHSCb1xhAWQDEbQt4yn1YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmqzMDD29ZZsEpUkunr6ooIvVbpDM8TdqvVOPjh2NnrFZhe/kce5gDorcA8bNEg1YleFTxAovuiqDprBtleGgqzVYXItDhiRhrHlUlWB6GSJC+MOv9ce2xm13EzO1IOBrg24ZOzRBKT+T8x7+ffEwy0NLKw0OJ2xbI7yd4Asny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbshvHkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbshvHkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF581F00ADB;
	Tue,  8 Sep 2026 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907170;
	bh=CUaNG8+3etczoLjmEJ1Fq9ktaYGuJi5EDDS65u7lJs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZbshvHkcX8KJmv37Zp8P3QrDcKKu2zIKlxOzSkVmHr3KHpEm5QBawF/4NRlPl8Wcm
	 4Aq3xpOfjF1p+Qx7Ls+jDd9bIPYYsONxItG//KpJ3UMQtFEFv/60t0zlus8G3hxdvJ
	 DlsDlcnxl1y95h7Oat6EWGlH+rb58T/uUB5uNyOcdv7/QBdkkYuD17s4BadixetrSk
	 6IqDGHvmLI+8HiytiuEEzRkp5PZdL3v3/HVng7tLlNeDVu7CHADbHIjgCF/T4HOx2c
	 xo321i3BM7YOecNOnHFnz2m3WaBGz67mc/xWplWy55/fzk1QoyPbwwdKB1VqTq7WdV
	 ZfPA+vrscjBFA==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [STABLE v5.15.y 4/8] eventpoll: kill __ep_remove()
Date: Tue,  8 Sep 2026 18:39:15 -0400
Message-ID: <2026-09-08-daily-reply-0008-eventpoll-refcount-bounce-5-15-p4@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908085113.3960814-4-lee@kernel.org>
References: <20260908085113.3960814-4-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Remove the boolean conditional in __ep_remove() and restructure the code
> so the check for racing with eventpoll_release_file() are only done in
> the ep_remove_safe() path where they belong.

This leaves ep_remove() with a redundant second refcount decrement on 5.15.y.
On this tree the decrement already happens inside the helper (ep_remove_epi()
ends with return ep_refcount_dec_and_test(ep), carried over correctly by patch
3/8), but this patch imports upstream's caller body verbatim:

  if (ep_remove_epi(...))
          WARN_ON_ONCE(ep_refcount_dec_and_test(ep));

Upstream can do that because its own helper returns true without decrementing;
5.15.y's doesn't, so on the WARN_ON_ONCE path this decrements an already-zero
refcount.

Could you respin with WARN_ON_ONCE(ep_remove_epi(ep, epi)); here instead,
keeping the decrement inside the helper?

-- 
Thanks,
Sasha
