Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793240737;
	b=avgiMMfh40reP2AsYi+eiJwMxdRtJAE/VMJrOYbR2WTVY8EE7xCiIN9zYljjCyGMTU4X
	 qe0JXnsl6srEBMJerx1pbU/NcEK0AMAshzMy9Xg4z4lYFncRZd2sN7/QlH4Y/ZxjaGjI6
	 Q1bccQSsWtfh/zcsyYXlROycfoHqDUYRDHpRlYMFkLm35kE9FJs4xh/1/UaQiZukbWX1O
	 V1O47lqNbirF1mI541j4OM/BKi5g27dPjx4rvdAm4D5Emfvjuz4eqhW9Rr1sTn/3/L4nn
	 hqYvU9D7I2f2QTAO6zKEY7CGlIoPn5aFhSVutWDjRJGZm0guWL1ut2aMk6Z0mx7z+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793240737;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=x24bZLWBM/LicqTiRgYPs0yGqyDzPgZxkpjpOAFpoZQ=;
	b=5CIgEim9i6+9K10Cvs6xAdAgSwHW+KE495wGWHj+dDtklXYL75SMvyqv+2IgnjUxj4Oj
	 9YRckfX3e4hja5ds/J/ciJ9eNh1UokTS8arr4nmeAqeIFCc2frqQCy8bjrEBwWqaJp0r+
	 5xu7YEIvHVIgULGxrVYJzmrFfeXsc8l0RKz4MuVCWzKF2JcqoHzDtNkstidejEDFVSlCE
	 ZAwE3HpafwIiWvJgUMH/5z3oQIndUxblNsO+goHFiJnwUVaQO63QSBCttTUvIho1lWmDK
	 shSfaozJeWmk6Xc5H+dIkoP2tDgwaIn8WDicRoJiexr34YHw22zealZMu6vH6UZjr2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=bw8UcsAb;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9D606A327
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96A9D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=bw8UcsAb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793240736; x=1824776736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x24bZLWBM/LicqTiRgYPs0yGqyDzPgZxkpjpOAFpoZQ=;
  b=bw8UcsAbHW/kgEVyflpkvGJecvNh1yxymVVoWNOLJhrOnjJVy08d1hKc
   I5WI3ibRtv9p7T6eLozZbwJpQH5mZlWYP4gWFJjPk6E/voQSFpybl6kID
   6QeCCAIeZHMaVpSvtYSWbBMOzVENjmG3m4U05QBOzEzMbKhZlfbDjmlL9
   iqQqeDN3lP++Zq+cF+MGAXXYED7OJfAYaa+lm7f1zr9ko/mPb8+qYIT+H
   F7ChXqSzi8QhhcsnwCDEq3f6qq3ixGzOiRf8TaaYX0tloYJ7SumOYlD2y
   gm+xyktZ5BmF6xj93RTd9/nO8BpatHLJbb9kMzecfHVlRKOwOxsQxWU3/
   A==;
X-CSE-ConnectionGUID: e7kZNjV2RpGPmfy6hDJtpw==
X-CSE-MsgGUID: jLYuy3qNQxacb5idhzCH6g==
X-IronPort-AV: E=Sophos;i="6.27,183,1787011200"; 
   d="scan'208";a="32433882"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:25:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:28803]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.65:2525] with esmtp (Farcaster)
 id 025f824c-39b5-4858-9d97-f396d1c04e53; Thu, 29 Oct 2026 02:25:35 +0000 (UTC)
X-Farcaster-Flow-ID: 025f824c-39b5-4858-9d97-f396d1c04e53
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 02:25:35 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 02:25:35 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Fuad Tabba <fuad.tabba@linux.dev>, Hiroyuki Katsura <hk590@cam.ac.uk>,
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.6.y] KVM: arm64: Transfer the hyp stack pages out of the host stage-2
Date: Thu, 29 Oct 2026 02:25:09 +0000
Message-ID: <20261029022509.2631522-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit 3a8c562892b96f35bba1e00d5e455a15963bbb92 ]

fix_host_ownership() walks only the linear-map alias of each memblock
region, and the per-CPU hyp stack, mapped in the private VA range for
its guard page, has none.

Walk each stack's VA range with the same walker.

Fixes: 1a919b17ef012 ("KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack")
Reported-by: Hiroyuki Katsura <hk590@cam.ac.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://patch.msgid.link/20260908110713.1540304-2-fuad.tabba@linux.dev
Signed-off-by: Oliver Upton <oupton@kernel.org>
[ 38f9e4b905a0 ("arm64: kvm: Introduce nvhe stack size constants") is
  not backported because it converts nvhe stack code in eight files to
  NVHE_STACK_SIZE, and the hyp stack here is one page, so PAGE_SIZE
  replaces it. ]
Assisted-by: LLM
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 29df463ab350c..e8c1f975e38e8 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -240,6 +240,16 @@ static int fix_host_ownership(void)
 			return ret;
 	}
 
+	/* The stacks sit in the private VA range, not the linear map. */
+	for (i = 0; i < hyp_nr_cpus; i++) {
+		struct kvm_nvhe_init_params *params = per_cpu_ptr(&kvm_init_params, i);
+		u64 start = params->stack_hyp_va - PAGE_SIZE;
+
+		ret = kvm_pgtable_walk(&pkvm_pgtable, start, PAGE_SIZE, &walker);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 

base-commit: 0aebf2870d53a8d97e02a99e2103ea0b38950c1b
-- 
2.50.1

