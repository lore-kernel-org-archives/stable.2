Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0544AEBF5
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823265; cv=none; b=taRZxbn3S5sswNMQOzCqGcdSpDPsfb4ZIFCIMlP/QkB7QWXpZJewP9PGcFeupG3w0MKVoYfwiLEHSl/CHABFkeTN6rVH6fqB1AlLaPHkWCSkg1PtwYJvOhnHNO+Bsum8k1G5WDlNE5dymyqdl6YC1hcbD7NbemXm44FG3J3yUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823265; c=relaxed/simple;
	bh=ZTdKU8hqQxR+1tUK0SdtMXHF6MVVOYO29Z7GXScvzSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xp+Anen1B+mchan6L3juIqA44dyR30kOsOlLcEA3buZm+aUZ0wIXDBZ1YxKxboPx63WpxN2/gU9bumZj8madrwo30nprQpkHtpixEJRE8x2FDycqY/5gP6dmQRIF+FczHzCy94LdOon34UDfNRHxq5ZBShC/EiDUZEji7aGFGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RpAVpaAx; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RpAVpaAx"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFRvE21950415
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=EbIVpBvBMwcBF7E6TS9amPzU5Arws
	ZnjUUkpH7GT8ZE=; b=RpAVpaAxVKvblCzcfWR7pT2GJ8cow/uTmg62VIbXAtWLU
	X0fhDYz91hmhj4XEwK7zBJHCujo2wyE/qQs2ATKUkN0pKybSApfdqG9jTxCIWE2V
	bys7NlPd/cSO43/7p5mNeVLG0KnLobhMyHNDZNxvzF9QQ75TRb9WzI1fvO1ZvMSy
	m0h4gwdQtc52WUJ5VUkfX+Yumm6WA2ZGLLxknE66RiVh/oelIrJC5H7NPmTMDLen
	QCd54I+o35Q6XQVnkWqYepvCOx/FijeF0T0vVxWDr1RYziFcX//WFwIh0MdwrDn0
	LsD3H2T1y6yL71Cfa8H5ULTR3dVGc/TM0vdgENglg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dwtak8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CGbonL032864
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btnf190-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:01 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CGf1wQ006762
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:01 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btnf18f-1;
	Mon, 12 Oct 2026 16:41:01 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 0/8] Few stable backports for CVE fixes
Date: Mon, 12 Oct 2026 09:40:49 -0700
Message-ID: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX+jGjCKxMGM6+
 19Va44awIAg4x+Vg458b3vxO/kFAZDYmhpcAuApyKPGlqlamtQXSxBsdUi1dFXkmbkNTFRC2Olv
 UqfQ2ROmW1/8VBuWyTYvXHWGhazfJvqWmOn6nlYEbSO4vWPJuVtXUDANK+QgTzHXvxwbBRGkVst
 0ztQkJrYZzQ7tYu8gIcszO75orn9WX0qvkU4wkf/aWGx75txeW0bpV1f0jLBoBXl9GRv8hT4D9s
 rmqRCPW1VFiulRhT2wvfK0lDgMjM06S5Z/03KUR5j3RqEMhWRhszybc0fa6gYd2cRDuyiVQnJGe
 EBu3/fSkFuKoK+EdHJQN1T3SA+gk3fj+z1hX014RdBhjRhM9+f8E1jWVH/UdgA9VcfONqxql+yK
 xepNazYY/M6qHzGuT+9UhJVw4LhU8wS6knRdBgotgJ2nQU8nRBqYxDDMeEE+7kqiSqvaKexKNrT
 JR9aFBbbx6FNJbCdD/x5cfbHKK20spe3WDAf325Y=
X-Authority-Analysis: v=2.4 cv=Kp7YSmWN c=1 sm=1 tr=0 ts=6acd0d9e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=vFCzHSVkLgEBUF9z9W4A:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: FX-RriWVYk_wxtf1JdIWRjJwKxfnD27t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX8vst25AaIz+W
 Vha0yLP0KP5QqVDWuQXU2crVrw2UMdFl96S5RrJWVncbYMRonvow77ZTloYMLkNjl7x9lnlXPSi
 JDfqcNQOg5KN7Irf7fq7kndsol1cDrYMAoLo9muAKPt4FGjU4Oxv
X-Proofpoint-GUID: FX-RriWVYk_wxtf1JdIWRjJwKxfnD27t

Hi stable maintainers,

We have backported some upstream fixes to stable kernel 5.15.y, based on
v5.15.222. Seven patches have CVE numbers, and one is a follow-up fix
for the SMB interface parser. 

We have only done overall testing that we do for stable release
candidate testing and not any patch specific testing.

Quick summary:

Patch 1 fixes CVE-2026-43125, needed a contextual conflict resolution
because 5.15.y uses an RB-tree instead of a rhashtable for DLM resources.

Patch 2 fixes CVE-2026-31678, adapted to dev_put() and the one-argument
rtnl_delete_link() in 5.15.y.
Patch 3 fixes CVE-2026-46165, needed a minor conflict resolution around
rtnl_delete_link(). This fixes a self-deadlock introduced by patch 2,
so both patches should be taken together.

Patch 4 fixes CVE-2026-23392, needed conflict resolution to place the
RCU grace-period wait in the corresponding 5.15.y flowtable error path.

Patch 5 fixes CVE-2024-26828, adapted to apply the signed length check
to both passes of the 5.15.y SMB interface parser.
Patch 6 fixes CVE-2025-38728, adds bounds checks to the same parser.
Patch 7 is a follow-up to patch 6 that rejects short, nonzero Next
offsets. No CVE mapping was found for this upstream commit in vulns.

Patch 8 fixes CVE-2025-40135, needed conflict resolution because 5.15.y
lacks the BIG TCP hop-jumbo code around the changed IPv6 transmit path.

Please let me know if there are any comments.

Thanks,
Harshit

Dan Carpenter (1):
  cifs: fix underflow in parse_server_interfaces()

Eric Dumazet (1):
  ipv6: use RCU in ip6_xmit()

Ezrak1e (1):
  dlm: validate length in dlm_search_rsb_tree

Frank Sorenson (1):
  smb: client: reject short Next offsets in parse_server_interfaces()

Ilya Maximets (1):
  openvswitch: vport: fix self-deadlock on release of tunnel ports

Pablo Neira Ayuso (1):
  netfilter: nf_tables: release flowtable after rcu grace period on
    error

Steve French (1):
  smb3: fix for slab out of bounds on mount to ksmbd

Yang Yang (1):
  openvswitch: defer tunnel netdev_put to RCU release

 fs/cifs/smb2ops.c              | 15 ++++++++++++---
 fs/dlm/lock.c                  |  2 ++
 net/ipv6/ip6_output.c          | 35 ++++++++++++++++++++--------------
 net/netfilter/nf_tables_api.c  |  1 +
 net/openvswitch/vport-netdev.c |  8 +++++---
 5 files changed, 41 insertions(+), 20 deletions(-)

-- 
2.52.0

