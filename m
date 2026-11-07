Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050437;
	b=r3Zoks0r5phak6ab5ULTikrVcAxh6Ryua4OfpKDgmeDfzsgUZErScWe/cN3J+tUXvBdA
	 eq7EQnYAQLtiWmTX7HiDmbYdvmcK5hovAZgnO/pLDj+chi3cNWN54TwclxpTZryHfCJH4
	 OfXHcILEUSZgnzLfPH8erE5ygpGNyYC3lnQb3svF022Juq1/oobNLgxiz9n1lIQUPJ13Q
	 Ed2lOmUTSF7NGqOKFIKsRJfU3dg4Od2VJSECjOLYZIGlQl+D4+7d67jJ3eoPo/xuw5WgR
	 shq7/RkBsFi5Jk7RJP0JQHp3bh5hRfoYjJKPfkYRaDyJG5syfkl926i2Wofufy5pyKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R+cD/bFCNJzQ/nBfaYJLXqCIvj4Z7xtZSFSkIvkdLgI=;
	b=VtCAF9xK3SVsm+gmmdRvdQ0Jlj8xMSmXsf9iC5Qky3U/s36uT12wTX+SEsVKvz2SJ6/3
	 FEp90LEZKdYzW9UV4ONsYJsnT5K/cL5+v0vn9hd4euUgXHadDxcqzwHu0n8lUf5qUX6lg
	 zmes7aLjP00HevNztJTt1aF7Fd+6r/JbNcNMemfBE4dMS+3pNGyHBJt6d7oK0eu2XW2Y7
	 OFr2cnxjbfBEET9m/J4zteDivKq8QHPtPSpKn0TtshCdWZQD36u2Oeu4USc2VibYIwKv1
	 xEU+RBPfmm/qlARkTI9GuujdA7QN2lbV68njP/K3t1UDVZNt0Hx5D5OiSeT3tri2ZrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1Dc0pli;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1Dc0pli
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEDA1F0089F;
	Sat,  7 Nov 2026 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050437;
	bh=R+cD/bFCNJzQ/nBfaYJLXqCIvj4Z7xtZSFSkIvkdLgI=;
	h=From:To:Cc:Subject:Date;
	b=h1Dc0plizSKLns4l3Tp6FCAHMbGwiaBXPynlTeme1j96HBrn7neZ/cJK8OKj5YLou
	 i2DRy7NlPN9WAY1BZdUpnzaMeraJCjp6o7SP1Z6XIJ5v0W0oIPXjDKyAAKGr7vv1Rh
	 S2CSzS3YjZTn5i88zUT3hXKzY+c2dT0LgleFm0ItVfEV54vsFJvWLCqSv7KP09WwY5
	 XT+GmJ9SUzIuAXsPxulX7QmWeeX0Hs9SpbfpN6H6yZweGMc6fvacO972iJ6AR8m99j
	 FiSB6o6KfWelxI2wvwDkpN682632ioNDwEoC/QuZk79V09iRPBm9fbHoD+7MMEhWAl
	 DQeA+2npz1frQ==
From: Sasha Levin <sashal@kernel.org>
To: alchark@flipper.net,
	miquel.raynal@bootlin.com,
	srini@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmem: rockchip-otp: Serialize reads" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:35 -0500
Message-ID: <20261107062035-failed-5.10-9fc6a1592d84@kernel.org>
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
git cherry-pick -x 9fc6a1592d844c0397f115ee8cbd935169b9a71e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062035-failed-5.10-9fc6a1592d84@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9fc6a1592d844c0397f115ee8cbd935169b9a71e Mon Sep 17 00:00:00 2001
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 2 Oct 2026 11:13:26 +0100
Subject: [PATCH] nvmem: rockchip-otp: Serialize reads

The OTP controller is driven through a single set of registers holding a
state machine which has to be stepped through for every word read, yet
nothing keeps two readers out of each other's way. Concurrent reads
interleave, and the outcome is either a reader bailing out:

  rockchip-otp 2a580000.otp: timeout during read setup

or, worse, one of them silently taking delivery of the other's data.

Reading two cells in parallel from userspace on RK3576 reproduces both
within 150 iterations - 53 read errors and 9 corrupted results, the latter
either losing their first word or, in one case, ending in the two bytes
which belong to the other reader's cell - whereas the same reads issued
sequentially never fail. Concurrency is not hypothetical here, as six
thermal sensors source their trim values from the OTP and reach the driver
straight from asynchronous driver probing.

Guard the read path with a mutex. Reads are the only way into the hardware,
as the driver registers no write callback, and they always run in process
context, so a plain mutex spanning the whole clock-enable, read,
clock-disable sequence is enough.

Fixes: 755864feb729 ("nvmem: add Rockchip OTP driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20261002101329.1084348-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/rockchip-otp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 2c0feb036f3fd..f8a8c7cece98d 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/nvmem-provider.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -80,6 +81,8 @@ struct rockchip_otp {
 	void __iomem *base;
 	struct reset_control *rst;
 	const struct rockchip_data *data;
+	/* Serializes access to the OTP controller state machine */
+	struct mutex mutex;
 	struct clk_bulk_data clks[];
 };
 
@@ -272,10 +275,12 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 	if (!otp->data || !otp->data->reg_read)
 		return -EINVAL;
 
+	mutex_lock(&otp->mutex);
+
 	ret = clk_bulk_prepare_enable(otp->data->num_clks, otp->clks);
 	if (ret < 0) {
 		dev_err(otp->dev, "failed to prepare/enable clks\n");
-		return ret;
+		goto unlock;
 	}
 
 	offset += otp->data->read_offset;
@@ -308,6 +313,9 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 err:
 	clk_bulk_disable_unprepare(otp->data->num_clks, otp->clks);
 
+unlock:
+	mutex_unlock(&otp->mutex);
+
 	return ret;
 }
 
@@ -431,6 +439,11 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 
 	otp->data = data;
 	otp->dev = dev;
+
+	ret = devm_mutex_init(dev, &otp->mutex);
+	if (ret)
+		return ret;
+
 	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return dev_err_probe(dev, PTR_ERR(otp->base),
-- 
2.53.0




