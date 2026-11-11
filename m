Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419757;
	b=RBFsPyWWnffHltRyxC0Waqb3COiP8EMnInO2FMl99XWtRXL87o17EEQMjl7V7s2U3Q51
	 E60dWj06I82jGlGN+/yCwJb1uM05oBmHZnsdBkMWIeEHvJsJkdjAjl4pUqwGCqmF+CeuX
	 j8xEcKMM/lysDNEWBz4qr5knDidEEeDiLoOENtjF542FrUCv3pyFhdzFjLadN8limx4uD
	 NOOchJ7QCy6pHsV7c2Tz1WCSn8NLSnrB/a/cBDg//1SUY7fsUqFHnqF9Vqm3HKhiysXR5
	 VSviNrbnrtEzj8OfjzpLVQUK3gEL7oaf6f/b+5s09M+56t5orznqmCPWWBD4C45QgUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419757;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=deCzxOFeDCQXgKxHB3hOal3UgkmEGxjDuW74KEugHoU=;
	b=dlFXSCr7nYgwjFkyU6nDeDSmzMyCnsI5xJJrWJy4l4rJygBX4WIPYet3I+Ej+TnOFCXT
	 Qpe7kwo/36LcuLWiGQyFN7Ayn+W9PzTgaoerzPGtzxm35REWEgzh3usimH9+ORxUurg1J
	 L2N4zgtyMNoOrJE4gAPbM2i7zr/3c+4keL9lbJbPRJjfNTi0eKmFFLF1Rm6SjpgqFXTA9
	 m0cZmjlcDExqx+TMzm+O2vXiqo78vFFBO3xNEJ+rNi5Ek8EH9My2k71cUBNx+jhGr+mKK
	 qJtgW0aWj2hCvMZvmjnv5+6R9ZBIqgYoba6mCGPHfbbxkrGcPJbWq5/ZOUdHjqV2daQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nL1QA79v;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=VwnW3Qzq;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF98606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF98606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nL1QA79v;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=VwnW3Qzq
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYE9k825536
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=deCz
	xOFeDCQXgKxHB3hOal3UgkmEGxjDuW74KEugHoU=; b=nL1QA79vIxrk1LgRXl1R
	ipAVXpxa26rNAPdRIHB2IMbb1SbgNxZNxC6+K43RVctvACGgXZ9c/sMH0lHNFgoA
	NUbS4vXonzDqYheWBIi2VsAKB02Siim+bORzdo4O0M5R8/5InB4F8/SSfIFg87+7
	eLLBRyWqs+PiYQPhiovxSeEg4g5MM5YSJ76W2DC9A9b8I5E0i3L3raNk4nu7TUSW
	QGje/p67Ob49L6nWEu5f88d+wHJyf+pEQqyK2S9TpDoyMMjUaPl06rVA/reQ5GOw
	1kLoNnQWh+PPE13TgFJt1BPQB9NvkEXaiUU6KSu/MmojvRAlqAZV/8IZXws0+NEk
	pA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvvaqrhf2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:55:55 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5338c215ed2so51062951cf.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419755; x=1795024555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=deCzxOFeDCQXgKxHB3hOal3UgkmEGxjDuW74KEugHoU=;
        b=VwnW3QzqqtwSwH0CmH2pD4ibQ3qfPS9UQ7bvFg7FVUVbvSiMwtxRqwY7/vl8R+qiY9
         cqYXVKoQ8MHaPt1BuQ8JRq2nkpXRRmsKkWwJiZvQX21j7n5oT2A5cL4mjv90T/f/0+PI
         9kUWb6BWAQfDnUksWPG+a5I5p5AMOi1pPCfOYSc1XnCN8iQo3WI0Ow9wQw2irZsutnJb
         DSwK9OaGQf+unrwumnmW3O5qT7Lanxf0rrr/8xYSPMGpqMot/4kd64LYE/3Z3w6fEnOY
         eFqU1UrrYLzCDaoAeG4SIQW9+M79Qv1bQnYGLL9p1T31oc5X4DwjbEM8ACtVakdyfSKB
         T3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419755; x=1795024555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=deCzxOFeDCQXgKxHB3hOal3UgkmEGxjDuW74KEugHoU=;
        b=TLJw2gAYMMpiR2ibnDx8eH9h4Rb03LtorE+crDDNIp2rhtqHZh5V95Cky/UGeBwWNh
         hyFHNOVRRbB9czT9YkNOTeOrgHHY1fI2Bdit44COU+FmkAHkIt8KwAelP+eGzEYOC9x4
         OYF1QBwzckfHIaj+0YgYG1yXhzcNDCOR93s0hTTlmuw93l2pI2ciVJXHgnzn3RUzAgcj
         6HAG2g2OAoWicHcTpSyPwi3ZMkeUZMxseLwJFvnEGauRMmAH1TdBkyf3/XJDRGFyBsa5
         J27R5Jua0rhdeQhAOAFWmZ0qC0PqeBMyLZ4Cv8QpL035OX2hHDesWLPCZ66tUTBavGMm
         Dt6g==
X-Forwarded-Encrypted: i=1; AL+hErHq1+QZpvnuaGy+SdxP8ShCDTjcjXuW1a4gBMoWhBGcwvcN4SMA3IQ8X+ZDtG3EcpCet2LMlQ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1wBxvh1wlSCOg2mIe6B3amKV6tf2u5uWDYbXPrpqxoCyI1re8
	WpNjbmJz//8kkVzxiPOEqsTQUzE80RjgqTs/rqIUb7X690/whakIFL+vIJ17nHF7cExqFJb2KBm
	8+fM2J57FlQuDhVADTVPzqdlQm4Uh+AAmOowOKOgIMq0VWiuYWq5rAQ==
X-Gm-Gg: AYBFou3Tt/IY6obRtMEDi/L7v3vQafSg46wKfx9MqrQzojB2JwCt8RTjOnjqWSL2gzE
	uroXsUqeV01keMgcx/fgaT7f5mbq8ilc8MV34oinKBpG+kFch/WJJLckf9NdhQA6lZfvWtG4Wv4
	z0Mg9aAPUx6gddNxoT7d4EVgQuAGt9tt8b74rzzaN62t87R95ajjIoWrc0ByZQx8z04Gn5/vZY0
	JA2UaJOy4Gg1B4A1+JbCWDR4Wu7Va5tmsSjfXeBN4yRDCCokpMG4HKglcCF9foM7pRdZwTZxn3l
	qPHRHQjUOuH68NtFRQ50jUXMe80B+pr0ryIX9sDb2TK00tPH30vSGKh73hLvPzwyeqJP5Kzd/Ba
	iXfGJyOducJAXlgbJ0zLMu8gmVWSiecCcJGQ+74rDW1UtQr6qSpbWo9z4DgZ1fYaftmMaqMs+yb
	BrIo92nyHv1Z70PkwRGw==
X-Received: by 2002:a05:622a:4c6:b0:551:ad99:3df0 with SMTP id d75a77b69052e-556c1a5e3f7mr48808331cf.71.1794419754936;
        Wed, 11 Nov 2026 09:55:54 -0800 (PST)
X-Received: by 2002:a05:622a:4c6:b0:551:ad99:3df0 with SMTP id d75a77b69052e-556c1a5e3f7mr48807671cf.71.1794419754264;
        Wed, 11 Nov 2026 09:55:54 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:55:53 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:09 -0500
Subject: [PATCH 01/12] userfaultfd: use anonymous memory for
 UFFDIO_ZEROPAGE on private file mappings
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
Message-Id: <20261111-uffd-state-fixes-v1-1-00713d368976@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=5307;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ZGzqhLx0gH//2ZFXY5DcwHUNOIJoLDbuuIlcIz+dT4o=;
 b=eBI5XdW7u+jazsrmWEO2BTjYrlgooAZbQFoFI5BxfJc84/TDMCva259mt44pi4Q3MmInVwbC8
 Gp0p0OSeiIXAPfpI5jclFrZpIzdZfkcquSiZQb7hr/WMWAWNQXKUChK
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 3ceKTtV2bhonPZB0fwKUbpXHUo9PXGuW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX3ogjh1YZW721
 ETe+d4oEKSfrNMS/02QzZ6v8KW4RtggmW0113MBgB/nT6uCyKF2TXYQVQikk7DLMhmt3ZvinHkk
 t1z7UydTM2RJ+8s+e7S6jADcpd9KSijYi6mixxTyOYG4x7FwHSZw
X-Proofpoint-ORIG-GUID: 3ceKTtV2bhonPZB0fwKUbpXHUo9PXGuW
X-Authority-Analysis: v=2.4 cv=dqFOmFg4 c=1 sm=1 tr=0 ts=6af4ac2b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=a5NvJi0EDLanwwYVvGMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX6SiZYOLE8LyJ
 QAxuSGS1MvykYoldv9Zu9zVS0cWY3jSu6Nr/zgYCTZRlAU6eYRP1H6BRe6LjJE/kE1hCUELlx7w
 lVDDj+WKjxIwjNsOraoHrgeRA7stMf7sMsGJIOa/lKT5FlkZl7P9/NAy2v2ROOiA3EEyjf/nO3s
 kPzh6fDMAkNJXcs5pje0ii6RcX+s+k5eqJqAZw1DujhDBfrQYQ9F1jwzm/YJmFuxaTs+3HDw4L/
 ePEFQCWxzC/wgVORv8+cjDDX5iMH04VCwTfdqHuU63tU56w4W+aU3qvtiVegCQTcU4koU/uewFK
 sZXwxdZQRjA0eRhaIwNFlJq2CP8FIw7E1cun+XBJHyeCFgD38G8AIqCzYVcH3qgbRle4A55Byk1
 rjgiNssC284E9p2x7p8FGZDFueIF+MjJR4ZrFtGi0xYk6wf/hiebzYsyJfP3XIOw+bH7GJ0cPqK
 6a44Cao4wzexy6rTK4g==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=10
 clxscore=1015 lowpriorityscore=10 impostorscore=10 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

If the mm cannot map the shared zero page, UFFDIO_ZEROPAGE falls back to
mfill_atomic_pte_zeroed_folio(), which allocates a zeroed folio and
installs it through vma_uffd_ops(), no matter what kind of mapping it
is. An s390 KVM guest with storage keys or protected virtualization is
such an mm.

For a MAP_PRIVATE shmem mapping, that adds the zeroed folio to the page
cache of the file. That is wrong: a private mapping must never modify
the file it maps, and the file might even be mapped from a read-only fd.

The ioctl can also fail where it should succeed. A missing fault is only
delivered for a hole in the file, but UFFDIO_ZEROPAGE can be called on
an address that did not fault, or can race with a write to the file. If
the file has a page at that offset by then, inserting the zeroed folio
fails and the ioctl returns -EEXIST although nothing is mapped at the
destination address.

What we want is what UFFDIO_ZEROPAGE does on a private mapping when the
shared zero page can be used, and what UFFDIO_COPY does: only check that
nothing is mapped at the destination address, map zeroed memory there,
and leave the page cache alone. The zeroed folio path did that before it
was moved to vm_uffd_ops.

To fix it, pick the ops in the common folio path, as
mfill_atomic_pte_copy() did for UFFDIO_COPY: anon_uffd_ops for a private
mapping, the ops of the VMA otherwise. That makes
mfill_atomic_pte_copy() and mfill_atomic_pte_zeroed_folio() redundant,
so remove them and rename __mfill_atomic_pte() to
mfill_atomic_pte_folio().

UFFDIO_ZEROPAGE no longer modifies the file, and only fails with -EEXIST
if something is already mapped at the destination address.

Fixes: f74991b4e383 ("shmem, userfaultfd: implement shmem uffd operations using vm_uffd_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/userfaultfd.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d65184d9a480..61a712e1f9f5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -531,15 +531,27 @@ static int mfill_copy_folio_retry(struct mfill_state *mfill_state,
 	return 0;
 }
 
-static int __mfill_atomic_pte(struct mfill_state *state,
-			      const struct vm_uffd_ops *ops)
+static int mfill_atomic_pte_folio(struct mfill_state *state)
 {
+	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
 	unsigned long dst_addr = state->dst_addr;
 	unsigned long src_addr = state->src_addr;
 	uffd_flags_t flags = state->flags;
 	struct folio *folio;
 	int ret;
 
+	/*
+	 * The normal page fault path for a MAP_PRIVATE mapping in a
+	 * file-backed VMA will invoke the fault, fill the hole in the file and
+	 * COW it right away. The result generates plain anonymous memory.
+	 * So when we are asked to fill a hole in a MAP_PRIVATE mapping, we'll
+	 * generate anonymous memory directly without actually filling the
+	 * hole. For the MAP_PRIVATE case the robustness check only happens in
+	 * the pagetable (to verify it's still none) and not in the page cache.
+	 */
+	if (!(state->vma->vm_flags & VM_SHARED))
+		ops = &anon_uffd_ops;
+
 	if (!ops) {
 		VM_WARN_ONCE(1, "UFFDIO_COPY for unsupported VMA");
 		return -EOPNOTSUPP;
@@ -597,32 +609,6 @@ static int __mfill_atomic_pte(struct mfill_state *state,
 	return ret;
 }
 
-static int mfill_atomic_pte_copy(struct mfill_state *state)
-{
-	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
-
-	/*
-	 * The normal page fault path for a MAP_PRIVATE mapping in a
-	 * file-backed VMA will invoke the fault, fill the hole in the file and
-	 * COW it right away. The result generates plain anonymous memory.
-	 * So when we are asked to fill a hole in a MAP_PRIVATE mapping, we'll
-	 * generate anonymous memory directly without actually filling the
-	 * hole. For the MAP_PRIVATE case the robustness check only happens in
-	 * the pagetable (to verify it's still none) and not in the page cache.
-	 */
-	if (!(state->vma->vm_flags & VM_SHARED))
-		ops = &anon_uffd_ops;
-
-	return __mfill_atomic_pte(state, ops);
-}
-
-static int mfill_atomic_pte_zeroed_folio(struct mfill_state *state)
-{
-	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
-
-	return __mfill_atomic_pte(state, ops);
-}
-
 static int mfill_atomic_pte_zeropage(struct mfill_state *state)
 {
 	struct vm_area_struct *dst_vma = state->vma;
@@ -634,7 +620,7 @@ static int mfill_atomic_pte_zeropage(struct mfill_state *state)
 
 	if (mm_forbids_zeropage(dst_vma->vm_mm) ||
 	    (dst_vma->vm_flags & VM_SHARED))
-		return mfill_atomic_pte_zeroed_folio(state);
+		return mfill_atomic_pte_folio(state);
 
 	_dst_pte = pte_mkspecial(pfn_pte(zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
@@ -927,7 +913,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mfill_state *state)
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON))
 		return mfill_atomic_pte_poison(state);
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
-		return mfill_atomic_pte_copy(state);
+		return mfill_atomic_pte_folio(state);
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE))
 		return mfill_atomic_pte_zeropage(state);
 

-- 
2.39.5

