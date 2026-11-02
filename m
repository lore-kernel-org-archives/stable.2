Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614869;
	b=lXzznsQ3vzEdvbkiEyQVilNyGSsR7/YgtX9Cq5du60frC5yXa6mjK248QbHygqlQror0
	 pTDYf87gVkRyxSd5jTpLUs6U8GwGbCSVI0Ia8kmD9D7s4gANFh0YqcTzZ6TstVGPtiMZM
	 PZyJMElTjJVAsBlfHcerr+lNrR9jbZOLFvuZKpb2c2eLkTzHN7ldxHBAuaJZcp+0Ii7ic
	 cHgAgBDnppUNuRs8fqSNCLwhfRswLDL/1Oz8vSXLMunu8Gw+wCgDnYILAoJO+yLsT7DZR
	 G2PpaxmVJPMfRxmJkBjyZfapQBAVOsvbT9uxMLWbhv5q99WOBGmWQDA4ULg14x5C/sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614869;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID;
	bh=LEFGGTgz7yjASEUA27ZEa9Yb28E7mZRsuhGgiXdVjGY=;
	b=JipzkujaKTYiBcF9s2cumznwRYyUPoqieMywrD73lLU8c7PIXMW9yRtruEsAxDqs2xmD
	 ZaUjagAP8LcJvrEdF3bSeEsg6l04ZXaox/sFRbj9RGbMJuC4GXCk04UwavApTul1Di9Uq
	 IwhpFwGIsA4I29tH6YJI4jKYYpvBmRXHqTkU0K/d4a5PddwlSHN+miZ9mNO6FY5884Zs1
	 AKeAT9YrGi/m0Xw3mot+FBkuP2JHgeuhDvtH582uZVsgPT3H9kHYmklgISy7ajiNf7Q1l
	 lgj3k3nx/leEg1I1ehJaADiWmVZxYPOEijSMn97YdyUCUwFlH7u36eIxqIAuEyLoaTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=hqAkoL83;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB2606A330
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FFB2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=hqAkoL83
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A22Tlux4112660
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 10:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=LEFGGTgz7yjASEUA27ZEa9Yb28E7m
	ZRsuhGgiXdVjGY=; b=hqAkoL83yZWftbTqNwgjluUtqP8RI4VXowF1JAYNrnr8h
	fb3p6URLnH3JH9huLM1O2JXGD+cXGxMzNc73Wb67cAQDbXbz3EwrjMqxurdz0KtV
	tH8Eap1oWFGze+s7cLewPj0Iy1jy0viQ7H6N64Pf6d119fyb+yHZgFQSUFOtbhu3
	lUDJg5FphJvkb7uaSWZlcd3rmqK5sJbl1nlW2leuEwbAVXlt41BabwH5usdDOlso
	pC+Bta2xj7pC1xoGA7af/B240AAzf4FQKhj6zFpE5gPeOSgyAD9fZfe/zaZniTtT
	JD+ZSGzLY+b6mj9XIIW1wMprp9kH9KZIg9XjuM8aA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6r9smh2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:21:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29D3md1424376
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 10:21:07 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-1;
	Mon, 02 Nov 2026 10:21:07 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 0/9] Few CVE backports to 5.10.y
Date: Mon,  2 Nov 2026 02:20:55 -0800
Message-ID: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=915 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX6NfdouNfmUPC
 kIYM64AIyZ2tE7y6QJWtbcwCXW6y2A6GICTZzl3RGrI1miG+kogFhTEiU7/sAIKkDO39G0cxVSc
 RsmyyubTNAABDBIxKWZXwTqWmoP2LkZLMC7thBAxpzvf3wXt/JxV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX4SdYcSi9A89d
 Sqy3L910T+vf5Db+OGusoxH58IbRxTU8/EqP5hdXQbPOAzkJ0CCFNoAA2KGUPfcjTA10D7/Sg6h
 9/FxZOPYDCKzV69wjnnZ49T6BWlwQitsjPeJi2Y1RFxIGivwcblDPpLafl4qfJOvzD2Y3e4WaMZ
 pD46Ec6FwmySwwT1Z+lAQTeQjwq5EveKAUIj7Q+v2ZT4GQGG8SbWVOJDQuovSqXS2Nk6UIcmt9E
 4AhwwtAo7Ot5tPHnk0qTj7DZShZlr/G2Eru0s7e3I3rAfFvlXCyuBkb/0QU2J97lMw50fVgDjlY
 ugoogjoD9GpTpxtyNDEMFe0XX7UOcT3+UVD0n9CVA4zFdkj9MJRyPSN3CW6fB4TK8mT5d/CgWyP
 xcoZ+upnFMRA+yrZxbxSvnT3LZfIV8Aj/q2vbYrGkjV6LnVtsTzwpo73vdQfLnmvLLCEF8wGN8l
 KVckwb/y6OdA04cHZFzt0TRrJfD+boejURL5IdW4=
X-Proofpoint-GUID: AwFErMqF6dekb8Nen_teJG-frQq_uWAP
X-Authority-Analysis: v=2.4 cv=EdZd0/mC c=1 sm=1 tr=0 ts=6ae86414 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=2mhxUGYMmI0o_qw-IhYA:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-ORIG-GUID: AwFErMqF6dekb8Nen_teJG-frQq_uWAP

Hi stable maintainers,

We have backported some upstream fixes to stable kernel 5.15.y.

We have only done overall testing that we do for stable release
candidate testing and not any patch specific testing.

thanks,
Harshit

Eric Dumazet (1):
  ipv4: start using dst_dev_rcu()

Ilya Maximets (1):
  openvswitch: vport: fix self-deadlock on release of tunnel ports

Inseo An (1):
  netfilter: nf_tables: fix use-after-free in nf_tables_addchain()

Koichiro Den (1):
  net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless
    qdiscs

Matt Bobrowski (1):
  bpf: Fix UAF in sock clone early bailouts

Qing Luo (1):
  sctp: auth: discard auth_chunk when skb_clone fails

Sean Christopherson (1):
  KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid
    guest state

Yang Yang (1):
  openvswitch: defer tunnel netdev_put to RCU release

Yucheng Lu (1):
  net/sched: sch_netem: fix out-of-bounds access in packet corruption

 arch/x86/kvm/vmx/nested.c      |  8 ++++++++
 include/net/dst.h              | 12 ++++++++++++
 include/net/sch_generic.h      |  9 +++++++++
 net/core/bpf_sk_storage.c      |  2 --
 net/core/sock.c                |  3 +++
 net/ipv4/icmp.c                | 10 +++++++---
 net/ipv4/ip_fragment.c         |  9 +++++++--
 net/ipv4/ipmr.c                |  4 +++-
 net/ipv4/route.c               |  5 ++++-
 net/netfilter/nf_tables_api.c  |  1 +
 net/openvswitch/vport-netdev.c |  8 +++++---
 net/sched/sch_netem.c          |  5 +++--
 net/sctp/associola.c           |  4 ++++
 net/sctp/endpointola.c         |  4 ++++
 14 files changed, 70 insertions(+), 14 deletions(-)

-- 
2.55.0

