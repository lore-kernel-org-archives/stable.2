Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2C4AF9D1
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823284; cv=none; b=DF7q4HmEmjgiubkV5NEUZxMivUCLXhEAuBxo3opkx7RXISYswefLZ2TLGIH44ud+ejTrbhfI6j6yoFKjAbg3eFF50J/m+Wa2miQ2sbYAA8eA54MG+bkfxlJRnNm/e+wK37eu+0HiFbiO6s62lf2tKhMAQHKjANN5V2gvlWpFJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823284; c=relaxed/simple;
	bh=XpqsLmvlhiCjW/mNZXNBtzL8BFxDIwTLPAQxKuobd3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEVgcFwIk1IVcZMTAbyVsGFeWmHvyOoT/TU6hWQb4CeRjmBjjWb+Bz4jrXD7PRXeKAU5Ajt5JEotxsLf0Nwo885Vq/ojJ7InSAJnHFBn7QL+wqJMlivJbJkObtcEslfIlhDqunCVE+dAbGXSOpwDGFoF9/kTiyYIaV8E8ssfbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H/QhK8DH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H/QhK8DH"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFR0wS353416;
	Mon, 12 Oct 2026 16:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=NDCgz
	GOqagViJX3UwrldVCxzSl5RRTZNjLpwpztR4Ek=; b=H/QhK8DH+hS/qwb1pQ4u5
	Q2qW4aAfyMNLfR+ziukXbT0r2FjKrG3+T2pC2vHAjm1Kg9XO+9fIpLxvqqYia1xh
	+AdXpM9EpRvB2rESezYzuYY2Gt+LwdrsvSkhxexL1sn0lsmK9a4bLViGtULTWs4B
	d8Lx8EFK1Ikw5cTIqvm+yCy7vTKfb+1py/pEwMT66+oIkCmTEgKjqX88cGa2Qhv1
	iCXEek1w0I7R7cPsBKCWKqA3NDFDJJo6TBkdBZryH9FtikLRAfh/GgANUsT3JY2z
	NALg3vW4b60ftFflPB+PA7mvQleloX+rX6DEqMvSSvndcYEjJ161Rl1dWIAPqdBs
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7df7tkyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CGboCS032851;
	Mon, 12 Oct 2026 16:41:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btnf1t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:19 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CGf1wa006762;
	Mon, 12 Oct 2026 16:41:18 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btnf18f-6;
	Mon, 12 Oct 2026 16:41:18 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 5/8] cifs: fix underflow in parse_server_interfaces()
Date: Mon, 12 Oct 2026 09:40:54 -0700
Message-ID: <20261012164057.709105-6-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
References: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=N+a8hG9B c=1 sm=1 tr=0 ts=6acd0db0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8
 a=zNV6N4Yo1DPrtWUnA3AA:9 a=cvBusfyB2V15izCimMoJ:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX2DCvVxTVI0AN
 C5TAqfE8vtY+OUQgWB+mdABSjnzKNDH0rJMm+kIxcthfcHxRld/o/Ohi/LoosvgJDuVpLWFJMJQ
 vDZyMOgbOuz+Kwv9pyUjrKAbC3F4ekzQMYs40I2O3IilBkSkzUhCB3r2kQrMyJpPO0yPOt613En
 ifywWp55cvApEklsy2pz8OdpqMCOmgfc5QpbodGSXk3TOlQPJfhqJBU28KLhWQ/T0LZQEV/rh5/
 eXs1HLEJfWFsFVTFhsL3Us17P0anzrmiBRbybAaj5QcRTCyTLmDodp107ntjm/e5ZZH6aai4NDQ
 uFgTJ8kjsNptxNrrMjGlEi81xsywkZozwFqjlZWJRLNclL7k7uNzFtSZY6dqbqa1mVIWOMauZSW
 U0KTvAsTo+kjXnzbfeXFk9OqXWBuSQ/axUnzR06ifrl8kvGMtQdY1KdYkVZ2EJ7qOTa3lTnoNaV
 hOj8NPxPyDVnm2uKsSEdIgeItsUelG+9y6cAc6pI=
X-Proofpoint-ORIG-GUID: 7m_z4jIrriWtDzKEbQzVyAJewGZeksff
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX9dkYg1Lq2L/I
 sBv2ozRQDHONOKytPGzsXhFKpXD8HCMwOC23Kbe4DMHJ3xeDJmFF9kYbbhP9WRzWB7C8bFCErTb
 Ml+tfbOFYblVYlzYN0UtMK5edTODdQ7kNc9ztb7xEIb32NdfvdTI
X-Proofpoint-GUID: 7m_z4jIrriWtDzKEbQzVyAJewGZeksff

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit cffe487026be13eaf37ea28b783d9638ab147204 ]

In this loop, we step through the buffer and after each item we check
if the size_left is greater than the minimum size we need.  However,
the problem is that "bytes_left" is type ssize_t while sizeof() is type
size_t.  That means that because of type promotion, the comparison is
done as an unsigned and if we have negative bytes left the loop
continues instead of ending.

Fixes: fe856be475f7 ("CIFS: parse and store info on iface queries")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
(cherry picked from commit cffe487026be13eaf37ea28b783d9638ab147204)
[Harshit: Apply the signed guard to both 5.15 parser passes]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/cifs/smb2ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 3aaa45375d8b..c38309616e68 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -521,7 +521,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 
 	bytes_left = buf_len;
 	p = buf;
-	while (bytes_left >= sizeof(*p)) {
+	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		nb_iface++;
 		next = le32_to_cpu(p->Next);
 		if (!next) {
@@ -556,7 +556,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	info = *iface_list;
 	bytes_left = buf_len;
 	p = buf;
-	while (bytes_left >= sizeof(*p)) {
+	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		info->speed = le64_to_cpu(p->LinkSpeed);
 		info->rdma_capable = le32_to_cpu(p->Capability & RDMA_CAPABLE) ? 1 : 0;
 		info->rss_capable = le32_to_cpu(p->Capability & RSS_CAPABLE) ? 1 : 0;
-- 
2.52.0

