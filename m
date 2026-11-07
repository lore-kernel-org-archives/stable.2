Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048091;
	b=uYongIA0KsgvViDDfQT53y+pNafFoQ8CrVh6HHNQAVzrsc6Q+cxDcphYCIcAZcovyDdL
	 EoQLhLXwj5vpu+DQRsc5amsC9Hxl2qcCWpneBh+v+1ptIaGgS+nXhoipEiEjD2ZvUy9R5
	 BNqmoT67yAWh1Z7ErineeA4wQYmfN2Y44xcPchIPR5DaSgIp74cn/zGQfVw4RtPP/+Dkc
	 IOy0sV9pbi6XIa9mozjbYRwB3C+gS044JIMbNHAnECSS6lRVkEKk90Zl6RELre7M42hTt
	 bjAZlM4uBaSBMjlkdXDND66Hz0LJY3EtJtbUY9syGs9ny9IL8RWv/HASwsJ5yA3bjew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048091;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j/9WWr9aYK8aY0F0vGpm9GlAcXCvgoCbn+qNyTSyRo4=;
	b=lXuBmoCVj4koivr5TLatgbXKVs8wyXACrFIeOUcdaAKekEtTADbht9cGtouhbkuVSEk+
	 55uwDFG20re5MTbQbcqZYjtq9GyRtl1poqsbs/TmFY6XS+e+m9omiq25adS+dLmGWgiFs
	 32XmqHFeC6HcUV5x3LaY64jU76ufi+AcAo4s6mIdM1cgj3tlu30YibVoxNd8ASqAdgMpA
	 Ut4UtFJOFXlpq9UjC7gOYKaOCR8ETnfHOTKRXbQGqL+qJ20zCB1FHYKe+OOBTEKIByD+Q
	 3F+IF1+yL7U9vKpNBv9SgLV9WUml+QjNuXOUbPHRA2W5lVWvU3MVUGKcAFDZSQ+1t3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGS3qTJU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05AA606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGS3qTJU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380201F0089F;
	Sat,  7 Nov 2026 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048090;
	bh=j/9WWr9aYK8aY0F0vGpm9GlAcXCvgoCbn+qNyTSyRo4=;
	h=From:To:Cc:Subject:Date;
	b=ZGS3qTJUn8VnqaqHJ4XrJMF9hKDPPyRBOqo2ZKqEIDrK/5gpar5MzXj70TdPTeM1Q
	 2wfAaGGDXwnDR5qMFUpIBZZZW95FXMcpvW6z0yN8Qtob/p47rj51GOr5IO4E5O3Kkx
	 u/5DIa0iW4mYt8R9QcvJDV+iK01FOZY4d26B0eU8fjLUI3azBsuertdioF8H5R4ZBI
	 jhYz8Fwc9m/9wJKea04Hu1YHqaXywoGYJFp+xB9GfNTqWBSkB/K4Rg4JL2sfCxu4Q8
	 YWVJBEbKfaygLc9Rp52NpocxK8/PzNFwvlNx6ZswJ71tB8LJ4J+CCYuHTyB+MZF3nS
	 ad6QM7Hdu+kFQ==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: don't sleep in the clk .is_enabled callback" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:29 -0500
Message-ID: <20261107054129-failed-6.1-61490ff518c7@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 61490ff518c7b3ea3ff1cd16bbc012e9e4f1ab74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054129-failed-6.1-61490ff518c7@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 61490ff518c7b3ea3ff1cd16bbc012e9e4f1ab74 Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Wed, 19 Aug 2026 11:49:20 +0530
Subject: [PATCH] media: microchip-isc: don't sleep in the clk .is_enabled
 callback

isc_clk_is_enabled() calls pm_runtime_resume_and_get() and
pm_runtime_put_sync(), which can sleep and are not safe here, as
.is_enabled must run in atomic context. clk_disable_unused() calls it so
at boot, and CONFIG_DEBUG_ATOMIC_SLEEP reports a "sleeping function
called from invalid context" BUG.

Use the atomic-safe pm_runtime_get_if_active() and pm_runtime_put()
instead. A suspended ISC has its clocks gated, so report the clock
disabled when the device is not already active.

Fixes: 01192aa1c5c2 ("media: atmel-isc: Enable the clocks during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/microchip/microchip-isc-clk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-clk.c b/drivers/media/platform/microchip/microchip-isc-clk.c
index 24358d804e75d..66dc522a61908 100644
--- a/drivers/media/platform/microchip/microchip-isc-clk.c
+++ b/drivers/media/platform/microchip/microchip-isc-clk.c
@@ -98,15 +98,14 @@ static int isc_clk_is_enabled(struct clk_hw *hw)
 {
 	struct isc_clk *isc_clk = to_isc_clk(hw);
 	u32 status;
-	int ret;
 
-	ret = pm_runtime_resume_and_get(isc_clk->dev);
-	if (ret < 0)
+	/* Runs in atomic context, so must not sleep to resume the ISC. */
+	if (pm_runtime_get_if_active(isc_clk->dev) <= 0)
 		return 0;
 
 	regmap_read(isc_clk->regmap, ISC_CLKSR, &status);
 
-	pm_runtime_put_sync(isc_clk->dev);
+	pm_runtime_put(isc_clk->dev);
 
 	return status & ISC_CLK(isc_clk->id) ? 1 : 0;
 }
-- 
2.53.0




