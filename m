Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419757;
	b=Ux/T2whdHLX2doCIXM7nou8oItas8/4fJiTx4rae1YxLPtOUGk82wyNkLi7dApD9AYOH
	 YlUbYMXENA989WhGm/c9wWYj9Hc3N9jBlEqDPsaVPo8TR7q0qsy9flrge5Y8GITF4l0Fr
	 MpZYcLeKbWPQxP9PmMqveQGHtfk7uo2SOKZnUxKg6y5Vkv16NAOmEabaT91hI1S6vHW7j
	 WGCFTM4kMMPL+bApjv7iLdyNtV08+adLO3O5LwpSBwKhUMoJ3JnRejrFrZxm8TK8FZsVV
	 xI3zIiNANAjWo3GgG/6lLFvZODUMORuo9hrg3JRTqANFcIkNXxDKpe8ITRElCFmwJ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419757;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LvmOJZQBB7IFXQ4rWiGOm3EqZVi1Citt+WxZ2aQ6a20=;
	b=OVH2w3QLg+uZ/h8ZBdob39JgZv8wCRN57QBoxVDGqYYnuAXViKRek0UCF0ljxZXrIM3L
	 Eq19DeCcpcYhchcvaGCYULJMZK5LpRXAd2K3k2NosRk4FIQzCNO1Tme1p/aLrtv/lGvjt
	 lLQL84aSRu97jMQja2VSHKv8Nr5g/h9JAj2q6jcK293ip0OaYbbx0h8Dsw4HZpWLVZYNX
	 kUOzuxSy5uDifDmemVz+XAz6iR04tySw93FAw9JSDqNaWP/VVG7kO59zGBiGD0AZ1BGYc
	 joR5fvfztmyle8QZOBjJYmtxIZzLNQmS717Z3MwLOFUarpXM5sFcvuplsg4T9fmdIjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=T4qiOUVq;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=aI7PgHm0;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53991606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53991606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=T4qiOUVq;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=aI7PgHm0
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYFYM3383390
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=LvmOJZQBB7IFXQ4rWiGOm3EqZV
	i1Citt+WxZ2aQ6a20=; b=T4qiOUVqH14cGGbnsTSJxS4tbddUBrhFmsLiPt+sYy
	eveWAhH+ZZRt1Zc9U4VkkGjt6JD8dbgQOWe7txZfaxAXGCvp4IWTVZEtjY2ui5QV
	Cz7apLFSbuqpYm86l8jC5gXpWWByv3rzgpnr2yodcXTs5QVg3EurmndxGMjGlRXm
	2vzYejk2gq6udQbxeQ1DdosGkSb96Xj1Bj7TvpIITitTAwk+GS2AY/+8CLPAVF4R
	i7lfZpPSkWWKD1wKguwZZfdKclL2xEVnsb2a5IpgvFoWinZfHUVHyqK/8W1Rx8/X
	s8GXFaM10U23XqBjlfPO6Suyg4yxF4X9cQZ08RvcfSjg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hvda5wamv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:55:54 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5339739b343so69251721cf.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419753; x=1795024553; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LvmOJZQBB7IFXQ4rWiGOm3EqZVi1Citt+WxZ2aQ6a20=;
        b=aI7PgHm0IokjHh6Z+g2Uj2knHds2GhQyGwztHl2yV2eLv9YqUxkiO8RDLEMaQ4j4p5
         YUTDksyIH2vfPk5eGbVKSJQl/CeT2pRCWhecXJzQEqHxokaG0WiPnrU4Z1XAJEJ/+rLh
         yxpWk7i3D1XlcuAsna5JQ2vrEmgOsHGUBbNI3xaboV/PHPOMfIjFFHdl41d5o8zy8Zs3
         8999FVj7QzlIyZAdfxv2TWZM7Ei+OAHJXxfErh41wkwVFVvNoXvm59+jrAGVcJ0V/5DF
         YdKS86nwf1Y6Bmm+tdrKW4+maCEPr3lPrrWlX7tDCxicIZstQeL1zjNkae4Sqk5I+J2U
         Wgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419753; x=1795024553;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LvmOJZQBB7IFXQ4rWiGOm3EqZVi1Citt+WxZ2aQ6a20=;
        b=Y7aSmyHiuP/2suK3ugIhBT1Ez/QSjHI0AcrYGGkteU+wPS6IjmDPrae30OFbcssI+b
         8NxvVjBMyPHi+cwLlftLfun+goY6ejsueMLVf6c5RiC48wkMZkNPxvrQfzOvG2DIUaCY
         8rY45YuhcXw/iW8KdI4Mjo49e5gxCxMFzB/NV7DOXwzf2C8ip2ORBWAYZA6pCCSmN+Mb
         eHcgv3SoXTTPF35IJ+ASAyZXmM9SoKGCojZURlUtHWewD5vXiMepzfnaNR2FsAAXr/+/
         xQmcG1we4ZMh5SzJZ71y2kTFx9UHmTH5BJBo26uogNOCVUbLUY/lVaqS0QlCuvGkJAac
         bGbA==
X-Forwarded-Encrypted: i=1; AL+hErE2m9Oem9W/BoThDYnXXCYO+Aan1h1dlynZDwqgWIPAgJfsQzJrjtmJ31lMD1ZdPhn2MPQM6+c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jTDVZhzjP4bzvG2kQuUpTADBXkiG1lOWt9Xua6o6wKmsNT0PI
	SNuhu2FDh9XBxvdavlEU5U7j11GOrf6DCaeVv4t7yObTU1hV2gP6ybi+jyPgKTFMbBjW+1UTKlV
	C/lPFA9Gu4ayuuZadM/hSReGKjEeJ9iJGXAyjucGUiz04AfkYJoumFg==
X-Gm-Gg: AYBFou3qd1OxVuB1rdyeajrMZWMukQrJYslcxR5pC4hjQA0gdMvVgIcUc1o50OLqLQB
	jy/uXWHSGWOzNgpbjSb3mUklSUnkp7fpqosW+s4UFJcGHRFabgCo56SF6Qlxyi6/HDmIMpOkNN7
	afYhiZsQLf+PEwjG/WCAu/a16ujc0LLEpq2VxN+eKViehrNRCe7vrg4sbQarmN/DJ8CMG/fuXlo
	2X0rlsyooPyqH5RPrmUG+wAU9A/YodZMyrvWKk6GVUo49WwkDPqs1lkpJtlnb3ArqNo+2gZVMet
	Hs5BLlhuDG5TCaT14eOesIRe2psQUb7hXiB1MQEFIoeX7J/rrpjWzjSqOoD4JYrVnCK++xJvpn2
	zUeKqjqdVffhNrsnoZiSl00PBErWyYTfvzhqDsuZvQxLRS3GsbuY7bfUn8qxRcaqz4hA14DvIkF
	1T1X4tihLUpICgln1VHw==
X-Received: by 2002:ac8:5f4f:0:b0:536:6856:f590 with SMTP id d75a77b69052e-556bfc28a79mr49069381cf.18.1794419753268;
        Wed, 11 Nov 2026 09:55:53 -0800 (PST)
X-Received: by 2002:ac8:5f4f:0:b0:536:6856:f590 with SMTP id d75a77b69052e-556bfc28a79mr49069031cf.18.1794419752787;
        Wed, 11 Nov 2026 09:55:52 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:55:52 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 00/12] userfaultfd: assorted fixes (part 1)
Date: Wed, 11 Nov 2026 12:55:08 -0500
Message-Id: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAPyr9GoC/yXMwQqDMBCE4VeRPXfBDUWkryI9RDPR7UFLNhZBf
 PdGPX4M/+xkSAqjV7VTwk9Nl7lAHhUNk59HsIZicrVrROqG1xgDW/YZHHWDcXAiAuf78GypZN+
 EayhV975ta//BkM8fOo4/Jw+9OHQAAAA=
X-Change-ID: 20261106-uffd-state-fixes-d2111e2abd48
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=3924;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=cHZMnkuvxuVsum5IPSVBD2Hn2T2KOpeSqPFMnmKTxDE=;
 b=PkxX+j2NoQYADfdFn1SMpbWDsHba3k2jAxsod8ceDHDYyebLuzyuWYyJoweea/Y/WhGIgizjc
 tc/IiVb91ndBzMIK+oPCx5sSZLBqMlOolvppMeZlGQp/vadBlj2yIzh
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=ZaGIpcVA c=1 sm=1 tr=0 ts=6af4ac2a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=ctVpGLEqiRcwzRHSUTwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: GrW0Q6VEc-xNP352iABIwPeYk0RwbssB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXxaMofD5fNkSN
 0shkOLZsx1VLioIR11l+kd3SmwX2GvWhNzQfa9VCqYSA1176y1ylUaC927z/HKHVfs9K+QQzdOf
 Jy8hKwN5K3vkUcivx1QgMvitjyKcxImgdNF281eOC7TxujUrPvI2
X-Proofpoint-GUID: GrW0Q6VEc-xNP352iABIwPeYk0RwbssB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX31ULR/6EbRGK
 w/HnOQx4baA786jTQGFUkaPyhvKzyL//oF9XWSEhaOKFsqH7P7rfP0N1hOBM8BdV0G1xI60duSL
 39kJq80JAapX6BLbtkfvA0aSetD2SOi1gpu8nDjl2TgySaS2Xjhh2pd5tum8iRvwSV8LkfoW1pP
 LtmXB2D5HLJlOc/FyaBWKdHFDx3gUDHcOXiL1Tq7ax/b/jXg3F3dOH+WxyXVv6feys7OLbleTmI
 4DNL42KqqHTCxKKgIZVCrI0PkDJCwBpOHoXddSP0ueax6tub88tAXC8JSsqHIIXka0fhc2zrPrd
 Xa6hKhuWV0yhx+ByQZw/yQAVRVsQS11unPlGqFwhqqa9/WQnWlhu8WhoBzjerCOjj44jsuHQAyC
 G6ip20xUvgtcRm5EpnGd+PbniPX0ehDkxsILTFaaFE+swCrlsKrBK+NigHCo7+3JcPOVAm8sjJ4
 wXSbBAN1Ws7rGi12bUg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=10 priorityscore=1501 malwarescore=0 impostorscore=10
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

This is a first batch of userfaultfd fixes, with more to come.

These were found by a mix of regular old LLM review and by having an LLM
write a TLA+ model of uffd interactions with PTE bits and other state
and seeing what issues fell out.

Most of these fix places where mm code loses uffd-wp or RWP protection
while moving, migrating or zapping an entry. Userspace then either
misses writes and accesses, or gets pages reported that nobody touched.
There are also two hangs (UFFDIO_MOVE and MADV_GUARD_INSTALL), and
UFFDIO_ZEROPAGE modifying a file through a private mapping.

Patches 1-2:   UFFDIO_ZEROPAGE and UFFDIO_MOVE fixes, cc stable
Patches 3-5:   PAGEMAP_SCAN write-protect vs. migration and
               device-private entries
Patch 6:       UFFDIO_MOVE of the huge zero page from an RWP source
Patch 7:       mremap() losing uffd state when a move fails halfway
Patch 8:       migrate_vma replacing a uffd-protected zero page
Patches 9-11:  guard regions vs. uffd-wp
Patch 12:      UFFDIO_UNREGISTER with a misaligned hugetlb end

A few of the fixes change what userspace sees:

 - UFFDIO_ZEROPAGE on a private file mapping no longer fails with
   -EEXIST where the file already has a page, on an mm that cannot use
   the zero page (patch 1)
 - UFFDIO_MOVE returns -EEXIST for any huge destination PMD, not only
   for a present THP (patch 2)
 - MADV_GUARD_INSTALL sends UFFD_EVENT_REMOVE, and can return -ENOMEM
   or -EINVAL if the VMA goes away or changes while the lock is dropped
   (patch 11)
 - UFFDIO_UNREGISTER with a misaligned hugetlb end fails before
   unregistering anything (patch 12)

Patch 6 has little user impact on its own. It is included because,
together with patch 7, it allows removing clear_uffd_wp_pmd().

Patch 7 adds spurious minor faults on shmem and hugetlb after mremap():
when dropping uffd protection there, change_protection() makes writable
pages that were never protected read-only. UFFDIO_UNREGISTER and
UFFDIO_WRITEPROTECT already behave this way and lead to the same
spurious faults. This will be fixed in change_protection() in a separate
series.

Based on mm-new.

---
Tal Zussman (12):
      userfaultfd: use anonymous memory for UFFDIO_ZEROPAGE on private file mappings
      userfaultfd: refuse UFFDIO_MOVE into a non-present huge destination PMD
      fs/proc/task_mmu: downgrade writable migration entries in PAGEMAP_SCAN write-protect
      mm/migrate: keep the uffd bit when restoring a writable migration entry
      fs/proc/task_mmu: write-protect device-private THPs in PAGEMAP_SCAN
      mm/huge_memory: build the moved huge zero PMD from the destination VMA
      mm/mremap: resolve uffd state when the context is dropped, not during the move
      mm/migrate_device: do not migrate a uffd-protected zero page
      mm/madvise: let a guard marker carry the uffd-wp bit
      mm: set the uffd-wp bit on a guard marker when write-protecting
      mm/madvise: send UFFD_EVENT_REMOVE when installing guard regions
      mm/userfaultfd: check hugetlb end alignment in UFFDIO_UNREGISTER pre-scan

 fs/proc/task_mmu.c      | 64 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/leafops.h | 18 +++++++++++++
 mm/huge_memory.c        | 31 +++-------------------
 mm/hugetlb.c            | 27 +------------------
 mm/madvise.c            | 62 +++++++++++++++++++++++++++++++++++--------
 mm/migrate.c            |  2 +-
 mm/migrate_device.c     | 23 ++++++++++++++--
 mm/mprotect.c           | 26 ++++++++++++++++--
 mm/mremap.c             | 46 +-------------------------------
 mm/userfaultfd.c        | 70 ++++++++++++++++++++++++-------------------------
 10 files changed, 215 insertions(+), 154 deletions(-)
---
base-commit: 2dc0136b1fdac153434ab02778fcdb32db5d0dae
change-id: 20261106-uffd-state-fixes-d2111e2abd48

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

