Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910003;
	b=Wq5ei3EDB8CPt1DbNSqCoouHLJ9L2Y9PBtNB+OQyH1K9gJ+4Ri6tZhM4lhjVXIeI1Rhh
	 vMY3Hw8mO23V2Krj6nzq+iQM2oJlmysIrkkZPnvtUwHKzNaz1zslhMXGE2DFAMOG1mhm0
	 DzW28iX3n5s3BfiLmi255oKc31IH8BsjSXroWM0nuRgz6fPnFGNV5b7casXUombxs8Sum
	 ceypVMCbZU2ftkvIisyxOZ2oid5ji9Wz3lJ/fqHYkfRvWQeqmFQ9Tkm1qYrtNfp2Ou7Rr
	 QRJOBHxlmlxb1YVeniD+C8fP9OFVg/ognSZaoNevisxn60W+rbGURFJyDS44ce4kE7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3ahOovwjDlDqMNZ2Yyn08XyrzZ+sm+Yb+nsv1sSKI48=;
	b=bOIlKBpQHd2zxd1TdQp6BaOVI1Ofh4ChM3GIdQ6K8W0n5STtfTBV+V20IZuaveXcBxT7
	 VvidHjgS5T4Q+v+tnjGzyPRlMzLxpcDQGCZfNAOlvtWBiBmKQLP8O3R8M4Wo+eEiYgzNw
	 j5P2TOMB/XHMpvZUi3d2ROZ0cDYiFnxnyqIQtv01sN8z6LT5EyHJb+Iy7QACuxGGFsDqk
	 HCEaMcAHItJQVAnJ8Uzr2yTTEh08grHEmyfaLpn8aoTaZnZBFJiXqRgF0B8bbKY/Ebehk
	 N6y0RgV5tv/WtToYZoPe9Wue23SnPMjaMtSVhk1O3Z5R5kEMrWrxrFQ/zUIIeY2Q3Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A/oX0UGA";
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FBA606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3FBA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A/oX0UGA
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so2717347b3a.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794910002; x=1795514802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ahOovwjDlDqMNZ2Yyn08XyrzZ+sm+Yb+nsv1sSKI48=;
        b=A/oX0UGAjiQUMW/uHe4FAKYp/rapBHq8Tyxdw6UZ+gBxrxtAI3PfS7VDGLBkS6lAYQ
         D5CPvf+FkTgRQAS8ykBj0Vugq0WHVlvkPSN9mf2Sezh0Sspcf9Ci8IagyeqRVo3qgCqg
         oRKUia+PhUgTH6cetMzY1GGYcAkmx7cFvobW6z35XjmGohNhnwHG3XEvuOW8klc33110
         BbAVizGupRMtP99zsyUFXFIs8XGHjIXClm2axID+4jREMsJPtGSqbGB2BR7bi4C8akrD
         UMxk3NBU/XHMloUaiehf6ru3kkPjBppTOpjNpflrvgZpY1usm9St8qgEYhHNNQ/cirdf
         1Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794910002; x=1795514802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ahOovwjDlDqMNZ2Yyn08XyrzZ+sm+Yb+nsv1sSKI48=;
        b=tZWapaVmO365M/AS/OMPyWj4RI3WwluFcY7DbXvnk2ytmHmgH+ABEDjMBvMqZZPHKX
         Ml6UIFN7MCeNsn9yyztqHuK64TtF1D1Tbp62SUvJRigwxs8f7OnwIa3OqeHhuOOTdzfd
         Honu70L/xC2GYvxzrunpxi5WCwUT2BFD4EDc++0kQzZoHDOFrUEyVrDrQDbT21AROO6e
         ViLGPPbQrE3BDl2bduoC8Rp1FpgqcZrmjuhO0Uawcail6zRyU3BbpBy7NR04VzZ+o1mv
         n5yu5M93X8kZrqDayTMsXdSp5aNU5rIkRW+D2SeociPcy7mqXpNoCwCerlgKjOt+/2c/
         vZOQ==
X-Forwarded-Encrypted: i=1; AL+hErEoLnSglou7M1yoPGuoFSgcELwAnKxx48cq/9noX6cSTcsyJlruR3meCZ3zJkrTa8ginxg7Fro=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uYtbWfQm4YrT9dU0KasU2YBSbDCJozdmWiGC2TT1d8cnCuCTi
	KsOpheVQlek62ZYtCXt2vT7+3+xs8QgzNgB0Oiu/YkZrVHoyYz25ILt+
X-Gm-Gg: AYBFou1V+teyT9OuxxSQ1T9tX3DPxRnFNKp7HyffUm5inPk0y3TPVFWM7utFTKX3FJ1
	yysMXkbtrb+LclBn8+TdFN3NbOX2uYQPz1SPSYFw1uE887OFJ0qyLyyVAUsRBmSb/uf9BC0qla2
	zPMpXarv1jAbaEmUCJurD/TvdZuytEFPZ1CGWIsyxLIMD6YNqTpPtjBrQmRC7zK7OqjbITUbd64
	7BTtkgrXusD/uM8E8HdzEyqTy72TXYndnSvEueqApz8xk+sPc8yzSgFX7aNoDeEcl9kqYqpOU03
	HCHf/hi3QtcTDP0Qy41XMmTQB5UHmrCI7hFixdBpY/E25u+zxSZDNyKlKSFpFd4zeec3ZJaknDT
	8MRH3gICjZh0sFJNgZg/gXaaKOok+NeY4UaeqwroNDgd5jwGa29bUO/xwktsucZ6lKShcUQNIea
	P8s3OvO940naQdOTxDPro1QmCF86jrMAn5MGaNWWYUXu1U3dvUtW7FcoAjYBoJXEdQYAIWMJPHt
	b1PDL21SKVIiUuNQXlDxoSEAXxZa+MqNZ+UvVmRSz5EbH5oOSTq57g75t5zA49GGEQ0ssvlDzPs
	jcmQa+idKHSfpsuNIPgYK8FyQH5wlQ/MHwbhGofBLwtS8eQw+yG2oTY06gUQpwRBSxwki1Iaeua
	X5d+/b8WqT21Jfnk+OAsdB2nj7yWRhv7pjDP18KZ131cQ1FgOu+2/VedDRS1AsI4Jnzvc3kPpnX
	ESu64ej5b4+6ZtqpxPV9zVzYoGdMYEt9yReceM03uOBju40joNgw5Ni5r8JOVbq4Eg35GP8ugim
	ayg/YEsKQIZA6VgJNKFCD0jVvmihZ2UXL8WfGoSbleTFFzdnyzd2Err6XTeIc3R
X-Received: by 2002:a05:6a00:13aa:b0:897:d037:f3ef with SMTP id d2e1a72fcca58-8beb7d1cd51mr11380228b3a.30.1794910002249;
        Tue, 17 Nov 2026 02:06:42 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1d6207fsm5213337b3a.32.2026.11.17.02.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:06:41 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/memory: mark unshare copies dirty to fix MADV_FREE data loss
Date: Tue, 17 Nov 2026 20:36:22 +1030
Message-Id: <20261117100622.807-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
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

wp_page_copy() only calls pte_mkdirty() for write faults, so the copy it
makes for FAULT_FLAG_UNSHARE comes out clean. Nothing marks the folio
dirty either and there is no swap entry.

Unshare faults come from R/O GUP pins, like process_vm_readv() on a page
shared with a child. If the process forks after the pin is gone,
MADV_FREE in one of them marks the folio lazyfree and reclaim frees it.
The other process then reads zeroes.

Mark the copy's PTE dirty. pte_mkdirty() also sets soft-dirty on x86, so
take soft-dirty from the old PTE in both directions.

Side effect: smaps and numa_maps count an unshare copy as Private_Dirty
or Shared_Dirty rather than _Clean.

Fixes: c89357e27f20 ("mm: support GUP-triggered unsharing of anonymous pages")
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
v2: set the PTE dirty instead of the folio, as David suggested. No atomic,
and the dirty bit then also survives in the other mappings.
v1: https://lore.kernel.org/all/20261116111245.28871-1-danjwade95@gmail.com/

Tested on mainline b3dfbde62cf1, x86-64 with KASAN and PROVE_LOCKING, as
uid 65534. The test gives an unshare copy to a child, has the parent
MADV_FREE it and a control page it alone maps, then waits for reclaim.
Without the patch all 4096 bytes come back wrong in the child; with it the
child's page is intact and the control page is still discarded. Same on
v6.12.117.

 mm/memory.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index ec3d9d99ccee..113b305854d5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4130,8 +4130,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		entry = folio_mk_pte(new_folio, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
 		if (unlikely(unshare)) {
+			entry = pte_mkdirty(entry);
 			if (pte_soft_dirty(vmf->orig_pte))
 				entry = pte_mksoft_dirty(entry);
+			else
+				entry = pte_clear_soft_dirty(entry);
 			if (pte_uffd(vmf->orig_pte)) {
 				entry = pte_mkuffd(entry);
 				if (userfaultfd_rwp(vma))
