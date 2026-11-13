Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.150.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539007;
	b=WB6TiXmDl2MXNI4rsO7ncTZPUpZkYf5weiqPZNzb5JHUrnvHt6jQZb0bC9UxN5tqC0HS
	 uSjvQeFvWfXgRt0L4NwZlSQN5Fcn4fv4hYjmlhMWOSN3NVK1iKJbNjTsZDxPEIq3tvODW
	 kXhr+ZWFIOHVSVtiOKHThAliN9mSKGv2wgG7rpTORtcKAICYyfFM0AD9Rn263fQNCUw3X
	 5VfobFs0z+MFP/kmC4BKCQ34THrC5lLM1hRV6CuKAwtS89D2suLea6m0tFB/9/Q6mX0Uj
	 j5Q9sVE9XrYZiAKsuLCMIdEUizRpNcwgiqa+UK8F9FoX0dZ4GzBUkNQkLpXaY+WCPrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Orig-IP:
	 X-Proofpoint-Spam-Details;
	bh=UZPdBtWA9pQKMZMHNBUh0eB5Fnnm3slLNwC8Pi8shQo=;
	b=k5kQ2L1butLz4gXwvrQi0KmlDoToL3nkA1unI2baN6Dsbb3sqeWcSZM+TJDDUiahGPdZ
	 oUhm7FcS5FfnyUmoVulvNIh4zigG8qiyL9NY5900/fb9Uka0jlMVJJxGVyqEFeiFGDKNS
	 e+7lVKMMN9xlg9VWjsEmRYWG0IXQ/6rlkYmm1byYydmETfL1vV8yO1XXp3ByDFayivtQN
	 XAEezU2RKXwWD3vAtrlW3hj9tgNAA5fa5IGDHJxlvSGiVl28qikzsJvT98Mf4AYuIgE8y
	 PVe8xr68ALiHac0AyNlFwnfFum5H4QUzy4M7tJukwIN0AhwyunVHII7zQfL1TFf/ZOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=pkgUP0GT;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=R6rAnkXE;
	arc=none smtp.remote-ip=148.163.150.240
Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3A606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEA3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=pkgUP0GT;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=R6rAnkXE
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD1AiFv4002817
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=UZPdBtWA9pQKMZMHNBUh0eB5Fnnm3slLNwC8
	Pi8shQo=; b=pkgUP0GTSqLkHf8q+wXoGyenYuJcwhv/WLF5KOZDx0oedEdUhbJF
	IRUw68ezuiY30hzY1AFFGTZDBvvDM5TaDPpImCICqJSQnnC1FCKzIcAOckZ4oawZ
	uhZpl2jjEOguHwBtltTsDAaOuk5ZvcYSz10Brod3iDGaziRO3ZvcUiG8O6HFNQWf
	2a8yPwJqECVxUKoxRqMDQhNZX+/+YledREEXEvxJNZcA8DU5zAtw5yN+7KPcN//S
	AXaiDczMdiMO02v9TZASFkXHfZMySSelNW5YuUjH1uTPBhjgnne0hPoOUcZMnd0R
	AIZ5poKlDeXY1SjGW8kERH5LbBhXWwGjtA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hwmjxmh4a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:03:19 -0500 (EST)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b0cfe694c3so8859177b3.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1794538998; x=1795143798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZPdBtWA9pQKMZMHNBUh0eB5Fnnm3slLNwC8Pi8shQo=;
        b=R6rAnkXESu2Q363z3aAdgxXzm0eYqZEvsg5siKL0IT0cya/QX2mmHr1bldf02AruO8
         /Vym84hBFwTlbMOTY0GA3jA+R9/1QfJBodGbdqDlvjoe2mVQDhp5t9Ytf4WC7B8wg6ca
         8zwjIR+RR2Bj6lNiNxrGpBmF/CYxDBUVfe7M6ztvpOZwACzydj9H2SGG9WoRagjJdU8u
         J+/JMKFc7TucTWHUQW6Xf1qqeyWQjNGHH2YHBaPxT6+CwF4MDtE2zyL39sYWGSpw+BcR
         W/y6tUIpD/OSyRpG+3b776ce7jzSX4omaA/arFe1JdN6eQ13L/RItsxoSaBEHV/YKiAc
         4MJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794538998; x=1795143798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZPdBtWA9pQKMZMHNBUh0eB5Fnnm3slLNwC8Pi8shQo=;
        b=vXkaJyOMKGzqVYm5z/CvtkLUGab5vBv2Z59iplaiMPr9K2DWBTdi3JoKHdtMmivdNW
         xGFWySnSwtd0t2+EFJkjTZWE0QddXz11PY7+algSU1C2IxJMeod1mcCDzCLg0KDMzBZZ
         AvJcUVlL5VvanmUxpbRqn1z4d/nU5helmIfhzr6BKRPfzTrkuA+XWbT9acA1Bi87OuV3
         aRDpGBbd1LsLUrVAA0FkB9YtV/IYdfP4GZoPZ11CUXC0jsV5pfyIEmBTR6h5p7Xnv2F+
         8ITlDGWECL4s2pRq6Xk6XMWT9Kq3j9i70qlYWDOlvA37s8mzNxl0ESRqrA2wRnySnSjC
         NiRg==
X-Forwarded-Encrypted: i=1; AL+hErFETwkyp8hiu/I8wZNrPO4BvLv7UnxPe5gKp7GOdeEid1iQqowEtMhzuqR9e+KoFglTEjWlEAk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+teT6tgCy0//EwQKdWnFuEyvXKPmn5khFyMaszMnLnBVnvXClb
	Cf6U8U9CMpTKSfqv/4ys+2RxH4NgVetymFNG55bz7KOJyBaNNBQzK8CiM6/rWT+USCl3DmAjSGA
	1k15ix/Mv9P6W8pkVpb5JtYF+3Llwoof/5n7bDSXHFkFo/h3Kf7sOg6o=
X-Gm-Gg: AYBFou0i9tDP/E7CJUnqeTABNRC7ITJV9qjolrm8fo/qnxpn1qCsBqx29dXBtGJv9yt
	5Rjvy8ZYTSBmJtv5LytmnmQGl7h0b7QKLRIxmXEJFqvCBOc7FBWHy7KHk16FUEP1jNe2U7eqRfk
	xYcP9DGH2/GQa61Fr9gRuvNS9vbiLPPyfUqUt52sCyYAgx3NHjhvX9MZvr8nxhHbN3Zix+rsa1D
	5r/xc6U/DyTkAOO4e8Av08RUyOV1Tmtr4mN5YiUUUIEKBOPL4JNk5NWincabq1tzxAz+gOMeDku
	qLQJmu43E0dWUEIvvJ9aOO1t2WArbFz+V9c34/JjyQYNFO+yUO+0KPZDInvyme80eQOBNbDXK0s
	0hsrk3tanhXhHnWDDhzvqYh6IK2eEoS0jI3h2xRc7w3hImKwdw0XU1JFVk47ieZGi7BT3whqfeW
	eq2+Ou1Fy4SQ==
X-Received: by 2002:a05:690c:1b:b0:8b3:7782:6759 with SMTP id 00721157ae682-8b4aa323715mr13793417b3.38.1794538998355;
        Thu, 12 Nov 2026 19:03:18 -0800 (PST)
X-Received: by 2002:a05:690c:1b:b0:8b3:7782:6759 with SMTP id 00721157ae682-8b4aa323715mr13793137b3.38.1794538997808;
        Thu, 12 Nov 2026 19:03:17 -0800 (PST)
Received: from jerrythepro.nyu.edu (216-165-95-156.natpool.nyu.edu. [216.165.95.156])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa99a6a3sm10905557b3.28.2026.11.12.19.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:03:16 -0800 (PST)
From: Kaho Jiang <kj2864@nyu.edu>
To: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+408fcc361565713f@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH v2] ceph: Use unsigned types for snapshot split counts
Date: Thu, 12 Nov 2026 22:02:58 -0500
Message-ID: <20261113030257.1061200-2-kj2864@nyu.edu>
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
X-Proofpoint-GUID: I5muwX_f5uNETYYLZ1K9goZ4yHaixdZO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxMSBTYWx0ZWRfX25PiORvTH+/w
 Z5M4R0yc/2kTieSWQ/aNWBMA/QoyckXIQTCP5ITiEVmblJ5dtL3owhAlbQDA4GB5saa4o2GEqiw
 D1SYGN4Pr1cGlJUG4qsrHl9fv8pK7KLgXjiWK9/D+BNFdEwz2xNG45+nE7lxR8Fn4OS6jRXcVFA
 ztqsjosE8hjI1NTKAaTVh9/fZ9nEK8xHyKdhUdJjXGt+mCMZqZ84q2WTucxk4Dn8E/5vfI5C0f5
 ne3vlcu1MOkmPuircebnMIcx3t+AZBjjxa70Qo29L4CNk73jUuZTR3v7zR0a0PpL+Kfwbyr0fs6
 Dkz+rVZCwAmng0inicOGU/rSQtBsmeMkxXsaiY4IXRoIRunaqWUPK0r2Hqk0/Dek657d6Ag5rnL
 0j6JnaSq3jBNKvBQN8Uzt6rwhP3BuO58xIv9inEnDA3AqcCc/jpTdc0xBUrjZEK2ff6onxNl15+
 Ri7sGUa8U960brDEDGA==
X-Authority-Analysis: v=2.4 cv=W82txhWk c=1 sm=1 tr=0 ts=6af67df7 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=00YF/gXxkIOuibRGLzhWGw==:17
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=T67y4n-0JBmO_r8OIWtK:22
 a=VwQbUJbxAAAA:8 a=09FrV-9A3yaSbjUTAGAA:9 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxMSBTYWx0ZWRfXzxoWqpOtfp59
 MZDw1M1emcSCol0vU0rY06Vm9ct2PkIOGiNjZfzF5Qp/Rj6jNQzROQjapABxYDhxdxJbZWVX6Ii
 /IBWEzkocvomx7A/O5vn5Gy7/GulK5I=
X-Proofpoint-ORIG-GUID: I5muwX_f5uNETYYLZ1K9goZ4yHaixdZO
X-Orig-IP: 209.85.128.197
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130011

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

Fixes: 963b61eb041e ("ceph: snapshot management")
Cc: stable@vger.kernel.org
Reported-by: co+408fcc361565713f@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 fs/ceph/snap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index e03d89db61fe..b7f0db7bb515 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1039,7 +1039,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	void *p = msg->front.iov_base;
 	void *e = p + msg->front.iov_len;
 	struct ceph_mds_snap_head *h;
-	int num_split_inos, num_split_realms;
+	u32 num_split_inos, num_split_realms;
 	__le64 *split_inos = NULL, *split_realms = NULL;
 	int i;
 	int locked_rwsem = 0;
@@ -1079,8 +1079,10 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * child.
 		 */
 		split_inos = p;
+		ceph_decode_need(&p, e, size_mul(num_split_inos, sizeof(u64)), bad);
 		p += sizeof(u64) * num_split_inos;
 		split_realms = p;
+		ceph_decode_need(&p, e, size_mul(num_split_realms, sizeof(u64)), bad);
 		p += sizeof(u64) * num_split_realms;
 		ceph_decode_need(&p, e, sizeof(*ri), bad);
 		/* we will peek at realm info here, but will _not_
@@ -1159,8 +1161,8 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * positioned at the start of realm info, as expected by
 		 * ceph_update_snap_trace().
 		 */
-		p += sizeof(u64) * num_split_inos;
-		p += sizeof(u64) * num_split_realms;
+		ceph_decode_skip_n(&p, e, size_mul(num_split_inos, sizeof(u64)), bad);
+		ceph_decode_skip_n(&p, e, size_mul(num_split_realms, sizeof(u64)), bad);
 	}
 
 	/*
-- 
2.43.0

