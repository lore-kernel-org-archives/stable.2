Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793957316;
	b=bUFoCG9j4yopABgOHJmmTUsPEcsPCo9IuFD2U0q9HBfHa3eSfosAu0dTwqI7CEzdwu97
	 L4dGGTNRadC6MeVmu8NS+cxg11pB+IfMM4QSFuTl0A9KtXO28Qpz1VHK3FYOimoIPcX3x
	 ghtQ84nf8VuCMk7kBUjCLPP9wugrb+zG+2x3Ztp03ax0WhZGHdxBHXnEma9YMGQ+sz9TL
	 lofNO0wnM+y1HjMBirmIESdCUxtQcC4Yuckw3TePA52TKJb1tm7cAkgPg016SgtHeq75b
	 zKLQUir4aTeXVFNtkb3Z1l4R/0F6J25EuFD9eRt891ruRIprJs/rxIaxJay4Dn+Tsgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957316;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=U6oPa2ZJHjZNJ3jw6GfOwDyY59OJDmTAAq1w/QD2M+E=;
	b=H/0pPlDq50OyW0M/vH+bOrLZZ7s+uDrQbJ93AyMa2QM1xtVUFH6zodRP9gH7PShEoqUc
	 9BdMMq+qroIlkWB3Z79dazcOzPSUo92tJMS33ZRgcVfpGD5ffr7Vm/h9+lSpE9Bil64Ee
	 a54M+FsWHqqesjnz+BiLBrSbRY6m6q2hHz6jKfU+5c4x7+UXsH9LNz+01WNZp1pigrI/Y
	 ecyjLfAxjY8HIP4MQ9bTy7QcyR0JTHL1ItXi7I92vlCQtEqAtDSZ1WLsY6EPx8XL5vfc+
	 zR9VXcGe5lfIM0Be+UPQil18MJR/UsWJ+lkhWWu8qqs+uSAi7eDylXTVuZXSWc4TH7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcFsuNMd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E2606A331;
	Fri,  6 Nov 2026 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcFsuNMd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793957316;
	b=f9asUT1T2RPEeC6c/JtMB95mmxevhlKwTrxrjyVEBmuM/tiehWe1fLkZH+Gs8Lvh6Qpa
	 l+rhYZjwfl44+uTegaqZcqLeX6/dZS61meKkFtJ+oRCub2VskX9kimGY+ydFn7mpcbcwf
	 Ye5xdokrhl6WKRfls7dgnA/T/SwLRiAEM5Iv+bpJ40OQykrjN9zMV3+fjVUTcX2N5LYS7
	 qCYPFhU9Fbt9KzfFIxSxhMwhwtmy7gvZCf8BTqGYZPehv22DjzzyZbvKI13Eye0gFz8zW
	 jkwYYkNKct2igRjuXR1kF9K/Mf5T/JzSFoDrtf1zHuGBq3glyiPpWCtfpqNHrCIeyKw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957316;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=U6oPa2ZJHjZNJ3jw6GfOwDyY59OJDmTAAq1w/QD2M+E=;
	b=eLX1kY+XS12KZCj8n2hg0VaqXoK1IMJ3BJSFt1eoFJvd625FOC3A34j0Ctsa8P3APdUy
	 Isb1Ky28aRmP0lrrLPtNV5Fzx1UKeAfsJAJ7fvdaV3DYo5tHPtzdayBpNPvR1Tsm5AXZS
	 W4/XXC73HPyqyvB6lBlCLymfp97wOyucs9gEHx7zmyPFPnaevJObtnQU1QNAyEKyU27Qw
	 pPuM8oAA9CmlJb7mP6yGK7L3uat0h5tan5xgkZc9PHoQktYt7u5nfKlniHRGBYcZOKKeL
	 V5q3MZHHfx6E6jFef997IMFNsJO468kQokmXD53WMKRt3rMLYxJOVgqwV6O0sFYTnwA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 949931F008A2;
	Fri,  6 Nov 2026 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957316;
	bh=U6oPa2ZJHjZNJ3jw6GfOwDyY59OJDmTAAq1w/QD2M+E=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=LcFsuNMdujcQFiGeV+iA91OZ+2H8rrMesKYasVfX/+ZLpeUA6aPVaFSjnGpV7yCyR
	 n2N3s9/E8CUuVLHKsdYK0TkUt82zAkvXifqxdHFqv0q2Bg64/Q8GqdH5h9sVhj/w6b
	 rgngKjtCrTJ0SQHxmpxoynWZiB3D7niCgmrNQraYqUxwesWn+3n83YoPFUQBs4+NOz
	 B1hCbUWg8G1Xc5ppE+9mcb7oDdqCdyekgcaEn8Cc1sZzeuXxRj5AvM6YL9/wfi+5cf
	 Aftu9SNl7nvRdRF55+j0Ea26HJ4rPofqmIw/tO15TRZNqZsiOi0cGs8vxQm9EsobbI
	 jgdVL1iIjDiww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E9DC145B3F;
	Fri,  6 Nov 2026 09:28:34 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Fri, 06 Nov 2026 17:28:26 +0800
Subject: [PATCH] usb: core: hcd: Skip PHY rollback on failed autoresume
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-fix-usb-hcd-autoresume-phy-rollback-v1-1-1ed900ddcd2d@qq.com>
X-B4-Tracking: v=1; b=H4sIALmd7WoC/yXNwQ7CIBCE4Vdp9uwmhUYafRXjAegoaC0NW4ym6
 buLevwO889KghwhdGxWynhGiWmqULuGfLDTFRyHatKtNkq1hi/xxUUcBz+wLUvKkPIAz+HNOY2
 js/7OOKCHdvvOmJ5qac6os9/L6fy3FHeDX75p2rYP/5Q1aYcAAAA=
X-Change-ID: 20261106-fix-usb-hcd-autoresume-phy-rollback-e9e7e2b53667
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957314; l=2560;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=+UkhgORE1S10jMlcch7WwpiOoh63ObUq75ZT5p51K+0=;
 b=qMn9jaDlRH01ky+tRH0T1p+YC0f/c0Y3Dxtj7ZuSDT9aOB8MWY05ZJWqILt28oU5ZZznq7RcG
 n3eBDhIsR9vBDbD+clBxoJbVA31y6tJSzXulewfhD9IW0JLV3kJlqeC
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

hcd_bus_resume() resumes the root-hub PHYs only for non-automatic PM
events, but its failure path suspends them unconditionally.

A failed autoresume therefore drops PHY power references without a
matching acquisition. If wakeup is disabled for the controller, it can
also drop PHY initialization references. Subsequent cleanup can then
report unbalanced regulator disables.

Guard the failure-path PHY suspend with !PMSG_IS_AUTO(msg), matching
the condition used for PHY resume.

Fixes: 178a0bce05cb ("usb: core: hcd: integrate the PHY wrapper into the HCD core")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
This USB core issue was found during the RK3572 mainlining work.

hcd_bus_resume() resumes the root-hub PHYs only for system PM, but its
failure path suspends them even for an automatic resume. This releases
PHY power references without a matching acquisition and, depending on
the wakeup policy, can also drop initialization references. Subsequent
cleanup can then produce unbalanced regulator-disable warnings.

This patch guards the failure-path PHY suspend with the same
!PMSG_IS_AUTO(msg) condition as the PHY resume. This preserves the PHY
references when an automatic resume fails and retains the existing
system-PM rollback.

Validation:

- Hardware testing on the Forlinx OK3572-C reproduced native xHCI
  Run/Stop timeouts in two USB2-only configurations. With the fix,
  eleven failed automatic resumes returned -ESHUTDOWN. Tracing showed
  unchanged PHY initialization and power counts across each call, no
  extra PHY suspend, power-off or exit calls, and no regulator warnings.
  No trace events were lost or probes missed.
---
 drivers/usb/core/hcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 8e8a5f59b319b..fc4c28b7d4398 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2368,7 +2368,9 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 		}
 	} else {
 		hcd->state = old_state;
-		usb_phy_roothub_suspend(hcd->self.sysdev, hcd->phy_roothub);
+		if (!PMSG_IS_AUTO(msg))
+			usb_phy_roothub_suspend(hcd->self.sysdev,
+						hcd->phy_roothub);
 		dev_dbg(&rhdev->dev, "bus %s fail, err %d\n",
 				"resume", status);
 		if (status != -ESHUTDOWN)

---
base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
change-id: 20261106-fix-usb-hcd-autoresume-phy-rollback-e9e7e2b53667

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


