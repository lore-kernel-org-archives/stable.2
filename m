Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859467;
	b=k26GMistqK78F6ng7Dizv1Wg4LvX2QGfCJxFHLv8PWTTNvl1anoTpTbrdJKGm8pOD8Z8
	 viFmjc0wohJYXQcNwskOxpPuuMV55FDBmVP2mj1DlpQ+OjoYJXojWuVoGwdkwi1Iwgkhh
	 j3CzDVx6C1bEY6bdHOfKSRTOGyhYpPuYpYP/JXtMgAANvAZ7BxjOFtyAygwwAKq5dt/zY
	 /wC/6ak87Ah78vWJWxYZTclIRkgL5dQplcDRR3UtogeIOqle+z8revzrDVS2vlnrai0vy
	 tO0GqkbkeTkXXlF28tn/Mj+wD+n2pqL1B1Wl1d3Z8cNdx/To+mMRPWT8LuqKRCCqQ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859467;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2pCrvciRru9far+96jdSprril95F4Tc/yf/SqoSxM80=;
	b=NiIOM4IL2T/JK3uqePO2zUQvJxudPla1YjX2bYDrzQVsy8zebzeU79IdYHyVCGhAmyJt
	 4ccujorvJTrpdkk0o0aLvJw5zmE1ZXAuEqJfJVg+A1Fb1bmQYA9ZHdwoD43w8VParPKxM
	 JmfTy3WI4TUuzdNYvOwFFp5OhDasbtIXcrnZMmnO6sHw7K5Gf0atjbNbFbn/IMzGyNpL3
	 ic0SRtLavwW8VdeGlxxt6EX89DpNS8AFAMiRNnWJGVmh03gp+Pur9m/zJdeCo8s2EadOZ
	 h0W5VRIrZxajshMgAd/fDgjERwpblavbR7I1++y8FcivVq5tUwAgsuJske9EiToehOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=gaBvCVkU;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xv11xGA9;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F7C606A880
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 20:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5F7C606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=gaBvCVkU;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xv11xGA9
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXJYw715928
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=2pCr
	vciRru9far+96jdSprril95F4Tc/yf/SqoSxM80=; b=gaBvCVkUaPYrP9nkf0+Y
	CfazgRl0zQMGC/xzRLmb+PR4eDFygVmlDT2eKTskq9kNYGGvTgf59hl4FOIIxK8R
	lHhrfVVbRvRMZ+dULXsyB9cgK+ciiRyoxD2ZGMjzowc0evibBitvY5W+baeptKtx
	B0w05BH564VGyryNxzB4+mvUc33BDujLcR5AZdwAnjJmAcXCMF5iMSRlxRie0L5T
	zfNHum9+PxaSBmXaQjLgIYcr6mZeye6lEWUDBUScSQLnXW6UL/4Rg2miOwjb/VN6
	zDtrn/eaZw9TqpTu+E+1IovRyKliJaWPvJVqVMtFItYmGGzEU0+Fs/wT6jrXgTr0
	kg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059qt4g2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:04:25 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-55d2bde4c78so27415571cf.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859465; x=1795464265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2pCrvciRru9far+96jdSprril95F4Tc/yf/SqoSxM80=;
        b=xv11xGA97wPxb5SWY0ZoNx3kC6miG0Feq67pfax+5OhvoUaJ23dUrbjfieMuno9JVB
         bxOz6g3PWyGZNIwrAixz9bqN59IxAdBV9ftPrCcIIcMDlV7poadyLYyJ6Rfxv+bPvPlu
         vO6/glcbh4EuJKQyCcOPQRRwM+jaWV8jxzcaOmnHzBpmxv0gG3CsHtD1/Xtdb/RQzP5a
         KLx2jsbW5zDnks1FVHei5Kib66gcp+7o22Z7zhIf1ED9phQucSpE9s550nnSbbh50E9j
         ta5t20ZomkqqUt3lgM9yUlv3Dwk5hL3npfDKPJ8u+32wPj0KrKAXsRwT2AbDasztI3hP
         iDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859465; x=1795464265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2pCrvciRru9far+96jdSprril95F4Tc/yf/SqoSxM80=;
        b=CEGldG+BTCIQd/trV1FIQkrTEb/t/0UWZGOlFoF33kFYXMtVZNwjOajKw28GvJYWFP
         gDk6h4F4oXL9WbG8gx6daU/rL0DKkCoriGSKskjC9QJRBt0qcdm99bEUhGbHhC9skevi
         4CkG/PvMWhfhFfAE2iP/AA1NKQtevY3NwLi2QrdHUAoU9Iv022jMMvTTFnbVLjz5gLHY
         UjSF9X1xtDmZTAGqdQC9WTkF1nwi2JesfpjfCpG9tGY5wDBB8T3Cjx+/T5g2S+2ceRfM
         gq1tS63xxIXt6mBEDtQoTOZSNYyCW2b81UdsqY/sh/yrcC0App+Pp/SPCI6Ls9++w4ua
         o0xg==
X-Forwarded-Encrypted: i=1; AL+hErFRVpIjMaaGugOucNLUdScnLTwKIbukacEndNipPK+dy3MAp9uZwXduaqVxLYAtma3t7B03HbA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DnAg/TrDHxACb9f4ZzrNZFK7Z0Dq2vPkSLNscJOyS5e/v/1LW
	dft1mHT/WG7nkf/UcDiLvV6tWyBeA+hQacvaC5dVj/plLXhE0j/vFqeUSLMFU6APA3MKElQ4E09
	LdrYBIJdL7pxxDNdf9ljBPEsKzPdRcT1dfC4xS2IX0JlWG3N9kKYkSA==
X-Gm-Gg: AYBFou0kF6bzwbEKDkj3U0ZRqDhIT3qbsttMatjgMIpc9DaaDu7PQvE4GMZ32vhoZGX
	FPdfXD3MshmDrqYvdi/ls98d2is0DupEaxS83iLjh4yLlX1sDK2Gk2KBgDg90IuWXr7j0L9/QuQ
	OL3PXEJ86OJBrhFIcmCrGbRFM9ioZYM33V4YGBznt6VU58Dh6O1R86heIWZwsHWGwufsKXld4sy
	oFXZyd2XEjihey+nRdYcgq8mHZLWT+zK/qi9m29fp11Kx9DIvsEr4t79+ZkmLaj6zRjrykx0kjs
	QVA/EJQk6+HSXXMSe8yzrxWAHqy7gh6Pp1nKUUlxDMgL3+Xzv8s0C+t+1fFK3M898/kmqszTq+A
	PMQVPZ8HRuYdkrDY3OaytVyChHj4jO/KQ9aFf1Egh5ZPC1GEvjO+C4rqfuy8d7+zUpus1lwaST+
	G+5U3laZe67FgkGf0m8+Y1
X-Received: by 2002:a05:622a:581a:b0:536:5a78:6b13 with SMTP id d75a77b69052e-55ac8880f3amr188261671cf.57.1794859465156;
        Mon, 16 Nov 2026 12:04:25 -0800 (PST)
X-Received: by 2002:a05:622a:581a:b0:536:5a78:6b13 with SMTP id d75a77b69052e-55ac8880f3amr188261071cf.57.1794859464655;
        Mon, 16 Nov 2026 12:04:24 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:24 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:43 -0500
Subject: [PATCH v2 1/9] userfaultfd: use anonymous memory for
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
Message-Id: <20261116-uffd-state-fixes-v2-1-4397a0196479@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=5357;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=gBVSnTZ3qsV69B4gqQcTBCEDewrjMXk5AC+DfvYSL8g=;
 b=GSOjaB1MTsgs5EwXWExu/mb6uuQFlX5gvMC/W50tTKHT+E8WJeRXUZRGB9CfN8X+Jyh9i/MYs
 akVq5xaSShPDq2cx74ysos2PCDaUbKtJgSPqrHNGHGAyRi3dq+F3eiF
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=L/qI0OT8 c=1 sm=1 tr=0 ts=6afb61c9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=a5NvJi0EDLanwwYVvGMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Wph9f3qUB8SS8MX_1xAP0DqkhLSAZNYf
X-Proofpoint-ORIG-GUID: Wph9f3qUB8SS8MX_1xAP0DqkhLSAZNYf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX2eef6b0a9V6E
 JfdLHLDlx1yPj9RAzIjxPVbTit43gLq+7xakDkeaXtiQ2OlyAAuS15qzUshGrw6TSFJV2dGYVTO
 IVfwL/SOjfo9H10aDqEI2pdl2xtEZDaVUyfQMR8wE4MoSBXTxZ4LN7orNFFFeDoVN1zOKI8MBXP
 wIDvr9/HwVeujG0i4Vr2mdIjuCHV+RiJW13556LSlgXDhcjFC7GGJtTx7D8JhzkLUrqe3JpFt+p
 LdchoDXQUGOUiATM/9xtc7lx40kRCZ/QYfjLTm7oPBSZsJlHrMkVXHAd+cN6koLJNk/tEQyY8Pw
 EtLL3msP4NZjOorc0zEjwHDr9coJJr9GjhHDDto54sZXtzsfuKTneWkpx3EpLyf9pPstrszO8XC
 JbprvDYQFuIp6A6oYbN0LPvlHdGTjrDfX2yH8XAs+t5Ow14WUXEHgOOhDrDLK4iro8iFSE+yc77
 U7gfaWzgiwOFUrpjYiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX88OKgqa04xJg
 zS9jw1K2pc/j6EPmR98UJqovnqif8nX1ih84HGDSAiDPL1/PDUPLbFTkBwdR4Iw09qcOAWG2i+M
 YGeOkyQR3CO0+eH3td/zZedQsRwxBfpp2yNIRO1yb0+cJbNfAnq1
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 adultscore=0 priorityscore=1501
 malwarescore=0 bulkscore=10 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160080

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
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
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

