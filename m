Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614370;
	b=oow7iCG5i5QJna2Y5GJJqDJ2tG/9m97LK/q2DMVQ+tXq+VAFwWNILKU3Sj7H3zGip47x
	 Ku4nh5gvSrfwL4ZmZ4j7qRIUdWgxh+QRMxrnmh6RK3Qi+6isnpkxkD2Xz/1J3g39clLaO
	 QJQ85iX+eUJoI9wJeRR4+r4lwLzPkV1I79lpCxfSUxULwzUzr7vJGO1X2ZO+xzY51DcDu
	 NkVhJTTBZ66QmYP2ThZdNPJnIiAtYlda13LtQWnkaQmi+Z23iczWmRf1VAWi28q12TYsN
	 6fGUeOzRh+qU+maBixH7QbKdsyF12BFAN1SWi0bdYGVnzttloYBQgveyMenLiSJWI8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614370;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc;
	bh=/C9XDvNMYxgafJvnNulDozccad44pBR0l3fqdC0CzJc=;
	b=doTAimb2jn6YCHD8b2YrAviBxq5leO6vTrI3yLp6xdXnPi+iA7eAcXSG8b8Zeks4Csim
	 /lFyPhIC+rdaT95tUFcQvYcsxZvscb8NyU2vTncPsxSmfOuPbv427jZ6rWQmmnkuj3jht
	 jNc7wMC/7Yl35DY3JQ0HLHtbqO4yk1PWdhSnL38ZB82hOq8qYQHJBXnTb5Q/43w2r9qom
	 NWMxZLbQvurU5Z+uB5AoNNZg4Pnpcf8TbHYCxkm1q1LXMp34nGkeCk6c2dhadirYizuwx
	 Dm+PDkKESU+2+wEo+WWG496fU2JbhDPeo9TzuO9jFLUpuF4RQ65sg2R9ZpWKk/6JT2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Un1eIudg;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424F606A336
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5424F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Un1eIudg
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1NF2MU749734
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 10:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/C9XDvNMYxgafJvnNulDozccad44p
	BR0l3fqdC0CzJc=; b=Un1eIudgd4gBrodILnivsKSLc3basbDqwG6dMdwhn+ou5
	yLMKw9U6MXk8F+E20Qx+VFRQ/ycouaEz6QgdSVeIKRm1z7ur1vbYumFxpyAibtPc
	KeJJycGWLRpZvgihrbEHfDWlg62K2+IParN2IwV8jLauUfnVIY4Zc737m4ud7426
	cQwL/Tt6cAedfL2cU3DdwQVdAbrwSFq1KT5f47KBPhA+ktH+8JxbsGT8ZssJwgX6
	ien7JRpjZn5QgfzbhUhinU3WYz4sDVIOOmi4oVrwA+U+KV9TG+hZF+ThJwlvb056
	1U07yXD4ZVAvDD6quoBpOf/wvYvtyzRLPkkpy2VBA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn7431kku-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:12:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CqHk2995664
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 10:12:47 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-1;
	Mon, 02 Nov 2026 10:12:46 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 00/11] Few CVE backports to 5.15.y
Date: Mon,  2 Nov 2026 02:12:28 -0800
Message-ID: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=843 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Authority-Analysis: v=2.4 cv=OpXaWC/t c=1 sm=1 tr=0 ts=6ae86220 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=vFCzHSVkLgEBUF9z9W4A:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: 4We58xZFY6zFPPSDxsrTowMNhW3gZWoR
X-Proofpoint-ORIG-GUID: 4We58xZFY6zFPPSDxsrTowMNhW3gZWoR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXwQ1nfSaVmbg/
 3CWhQnSvpXO6CsXXVvmxO6Xy6UtRv3k/a3mAxtlUOEPp39tqOCgVogXtAiVtjAOOru0PU7NTj2L
 qap3Ie8NSTUmvNzY7r0dY4DBfPj2M6b8BnQ0ALCP64rXYMJQ6HwC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXz/HOxaxaa18l
 ZM9bSepSlNictH/XUikA7Uc0puYDvUiaepvxXPoduDrGst1uiTPJRrTiPceZwJTt/3M54C2lzWY
 d4vOTcXWnjouqa6/duq6y+JV/t5QdDEnhnG04YFaiM+umwCgOlfg7m1+vUM/5Gvm5YylWUs3IhP
 RSvUML9G+7/w+qx4/Vuxokmxm2/WM0SawZlIz2Wk/9z3w9L5dhlwEvuv+9Licxha7LebMUMkrir
 Z4M7gE8ErWaiaG1frMNxuBWiNkSymxSrm1l/raBAYTC+uqCPjDBjq8wYD/MQG3fwh1sfkyVPTXW
 PfBPweEMvXCeoJD9AusQ63CcgirNnmj7gpoO7qKo/H3pLkdXxjLeSN2X4Zxx7a/BPRC3d7XoLmz
 fHM2EsD8RoQl839hJpiLvO1VXVd3A3IDlL4gnPtHVG55QIwWqHyYFFLf6cDcOBOX8z3mu72wUSS
 63/ktcpqYUGX2+7+uVg==


Hi stable maintainers,

We have backported some upstream fixes to stable kernel 5.15.y.

We have only done overall testing that we do for stable release
candidate testing and not any patch specific testing.

thanks,
Harshit

Christoph Hellwig (1):
  xfs: remove xfs_attr_leaf_hasname

Duoming Zhou (1):
  cxgb4: fix use after free bugs caused by circular dependency problem

Eric Dumazet (3):
  ipv4: start using dst_dev_rcu()
  net: dst: introduce dst->dev_rcu
  ipv6: use RCU in ip6_output()

Inseo An (1):
  netfilter: nf_tables: fix use-after-free in nf_tables_addchain()

Matt Bobrowski (1):
  bpf: Fix UAF in sock clone early bailouts

Qing Luo (1):
  sctp: auth: discard auth_chunk when skb_clone fails

Sean Christopherson (1):
  KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid
    guest state

Shiming Cheng (1):
  net: gro: fix double aggregation of flush-marked skbs

Yucheng Lu (1):
  net/sched: sch_netem: fix out-of-bounds access in packet corruption

 arch/x86/kvm/vmx/nested.c                     |  8 ++
 .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  |  2 +-
 fs/xfs/libxfs/xfs_attr.c                      | 80 +++++++------------
 include/net/dst.h                             | 16 ++--
 net/core/bpf_sk_storage.c                     |  2 -
 net/core/dst.c                                |  2 +-
 net/core/skbuff.c                             |  4 +-
 net/core/sock.c                               |  3 +
 net/ipv4/icmp.c                               |  8 +-
 net/ipv4/ip_fragment.c                        |  9 ++-
 net/ipv4/ipmr.c                               |  4 +-
 net/ipv4/route.c                              |  7 +-
 net/ipv6/ip6_output.c                         | 27 ++++---
 net/netfilter/nf_tables_api.c                 |  1 +
 net/sched/sch_netem.c                         |  5 +-
 net/sctp/associola.c                          |  4 +
 net/sctp/endpointola.c                        |  4 +
 17 files changed, 102 insertions(+), 84 deletions(-)

-- 
2.55.0

