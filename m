Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095765;
	b=E6KUpT/p/f8EVzwoeZvlq+fdDA9fyIwvzppNgY2cInlL4tKMSxIVW6vzasUgGWfPHmoV
	 BJucIVjJw4ynAbwzeHxjRMBsKUs3CcgyTSvQdpoOo5w/KT6K2ar+gv291QQ40XkmCnq4M
	 NAPRciQamZ/gtZ9KgX8Utt4C60u+nBOv0iXRgH03XAOV93SD06KTz4T4NLmi8TulGJNGZ
	 CUFaLrbq7mug/3v6JJDPeoeNSs51uhuRj/tPSqR0GsnrY8kyo31+JcCB/C0yzB3/dHIus
	 YtUgNX+56xkvC8DdN1TZv2q7lM9k3LTDqlKgQtJRC4gnFYonq8gyccGQFR/SX3a8NNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095765;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hZLXfSf/17Ef5XJyZLOKhQU5fMpX1env96s9MUXf9kY=;
	b=vxfut+iUautMWUTgvBGzz4etz+RpH7e/wZZZ1k5bcrjVChhgPGx/7FH7ugqyrBXwcHXH
	 ftUxzNP0pL64C+tX8IZo5399aIo76hTS2tR6ZIXZHU7kPDmu9kOoGPR1crL1JSYrrImft
	 xVchJ0ksu37vRLZiTEToE1KGhIfEwxmqv/glSOPnNFIvFiZdQQzgTenZzzQ/qlzjsN9ut
	 f3JWprAc6H2Mvb7qO+FBpHkUH1jmZSQ/1wANvpHjlBtSlAj/N3buvETdHDD6197HnAsvY
	 pRpFm+yWip2UDwFUIJkqJujWO38vx2RKVYQ3cajXtXITDi3ZJNWdjGog4hi2jaieRFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+adbwFN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B518606A333
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+adbwFN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2081F000C5;
	Thu, 19 Nov 2026 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795095764;
	bh=hZLXfSf/17Ef5XJyZLOKhQU5fMpX1env96s9MUXf9kY=;
	h=From:To:Cc:Subject:Date;
	b=S+adbwFN3mBqD+Y2dJKKI91Yatqdnw15AQDzpeFz1GMMd9Zm7SmrbLlt4kkblZhOw
	 9+lLLlEJdZzsGdtyNk4EKv+fZOeWAcppiKZeATO1r8mY8A90zyDhYCjTPAZ1A5xMQ9
	 V/FEitO7Zvnp5wMNDhAzVWh4ns9LL0EKjChErdP7h7tPrDrKVNQDWIgxQqLMVakd07
	 udQ/5WAyTRKWygUnuUqjUoLGmR6b56eqvqIlTMzeRDr29qhUloT3WOEA2JNQaYdKY7
	 EFAibC1gSCxhoQ1MN90WstaURwGYyNbbtHzkn9KXSO6dTNH9gLJOU1GoDvwmP1LOQL
	 L/N+I/hZBX+9Q==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 914F0198003A;
	Thu, 19 Nov 2026 08:42:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 08:42:41 -0500
X-ME-Sender: <xms:z_z-aimJl8XCqb5MqUf-Tobp9vhrkPSgE_Vorci58WDqinU2zpClMQ>
    <xme:z_z-ahzzgkrjjVvUyO_wv3ZWJoi30-rT4jQi-cfs4EnSGzwDKyOhgMDm61LO8bKYj
    DdJ34f9ll6e51qh19W5t5GwEns_KCZYhgyY5b3DPCzpgXpZ9U9neyjC>
X-ME-Received: <xmr:z_z-an20otvXVua2svjDqlIDFl_z3T2H4j9UO09g1vOcmgTmzZvS4NnJ-O0>
X-ME-Proxy-Cause: dmFkZTFHmT+KFWUidJgUngFM8yp8kVRG2IFi1T6SjyyYCJuUmIsF6IdJZHernKMGzpOMgc
    N7kcPP/LThQoj1fmneGFg+J+zYjzV1DzWnyuedRueYR+KwZkHR+LyFpGcTO3UxZHbsHZLI
    VeemSW0OzNfHw3hjpvSetYaKqHsRxd0DgRmV5azyzryGDjg3EFKQ6nzyTRfvrGJpuDWk0A
    Q4DoYcz7Alv8vaF0fCd22ynjNg8DvM8ITRH1kkAyG8F8iFh2WQkYXrXeSHv++WNwQHhPco
    DoboXMgRx3iyIxqEIEn8S65o/o6x09rTMI6ipa8RxHIekKwEDY7+h5gHfKkxmXEeivWKB7
    dyMXwzm2z/J9TwCOGP1H9rZx6vcd10RDMfAdWVoqGem2UuvuOpgoXyQh5D43Ev1puVlk6z
    jue8XaJ2qU/DA/o+RpOEh2CLzgoxg1N0gHYYYCoPeju+Mo3Cp25f69TrleeYFJK3MKBo9J
    arGQ/sRpQcLDJUAk2yA2StZNFnjrAk3moF7+W9MIzjdMOgIOgGgWoWu0122CF6WemIYqMQ
    TixAddxU1H5FdYQob6/cdlFW+VH7Uae4k61kJFjWHADpr97i0ItclPVGPE3oQh13psDCl+
    tin5ZYgNfGptXWID9zL+GBw5zYH/S/FGOZV6DyDmINfP0UdFR5VecCdDgggg
X-ME-Proxy: <xmx:z_z-atCEjpCU5Dkkrm-b_7_6_SAaMTKlX7xWCQlvYqrVoyNIF6mejw>
    <xmx:z_z-as--sBmjlT8JyoP707xtXeBePkF59F5HfS-iWlMppSKOk_8mVg>
    <xmx:z_z-aj9wOUnLA4hJEyP5clpx21s9R__P7F3HP3RKjfh_mi5Zv-0ntw>
    <xmx:z_z-ak1ZwP6TBd09Xjf5A3Eaw5pyIzOpG8_N1el1TxRgkSZw5TADcg>
    <xmx:z_z-aj8L793r-tafdJbyAXNuoLMkq0eU5lnOeXZXJ4qnfm2lQby6bR95>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 08:42:38 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Usama Arif <usama.arif@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/memory: don't map hardware-poisoned pages in finish_fault()
Date: Thu, 19 Nov 2026 13:42:31 +0000
Message-ID: <20261119134236.3745231-1-kas@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When memory_failure() cannot split a large file folio, the folio stays in
the page cache with the poisoned page in it. do_set_pmd() refuses to map
such a folio with a PMD, so that the poisoned page gets its own fault and
SIGBUS. finish_fault() then falls back to PTEs, but maps the whole folio:

    do_shared_fault()
      __do_fault()
        PageHWPoison(vmf->page)
          // the faulting page only
      finish_fault()
        do_set_pmd()
          // backs off on has_hwpoisoned
        set_pte_range(vmf, folio, &folio->page, folio_nr_pages(folio), ...)
          // maps the poisoned page as well

A process that touches the poisoned page takes a machine check instead
of SIGBUS from the fault.

Map a folio with a poisoned page one page at a time. The poisoned page
then takes its own fault, which __do_fault() turns into SIGBUS.

Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
Found while reviewing Usama's fix for the swap-in side:
https://patch.msgid.link/20261116063624.1382944-3-usama.arif@linux.dev

Reproduced on a huge=always tmpfs, with a THP that vmsplice() keeps
memory_failure() from splitting. A write fault on a good page of the
folio maps all 512 PTEs, the poisoned page included. With the patch it
maps the faulting page only.

 mm/memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index c966b3fe48b1..1f899d1be407 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5920,6 +5920,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
+	/* A poisoned page must take its own fault */
+	if (folio_contain_hwpoisoned_page(folio))
+		needs_fallback = true;
+
 	if (!needs_fallback && vma->vm_file) {
 		struct address_space *mapping = vma->vm_file->f_mapping;
 		pgoff_t file_end;

base-commit: 5e600d79135124a4eb8e9db30ad524224c267c07
-- 
2.54.0

