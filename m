Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E436A03A;
	Sat, 29 Aug 2026 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787990930; cv=none; b=LVBhyUl+DnN6/q8s30qbSouahapL7cqwAQZXRJCSSLv5gkhv0TKwWwWBgvsFKMCpYoXS/FGlWcZ6DxuWpi4shpTAanOWPzmKpLb5wSaJzGmGdSR8BJ4xyKf+tH5KA5BDqGK+mVMo6y/8bhVkKHN9QENjzD5cG2e8GXm9i9lDA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787990930; c=relaxed/simple;
	bh=Jd3DvGoMdoyGVq9GftryTd67aUOreF1uZEqmV/84+U0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ec/vf5nUx2VUmxMJWthwqbHecL1qxfzYkDumsvhiHd0DKHMRvTc282cIqqu2YTPlJhqk74TlKfonKLNzSMeona4m9LV6rMMqDSap4HTCusiI7kHUXEcP6wHtd6UIu5Jq3t278cKUxlo64N29kx89M3zuft/yPb1gpKppeloXlMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXwIfhol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXwIfhol"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C881C2BCB9;
	Sat, 29 Aug 2026 08:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787990930;
	bh=Jd3DvGoMdoyGVq9GftryTd67aUOreF1uZEqmV/84+U0=;
	h=From:Subject:Date:To:Cc:From;
	b=VXwIfholkM7dFYIFdiRi2jcAmL6g3PIAL4EKYlAKh82qSv9B8FBt7Bd7MospAl0F9
	 IGmYR3njthQ1ip+R49Ql6PRi/JMmgsXxWwHlWnK8nyErXTfSJp83NdXqeFBBleDyCF
	 Y0bPOXun1hWXMZkLclCB/8Y8vWeFAUaDDYZYFC4I0D3nxPZz0VoaUz9qZpG4B2cMsS
	 m4bxN/RKYv00qIGxagAB2+CMTBWN8mC6p0UAG5KvAFNWimx4nOE9hng1aqtnFbQp+n
	 ikDDzdNipUdLtGlPC706ZUmUKcpoCbuaG+An7gsLwLA14cUl87LCjSm65kisD4Y3D7
	 oyT3Llg5yBkHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328D6C61DBE;
	Sat, 29 Aug 2026 08:08:50 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH v3 0/7] thunderbolt: Fix DP tunnel teardown while an async
 DPRX read is running
Date: Sat, 29 Aug 2026 10:08:32 +0200
Message-Id: <20260829-b4-tbt-fixes-v3-0-e1fab6ac54fe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ7CIBBFr2JYi4Fpi9SV9zAuWhha1LQGkGia3
 l2oMbEuX+a/NxPx6Cx6cthMxGG03o5DgmK7Iapvhg6p1YkJMBBM8oq2JQ1toMY+0dMGhKy5FIw
 LTZJyd7gcknE6f9g/2guqkBt50VsfRvda/kWed9/0fp2OnDKKGjWUgpvKqOMV3YC33eg6ktsRf
 mwo/mxINoiGy6YEoWqzsud5fgNheMK6+QAAAA==
X-Change-ID: 20260815-b4-tbt-fixes-a2689186016d
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Jd3DvGoMdoyGVq9GftryTd67aUOreF1uZEqmV/84+U0=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ9akye2hGXP4d6yIfuciunb65aNrnPdtUDy2uDls1cznJ
 ilHONZKdpSyMIhxMciKKbJs329v+uThG8Glmy69h5nDygQyhIGLUwAmcrODkeFeTKOK3P/bXOd5
 FLcFGS6y+3Q8WLJbT/F/+IsCi9o1t9QZ/ofNua5++2W624KHTlFW6313xwTl3WtdKGXwSDstalK
 BOy8A
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
Changes in v3:
- Take the router references in the HopID allocation/release helpers
- Actually call put_device() via a cleanup action for the KUnit tests
- Link to v2: https://patch.msgid.link/20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org

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
      thunderbolt: Hold a router reference for each allocated HopID
      thunderbolt: Make the DP tunnel activation callback mandatory
      thunderbolt: Fix domain reference leak when DPRX read is canceled
      thunderbolt: Don't access a DP tunnel after its DPRX read was canceled
      thunderbolt: Mark discovered tunnels as active
      thunderbolt: Tear down inactive DP tunnels when the domain is stopped
      thunderbolt: Drop the DP tunnel activation callback data

 drivers/thunderbolt/switch.c |  9 +++++-
 drivers/thunderbolt/tb.c     | 34 ++++++++++++++-------
 drivers/thunderbolt/test.c   | 58 ++++++++++++++++++++++++++++-------
 drivers/thunderbolt/tunnel.c | 73 ++++++++++++++++++++++++++------------------
 drivers/thunderbolt/tunnel.h | 12 +++-----
 5 files changed, 127 insertions(+), 59 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260815-b4-tbt-fixes-a2689186016d

Best regards,
--  
Sven Peter <sven@kernel.org>


