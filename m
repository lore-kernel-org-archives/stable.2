Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD5310645;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501415; cv=none; b=mYx1O0AiOe/4XG66NSPjGKz4rGHhP7RFqD4U45sPJViu7IQrprXevrGTNMP8LpQlCum37SPAeW2G/saNBgqiwfNTtj0aaO/kMraz7FdlltmCjdIcE3amch7vHBqVI6OCkZQVOtaWAYKMiCTOvHmmc9iJD3INDvE80y001Uora70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501415; c=relaxed/simple;
	bh=SXsFoeeEfcibtEXf8lradzcC9odTvodt9bD65D+EBQM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WvD1XzZ875Ex5FO7qmL5Lzj8+bfx7PhTBoWg6mwHyOin5nquWiqElDuBiDsRXrAX+ojjCdBeFOpa0hR8Ms7P040tWLE7xuDlZSgq/STs7tdJ6LyY8qgWHougNE1ZrLuz1WpUAA9zTfDoZ7tLCX9M2zYeoEL2jseihm8lqQFRMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFB6xExP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFB6xExP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FD9BC2BCB8;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787501415;
	bh=SXsFoeeEfcibtEXf8lradzcC9odTvodt9bD65D+EBQM=;
	h=From:Subject:Date:To:Cc:From;
	b=oFB6xExPpIF/bmPlQf/xKkBy/MBvfKjbowszh4jctCqnOQYI1fgHuR9ELgcPcXWci
	 3e6ql06GCjzrIkJvoOTWGtkB12w0qA0SAPfxrz7d+5cxSkt9P7sMwrv4OCjPuLR6De
	 E3N1QK66QU0orjcwxDINjG2pVMyB+80ALq51JxcPyyZpX+rLIcQ7BNiCi82pKiRqoY
	 Pf9X08wHfk/KP+aMNjppXN2vSPr13YzsnX3B/jJpNJCbq0xev+G589ZsVZIPc4p+5x
	 5IWEnSmXm30y28D325bspNSps3D3XR9Mxo2iP9VKxnWpjuSxxzIjMLsWFA/q7xNlRk
	 EQkCixoJ27KjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA26C5DF8C;
	Sun, 23 Aug 2026 16:10:14 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH v2 0/7] thunderbolt: Fix DP tunnel teardown while an async
 DPRX read is running
Date: Sun, 23 Aug 2026 18:09:13 +0200
Message-Id: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQ7CIBREr9L8td8AabG68h6miwK/LWpaA0g0D
 XcXaly4fJmZNyt4cpY8nKoVHEXr7TJnELsK9NTPI6E1mUEwIVnLG1Q1BhVwsC/y2AvZHnkrGZc
 G8uThaAvy4tJ92T/VlXQojtKYrA+Le29/kZfeT334V0eODMmQEbXkQzPo843cTPf94kboUkof/
 iyIHLsAAAA=
X-Change-ID: 20260815-b4-tbt-fixes-a2689186016d
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=SXsFoeeEfcibtEXf8lradzcC9odTvodt9bD65D+EBQM=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1a3tN35H1OSouYdErSLb7aRvf/Lr99llnRhuco5rWyGq
 IWWH6w6SlkYxLgYZMUUWbbvtzd98vCN4NJNl97DzGFlAhnCwMUpABPhEWb4K51ypP/0tt8Gfxyy
 9mYE/nM2lHolU2W0xS6jXn+RjEXkdUaGe64bz22ouD196XHV15ps8TvZv732rtQMz/i1g3OXl8t
 9dgA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Hi,

This series contains a bunch of fixes related to teardown while an async
DPRX read is running. I ran into some of these while bringing up the
Apple Silicon NHI and just haven't implemented DP tunneling support yet
such that the DPRX capabilities read can never complete and will always
time out.

None of it is specific to that hardware though so I figured it
makes sense to already send them out.

Best,

Sven

---
Changes in v2:
- Make the DP tunnel activation callback mandatory. The DPRX
  caps are now always read inside dprx_work which now also happens to
  discovered tunnels when they are activated again after hibernation
  restore.
- Mark discovered tunnels as active
- Add a cleanup commit to drop the callback data that's always the same now
- Tear down DP tunnels that are inactive in tb_stop instead of
  exposing tb_tunnel_cancel_dprx.
- Use "router" instead of "switch" in the subject
- Added comments how these issues can be reproduced
- Link to v1: https://patch.msgid.link/20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org

To: Andreas Noever <andreas.noever@gmail.com>
To: Mika Westerberg <westeri@kernel.org>
To: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: asahi@lists.linux.dev
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Sven Peter (7):
      thunderbolt: Hold a router reference for each path hop
      thunderbolt: Make the DP tunnel activation callback mandatory
      thunderbolt: Fix domain reference leak when DPRX read is canceled
      thunderbolt: Don't access a DP tunnel after its DPRX read was canceled
      thunderbolt: Mark discovered tunnels as active
      thunderbolt: Tear down inactive DP tunnels when the domain is stopped
      thunderbolt: Drop the DP tunnel activation callback data

 drivers/thunderbolt/path.c   | 21 +++++++++++++
 drivers/thunderbolt/tb.c     | 34 ++++++++++++++-------
 drivers/thunderbolt/test.c   | 49 ++++++++++++++++++++++-------
 drivers/thunderbolt/tunnel.c | 73 ++++++++++++++++++++++++++------------------
 drivers/thunderbolt/tunnel.h | 12 +++-----
 5 files changed, 131 insertions(+), 58 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260815-b4-tbt-fixes-a2689186016d

Best regards,
--  
Sven Peter <sven@kernel.org>


