Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972532D5932
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075550; cv=none; b=eLN/W/d5nIgBxzuYj5xNAIv5T2c5XRt4uy/yK05+L/UM4z7xAk/POb5YQEXQ7SjH/xUYNkUur8QF4Y7XorIzHAsJHeWi0vE9ULDayLkYi7JXVb6dmFOjv8vPoi049FdiUAoa0kPQE9peQh0mvQ428Z/bI5dOdemMhu8cHP+DZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075550; c=relaxed/simple;
	bh=WXZiTwlIziC1omOj7jdwQE8zzogbpJNb1lBXEDWv9Gw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqcAV9ZS/bpyZ1xoHf7H9berFFfiqv8hKscT1Nw54BXlbvFFsYKaC82Tc/VzU5rSTOzRr1WTwPWysUhYxHKlI2RBYHHfnDzVK+MurbyryeYEF9ktbEHHiXr4rC8a6+J+VZ96jeTJJWVOuBIToDBptdh02iZxZxhoVO46eEZfd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=RK2JeQd2; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="RK2JeQd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792075549; x=1823611549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T8axlsfso4k7syKxUcvyIg6Ym9y5kFkDYTWkZAR8ayk=;
  b=RK2JeQd2nuB4wdxVOmlM+97DdrbbtYq1OQMWJlVu3QeUTfWoFRwSehi6
   yEFSCPGMA+Td+INfJ5pSH1GU9xBPurXslmMJ6ZrKAV4rkcVGKsZIu8T0Q
   6tjMAqYCt7z5hhU3xCLEC2yKcs2brwyra6s/XUhTjmFj7J+DAvFC6fTPX
   3mju1XIkFqyD+eQFWRoQMT5zi/olJcHr/SYX6zfKozFm1lkJ3BGz6hffD
   TAZec3eV7ZOCWEl1AySDDT3M8+9+rZBkgvQD3jeM21VtnHrZno5XzQIpq
   2RWHqJFxdRzp5+hUMNi9KbpnVZ5Qj0GHFxlh/ChjgJ50eIJkNr78+0sPn
   Q==;
X-CSE-ConnectionGUID: opeVRcGqQHGuOktxkplgOg==
X-CSE-MsgGUID: aF+8dlOhT5+24Ki2k86dnw==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31124997"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 14:45:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:18197]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.38:2525] with esmtp (Farcaster)
 id f94577a4-6cf0-4788-b26f-4e1b3530fd63; Thu, 15 Oct 2026 14:45:46 +0000 (UTC)
X-Farcaster-Flow-ID: f94577a4-6cf0-4788-b26f-4e1b3530fd63
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 14:45:44 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 14:45:43 +0000
From: Federico Parola <fparola@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH 6.18.y 1/2] kho: free chunks using free_page() instead of kfree()
Date: Thu, 15 Oct 2026 14:45:28 +0000
Message-ID: <20261015144529.76911-2-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015144529.76911-1-fparola@amazon.de>
References: <20261015144529.76911-1-fparola@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Pratyush Yadav <pratyush@kernel.org>

[ Upstream commit b15515155af735a86e5bcd67ed739162f0de27f5 ]

Before commit fa759cd75bce5 ("kho: allocate metadata directly from the
buddy allocator"), the chunks were allocated from the slab allocator using
kzalloc().  Those were rightly freed using kfree().

When the commit switched to using the buddy allocator directly, it missed
updating kho_mem_ser_free() to use free_page() instead of kfree().

Link: https://lkml.kernel.org/r/20251118182218.63044-1-pratyush@kernel.org
Fixes: fa759cd75bce5 ("kho: allocate metadata directly from the buddy allocator")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Federico Parola <fparola@amazon.de>
---
 kernel/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ac9fa7727b5ff..9fe5d14f1ec54 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -365,7 +365,7 @@ static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
 		struct khoser_mem_chunk *tmp = chunk;
 
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		kfree(tmp);
+		free_page((unsigned long)tmp);
 	}
 }
 
-- 
2.47.3

