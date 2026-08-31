Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E4397937
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210647; cv=none; b=uZBxalhOHZTvDnH8bpkUGi55c+e206AFi0oHdNzyK7wOT/PHCtZy8uXBXWg1okjUtgYyMSwCKAvwANFq1c2/9naE6HVhsXcp/MVs6/dM7S0S1dx2jrGq2ll5sOThVYVmIzJZEjiM4lfWiG0YaMGJJKVSAcYbTSQ840Z2Us563aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210647; c=relaxed/simple;
	bh=7DyqfneiyATJW8YulqhV4rDrcrapDpJbycrJDqbHjwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFn/EkDWQX1Ps9sHn7X33mnDNhdEO0xsihWh/BlGwV6GpC3aVC5M2Bo+UEpgpysb9FIQ/O42BY+JtqPb7fQWP3q17POTxmIcKEwav6Zng+RjQOVczabjI370SJNhsoh2tOyHe12LAUy+HDzT0gLkpVYCwDC8ZPecobUuVz4OJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z32t7nwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z32t7nwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E111F00ACF;
	Mon, 31 Aug 2026 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210645;
	bh=w1uCuMqaMCrlNhh4tmI3mC9YBNci6gjqPisrZ+pX3ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z32t7nwlGqXLc0Xg/DQA6ALCuYqsNfl/wlkJXo4jtgoVZxIqfo6jgKoJ/TB2WuNFr
	 h/PcGdTRVvNZmNQmIKKafpQ1bTKwg/al90Ghhk9VkQlkxqUtlqeErbmgCMV9ZJepPK
	 fn9YiqnJXbqmRpILWl1govOvhZYbxF35pWhzpwKcp2pLhgG/oF07GCpT61q5q3AK9e
	 wdSw0YpgH2LPstmojzBpRqltgUA1Y4GE0ff/ss4gpnx8k5NBvy/Os4LWnR8yweDv65
	 djcSfoiM1ZNwKRGYTIJobYJ1yPjmuxouf/HqF+6GFydlXGJJHNa4191hCd4h3T3SXl
	 scni+vAGxCRMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] usb: xhci: use cached HCSPARAMS1 value
Date: Mon, 31 Aug 2026 17:10:12 -0400
Message-ID: <20260831211039.1799106-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831211039.1799106-1-sashal@kernel.org>
References: <2026083121-usher-contest-f49c@gregkh>
 <20260831211039.1799106-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit 70651cc3f5a4c7cec529f121e36ea3b45ea84778 ]

The Structural Parameters 1 (HCSPARAMS1) register is read and cached in
'xhci->hcs_params1' during host controller initialization. Since this
register is read-only and its value remains constant for the lifetime of
the controller, re-reading it later is unnecessary.

Replace subsequent register reads with the cached 'xhci->hcs_params1'
value to avoid redundant MMIO access.

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20251119142417.2820519-15-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 78203d5b54a4 ("usb: xhci: bail out of setup if the controller is inaccessible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 42e5b05827208..8d35b01ba0252 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4053,8 +4053,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 		xhci_err(xhci, "Error while assigning device slot ID: %s\n",
 			 xhci_trb_comp_code_string(command->status));
 		xhci_err(xhci, "Max number of devices this xHCI host supports is %u.\n",
-				HCS_MAX_SLOTS(
-					readl(&xhci->cap_regs->hcs_params1)));
+			 HCS_MAX_SLOTS(xhci->hcs_params1));
 		xhci_free_command(xhci, command);
 		return 0;
 	}
-- 
2.53.0

