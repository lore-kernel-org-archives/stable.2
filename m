Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7332D0EE
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545147; cv=none; b=UpcfBUjO8nfPIIbpI/hnjYc/9N+TI/CwMnaXp5ZoOETmILK2SnFVQXpXmqVqcta6wge5bE6xkkzOAaudchOmCQXLYdzXB4RYqOPHLjA3z/RXxXyqFL0+nYGRpc5sdwLYuQAloO/kGDuVOJQx0rCjvNYDTWAYRj4objJmth7JkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545147; c=relaxed/simple;
	bh=HMWEiHP8m9mGEQObUVSBWRU+t8STf9EgunnJuGTVWJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4qrxCoY703BMcdzolpaCM9yqS2X7qN8EPKTYYhrUIV526BN+tmcQAQAxXFis6DoKrrm3Ab6hd2gsg+9GGXVYk1qluxroZ3jg2pf/LHvsbJAcK0Btyz2dgyOtAn42mROeVOw727HcOSqbvCBKMhtr8WdfTzQhinzsUrAQ+6wWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0qhcJf/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0qhcJf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE421F00ADB;
	Sat,  1 Aug 2026 00:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545137;
	bh=AJKJJePPq2CUYz2zO53WnYyzJC/2SjDnyCQL0iyfeC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K0qhcJf/R6/kxyDfdtPAAQWHklC4lnMjDHkx/eSpdgdX1EG80CO6O/g1MQuL6le/L
	 J8AYV42TigZTe6r86qoE6LNSyzNFcXtop62MD4DGIXx2JXqkhr84w548M+uEhq4L7k
	 igetM9qmU4T5usU+7sFdznFIvZB3GVZ0j35rAopguklrOCnWUwnYVxCX2zeVnv8Itg
	 4CML/LLWLNvdPlsFaE8ZS9jZhT0tnftzomUX+gzJho5RYXeK1cQH7epMeaAm4I2XTG
	 4ZAxkUqAXi31YSDB0FinoPhwB1+MpPp4O50OFat82N4IH/qOvHIMbvkq7fjzMpPsZo
	 F8v1DeGeZmRbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists
Date: Fri, 31 Jul 2026 20:45:33 -0400
Message-ID: <20260801004533.3663723-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801004533.3663723-1-sashal@kernel.org>
References: <2026072902-gorgeous-negligee-5e08@gregkh>
 <20260801004533.3663723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ashutosh Dixit <ashutosh.dixit@intel.com>

[ Upstream commit e70086a3a06d276b4a5d9a2c51c9330c6cf72780 ]

Unconditionally whitelisting OA registers is a security violation. Set
RING_FORCE_TO_NONPRIV_DENY bit in OA nonpriv slots, so that OA registers
don't get whitelisted by default after probe, gt reset, resume and engine
reset.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-2-ashutosh.dixit@intel.com
(cherry picked from commit 90511bdcfda97211c01f1d945d4ea616578d8fca)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index b9ddbad12a58..235db9f33b3c 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -74,10 +74,12 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 				   RING_FORCE_TO_NONPRIV_ACCESS_RW))
 	},
 
+#define WHITELIST_DENY(r, f) WHITELIST(r, (f) | RING_FORCE_TO_NONPRIV_DENY)
+
 #define WHITELIST_OA_MMIO_TRG(trg, status, head) \
-	WHITELIST(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
-	WHITELIST(status, RING_FORCE_TO_NONPRIV_ACCESS_RD), \
-	WHITELIST(head, RING_FORCE_TO_NONPRIV_ACCESS_RD | RING_FORCE_TO_NONPRIV_RANGE_4)
+	WHITELIST_DENY(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
+	WHITELIST_DENY(status, RING_FORCE_TO_NONPRIV_ACCESS_RD), \
+	WHITELIST_DENY(head, RING_FORCE_TO_NONPRIV_ACCESS_RD | RING_FORCE_TO_NONPRIV_RANGE_4)
 
 #define WHITELIST_OAG_MMIO_TRG \
 	WHITELIST_OA_MMIO_TRG(OAG_MMIOTRIGGER, OAG_OASTATUS, OAG_OAHEADPTR)
-- 
2.53.0

