Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615125;
	b=qD7GA5u4M0RNQMMIO82nx60lWWSuC0prLYlx3L6VJ/Vgicp44OoeIRFgMQk1X7oVxeaB
	 Dolll4aPgVWvRS3t/RJ85xe0R5wxu87qkprYE1KypW4/EIofYTyUAgbiCDn6l6AqJx211
	 d3MgoRIF6GjWfX/McKUFqlS2/qZK6BOFMbArMeRs13G9aQiP8IvhhUssgWvyKuIfpYpDI
	 KvaNvrJUcnkzoYO++w+YVoVtVhd2vXq0lnYQmc7g/zCDrEx4QK9EX95Qbh5mmwUO+1VqX
	 P3Ebmiuuoy5Oh/rhW21cV2mZzn+/2hQFN9l3JSX9xmNO2jGDip7WjtM72U82GJ1n6wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QDqMOsDuzil6WajGuk0RdRf8D0CQ7SO9x51N1GbZQdM=;
	b=SumyU4BKOBzfE+KGJgpVfJ+sx67QAUpFXlIIdtIB990ta/aX5TMtx/xEVQmUr9ZSVFpF
	 BuIAStTYUyC06VtGxrqw5Iw5ZlQ2ipb6x1NAgyMu6XbUP1hBvRhjENx2q0pqN4q4vInyv
	 q6IoJWDmvkdxMtvJ3uxPyiUg3F/4yztx+Hc+ZCQuJcNoasKFMTVUOJr3DYJw7CfS5Zs5+
	 6lMOPdxCojSlF/YpoU0qSLtDD0wAYgUvjFZUBUzVavz9mfv5AKXBRPnj7Rb5+zswMG6VK
	 6jT61C05tqi5t8JYtjDVtV1hUuDE3kgh2XlzhkuggWbS8XuUiM1ni7OSeNbHeryydLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b="TYuqt/5m";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F7606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A1F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=TYuqt/5m
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so2664776eec.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1792615124; x=1793219924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QDqMOsDuzil6WajGuk0RdRf8D0CQ7SO9x51N1GbZQdM=;
        b=TYuqt/5mO4PjbfnCRxwcJm7BAZwyqRgmg3wp2FBQnEulaSDO8PG1kkau9TrwwG/4rm
         S54X/KvrMS9ftanemrX+21iKHDVucwkzknh255Dw7twnycP9vUEZrqRsbbDZwXmPkQkt
         kL9NjK5dKf6Fr2cUe9oywBQ442UmXHTvzbL3IJRcSb2SOTFLMItZhRVw8nyLvka7+ENJ
         8pSUlA6e168H6A/u6qwE2ZDguV9Upife7jLXEE2IVYaQfjU7FxjhZXDPmilKpww/F5rD
         vaRFpqIqaJcohE82mXETz77IOXcp5EmcODCg+YODE4SJdZTAHCS2QOp91iygN85PDmBY
         KeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615124; x=1793219924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QDqMOsDuzil6WajGuk0RdRf8D0CQ7SO9x51N1GbZQdM=;
        b=pOMk6zNAzgJAXIAL2ntPlJQRwSdsePkrIw/uXzGOOLU0na2HTjraNk5azvacioGFUt
         bpUP6qU0awQm+gdbLYUh3my5u7IKqv6DUj0GcO++B9n0siX2noVYnjOiGOX/xZQn6Wa/
         LfxtQp/TH8j7cvlWZBoecvWC7h4MW0v1cqZbEew6WibFhS3qCDXxHi9mSIJR7msH8ZgA
         VzH7FXiGqR/DWNJCfdKkxyUCkBlq0+xpraKIg8zMy2O7/AlTGBopX6anlofVWZCAmaW3
         8zXGEJWHgOXS/ik+gE8AtxFj72iK8l6OCBCkVnXGfmczWUiKPlGFrwWdr/5p0veA64yX
         IKeg==
X-Forwarded-Encrypted: i=1; AKwUvBwBsTKtxwU0AR0Nt5E1BVvB/ojFMcZsh4wmx/E+S8T/MEFcNHAQlgYR4GEE1tn43kxj4FKUmUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1tNqEvjTmqVMa5rZPbQk/sR8bu+c020gt3k7oPBJI0Ble4zq/
	DigTnVoC32qJKPByKOAAAhMeNVRVgn+HkiFRso5oPI+YBKImrkoSLu+K9RP7rTv1ow==
X-Gm-Gg: AYBFou2Ro0P85CNUlo35Xfia87qPMJMyoX7SWCFBlf8ReVvEvj1FxXfYS7fkrtlF7Jn
	2lWML2IjFsIy25W+1YNZZ36VZAZOPf/yZLwKEmSSNln2L/ZE2jTBuWO97E3A4ydlYng7dImlKsq
	bfT8q0OTtP54ttwwkW7BIrBaWAhCY8t56hVCNmNHkOGlBn2eO7wDzRduEeZpzckgXebKKuX98EK
	tULESmysmpRNz0663S79x3k7qMQZ5RFnFLANyMQ8+uGKux1U0bvtJps+vbyvZtIIQpybxLTyc9s
	k5zslOKqSvfradI/7cEYky8+ZL8XUZ1hrMlygX8qNYFjPwonLpK/Ngsqizic/th9RV0qdR5XTFI
	mfIHRfYzi8R0JNV7kibuzFuzq67NFLc/Dl7uha01vzFV2P5DH+L9hLcXjTzL8f6+WvhtdY0oKir
	VMHm35snwEFU8WHrPA8HofTDSUs5DyjBVB3nsY4Gy5GcuT3VSREhfYxYMC9pLxe0UA+R5zkjuw2
	E9B1rfuyCLJgqc7hy/ogTITJiI4052CJ/MW+B8MK9mC4lgIhFSIe/dOcF8DgvpOdkVuFQHIPb5g
	x8HUtAH6HMg=
X-Received: by 2002:a05:693c:8955:20b0:339:7b3b:236d with SMTP id 5a478bee46e88-3674cf43498mr4460582eec.15.1792615123572;
        Wed, 21 Oct 2026 13:38:43 -0700 (PDT)
Received: from gio.localdomain (ip68-109-140-205.ph.ph.cox.net. [68.109.140.205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405edd7bsm9857018eec.6.2026.10.21.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:38:43 -0700 (PDT)
From: Giorgi Kobakhia <gkobakhi@asu.edu>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Xiang Mei <xmei5@asu.edu>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Kobakhia <gkobakhi@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] svcrdma: bound check rc_curpage in svc_rdma_build_read_segment
Date: Wed, 21 Oct 2026 13:38:17 -0700
Message-ID: <20261021203817.3898293-1-gkobakhi@asu.edu>
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

The existing guard in the end of loop is not enough for bounding
rc_curpage, because it only checks if some part of the chunk goes beyond
the rq_maxpages.

    if (len && ((head->rc_curpage + 1) > rqstp->rq_maxpages))
	goto out_put;

If the chunk exactly fills up the pages, then len is 0, guard is skipped
and the next chunk makes head->rc_curpage go over rq_maxpages.

Commit 81381d1a90de ("svcrdma: Adjust the number of entries in
svc_rdma_recv_ctxt::rc_pages") made OOB accessible, since it
shrunk the rc_pages array size to rc_maxpages.

Commit d1bea0ce35b6 ("svcrdma: bound check rq_pages index in inline
path") added a loop-top "rc_curpage >= rq_maxpages" guard in nearby
function svc_rdma_copy_inline_range(). The same check would guard it in
svc_rdma_build_read_segment().

OOB write is triggered in svc_rdma_process_read_list():

 BUG: KASAN: slab-out-of-bounds in svc_rdma_process_read_list
        (svc_rdma_rw.c:1148 svc_rdma_rw.c:1197)
 Write of size 8

 Call Trace:
  svc_rdma_process_read_list (svc_rdma_rw.c:1148 svc_rdma_rw.c:1197)
  svc_rdma_recvfrom (net/sunrpc/xprtrdma/svc_rdma_recvfrom.c:1022)
  svc_recv (net/sunrpc/svc_xprt.c:870 net/sunrpc/svc_xprt.c:968)
  nfsd (fs/nfsd/nfssvc.c:919)

Add bound check for rc_curpage in the beginning of the loop.

Fixes: 81381d1a90de ("svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Tested-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 9aaaade99e6e..a98041139075 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -777,6 +777,9 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 	ctxt->rw_nents = nr_bvec;
 
 	for (bvec_idx = 0; bvec_idx < ctxt->rw_nents; bvec_idx++) {
+		if (head->rc_curpage >= rqstp->rq_maxpages)
+			goto out_put;
+
 		seg_len = min_t(unsigned int, len,
 				PAGE_SIZE - head->rc_pageoff);
 
-- 
2.43.0

