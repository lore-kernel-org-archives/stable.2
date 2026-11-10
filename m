Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794294534;
	b=a5xs+UjfvyrS1pKLAXru89JE2uZNOqvQ/o/iprKDNgAri3Wb8zSZOJBgVKDiCFg5F4AB
	 hWmdoxdy5cHocjMvdmFVSwQeAVF4gx0N3XSsP9nEIvtmyIK1tR7OjQvphpWwvpjGLEyKS
	 VkcKPE3MW5C4Lqc5hU+2V5xMEB9zjFDWX8Dlg98VN1Ck53z0rKaZL4Al7cJp3xpCYMLJz
	 PGcy/6vJL/bA5rozlu4JBxCRpmN06Tcbhtyzrfxw+n8CMtc4GUbyvTLC09GOOpBtAgjyd
	 nyy1Uu+Pjq/3s3N0mFjqttIaEiOEae/tu7dS0AfLWRVxiMsSGZpHwafrJKpw+iZfprg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294534;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=1zci30K6XDnk6LwA+I1Lc3l3JUyNgpA+En7a0rv3or0=;
	b=DsihNkq8o+k8TBjGkTfew7cwZCVPNh/8eU6zk8QLts5CI6IJVQAYTWNfTSAINK84DBio
	 IU7QalyJjYDiDfeCRqAQ/lotk8IwfaxVPQome6LkT8MCju4KHIAJRTTTNf+Q2cT+Z1xor
	 ztEJiLE2RCh1m+iLFZFB3Wku5N7OhdK58+7QyN+PCNAo3IQN4QksuKccK0VwttT6+N2EG
	 kK3oNPNpAjm4waDBWE0QbooBCTuH9b7Niy4muB/1j32zLTXjlAIfu+v1QyyZE6PYBrKWl
	 1664T5goOywIPVl81vnva0Vyv7uece7Q0xPOMUYrlsI7hveEO3naDA1Gkx5l+/2PqIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lK1FHumx;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFAA606A31C;
	Tue, 10 Nov 2026 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lK1FHumx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294533;
	b=jXSbsFhtEM1cXGe2NwhKVxQcjhgtUwt2/ZDxKClCp62K2Y96k0SnJlmFWUvHQ+FJoKBj
	 w5lZB8MWUQdA7BfeHotwnG5TdqentG8iEkQ1Lk55tyooXxdihX5op/Gv/obmj+l7kqxZE
	 4t0eY4GVCzsUamCErj3XUHadO9OFtfonRjVbczbA3CnaJ8IoTRFjGl4XrdBjyftXvpQI/
	 cXUGcqeXqR6FJKvvDkuWSSWnFPldWK8bORr6VNPzYEpIPuRMrrRMdNXG99SokMaM740RX
	 cv/v8NFSsyhRb4WL01kSVjIvwYUP/S9DGEvX+TfVVRcLxsP9X+0ZtYQ1FP3jzWwmbZg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294533;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=1zci30K6XDnk6LwA+I1Lc3l3JUyNgpA+En7a0rv3or0=;
	b=xbgzStDbXSoSVHiOHIBvnqrSaaz8o6E+wVYUzWR0cH5trHv6v8FLlTFNj/lgMnecI+sq
	 kcjs8jeLGrS0/rKYwvy6AbdvTmHApVNTV97a/LE7tYpZoarouAGpi/bd8iBXFP8gvdN4y
	 jXRjGV5gA3qbh3/h2v754snU6PlCVdR1zWtGaoQ33B/9VlHWD2wZjgmTETTE7r718hrS+
	 GCYwcXdqnMSBzfbiY9+mj0BINDyKQhL9zAxTlbX+VUSBO/clzdHiBwrKpOMBpO34ceFjM
	 J8+EF5q++8ZchHEO3zKeNOcvyIOkCMI42PK7OafCuZpbO/U6miWtK7bcbQt2A8ndDnw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D94791F008A2;
	Tue, 10 Nov 2026 07:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294533;
	bh=1zci30K6XDnk6LwA+I1Lc3l3JUyNgpA+En7a0rv3or0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=lK1FHumxoGl9QnROk4S3uSWekbUoI4VYyVWXofmCb4hSVq+fpewUBkkRix0DwZ7B3
	 iPEH5HzT3rDfx11OtVydtifwHy0e7Zw7AEidFfvufBsr9xhzLVPTQnSE2oR5LV8bqS
	 7zot5Rj+wiBtd19YVzVkYNWYcwI2TWAgIR/p6NDQhzLS7kw1tOpI7+jUXDhpHAvQD7
	 BKf7aSWVMD+2mkGbfrsDm+DXbG2Hc+Hlep779wFjpKUf4GicxOfGd5bX/2pcvR/BmL
	 UHby3Qchv64EFewvjIy2jifdtER2OHuLd5SpftwteD9VVjjN8aeVlI8UkCmN1fiLjB
	 0uX7GpgoVgTXA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 634864891A;
	Tue, 10 Nov 2026 07:08:52 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Subject: [PATCH 0/2] usb: musb: sunxi: Fix unbinding and rebinding
Date: Tue, 10 Nov 2026 01:08:51 -0600
Message-Id: <20261110-musb-sunxi-unbind-v1-0-d821584fc4a4@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAPD8moC/yXMwQqDMAyA4VeRnBdoi1TYq8gOps1mBmajWUUQ3
 91uO36H/9/BuAgbXLsdCq9i8tIGf+kgzZM+GCU3Q3Aheu8dLtUIreomWJVEM4aJ+uxypDREaN2
 78F2233O8/W2Vnpw+3xEcxwmkW2RHdQAAAA==
X-Change-ID: 20261110-musb-sunxi-unbind-2ab4d0d6bc76
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: regressions@lists.linux.dev, Zijun Hu <zijun.hu@oss.qualcomm.com>, 
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Rajan Yadav <rajanyadav0307@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294532; l=1975;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=ldGUp6lz3WZtjMz69tdwqzZtvWjZqidFlVH8uvgeKIc=;
 b=MCB2MXQIdsbIGlvQgYsC0+8HOab+meeL5xETwA9UXFgrRetKIiqDkp3ZBmxw5ibeaoItFqvdY
 SxhZe4UzrdbBNjvD868U2pKK9n2EYB1vzSaSz86Lk+g/UQm2F+QdMzd
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com

Unbinding musb-sunxi crashes on current mainline: KASAN reports a
use-after-free in devm_usb_phy_release(), followed by a NULL pointer
dereference. This came back in v6.12 with commit 498dbd9aea20 ("usb:
musb: sunxi: Fix accessing an released usb phy"), which removed the 2017
fix for the same oops. Patch 1 lets devres unregister the generic PHY
after the PHY reference has been dropped.

While testing it, binding the musb-hdrc child again, the case that
498dbd9aea20 was about, turned out to fail with -EEXIST: since 2017 the
extcon notifier is registered with devm on the glue device, so it is
never unregistered when the child goes away. Patch 2 pairs the
registration with sunxi_musb_init() and sunxi_musb_exit() again.

The two patches are independent. Both were tested on a KickPi K5C
(Allwinner A133) with v7.4-rc1 and KASAN, without out-of-tree modules,
using the board's device tree, which is not in mainline yet. The
details, and what was not tested, are in each patch.

From reading the code only, drivers/usb/musb/mediatek.c seems to have
the same problem as patch 1: mtk_musb_remove() unregisters the generic
PHY while devm_usb_get_phy() still holds a reference to it. I have no
hardware to test it.

As in the patches, I used Claude Code (Anthropic) to find the causes,
write the fixes and the commit messages, and help with the tests; I
reviewed everything and ran the tests on the board.

Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
---
Rajan Yadav (2):
      usb: musb: sunxi: Unregister the generic PHY after dropping its reference
      usb: musb: sunxi: Unregister the extcon notifier in sunxi_musb_exit()

 drivers/usb/musb/sunxi.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-musb-sunxi-unbind-2ab4d0d6bc76

Best regards,
--  
Rajan Yadav <rajanyadav0307@gmail.com>


