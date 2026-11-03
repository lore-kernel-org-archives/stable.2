Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745508;
	b=ojVtEIX6zD8vQokP+cRe91KcHuZ9nRk+ZydRLGj/J1O4FhhNWTbpaKPyMkohuC3o6tYr
	 jzlAZ+KUrK/F/FOTJcRVtFd4d461SYXwxb+IEIRkcAUNv8Y63kuL2Eo+gUQqY9nx1GYHu
	 ZtMbUTqLJsjdbG8F1rYVwVEeXw0NPPesBZPuQsydBTXvSL/9PWXqI8ezCuRhg7cnbqQqP
	 JBGC/HO8RnsmAcvxCUGtO7nuQCDhe1Li8B3jSxv3icLIQI6wnlCRRgoZOhtMVTgHGPIxw
	 PdsX4ph4ZR0nLBpvFDXyi1utLZEneo/teY4lmPa8sO06sNFsku+US/WU4xJKV9AXqUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CNfhVmOoSlL3wC6OcMbKZaKfB8BCmJy4Z72sfxwNi3U=;
	b=kdAPggQVDESM2QtWdL3GMsoHCWduCTPsEd+dU1amHczqNfoggPx+rpG7yg/Ztylo9ev7
	 O23/iQ9+ZtXH0icGpoLlI54DZbiK0jFjXT7jbXLR0MBdEh+PDS/a4H6rDLiUZtnpUDsct
	 UrWqo0vq34tLvptdVYkpwxzYqLcKWmDnnGNRsl++SC8JUykwZtXiKCq4ltW+qpFDtRwcl
	 uPtY6HuzRTIB9k1F6ErpY7D80nUN1k2pSIl5TF8+kt94y4N67RHemECzI4iREjS+k//WL
	 TzEXS2SGqCeLwHmULoOCK9MTpY6vU//flsAlIPKZwMZXdx0PdSvZVfVfIVixsLEfuLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="fi8h/sIZ";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D5606D813
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F4D5606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fi8h/sIZ
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso65587a91.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793745508; x=1794350308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNfhVmOoSlL3wC6OcMbKZaKfB8BCmJy4Z72sfxwNi3U=;
        b=fi8h/sIZaQkcsmsmGviALRVG91mo3uz5ZdlWhUImjEmIXw4SghMonsnBi2Qlr8Ob6F
         dk5v25/FTscjSg9h6v6LDgMeNMhNlOaDwZLZKaIhOVocIzY9N0Gtq+zl5qioTxkAGmqw
         RzDqP5s1MTwNaRBVmbWf1Q9Hzj6J15yoJ/lr86BuA0DZczhXI62eFoYziub+EK9ZWlBu
         f0AzdcP4SVoL3bv5W4Tnwez4+CEEzoaPhu2PL1AHAKkL5LjAWlq1jnSFG1bxqYsY+Ry4
         JbsK+P0EXHinDusMpYyRy2AmrJmei0Nw4Ui/cJ6SSbhKgH5ITt8y1GLq7kxsI7bJFG5c
         OK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745508; x=1794350308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNfhVmOoSlL3wC6OcMbKZaKfB8BCmJy4Z72sfxwNi3U=;
        b=NkFDlbgtCQhXHvnNCItdh6KyVgkx1aICjhNJaWuGbulFtQzYLzfuiXhBPtfLhbmqee
         YqxIi3kiu+pkS0M0EZGf7ApugOQAns0HPKToIhwv9m769cUrXIlrH0lxDOhBF833obhM
         E9xdP3PqmnYsTprwMDvSUi6aAj0Bi05NHde+GfCji/ZN+aXN/OawxNfhJ8qO18iBFd2I
         zebaa0pEXTZTo1xyQr43poeKToDYack/btcLCdOOyarv3KF4rIdmOPafNQMHdumospXC
         r9wNUovLy7bi/QmUdNrRKzxJ/8pUasQrYt48woXLBL18AqLxLRfL2lYc+tTWbI3MSES0
         xZUg==
X-Forwarded-Encrypted: i=1; AKwUvByPqIC1LTr7dF0U2WyBigPbCgf4JyWMBedsQSr9URgCD9UYL/fH5FuVFFvwaTWFfpEqkMs9xQI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uKp+nUpJFZxtwxnx5+RyjOYe8QjLDTPdLtaZyLmxgY9HHumjR
	WmvRJ9ocSzcpOYt5KZ3FgsGoMPNszsmpzil4WxWH7IupKmUd03Krru+BXnJvAuuUTWY=
X-Gm-Gg: AYBFou2v4vV5NsQ/H2LEkSTGyXMYXc4fk5wTAmm4t4uJiHRXt/JrAhTYukt3TE1JeJC
	2+zCqg+RzoqI9W+FMy3qtD8p+Euen2JFW9LjaiAafEKDG9ZSOs5mwY97MNePT++OYJyfJmORSef
	ACgjqZWxru71YCcv5CTppiWXYGhr9j3b/h1aDW6cava64atg6e/xeBCKoeeTNwMegSxSyLa8bAA
	2mKo2dBzja3wH7Vpzj4WJL4xC7ik4yiTTxBy5+AFUG+mB8N7MulJN+IoDqzZOk9e9dflJWGdTWD
	0eJnii7X+zt22KN740f6G3mx+akGZ2lvQqm7fbplnr55D0meHBskHzwB5MZBnJTuZD1R3RvcJZu
	FZ65R6lMuYtEzPUnKfDnrRg909rBPJrersq8phfcfkT9o4BcAiDToEaw8JKtbzUoIcSfW5lFsRu
	Ra/Md9ey/2VbS8xeAXgbUqm+L+3RE3/Gp01OAdEpy0VxJD7qfoNlxmL8mEqKsdGNwN4zCuh9gOg
	XZwLdFnteQPPFGiJr9OIsGY11vmwXVws6LQtOd+QMv3Joo6toukcBYScy/hVIW9VgKeMlMCTRHn
	YgdyJj7f9cPwVC5jmkwABRdD7g2Dd27WLlIMDoOkME3VibyQtWHOFVkrVjcW/e4PTdPrdiSbPKT
	AkfyC+HQ6RKcNOW9oSLOzFmn4ej6WbuqklEBS/tTyG2/rvHr42JQ+jm+EIQ==
X-Received: by 2002:a17:90b:4a85:b0:3ab:c674:cad1 with SMTP id 98e67ed59e1d1-3ae897994c4mr11801532a91.50.1793745507642;
        Tue, 03 Nov 2026 14:38:27 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:744:cf40:a7b2:e78f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b096b6116bsm223711a91.4.2026.11.03.14.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:38:27 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Mike Christie <michael.christie@oracle.com>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v6 4/6] IB/isert: drop the promotion reference when a connection errors out
Date: Wed,  4 Nov 2026 07:38:00 +0900
Message-ID: <20261103223802.1697607-5-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103223802.1697607-1-yhlee@isslab.korea.ac.kr>
References: <20261103223802.1697607-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isert_connected_handler() takes a reference when it moves a connection to
ISER_CONN_UP, and the paths that give a promoted connection up drop it
again.  isert_connect_error() does not: it drops one reference for any
state.  A promoted connection that then gets an error event keeps one
reference for ever, so isert_connect_release() never runs and the
isert_device reference it holds is never returned.  isert_remove_one()
waits for that in wait_for_completion(&removal_comp).

A REJ after the RTU reaches this path.  cm_rej_handler() accepts
IB_CM_ESTABLISHED while lap_state is IB_CM_LAP_UNINIT, and a passive id
stays in RDMA_CM_CONNECT after ESTABLISHED, so cma_ib_handler() passes the
event on as RDMA_CM_EVENT_REJECTED.

Drop the promotion reference too when the connection being given up was
promoted.  A test-only knob delivered that event to eight promoted
connections.  On patches 1 to 3 of this series the device delete did not
return within 240 seconds in any of three runs, each printed ten hung task
warnings, and isert_device_put() ran once, twice and twice, the first of
those being the one isert_remove_one() does itself.  Three runs with this
patch ran it nine times and the delete returned in 15 seconds.

  INFO: task rdma:206 blocked for more than 10 seconds.
        Not tainted 7.4.0-rc1-NR3-00004-g11e5479fd20e #123
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:rdma            state:D stack:26592 pid:206   tgid:206   ppid:1      task_flags:0x400100 flags:0x00080800
  Call Trace:
   <TASK>
   __schedule+0x180f/0x4bb0
   ? filter_irq_stacks+0x71/0x90
   ? __pfx___schedule+0x10/0x10
   ? kasan_save_track+0x14/0x30
   schedule+0x70/0x1f0
   schedule_timeout+0x1cd/0x200
   ? __pfx_schedule_timeout+0x10/0x10
   ? vprintk_emit+0x200/0x2f0
   ? __pfx__raw_spin_lock_irq+0x10/0x10
   __wait_for_common+0x29e/0x420
   ? __pfx_schedule_timeout+0x10/0x10
   ? __pfx___wait_for_common+0x10/0x10
   ? mutex_lock+0x79/0xd0
   ? mutex_unlock+0x7b/0xd0
   ? __pfx_mutex_unlock+0x10/0x10
   isert_remove_one+0x529/0x710
   ? xas_load+0x1a/0x250
   ? __pfx_isert_remove_one+0x10/0x10
   ? xa_load+0xbf/0x120
   ? __pfx_xa_load+0x10/0x10
   ? __pfx_up_read+0x10/0x10
   remove_client_context+0xa4/0xf0
   disable_device+0x128/0x240
   ? __pfx_disable_device+0x10/0x10
   ? __pfx_mutex_lock+0x10/0x10
   __ib_unregister_device+0x226/0x3f0
   ? __pfx_mutex_unlock+0x10/0x10
   ib_unregister_device_and_put+0x50/0x70
   nldev_dellink+0x28e/0x3d0
   ? kernel_text_address+0xa7/0x130
   ? __pfx_nldev_dellink+0x10/0x10
   ? __pfx_down_read+0x10/0x10
   rdma_nl_rcv_msg+0x29c/0x4e0
   ? __pfx_rdma_nl_rcv_msg+0x10/0x10
   rdma_nl_rcv_skb.constprop.0.isra.0+0x21d/0x370
   ? __pfx_rdma_nl_rcv_skb.constprop.0.isra.0+0x10/0x10
   netlink_unicast+0x68f/0x940
   ? __pfx_selinux_socket_getpeersec_dgram+0x10/0x10
   ? __pfx_netlink_unicast+0x10/0x10
   netlink_sendmsg+0x810/0xf20
   ? __pfx_netlink_sendmsg+0x10/0x10
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? selinux_socket_sendmsg+0x8c/0x270
   ? __sys_sendto+0x337/0x390
   __sys_sendto+0x337/0x390
   ? __pfx___sys_sendto+0x10/0x10
   ? fdget+0x53/0x3b0
   __x64_sys_sendto+0xdb/0x1b0
   ? fpregs_assert_state_consistent+0x56/0xe0
   do_syscall_64+0xdd/0x4a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fe0ecec20d7
  RSP: 002b:00007fffe9d34978 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
  RAX: ffffffffffffffda RBX: 00005621db1ab390 RCX: 00007fe0ecec20d7
  RDX: 0000000000000018 RSI: 00005621db1aa2a0 RDI: 0000000000000004
  RBP: 00007fffe9d349b0 R08: 00007fe0ecfb9200 R09: 000000000000000c
  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fffe9d34ba0
  R13: 00007fffe9d34984 R14: 00007fffe9d34bc0 R15: 00007fffe9d34ba0
   </TASK>

Fixes: 954f23722b57 ("iscsi,iser-target: Initiate termination only once")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 4812dabd939453..712d6165150e3c 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -721,7 +721,7 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 {
 	struct isert_conn *isert_conn = cma_id->qp->qp_context;
 	struct isert_np *isert_np = cma_id->context;
-	bool owned = false, bound = false;
+	bool owned = false, bound = false, promoted = false;
 
 	mutex_lock(&isert_conn->mutex);
 	mutex_lock(&isert_np->mutex);
@@ -730,6 +730,7 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 			isert_conn->state == ISER_CONN_FULL_FEATURE;
 	} else {
 		owned = true;
+		promoted = isert_conn->promoted;
 		list_del_init(&isert_conn->node);
 	}
 	mutex_unlock(&isert_np->mutex);
@@ -748,6 +749,8 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 	}
 
 	ib_drain_qp(isert_conn->qp);
+	if (promoted)
+		isert_put_conn(isert_conn);
 	isert_put_conn(isert_conn);
 
 	return -1;
-- 
2.43.0

