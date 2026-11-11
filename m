Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.150.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367981;
	b=yc1qspmjna2e0ul84o7HNKCcEJQAUp7DWgcyhFeUlodY+jCOuvl7UXqoX3KndjQmF31t
	 2hTK0je7TYmlblUB1JYjlQBRVKYZ2Rd46SDTvRpyz22Ti87txIh4nik/4z1d4IrWiH32k
	 mT95ZKpQbHIlAySmsLdzRMEydqdf7fGIT9KWDFyZnnHk+2ePT0HeI4MMtkSYC7BcHgF3G
	 RoThQXJGt4vMLW3CevD6AXwnQLqC+SYYOBqc5kXkHiCQMWyGCZ9iypyIyl7DlBg7NBzpE
	 0u9Q4b3rtNkQbrdvCTbTBw88b9mUY3xonsXSJ7hGERdw2v0us4P0GMYxcgXF/L9S7pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367981;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=bQ7xCGeyKivCNLHanIQkVR3eV/kMY2IG8KqwPvVm/cM=;
	b=afZwqL+7Vr19ixLKCme7xWOoeSHAhE1ql9DAbmPAkKbA10WNlhS4URRNtC2c7eVNMs7U
	 no8YBRyLoSCWuCAnvacRKQU7c5DNRp/05L3VYOsq2t+ewKS4dIYY/4qIr5uRlCzayfWVB
	 I4sRgGXPpVHIrHJWfIANSSKGqHxj5OBiXTvaNPnOhoHL/w4LK5F+nLyDjpNiMEyO2SiIE
	 cZZEs6HqqoEF7k4JPfv2dYEyOMqejZk40vYEwYg5Mx+A5pMxhiohLzgWB6Wo0ze2hbL2/
	 uFVphyv97a9Lyca+hegZikWG8KbqsmoGsc8kvWWcQmPVkhQnxiypWi7uu4EPYTCQTRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=v6iMNFcf;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=uPsmbQ47;
	arc=none smtp.remote-ip=148.163.150.240
Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7822606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7822606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=v6iMNFcf;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=uPsmbQ47
Received: from pps.filterd (m0355794.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB1qHTq1253481
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=bQ7xCGeyKivCNLHanIQkVR3eV/kMY2IG8Kqw
	PvVm/cM=; b=v6iMNFcfWrjyl90pLk/uRuozJ2Go+1iAeDdwrlxiLR1pqH5vbGQe
	SxJ+LwDeaezfrmtmCOpyB9Z8gp39d3hZbjRomWPgPmu8okU552Qkw2waE3qMPdsO
	nz+Q53ytBGWVuXJyNWVsnTR4GJSHddCE/R1/F+7fCrvs0Cp1ojfe4C2fHsWHH572
	6Bayfen+GQgz2My+usDvdC+QmM1SGNZO7IgnCOFUw+QhSxAxPxfwXJAQ6u2mv9OM
	HTqltuNDwdjBNSEkSViLg/+49bSA8cxzzxTPmhJwobWBb/0BTVp49llGSQoIAbCo
	8Th4nC14oJHg47HvxPyvpn6mejnYhqigzQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hvb7bc6p3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:32:53 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91ebc622dc8so73170146d6.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1794367972; x=1794972772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bQ7xCGeyKivCNLHanIQkVR3eV/kMY2IG8KqwPvVm/cM=;
        b=uPsmbQ47UIY/FJS/RsCm1j9cJWsT6UksWf44W0uJthuxDbn/9DqBG2RT/dencJlEGi
         uOmpKPw7WSyTglYAjNYkR7JK1ZhUlZdiF9NZi3gCEDaEZBTrpuD4JQddz4GjvfggZqFc
         n/qrUZfv3DDrl4n13wP5UROlDNy3XLGfuTQs9WMa1ZA/qNdWqsJ2AK0vX5D0wrXub4pS
         yF3THlErtlk6xyFRZ20LvnNcFy+oxGVkVgij3q+Bw2wg3WvFD0DpmidXSJIQ2DdzgytO
         5au7W1JDtDoXllGOQdDglUSoNU27hxijDiT0jg72aSbNIQ/Pz51MDCvfMLVE82ogRSy/
         GPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367972; x=1794972772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQ7xCGeyKivCNLHanIQkVR3eV/kMY2IG8KqwPvVm/cM=;
        b=xZ51io9GO3NuCTh8nZuKvwNc5pp+jpXg2zPLOAUoPaVVD5dA+boKyATbJrA7+WRDEJ
         GaxoJwEjNNApLa8cJSFkvXlTg2IbNgfFuitzrXP9UmP3s1bqxR/lZXfcu/WafKYTK7g1
         k7/3JE7OvXYhm5SOrJjPpwWLRqN5oPWqnQhfaUWBL1k7a3GnLZUXeSkef+IMk6K2QqHB
         jjDh43gvrWcANQjhm/Hh8avKlhM5WD5GSFSCM6PIps6bXw66MwHjo2E71HeCNd8JGStJ
         y9be4jZrf9thRLCQsJ7HpJTriHgGJ4bZMYOgJT1HAwKXQdKq1OnmFFBGXi5I+eRea5HG
         fdXA==
X-Forwarded-Encrypted: i=1; AL+hErHfAiLyR79Qs+TCw4Xe3UPykcqUMS+nZxyBpKXL+DkVPGKgfBk0o5KfdsXTmvlZBmsMaUdWUlI=@vger.kernel.org
X-Gm-Message-State: APuU4Z88vfyJHYjS+A2AfqzmIbN2WLDXZ2SX+qfl9wEInpZ7aVEKhYzU
	bJBHlp3VAL/SveYRsn3iamDRoFLJJUWahXnVVo1h5lJrMW9TysQR09cqqlgJdEar0Bd5AZjXQ1l
	Bout97F3KviZzPhF5sY+UOo40z/PFmkTmuJs8Mh9DHSAgZPAN8fNG3bI=
X-Gm-Gg: AYBFou0Amgw+/UvJgKU7OwOHBZUG5MWg1qZ7Zf7CnVrRDgST4Teig+3D+WC3zB0QoUR
	3nrMIPmYBklSOIwdcwjIfza7wDYZXTB5i7hOwXe784+JEbw45KRDsUrRRQ+1lpu4DGIaEyAy41V
	iSMMhK76Gmzlq7vWMneUXzhGmMwqiP+n30t0FGwgOeTEKQCjOtdEAiVw8oPpzk58Cbgvwm66fB3
	q9G4zrJ3TVdeMYNSPfSvm2qesEI5PByXCwmlhnc5YsbJ8GO16M52HRMk2oCLW+hDGIVdjQWMmjs
	tYcSlj8LoaFudXSud80GuyqeJH+d06GKwsprP7p6NqtxBzFCnBuE12YYwaWjh6MOcjKZro33IUK
	pQz90uSFw0hfJhPTrPJYYE1dWSLAMNa89Gjk5iXs5PFHdwbDjzdkalRIpgiE3HXJdi7fuhy4pCI
	Qr+CYqWHleew==
X-Received: by 2002:a05:6214:c2f:b0:91e:a762:94e5 with SMTP id 6a1803df08f44-91f0404accamr24041356d6.14.1794367971952;
        Tue, 10 Nov 2026 19:32:51 -0800 (PST)
X-Received: by 2002:a05:6214:c2f:b0:91e:a762:94e5 with SMTP id 6a1803df08f44-91f0404accamr24041056d6.14.1794367971473;
        Tue, 10 Nov 2026 19:32:51 -0800 (PST)
Received: from jerrythepro.nyu.edu (216-165-95-164.natpool.nyu.edu. [216.165.95.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef051dc53sm37025576d6.32.2026.11.10.19.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:32:51 -0800 (PST)
From: Kaho Jiang <kj2864@nyu.edu>
To: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+408fcc361565713f@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH] ceph: Use unsigned types for snapshot split counts
Date: Tue, 10 Nov 2026 22:31:50 -0500
Message-ID: <20261111033150.847104-1-kj2864@nyu.edu>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfX72irFifDFir+
 g8EKDIFNwoQsKhYC7pRYQpNVInLr4M2a/MjMZh9rmO+g3WMTv9SoB+qT+F4X/D6O4GZfMvjKDng
 zN6sSzZkQTq7tMT5Mt3KsujgJOYTcJ3O++vJY4JRQX2yLT4jc6gQU3BbBvDYfaeDI19eUutFmLC
 /W0f97gBV1WWQsaxN4n9NeK8Rqsi/g5UzWwy4Qrn6Fx1FY56FFfd/wmWRPPgVVAuCtsDzGm7mWW
 5UxvCMppqfiMv5BRLK/FDnffd85kzbB83f32mWOuM1dDM1ycpdIUc3POxsIFLpDz0H4jiJECaQR
 4la5cnpkxBP0wHn2+G6cyDtrwFdIROH8uOt/i5iYqcDjhdWXXM/iEjm7WPtZ/wYy4R9NL8VDpmS
 V9agG+e8HdkqeWVESGsXeRdoTUnvZdeQB+HmKmVvrNktw6Y+HXwo4ZxQ7q61YV4tuCWh01E7h3a
 QTK5fpugUnvxZjWKaaQ==
X-Proofpoint-GUID: RfNsBEifn-_1KSVGO5y8nW3wA5p5J5fg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfX1IHSUKfANGjE
 pK8DqpoXcWo+vY/0Nb18+q8J9EqCdEI+bgs6EPTSojFS8leEe+eQkz5C3Ex6h0wflxPTTXn8nNO
 IRzTDWm0UNp2b/3anZEpzOXjE3IgWjw=
X-Proofpoint-ORIG-GUID: RfNsBEifn-_1KSVGO5y8nW3wA5p5J5fg
X-Authority-Analysis: v=2.4 cv=HdyB3SE8 c=1 sm=1 tr=0 ts=6af3e1e5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZtTe6gSuN0kH6OIYMjA5WQ==:17
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=A3cO9-ABBa8CDv30UOuY:22
 a=VwQbUJbxAAAA:8 a=yYqStf5IHDHNmpx8MkMA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Orig-IP: 209.85.219.69
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110013

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

Use u32 for both counts to prevent negative
counts from moving the pointer backwards.

Fixes: 963b61eb041e ("ceph: snapshot management")
Cc: stable@vger.kernel.org
Reported-by: co+408fcc361565713f@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 fs/ceph/snap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 9b79a5eaca93..7ed782abfbbc 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1027,7 +1027,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	void *p = msg->front.iov_base;
 	void *e = p + msg->front.iov_len;
 	struct ceph_mds_snap_head *h;
-	int num_split_inos, num_split_realms;
+	u32 num_split_inos, num_split_realms;
 	__le64 *split_inos = NULL, *split_realms = NULL;
 	int i;
 	int locked_rwsem = 0;
-- 
2.43.0

