Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996F3822A5;
	Wed,  8 Jul 2026 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542150; cv=none; b=MfRNmXtXOqzsclOoYlDanDM9t3BSky0UkQB9b4hOD18KvpVcBUBt0+Qo4gDNiGDgAxAYM8+927hTQm02rSgD3LwxYA5hug4H5v3EH6oVypAF0jvg3OABxPu2OiAFYWCAZoC5ImqqohT1hbgsMnwJn3fg+YNoIlPTv72kY+9JFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542150; c=relaxed/simple;
	bh=2ygZGMdzasDAd/3SV8St3JTwPMy/5pYWnPSGb2dWQq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTv4KK7VqRlW1IjORPKtNFyDN8+0CCh7YXbdbHp+vErJ5IwrEW0VHyqneSdaVUdMDc6wyt331qDcJvockAjERQRaMwYqUzpIfqixdPLS0W3vLu4RqWm3Xz+NIUz/REBjVlq587s2JdOe1LnOGF0tUxRk1A0OiePnInzcxxRdF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cr+j+iOX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cr+j+iOX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668KIKKa3699062;
	Wed, 8 Jul 2026 20:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tknLwERrIw+KuUXCBYFFzSBxUeBG9hYB7jy23J8B1
	8Y=; b=Cr+j+iOXewxEAY6jFJQ0UoUWwF7De1VDHWQJlAOzfegxHUMyw7Rdvl3xw
	BFHSzsd7Zn5pqGApoqPOcB0ItW/s/U0JnvC5hwaoq9j+XATOHg/rzuvnfkquNpMa
	yTSEDcTmj0YC6lLaxpqhykyQ9O6zC8HM4HkO5SzPE0HuodAzTTJrt/nOcmb6B8J0
	a90ZnHCHfOoYl1eSdLl5ZTDNGjTUOuzlhwbz/PJY9WqxCfV1d7SFpLRuhqtOArBy
	uo1rzM3uzSCPKMYebRsVobWD4mL/gJAFDnHTT8NMBkNjQp/Ba9vSt4paUmWLnZAJ
	STSpmo3y2zQuwCtT7gW/C3s91hCtA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdxnyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 20:20:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668KJhs0023235;
	Wed, 8 Jul 2026 20:20:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg9k44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 20:20:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668KK0Mo24969686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 20:20:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E94C220040;
	Wed,  8 Jul 2026 20:19:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2909420043;
	Wed,  8 Jul 2026 20:19:56 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.25.152])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 20:19:55 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Luiz Capitulino <luizcap@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, aboorvad@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v2] mm/util: don't read __page_2 for order-1 folios in snapshot_page()
Date: Thu,  9 Jul 2026 01:49:54 +0530
Message-ID: <20260708201954.686111-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4eb0f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ySnz47qbrfd7rJXDOpkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE5OSBTYWx0ZWRfX5mDbOq6xxWQi
 Md8rcKeDavIliKimRjqWK4Th1p+hb/s96U7lAxydA8YbM5l/i8p9v3D3aup1gmeBjCYc1gCbIuz
 OmUxkhUAxSZ+y9pB6ltFH+c1tQsgDFcOnQKiqqzcM/Guum91eXzY+oicuIKCMV8YWKq4IDGiAnY
 ZHm5+CEaYgrnx/jY4rh6mxhaqFJpdn0qyMyX0r6NPyq6OYGwjqgbNd8gyFSJhEUmFKNfOZ2/bmp
 ZIykLl5s6ATGu6vPjJ6Bnz2GxASsf1hJDaGNiYisz+ePjEc1krK2ZvM9PuuzKVwyVsgqAKQHS50
 7rEcfRYHm4PWnDfL8QIXnF+paT9ZgvYgnRRzrFLLruiCAp2guG7xKkSBaQytWVmnSseZxaProZy
 jiF0xvasFimeAU3dP/Y+NaM2UX9xjiLtBGeTfAGIMA6q5K4XO1m4IOkVal3gooU9ENVHCvl78sR
 KlQlSvjsp2xZGvo2BFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE5OSBTYWx0ZWRfXxVPDhdDTJqjW
 +DXsqtkyUjv6DPl8mTZ7lfoBLwwh/8v7PjZ04VhoVxffwe9KPTU/oT8AdXK36td2qJZDz2PuABC
 wPCCfMbD1Kkk3S88IvAxmB+VJ/hTGfo=
X-Proofpoint-GUID: xMBIo49HIMLhvUE5H9tE-NFN1IQ8dBuy
X-Proofpoint-ORIG-GUID: 8tLAzdzqwcadh2QqphpNWfyNEjWxcXcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080199

snapshot_page() currently reads __page_2 after checking nr_pages > 1,
but it should only do so when nr_pages > 2.

During DLPAR memory remove on a 22 TB ppc64le LPAR, snapshot_page()
oopsed on the page isolation path while reading an order-1 folio's
__page_2 from an adjacent absent section (unmapped vmemmap).

Fix this to avoid reading memmap that doesn't exist (e.g., a vmemmap
hole).

Fixes: 31a31da8a618 ("mm: move _pincount in folio to page[2] on 32bit")
Cc: stable@vger.kernel.org # v6.15+
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
v1 -> v2:
 - Condense the commit message.
 - Drop the code comment.

 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index af2c2103f0d95..34cb43b3eaa4c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1353,7 +1353,7 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 	if (ps->idx < MAX_FOLIO_NR_PAGES) {
 		memcpy(&ps->folio_snapshot, foliop, 2 * sizeof(struct page));
 		nr_pages = folio_nr_pages(&ps->folio_snapshot);
-		if (nr_pages > 1)
+		if (nr_pages > 2)
 			memcpy(&ps->folio_snapshot.__page_2, &foliop->__page_2,
 			       sizeof(struct page));
 		set_ps_flags(ps, foliop, page);
-- 
2.54.0

