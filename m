Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C43CF692
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951724; cv=none; b=j6U0PpTnXxE5PtMVDcW/KzHpxNC/+iKJ6JMv8lW62rTHp9P4MQ4qwkTcqL6lrAJpr7sa3gdJywHhWyTX4GWl1QavJZ5nULwpPQODvXLF9npJ8j6RzXcc3PjfUR7DZKUCitCPZP/gDwCqR8JDRztUUY5+yNllN/suuHNICkMOI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951724; c=relaxed/simple;
	bh=rsg8UipBxGJZ+kYm7G81IwBVHM9i+bwpc9ZYzUJD4ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxcGm23lQ+DLLAzxjGlLtOY/ULCSxUnNs+FIfNHRHepc4B7zMbUjOL8oSYJmypUiLKL4Czhu5qpnP/R5nJMD8fidEkEMOP+bIMLCbI6hz66dxlj2I5Mx/lNmYUXdTjZCKRnuOeS6zT+Vb0KrCnQd4onUoVE1V51O5Guf+ZNpxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Hvf0u9Qh; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Hvf0u9Qh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785951687;
	bh=9iZoB2kumZcpf52NfTQL0hJu3b5vcBsGbTYX+GlOeS8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Hvf0u9QhR63mE6hLGKPKiWsrRXdfjZumfD5mTi7hM8vp0mh8Aq5e9+HLAgbnOda80
	 h63/Jyl6dbjP5/7UovlXyONW1FnKBQGguXOUW9ESnBPe8QOuwD3/+GLv1t46scIVkV
	 paVjMpa3aDM9p6gj+z/4rDlz5vigF7XHObzJKs+k=
X-QQ-mid: esmtpgz16t1785951682tbe493c4b
X-QQ-Originating-IP: IZXO80E0c2RS+D9LV/76uOxKXFP3Y887Z2/XfQsgtDo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:41:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16443814179195625780
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Wang Liang <wangliang74@huawei.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v3 4/8] net/handshake: Fix null-ptr-deref in handshake_complete()
Date: Thu,  6 Aug 2026 01:39:58 +0800
Message-Id: <20260805173958.660310-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805173958.660310-1-guanwentao@uniontech.com>
References: <20260805173958.660310-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MLma/q+g9AdMR+Q876yZMjzprAfw57vH0Itq0GdUVyXJz6sgcT0MVu8y
	A+2p53sVObGRWSO7YLbHUIgpQ0N5POc/pRUEeeTcyJKBNJml3IvCKebkUvv6pliOGrMiwgc
	yyUy3bZVLJYz46y9jAbrDrgxFx1n/EW78qkoWD2S+pG3kHprna1vITdiPEHsWK6dbNM2Bqa
	nvGr9Ie/02IJV+xyUonJQFsRWLSGIy9OyFY94Q/yTlpnWgaNLAuVHUIo43/EaYrcmlXtap8
	lqWZ44VHCTxPl8xUYeE8dOCPGlowpzmb6GGrzlIIkK8QQu/fib6BBRNYbh1k0HNrp3ceOTr
	XliC1HxUG+rVZ//TEUswvcTtQ8OjBV9Y1MJzZFpDNuTf+lpNgmBkS8yP/Qx2r9a2gV1kH3S
	biqcmSkco41fLIjPluAWI75E0Vs0OZT8lOeoK9h3F6ZTUKmLdi/RBp/aV+GO+4wsO19PmbH
	xT935hvGD1CCE1KYR/e1+Kd7wLH7R6sl9z4w1Zhnd35asa3dk9Chbvj29E6xnYi9fVsMwrb
	shpIymddpujEpFrrH28gsj7cBOj+EHqZfMwL0lyUMl1iwK9zV7oGDu0U5XvwHZkXQRfILwP
	Usi8XeObCGvT7TQBFd/9GB3Q5ZS9WNkdT8+5Oz/BxF2awrdE2+FfzmooQvZEOmnhNd/oag+
	pdpYgoyOE63naod7XG5NC5LRcT9ZmBEkbfZesaLvBxmCNcupq884bYclCIPljHltkv0exUJ
	vuHakFx85Bf3qqbp1i3K05VjOAjCcxFGpjQ0xJiKUAsYozAQ9845abj9gkSWVThUnjrABZb
	r7Gpay/wHxaVWWP1mu/i09XQBmI/SLgBwN8Z1UDb5Y/J3wBFxc76NaC162Bng9HlOpidg9z
	MsZhZXjrwY02y8K/uvgC7JdWoNTcuniPM7ZXqGOqqQXJq/lsA0acJt3rZy1jVvaJsrQskfA
	LeEQ5Sl2QbiCNBQ3whbAi9+tZEZog+2NARqjzq/wpwEl8pNHeWd6daP4cyElmqxr/bIgKHt
	9vGJp0VxdviZv5ugs7D6KPJNZ1cYpLnk6hem0V2ychjT3OJQTE5cPN4jnrL2kjS5Vr5SHS5
	kb6EvM0ngjcBi50rGRzIZiTQU/nPjby8NK9ALI4poyQ0ot6OdX2Fz3/2RVQfOiYErT1uPqS
	qgATLHyio4/Sg6UUNWgqwalDEA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Wang Liang <wangliang74@huawei.com>

A null pointer dereference in handshake_complete() was observed [1].

When handshake_req_next() return NULL in handshake_nl_accept_doit(),
function handshake_complete() will be called unexpectedly which triggers
this crash. Fix it by goto out_status when req is NULL.

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
RIP: 0010:handshake_complete+0x36/0x2b0 net/handshake/request.c:288
Call Trace:
 <TASK>
 handshake_nl_accept_doit+0x32d/0x7e0 net/handshake/netlink.c:129
 genl_family_rcv_msg_doit+0x204/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg+0x436/0x670 net/netlink/genetlink.c:1195
 genl_rcv_msg+0xcc/0x170 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x14c/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x2d/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x878/0xb20 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x897/0xd70 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa39/0xbf0 net/socket.c:2592
 ___sys_sendmsg+0x121/0x1c0 net/socket.c:2646
 __sys_sendmsg+0x155/0x200 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x5f/0x350 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

Fixes: fe67b063f687 ("net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()")
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/kernel-tls-handshake/aScekpuOYHRM9uOd@morisot.1015granger.net/T/#m7cfa5c11efc626d77622b2981591197a2acdd65e
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20251212012723.4111831-1-wangliang74@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit dabac51b8102e1643d8e297a8e6948dab190aa4c)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/handshake/netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 7b1d42607ae68..039344979de93 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -126,7 +126,8 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 out_complete:
-	handshake_complete(req, -EIO, NULL);
+	if (req)
+		handshake_complete(req, -EIO, NULL);
 out_status:
 	trace_handshake_cmd_accept_err(net, req, NULL, err);
 	return err;
-- 
2.30.2

