Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273157;
	b=YHD02Yq9BdHsHkZy4iB8E0Kuzuxjirbjq5AcEMLTcQNryt9HnNqbEDmaU2r4I50Ika7e
	 yedXzg67hwW/+0N89DsHSKZqhNS+5uXsg+SqfTAQMzZeUs0DYUvpHdpaSJ7HwalK5tjO3
	 w/qBXcF3RdeY/5b87PqrtuPUaGMVVPqW8Fh9dZR9AfTVIe1Q+3ExFyoP0s9YGAvslEfgg
	 a8GTVCu6ywjHCr+AmEyDk2Pf5tTbiMiQ5BWdSVt5Yto1Z6A82yS0mcHEa48F8r5GVc8HH
	 wSw1EwpW83xe2GYTZSA0gVRLfjccuWpoKAnTjcNdCrxpbqoq79QggddfKixxhVQKkEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f6WKEZMfw63UBElQWsxULryiI2MQMMfnS8JHg8W/n2M=;
	b=2nS7goZXIULzBq0ibrvhp2tLf31gjTyV6voZoVRWovxLLFWXGSMDNn+5NyMmlVB0Kvvy
	 uR9MKdmKF23mi12ko6W8pkjlaW78sxktXFc02fnf8Q1ArhThYDxGEWx/JrlyMK6kUoHuC
	 ETzY4b6Z6mgY8HjmK1ub1/26UYbD2EIAImwT3y0O/lb2xh5V+o03bURNBpRHw/1UBrpsv
	 8VnXy/M1pECpr6X9OoDH8kpVyG/vpFjSoxJMz5wk0lJ5l96VEK4R9s4+W6r6VzhuVxAXy
	 ait+H9LXUNTn0yES0Wbb0NpGGGVnaZW9gseYcbRwDEP/dLTjUIcobA2GRx167cxjhdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANzajv8V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANzajv8V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDA21F0089F;
	Tue, 10 Nov 2026 01:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273157;
	bh=f6WKEZMfw63UBElQWsxULryiI2MQMMfnS8JHg8W/n2M=;
	h=From:To:Cc:Subject:Date;
	b=ANzajv8VG3UTVuXXia1ylNsmGrsxnFDniotid5UFcUudhP9TwdvATuiDNYiMJUkYn
	 rlRMO6Pu2PgCKgkBaW3wwAFFumelvutfd/cD8CkYDiMmzjl8bi5xs7tiQJ/J5Hozzb
	 j8/Smpd6tumo5tUQY71tU49yUzYMBC5bLE8pna9PYWoNLkI8JjAcO2I2THO1yuCBVV
	 JSuacZfk+IYlwPzCtY6LXZAS75lH6PPtbgbB6F45PRV2gStXN2LbCQW2i75VRh1TRm
	 zKS3NnYyqxYGURL9iK1LobdycsPz9jVGft+5O07T+TtBFBYyIBFa4BUGFwyaW0B3NP
	 BIQhC+PO6PDpw==
From: Sasha Levin <sashal@kernel.org>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	kas@kernel.org,
	pankaj.gupta@amd.com,
	david@kernel.org,
	liam@infradead.org,
	ljs@kernel.org,
	mhocko@suse.com,
	surenb@google.com,
	vbabka@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/cma: accept memory of CMA areas reserved at a fixed address" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:34 -0500
Message-ID: <20261109201234-failed-6.6-f8f9cbc34a30@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f8f9cbc34a309a388c052706f3329d1b52985aa3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201234-failed-6.6-f8f9cbc34a30@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f8f9cbc34a309a388c052706f3329d1b52985aa3 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 29 Oct 2026 12:18:38 +0200
Subject: [PATCH] mm/cma: accept memory of CMA areas reserved at a fixed
 address

CMA areas allocated from memblock have their memory accepted by
memblock_alloc_range_nid(), but areas reserved at a fixed address with
memblock_reserve() are not.

If a fixed CMA area is requested by the cma=<size>@<base> command line
parameter, it may be in regular RAM and on TDX and SEV-SNP guests it
must be accepted.

Accept the memory of fixed CMA areas as well, so that all CMA areas are
accepted regardless of how they were reserved.

Link: https://lore.kernel.org/20261029-cma-multi-v1-2-2cbced8b5cb7@kernel.org
Fixes: 75d090fd167a ("x86/tdx: Add unaccepted memory support")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 0035efb1130a5..f61d52796f4ef 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -381,6 +381,8 @@ static int __init cma_fixed_reserve(phys_addr_t base, phys_addr_t size)
 		return -EBUSY;
 	}
 
+	accept_memory(base, size);
+
 	return 0;
 }
 
-- 
2.53.0




