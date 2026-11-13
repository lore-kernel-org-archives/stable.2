Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530774;
	b=W3m3ddAeu0FMWHr/AlbrdsWFn3AXyI9+5hJzdibuOijX4DJheP+RM5cwJgXyio3WFvDd
	 3Dr/Z1AYCTOlV5Js8J0d+4JzfCBxJXBEo4SVO+9LY9lmwlbmoTA6nHBifotMZe8di/V7w
	 ETzt7ymbHX1TTF/68/fnTgdhJpjFOD321NThtz7SoDWRpOiv0JZUukUTix9++2F+zbPYk
	 iaXrzuBp68fJUMeFR62LUs+1z56SaI4xfUfXqlK6DxUi7WjnimphJ1/fHtBJWc7m2UMJO
	 lV1pz7H/9lPffQPF122gmeqvT+/5Xd7BVorRaWFLdvKXf+/YK3k9sXzIqjbFBksAtjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530774;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aFPGn4EId06vZSVBXtJO9azicPXDl+S9qCu5lJakQSI=;
	b=O5atP7KLMQg21ORGmCuB0rtjFB9YWDB5lkqUEUrnvojGBRl0RHJEUvddKpAFVFvmbP7y
	 xTh8nQ+vWujxPpqbhTKs13cJJ2s92LAcw1Emk1kHLEolFshUMXcnwv/ub0OeAvIUM14xG
	 8YkzY2fvCiBkb8fwVpTva0S7424nGJq5+QvKA4Xt3zJ8Jv0aiyRjoknrG5oXS8KCtLpPM
	 XKAJ9kPpHncTKb1tJBdhFUOYXsNiG0ObHA8Ptmj6RWT2lwDgZBiKcTJHcX6qTbX5dS2Vx
	 yy8VSy7ufqkTm3asbL6nYoynXP8NVNHKyTSNxFokPI+t6ArlITNiSZ3zGdwK3wkXeyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hPctx9yK;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3463606A884;
	Fri, 13 Nov 2026 00:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3463606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hPctx9yK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794530774; x=1826066774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fVTy13yu9gq7GWZ+qegA9cG02fANZOPnhhcNFw62mUs=;
  b=hPctx9yK3FjeCyUP2akZyKz7D7/YLdEagcUzRRv+Vh6Ic1Q4yW+hempA
   D6DccEPxlXiBs6Vdca5qTqzYSgYp5BjA8muFB3DljmqRSmV5K4THwXjU4
   0IFnpG4FzTel5ZjULRNRKIwFRfR4DeO4SE2DXSg6+6PoItEUMz6eUu7Qb
   6DuRIkXqp61SM7c7cj1aAgpBgFpoHSIeIo+1O0v3KtlIcTP70+GTXv9WW
   KWwvG1ehjLMn/A11GkLPfgf7lYwylfOKvUVkkxv8fpTXzdiG1PP5tT7XP
   4Pk11BftyRJkizjpDKd+9N2kW7pAajMJg38Q2Fz3bbsykwuQw+QG6zqM2
   A==;
X-CSE-ConnectionGUID: NNP/iMgHT+S4y3a2zrQHhg==
X-CSE-MsgGUID: sqWWBUuwREC5y7p7zCiGDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3361688"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3361688"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:46:13 -0800
X-CSE-ConnectionGUID: /iZ2F3sZSRq+rdub8NIIJA==
X-CSE-MsgGUID: BbOnem5JRPmbpUAfZt+OOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8724624"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2026 16:46:13 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	anthony.l.nguyen@intel.com,
	mheib@redhat.com,
	fballuch@redhat.com,
	aleksandr.loktionov@intel.com,
	stable@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH net 5/6] iavf: fix ASQ command buffer leak on init failure
Date: Thu, 12 Nov 2026 16:45:59 -0800
Message-ID: <20261113004602.129864-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
References: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

iavf_alloc_adminq_asq_ring() allocates cmd_buf before the remaining ASQ
resources. If iavf_alloc_asq_bufs() or iavf_config_asq_regs() fails, the
unwind path elides cmd_buf while freeing the other allocations.

The ASQ count is not set until initialization succeeds, so the shutdown
path cannot reclaim the buffer. Free cmd_buf in the common unwind path.

Fixes: d358aa9a7a2d ("i40evf: init code and hardware support")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
index 6937b7dd44cb..40f76f9507f4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
@@ -60,6 +60,7 @@ static enum iavf_status iavf_alloc_adminq_arq_ring(struct iavf_hw *hw)
  **/
 static void iavf_free_adminq_asq(struct iavf_hw *hw)
 {
+	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
 	iavf_free_dma_mem(hw, &hw->aq.asq.desc_buf);
 }
 
-- 
2.47.1

