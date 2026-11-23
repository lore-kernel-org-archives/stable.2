Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410377;
	b=uNpo8+0YSAglJuMXJPwJLAXccfYL+oVd7MwEicbUxjdEzu+5lM7fWLGa9G3qFus0UE7V
	 ZJIcdso8NJRwfg02IqSnH7m3lCYwEWI1a9U+Hd2D2wJdoA/I45CnhoVGHdiEe+7ykhwfF
	 ym3YXncp6BQGjznboGsajOGrrmZEG9xj6+vtvKp7kwWdhSd3dt7CVNXUFljsi2tLiM3q9
	 D1CptAG3FGYLMlE1K1hHgVhKfJWink4AjUsqJvSzNIclQpbBZD7vSCeq5vjtUL4l5SZsJ
	 4ofqaX7DAUOrnm+9WXWhZPQt6kkyU19kll+H6Wy7AmZMxdE1YhAUnE8cySoge6NNQCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410377;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=6J6EnRC3kLUDOIVWgNkPUrxRZlq6bOeFuE4yVWYWP1E=;
	b=MkQxvBVeR+ikWMXxewINACKBuCidAojyTH0f+UXH+8ZppDhKErDFPJ1/kuSbdWjacEkL
	 2klFTomyh++A6HYItVMcF7K59NZ3HUgJC6hHcIJzVcWOdCr4miD1rvq/rfTFS5cuXbrSi
	 FXdnG/sUjcrR3vGAor5HsazULf6oa3KBTtBXZmEiWzFBbbxZPndnRDyNWZZ9reO21OoCm
	 3QySSxejyavjkqcDCtncoHZ4LwaZuMDCdwRVrqlDwRCJ3c3LugVhd81vKsmQCxKF5O5I4
	 mBHa95oUeFsM3l7lpEodRc5/1MW/wMFqesEbX7CNoKlmdd8LLm9L9ChRSlHEWmZLJow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=j4ioHfd7;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=b0wWkhLv;
	arc=none smtp.remote-ip=67.231.153.242
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9F606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A9F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=j4ioHfd7;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=b0wWkhLv
Received: from pps.filterd (m0355791.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMMFutW1879178
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=6J6EnRC3kLUDOIVWgNkPUrxRZlq6bOeFuE4y
	VWYWP1E=; b=j4ioHfd7Wn7gbVnK/Pq56qlz0lFtnb52j4gYIfH2WBZ/alO6ByvB
	V3HPxL93cUgtXTKRSWeG/aOfHQf4kAWeRzMV8HCZXVzWeOAb0MvjnitIb0jCJDLE
	+k5lU/DGkdaAarXnsEfPeiAcuW9KxKDiFQqLAChZ5+O/ufcerhGIeGX3I7OzMV03
	l7Qav+r3ACXZKYi6r2axjPA3ftd5AOtpQZgfYcHYj1zEBtyvEckPdRYUFfYkrrMk
	vxbAloKl2eX7B9Xptb1PCIM+olPSHYWcwRkEv9fiq+hRYKX4LOtp7/ihv24O3SV5
	uRcbPuG9SnJfz0hCeL8q++fT4wOrIVlu3Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4j491pk7mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:06:08 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9213659143bso58545236d6.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1795410368; x=1796015168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6J6EnRC3kLUDOIVWgNkPUrxRZlq6bOeFuE4yVWYWP1E=;
        b=b0wWkhLvjaaFrYXP4w19XyWiVp9uBdQ8sgEHr6ywIImiu2D6H6qPTmcaFKOHuHix//
         g9u8PEkn4IkAGPPJkNyGv0P1sNc9bxMWgiBMzSYklAEIQKopOf52BB52QT+yWNe0vpDW
         +16LP9AvyjiAzFABYIT6KMkiNelgi/ZJpqHut4TQg9N9o16/QE6kjExYxpfIwzpz9mzR
         53odBcyTc/TQVd7TA+e+8p7bUB5smHfOj3YlK0jY4h+cXO5vygnociKKn7f2+khLne/P
         Uv+Jdras+tKKIOa29416DievaKI619Xuv4KtVdSA7qyWptUanMScxeWh5S98buCbS1lD
         zRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795410368; x=1796015168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6J6EnRC3kLUDOIVWgNkPUrxRZlq6bOeFuE4yVWYWP1E=;
        b=XJNtc62l21D3uNk1nR/3QxEgauhRBkmYY+RfrLs7f/it6Pa5FXpOK75qVo8PKnrFhI
         BJpOCZb8MhYMr9c4haYmeGDNr1UQzxYi7HslCKloqoChANiniJvrrvDnomDBkhPhfAeN
         o3W+aS/FkMoK+c+IEv2J8gOarYCMAtTa1vbOfq/wXVH1StWGfBLYvnUqijKyBsu9BnAM
         c6H631zVzr1LMvbEnlO42VaxXFmcvuImmk5yllgAvGJ60J8ILRxFaZBjcF8lkhn1HJLf
         nVRpBss9A07ZlagcV61rsU0W2noKvpUEfSYzVXQfJteulczTAFtTPbsWdLmDHrz7lZZu
         I8Tg==
X-Forwarded-Encrypted: i=1; AL+hErEdk1e/9RXL5psZ/ai40yQedjilFH80OKf/YpKf2BSXgR6EMVcds+BIHDey/aJOTnRibThqCHI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wUDA3wX+ilHPsed+v1gv8mbFnA5Ahdkj9wCdx6mW0TJiyPyDB
	C4ms5yfvDeB1584TN0SChpJrmG2kVi7WyhAZjR5s28FNtzPvH5VQ/IZahQjfPQI5eZrYKmJpegC
	yYpRPuwth9Vle7E1lapHivsn8hLn/RdBoY+UhFTFlKtfFO+YOwiEOVcw=
X-Gm-Gg: AZFdTZeLNjV9ju9SDiY8t5Xzwm6Ovbi2AJ3CMSzVRxThDdG1xF9dW3ZfXsKbbFnlZgi
	0ar1phtPjckwVX5TatmEQZBzI7WIiIvT08NbOdRRpYvXlvo4yRBYRhvkrFFjhelulgwsVd0X37s
	bVju8TKqQsK0hY882ODCmHYaUPUs/8aaLeTh0+Y6HHGQqKpQHIzauJPuYHqZkcmhzOAsCayT79X
	PivZL0vB5lVupXBZXN7CDUfH2s3310/SRUw8VZ8Pwx70gCpYrewasbgEW14H4IcvYSJYZYFQua+
	QhgJg58ZoCToN+5Fs4K8DFfYYBEjbzt9ex95IaaZwj4XVPZ7xHbRsfb3XCRvvSZ7kqH0fiaGmKr
	7EyEEKj4FamL5YGXPT8zmmYb5rwROkl5NJmSpov0HvsxGkS3dH9Ldr83Bg+TIAXzWJoja95Mbpq
	utNdM1wPQtfw==
X-Received: by 2002:a05:6214:8613:b0:921:2840:dc7 with SMTP id 6a1803df08f44-92134a5d430mr180874126d6.26.1795410368146;
        Sun, 22 Nov 2026 21:06:08 -0800 (PST)
X-Received: by 2002:a05:6214:8613:b0:921:2840:dc7 with SMTP id 6a1803df08f44-92134a5d430mr180873896d6.26.1795410367672;
        Sun, 22 Nov 2026 21:06:07 -0800 (PST)
Received: from jerrythepro.nyu.edu (216-165-95-169.natpool.nyu.edu. [216.165.95.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a1d948sm95191616d6.40.2026.11.22.21.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:06:07 -0800 (PST)
From: Kaho Jiang <kj2864@nyu.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, co+408fcc361565713f@bugs.sh,
        Kaho Jiang <kj2864@nyu.edu>
Subject: [PATCH v3] ceph: Use unsigned types for snapshot split counts
Date: Mon, 23 Nov 2026 00:04:41 -0500
Message-ID: <20261123050440.223436-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
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
X-Authority-Analysis: v=2.4 cv=CJO/zhrD c=1 sm=1 tr=0 ts=6b03c9c0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=TGEpv/rl2ONqXpz49YwF+Q==:17
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=R6YzIN_bpWbBo3jmtC1i:22
 a=VwQbUJbxAAAA:8 a=rCkX3SQkd4zC8Pg9OjUA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: cO7D_fd6k44RsnSsaBOas0lXiK_4OF6v
X-Proofpoint-GUID: cO7D_fd6k44RsnSsaBOas0lXiK_4OF6v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX9b+dxpzgt3os
 CUfRLPHY9fcJKgacmDn54jgkTvQXQe4Hw/lGGcjOXQ+j51llZFYR+NSmRPpMwYQSW1rg194dlEG
 4/K4yKA7sSCDCunUhKDv3ABBt39UNwM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX23oQGoNp5UBl
 FLW+OE1V06KvElV7FY14hXf0C/bHGUz+2i98RpDO3OF/RJzySLfMkQX0cRGBV0wVwKl/75Aj7kK
 xOejRPJr/TH65kT6Ic1NSM47fvi2Kcd1ImuOgKaIrfnzYOqqkQjA0MZYot8FzuxINyPP39F/SAL
 OCD83DeTzHdKTxFwtwc1k7WiGef89vNw5VqIl20zex0hG4M/sm4Lwgz8Ksw7jTX2dEQ9ARedBk1
 pS9pSXi+KkDK4VLZuab4hzhabWfRLpeVpdGDQ17cKOYA/Gd81RUTP2zOz6b1Aekk45JMDNuuKKc
 rfVRuT+Yr6XLCZgSjbZ3f0pAbozZTiAkZ6H9GW4HPIaZXxnjW+b3+rQYgT6ZJPO8/5XjG9/GdFm
 vJvbphCzBfiF4cZ1Wulrt5mQoCoviZq98A4K8pwe3rQhJuz5Pggji4UYf3yl+tY3jEuVChEhpQw
 DyGmpNSiR7GR84JyL8w==
X-Orig-IP: 209.85.219.71
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230019

ceph_handle_snap() stores the unsigned 32-bit split counts from the
message header in signed integers. Values with the high bit set become
negative and, on 64-bit systems, cause the subsequent pointer arithmetic
to move backwards before the message buffer.

BUG: KASAN: slab-out-of-bounds in ceph_update_snap_trace (fs/ceph/snap.c:815)
Read of size 8 at addr ffff888024f45478 by task kworker/1:3/2220
CPU: 1 UID: 0 PID: 2220 Comm: kworker/1:3 Not tainted 7.4.0-rc2-g7475ea8b5861 #1 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: ceph-msgr ceph_con_workfn
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
 ceph_update_snap_trace (fs/ceph/snap.c:815)
 ceph_handle_snap (fs/ceph/snap.c:1057)
 __pfx_ceph_update_snap_trace (./include/linux/list.h:172)
 down_write (kernel/locking/rwsem.c:1350 kernel/locking/rwsem.c:1356 kernel/locking/rwsem.c:1632)
 __pfx_down_write (kernel/locking/rwsem.c:602)
 ceph_handle_snap (fs/ceph/snap.c:1158)
 mds_dispatch (fs/ceph/mds_client.c:7298)
 find_held_lock (kernel/locking/lockdep.c:5401)
 ceph_con_process_message (net/ceph/messenger.c:1413)
 ceph_con_process_message (net/ceph/messenger.c:1424)
 ceph_con_in_msg_alloc (net/ceph/messenger.c:2094)
 ceph_con_v1_try_read (net/ceph/messenger_v1.c:1434)
 ceph_con_workfn (net/ceph/messenger.c:1576)
 process_one_work (kernel/workqueue.c:3495)
 worker_thread (kernel/workqueue.c:3578 kernel/workqueue.c:3659)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
 </TASK>
Kernel Offset: disabled

Use u32 for both counts and validate both split arrays against the
remaining message buffer before advancing the decode pointer. Use
size_mul() to detect multiplication overflow on 32-bit systems, and
ceph_decode_skip_n() for checked skips in the non-split branch.
Also fence I/O, blocklist the kclient and close the sessions on decode
failure, so a malformed snap message can't leave the client writing
with a stale snapshot context.

Fixes: 963b61eb041e ("ceph: snapshot management")
Cc: stable@vger.kernel.org
Reported-by: co+408fcc361565713f@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 fs/ceph/snap.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index e03d89db61fe..45cd0275028d 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1039,9 +1039,10 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	void *p = msg->front.iov_base;
 	void *e = p + msg->front.iov_len;
 	struct ceph_mds_snap_head *h;
-	int num_split_inos, num_split_realms;
+	u32 num_split_inos, num_split_realms;
 	__le64 *split_inos = NULL, *split_realms = NULL;
 	int i;
+	int ret;
 	int locked_rwsem = 0;
 	bool close_sessions = false;
 	struct ceph_journal_info __ji;
@@ -1053,7 +1054,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 
 	/* decode */
 	if (msg->front.iov_len < sizeof(*h))
-		goto bad;
+		goto fail;
 	h = p;
 	op = le32_to_cpu(h->op);
 	split = le64_to_cpu(h->split);   /* non-zero if we are splitting an
@@ -1079,10 +1080,12 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * child.
 		 */
 		split_inos = p;
+		ceph_decode_need(&p, e, size_mul(num_split_inos, sizeof(u64)), fail);
 		p += sizeof(u64) * num_split_inos;
 		split_realms = p;
+		ceph_decode_need(&p, e, size_mul(num_split_realms, sizeof(u64)), fail);
 		p += sizeof(u64) * num_split_realms;
-		ceph_decode_need(&p, e, sizeof(*ri), bad);
+		ceph_decode_need(&p, e, sizeof(*ri), fail);
 		/* we will peek at realm info here, but will _not_
 		 * advance p, as the realm update will occur below in
 		 * ceph_update_snap_trace. */
@@ -1159,8 +1162,8 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * positioned at the start of realm info, as expected by
 		 * ceph_update_snap_trace().
 		 */
-		p += sizeof(u64) * num_split_inos;
-		p += sizeof(u64) * num_split_realms;
+		ceph_decode_skip_n(&p, e, size_mul(num_split_inos, sizeof(u64)), fail);
+		ceph_decode_skip_n(&p, e, size_mul(num_split_realms, sizeof(u64)), fail);
 	}
 
 	/*
@@ -1187,6 +1190,14 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	ceph_blog_exit(&__ji);
 	return;
 
+fail:
+	WRITE_ONCE(mdsc->fsc->mount_state, CEPH_MOUNT_FENCE_IO);
+	ret = ceph_monc_blocklist_add(&cl->monc, &cl->msgr.inst.addr);
+	if (ret)
+		pr_err_client(cl, "failed to blocklist %s: %d\n",
+			      ceph_pr_addr(&cl->msgr.inst.addr), ret);
+
+	close_sessions = true;
 bad:
 	pr_err_client(cl, "corrupt snap message from mds%d\n", mds);
 	ceph_msg_dump(msg);
-- 
2.43.0

