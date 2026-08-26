Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6139184A;
	Wed, 26 Aug 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724660; cv=none; b=IfSPjZ6xma5U4bEITOD5or53HSMF4CUs0HPIHF7zRZjx46vmnYOKBFfqD8x2Wt02Z+5W42OCN7ak/67Xe4AvBIOMCVgzA53Ep5x8aw6IKaIqOv3VmUT2zXrR/y9ttNt0fsICMdFaH21GEJJbY1BJ0+x8TjCQ8JyIZJegKEm3/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724660; c=relaxed/simple;
	bh=eRG3l+bLI2uyY7V4FKmXdMdEOpONQOIxZYKTOEYRSCI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=o+OKGcN0SorFrJTYMwFQOS8jrZZDHH7pa3ZALqAVUkTam1nwWRNRnDqqiULpYHxY8IPFG90o9M1jO2FUCwk/oS4yr3XcN7dnLD/yCxfTsYYmzRPzmeC/HZn2P1vIqO07qpyb7dW/oh7tXTs5JaAm0fC1+qigPUxOXnShzYTgewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xKHbfwYj; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xKHbfwYj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787724653; bh=y8ORNrgpqj5sYg9mYdJsQlxDl/VjcoDqIo3M0lXjQok=;
	h=From:To:Cc:Subject:Date;
	b=xKHbfwYjvuFQ7rXTGFbRech6eOlbXcOAi4H12gfSK2WJhx3W1b+WZiwqDY1pWN8gp
	 r4stz8PFloGiwsbLKpzbGK3vr94+T1iDMCQjlFl6wRE7CfXFmOnyMZnmO4CxDDS0FP
	 2Md2U+l/UJsBDzCrXTOt125cKAz7SXC5bbPoSjlw=
Received: from wang-VMware-Virtual-Platform.localdomain ([223.104.134.142])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 2B39C263; Wed, 26 Aug 2026 14:10:51 +0800
X-QQ-mid: xmsmtpt1787724651tqbfwb3d0
Message-ID: <tencent_4AD5738B48FDD2FC84E21FE59338C8DBAA05@qq.com>
X-QQ-XMAILINFO: OKJfc8Sc6ZBy7Gq/ZcpqyXBqOr1RXIqb+VQi5KtjkL+Dnb68YiSffT5jDokiKs
	 qakD7SPJY7KXqE1amzAk6Z7oLRpAYCtuuSXgeJN6nl2Y0cH0r2zUTFUOcMBvSjekcChMDBbK0M+T
	 YDCiWo6iHRmXS+t21bEHLMflOlHjvieXbAWpKz6fq5Tiv5Z2cqZLDKbxhGU3OgtFdz6jANf2gwY4
	 TYbfQWeuJPo+cDObM4qt+Avl5xZ1Xk7IWQC7V9D8qepFgU4H0/8oT85eN0UTixSLuOcnYxvSbbgT
	 PuJORt1ZcApO631gESCnEWJrqRznNXl+8C2NKY7yqs1ZriY+5JhDuthBlCE3QPGWtKHynRP9aHsU
	 yoN7Uha/Hbjd2kRMjXeDRLY1+1W/u/vgQWBairdqG9N0HNorGY+u2OjZhIW1tVt9+RxENH1YXKly
	 qP3oB9YveySQdHtH2MoobfkK0ylS96W7Q8exL9utfY3y8GszIPIl6V285Ydmh2W923C0Iwgzrpqd
	 iaESWr7NUCGQbkslEByyjkWMmpBSR2rqSTil2F5pJ4z6ZoNxIvfNZUZFtvlg45GRVBW6AGDi1wrx
	 xolpH1dC1mY6/OA3IlyvVHRGXm2kHZvmwH9k4g85+fg+jWoZeT9n+MJywjxQzqVEaGAohL0SB090
	 hrL2xNubyDLEcjoq/YAZb640d30/kKs8qeJiAYxw+/5upX11xCWNzKqETfPi/UQaU/3JAphAixQp
	 tDcujZElVl0HTRNnJoULWetWYbR8R+pSyYkgwvMWZu+KnEf7bEgyMGIRBFCjEAeMEng8iMiGM7yF
	 nEloQ7pyoddpRepQ50bLIgVRar6QEMsZu0oJIPRqqgX89wEnzynaPNJwSVd06iZ6lxC8XzsnCKxh
	 thiUF8C0xm6XVDsiXuY9LQrrvQQC6Lb6JYjvXIcy0oN7JVtrkCAWRo6xul2cnxDtLGvJD34CCDdv
	 apYCK8rzpmyuZs1GJnXAGAN2rOIynSUkyplzx7ybfPG8+1CzDnD6bS+KbrNj9DZ2NWoPKFoOueO+
	 XrMAyjkZzXo/dOM409KLLY/Trfk84GwasSiOCzEFOX8a6CkWqBA2BLo/dpxhtneWHUItHvTw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Yingjie Wang <1075151112@qq.com>
To: kuniyu@google.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yingjie Wang <1075151112@qq.com>
Subject: [PATCH net] net: unix: reject negative max_dgram_qlen values
Date: Wed, 26 Aug 2026 14:10:50 +0800
X-OQ-MSGID: <20260826061050.238708-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net.unix.max_dgram_qlen is documented as the maximum length of an AF_UNIX
datagram socket receive queue. Its sysctl entry accepts a signed integer.
The configured value is copied to sock::sk_max_ack_backlog, which is u32,
when a UNIX socket is created.

As a result, writing -1 is accepted and reads back as -1, but newly created
sockets receive UINT_MAX as their datagram queue limit. A nonblocking
sender can therefore enqueue past the configured finite limit instead of
receiving EAGAIN.

Use proc_dointvec_minmax with a zero lower bound, rejecting negative input
while preserving the existing nonnegative range and the zero-value
behavior.

The issue was reproduced on 6.12.80 and 6.12.105. With
max_dgram_qlen=10, an unprivileged local workload sent 11 of 16 datagrams
before EAGAIN. With max_dgram_qlen=-1, all 16 sends succeeded. After this
change, writing -1 fails with EINVAL, while the 10 and zero-value controls
retain their prior behavior.

Signed-off-by: Yingjie Wang <1075151112@qq.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
---
 net/unix/sysctl_net_unix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 47660d5..2782095 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -19,7 +19,8 @@ static const struct ctl_table unix_table[] = {
 		.data		= &init_net.unx.sysctl_max_dgram_qlen,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
 	},
 };
 
-- 
2.43.0

