Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEE3B27F1
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184082; cv=none; b=Xzy2Xkw6KIgmqEyxx1HvrzTqIQBR6s6EciLB+hojdS6ZMo1vIEo9m7sOXCI0BJYj5+AY4Bi/ydFWPW1WUFyxEREljQxXyjWkcq2TMU7rlXnRyhA+adM3ZX9ajIPSAX+6wy4h4k1o1m26KH2ne6ArmHQspt+sNGvWD9mrCADsIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184082; c=relaxed/simple;
	bh=xFHh0bIJf7qPd4/M16+w++7kWh4PAw4tK8Sv5d6nr5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbjuWdYzupW00aYQrrZIAceP5SafQjz5qLkNaWJpiAWRijeU1HEQdBi3/zxom/rJuUjRw/ZYNqNwpwCdwtaLvI1CeLLXUxn08eqD67T0BlB3kjnYgvUmVGPrv9NI0/HM3yDzWw0lWigJQG64mauwtOJbMx9fAr4etJVSqU66yP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bi/UB5S/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bi/UB5S/"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BCfg9g2044781;
	Thu, 11 Jun 2026 13:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ASn9wZgqrEwImvMeBp46wn7kh/rVf
	67R1XNGTPiuNU8=; b=Bi/UB5S/r8MtzbnxLD6jXfZWkRqXw2SR3tcgz9o9tEL2D
	/FSN9De/z1IXiW8T40u0Od57zoNqtk8Yb++5AmwPemtqQKV4l6YMig/CC25tlTTi
	raqzd+b4x+RTQDkXxS/L8olcEjrvbgss6FHrIURCYAzHljMdQDzYrP9DKEi47rPy
	cZq2jm4QHnSyJxcOm+tMehJ+qlb1peAschPLLQaHzzpfiVpWWo/SMNtZ/8ENNMvw
	pP6EERph3jLPVrHr9RJ2LRr7ywO1cJTvouLeTawdOhPYvE3GvOVETYQoudrAKgmP
	V5x7DvoGJ3/dT5OV2waSJzt9H/DzPxV3/ZbZvcpGw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eqe76982k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 13:21:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65BDDfwb010913;
	Thu, 11 Jun 2026 13:21:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eqwf3h8p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 13:21:10 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65BDLATH016790;
	Thu, 11 Jun 2026 13:21:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4eqwf3h8n6-1;
	Thu, 11 Jun 2026 13:21:09 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y-6.18.y] tap: free page on error paths in tap_get_user_xdp()
Date: Thu, 11 Jun 2026 06:21:06 -0700
Message-ID: <20260611132106.610111-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606040000 definitions=main-2606110133
X-Authority-Analysis: v=2.4 cv=W6gIkxWk c=1 sm=1 tr=0 ts=6a2ab648 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=Ag6TqXP-0EEkkbMwXSEA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13723
X-Proofpoint-GUID: aAmLR5461sNeaMAyNPMIed3y4532Ofvb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEzNCBTYWx0ZWRfX9VdqEblShuTD
 p8mpzTiktgiJrXWFZ3wfIyQopC/I5+71A966N7+K+qMQTsg4fBC6G404DVAn1/C5g8zwTUqfSoX
 sHANnzSogVVpZoPmIy1ZDj7ab1FYUnpuiKxzTg6w3Fz9l36e1PRCF9zKQNVV4Z0hxUvP7dOvzG8
 f9b+BpDNbmBTUX2Ksa1fAceQqG1+gu6MmJScEDkyJSLLYoWYW/9ewNiDjOyCCXmJUpnTxbekhgu
 3oxm+YSyTRmhWTsdEt/5GMl4mD50QWzzDsWYcnLNBQzfuInQFwB0ymqZgNTujT9kHR+fSWsO9KU
 gk5OjnkO0rk3uj8k7kzRCbVLwucMQ9BKQblRwCuvzBK21hF6OcJY0ImS00PZX2o/ckeb1q0Q3we
 EpKyXvVTkLCuMcGokN+Ql6COkAAel1ZUIHdEUgQCqTADVqom0IMldFWnRAsR84QeBeieF8IskZk
 2m7bx49JBa04XB/hDh9IQm9Q6Yh+uysFUeV0s7wY=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEzNCBTYWx0ZWRfX0wAAqiCJDg7D
 xia+nAmueXDNQisWqv4aetFOikFEtEC1/UssLqY14R/Oo9F3tpxOX4KkaTY7s/brQFmg+30vQC6
 I3Y+uAC+m+J9Mu/al0WWDyiPZO0ZGt2dObeufRrltx+rKGM1qNPQ
X-Proofpoint-ORIG-GUID: aAmLR5461sNeaMAyNPMIed3y4532Ofvb

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit 3bcf7aec6a9d16438f2cec29f5d7c8d5b8edf9b2 ]

tap_get_user_xdp() rejects a frame shorter than ETH_HLEN with -EINVAL,
and returns -ENOMEM when build_skb() fails. Both paths jump to the err
label without freeing the page that vhost_net_build_xdp() allocated for
the frame. tap_sendmsg() discards the per-buffer return value and always
returns 0, so vhost_tx_batch() takes the success path and never frees
the page; each rejected frame in a batch leaks one page-frag chunk.

Free the page on both error paths, before the skb is built. This is the
tap counterpart of the same leak in tun_xdp_one().

Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
Fixes: ed7f2afdd0e0 ("tap: add missing verification for short frame")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260521163230.1478627-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 3bcf7aec6a9d16438f2cec29f5d7c8d5b8edf9b2)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Clean cherry-pick , only build tested.

 drivers/net/tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 6fd3b14273b3..b51ce7af1b20 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1052,6 +1052,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	int err, depth;
 
 	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -EINVAL;
 		goto err;
 	}
@@ -1061,6 +1062,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto err;
 	}
-- 
2.50.1

