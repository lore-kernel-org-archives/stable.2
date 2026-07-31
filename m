Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F15415F23;
	Fri, 31 Jul 2026 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493337; cv=none; b=rb12YfDDgdlNFGCFMHp/pGWmhLegeNSQRQ3Qq0+98Wl02JDZmOKKiZmRV+AXX9bE4Xr+DlGB1juNF8RYcFIE9rhP1k9LXkgOFYAdW3ZAvHF0jud52JJZvKghtkeqntyWW1SIx1RN/UDUbQk/pmCOykfsh54n4Sc6ThB3XGt8g4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493337; c=relaxed/simple;
	bh=BomYNnZI/rtzGRCsEilqHXMjZtEJfVuDl9BNpljjiJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cucOA1OJUSS9Ks6wyNvMIGXAjLDOWNHRe/NwB4WD/grVdimPUVPMV/CK+chRuJiCxRMrsToduOPFp5dh/tZczyz400vse6YwrmGyMby/cJvCBGqgeJoU2EQHmMuEF2jcmTRG4GyqJERt3+RXodoYp8cjKj+0ZA0OzpESgxGBgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=bWueKYiC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PN77blkb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="bWueKYiC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PN77blkb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E4FCEC0176;
	Fri, 31 Jul 2026 06:21:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 31 Jul 2026 06:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1785493315; x=1785579715; bh=HZ
	01E4R6gBHbtiX4E85aSm4oc2jq2hxYKxHXOcMrMYE=; b=bWueKYiC5bP0H0DOjd
	tJoeDwBSTgLyom9KxsF3dsJL42fOEOjxWUUKr5Y+RJuADb0eMNPvoMY2cBHR2v4N
	QkCP3n9JmiSQVVWlktN9+Wd+pjECcu87bovK5dD8dKRYlXd590cBEq8OhL/LWSZs
	CFAcHgnxdkJG2bvBJcpMrmsNYmr6DjlAFxJS0BbbrvUbi+41sdCFnXahfNnrxZjj
	wvXMAD4bx5UAuNbvVw1cFnSYLC80WT3hhly/VNUpwjqtMB5OTUgw93KVl8UpFs3k
	BsDl6+Dmm2PSDotyTopM5Aqjc0+EY/fwvMNte1W4Ll1gLeJlOqv4VeC1MgLLu2b4
	oSAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785493315; x=1785579715; bh=HZ01E4R6gBHbtiX4E85aSm4oc2jq
	2hxYKxHXOcMrMYE=; b=PN77blkbNr6zngJlKY9KAUuMdkWUkXDHZ//R1iQnDviG
	Dj8HQXIueTd8yhvstpugq5f+gtgRgF5ZCRJSQ8pyozV74J1AtDzE3JVu/kcg6iB4
	mhyIiMnFd/WBc/p+J5FRcVDASIPtFSB8K+jqoiMvJOJDD7y8n2E14YFDbpzfiOUR
	tVSmlPSbVX0mF+qHnOJwC14nEy3V+2dqNWBM8/+N3Ehz3yEtQfwPIlAXgSPG2W9G
	2olJNNuC02w2tWbgxRoYgu2HU9VzREroX3SwGFhkbBV2C3nxnnmuzpECmr92viPP
	DW7UAY4iDz2cUeFmht1/Gz8VegWed0/+4XWbJG/TTA==
X-ME-Sender: <xms:QndsaiX8uDZsMXEuWs_2VF_HdEOkFZeL4g8-nZ18q2bIZ9nF3zUxjA>
    <xme:QndsatqU0ZUT7pkTe-oszqU6AVD9St_n9_Y8Tr13wUozz3yYY9MwJjh0p1f3oO58O
    0i9xWS_7LMsG0UdWuOts0KthnvGlx_fF6xN0mqxDJIQz6Oa-9JMJ8U>
X-ME-Received: <xmr:Qndsasn6fO492Ke6DNWeTLWLcFerK_j2zjYe38fN_QDiPAKwGMfKFtHCjvEFBpCq1TDDJ3gz-SKOStB9eg>
X-ME-Proxy-Cause: dmFkZTG0bmRKda5040SbHZuHWAq32lmYqE1ouBFlAXJZeE/gYfprID01cBUppm5eDQt1Cb
    7GBD56isvBBbVFq2lxuYvd3QR6w/an+k5VzjegSfwQPsSZuWV+WHXBnDUJlpMsesH/T2ga
    cM5wXzoyf6ta8cga787eouYcJIULN5VEPVXAsZahipiwaTM6NGHgBD29IJd6McL8YEB0d4
    faENia1pvGbJiI4OUDqgJWWczWZxfFu8yAnNEK9U+yjk540osdWu6NN5MyqeJI92Daq/Xw
    wuB5irePhFpCHuPDVXCSezQrUriAIx3EdQ2IBMk0hMIJ4LQ3XMA3CPLYvFtjNm+7gQl9Ax
    VFq5ZszGTF7Va9xt9/Tx5kXdYQd/e7n3gUjsOC6jUVTsE6fjSgl8c+jrDnqAeRoiwFpYMm
    oOMsR12hFf+kXkHsCgP7djNTkldbOBkrYBw/PcEt7Dum2FcRsjOm2uwtQ4zBhhtXlkuiBh
    liPCJgDZdRgRbVHEi7bmBksvAkJA5n+QLZJN/xnC+9qr47N4FREFXCwR5J0jrqnxymW4j2
    huGAsT0v6EUnTqCbN4Mfpp2gJFiTfjvg3bmicbbrWqe56bWizhmrKCZfbTaxbPLwhetdC3
    VHqAAwLDJM2KjnSA34m6XuUP8hskzqt05TC/Xn4QspyivTLtyVLUq2ueIJxA
X-ME-Proxy: <xmx:Qndsal17vMiaWME-dH7nkYEl6L26_xY0YosSgpLxJqf6w_penLCKuw>
    <xmx:QndsahSjEFeOl--wn7ckX-gNhDTvsFoOtp80jDdK2JHKrNOy10It2Q>
    <xmx:QndsamxlwZPAWpWmig5CyTkrtx5ismPCnMR4-iv-F_8zshqWgw8I9A>
    <xmx:QndsapCHylTLeXzMH3rCChsoi-qcVA5yw3BhMtweY5ASz0FBrGP41Q>
    <xmx:Q3dsamO-ZaeK3QnjaQFpqFZNTOQxX7Zf02oi-Bsv_xWl-UgGoQlcWYy8>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 06:21:53 -0400 (EDT)
From: jaseg <git@jaseg.de>
To: Ulf Hansson <ulfh@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	=?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>,
	stable@vger.kernel.org
Subject: [PATCH] pmdomain: core: Wait for device link removals before dropping genpd->dev
Date: Fri, 31 Jul 2026 12:21:47 +0200
Message-ID: <20260731102147.127082-1-git@jaseg.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jan Sebastian Götte <linux@jaseg.de>

genpd->dev is embedded in struct generic_pm_domain and its release
function is empty, so providers free the containing genpd with a plain
kfree() once of_genpd_remove_last() returns, ignoring its refcount.

Since genpd->dev is registered on the genpd provider bus, fw_devlink
creates device links to it, and those are torn down asynchronously.
Nothing made genpd_remove() wait for those teardowns, so the provider
could free the memory backing genpd->dev while the queued workers still
used it.

This is reachable at boot on qrb2210, where the firmware rejects PC mode
and psci_cpuidle_domain_probe() removes all the CPU PM domains before
returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but shows
up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
causes the kernel to crash a few hundred ms into the boot.

Call device_link_wait_removal() before dropping the final reference. All
link removal work is queued from device_del(), via
device_links_driver_cleanup() and device_links_purge(), which precedes
genpd_free_data(), and flush_workqueue() waits for it to complete.

Note: This patch was LLM-assisted. I reproduced the issue and tested
this patch on hardware, and I did my best to verify it by hand. However,
I'm far from an expert in pmdomain, so YMMV.

Assisted-by: Claude:claude-5-opus
Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd provider bus")
Cc: stable@vger.kernel.org
Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
 drivers/pmdomain/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 842c4169e290..4eeb980e5a40 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2348,6 +2348,9 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 
 static void genpd_free_data(struct generic_pm_domain *genpd)
 {
+	/* Pending device link removals still reference genpd->dev. */
+	device_link_wait_removal();
+
 	put_device(&genpd->dev);
 	if (genpd->device_id != -ENXIO)
 		ida_free(&genpd_ida, genpd->device_id);
-- 
2.53.0

