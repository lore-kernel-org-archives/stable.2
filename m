Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B69279907
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813794; cv=none; b=KCobqJoF2QsiAx8WS+BzUtQZx9x2fyrJfRM3z62qnHFSy9Kso+9kHyyhNjX+1jSFEww/WBMxuRIh4mUfh8vlE1ebiZON7AZgGX02LQFzxbo61yYhVonBaSCUyxpcUUeluYX/M2ESLa9KsE5oUX64Ni+EEnHrFrB2bPgRJB5Qbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813794; c=relaxed/simple;
	bh=+ELlO/zDo09CCAc+8RqE/3jj6RRPlKAIpdazWmZKLMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPE3VcmTDTWnZ4g7exUAm+A5mjRhwrhz/IdARmzeAli4JgcUqRl5xQyiKB1xylVmIU2tCvQqvxZKcPYdgYls+ISdgNnXaRz1opzGraGzDArrzErdEiiKmLL1u01H+VhCF5U9T4xWH/m93c10ToBD91ffmFy3+4GymzojMT4+JUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=k3icCch+; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="k3icCch+"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIscCq3950445;
	Thu, 18 Jun 2026 20:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=2ifpJ0sfw1yhLXuaFXAdGM1j3w3q2Cg12ziuwXOzWWE=; b=k3ic
	Cch+PSczyPJDt7oTXV7CQ3ruq7T8bEJTQfThTrTt03bIJKyOzpx2VX3uL0igduxP
	RByYeGtCWhb5Rf8tuKaasGaErxhAYEWxW6eH4S2cYuJesAa22hgDn5i9URlKsNxh
	4M/orFcgygp4Hqwg/jJ7c9vR0pVCqTrjpwEHEunchLM4aEWwi2zcr1MjPmccEJ0g
	QkZJ2XkWTUus8qLuQVM8RpsUt7PKod8/F/NixQiZ076iZNJCsmpkvgRmilmuL0nZ
	SvTFE6fSHGshqjKRDMGM4+v+50TXsErACs2YyKMJ746anMRhaE9BdgXIM9THGwvi
	xTPpqLn4IpY+vQpvQw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4evd10aqmv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:27 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:20 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 27/27] scripts/sorttable: Fix endianness handling in build-time mcount sort
Date: Thu, 18 Jun 2026 16:15:41 -0400
Message-ID: <260290837178d984dbf07c74176f8997b62b42d8.1781809990.git.andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781809906.git.andrey.grodzovsky@crowdstrike.com>
References: <cover.1781809906.git.andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX9PDUafmO3aGY
 xD2jCsxDI70jOGWNMmqxCUp4jbwA3D17187lJExKicvI35uQQDXAfcjVfPSIL/cjDBH516fn/Ga
 9AkJaDEBjFBFbCjiDkRuSnYAw1q/HKEkYAtC7FqQAIu4aENZa6AsiZWUMuEdcUObpHoHbuY43BH
 EcX+QTyVPSdqfQfYOpDKffHB5nJRyPsGNb5IFPzd0+YS1u4bYTKOUyPa64Tv4uQfRHRg8cuUaw6
 WcX5LU+Cz3iIf8UbBdbex8OnX770jh1oGp8itqAFTCgbcsz2u3gBlwNciVrlQvU5fQmIbqQUxoM
 rtW+UFQQiLV0PaWhttckRs+s2QCBXEATYKXtOMVtcBkZHbhlH0QoUmsuwztHIwF5k9xwga+amLM
 ldcfeGhhJya56jgXQ6ydH76/B8T3SfX4s2xyPibkh5UU0UtCyYejbjrMu4gncvMWhiC4YQYMDdX
 IoyfjyS+TiQp9ie+g3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX+pFfbTSp7S/Q
 QRFTDPdVWpB5ewE7QuKDWWtQDb5TLnWHd44aK/Xk0E8IayC/NJg+bu6v7SHRPGfTJ1OCtfJEcKN
 zugcVjrVQ5s5yo6auDmuxl4zJGNWkGis5Yql/n6YyN2Kj0fbj7CT
X-Proofpoint-ORIG-GUID: Dg11wmcDkOJ0RKCtlwPrILpbX3QU2OHY
X-Proofpoint-GUID: Dg11wmcDkOJ0RKCtlwPrILpbX3QU2OHY
X-Authority-Analysis: v=2.4 cv=L7UtheT8 c=1 sm=1 tr=0 ts=6a34521b cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=sCAmtXjBCdk1NZRw0HUA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180186

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 023f124a64174c47e18340ded7e2a39b96eb9523 ]

Kernel cross-compilation with BUILDTIME_MCOUNT_SORT produces zeroed
mcount values if the build-host endianness does not match the ELF
file endianness.

The mcount values array is converted from ELF file
endianness to build-host endianness during initialization in
fill_relocs()/fill_addrs(). Avoid extra conversion of these values during
weak-function zeroing; otherwise, they do not match nm-parsed addresses
and all mcount values are zeroed out.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/patch.git-dca31444b0f1.your-ad-here.call-01743554658-ext-8692@work.hours
Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Closes: https://lore.kernel.org/all/your-ad-here.call-01743522822-ext-4975@work.hours/
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 7b4b3714b..deed676bf 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -857,7 +857,7 @@ static void *sort_mcount_loc(void *arg)
 		for (void *ptr = vals; ptr < vals + size; ptr += long_size) {
 			uint64_t key;
 
-			key = long_size == 4 ? r((uint32_t *)ptr) : r8((uint64_t *)ptr);
+			key = long_size == 4 ? *(uint32_t *)ptr : *(uint64_t *)ptr;
 			if (!find_func(key)) {
 				if (long_size == 4)
 					*(uint32_t *)ptr = 0;
-- 
2.34.1

