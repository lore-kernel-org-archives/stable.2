Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122726CE32
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105792; cv=none; b=RUPnuhmNcQ9dHIkn5hf45YLkH0smGbksN0crTFU56MkFAYnI2YHn21Kh4e38My3b55JoX0QZzhPIIxxDTsd5dgjgbNHi4QC1cDtygC74HDOnTZW6czrcE7Hb969huwqCNd82VbKVdqFGBL2141Fbz4Ggno6X8hb2ZLBAVq50Uxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105792; c=relaxed/simple;
	bh=tt5fp8eFsnF4QFc0blDl4AhU8ekLKX+4Z2IUjsjHny4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahJpsNAKnBEnfazjnbrJrOhIovs0D5BWhBRFEAW7/Q/jOzf8mYQFX5UOFJLFsnlfkaqjVTFtOaRNo1rsXvhFGknC/jTlo/+6H1K0KwVPnm13u8fp8HNyt/4oj2w9YpmwBCGJQEIYzBRDMm4AEIM36oPQ+hpfu+JokQVBtBANbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSZYwGhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSZYwGhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3112E1F000FF;
	Sun,  4 Oct 2026 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791105790;
	bh=m6dkSy3d16vG/GCFXdY83irgHKz4rC51aMJFcuKvxt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iSZYwGhfNT07lvV4EQoIE5FFn/yGxpN0C+AG+rc1BcGs17bWebuBC1725Qt0y0gNH
	 fxqjweze5o6G+R849Z5yN1J/uBSRZ+1NQ5Tmc4W1pjIpN/3dYU+9ot0nkPu+8nCeVZ
	 t87LaFA/jWH/4Q3WDqI/hwtptMV3Gm+gXExWFse7rGPZGSN7pa5IxCHezDo5QQgccv
	 MvJI0HQ17YUQ7t75iRPC/xu2i6Z0EdCa1qNePcOKM5lM6BYoYCa9BtvQXZRxnY/m1a
	 fScO/aBxnBQSroLjCU+bVOweAboc7K6wVQUu3fyo6ZE1Eu5Z9Pi6pm/2wtLEEM9iM4
	 lQJkzdlNpyVqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] pfcp: fix socket lifetime on netdevice registration failure
Date: Sun,  4 Oct 2026 05:23:06 -0400
Message-ID: <20261004092140.1381743-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100325-dangle-explode-ba36@gregkh>
References: <2026100325-dangle-explode-ba36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

[ Upstream commit 0f17d2e3dd9cda3ee6d94033d5e5489af168920d ]

pfcp_newlink() creates the UDP socket before register_netdevice().
If registration fails after pfcp_dev_init() succeeds, the core calls
pfcp_dev_uninit(), which releases the socket and clears pfcp->sk.
The newlink error path then releases it again, causing a NULL pointer
dereference. This was observed with failslab fault injection:

  FAULT_INJECTION: forcing a failure.
  kobject: kobject_add_internal failed for pfcp0 (error: -12 parent: net)
  BUG: KASAN: null-ptr-deref in udp_tunnel_sock_release+0x1c/0x50
  Read of size 8 at addr 0000000000000120 by task ip/1037
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x78/0x90
   print_report+0x468/0x5cc
   kasan_report+0xa4/0xf0
   __asan_load8+0x7c/0xd0
   udp_tunnel_sock_release+0x1c/0x50
   pfcp_newlink+0x128/0x184
   rtnl_newlink+0x848/0xe44
   rtnetlink_rcv_msg+0x468/0x514
   netlink_rcv_skb+0xc0/0x1f0
   rtnetlink_rcv+0x18/0x24
   netlink_unicast+0x4b8/0x558
   netlink_sendmsg+0x2b8/0x584
   ...

Return from pfcp_del_sock() if pfcp->sk is NULL.

Fixes: 76c8764ef36a5 ("pfcp: add PFCP module")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260924055252.33488-1-xuanqiang.luo@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: Adapted the socket null check from pfcp->sk to pfcp->sock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/pfcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index b07517d4fe2db..01dbdcbcdc64d 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -104,6 +104,9 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 static void pfcp_del_sock(struct pfcp_dev *pfcp)
 {
+	if (!pfcp->sock)
+		return;
+
 	udp_tunnel_sock_release(pfcp->sock);
 	pfcp->sock = NULL;
 }
-- 
2.53.0

