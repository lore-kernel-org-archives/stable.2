Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DF26E706;
	Sun, 31 May 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780242346; cv=none; b=ZZEtEQE4xXBL7ujv9aQaf8PkocLqmoJBljPKOWbHHHvQxXxNNX+HhQmm+Io4ZlzIDNFeWpgMs1Y5tqas6ygKEnso0baTfJ3lTslIpuotEVC9eHee8uZTgFFXl1eJ/k6odXMoXbPyXc6drZAc/vrJEtpzawzLHGQZrGmC3oJYIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780242346; c=relaxed/simple;
	bh=SVD63xrn6IISIPNiLlBTLVrnjqjyUKsekxiCpciE/N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uInol5bIprV+BJ49AiPnVNuEnRgkJfHp7UIpNpqVRtE9qnCwQoFN58mlG9MbiifJ5VJNSHqEYcvFJ0fpK0ZKA+760ZzgMNLgcR8OjLb4mwmn6MGvtYJ9x57MjpyyLxx1A5EF7C5KSWQ1/XTOO7o3At971eXygnHperU75+aZv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=GchTXq6y; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="GchTXq6y"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4079b0796;
	Sun, 31 May 2026 23:40:21 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Date: Sun, 31 May 2026 23:39:46 +0800
Message-Id: <20260531153946.1627418-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e7eb17baf03a1kunm1a9473aa10c4ad
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCShhJVklJGk4aQ0xKGU9LGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=GchTXq6yBIqgbfkodXRn449NHQhaIPStb9g4k2rFPVMWXdLfe+FgPe7UhrFXLw1DbeTflwb4uj8TVzFbMtKS8HH6nUobCtgae6s8CzR12ikwDfLlHk1QIBvzY9JWlYBsSGPdoW7u/5v9ZXdYcUYhDkYJIz/2HmbRyRukC/byZVo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=xYgiqMGXQuBXTQ4de//AYazBAazERw6uoWfhIGwwyqg=;
	h=date:mime-version:subject:message-id:from;

ipv6_flowlabel_get() still reads the shared per-net sysctl fields
flowlabel_consistency and flowlabel_state_ranges with plain loads,
while writers update them through proc_dou8vec_minmax(). These checks
run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads leave
KCSAN-visible data races and can make the policy checks observe stale or
inconsistent values.

The race can be reached on a running system by toggling
/proc/sys/net/ipv6/flowlabel_consistency and
/proc/sys/net/ipv6/flowlabel_state_ranges while another task repeatedly
issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
state-ranges flow label.

This issue was first flagged by our static analysis tool while scanning
lockless IPv6 sysctl readers, then manually audited on Linux v6.18.21.
The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KCSAN by
concurrently flipping the two sysctls while TCP reflect and UDP
state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KCSAN
reported races between proc_dou8vec_minmax() and the two plain-load
sites in ipv6_flowlabel_get().

A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side reproducer
also hit the inline ip6_make_flowlabel() reader through
__ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
fixed in this tree by commit ded139b59b5d
("ipv6: annotate data-races from ip6_make_flowlabel()"). The remaining
plain readers in this tree are both in ipv6_flowlabel_get().

Use READ_ONCE() for those remaining sysctl reads so they follow the same
lockless reader contract already used by other IPv6 sysctl readers.

Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.

Representative QEMU/KCSAN reports from the two target reader paths:

  BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
  write: proc_dou8vec_minmax+0x206/0x220
  read:  ipv6_flowlabel_opt+0x6d8/0xd20
         do_ipv6_setsockopt+0x873/0x2220
         tcp_setsockopt+0x72/0xb0

  BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
  write: proc_dou8vec_minmax+0x206/0x220
  read:  ipv6_flowlabel_opt+0x129/0xd20
         do_ipv6_setsockopt+0x873/0x2220
         udpv6_setsockopt+0x21/0x40

Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/ipv6/ip6_flowlabel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index b1ccdf0dc646..1ab5ad0dcf24 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	int err;
 
 	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
-		if (net->ipv6.sysctl.flowlabel_consistency) {
+		if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistency)) {
 			net_info_ratelimited("Can not set IPV6_FL_F_REFLECT if flowlabel_consistency sysctl is enable\n");
 			return -EPERM;
 		}
@@ -633,7 +633,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 
 	if (freq->flr_label & ~IPV6_FLOWLABEL_MASK)
 		return -EINVAL;
-	if (net->ipv6.sysctl.flowlabel_state_ranges &&
+	if (READ_ONCE(net->ipv6.sysctl.flowlabel_state_ranges) &&
 	    (freq->flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
 		return -ERANGE;
 
-- 
2.34.1
