Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009741;
	b=FJXx8lFhWhdKZq7G+0ACUQsm7cFUvA2Sg0xCOgB78qv4CFAKx8ka0TfvpoHSKsCMRj0j
	 sJMMAob1/HNyAKVcmrNGr6Tzox24GWJkS2iJ6fdoynicB46pIYhBqddA32iiK3iLDWYdr
	 Ba7pMydz99qFv04OV7VWIV7ZCZgUpHdUzYbDoms8Rbh8Ql5uP5rYQoy0ViNgk8f6AVm9V
	 XJdzRHeRWYHfvxRr599PUtUgZYB1OZ7i6kxepzBT6+fKYWAMBJvpOw4VAUtBZK+9OHfRW
	 TsnAMfijx4fnzCH9VtarWcHMmDpUU9ecRcph3Ieu8NMbyNDUYpQN9k+FkmQcqVUhr0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009741;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Originating-IP;
	bh=D2jbpt4NMXX9Q/t261OKzxoOaYn/y7J8+K/ww+vFFLs=;
	b=EFZNWR5OzbgPVWVvYAx/FkrKQ9eCmdVmvYdJI8a4DXLTwmqHyf6CK8CyPpm6Vd57Yq6j
	 LLd8u21DFIxoGVpxMfshibmjQSY70leGh01104U2ci/W5XsURoQfwLpa0MBCAJ5f3hrDz
	 Vs1XFk6lepXgyzcyy2jRYKniNUbpFSkYAH58auSF8EFWyc9pjXmKxF76hKTnekWSe1trp
	 b/1Y7jsNxqrnCPt+pWKsaDlpfyACfTaK/+pVS/1kv9vh1t/yzl9xOPtdA0LE5zbDOi0Bq
	 R7WU3TsX7Y/R9JyH4Z4spVB/DwORbzJumcGDEp2Jl1FrXbiZj6OiYU0xkJGRIlt+FRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=hsrdR4e2;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F781606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F781606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=hsrdR4e2
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id 3CC5A1017D1;
	Wed, 18 Nov 2026 16:48:57 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id 22A95101327;
	Wed, 18 Nov 2026 16:48:57 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795009737; h=from:subject:to:date:message-id;
	bh=hOEj1zfLkdDSVSsjr5eSTnPdiFLODPEGSeCFzk34h5M=;
	b=hsrdR4e2+5TTN7xYg2ScaKlsNXlYzcgRhOaq45Q+tWgnKIaaBH3591LnO2jsMQzAl2NCzcCZIez
	Rveb5C9PYSQO5VRFrPaCqVXX+jHr1crzMe/mGzgF/Rhe3Y2tJpnvfp2vF8ansTxq3gM9KaEAFXhLZ
	QaqdbgSRHasbxFPDBlDMSCUzTxzYUOfzcCk4A1HCVaPX6CJb178pgAjahsCZbbMX0jzfkzyggXUF3
	awSJ5rxB6KXs5DgZaiIjESFEaBSI45RReXaJMR/8FaKh1NAVnQYaOhQAtXI4GZ7jMOOogI7gcxZIq
	0HWkp9Sskdab4QxYp++tY+zBHaKw9illWb9A==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 16:48:56 +0300
From: Artem Novikov <naa@amicon.ru>
To: <lvc-patches@linuxtesting.org>, <stable@vger.kernel.org>
CC: <pchelkin@ispras.ru>, <rrv@amicon.ru>
Subject: [PATCH 5.10 v6 0/5] KVM: x86: Backport shadow MMU GFN and role fixes
Date: Wed, 18 Nov 2026 16:48:45 +0300
Message-ID: <20261118134851.203854-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Backport the shadow MMU fixes for CVE-2026-46113 and CVE-2026-53359
to linux-5.10.y at 3a323bc22b88 (Linux 5.10.274). A linked child is
reusable only when its GFN and complete role match the current walk.

Patch 1 makes shadow-page sync flush remote TLBs when it drops a
mapping. Patch 2 syncs cached descendants before linking a child.
Patch 3 checks for an obsolete legacy root after reclaim and handles
synthetic roots, addressing the root lifetime issue reported for the
earlier 5.10 backport. Patches 4 and 5 check GFN and role, respectively,
at the three legacy child lookup sites.

The backport keeps the 5.10 page allocator's role calculation, including
the non-PAE quadrant calculation. It uses the existing zap and flush
helpers for replacement after the page is ready, preserving the existing
root-count check. The parent-derived role and its setup refactors have no
dependency in this implementation.

Regression discussion:
https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/

Lai Jiangshan (2):
  KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
  KVM: X86: Synchronize the shadow pagetable before link it

Paolo Bonzini (1):
  KVM: x86: Fix shadow paging use-after-free due to unexpected role

Sean Christopherson (2):
  KVM: x86/mmu: Retry faults on obsolete shadow roots
  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

 arch/x86/kvm/mmu/mmu.c         | 97 +++++++++++++++++++++-------------
 arch/x86/kvm/mmu/paging_tmpl.h | 57 +++++++-------------
 2 files changed, 80 insertions(+), 74 deletions(-)


base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf

