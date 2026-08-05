Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A81F09A5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950397; cv=none; b=i5HnxvmzB8Wl7GSDlL7iRTsEB0/qr1CluPgsMQ8/JU1I7nEPjbzrDRaFgfikxab3a31k0M98HL52PF3z/2enLFvzQNqp1IO6NSAioeFpoV/ttZgoQnTpqUs6Lq/jj5nFnvf7Nvu90ckbTbPiv5q7KETpk/L6cjdLvyVvqsG2ARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950397; c=relaxed/simple;
	bh=rsg8UipBxGJZ+kYm7G81IwBVHM9i+bwpc9ZYzUJD4ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iwn500cHFP5VyFpI68Ksg36/xzMex/ZY2fCO7QUERN5VsdY025Y6z1wLnRYekZc7LFsOBx7EpsVUnsFSyqHhJ3z2vt79d6xLWtvzrniCbgT/iKmX426fcrQB6uwvXL+wwxTMfLY7d71r/dhNphOqOnvJS0WYr3DXORhfdi3DxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=p1AOIXKp; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="p1AOIXKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785950337;
	bh=9iZoB2kumZcpf52NfTQL0hJu3b5vcBsGbTYX+GlOeS8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=p1AOIXKpFcT6SrOIcoeGKoDw4iY0Tei46OWc1iIu4ug3MGynVt+C9lHVpcRop9raO
	 mggIS76B0+ApSvDfom93MSfZKhC2env0XA36cQWxLwAIlYExFcbhNwzz2cIa2sg/1S
	 lx/SKNEXoi29AxJZzc6CJF2TeOwVUlJyzUSw90Po=
X-QQ-mid: esmtpgz12t1785950330t1eb90733
X-QQ-Originating-IP: 3mnO0auOi4hulTy7Izg8hW6s4PQgGQZsL50WC9gXywY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:18:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 258333801053326389
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
Subject: [PATCH 6.18.y v2 4/7] net/handshake: Fix null-ptr-deref in handshake_complete()
Date: Thu,  6 Aug 2026 01:17:43 +0800
Message-Id: <20260805171742.654530-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805171742.654530-1-guanwentao@uniontech.com>
References: <20260805171742.654530-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N4LRzSsm0iU+Sc7BADrcKSD7Max6OgmmKP/x9jvYFo2otoX/ECClOLXP
	A8ulgdGS7/iv7uUhgc+pdSGJIEu0SBol4qfDwt2/lPCuV+uAvG1mkp91+qh/7bwUkp2Jrib
	XYYYPf5of3v8GPYHsUwM0soG8PBLu7VJ1B0QHTK3ifboBM9fvuxOiTGCeAxZrXZ1mz5zctd
	jt5+tIt4v2m/IPwYzslDLMeaPoQpZS2PVIc9szqiEGBMUyoJtxQwfie2ilAKoWLK1muX5jT
	t62RTFjRTDKKdqN/Sue/4VEc16c0MsHJDKiv2Q+fIuMh+CWQ53yw/bg+WODWQOfNpCirDVc
	GQU83MLl+HknRSaH/Ll7WHKDB4vLb3tte7Hl6seCd6dxhltfAd3LxiiVee80GwsbwmNrvvm
	T2w2bEv5gN7hLE9jECkrmRzvl07UK5M+3S85npOagjEeT/Qs8rjIkrQovuok40hyw0b2FMp
	WXcPwVxI2d4480Y/oasQX0//TknpA9EtOVdiunaS2z0TtEl0jHLA6T9hzI1helCJGTKVzyf
	32JTdS08Vvf9Xw5//yPsLEFgk60VWsvrqrCx3EYCT4nWlCM8JSvEYv+WyXLkr1GT6TSiV2q
	xAP0FGKtHyUnRO+/oL71p4Np7YZ2Vu3no3zIwBmARpHWanXHI9wXnIQmck8ffs+iTbiyvNf
	Hgo8qNXtZ0mEK13JM5qDYM4HvsiZbYBGKiYgp8Bf7Tf5gsJIWfgx6ppVgL0Ej6jUGX/g1Wu
	sLzRx0q/MKo+rhUrcMNkHAMk+K1XxI26y/9Abcs1KtMzAZVJqEKaNLU3fhyLfnirJ264L8/
	UMyVvzSvkOukheSBDLj7PeZ9oGPUeeJjD7o7Vm7pEMB4YzdpHFBJIwsi2DV90SLZ2y4o13c
	CLNM3pvX2BKPmUdwtz33b/6bBh31mYDNE5h8blLvbV7vJb3V7xdPfq92+r5J7zkJ6dZj9kY
	gqcIfxb8Pqz46cmbnXG25+JUK8CFYwega23CA16Ar3i5pQq811yEHFcxs7uz7rWTIY7cUgE
	XCiHg6gWWs0hwCqI6qnpugAN6FAZDXz3OdedPRtVbWVcdl+5GMPseQW/HyE68vX96w73l1s
	zky6XUC5p+6Z3NXa19FuP+g9YUh8wyLFPqq5HfnU4ma2yOEAWlbN8b/zky/io8hwA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

