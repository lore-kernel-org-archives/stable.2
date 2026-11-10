Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272843;
	b=2m+mlY/VhmW/VgZqg9meLVupadgu/wrW/O+lUP7xmj2rHwREaEx73n7Fksd5WR1eTAhZ
	 YiWk3qoWqlyTRSVDtvnI0GbacRcn08ZOr/2nnqurNvIr10zbSvNgkXmQcjH/H70Qd4APJ
	 RlFkYMkLvI4RAXCgFuJO9e4CGJrPinYDNBFNdlcJQenQZjbJ1xwPOd5bQY9xWjfIqOVP2
	 L9X9n7/a/iPctdlAqGmu0tfuU5ysmYYysz5Ki+EzCSTiw00YCyttnsBkomFXpRMxTQnlw
	 wyTV8LGQNZ+rqbp9ADzSVUG9VrCwLJRkcedNjwmX4g5Kvjt9Y6eB82Ge4SMnOIk/8xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272843;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GIOJLF+yB7OGNGXuTxSEOPo6C8jxwRqG4WQ+wn0q/Cc=;
	b=sPIfjDxRu7hMd6Ppumo1VFyzOjmYX0UodPCvuLOEuAYuSduo1KfUyHcNjYzbpl8FZZmO
	 kIlErsIg1BHz/JOMZzk+q1E9/zBF5/MEWganZ4x8m3r3oGEq6EfvtPzt2/5iDkFtPkj4A
	 PNckMA77OhXh+CX6zUlbSV/CVuDFEJ/iIyKiPA4XqskjYcr0R3sJfeWAoxtTeS3YuvzvU
	 +XT71t6BOc6tAfBQthC2ZHB+O7jdqusTyiokLfb5fnCi6M7qXrFDXBZL5SNf0ex+TPnhO
	 FEhQtKNxenU8vhiVF4LV8C9j2q+UdmA4Ef4h4DrOkZ005N+uMuZdO0laBT5MFSVErog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etngWYQA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E31606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etngWYQA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70E61F00901;
	Tue, 10 Nov 2026 01:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272843;
	bh=GIOJLF+yB7OGNGXuTxSEOPo6C8jxwRqG4WQ+wn0q/Cc=;
	h=From:To:Cc:Subject:Date;
	b=etngWYQAdd6hiHPqgbvzg7zv7hdDEeJucvU1nh3/V4ff027UFK2PbVIBKfujIlb2b
	 vR5iW2k9lnDv8e1pTlHFItEqVV1WvMvJvx3ESoJg0ETAE6CdQHbPcEMDMUeNq/vkM1
	 HvIM6AoA7vYk0zHR+S+JRH7pXjA1OMyRLOucTy03axGoeHAR+lziIzfDiwNZ/706pn
	 gW/vbj4xsmSRTBt8wg2307O/vMr149texZRnBl/luCId9SM61tV4dPo/ef4ygy6KT2
	 s3S5UDW1knyHA8simZWt/6hDTwb1Cu7W2jUBHwKPEkbwLgJyJDRAfEGV4B9WLX6Gu/
	 w4Kc/f1wfAnjA==
From: Sasha Levin <sashal@kernel.org>
To: javier.carrasco.cruz@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: chipcap2: synchronize ready IRQ state" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:21 -0500
Message-ID: <20261109200721-failed-6.12-8c02722be2ca@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8c02722be2caa6604a837b81faeaba78250eda4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200721-failed-6.12-8c02722be2ca@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8c02722be2caa6604a837b81faeaba78250eda4a Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:10 +0200
Subject: [PATCH] hwmon: chipcap2: synchronize ready IRQ state

The ready IRQ handler can race with reinit_completion() in the enable
path. In particular, a handler from an earlier operation can complete
the completion after it is reset for a new operation.

Use irq_lock to serialize access to the completion and process_irqs.
Disable IRQ processing and synchronize any running handler before resetting
the completion for a new operation.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20261014-chipcap2_locks-v3-11-27ebfc2c5b9e@gmail.com
[groeck: Dropped obsolete 'Assisted-by: tag]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/chipcap2.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index b3b725cc7224f..00f62a33d4637 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -123,6 +123,16 @@ static int cc2_enable(struct cc2_data *data)
 {
 	int ret;
 
+	if (data->irq_ready > 0) {
+		scoped_guard(mutex, &data->irq_lock)
+			data->process_irqs = false;
+
+		synchronize_irq(data->irq_ready);
+
+		scoped_guard(mutex, &data->irq_lock)
+			reinit_completion(&data->complete);
+	}
+
 	/* exclusive regulator, check in case a disable failed */
 	if (data->regulator_enabled) {
 		scoped_guard(mutex, &data->irq_lock)
@@ -130,9 +140,6 @@ static int cc2_enable(struct cc2_data *data)
 		return 0;
 	}
 
-	/* clear any pending completion */
-	try_wait_for_completion(&data->complete);
-
 	ret = regulator_enable(data->regulator);
 	if (ret < 0)
 		return ret;
@@ -162,6 +169,9 @@ static void cc2_disable(struct cc2_data *data)
 	scoped_guard(mutex, &data->irq_lock)
 		data->process_irqs = false;
 
+	if (data->irq_ready > 0)
+		synchronize_irq(data->irq_ready);
+
 	/* exclusive regulator, check in case an enable failed */
 	if (!data->regulator_enabled)
 		return;
@@ -510,8 +520,10 @@ static irqreturn_t cc2_ready_interrupt(int irq, void *data)
 {
 	struct cc2_data *cc2 = data;
 
-	if (cc2->process_irqs)
-		complete(&cc2->complete);
+	scoped_guard(mutex, &cc2->irq_lock) {
+		if (cc2->process_irqs)
+			complete(&cc2->complete);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.53.0




