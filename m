Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758272;
	b=fgECuhc4mPxwLsgpn8dFfvQ6TiLRuAR0iemSg4/odtSg5c9DkD+1w5jQ9RmhhggpcLLs
	 mTn1TVhYkDMk5/gnEeM17FSL/nP34F7cPPrfKIWGnQPvXwat3bIfcI1V+APwJ15ogE2M0
	 uxDlMBKhJ8lc5SiTwm0Ex7ncZI6fTX2FpfI/CvheiNqeQQf1u+ICGx7+9eeZSHJKFqDEQ
	 a2Fb/C1uIfewGd3sUaCu1r0jKTOI8FThDasDwGqL7IpwMI5XRqbdpXVVFgWsDRrks3jgb
	 8w0Woq0bZcHCQbY2+wpYRcMKS9hWnwUDQAV/NHu+cTvpLMIK1/0ztR9lKjo0KJ0CuDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758272;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=o+XltfqJrZ95a6qdyrBWf8fYWe7VspmbFRBcyA2Af60=;
	b=D+expajsQOAkVauDcWDS85v8Livj8/xPnO/ncDDos+mLYN9sBHn2Gg1O4d1JIS+p7U/P
	 oET8cJ7NQbkqzxOKWHpY00gEpMG+1Nq9pYCbw3SQCqeJ4COHeOOcjglVY3OW2n//T7Evp
	 TJELaoeTFaPAlCTsiJuiiTQ7Qhjguqhk6ImUeoBdH/peRso/Zcq3iwM49t1kI+MvU51DK
	 2EYgcBHfixVI9V7WvPJqzWe8L0/Mso2VrYbVn3YhD8PDrq5mdMcmqNi95vOQuzNVzn2dr
	 QnJq4ks1e1qpwDWcaikXh4KV+4GZIQS+tXZ3oaMb9WQg3KA083cVUS8DaiEB0hNsl3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kobgKXOA;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2986606A33D;
	Sun, 15 Nov 2026 15:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2986606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kobgKXOA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794758265; bh=o+XltfqJrZ95a6qdyrBWf8fYWe7VspmbFRBcyA2Af60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kobgKXOAsg5+xHaP1djE8bGgJsgAtadgWvObfORQmaYTw7+8YGzJFLi1ioKrfb9pJ
	 WnUfL4V8xGa0l46uplKZ2zBnPf04+IVxBc+mIewNXbQXSt6/UVGGXijVD0UDoPm2B5
	 +BRzQoNZp/1JPBaXjFWLmSa+8zK2J6s9nIOdlAVI=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:103b:e9c7:571:634c])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id E6931827; Sun, 15 Nov 2026 23:57:41 +0800
X-QQ-mid: xmsmtpt1794758261twipasb0b
Message-ID: <tencent_B3B795CD5D04DB5F115B3CED23D57EF9A40A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Gc3Kg9n4OQQyzt3Yrgm+67u9HPDMgjYzX0dIkePlahq3yL1TsBZ
	 IoNShSC/xl/hfDG94CfHQFQubLBSfN3k1Jsk3iY1MjI3GzE2cLKhtmkeTUa1ckqtHNbMqa9aYH/n
	 IlHvHE8PsQBXB6fTCCxRZWNceP3kUWB/Py8mvjPO4RZrANd5JRZyuowdePUZyKPnzym1sIhtTcNb
	 JQMuqig3Y7+ZZcCTUPSWaA8Zanu0VWnSSy38Jvq4tHG4jRwkP34CeY1+gpaplYcT5DEKMX1P4nhH
	 pfF6s6tsrHivYf7s0VJGPbvtS9rPfmI2if1wViL4j/fo7TX7rqre9XDGj3abp1u9Fii1GhbarRxa
	 wCoAQURsOhKY5e3r+QuldjAyzqVSLWSP2+I6yxFK0eAnwgc/joUOXed3KRPM+dqJmCrehNAOXeKR
	 quF1KPpPeWbfGtJBZD/ZyFcKEeZNb9wJwbq1pPb+CaKoahhoNQFso1pFwTAQT3lGcChQCO1tKFzV
	 mxZaNjmkFJ2JK72g7mu7NvOtjQN2NIjzf/Nh69Ema8ZfydBKUBb+9dOxflQxZ7T/os5+M2c5SFg5
	 /bXbSbfZZVPnZ8fUBWNENa99t+r1d+NdnH4WWEuXw0fmTjt9j6f4qGxzuie4fvOi/rykHJnRdyWK
	 XEFqPuM70EOCBUlFemwM6nxfn6DqgiPp983yhdPy56ZYvtb9WdHo9rJdqOP3CKHQK0LjaI2n1j5Z
	 HVqqEuJ/awFGPxleg7d6/8lgMDw0XwJPzSDpaFw3x2XPqiRnQel1o2rR3/Ci2mskOPq2k7ubkpai
	 +iEqHs6yw0ybta5VLT6e9yEtusRMaiLwhiYNvepswdrkRElxpBEtnt4b26SYrVU0tB6skpHmX14A
	 qvuGR+eqYv/8tS9F1FDQlaOS567XyV7E1H7uljY/vEdiJalggy2gsIpR6+XXqTqxezZreo3in+qV
	 PbQYzS2qPTHWZ21FhyVDQUqcllIOHIsARlKg/tKjt1e9aN3OoXusPFRP2RrxQ69HvKDqBlgLUQyl
	 6PUq63/CJ/W0VGINOTm22LXd54Ge/pIzR8wjrgp4Z9XLHU1jdZSUfMHnrE8XKryL9Q2Uhtgkx6j0
	 kCXUCa471CZbJgNwI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hang Nan <2122295973@qq.com>
To: sashiko-bot@kernel.org
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 2122295973@qq.com
Subject: Re: [PATCH net v3 2/4] net: core: take the reuseport migration
 reference with acquire ordering
Date: Sun, 15 Nov 2026 23:57:40 +0800
X-OQ-MSGID: <179475826068.178830.14957974064477086476@qq.com>
In-Reply-To: <20261114130927.91839-3-2122295973@qq.com>
References: <20261114130927.91839-1-2122295973@qq.com>
 <20261114130927.91839-3-2122295973@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thanks, agreed - the patch is dropped in v4, and the series is now three
patches: the two mptcp token patches and the iterator one, unchanged.

One correction to the reasoning: TCP sockets are allocated from a
SLAB_TYPESAFE_BY_RCU slab too (tcp_prot.slab_flags in net/ipv4/tcp_ipv4.c),
so "not a SLAB_TYPESAFE_BY_RCU lookup" is not what separates this site
from the ones in 5b5d8f351dd9 ("net: restore refcount ordering for
lockless socket access").  What separates it is the second half of your
argument, which I agree with: the acquire only orders a validation
performed after the increment, and reuseport_migrate_sock() performs
none.  It takes the reference, unlocks and returns the listener; the
callers go straight to tcp_filter() and tcp_check_req(), and the state
they actually depend on is re-checked under queue->rskq_lock in
inet_csk_reqsk_queue_add() (net/ipv4/inet_connection_sock.c:1403), which
drops the child when sk->sk_state is not TCP_LISTEN.  Ordering the
increment changes nothing about what any of those paths observe, so the
change was cosmetic and I should not have included it.

I also considered adding the missing post-acquire validation instead
(re-checking sk_state or membership in the reuseport group), but that
would duplicate the check that already exists in inet_csk_reqsk_queue_add
under the queue lock, so dropping the patch seemed the honest fix.

pw-bot: cr

