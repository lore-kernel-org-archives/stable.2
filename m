Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.150.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962245;
	b=l4+Yi8k0UTs1xxMpg3Ue2Q3moITQ7NS8dxRU/tVcEWdvdLKlJcx+hludz68EQwQZAJPf
	 LjtX0lyx8NoLZZBS1PC9Hd3i+3/dEX9xtuash/HaezsQy/0RMQN8Fi9Fs3UMIk0yoY2pj
	 +f1NlOIXxs5g9BO3ipMeD8Sl/kHc0UN9CoHiMK7seQwJHmmrDQ7gOJrCqtuTTUOmQTsM+
	 gCwxtPEakPsxz634zapwMgTg2siBL5uXdaBc2rEv655jpjKD7DSehZwweQmX837rIbvmY
	 EqWPZoWxRj+NxCXICKJwThT3+xOXOrdhOPkut7jpzlQph7/WizJ0UoMHAy5dR4qmFkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962245;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=BmH2HJBNU7g56YAYVpbKo3jnFN4guXcX8zC5qVeFtW8=;
	b=GbmOULL2HK2CLaIp/UCTF03/bsTC6MJXwrggHnpF4yIg+m5zVPNTb+1C/jwLkfTEfULy
	 UV8zjA2HlsItdwCkuJKlW/a7nkUXy/9HmofMQL44jRV4kJmuGDgz5BUIHYciqXYksssUX
	 6X8rdknT9LrFOPeBPOmkNt9MjbF/CCajJF0FKyfHWMInS0w5eNJNGgRwRztFZpnz8FDtt
	 VlW68mDn/2oo2NIm5gTM37WmrReP1Qwt1BlcA0M37mKT7Y5VkN3eUIxSVMkWzTb33jojV
	 m8ZYZSF7XpGIZ25ebh9mgDJn1cwlNC0DhG8Mm+uTR1bFuwaHe1999hY0uM7MA/Zz1Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=e13sx5Uo;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=UjE3mKJ2;
	arc=none smtp.remote-ip=148.163.150.240
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74795606A331
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74795606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=e13sx5Uo;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=UjE3mKJ2
Received: from pps.filterd (m0355795.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMYWCx2071420
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 19:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=BmH2HJBNU7g56YAYVpbKo3jnFN4guXcX8zC5
	qVeFtW8=; b=e13sx5UoG1M+/4I/Kpj1YUj79oDw7obH6vaHjTYyK3KmH82/XEJY
	gg/bedyw3LVVo13zGNQfSmtSj5M9+ZoDnNJAuqaK/eQUr9AYRLq18QLe1jtV16Xb
	1gCm7QXQry3nQaN9mvJyY/QibdEZI4MdNCorzd0ayi4Voj85rIlMQiLOfdzMgw2X
	rYHHbziKuLoCouPnajw6E1DHeYrMzDszhygp4w2rIbEXaz4g+893GsY/zLEEj85m
	uXR3nzsbs7oYVM6LV+JXCmbLYWSZtDS3MmP0iS77V3F4vBsV7rsYgBFYyK71NkES
	j4g9gXDLvd4h1ZYZvfgGU59S5XRpEshReQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4j0yu6sgqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 19:37:18 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-947a607ec40so50749585a.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1794962237; x=1795567037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BmH2HJBNU7g56YAYVpbKo3jnFN4guXcX8zC5qVeFtW8=;
        b=UjE3mKJ2KHDLQgcUEQPAtKB8x2CYc26FXgPieugBwPcEHKwyr20qbxc8CPaQOWOzuQ
         4vZNcIJZSVJoc8btUD2OvCKyPR/Hl4MG/ENrEAB+3y5RnMgVupm/J9J6ikoGoK7IlCUL
         zULIOnoUpWPIXCFnY7rK0B48d/Un8DfQoCi3cALZ/UzBNeS9x2AeOyf5hIRoKKB7Osjn
         nLtL4QVoXSLypPtV8l+PgDVtYh4oTtD6JtcDTI/8dM1iALxLa1vK6D5Nhw+4Gm5i0zNy
         z9LnR/FIucETI9ojKvRuA16c7hpxHZohHk5kPXvbbv3ISO/uASZQ+Qubox+yBdddnqJh
         E1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794962237; x=1795567037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BmH2HJBNU7g56YAYVpbKo3jnFN4guXcX8zC5qVeFtW8=;
        b=O4ZzqdJek8AMmMZ621ga8G24jOYwytsvcmTROYqokEU9NXxXUvI0hhz2qutKWpD7St
         xQJHLtF6ojokiHxKORhTFSMmnMPV7IA1j2rAFGCMo4DhEWpmXIuCyEUz6f9c0m3MSD/R
         WMwEF6QCqPvn0DRohGPBYYouHtpAjjF3ND8hH+63F32xPJqzn3/mDmMYM1GgWW01sYmu
         oMJOIxx6MEwQqwagfy3eSwZrAYfguQLOPvQ/ENnZ5Nk/8n3kfeHryu8MkqpOJw+/5W3Y
         h76GXSNQcsCObK4tnqujhbFuAxSPMAFCYcDVw/fKpWSQw5yJ2myCX0o5u4kGXxSmOK6u
         ljyA==
X-Forwarded-Encrypted: i=1; AL+hErHUQPdKdcEDIvdxXCQhYKoOVoOKmSSyk4mb9a7h8PP/SInT/YOmWjrthGxcxdC4NVHcA6eifzo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5mOB21jSyEMRfzdJ105uItNo1YTuIDrJLaeTZHW4WljkR4rHR
	e7DHIIQpbSe2/QgxGPh1la+okURpc2FC451dimDWIJdTUG8j7YZrBidM2IRcEPHy+lokNToELOL
	fxVzWgIbMsE5DzqEi/9rfsSFSvQrQoyVIxVqVf5W0xkJMhELbi3KI1go=
X-Gm-Gg: AYBFou0YRBQeq1FlmDtsmFxYDYfGqxSlml75XvWmjMgJBXpJakBq8ln0uJdHfYWHpI8
	9HsMBYyrlsNE3emQ3oHZ/yajtP1By1YloLCaBg2qSjlA+BTK/FjdGm/bIeu0mHaMd0GFZm2jsHx
	0cuGyVrhXk1//aJhyCAm6crFiJbTZ1kSG+LIcLWrK+9ODAyj52+S2k8CKwQYZEjv/bG25jaWRlp
	Ww2fbWzy4s8atE8c6QNFuz4ST7QWgVgG3y5fHneXDt3QC9Clyxetb6LZ90reBScY2U1/fU/LQPs
	cq5Onck5hTqOvE5nb+3LVmUDlo+hpo62lXFFp1n0UuEtYsMV4HjD1eqwPgY409m9xwFEOKJSy1j
	a5IYlecCCX9wS28kV/n9jTOjdpozFZTr4N8fXXD47LluCYliKGJ4DgVOIoidNlacXpaOPYkpWZY
	6keELcvEpZ9Q==
X-Received: by 2002:a05:620a:700e:b0:949:698f:8be8 with SMTP id af79cd13be357-94999648996mr248098785a.64.1794962237304;
        Tue, 17 Nov 2026 16:37:17 -0800 (PST)
X-Received: by 2002:a05:620a:700e:b0:949:698f:8be8 with SMTP id af79cd13be357-94999648996mr248094985a.64.1794962236622;
        Tue, 17 Nov 2026 16:37:16 -0800 (PST)
Received: from jerrythepro.nyu.edu (216-165-95-155.natpool.nyu.edu. [216.165.95.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7475b8sm51691785a.18.2026.11.17.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:37:16 -0800 (PST)
From: Kaho Jiang <kj2864@nyu.edu>
To: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+a9f1a2fc804a2921@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH v1] libceph: replace undersized receive middle buffers
Date: Tue, 17 Nov 2026 19:36:42 -0500
Message-ID: <20261118003641.1069010-2-kj2864@nyu.edu>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwMSBTYWx0ZWRfXw2v/dpEdeMKK
 2GrXJ5HY0xQZ3kxyTf944kys9ezwlpiRqC1onYhibG/A3m++LT0BjGXnQ9uryOz6Y+fH+hhyZnw
 SWIEj2ihmDHSfODoc9ZgsJYFJIKYsMM=
X-Authority-Analysis: v=2.4 cv=IOCXmQvG c=1 sm=1 tr=0 ts=6afcf33e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=DJxkqqoNvFVJFTNdoq0VCA==:17
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=Lu3rmdZLeA08KL8VqJdF:22
 a=VwQbUJbxAAAA:8 a=6fTL0N-4C1eZiWn3T4sA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwMSBTYWx0ZWRfXxEbwBHyCc4uM
 eKHnSeyX/G7tnpVMhLsCO3XqA/q/RcCM5Z79lCKxwqZS1e+mCqaAZfOV34GfaXcnzsDnz6hBZfx
 ymcoB5fo66QI3vRZ65sZ0IrxGejpaa+odk7YgeXkI8Hj3Hu8PvIY9VMY0o2YVmuZPqOGMK2Kk7l
 ytk7epQOEdO1gnI21IE10WSxbO6zr6BeK/dQeC19fz+TYCUfbLoZpq5QcxLvIrKJ01Kr80FVVxJ
 JBEsa9kkPLD4yrSCL/Kn//Hk7HyGMwICKE5u1rBMKqBnFKbOqoqViWGuqtylumpTv7k8Psbduat
 6kBjHcFVJ1yrvlsyW52TxUOuGhztWXQhBlJ7CFHRkSaQDp9fwkoX9gpSxBIVmp0QIQ76KZW8mAY
 vvu6PftR7aiIgZEGNuZ85ASlaAbMrfLLVqWFa0C52EMAeLqXpr5c7yFaAYA9AxKrPXOZUgSmiDU
 c2FfvEr9eQeqDhLka4w==
X-Proofpoint-ORIG-GUID: mxFv6I9cGkL3uKz3HlFr9MG7YMCoXq3M
X-Proofpoint-GUID: mxFv6I9cGkL3uKz3HlFr9MG7YMCoXq3M
X-Orig-IP: 209.85.222.200
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180001

ceph_con_in_msg_alloc() can reuse a message whose middle buffer is too
small for the incoming middle length. The receive path copies that
many bytes into the buffer, causing a slab out-of-bounds write.

BUG: KASAN: slab-out-of-bounds in _copy_to_iter (lib/iov_iter.c:77 ./include/linux/iov_iter.h:86 ./include/linux/iov_iter.h:308 ./include/linux/iov_iter.h:332 lib/iov_iter.c:197)
Write of size 4096 at addr ffff888023765000 by task kworker/1:3/4983
CPU: 1 UID: 0 PID: 4983 Comm: kworker/1:3 Not tainted 7.4.0-rc3-g666539eecdf4 #1 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: ceph-msgr ceph_con_workfn
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
 kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
 __asan_memcpy (mm/kasan/shadow.c:106 (discriminator 1))
 _copy_to_iter (lib/iov_iter.c:77 ./include/linux/iov_iter.h:86 ./include/linux/iov_iter.h:308 ./include/linux/iov_iter.h:332 lib/iov_iter.c:197)
 simple_copy_to_iter (./include/linux/uio.h:228 net/core/datagram.c:521)
 __skb_datagram_iter (net/core/datagram.c:435 (discriminator 1))
 skb_copy_datagram_iter (net/core/datagram.c:535)
 tcp_recvmsg_locked (./include/linux/skbuff.h:4268 net/ipv4/tcp.c:2851)
 tcp_recvmsg (net/ipv4/tcp.c:2955)
 inet_recvmsg (net/ipv4/af_inet.c:894 (discriminator 1))
 sock_recvmsg (net/socket.c:1154 (discriminator 1) net/socket.c:1176 (discriminator 1))
 ceph_tcp_recvmsg (net/ceph/messenger_v1.c:34)
 read_partial_message_chunk (net/ceph/messenger_v1.c:975 net/ceph/messenger_v1.c:964)
 ceph_con_v1_try_read (net/ceph/messenger_v1.c:992 net/ceph/messenger_v1.c:1245 net/ceph/messenger_v1.c:1417)
 ceph_con_workfn (net/ceph/messenger.c:1576)
 process_one_work (kernel/workqueue.c:3495)
 worker_thread (kernel/workqueue.c:3578 kernel/workqueue.c:3659)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
 </TASK>
Kernel Offset: disabled

Release the existing buffer if its capacity is smaller than the
incoming middle length, then allocate a new buffer through the
existing allocation path.

Fixes: bb257664f748 ("ceph: simplify ceph_msg_new")
Cc: stable@vger.kernel.org
Reported-by: co+a9f1a2fc804a2921@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 net/ceph/messenger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 212e7797f9e4..ccb650708663 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2098,6 +2098,10 @@ int ceph_con_in_msg_alloc(struct ceph_connection *con,
 	}
 	memcpy(&con->in_msg->hdr, hdr, sizeof(*hdr));
 
+	if (con->in_msg->middle && middle_len > con->in_msg->middle->alloc_len) {
+		ceph_buffer_put(con->in_msg->middle);
+		con->in_msg->middle = NULL;
+	}
 	if (middle_len && !con->in_msg->middle) {
 		ret = ceph_alloc_middle(con, con->in_msg);
 		if (ret < 0) {
-- 
2.43.0

