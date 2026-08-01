Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F63909A7
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553860; cv=none; b=QRVj+MQH62dbOYauVyI5Yf9BlQm1X+vYqlNOJ5M8O2qjQyi/X7NCP0xGZydDfdKoRAXWFJt3Yu7in7Cuktao3P3VGM8Viq9eXqSPE1+amnoLzsblVZ+HrW8s+njhtbSxgSEUDHXLm09Orf9CmlqLRE8bJFf9ewePP+l+bpnvQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553860; c=relaxed/simple;
	bh=hQL8g2waB7BQ7HXsa4tYQ+vU6SGxQJDdHh9YrSoXYsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJCPVPYLCkFqY2VBlarBwwPe51X89W3W5zHhVyTv5NwfpPeAYaR2aXhy1xGjtdvwZWiHfD3oyf4+99AjkvcgYQIoxU7GS0PCDKPBwZBfaUUwT4tvLzl7obcbyEwOSHKxlCK4obnRlqPrPSybAOLZyhZPQ18YZwPXfj30mcv/bLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndcdkn9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndcdkn9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515631F00ACA;
	Sat,  1 Aug 2026 03:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553858;
	bh=kP1bYsGVMi1ul8pnQsiACM5kURSEVy7oPCyP83pPkAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ndcdkn9FIacv4/UD2v+fBE73Pp69j2eHuYrqWxfzsEvKEkZctVW2XBzvsGuTIKSzh
	 02f4XUleIR3l9qMTAajLz4DhiekWunwjebWIwXYg/Gcroh1fOzUaEJg1NU+CW6X7L5
	 W1BNAZn1l0A2pkKcb3UuIe+dY9hpAB8mcQvF6arUqqONpVAsofvoxkBH8u5UvKvODO
	 WpV3ne389AeVn3JbH3zc54my/QG2f+hR3fiLEQ54WygxOfbfsUMIzfMaPO51aR7+g3
	 FCyLwOXuaV8r8aaaPVn3WNY7VZ6KPvrR4OJbSW8uWumA5ocD9V5iVC3masgh0dy5s/
	 5azzSdmUsiA5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@nvidia.com>
Subject: [PATCH 6.12.y 8/8] drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists
Date: Fri, 31 Jul 2026 23:10:50 -0400
Message-ID: <20260801031050.987390-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801031050.987390-1-sashal@kernel.org>
References: <2026072902-purity-frenzy-fc0b@gregkh>
 <20260801031050.987390-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@nvidia.com>
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 5914ae2f88f0..2db968b0f166 100644
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

