Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9D3BA244
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415536; cv=none; b=dizjbV9ydaVG+yrJOd8XZjQ8vVbd3glQHCGZ27w6RXC+Xc/JULVSy4s3H6OsggKQCu4t69rdplqH7VPVC2o6qZ1wTXB/z47lAYQeK6hForm3Kruki1PZBsejrvcuvzaQ+J1ADHzQX+lRhEdxRNiLMuWTmJKtJ6SCdHeBdMMLrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415536; c=relaxed/simple;
	bh=RAL3ZX7gX3Qwt4a6LoAFqg4/b9gWA2A+ezozkGYu5v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNcmjJAySDK8xRVCDT6wdiSpxfp2dwra1pAA6xYtzpN3gdiPUs72zuBUmjXZ/U/Jgh1NGJ8OUNOXXaJPWTfkygqjszIEaUIL74kROpBYbI8QHHar8k11CGn+X18dUEFWtDt2o/+Bz2l+xKlZDSSOFjNtWlYHoxmzpdFNbnFNDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0wZVm+y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0wZVm+y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so11405215e9.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415532; x=1781020332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcSYq5CNRe914+kh+MhUoX6E3CbZbAlZ8MDYAoh0zI0=;
        b=D0wZVm+yPCQCUkDlqARJFBllvw1zfPTP3YXy460qUBOs+SkuKaLPX0+4G2Fhj3UIE9
         +GVh0dZmh6tY0zokqQFa8q8y06ssjwhSTJQ5Xpf2rfMB5/EDHv2MnCg3EDg3grmEj01Q
         DU37Re78vyEQLlfePfrySp0K89hJ3JIekz2yXvBdsXsMsQ5EuTsnS2Z2kZtZrpiL3aQc
         0/S4/CHuNf93ZE/uEcP/aOLM4rpmKDkgVa+ueHsihYHhX8xLEr5NY10bG9MfrJwaQb9J
         DGbgiph62Mf48FlLvlYm8OFWqF2pSzVA6FmNglM5FLcs2mFMyP9r1fHY3Gh+MTVZCa7u
         MIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415532; x=1781020332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcSYq5CNRe914+kh+MhUoX6E3CbZbAlZ8MDYAoh0zI0=;
        b=NXBNrRQoza/WHOfT3xcPA4q5WcJmNaGiCbooyipZoak9XCjVFMqwIojYoBKzsBLkqV
         i+jdktBTVeV4v92eudNOMgo+P7qe5DqY+B56G/+xA6er8GyafgXk6iugUh5XSW/PMS5r
         k3lGgbwZAZtMtOoX/7bimIMghfT6+fu34k/HgZ6T1AqJTb8aaZRrxOY1ROtsiUWlJiyZ
         Z8xNi0e3YgPqy664w40ViRastU/eAvnRIxa+wapmBY7q2EymBeUL/aUwzBgQbYrFpiXV
         1Pv6vUZHrLZx/OCKQuSy78nlt6Swmy1eMSlSJHt92trxQmeM7ggyLlu5sfvZcvaA3EYO
         /8uA==
X-Forwarded-Encrypted: i=1; AFNElJ8Bs2uCHQva9Pd/ZR6tdj0apUKjFbaXqv+6aZU6MR+Og5ui1fBrqktlaih4qHXATybiGqxcPwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fdGinLBPXiK1NndbLJInIM6Ke6tCmwLYN8PhdrePCVXxEZSl
	ei93nezbeiVMLtW+1ePUUbUYORFwolBjgs465T0g2H7YVqZncZLPlyPk
X-Gm-Gg: Acq92OESyy7dQznMWvl73mjOX6WSfFG6hucy6eq2B0Kc2SgaLoViN3vMF/G2Bx3raN0
	Hfinw1rXvzXOho7mUnHSIvTxGLm8v38oo2e3czTDRgHLStf8XnXzKca1GmtMYRWULAHGo8HuVby
	+xG4zhwJIFE2gcmJHpO581lNUBO6S3mtKkzQEk6SQYQTLuqDBuJUxmf1lyQBiZ3DN844Ytk6VlF
	vYRFEfe9InqVlpn0jOMIEP3iFMFPWmViDwftiXwu+3B3q2sVP2MRIBeB+ZWZobjp0ndQwrXgzMu
	2HQI7cm6gMHeLipcyJnY+Mt46ayMhLuMbd88IXldIEAeIWTRDUd65CGJ7M41iG5v0Hs1wM0TX3E
	rd7cH/4Bn/VoCWDKUkp1uIFTfGqNEusfbJPoqKOzhOszoCyIrlAiPyRBus/7Qtl4efQYgsDEHyR
	F/yULDt8SRElFZUk3h6UNijjsQwj09JlPOfX7BF766KWL5fKk9fOUixQtPE6J4wSf3mw==
X-Received: by 2002:a05:600c:8b2e:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490b50c634cmr4713175e9.26.1780415531774;
        Tue, 02 Jun 2026 08:52:11 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b55fda1dsm108445e9.1.2026.06.02.08.52.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jun 2026 08:52:10 -0700 (PDT)
From: LeantionX <leontyevantony@gmail.com>
X-Google-Original-From: LeantionX <leontyevanton1995@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Leontev <leontyevantony@gmail.com>
Subject: [PATCH net] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Tue,  2 Jun 2026 18:52:10 +0300
Message-ID: <20260602155210.90987-1-leontyevanton1995@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anton Leontev <leontyevantony@gmail.com>

netvsc_copy_to_send_buf() copies skb fragment pages into the shared
VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
x86 with CONFIG_HIGHMEM=y, phys_to_virt() (i.e. __va()) is only valid
for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
address that has no kernel page table entry and lies outside the
kernel direct map, so the subsequent memcpy() faults. As this happens
on the transmit softirq path, the fault is fatal.

A HIGHMEM fragment reaches this path whenever the page backing an skb
fragment lives above the LOWMEM boundary, which is common on a 32-bit
guest with several GiB of RAM (for example when the in-kernel NFS
server splices page cache pages directly into the reply skb).

Map the fragment page on demand with kmap_local_page()/kunmap_local()
instead. Using pfn_to_page() on pb[i].pfn maps exactly the page
described by the page buffer entry. On configurations without HIGHMEM
(amd64, i386 without CONFIG_HIGHMEM) kmap_local_page() reduces to
page_address(), so this is a no-op there.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
 drivers/net/hyperv/netvsc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..6984f6c97257 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -965,11 +966,13 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
+		struct page *page = pfn_to_page(pb[i].pfn);
+		char *src = kmap_local_page(page);
 		u32 offset = pb[i].offset;
 		u32 len = pb[i].len;
 
 		memcpy(dest, (src + offset), len);
+		kunmap_local(src);
 		dest += len;
 	}
 
-- 
2.43.0

