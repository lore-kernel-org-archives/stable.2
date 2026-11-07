Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050114;
	b=guVt95LFUaf2C1/OA4/FqxQp8xVI9pBgoD3pipTPl10mN1dChJlthf/xiYNjdg5058yP
	 lFVUY3gdE//ZAAIy55foWy3vlOtmf1gqqjnsYLxVYskfwhA3LVRhINbUtvuOvW1Q4cUbD
	 Kw0DJlMXXdWkMgKpPIbeSvudxFvhLsB7WCkVEySDMlMnuhS0Ze7uu2W3EH5bc3s1E/SUw
	 couIgw5c8gM/SNQJGn0Dw48OPNWyg0xtqK5SEiF++ptVchz65QYSf+j3IowZkBX/dMhfW
	 Ltff6rSz9j9tSy2Y7i1h9CTHlGauucmI9sBZM9W6kbrJQTFN6woI+FxaTLDMQqvplGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050114;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zCffoh2tGhavnbskLyX83Keq53JuclyIFAMh0sw7q0E=;
	b=HCZugP/y88Gb1oBfkiYlwfuDNlD17JxAc3Fywb3eI7oOZcrLYtberkqHAWSbAzU0Dg1L
	 erkFdS/ddjMvgn7w2hfviOpA7WdesrldbcRcoC0km9u4cIdgNe1dzdOn+FwKJNwU5VUB1
	 AUpbgkEvguBWRMKVf+yVqfKUHZ3jo75zPeQ7RulMZufngZDNT8zuZHBvt7QTO7hKQRhFv
	 hpjB9370i3K//EyIi9tiUwR2Za5fmlK7xdEzW3ZxBi/+UDRcy7gfrDtUY36CX6hXlGvR5
	 GkUD5B7W2MSVQ6wa1F6ELEwEP2irKhNPmzLZf6cNK5hGn6/2zJ5zHOwhWJENYVJh5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMqtHNvc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA48606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMqtHNvc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154B31F0089F;
	Sat,  7 Nov 2026 11:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050113;
	bh=zCffoh2tGhavnbskLyX83Keq53JuclyIFAMh0sw7q0E=;
	h=From:To:Cc:Subject:Date;
	b=dMqtHNvcMH2bxgmhBEffl3z4P7+dRqvwZh+31c+NM6MwDNkptQ0D8UN8pI2fxsRtb
	 zQv+f13h1iQ/HXtNkE5rc/aNm/1rQSZG4DJ+7+/KGIy26evqWNgz4dfe3DTL/I5YaF
	 5W17NbO+mg8ul/G3+F0i2LSo8mGz/MgMe9qD9ZTaBPFrbJkf1BIsJFBTVy2vcgxJHo
	 m++WyAC9CWqhaBmUU4xpE0VnzsUxhYXGDj1AhEk9e9aBNIp9ZeubQYM1gx8EXsD0wR
	 stL+y9+4cP1ZXm+eJAgAvs9+gQErF/MPo3dgaqX0uUDNB/uSdC9ySQcTzJ+0SbjTW4
	 FXbe+bpcYcOqg==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: don't sleep in the clk .is_enabled callback" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:11 -0500
Message-ID: <20261107061511-failed-5.10-61490ff518c7@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 61490ff518c7b3ea3ff1cd16bbc012e9e4f1ab74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061511-failed-5.10-61490ff518c7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




