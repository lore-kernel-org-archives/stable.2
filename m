Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235585;
	b=zcyZBYPJHrosLYsPaL4Ybrp/7cuHiPgNsXK9uApevpdQKr9M1gdrvHRxLhtoyrJ/E+wW
	 xiD1jz48IrzNVRN9IJVFnLA8TXNHzEHZzJtXiD70diyAtPN6C6YSu0HIuxk6yViVUcdls
	 eYc4FdGyinYK+nsLlhrd/eUy30CqweGHxm00GeJDw1+m4kW9gTWxqa3R+HAp5+uUWAciH
	 BVSV7vJh+HnYRcF9MSiPchCCQPev4gV0uszumSz44F3nPdtXGF1mOyMzZMdsBzYidIU5X
	 WfMmU455iHyi/rNg0MCdLekriW4V+SuMRq1PseL9H04YWipsxgGdG0MRgXqcIbGJVdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235585;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=u2MvoQxKr3wR6DNLKTsh6zXYz+g+10WUndpMh+qJbaA=;
	b=3AsKkELbu7GNjq7GNLLxhYKHhJ0ISuWfj4qlRGu/CJ8J5mUbVzydYCaFPKz6S7/f9A1Q
	 ClNb1t65exucms7cdYJs6H/MjjlVsjOZTohi12q+JRvtaQmNtr5Ly7krp2OWLqgeufn7J
	 F4ZrXxJK+KsyGj1piUEb+8/h9NVyw5SFyBrtfs41n7MLY1k+rPTfWLs8m8tHFngdT7unt
	 mN01epJSPUcVq/fHZ9LikVcpqt6sYlMOrfgma/GYNOtGMOHdU+f8RJMztQWE/eJzFGupp
	 IdbHc29Y3N7YDqAKW5vr8KJyM3rZmbr+Ja/Q6c4FUpvxzEzonyV52fMtO4DNNIFGeeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HeW0Qhmf;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB6606A335;
	Mon,  9 Nov 2026 14:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BB6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HeW0Qhmf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794235584; x=1825771584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=inPI/P3T71EMrG5thdTbx9XT//SEB1cDdwB6+qtlGW4=;
  b=HeW0Qhmf8ziSIhyM0dDPCy0V1QKI5/gXsdEAbqEa+oTizTL76EolXKR9
   WjnmPN0/uOExlMyF38nOr70rvZQuzZaKPcdsbH+Fl7ybkhXhwnYADcyh/
   lGYBNA4WCzuMuNeNpQVswYaqMrkJJV7hwP9P5bVV9OO4FETTSsx0QljDc
   NYKIy8ebbCBUx8NCq5vLT3T19Sl7kib/Go0L2P2MCVo7aCIh5Zfofp99Q
   573Ldnw2gALeucjd8Gp8WtZWtN+y2Z9jxw/4z1FsUcrMInq0o3ZGtRIAb
   oqYm8ypPXCbB5ngF1Jrq68SurG96b6LXmnVxZV8rw6RpS3ujP/bZ/cohw
   Q==;
X-CSE-ConnectionGUID: 7qQQEtkBRzqlW5EgLK/iEg==
X-CSE-MsgGUID: 1CYO985VRau2x2lrTr93FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2957071"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2957071"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:46:23 -0800
X-CSE-ConnectionGUID: RBbdS9FrRZGYyuMuYB2v7g==
X-CSE-MsgGUID: PlKoRGd4QIm5hRga7ipBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8044071"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:46:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Claude:claude-opus-5-5" <noreply@anthropic.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] PCI: Fix start of available space for the next bridge during distribution
Date: Mon,  9 Nov 2026 16:45:52 +0200
Message-ID: <20261109144553.2516-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109144553.2516-1-ilpo.jarvinen@linux.intel.com>
References: <20261109144553.2516-1-ilpo.jarvinen@linux.intel.com>
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

After distributing space to a bridge,
pci_bus_distribute_available_resources() advances available[i].start with
"+= end + 1". As .start and .end are addresses, not a base and a size,
this adds start a second time. The space left for the following bridges
then starts at a bogus address, which skews their alignment calculations.

Set start to just past the space given to the previous bridge.

Fixes: 08f0a15ee8ad ("PCI: Align extra resources for hotplug bridges properly")
Reported-by: Claude:claude-opus-5-5 <noreply@anthropic.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bd0974def921..9d8b22d1e6ad 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2077,7 +2077,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		pci_bus_distribute_available_resources(b, add_list, available);
 
 		for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++)
-			available[i].start += available[i].end + 1;
+			available[i].start = available[i].end + 1;
 	}
 }
 
-- 
2.47.3

