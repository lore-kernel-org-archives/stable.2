Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8E3D525F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255014; cv=none; b=L91X+JE6/ERwinbmeh0qV8VGHqbnpa0ln5wFxbnKCoF/0Xpaww2AagU3KkrqQMbzS8Du14lgY3hetMjOhQUgpJh56oZAu4IvCLagJHXx+OJi++znDAMO/rTWlIBY2Tis4yKzICFEGUKaNFUfbPF2f2exoDIB51OjBdQycaxyxfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255014; c=relaxed/simple;
	bh=MzokxoIqlNCtsP13EZve1BPLH7BUuOCHUmahB4Pdu1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWbhgDn5aEx0OF14X0dfE2Lf3hDWw5NF/U4ogWmB2rG1ejoIx/jU8ipg02Nq4KIzerqKkoFjft7NoC8KFTg8/YHRdH5Ec7qRgTcYzmXN7YEQZn022qRP/qh4HtNv6mHmNwdWn3KEUi362KF4/fuFhoJlXgIom4QP1zm7b1JBsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt/uIHRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt/uIHRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C969E1F00A3E;
	Tue, 28 Jul 2026 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255013;
	bh=b5XKu7XvBqX5+Nj2RbWqnYXmt9uPYvxTZtXKSmFoiJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bt/uIHRG4vCYa/1RvexPSj3uZYDMuP6Y0gRGMS2iocpdJZZ5Vfs85OSGO8TWKF9pe
	 OvLWCPqeLOyc36WnpXtjVKDqDDn83IEXuIoeN2NfeW5PAzicnEXa2mTMbTUghuP6F8
	 im9O+OLx6p2xDdFsheHTSSwMYJPNapIQ161tqxqWnZ8bzkLBPJPClcd1LPwh+Bk5hx
	 eB8KacxE2/SMgInxQr6+B4gN5fH/qn1jxHjml+eJzdNkzEW17U+U1d6yc4MiuwFtYX
	 8rC/CW0wwyvpt+lJorW7i6lqG4v3fZfj3QalkgGFenJZZQxPRN/u4qlFMpr+L9Ob9s
	 0pRmlgluvLmqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.15.y 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
Date: Tue, 28 Jul 2026 12:09:57 -0400
Message-ID: <20260728155654.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102149.16440-1-socketcan@hartkopp.net>
References: <20260724102149.16440-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> -		sprintf(bo->procname, "%lu", sock_i_ino(sk));
> +		sprintf(bo->procname, "%llu", sock_i_ino(sk));

This hunk is not part of 68973f9db761 ("can: bcm: defer rx_op deallocation
to workqueue to fix thrtimer UAF").  It belongs to 0fe27e598592 ("net:
change sock.sk_ino and sock_i_ino() to u64"), which is not in 5.15.y -
sock_i_ino() still returns unsigned long there.  The result is a -Wformat
warning (a hard build failure under CONFIG_WERROR) and, on 32-bit arches, a
/proc/net/can-bcm/ file name built partly out of adjacent stack.

Patches 2/9 to 9/9 look fine on both 5.10.y and 5.15.y.  Could you respin
1/9 without that hunk?  I'll take the full series once it's in.

-- 
Thanks,
Sasha
