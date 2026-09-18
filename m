Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD474503FB;
	Fri, 18 Sep 2026 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710628; cv=none; b=dPy0OWMoIUv2spOyYEdNI/A4/LZJZsPy5uHmpN8SuflvcS4Bj3RM4V2wvM+EGbCQXFM/gU3xP6Dzc+73hqD7/42E1MwjvuykmiSEgLJH+4jC3V03FZLuRe+Ltx0QsqGlKSiyxevmbCJ8MeABm6Lp2Kk1GakoZsIK6dCDwdf9dpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710628; c=relaxed/simple;
	bh=8MufMY9lIRnGTi5h9BPJYfykr099yQoG0Pih9buPj40=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mKBF+HWclrVP/gi3qQEaMUmO+OnGPYKaAK+A3FQOOkaUxGf5caa8wjSW7F7qMh2Z4eiLxfSwjyZgQDdfJMhxVxNeGiziV0EZvWQCCev7MfhFmHx6Ib0SJGM02ny9++JLtgd8EAvNSsjCwpCR+vNhhXaKHspXtRCoSfAtW7okHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QAt/GI0q; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QAt/GI0q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1789710614; bh=l4vt2RgI+Np3N8Wg3Ybz8eb3RVuLRt/R9ZyL/paN+7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QAt/GI0qpUZxHkcaVyoYAuH6efpCDGtTUbC1kXn4i+4/QNTnXEn3Y4m8MQ6bN/JGt
	 6XpnqTh1r0AUXpbbnEsasXnWuGdLiUKCCY/aj7/fmRVUmEhLl8x3iDA5SPAK571c1A
	 nZETciNH4aHiOQW3BLmMOUll9L0X2q5G7cj4Qq8g=
Received: from XJSH01426.meizu.com ([210.13.72.171])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id BB1B8E26; Fri, 18 Sep 2026 13:46:49 +0800
X-QQ-mid: xmsmtpt1789710409t0a17l4zi
Message-ID: <tencent_25C26948D9C4B056CBF12565F0600C4C2509@qq.com>
X-QQ-XMAILINFO: Od++Svt5p/ChIvJnY7Kp28UcdL91q3n2D9numSKrnNEc2IY/xjBuIKrvEotTQj
	 gEZNGpjuPNRZ8PFx9KagA/iudpU/dosFH62M9gixDs/kBd4fMSt8OP/vFpJCRMVFFTLsmM+zxHp8
	 nO7+NY1dmwIQri+NyAsYuU8XTx0FZeuwU7Bm7ZL4EpfjCyO3rreLyF3dgX2aNGZixCNctE0PcrOB
	 /Bdsn8Ni8nTHIuset3NyKibNhq1hjR3Z0gD+Fso8fQ4nTA7N/kUkN31szqQVijSemSGEXFC1yq+w
	 BaMshHw+mOxOT/qY01v8LEdoyJXejhKgpmzKO69zrHWlhaPuimwbpCMnmls6utvMLZwge37JS5r5
	 lq7WwoXuO+xS+STQrgNFFczLxq+U3y8RQa64XUwX0Q1hsIZIwqq9fJM0Y4oZvdg962nJ1ySE08S3
	 MM4VsXNVLXdTVwls0UIQTZEtqAyyn/WebpczM+iM+iLQ4E4haoHQ1/1L6/84Z7YKTvHTAEkME1D2
	 w0kNZbVv4cav7jubQodWVMkIq+AmlB9AEExvh/pc+fI4T6+rLkEIj0mE/XipLL52XGjk/vj6qQbp
	 CJcAQceP+4tDt6ZRooyU8hUgLq1BMzed+6m+kXhAl5MwpVxFLOXkjWJ+YaL4ahkeEiRL+POdOU77
	 ap7bckstJRMbKwM8iY5KLcg3E1wrM4KFk/GK+w2Hqoka4Ikdx+QLfRii9Bm+bPPUYB1zqEaMq+qG
	 SfkjkcXXKe6WUTuG3weVqUq27+00jACGIZAt4U1+e3EVCWS5vEM1WRwBgh5STel59xojExMlTXVD
	 ILGYIPV0ZkZUf+dnDs42mxcm/hs9Xz0/3Ea23rogNHSWNsQWJKOq9MaMxcxKgPm1vGgHRjeMyi/q
	 EqVizJQ1Stttl8VpRHXJgZ/v92T8chD9s9KfghdknZ5i/vXAJsebW23aU7Qw6E3HdRpyCwYLWZAO
	 pL+3R819jEazbCH2aD6ZSEpKEI1K0l1gDrPOl4xFd4d0Rnk96z3dY7quwqmmRP+MlM6H8K+Ro+cq
	 gp7w1LRB6gMvd/tBXAI2KjoaSCFHo8jG3d3Hw+BA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Zhenghui Hao <zhenghui.hao@qq.com>
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-parisc@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] parisc: parse early parameters in setup_arch()
Date: Fri, 18 Sep 2026 13:46:49 +0800
X-OQ-MSGID: <20260918054649.958466-1-zhenghui.hao@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7c90662b-903e-4624-bc97-96b1187332c5@gmx.de>
References: <7c90662b-903e-4624-bc97-96b1187332c5@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parisc is one of the few architectures that does not call
parse_early_param() from setup_arch().  That was mostly harmless until
commit d49004c5f0c1 ("arch, mm: consolidate initialization of nodes,
zones and memory map") moved the consumer of several hugetlb command
line parameters into mm_core_init_early(), which runs before the
generic parse_early_param() call in start_kernel().

As a result hugepages=, hugepagesz=, default_hugepagesz=, hugetlb_cma=
and hugetlb_free_vmemmap= are recorded after they have already been
consumed and are silently dropped on parisc.

Call parse_early_param() from setup_arch(), after the command line has
been set up and the memory inventory has been taken.  jump_label_init()
must be called first because early parameter handlers may enable or
disable static keys.  Both functions are safe to call more than once:
the generic calls in start_kernel() remain in place and turn into no-ops.

Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Fixes: d49004c5f0c1 ("arch, mm: consolidate initialization of nodes, zones and memory map")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhenghui Hao <zhenghui.hao@qq.com>
---
 arch/parisc/kernel/setup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index d3e17a7a8901..4d3015a411d6 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -132,6 +132,18 @@ void __init setup_arch(char **cmdline_p)
 	parisc_cache_init();
 	paging_init();
 
+	/*
+	 * Parse early parameters before mm_core_init_early() runs.
+	 * Several early_param() handlers only record data that is consumed
+	 * from there - for example hugepages=, hugepagesz=,
+	 * default_hugepagesz=, hugetlb_cma= and hugetlb_free_vmemmap= - so
+	 * the generic parse_early_param() call in start_kernel() is too late
+	 * for them.  jump_label_init() must come first, since early param
+	 * handlers may enable or disable static keys.
+	 */
+	jump_label_init();
+	parse_early_param();
+
 #ifdef CONFIG_PA11
 	dma_ops_init();
 #endif

base-commit: 4982d3552a3bf94de503acf93433277d08421de6
-- 
2.53.0

