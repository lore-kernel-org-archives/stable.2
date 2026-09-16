Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617C3B19DB
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599179; cv=none; b=il1XkSnUF+TziUDT6VyXHPND/d+xfM8/t6DkaLl1GOUldRvf1IyPHamhfY3VwJUbZbAHqGQyEFjT70L7nYhSUPac3T/jf2m5TNPPESIsFYCauaVj+0Y2+cjT1QRvz8LkbtPqgAofmZG4JVgDifr2w+D/NdyHEkjRlqRtdGcXSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599179; c=relaxed/simple;
	bh=qYIOkKP1Hmjmb64uqiVQboA5MyY0vpv+JJPY7UD78is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bo51aG7B6BSbeRKJ8eFfDPSnAYVQOiJwMwqpgkV4q7ua+EGSfrP0rw3ZXqD8otKJWwMc+IEkeXuhxLlFssLh6iwcyy8WVc+EFOQk/7ekO0reOGZoTlHr1oeMAZZkYtPvOAebGpqS4TLjyOCRFMuRrkwgZDpVXzP+Yv2S3wNv4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcuaHG8D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcuaHG8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789599173; x=1821135173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qYIOkKP1Hmjmb64uqiVQboA5MyY0vpv+JJPY7UD78is=;
  b=OcuaHG8DtvxQdILHtMqiLsRKBEXME8L1b9DBse/Uv3N/yTv4T8B2y3e5
   EFRtT0yQYsCrL+3SE5DOiCGhfXXYtlCop0iL9+LYvhBV1vKT7eFd5ykOS
   qrH247v6saxmEzOZr97vP+fBfe+9URENkBaLjObFvNf2P+T/QIoG1EemQ
   oxBFOzUZBuofhUP3YYWnQZo8FkYvAi4wBOF+ZXPARUUdLd5ApSk6b0VLk
   aUMDc9TOIZqlrYl2C83+Ijr0IezQCGWoJg3Vo7bJQe4w0bY1HUjWv1Sts
   Clka1rWgvhmcHnsKFVuCD4D0tu3aX4Hdeng3WaruppeVQOgbMP3W0Ety5
   g==;
X-CSE-ConnectionGUID: Wjiz5+E/RqGQaB1V6IbKEg==
X-CSE-MsgGUID: +UzHfVnuR/e3TwdHWeg1NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77547666"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77547666"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 15:52:49 -0700
X-CSE-ConnectionGUID: 1eihwxtYR22o7jw/28tFJQ==
X-CSE-MsgGUID: bEsMYJlFSC+e4HbEvP4ESg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272018133"
Received: from cdjpc409-it.jer.intel.com ([10.12.50.120])
  by orviesa010.jf.intel.com with ESMTP; 16 Sep 2026 15:52:48 -0700
From: Gil Fine <gil.fine@linux.intel.com>
To: mika.westerberg@linux.intel.com
Cc: gil.fine@intel.com,
	gil.fine@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] thunderbolt: Fix DMA credit limit to use host router value
Date: Thu, 17 Sep 2026 01:57:54 +0300
Message-ID: <20260916225755.45127-2-gil.fine@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916225755.45127-1-gil.fine@linux.intel.com>
References: <20260916225755.45127-1-gil.fine@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when allocating credits for a DMA tunnel, we reserve credits
based on the baMaxHI parameter taken from the router that owns the
ingress adapter of the current hop.
In a host-to-host topology with a hub in the middle:

  [Host1] <-> [Hub] <-> [Host2]

this incorrectly uses the hub's value instead of the host router's.
The DMA engine limit is defined by the host router baMaxHI.

Fix this by alway use the baMaxHI of the host router instead.

Fixes: 6ed541c53edc ("thunderbolt: Allocate credits according to router preferences")
Cc: stable@vger.kernel.org
Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Assisted-by: LLM
---
 drivers/thunderbolt/tunnel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 7a033df7f916..0625b1ff3820 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -175,7 +175,8 @@ static unsigned int tb_available_credits(const struct tb_port *port,
 	pcie = tb_acpi_may_tunnel_pcie() ? sw->max_pcie_credits : 0;
 
 	if (tb_acpi_is_xdomain_allowed()) {
-		spare = min_not_zero(sw->max_dma_credits, dma_credits);
+		spare = min_not_zero(sw->tb->root_switch->max_dma_credits,
+				     dma_credits);
 		/* Add some credits for potential second DMA tunnel */
 		spare += TB_MIN_DMA_CREDITS;
 	} else {
-- 
2.43.0

