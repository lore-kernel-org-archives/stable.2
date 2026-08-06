Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F63ED3BA;
	Thu,  6 Aug 2026 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009342; cv=none; b=frAK07Zexlk2CzgU5ZWoku9agWTO88auVTv27g6Q0bAOdHszHbQSE1cCYFAnJFYT/ND05vxDqgjvPzTc4BXUxUnMIQXl4VsVjlbpwma+h/7qsc0E1L54a3nI6odtPsDnTf129FI6ccWXtIns7/f+vYo8vKpILQQf7zUs3P0qAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009342; c=relaxed/simple;
	bh=EdRBoKLE1jX//QvJT1cWVHz9bIcNy2XWZHA5mWbPcGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VoHte/cT2NYkA2K5wC4+C4OG2aATujLi3ZVZxK/AOLYPYBbCq80sD6DpwWq3tSf85KLGnRIPy65Lmitzi3kbsJKAtfaxj/qY6cMt+OiPjO/0sZdadip+LtltWADBv+EnFU49Smc7qcb7OV7PeGFIjjkzouWWKAh0naRNE2wQ5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dHC6Xd1e; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dHC6Xd1e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=h5ik4yM9fE+jWXD4ilxFle03xtSHX0GZDfkqTilhjLg=; b=dHC6Xd1eS8hQdgrN13yPucashS
	C4x8I30UGOeOroT4FsyX1/dhVxj1/EqpJwngwJSrLrtybhUEWQpTqYj2L+jsEzSpTWygFc5mNOOHq
	+cUNhbc1NMxysqdgF5LaV2td5Q32UG4AscNSfNCHfMjYJjQZjt3n0HUDYHssXZRw6/rB/g5MPbg77
	n5a0ETIDSDzCmmjvz95ugQX2xknSynt7R2ljL4TV5EAqgnduEA5Whlr6wE7wOaz0pS2W/QCCKB6SE
	sJWv7LvmiPeTMki/KInRMjkMAZL34UO1QJlQvndlKO/MBD7kMdcsJDyYIqDuZo0rt0h/sU1WNUQYQ
	c3y7ZtWg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wrucE-00EbHg-0O;
	Thu, 06 Aug 2026 09:42:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Aug 2026 02:42:00 -0700
Subject: [PATCH net 1/2] ipv4: mcast: getsockopt: do not overwrite past
 optlen
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
In-Reply-To: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=3502; i=leitao@debian.org;
 h=from:subject:message-id; bh=EdRBoKLE1jX//QvJT1cWVHz9bIcNy2XWZHA5mWbPcGY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqdFbxySD/lQZFtlsbVY5I3jXr+9Z/zzywAeJsA
 iLNhc9OUueJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanRW8QAKCRA1o5Of/Hh3
 bRBhD/992k/K8bQYR5BTP1/boAZ/wqt6VdNuoN2yTT72ApyabJhAKGBIh+l2pGanwEBQobAuTn9
 mMsCiJJokHwJqi4CCJR6QP9SUqlkOv1N32clOhwUzlk0Q0hS/Lf2XQtXwdy6LJZZRNd1/k0Efxc
 IUjRUrKvUPwGedkFbEWE0kfh7/qRo62ohqYrh3+RXNIZZrR7pWIGc2yhGbh8vKaxZJIxMyStBi3
 EkYdHYOcP4V5GwU6rGosiHUo36MhdPnv7No8CN7JDhb+g3o2Rb3Qh7I+pwf9zW6eAl7u/R2yHny
 H36ZfNmfhyxwiS9Sa+5T1jM4sBFnCkYyhfkvR86f9fn75GON5hWarXvU18ICdW2r32IMQB+wMhM
 f/DN9WLoxNV/Yx0//XHhv25GV1CI/bOUNg4Xy4Aut9PY3S8ea5q/kNIo/CKlYdz1QilDjEdAc+M
 /L+XzLL3YaJjtdj1QbacMAE0Q+MUz4r65H3jO1Q+YjyqIBxAIkidTlu32qcFIl/19N5himnYbIt
 s1E2xz1uzYsdvVJa0yN5tLvzrkIJgQyoTXp8V7+Ds02e9mpC8Y/HPLxYFwqOhlc1HMiWxUEmavl
 DW2Xzjn86DBdwU4IVJE2KjYxyLZFgJj3sF4RMZZ+bcnJb+cwG/SgyuGk7OmlmDRr4+U8xRfG5vT
 yyAJVhNX2Rqi8Aw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

getsockopt(MCAST_MSFILTER) can write past the end of the buffer the caller
declared.

This is because the copy_to_user() does not respect the optlen, and can
write over the allocated buffer, overwriting userspace undesired
memory

The amount written comes from the numsrc the caller left in optval, not
from optlen. do_ip_getsockopt() reads optlen once, to check that the header
fits, and then reuses the variable for the length of the reply, so by the
time ip_mc_gsfget() fills the source list nothing remembers how big the
buffer was.

The copies go through copy_to_user(), so this reaches only the caller's own
address space.

setsockopt has had the matching check from the start:

	if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen)
		return -EINVAL;

Clamp numsrc to what optlen holds rather than rejecting. Another option
would be to reject (-EINVAL), but, that might break userspace _more_.

For reviewing purposes: size0 is the header size, so, the available
buffer is len - size0.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/ip_sockglue.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a55ef327ec932..2e4e19b90645b 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1447,6 +1447,7 @@ static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
 {
 	const int size0 = offsetof(struct group_filter, gf_slist_flex);
 	struct group_filter gsf;
+	unsigned int max_numsrc;
 	int num, gsf_size;
 	int err;
 
@@ -1455,6 +1456,10 @@ static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
 	if (copy_from_sockptr(&gsf, optval, size0))
 		return -EFAULT;
 
+	/* Maximum number of sources that would fit in the userspace buffer*/
+	max_numsrc = (len - size0) / sizeof(gsf.gf_slist_flex[0]);
+	gsf.gf_numsrc = min_t(u32, gsf.gf_numsrc, max_numsrc);
+
 	num = gsf.gf_numsrc;
 	err = ip_mc_gsfget(sk, &gsf, optval,
 			   offsetof(struct group_filter, gf_slist_flex));
@@ -1474,6 +1479,7 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
 {
 	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
 	struct compat_group_filter gf32;
+	unsigned int max_numsrc;
 	struct group_filter gf;
 	int num;
 	int err;
@@ -1483,6 +1489,9 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
 	if (copy_from_sockptr(&gf32, optval, size0))
 		return -EFAULT;
 
+	max_numsrc = (len - size0) / sizeof(gf32.gf_slist_flex[0]);
+	gf32.gf_numsrc = min_t(u32, gf32.gf_numsrc, max_numsrc);
+
 	gf.gf_interface = gf32.gf_interface;
 	gf.gf_fmode = gf32.gf_fmode;
 	num = gf.gf_numsrc = gf32.gf_numsrc;
@@ -1705,6 +1714,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case IP_MSFILTER:
 	{
+		unsigned int max_numsrc;
 		struct ip_msfilter msf;
 
 		if (len < IP_MSFILTER_SIZE(0)) {
@@ -1715,6 +1725,12 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			err = -EFAULT;
 			goto out;
 		}
+		/* Do not write more sources than the caller said optval can
+		 * hold.
+		 */
+		max_numsrc = (len - IP_MSFILTER_SIZE(0)) /
+			     sizeof(msf.imsf_slist_flex[0]);
+		msf.imsf_numsrc = min_t(u32, msf.imsf_numsrc, max_numsrc);
 		err = ip_mc_msfget(sk, &msf, optval, optlen);
 		goto out;
 	}

-- 
2.53.0-Meta

