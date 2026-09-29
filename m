Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF32544D64
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704077; cv=none; b=BYor5GxjigNi6FqZsOxqetqOXKkWSRZJ0qCa03aoa8ltxYjYxaK2Ks7i8Yf16lRfOUqnULvnW4GL5QRKjq+CcTLk039/uxQKlIuHTOer15liwISY6MnMPgZkl9RFJK61qD7nCaWBr2WRcWn08CcjxHs1EZzurfFvc1WS+Y465Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704077; c=relaxed/simple;
	bh=Pr3wCuyD8LVZi2MzZ8hnV2xxa0RItBAp/Er6nEQLaCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wgv/FWNlphyaPCQthmHtLkTjxD0hn2c7Oa4fzpysnQDE0+CMMNmqrXpmRUXGTDQViBA8AkB1Fd1Ap1rv6VKlL/BROCQivFg8aV4HDW/su22eUbnyGy9VHkUnrewoXIanBkQqU/yjadXvmNqxUUVUEFYV5oTMcD7/cTTUD9/0RsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBcuKbZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBcuKbZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B9B1F000FF;
	Tue, 29 Sep 2026 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704075;
	bh=ZR5IowNUPn6huNzyFRzpdFScr96XlLHdmiAs6OWI54U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mBcuKbZBW5lSr2DkwyNS0PbnzFYwQtNekRDgsz1MkC4bkLakI8HOT7qI14hYbsLU1
	 9YZtUl6QqNGcBYXQE4KVnIkhM+iKRCrY/UwoNZNlIv8lK4Lik4yP9se6VnQftVnJHh
	 jWdLIk2jBTxfWR74dydYObxPxFrt96L0BhqJERTc3DR9DfO1kQZkLFZYz+wY+xOX0W
	 XSFYtpa5HxIedaQChU/Y1c5kdJFZAh2t6eytPgpbm7tJboHn3v2Hy7dd6BYowlC2V4
	 rfQSkeA53JhTmAAHUR6hmUBJKLKQqc/epj2kSN+yTYQTTWMemBnrMOekY0Ga8nt1UI
	 tLYBPBkeMwXNw==
From: SJ Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SJ Park <sj@kernel.org>,
	aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: fix unconditionally skip last region" failed to apply to 6.18-stable tree
Date: Tue, 29 Sep 2026 10:47:51 -0700
Message-ID: <20260929174752.9426-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092947-shush-encode-1e48@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 10:27:47 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Thank you for this notification!

> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x b3723b596b548c837a766aae3553c14a7b15af2b
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092947-shush-encode-1e48@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

I resubmitted the patch as part of another series:
https://lore.kernel.org/20260929174456.9251-2-sj@kernel.org


Thanks,
SJ

[...]
