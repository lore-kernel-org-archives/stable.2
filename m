Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859468;
	b=Xu5mmrJcrtRnWd82ITEH1iDCkNdH23oVZPjcl1Q4f9cDRw7DpLMkJFXB196I0JpVC75C
	 6LdXLKcx6jZtmuKHc5KPOe3J2w0o1ZWD0tZWZ/iuZnaFr6jOI4SLZciWLGCRzjK4TDVrL
	 ElVi7njgXY9BJZglvI5zlrS8CO0EhTJ+wWE+vypAgilsckaaSV9LGCM4qnLw2NDrFgi7P
	 +n7LeujLnLfqLOYxWHHGL0OT1aCibZCZNbCKiB8jE/5jdHh5/u1mrVLF9RXj/YFVXTDtR
	 nLip8ufnOX8IMrqpruThXE2k7+kzag8GA3aLYpi1fehNFBSShJFxmJ2gofAqo76XhMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859468;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZCwhlg799dXefZN6g30kX8e7Dd77LrYQ4Kv/DAwnaW8=;
	b=JEGi/vcJVyPy3Lu11HF29scynUhm3Yty/xqby0giGSqXZuI5IhFc4jPAF/VEJ9SyiScu
	 Gurv1L6UGUBVizU+lhSsX3S5VmVXeoRt5piIa+oxx67KobLyp5CvRTkqjwTecsho4UbzM
	 5SziqtI79Ph2TxCQj88Sgdk5RHU68dFos8jw+J6K7KPcrsaovvKLl2tWNSngIM95CBhA/
	 KWK8gRdgFoeGbvlf7GifgRoIEnD4gXODO2CfPIg4Unh/AKWLwXCwOUmnAB2xtDQXn0RWn
	 k4y9mPrcDWLQdj6ldsYSKqU0tw1r2FF39vYUtCCOmqFAXAOF/3EZkAZVOuA40Lt0Qyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Avi6yR7y;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SqJtWIwR;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258360A260B
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 20:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5258360A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Avi6yR7y;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SqJtWIwR
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXH3l4113231
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=ZCwh
	lg799dXefZN6g30kX8e7Dd77LrYQ4Kv/DAwnaW8=; b=Avi6yR7yJt5dxX4uim8f
	lZi5WkIGIa3WzKo8VWyn5yiY+9+QwBYGcFKkPG8Ll2bij05Tf/KmSHeosGVQEr0X
	vINu9OTxuHu+hMC8PrrSPH5E/xOI6rMUoMxPgyOWBkp2pV7hanccM7QxZzHJzxIH
	CJlhMYH6KmezeavezmwnNu3eu2xN+bBfGoFjsyRJnU8y7LnshG2MLp4qmcaRl7me
	/TDiOV/WbXgQaJ66MCjoqwqjmdjS3ibjEjpDsrJ+zOyGTYk6zpDPfuPR068ujrFO
	1iHPISMUXlqAF/djUPb8KgpHAfEW2FI80JP/8HOVxpFJzS/45igtuTLNBqPRtJ+G
	Kw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059dj3p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:04:27 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5363b06bcb2so33642481cf.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859467; x=1795464267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCwhlg799dXefZN6g30kX8e7Dd77LrYQ4Kv/DAwnaW8=;
        b=SqJtWIwRIxugCc52gjWRK7TYFawuwVQW0YTViyXOTfZEszhOjYugBNMBuNKbnuYZkJ
         WYK3Xohmhs7TQU/9yM3/HYqWAgew5P0pMwLBO5gyFI3K2wNn9QrQmWgowx/AppQq/4hG
         71upG2hUfLd8lpKVZsbCHkKXwhB32OzcoKekIbDiXJ65KWEmW54J3IKNreJPOT3hKwzp
         SUq80FFy/3tIMhDNGyp0PFkgCwKV1W+z2m+wbWKi3HUT7NFMXpXHhBfWl+suFGZ/xmzE
         vpPwfzhhUrBdt+s647EkFPlwWB+BjEqSg+/L/DCFZDT5wA/S+jhIwGk1+0kMv+x3trc5
         yKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859467; x=1795464267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZCwhlg799dXefZN6g30kX8e7Dd77LrYQ4Kv/DAwnaW8=;
        b=dFT6u5NDlJVvkRm4CNMKuSwpJ6wKjBJPvDGv8tA97QeSAAm14TdkGBx6CWWJuOxT0S
         VjnFQjJHR/nZ1CEtP7xBDkaOtKHYsqOlBDTuuO5T+lDvJ30pYveuV8pSHaiQLzEGNj/i
         g/Tc3AhF8l6iV0l7olxeUyymkA3kIqE7D7jEQp5Aw6TwAZbW90y5orZ+KGgz/48U6Kol
         8A+hfh94fZW1qj6gzAa8dPj7wyawlgyOM/47p3mnx1OMmVuX/tOpAItMRWp9LmmxsAEk
         3l/qOR+pAMXqMx0SnlmrPitoIDIKEHeY8phNE3J11FW2lUhzqkF8cin5rmj8Alf6sykK
         1L+w==
X-Forwarded-Encrypted: i=1; AL+hErEV+PUPkCBDB4MFWsvy9sbFq62uHuCYIIaeZN2uayH+57Bk0Cn7CqcXkZj0eQBKARQKsf5rs1k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ceZvltc5c7kRtxb2204jJZDGbQuQg9Lq1kGsLcSaKf9X7TNi/
	FWd2nmpRQi5cp/d/JFtzaZe4GhckRvHTTBalSXscBj76k7HQEfjwwstcjTjUFda8ut7NrzCmNSF
	+FSGAVGicZl5mTkJnca4zK5cSFAYzt90wGwrQOzu3GPDxliLTr39fVg==
X-Gm-Gg: AYBFou11fw9Qm1wEBQWyk4jcBR5C+FYnbH0epPSiBzg2trJWK3OmDkYoGY2CHSXzJIi
	grRQguz23HUajodHoQlmBdV8u+TjadhaHkTxZ4Ny9QSgyrw/wciVK4J8zbnf0H1y6zLa/DmYTc3
	8lCV/oSZ08qzFDTZ9R84eFlnlIk1c5rT8OTFovfyccfpmZmr5Ccblx8g3G/0YvqllZ26Qz46UeQ
	7r7eJBwXyLf5c/A2GCZESnR5ICyeq/1vwiZHitjIFOWEwv9XHplVfgo7QWjttRplYIZ3TX/G+M9
	ywOAFoHIQnf0bLv9MAfb73Fdfj5RquY0vW9rlNOEYd6rHVHgsGpzuqLzSkELrjgITyeDzvH2eFP
	UmdOps/SrQkSQ4ZBvv9Db3kzyTml1nzlu/4Pm7BBk69kuKkhA6+7yfH39yLik6ctG8xMCy7E6qs
	bRWnEbKiQGLgUbnV3OAJR3
X-Received: by 2002:a05:622a:1e11:b0:536:61d4:cc6d with SMTP id d75a77b69052e-55ac847c073mr171631621cf.53.1794859466727;
        Mon, 16 Nov 2026 12:04:26 -0800 (PST)
X-Received: by 2002:a05:622a:1e11:b0:536:61d4:cc6d with SMTP id d75a77b69052e-55ac847c073mr171630841cf.53.1794859466077;
        Mon, 16 Nov 2026 12:04:26 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:25 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:44 -0500
Subject: [PATCH v2 2/9] userfaultfd: refuse UFFDIO_MOVE into a non-present
 huge destination PMD
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-uffd-state-fixes-v2-2-4397a0196479@columbia.edu>
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
In-Reply-To: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=2644;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=BudFHF5389gq/6rY8jRzvPbsYx2vICBEg7pYFFrBViE=;
 b=t3sAieLSS+OXzq7B52aEUhbXT4G+5zwO4OVck5koZlutX8gDRlKpXN98AOcvX/w8IcqgKUbPD
 QyCfUeDhDxpD1EXJZMVer+LooTq+cx3UW2MMtCDD9f0yNIK3ut+s1Qv
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: kDNFau-eF_aD5jCYADmZYpgdrDvc-sIi
X-Authority-Analysis: v=2.4 cv=Utf2pOwB c=1 sm=1 tr=0 ts=6afb61cb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=tHa68p0SAAAA:8 a=n7zxJ9EK30Z5vFJJ7y0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX2q9iGdXZngkt
 3V7pLzTPUTiEt7NndkHUi4DonOs+MIGznW+txdexwiGEwDOhRQP/5Bv7PzuViCJoU3Pd54XoSdI
 xdYgxFjCxgKle2BY8v8LrPYQjAgs7tCpSqpm145zGDUaS0i4b/lzMqXzyjANlwnuLbYCAdfwu1W
 WPEwsF2DPTgwp0K+9LDPvt/+iu/ePq/7mCM7sKio+bBJjXZ3f/EWtupHydnx7zSC4/x0lkSM2D1
 uN0sVn3MMA4khUtGPbRJyfDbMhLqKRfRHAlAfjIHWJzJ1yxyap/XJbwzVC7pukHbiHayWuIuRJY
 xAWe0udWdEULt3TkQL0y9DN6mqhySH1Jjnn1ne5Y2KDcJ+/ei3x/JYpet+ccWAPvdftWJ61Hgdb
 u3AuPtfVM1hepuvYS+Wtp2Teha6XxMUgMxnSDJu0EB/XRLkZgItUNx74ePKPYkE35D/BW8/GQBH
 5+SUmGyrxi5/b59HzAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX0PflcKjhBWZQ
 V+m6/fSvHAuVcycOFF9i2BZtfFcDePztNvjU4N183+ovqWlD6AhM/fp/3iRW0h6FORJ539UEXH2
 L1hL22NnOospCTMivrNVtVQ131rsYVdsl8K31h6MjRmvbvz/TEer
X-Proofpoint-ORIG-GUID: kDNFau-eF_aD5jCYADmZYpgdrDvc-sIi
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=10 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=10 suspectscore=0 lowpriorityscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160080

move_pages() refuses to move into a destination PMD that already maps a
THP, but checks for that with pmd_trans_huge(), which is only true for a
present THP. A device-private THP or a THP under migration is a PMD
softleaf entry and is not refused.

The destination PMD is then treated as if it pointed to a PTE table. It
is not empty, so pte_alloc() leaves it alone, and move_pages_ptes()
fails to map a PTE table from it and returns -EAGAIN. move_pages()
retries on -EAGAIN, with both VMA read locks held. If the source is a
THP, it is split first for nothing.

For a THP under migration, the loop ends once the migration finishes.
A device-private THP can remain in device memory indefinitely, so the
caller of UFFDIO_MOVE hangs until it receives a fatal signal, and
anything in the mm that needs to write-lock one of the VMAs blocks along
with it. This requires a driver that migrates THPs to device memory.

To fix it, check the destination with pmd_is_huge(), which is true for
a present THP and for a PMD softleaf entry. UFFDIO_MOVE now fails with
-EEXIST in these cases, as it already does for a present THP.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/userfaultfd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 61a712e1f9f5..ad9d243dc64b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2021,12 +2021,13 @@ static ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		dst_pmdval = pmdp_get_lockless(dst_pmd);
 		/*
-		 * If the dst_pmd is mapped as THP don't override it and just
-		 * be strict. If dst_pmd changes into TPH after this check, the
-		 * move_pages_huge_pmd() will detect the change and retry
-		 * while move_pages_pte() will detect the change and fail.
+		 * If the dst_pmd is a huge leaf, present or not, don't
+		 * override it and just be strict. If dst_pmd changes into a
+		 * leaf after this check, move_pages_huge_pmd() will detect the
+		 * change and retry while move_pages_ptes() will fail to map
+		 * the PTE table and the next iteration will see the leaf.
 		 */
-		if (unlikely(pmd_trans_huge(dst_pmdval))) {
+		if (unlikely(pmd_is_huge(dst_pmdval))) {
 			err = -EEXIST;
 			break;
 		}

-- 
2.39.5

