Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794020504;
	b=EnsHJ0gydtjne5LxQ/G3m8xe/uoXyjkna2fljibV+OBpgYM7Vu1G/hzEMog1cspGvQ+m
	 RQ5+/Z0U7C6fibmZrV3A6iO1D5EQEqxB8ODqNZPcy2/wvzi3EIyM5LJYXUldfTHF3GOH5
	 0iqynOIF4HoMCsyyqe6R7EcyH7yL4RgHz1hZMXIqSTZr7r20TzSpdPduEDt3juZe1QAiL
	 dGMg5o3dISwNh6dBaTbcB6845jwwuEtYcjAAz3lXhGPRs1l0ad/R3LmdPL7unlMraOWfK
	 ADGPl+h+i66oXr7JQ1iV/zL6NSNDZTOhZZOW9cFc7MViAfGknvgSssKiq0klnj6vt9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794020504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c7RdJd1ac0ZTEx+/NYzXEY+S8dr+3ZAZRK/h78/Mnrs=;
	b=WGkPNowuLuisYgpg7PXbSrNmq/27CQN6/pCpKPQs8KRqcYGnJl4pW8oIr1/4DBXkHOBu
	 2RjdaxAGG+ELqftotbzPQkjDuQRe8V9HkEyReVgxZsyA8vHh1zhcYX8x5ukIaowXOmXST
	 yz+DAa+4uSrxOyicsTZl31qUZOhRKQ9H5I6BG/CqEVv95OekTbHIReKM96fRi6PdK3Nr0
	 7ZFPmOlNf0doajTvCKNaPomJzUv1oDl9ieAJP39iELo69N7I0vzwwzVNRD3X86GQ1FPEg
	 mKpjZhnCNGSMarPJSpXAtbO1OzNa1eVQIn1x7XBUtsqrRXQ0h2qLTg+sOJ/WjkcfPfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EXL7qNvo;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6E606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 03:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8F6E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EXL7qNvo
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36dbde64409so1738696eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 19:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794020503; x=1794625303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7RdJd1ac0ZTEx+/NYzXEY+S8dr+3ZAZRK/h78/Mnrs=;
        b=EXL7qNvoixipFHmUbTzJDnVPsqgi4j4biZQDDbJ1xQAQJHf2NXHxgCekVjOp/+aZVb
         yp6VqeTgewe26Myz7al0S2vSkb77+amT1dxIRHwQ2MBO2lT6wQK6EdXfpzk6bOnKZFHf
         1FPyaVZYqU9QWAvjgfe0vPkEPQW+O0CUwWAB8c3jRbLOHFBBIig3mpQure4oPc+30D/W
         gDsmH7CpNhQ1Hs8QtINZSFd9o/aReNI9OLi0R1eyEFjaIJ/npVDPGcNoOm/sW+CjDmro
         EXWj1yBbGE43wfG7YU7UZNX/c730VtWabz1UQ+x6vtpqvv5/1OErICSYMxBJqWtH2VZX
         QhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794020503; x=1794625303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7RdJd1ac0ZTEx+/NYzXEY+S8dr+3ZAZRK/h78/Mnrs=;
        b=rkRw2HxDLF2QaRF+zvzukcCAJXeQKmhBL3s1zrFSfj0lGo0fpHOVuO91sVHn7jqi70
         wCrJ2kOttjEU305B4jXuZQwP/J8moBfAYBa5ceLskjYqWzk3pY8unZd/xz/7MMYFz/cz
         xWb0dQAXuJ3V/TV5pdQEKObQSJqvEro9vKHKA8fR1wm2JIuSnhwRFEqnmVjlE+kwRiGq
         hga29MOxnAOXZdhp8mMUwH0LZHwgtDYNMduODX/AJ/+UuQbx73f0kY6SZuOVofBpn71Z
         n42EXxmSZGqjxN3NcuEC619lA6pQJRGjZThWQny0Bcvn1hfqQse3mv76JsVgg8EHtHa0
         CpGA==
X-Forwarded-Encrypted: i=1; AKwUvBzOWCA7+GhzoispSuc1B+09DCO2U1vl/7QINneZQquJiPLZxYR7H0D9HHjp/QiSsGCaxmR+G30=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZNbIhxXGvRNz8JK0oLOuYLdOzoMMTY46J02oKSX8DBCyJfsXx
	yfIr0QZclGG3axNOXrxYI47lec0eFjYTm1OM87pnPt4JRx58PuR2yaOFcSV18dBROCI=
X-Gm-Gg: AYBFou2fc6OeZeLXfDcZ05M+4zhSOC8uFu0rFI3EQek0xW1Ao4ODpBr+DSVPbp075Sw
	kFGVK888/A0yvPfXd9EJ2OpMobPew1EUO/DoxcswowBdx2K22bLX4lkAzUmpC9NzMzkAjhdxb7H
	DEt9i51M0u7uh/+Xgf54pnKpEg/F+p2c9QjZeCRMlk2e6Oi6YXK9T2NWDn3Pt61scnFmtxJXJYa
	PXbFXH3x2WrSg1I6sPlEGvkLRty8dadvVZTAPD8sTV+nFYcZqtLBtKCmK5Tg5geveiCgkW0YPXD
	36l0QyRjezbVNK9JaBLNN2PNBP4WBDqadlBkJlo5HBreyuwgLe+6TJn8ujoyJ4PIR6aRhi9L3lW
	Q/ii8koPi+qyYi/ldGaKgaJrM1LoycusW4DEngKOB7Du7vSW7kFaVETz3YdyM2mmdMIsVVz1eR/
	3yaIEdSkrX1+02DDcRDpkqOS1yfF2ldFXDRUZNnGrLMwcQEIsa/jMpDk/4fCih80OF74twS3YQH
	s9TkbEn9BCP2drDl3fkZetpA3s5Lxqp9WmTnGmw6mjEsiNoGuAwtbfJQ5mxQ/q3pu9u4Bt/cPce
	hib5nG3O2Wh0oGXgt5Na7xT1UR1NCcgE+ZctyiIbSUBURkjwUb3388xq4yVrTg==
X-Received: by 2002:a05:7023:a5a:b0:1a0:e3e2:22a3 with SMTP id a92af1059eb24-1b25d33a590mr5333663c88.31.1794020502203;
        Fri, 06 Nov 2026 19:01:42 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4b4aa7sm9534473c88.13.2026.11.06.19.01.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:01:40 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Pavithra Prakash <pavrampu@linux.ibm.com>,
	Muchun Song <muchun.song@linux.dev>,
	stable@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] dax/pmem: fix unaligned compound devmap initialization
Date: Sat,  7 Nov 2026 11:01:26 +0800
Message-ID: <20261107030126.90894-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
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

Static pmem Device DAX namespaces reserve space for namespace metadata
before the user-visible data range, and may also include padding needed
to satisfy the Device DAX alignment. __dax_pmem_probe() adjusts the
dax_region range to start at the data range, but the dev_pagemap range
still starts at the beginning of the namespace.

That is not valid for compound devmap mappings whose memmap is stored in
system RAM. Compound page initialization requires the start PFN to be
naturally aligned to the compound page size, because the head and tail
struct pages are initialized according to that geometry. If the pgmap
starts before the aligned data range, memmap_init_zone_device() can build
compound page metadata from an unaligned PFN.

The resulting struct page layout is inconsistent with the Device DAX
mapping. A later mmap fault can then resolve the user-visible PFN through
invalid compound page metadata and hit a kernel panic while inserting the
DAX folio.

Fix this by rounding the pgmap start up to the Device DAX alignment for
non-altmap mappings. This gives compound mappings the required naturally
aligned start while retaining full-section vmemmap savings when the
original start is already aligned. The altmap path remains unchanged
because memmap_init_zone_device() skips the altmap reservation itself.

Fixes: 14606001efb4 ("device-dax: compound devmap support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Closes: https://lore.kernel.org/r/wlrkqqvg.ritesh.list@gmail.com
---
v2:
- Round the pgmap start up to the Device DAX alignment to retain
  full-section vmemmap savings (suggested by Alison Schofield)
- Update the commit message to describe the alignment approach

v1: https://lore.kernel.org/20261016054914.2601510-1-songmuchun@bytedance.com/
---
 drivers/dax/pmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..d54d23f1cc58 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -51,6 +51,12 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	/* adjust the dax_region range to the start of data */
 	range = pgmap.range;
 	range.start += offset;
+	/*
+	 * When the memmap is stored in RAM, compound page initialization
+	 * must start at a naturally aligned address.
+	 */
+	if (!pgmap_altmap(&pgmap))
+		pgmap.range.start = ALIGN(pgmap.range.start, nd_pfn->align);
 	dax_region = alloc_dax_region(dev, region_id, &range,
 			nd_region->target_node, le32_to_cpu(pfn_sb->align),
 			IORESOURCE_DAX_STATIC);

base-commit: a91337fb5e8e0127c8b5be87be9f3027f95b48bc
-- 
2.54.0

