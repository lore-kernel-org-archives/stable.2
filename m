Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049434;
	b=reCVCNa6s9CtL1fCTT5tDyvcrt398kXdnLAe5ppa0yYdyRPVeljb7tkEJENllyAfy3Tu
	 WtRMwMIa/+wK/wWHGIFpiB4yMLNmVLInYpmQeoUPTF3dpPO3Fw7x+DKYxe7jjMN2+ro5k
	 UhT8sBXoeD3m+tCEPtfL0O/GqK/F7f+HLYtyY6rv64Nq0ujVbZhsRg6/Ns21wqX/To/dF
	 kQKbAuPdp/4QzqL1jf1nxAcyiyGuCARJCAZSsm+MlyAtCW/RZR7VP6ysdE7qw5On+T8rB
	 jf8V6TpKCMFqQFAMr+tYpU8apNq1eq3mIdaX+fnCDQOGn/FOByLwbWhZtruiimkrhaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qEi+F3KIY3ZPumc5X+M6mqFyaFI+qXcNHCWzPqCXScg=;
	b=5HwSW/0ificLAbVpZKxDOIG5Wy/dUzTi79UPB8RhdiC/a9FiCUnRIM9YKUUlSsLqRPaK
	 UU7EA8HdKUhyRcTd5YapWKwkZ6p73DV1LHSxDRcGoV5Ihz8YRq2AOHHY1A+Nz9woaEcEt
	 nnMqBCQf53HEjTRQhkGkee0waJ84FVxgtGcjhtYS2M7kWANKWQtcuhAbnBn1eddhrEcsX
	 2CbTGI4EJGk18wWRw96NIIZuNcplRmhiue6p42TR0wb5KgpkIuX/CM/XuP7r2jMt8/bZu
	 ECgelQuF2IfaMqeWXnoru9x5cqqcqRgToIgrwZFD/bRAaNrLfJEsN/vi7szfc3A5fCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=agz0nwDF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=agz0nwDF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAF21F0089F;
	Sat,  7 Nov 2026 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049434;
	bh=qEi+F3KIY3ZPumc5X+M6mqFyaFI+qXcNHCWzPqCXScg=;
	h=From:To:Cc:Subject:Date;
	b=agz0nwDF8u3NQuJ9zR9H2+CX3BV3n4jjTQnsFAS0tLgb+GYybtrUUF+IFgG5RBh25
	 JM1aEO7xIoNbNH8YXTzkGYPEOOshgpgL0YVe2Vj8Wn8BF72UcrP+amneqrM0Wx66vO
	 AX+2gzX8qj+3bSqh7eGLba9b0csXGqj5TV7mJ/wQMYcaaQFuv33xp8RJjVp8RRuCHO
	 vkqH+8SvRG1myU9w+aSpo4OqtvG3yxEFNd6M7ikpi173DNgPsqsRWFwdrdx5bB4XEe
	 A8q6H1cmPCl06ASuGnbrpbWZlAYRzJ+K8K8kcA4euG0pPgHZscU/G7urty3Q3bfJp3
	 zacOLj7QDxPig==
From: Sasha Levin <sashal@kernel.org>
To: alchark@flipper.net,
	miquel.raynal@bootlin.com,
	srini@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmem: rockchip-otp: Serialize reads" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:03:52 -0500
Message-ID: <20261107060352-failed-5.15-9fc6a1592d84@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9fc6a1592d844c0397f115ee8cbd935169b9a71e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060352-failed-5.15-9fc6a1592d84@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




