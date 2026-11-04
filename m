Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765024;
	b=P9YnwgBn/sinFlSzyRoqOCALRb0Xb5hzqxAhqCPLL1C94TE8LfXTIT6Xx8d7WakzjXng
	 VGGzv0k6LLfPzF/XtXEfiUfrHQy97y2Ay33vXk0QXaPhxgpY7PIHAcMWuaA5+ZAkAEofR
	 UoBCHU1/8RRxiyiMT4oTQfsMNfrnDOQwLS1V7ppmMxqESU8SL7PYoY0fIJrS93aeg7CRa
	 lTzlZ3CvgriF+F8BhCxKOqs9Vlv2vrWHDL9EoGpdT6fEILdGBIEtVHzjw8GA/1IWy5EOY
	 Iz/YXK4bEqHDdm+y/EFbVEnIiUFTlE/zTOC6NZL505vEHB2bIeeuxbNvtdwRe1ogHsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KG+lk8t5iLyrUOS2NbtRJT3WvLogNx7an1uTy/LT6Vg=;
	b=x2+NsjsvKyAxnXFoLfctjIGs2UFKEksCZb4Jxiaj95WgE0lm9SzeShFwq7bIzldPUiQn
	 qbu39cVH+eXxKMhJpkE3S3oa13MGBfgiwoe7H0fi6cw517k/0eXh0S5oDCGJd3ZN5oidA
	 JQTA3nPhTERw+/U9tW+mRLyJ/0WKgtRRmqPmbPHCYZtb5rynl6km3YzatFRuqgkJ+9YWA
	 nI7w1o7VaqMMQrHh5DRbgmauFbJ1QlNeQN8CPvBjXtDGXCR5M4VMaewGTaWWW3h13f2ba
	 cNE9+ERBMs0CrtpyXMbQMKbZVJf+rmfHsYPdPVNe4nOUq6dkGwGSmdi8YYeC9zKowYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SnoMtK+R;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E9606A334
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 04:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F07E9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SnoMtK+R
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so132105a12.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 20:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793765023; x=1794369823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KG+lk8t5iLyrUOS2NbtRJT3WvLogNx7an1uTy/LT6Vg=;
        b=SnoMtK+R/rrHrDrsLK2qtVWIKElhOe4JO2jvrHWgKbysnET+xtVkftyYA3JBYmy8s3
         1Sms7299ryhraXNqJ+X1NzyaND2LE2tOMZOlkKdbf0Q466cgGhAIQlTSzIBcbYSCICIJ
         amNbB8zhPQPpZ5D7dETshjpfJ7bmr+ebvp+90NmRzm/VaZuAo+klEhj2BWptOW8/lDff
         7rC/v3m3UCXir4/1gZPszbSoU1/EfLOJavO7kRd3+0AisHB32pMGyQO/T9bR8hLzqXnn
         wkwB2d2EPJq3YTR/hOq+5a2tB4sIqwCtwKL7hEIdZe/1WVkxmFCx8iSJR55m+DN2EedZ
         0BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793765023; x=1794369823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KG+lk8t5iLyrUOS2NbtRJT3WvLogNx7an1uTy/LT6Vg=;
        b=CMTJFsF8OcNHCrMfCboqYlRPpF4oAJakX2sAD3sPncq4aU7H/wespAdMu8aKbqwPiK
         KekhjEtNajP+Dgeo/Hd85fJx9M+MytahZghvnw5EdYKy6WEeaZADJ4Qcagz6dLPAcdma
         uuAitbMgRgaljAk21IWRLaR7Ecg13p39Qpd9zh9AiLCUcKjLyt9Kk2yv6zJSPPyd+8ct
         jBPHYcE/exEpzAWfaXkKpzH/oGNrLVof7+cmd1OwIy276GBDvRPktpIrQl/Zyjyo3kQF
         GH2uPIkpvRzhnWGDCLmuyCGEUoiie3KkcYA2QvTy6Db+JiUF+EsocIyOACM8IsvrCA1/
         ilRg==
X-Forwarded-Encrypted: i=1; AKwUvBxAZBb75FzdcBFKBoQxZPXLUZ6Z1RFxpnCnOcRhYrEDJoDg3Qg9CJ3vegCbAbjUmdahyMrKtxM=@vger.kernel.org
X-Gm-Message-State: APuU4Z85MTZRiQYhbgTeS/EyMKRth1NpxTmXRVbeZe8mi4GFhiTnTx8E
	yNp/tqKWRgMtqb7iqev++kobPu9zS+gceb0j5J2TT8S9P1Un7wAeYvst2OwjfSM43KY=
X-Gm-Gg: AYBFou2UYye6eNQTgOFdjGDrv4aTN6uu2XI34Ljtj0irxKiO7rcIOFqfkJUCJoNIuhl
	42YJIQpSoHHTeB9FVBw8xnqJ+Qism9iCxF5IN3L2G+doOBmsjZvEyrJSjHi/XjpZrWwAzZoHLqi
	hhLSN3c63AGbHMCGPNUH6wWd9yhJYLN6Nedwr2TOQF5YMq41mliOX8DenFfqli6aKr4sXJ7z3O6
	vhkvc+qVCw22LeM1sy8FacUL3xVcJwN5fB9LiBXk4heWpfKzZ2BHOuSn05JIbTHCpwkUrUDK1D+
	JgPkEpAU0UhDE4p2JzyQgTQ3IFehQXayWMorMAMzACgsXlR0+JXkRhpy1s+MY/GKAg8Moz5rt+Q
	x3CvpI4CGZ4gJA2CIgZer93yA1brfhiHucZe7NLaU8FVXixVMp2SvMPro3RzgLObc8f+WdGDx/m
	ALxB0+M3g5fvvowfZgwV/qzlxBhB2xnCwmg2a/AC3qXZsWggJq6B9ZgLgX9Cu3vUEBT3ZxFJkuE
	yVPe4sqmbig5EctvAnTMvRm1Cd77pLmyi8AkXzFDek3aaIbUdvGTfTTBv5TC/7u9fFD8f9GmBBK
	6Do7kl4TX4KFcZbF/uAmdvkV8H9JBiz9zFGbXRBJKZQFmjhazlfwj1ZsMcj1T9JYjDURgFRAa3X
	+7SGCt0GCjlKXXRrQTlOfvo+XozUsuxrqSM5w
X-Received: by 2002:a17:90b:5870:b0:3ad:6090:a189 with SMTP id 98e67ed59e1d1-3ae8983e2f3mr11360606a91.45.1793765020090;
        Tue, 03 Nov 2026 20:03:40 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:744:cf40:a7b2:e78f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093d481a3sm1817053a91.1.2026.11.03.20.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 20:03:39 -0800 (PST)
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
Subject: [PATCH v8 4/6] IB/isert: drop the promotion reference when a connection errors out
Date: Wed,  4 Nov 2026 13:03:15 +0900
Message-ID: <20261104040318.1844865-5-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104040318.1844865-1-yhlee@isslab.korea.ac.kr>
References: <20261104040318.1844865-1-yhlee@isslab.korea.ac.kr>
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
index 187759ae644733..980bcc0fb23183 100644
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
@@ -747,6 +748,8 @@ isert_connect_error(struct rdma_cm_id *cma_id)
 
 	ib_drain_qp(isert_conn->qp);
 	isert_conn->cm_id = NULL;
+	if (promoted)
+		isert_put_conn(isert_conn);
 	isert_put_conn(isert_conn);
 
 	return -1;
-- 
2.43.0

