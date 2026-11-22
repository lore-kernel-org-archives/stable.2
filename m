Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373473;
	b=mjvi6Nqd/xjv2ZcFEOI5tlatYPfLbUvq5qm7RfUejuG+Nz9OTHdSieVldM4gu9t74DZV
	 5PNnSpeG0dWFPkJTvATz5BSvdHOXbMAJV2Hl+c6IMAFoa+5zowKZAfG1U5aw2S3OlzL5u
	 vCA7BoG38RtvpYBFbP+FaSM73DCTI3bQQZM379+dwGPEjUP8cI5tJFv9xL4iFcDC2tITr
	 6YkWn/OjBsC8SnRHGYOaT2+B2nYhQM5IVHljvEirV/Hj996xZjDeBEKzgGWqPn1eeaPz6
	 OLgY8t4+LR8hDiug2M6+i6kFjwFRjkGzqwdMvy63m+OMJC68G2qXjjwa9XdcDgNEOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373473;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=50wCei2ezE7qqlKPwEZQKfaQvojP+aADu/REaQZidPs=;
	b=QcVCVTAaJCWsWCbvcagdixju3bRu9F7SFkNwIRuhKuBHx3CjzchCQKDnA9FwCXvTyyYV
	 YftTakzj//y7cX4s45QukxjqCPuYhsLIBaIgBqXu283s+oisnG8WE9RakyZrVecTEH34x
	 QQl/AUOdRfeO9LXTrQDcOKIvkNEf1UGMSEqN+ucEgcRhZNZphBUdUnX4uKriq6Kc2qXw7
	 PaAzc3srwMHYHtHgi44bF7oh7U/DckxnAXjFgygXJGBRl8bl2boz+ryxH8I/zBWfCL2b0
	 jyap4oUmrBCfhmI+LJMuFGff/73ifR6H5lJGIPC0ISadKuQayiThXAHhrNg8kiQwapA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DeORfqno;
	arc=none smtp.remote-ip=95.215.58.203
Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6C606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E6C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DeORfqno
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CGiHf1+jeEEE2NgCdnd+kn0vFA9jhJqMPHDtP1DXzTo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795373469; v=1; x=1795978269;
 b=DeORfqnoSh0rdqxELAj4spb63VFK2xQzhpJ8ltJW9dd6VmhU53G9kQKy32CnHH6odAzp6Ipj
 XHPwQ4vkCBD4UHK8nSWE5AL6+xDY+RF3rm4FrqSUFOGdthD4VkJ0STyEZrAUKniYJyBknlLCFHd
 Fw8eQ38yC5/qPFu8v0OyyoSM=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 57ff06e043170ff8;
	Sun, 22 Nov 2026 18:51:07 +0000
X-Mizu-Trace-ID: 57ff06e043170ff8
X-Migadu-Flow: FLOW_OUT
From: "Nico Pache (Red Hat)" <nico.pache@linux.dev>
Date: Sun, 22 Nov 2026 11:50:36 -0700
Subject: [PATCH] selftests/mm: honor VM_SELFTEST_ITEMS from the environment
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
Message-Id: <20261122-vm_selftests_items_fix-v1-1-9edef5e7975d@linux.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM7QqCQBCF4VuR+d2CM4RJtxKx+HG2RtJiZxNBv
 HfX+vkcOO9KhqgwuhYrRcxq+p4y+FRQ92ymB5z22SSlVMwibh694RUSLJnXhNF80MUF5rppL/V
 ZKlA+fyLy/Avf7n/btx3QpaNG27YDejFqxnoAAAA=
X-Change-ID: 20261122-vm_selftests_items_fix-f118ab78426e
To: linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
 Tianyi Chen <hi@tychen.cc>, stable@vger.kernel.org, 
 "Nico Pache (Red Hat)" <nico.pache@linux.dev>
X-Mailer: b4 0.17-dev

The unconditional default assignment overwrites VM_SELFTEST_ITEMS from
the environment. This regresses environments that use the variable to
select test groups: without -t, all default test categories run instead
of the requested groups. The -t option continues to override it.

Fixes: 4844f5b84a8e ("selftests/mm: reject invalid test selections before running tests")
Cc: stable@vger.kernel.org
Signed-off-by: Nico Pache (Red Hat) <nico.pache@linux.dev>
---
 tools/testing/selftests/mm/run_vmtests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index a1b45a3dedae..aa63f840cf60 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -102,7 +102,7 @@ RUN_ALL=false
 RUN_DESTRUCTIVE=false
 TAP_PREFIX="# "
 
-VM_SELFTEST_ITEMS="default"
+: "${VM_SELFTEST_ITEMS:=default}"
 
 while getopts "aht:nd" OPT; do
 	case ${OPT} in

---
base-commit: 2dc60bd9975fc8666a13d58410499e06e6799ba9
change-id: 20261122-vm_selftests_items_fix-f118ab78426e

Best regards,
--  
Nico Pache (Red Hat) <nico.pache@linux.dev>

