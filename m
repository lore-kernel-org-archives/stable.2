Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419758;
	b=azaPREMsKHSFbF3b9DZ0B4MNMt3DuMTF54y+x7jRRlzC4ld3VwMes7cPYx7QfkYxrgTb
	 cniUP48R7kAoRRe8YFo4AHcBIEqpcpZDw2AaHY7wZU0W4lP/zOgJ4VvX2XvotkP8ZXWa7
	 erAeTxfh5eyvYfpFZEta99TUdPHJTnc9r4wxIIyymWHxqb9ayvQRWjyvjmdo7k8Nj2909
	 InJRaK6rnx+nJsvcKRTnMTJpi9aoE+o2WQDOPVVkbYVgg7s+lBwwPzTRef+r2A9bpFkLc
	 4K1BJ92k4wvc0FCsIFKx7B7rJZ7gj4sFXtnr9qJ8XbkYsWzUpUXwj+XgbVEHCTPWQEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419758;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7MOFi51WWNU/BFhcLH1/2inK6bTwCpvqAbFpVpbGI1c=;
	b=Sb11yD+kt/KAziykFYzGMTrR7JkqIhO0zDq+nYaZvXXJ8s/3d+XnZPfRmkQCfc7dfxQd
	 YXRIYn2dOiniTF9+0mV1xKcprBy/2px2yI3dkTqotJgUsJVd6DkYtRD9vGUfdRR4fO2+e
	 Ice68nW0zyPG9spAY0axoRU7jsjw9AkbYNLCIGdYntpW8UnVN0LtYdxtVck3XglDtyVW4
	 PB4fNgSEW/2gK5uBhb0uvx/39xZFGF1ax1loYMrhTyew6Z2zGGLjrCL0qetY90FmZZWTQ
	 OLH30Bun7ryS9RLb9qW1qIt8wKMMyXRvhl9loHHjo+QEPb4ROmYD7LxDeDOdJR3TW1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=SUlefyVx;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="ZF1yios/";
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03EE606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F03EE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=SUlefyVx;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ZF1yios/
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYOd1566667
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7MOF
	i51WWNU/BFhcLH1/2inK6bTwCpvqAbFpVpbGI1c=; b=SUlefyVxB2IykylV6RQv
	uCFi60l/FjIhTOBff0sXTGw8mJJ67LkIWRby8IoUBoGN71z/AKWoHY4taBUwIcS8
	GInDU+0qmG9aXab4oQAxeNGUYqW1wuDC5N77s9q9G40D0YyCuWd6Y374Un7fptUU
	b5ZH/IKn8BZf5Hol9D5KFMSjD3FMwhrLoCh4MCrseoT06SarW73nAbJfLbk2O9Bo
	JN+LNgOAy8ntOeG9+73YrJeibpoCF2vEIFsj2xd2vpjejlTwTn1p3Otd+/Ni4VK6
	vGNcNORMzv2Vtiwsy2earwPIWL/U8nOwpssXNKYxPtaVTa0PBjwonpv7MAlEc5H3
	IQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvew5mptb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:55:56 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53661e036a2so69201701cf.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419756; x=1795024556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MOFi51WWNU/BFhcLH1/2inK6bTwCpvqAbFpVpbGI1c=;
        b=ZF1yios/P2AXM1QIeaCSsdcvGOkzFiInAQf8h0+F6KH2Jtm7XQ8NPP4OPqXM0T2EHD
         Veqn21cDPu4VbbeiYTbRIxXvUNsd2ZW0+iXRL+GW0zKNcoVGeRN/ONxPanryR0QSHyp9
         ejw1Gs2NkE+HOaDGKXwKnJWtz+HbQjYuSqXlQxMUKHURahcSx3qFhWjGmDHzdFRGGAj7
         LmsAYi1yOHZY/7rxrs/XygqCwgzKOnrjyzrRhuYKwu/mxZc0vr1avp7sSgNg3DORzxJM
         hbotasRGQvnuhsCsmKnZYsRSlhZ7fk7tEHQE2uJFPVltSFSOZf/SmefI8CAlXtKtUiFR
         xeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419756; x=1795024556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MOFi51WWNU/BFhcLH1/2inK6bTwCpvqAbFpVpbGI1c=;
        b=K1LTsox2ALhfmZNgtSCGMBjYxbqyxfLAIl5js+ZEsGlBWomSG5f6elNiRqcH2wo4QD
         FgteCAtSwx5nfFcClo80t6LRv5sC//k2Lniw7SOYMrB31DBiOOnsvIEgX0XD9lQv5T3C
         C3MpZcWKr/gtPvLyS8GVQ/Auhv1LXRys2Z5yp4mXLTNW+Dx2WgxDR83EAkmcotdKlb67
         K+dfxIAI1Fl5fLdsDMHYejU+Q+XX0lssg4PTi0Asq7fmc88Kjz1TRPhyZoGpZ1q+O0gx
         E3KnDxZJHt4uUywYTz4sABqVXk81JXCgihZsQ7yLTIGaLGKrkTATKcHzaONQn75kgGJ5
         rg+A==
X-Forwarded-Encrypted: i=1; AL+hErFUWA1jf/5UFsspXG/pLTnIvijW25EI6BDL1eHVjQh0d0WaKuwLXZwtyt1Biyu/vaHkRYcBqlI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ztd9LYpSMeGbpLez7cqZ8+EHwWepiST8rHHvhhUJn7U8XwOKV
	diAA29yP8oksJOvhCDSOMnGQjcyHZ5i6H414RltKa+zwgGtH2fc0t0/qqMovA9ptsL9p8HSHc8g
	N5zWS67AzqiU8eV9usEYLa5tccOPKfPLvL9LTnsOGcK8PH4v1Abv/7Q==
X-Gm-Gg: AYBFou3ukGDYkNrv5Hr+2g/x23F9iVNWhoiAyLjDaD3lvBtnDVuave4sbbiHI66n4A1
	Zb7P22QhR96Muy7yM/mZXpR6BXwjRkzg6eOz22tFwO/e8j36wZ9XEAOpzg4TAyUf1hjOP6hMU9+
	AGcwzc93ADkXEM+AE1ZVBVJX4PjAMQKzt7XRoFZwZYIXf2UtgYXmgfNabPp5PN/bimYyWvfEFsK
	mr9dAYK/2yvIGWXDbzsqvIOVkaa39JNDYOTVtCOtLVwl5/gN38AjiIlGdEtkMCP7y1R2h3Z47ry
	+IT61Z9mEMzbPa9oG5cXQ4BQW+B2xa1Jz05V90ZhUl9Vl1HUx/UWX84t4RNeKhtJiXJVNpswTa+
	zCR/Nl2f9eIgQy+2Vb0Cwc85GwFUwVDn1fyfKOKjHL+GDIJosV64RZ/hPelmeeIzgW+/hg60Q1I
	gyVsULKl2SXl8uiKEcRA==
X-Received: by 2002:a05:622a:4c85:b0:536:5ec7:7b37 with SMTP id d75a77b69052e-556bded3d02mr45210391cf.8.1794419756283;
        Wed, 11 Nov 2026 09:55:56 -0800 (PST)
X-Received: by 2002:a05:622a:4c85:b0:536:5ec7:7b37 with SMTP id d75a77b69052e-556bded3d02mr45209941cf.8.1794419755682;
        Wed, 11 Nov 2026 09:55:55 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:55:55 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:10 -0500
Subject: [PATCH 02/12] userfaultfd: refuse UFFDIO_MOVE into a non-present
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
Message-Id: <20261111-uffd-state-fixes-v1-2-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
In-Reply-To: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
        Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=2480;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=hmSWdcV8+u8Uu55UTF0KE1x/q5080musLnzrsSE8NCI=;
 b=YcmnJF4fHQ0L7W4Y7oTSYqS/5IZFZUFz6kPggxDhxQy+g7C033bdZd6LsCGBcgjt9L5wqvPbF
 LdrIPSEAYk6Barh9Z36Pi1JQlaP2hup+hwI8mBdW8nnsxhKpgORKaTc
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXy8USD3S1neoD
 rm7kwA+CIjS3BeI+QtMRwvpubXvAp2UemgDFUodjfOly/gl11UyTfPhS/xsEIEfP9izeZhkAPFZ
 knmC+rOzdBwCcdQXDl7B0H3K6rWgMlVXQa1E/ujqAMT3/i8vSFzYnNVODcmg+COiTfya4EYvQD1
 MkV7ZxJvoqVZnS+VFp37gAmmc9I0Hgi2gdpbx0xnAsu0p6e3LCQSXzy1IrPGvSFat9uHCwH8FdY
 LVPoyjsN7DPJ+7IQpVnFJFqas4Dn1dp+OEEKnS1Pj3+WviBRrJlNEninM0mqsRzW8jk0FSiYYWS
 WHs2gBdP1ZycRLKJvKBWRSEl+F61UlcfGS4TXja6wZPNOR3Yy+FCvGNY/jKrhimoKWEMgrwV+3R
 YBwpeQDg2KiyxxmNF8XcBvVL7G1FKHbPr08rAw47EvaqU3TV5n1EcQigkiWNoIFibC2gZo96s4A
 6RZc4qpU5YMQtZUj8vg==
X-Proofpoint-ORIG-GUID: ZYpgUITUXSRleK2rwDSorSJiB2AtK6FZ
X-Authority-Analysis: v=2.4 cv=etVKXYpX c=1 sm=1 tr=0 ts=6af4ac2c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=VwQbUJbxAAAA:8 a=n7zxJ9EK30Z5vFJJ7y0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX9y8R7PX2HGaE
 ki9InsgAhXax8Lqy7mnl0iwmmJrfOO/476OjC8lwBNz8m9JXRJRlkdTeymHCfZ6X55vB/xWKpPX
 8/2YuoU8z45EKm/Nb5QhEWrVLIXqvKiuc5GcmOyciiKU+NLqdsMu
X-Proofpoint-GUID: ZYpgUITUXSRleK2rwDSorSJiB2AtK6FZ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=10 suspectscore=0 clxscore=1015 lowpriorityscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

move_pages() refuses to move into a destination PMD that already maps a
THP, but checks for that with pmd_trans_huge(), which is only true for a
present THP. A device-private THP or a THP under migration is a
non-present huge PMD leaf and is not refused.

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
any huge leaf, present or not. UFFDIO_MOVE now fails with -EEXIST in
these cases, as it already does for a present THP.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
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

