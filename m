Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210F37A846
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334605; cv=none; b=Y9Snrq4FIgjf0pNKXrb4hRgVnQ2G4Uyw/4F2/XZCObSht4KxFEB3VJ9uEuSqLStpCv8lkGlw9PeOm8nZY9bOqIMT0bnbS2Egs6Ko+gSFVOC6C6zfckZDVRiiYeerm4TN1tWCqv8G1WNsbiEtPV/dP0RpDv7Yed3wlBMG/od41oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334605; c=relaxed/simple;
	bh=iS1wwt7mtsamIuQdnk7Sk7R+gJV/gKrgDTfhU6DmIMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYVjEek3T4wVXw2JKOGijZt3UXndk5IUr9C/izALBwVc1QEU9AskI4IBWhmmUkuFRlpRbJbGNXXVCO2nzsdAH9WRFle8HZ1Lk4sY/VF+8paOn6fBS5RSbWBo6D5ZdLY/j59NPyYr/qxgTwhd9/eCEDMYpPfs7Ehut00C42lMhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S8GGbfW6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S8GGbfW6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LG1nfC1907093
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=onLHZu5jspemJ98IlbZykAh+E1JAjWFx/0i6Ra+5U
	bM=; b=S8GGbfW6KrvknATiCWnEixnLUE7MV5Beo+z/NahprBzVmQIVuihxbGYEP
	zkGOk3mD+H9vpZdRfVgYuyUQRsFHobYcpf0fVk6EHfnNF6cMJc1TqN2gGZIDPj/N
	mpnRZfntqmVQQSLhWJbmQ4psDUQZiakXmLXK3dTp8JNC9VaeD77mqwNgEDjvury+
	aGKei8NuNaQLb2DDNePgShxawzW9xKWdYbNOGQRqCSqW9eHk1Z7T149x4GmaK+7w
	9wrLs28DDMW/QkBBkjYAz3YqHXfQqxi4Zd5DKf6O/HyIBvpsYMV6SoM5Mix4/r5n
	JSYAFKpotsxPicTQT7MAN3PA0cMhQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4k257-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LHfHSQ005592
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngwu2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LHo07623200278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 17:50:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4900258059;
	Fri, 21 Aug 2026 17:50:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD25058043;
	Fri, 21 Aug 2026 17:49:59 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown [9.61.78.161])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 17:49:59 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 6.6.y v2 0/4] s390/vfio-ccw stable fixes
Date: Fri, 21 Aug 2026 13:49:47 -0400
Message-ID: <20260821174951.3467637-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfX93it0OxwHERP
 tdl+inIbxmV50z7hK+zzwI8g6mfBhQojv3v5RWptA0aOI350m74RKntobUAkFBW71V+qzsGWg+s
 cjNYEOzrzlXAdlUXKjB+AnstGjvHptY=
X-Proofpoint-GUID: LmY28-BIIM1MTdUp-SDBgsh9MGiNdYmX
X-Proofpoint-ORIG-GUID: LmY28-BIIM1MTdUp-SDBgsh9MGiNdYmX
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a888fca cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=0NtYZyUBCNxGb5a0HpYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfXyJEGx0bA3j8q
 W7V3DoIxcbxWjJVdvUw9U77Oh0Zuhd2k/YBjJyaYoydIcRaqHY1bvYcxO8jETCiMffu1WcaN/G+
 EdDJ59uSO34zAg+If7Gs1GPCthMsvr1/05v3rd62fEjH0MqY+b+5K4snvha+ywSZh0+29qj4QkG
 K44vwotTw8nqX8av3/vU9j0pcNHRBNIjoq2lHBXvdR/gdo2wr1qkYJmP6WOMNgfPt/bvvymtdpx
 A8wclXRO+/tEA1P/jFCe9Yzr3ELUbQG1LRxMM77i46eKKd5v/OQrXerbTG23LV7Lg0gRK4/lZzy
 ua+gWP2/AtqcbL7b6mUthcU6D1wuzKfAWRNUb6hTRARPVjRiLz8rq5j2WSsZ4IwHNOGaOyC1o1d
 lhZxJxgXx4ewYBRPK2Sng9nx13zB36c6DVe96H+2//2gIQB1z1F3LEi0cJz6IWfY77mn5z/ijrq
 CchBXjYMqY57Q7NVdtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210138

Hi,

The recent s390/vfio-ccw fixes applied to linux-6.6.y had a build error
on the first patch, and some merge conflicts on three others.
I fixed/resubmitted the other three yesterday, but neglected to notice
the build error presented on the first patch.

Here are those all fixed together (I hope). Built on top of the current
stable queue that includes the other fixes.

Eric Farman (4):
  s390/vfio_ccw: Free all memory if cp_init() fails
  s390/vfio_ccw: Ensure first IDAW remains constant
  s390/vfio_ccw: Calculate idal length based on idaw type
  s390/vfio_ccw: Implement a crw lock

 drivers/s390/cio/vfio_ccw_chp.c     | 26 ++++++++++-------
 drivers/s390/cio/vfio_ccw_cp.c      | 43 +++++++++++++++++++++++++----
 drivers/s390/cio/vfio_ccw_cp.h      |  2 ++
 drivers/s390/cio/vfio_ccw_drv.c     |  6 ++++
 drivers/s390/cio/vfio_ccw_ops.c     |  4 +++
 drivers/s390/cio/vfio_ccw_private.h |  4 +++
 6 files changed, 69 insertions(+), 16 deletions(-)

-- 
2.55.0

