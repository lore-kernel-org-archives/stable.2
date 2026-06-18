Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4CE31A065
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813786; cv=none; b=EzIpDo2O6Z+OBzPYpLJRLE0yKuxCyLsTjkoyHN/Tp08ttuT9KVnmQQ4L2+wgGpEkyJ6wNzeECND3qzb0uSTIxTkz94Fxm3RT6PA6UcjZCz94YbC9J1QONeBjnQSmTNDH+dhimOfxSqlAPZItq+02GZEhy77BJ/obMhcKy/3dkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813786; c=relaxed/simple;
	bh=kfnqe/Q3n5Ao6z/QZ0jgr+jJyQOiivIWFH4FIdLoY6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acgjiz4A/OUc/8XqDEbtOW02+qf72jD24HRACHdxYAqdmkgmijPSzw/3MKhM1B3NFnNaPfP/R9Ppa/VFcF/p89OuL3yK2Nfwh+xpNOfP3xooBujjDhpUXTeEVVEh8DF4eVndRit8WJLHWIZ7/RdkTOi8kUVx9TnFzI6rCkKe6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Bg3OXCqF; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Bg3OXCqF"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiCAb4006048;
	Thu, 18 Jun 2026 20:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=WSNXWlACFA4qdSGtwx0yCKg9+/GfhpAcD7LSpktqnLE=; b=Bg3O
	XCqFs59ZNmEd71xsSd1corFGE+1B96iETWxK86jQ8RfIpQ+9AFVYIdFJ9rxu5o98
	77ut1QYGheJBZ4g4Xko2QZe2UKCSnm+gZaIdtV49sz2Hb/UTUiaNUV5/YvI0b7Dj
	GEPecmsIMiN1RrOjKOvhnw/w6x2cKpzR8It3V16wWkmBtZJ7N0esDFXc9pnoWcfC
	op/PjBcoRBCENAFfxY48Uej6Czvl7yVVWGexI6iaZ2o/WvY9NxHdULgKTGCJ8yBN
	yWIAZ2EHUuE6s2ITHZu478+vYDUX1RL0APETeWILdipSq6PudvOcL7cQskGdkLC7
	RTp4yALjXv7jfDGQBQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3jg4nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:19 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:18 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 25/27] scripts/sorttable: Use normal sort if theres no relocs in the mcount section
Date: Thu, 18 Jun 2026 16:15:39 -0400
Message-ID: <d99230ce57a655ac9f9478d03717763f9c16b896.1781809985.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX0VJ5tTX5F0m7
 mhF/nKjc6YqPNpgwRuOHvDDpstHWScM0iAY0YXZeDi1lotJ6wef8j699Eyr92IqRgDTDeEZDDQ5
 FBQLtg/ZJZI2H2qo0XB7Lo6jzNQok5a68WVPX4rjvsl0Akxqvmrp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfXzLdHQBaxoSle
 BxHhgz/TmrnrqNYoOtfcTHR4hm6yWPxg+8Cc8+NbOsW0hYdwUxQC5TlyqEQS4sRW7V5+KMNFXs/
 e6hyoMWdX8JB4kojCHI19WH8txVuIeOsFiOM2ADckp0A+WeH2ntQeZe8e+kWcsB1g9KXUSWH3OB
 jpVla5Txci+KDX/jS/6gxYR75nybrsHGPjcMYE4FYcOI6Q184nlit0gu9ifE+yzymxMBTNLbGio
 cZs2mV991dfPKSNdGl/ESU37Q11493nYQ+WEOeUvbLGB39/Pzyg1yNUycXxZRQpF9FM2GCHJ842
 NVPiJjoHfgeYXJxZyCT3wR3baaOb5L0PbTlEznGr+1kh2XYKZgnlrW+7ct1teOvwV5gIQMPF4KF
 yukHfWdlR65GP1YrJXg/dcfbidQP6w1B59jXC/V/rTv1qaNpB/4wVxtDzbeSMiWvcMEzdZx0TOH
 2VKNfuGy0WWQ1KIElgQ==
X-Proofpoint-ORIG-GUID: 3KQtUwP_vRKMEHLkjC97JY2PcEYRXwMY
X-Proofpoint-GUID: 3KQtUwP_vRKMEHLkjC97JY2PcEYRXwMY
X-Authority-Analysis: v=2.4 cv=AvLeGu9P c=1 sm=1 tr=0 ts=6a345213 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=ZLGELXoPAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8
 a=Z4Rwk6OoAAAA:8 a=pl6vuDidAAAA:8 a=QEzrOnKiztfUOB_tiXIA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=CFiPc5v16LZhaT-MVE1c:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180186

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 46514b3c2c17c67cefe84b0c1a59e0aaf6093131 ]

When ARM 64 is compiled with gcc, the mcount_loc section will be filled
with zeros and the addresses will be located in the Elf_Rela sections. To
sort the mcount_loc section, the addresses from the Elf_Rela need to be
placed into an array and that is sorted.

But when ARM 64 is compiled with clang, it does it the same way as other
architectures and leaves the addresses as is in the mcount_loc section.

To handle both cases, ARM 64 will first try to sort the Elf_Rela section,
and if it doesn't find any functions, it will then fall back to the
sorting of the addresses in the mcount_loc section itself.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/20250225182054.648398403@goodmis.org
Fixes: b3d09d06e052 ("arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64")
Reported-by: "Arnd Bergmann" <arnd@arndb.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/893cd8f1-8585-4d25-bf0f-4197bf872465@app.fastmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 23c7e0e6c..07ad8116b 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -827,9 +827,14 @@ static void *sort_mcount_loc(void *arg)
 		pthread_exit(m_err);
 	}
 
-	if (sort_reloc)
+	if (sort_reloc) {
 		count = fill_relocs(vals, size, ehdr, emloc->start_mcount_loc);
-	else
+		/* gcc may use relocs to save the addresses, but clang does not. */
+		if (!count) {
+			count = fill_addrs(vals, size, start_loc);
+			sort_reloc = 0;
+		}
+	} else
 		count = fill_addrs(vals, size, start_loc);
 
 	if (count < 0) {
-- 
2.34.1

