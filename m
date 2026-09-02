Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3784AD7C1
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387273; cv=none; b=vDuZPHNM9eIwGGlEK5tWtv5R1Kq3WLtVMh93d232YtavS1sVTWesZDya+ZRGw4s9c5OS7RtVzheBe4r7uDeHCkN8f1c0EUkbFnAaiPDY20M2X5Kf5KW+Gxm1F9nueSrKwKCbXBjnfDNFscu3IyoUwxfbL5uBUR5kq7ptgb/CsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387273; c=relaxed/simple;
	bh=WFR8DKiWR9Frgxh1Jbg961KktCcw0qTeHalkaoSsJOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFAW60xZkinTgDEfY3I2Q3oXHq6i+fL5qarBf9xM7FzRCAO609WffOzjc/rCO3Pta4Ma9hmpnb9ccR/h4V+kzyxIYWS95rZUFJxeyGdO043VAdSeGs6CJAKqa1qMzK5xzMd1roH2zdkJpEdtgKdZMI8ET347nx5vgDIjxC24ZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQhvAX9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQhvAX9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8431F00A3A;
	Wed,  2 Sep 2026 22:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387268;
	bh=BeKrpZq5mhUAqmrvj+af+SkcIEUxkxq+VzRPeOwyvPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NQhvAX9JlV7JiyD/wH64v6qBnMQIzSU8qXCkWi5tgMMHCDbxL992GIQBb3wOCKMaB
	 ye1zINJvAH2Bh5nUveEOaMMUuwIPVyRVRB01dZQ2vhCb58h7DItN+RPCn8/uH2VFlQ
	 K40gVLc1V3y4sxbOLVJQUMmqGJFWOb0rKvNpU9fEk9gTtpFpX1etx34KkAlfybzZ0T
	 dsN1aLinoBhVItye0Zjdk5F0M6bRpGWw/C1klTJPTEZpwHXZG+bmXl+o4a/mlOMxjl
	 vGdfOvU/Sfzm0JC2OX4pisESzg4+uiucdP0fva12rYUwvK4ILciKL0AGwEskiyzqIY
	 6+M9fG6aq3Ivw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Rochan Avlur <rochan.avlur@gmail.com>,
	syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 7.1.y] fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free
Date: Wed,  2 Sep 2026 18:14:06 -0400
Message-ID: <20260902-daily-reply-0007-fuse-abort-on-kill-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902013656.17291-1-rochan.avlur@gmail.com>
References: <20260902013656.17291-1-rochan.avlur@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The abort_on_kill path in request_wait_answer() calls fuse_abort_conn()
> and returns without waiting for FR_FINISHED.  If fuse_dev_do_write() is
> concurrently processing the same request (FR_LOCKED set), the caller
> frees req->args while it is still being accessed, causing a
> use-after-free.

7.1.y is EOL, so I've queued your patch for 6.18 instead (it applies there
unchanged); 7.2 already carries the fix. Thanks.

-- 
Thanks,
Sasha
