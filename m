Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186894;
	b=CJndgCYShsK0q1voc3E6OKa8ANDISAB5Hi86bsa1ZBORufPO1JyktM6Xs2erg031tEvI
	 Sjhsd6Hu5RPbiNkpF3XVmuAPPNxL6KWXxFUEDT6JVMWxSo1vjB7DIb8x2xX2o2F5A8Tsp
	 c4IJYIwh/F8ue8OFqv/zZOSYSzBKZmW/7Vie1buUBJOjHO9DKcTyH1qyKCWyhyh3ghbvR
	 EkYH0uWhdxZXaxVN9JEUbi4vNIJpe039Tgw5lhnAByUoEBwgGSncgsiq6GvG8H92s6dlG
	 aIS2dTB5WbWk3qgCoYWDw1EDghokYuuWAfYAiM+yMuFnNVJ705H4JuFFF6FvahkrL3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186894;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OraIQ2SDhu0uL8MoTVbZTwStx8G1xutMjL4a8ZJPBog=;
	b=bKIEk11/3JWO5gt6zLYX4ahS2PQiwDEuFQgcbxZL2pyX4SLFOvagIChmlBl0+2fAlTeo
	 QfmsPBiZ3v8d8/1gN1KJdorBJIQTRDTdrn4tMoL5z3xHxsaMDcwDzQgm+DiEfAVeXuLvA
	 MbngmXnbh6mGzWDhta5sQ1j9dy9Qqsscpa4Pib97y4W/NaWjz2s6QvxGDAfoQBco6hw7T
	 ypjkxsl20qzjUJvePdRB1jC1py0/z+01sm/1H0rNbXuvWdo7LaIGV9LEzDLRW69AjhQqA
	 Tgmc/lj0OBIXxZQwPkblKFerTQEnd0rEve7VkGu3PdXYewQJbytfSiu0X9WwZABErTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI80yjlT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A54606A31C;
	Wed, 28 Oct 2026 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI80yjlT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793186893;
	b=Xtgy0jXV1dBkgT0MR4AgjtJYapjc0XsslGvPAie/XSVUqh8I7tbqE/u8yMjN7mOD6KxY
	 AyXlcIsM2fNdNU1W/Oo0F3ZlngeNBfQ/0cmei03RRX9fXKOKNKPBcny2+v2WKG3TMYs9g
	 6H67cPg/E8RppFI5kPf96LsjigdJAHAuD00+Pd5EJqEg6J3lGvJ4MdPHsYFumQll0QEQM
	 +MyvJF0/dg92oUYVXxWOsDQjbmvJ9woyDhNAD/oi9l2RBxkTN+utaQPj7sZBjGNDmOuCV
	 b+ofnIQZV2rjlxyounPQbm3+QkpxxFXtZ1+uvSOutpqMOaZWnoiRzCBlAKW5i+NbAWA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186893;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OraIQ2SDhu0uL8MoTVbZTwStx8G1xutMjL4a8ZJPBog=;
	b=lm3P+IaEa05w+JilVyTnEbwWnllwPz/33RiSZiLGnBTK3NLbo29I7r294wdouEvfCug6
	 DNzzToIsCGOS17AkdTunpCARTDWgQlbfHtpcUMD0Cwi+qiz6KfODMHcbn1kLHdA/gMAy0
	 iRHxfKNf+rJTcOFE2B5ye0rAjhWUfzVvjw/Tem8XCUg54bk25NKu12gpA3JyTOh0ogS6W
	 PzLwW6HVWznmtmiWKOvBzNdN5qK2hfsNRwSy25K9Sg4wAEsnAyYHSFVlrvoJuqVfNDayw
	 AZe2yX1LJdseTKpP4tDpsiz+y/UQGEGVpT4XU8OIXGxvcJvv9m3uKFMiLR/Z7DkRjVw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 101771F031E3;
	Wed, 28 Oct 2026 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186893;
	bh=OraIQ2SDhu0uL8MoTVbZTwStx8G1xutMjL4a8ZJPBog=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=WI80yjlTSkrjldjZt+cbwEWMZJB1f8AAlgBqRvYJ1KGoO105xoAPdLH7EtQDHeawz
	 aCU2lewYFtggTXpJn9h7aZBh6bg3X8rYepGssMUp7cfvY7HHa5KAWrS30398ypwB+F
	 hYpyfiuBnxmof0J/5FAKxR/D8rHEpT3xdWT3AiRAyhvyh6tSNAVydTPxX0XTDwl0m8
	 Q4K+2TAMoTmT80hI3ygHKKkQt6oH66H5i+n31JkId5wydedFOrz61olajaUtoE99FA
	 3jET8T6OuxIyMnpyoqN1M1SgrhvY/OFzksCD32xAuyrgQqdyeYCFcpFqcQOHdMrCZU
	 GncwJFVSpisKA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 96E6E4540F;
	Wed, 28 Oct 2026 11:28:12 +0000 (UTC)
From: =?utf-8?q?Krzysztof_Soko=C5=82owski_via_B4_Relay?= <devnull+krzysiek.sokolowski.gmail.com@kernel.org>
Date: Wed, 28 Oct 2026 12:28:11 +0100
Subject: [PATCH] dmaengine: pl330: drop only the runtime PM reference a
 channel holds
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
Message-Id: <20261028-pl330-runtime-pm-v1-1-f0fb5c34a7c4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2Nyw7CIBQFf6VhLcnl3forpgugF8XYh0CNSdN/F
 63LSebM2UjGFDGTc7ORhK+Y4zxVYKeG+JudrkjjUJlw4JoBb+nyEAJoWqcSR6TLSJ2yAkCB40G
 ROlsShvj+JS/9wXl1d/Tl2/kbCZ9r/SqHRpzNSP08jrGcGxuCQm2NCV531njZAZdaatVJGFgrO
 R+M14KRft8/xOgpXMAAAAA=
X-Change-ID: 20261028-pl330-runtime-pm-b5a30050b2f5
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Soko=C5=82owski?= <krzysiek.sokolowski@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186892; l=2072;
 i=krzysiek.sokolowski@gmail.com; s=20261028; h=from:subject:message-id;
 bh=N0Dj51bhXIkS3BDw3/lGRjrwPEjdmvZxsqfqjpdUcCU=;
 b=ehlD/UbuZSYLlj0k3N8mtTulGuMalewB+pRQnS63Q3pr8M5a7lbCppFfroC6Kq/aGDjJJK1ee
 1uDkG+C2TppBmzIO7uFxRQQuHlqX9L2yt4eiW5LwDi6NBGvo/2IN8LI
X-Developer-Key: i=krzysiek.sokolowski@gmail.com; a=ed25519;
 pk=qeeCHf+lXP5Q+6LakjbiVVxxcDVYb7Op1WMfhoaK2T0=
X-Endpoint-Received: by B4 Relay for krzysiek.sokolowski@gmail.com/20261028
 with auth_id=1343
X-Original-From: =?utf-8?q?Krzysztof_Soko=C5=82owski?= <krzysiek.sokolowski@gmail.com>
Reply-To: krzysiek.sokolowski@gmail.com
Content-Transfer-Encoding: 8bit

From: Krzysztof Sokołowski <krzysiek.sokolowski@gmail.com>

pl330_tasklet() drops a runtime PM reference when the channel's work
list is empty, without checking that the channel still holds one.
pl330_terminate_all() drops that reference too (power_down =
pch->active) and clears pch->active. If a completion schedules the
tasklet and a client terminates the channel before the tasklet runs, the
tasklet finds an empty work list and drops the reference a second time:

  Runtime PM usage count underflow!

after which the controller can be runtime suspended while still in use.

Seen on an RK3128 board (dw_mmc using the PL330 for SD transfers) under
combined SD and USB load, where the dw_mmc error path terminates the
channel; the underflow was followed by "pl330_update:1678 Unexpected!"
and a failure to request the DMA channel again.

Take power_down from pch->active in the tasklet, as pl330_terminate_all()
does, so the reference taken in pl330_issue_pending() is dropped once.

Fixes: 5c9e6c2b2ba3 ("dmaengine: pl330: Fix runtime PM support for terminated transfers")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Sokołowski <krzysiek.sokolowski@gmail.com>
---
 drivers/dma/pl330.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index c2d0b47..b0eced8 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2090,7 +2090,12 @@ static void pl330_tasklet(struct tasklet_struct *t)
 		spin_lock(&pch->thread->dmac->lock);
 		_stop(pch->thread);
 		spin_unlock(&pch->thread->dmac->lock);
-		power_down = true;
+		/*
+		 * Drop the runtime PM reference only if this channel still
+		 * holds it: pl330_terminate_all() may already have dropped it
+		 * while this tasklet was scheduled.
+		 */
+		power_down = pch->active;
 		pch->active = false;
 	} else {
 		/* Make sure the PL330 Channel thread is active */

---
base-commit: aff5e6a77fc69a7c490246465940d18422d7c631
change-id: 20261028-pl330-runtime-pm-b5a30050b2f5

Best regards,
--  
Krzysztof Sokołowski <krzysiek.sokolowski@gmail.com>


