Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460441;
	b=r25znKySwz2OdkG0ecm/yNnJaLBKExMPC7C8YwarMM0znme/WYCfVJcPu0+uIUGmrMxX
	 rHoKNEWtAgblIlLx/a3SSJDorrYJmlQhruqL1/NVEzgO/44TGs0vuLjzZZ+WBppzp5M4C
	 2aUEPQq6EpQxEyP1fs3wlsisheJ+INOzBZu9fx9MX5bcbHc5j2tfeLpXDVkPYFQtBoY0A
	 fpRXSAuXxubFmWi3UuybJkGkdxwGpiUhVnctOqQ6VVrCzq4DFFo1NW1q7KG6W1izohgPp
	 BFLT6iXb3ptrvZaNGaO7sz2WubyM6BFRdORySZ17L2oemBoTDqdBLZTGDIYmVGu6Vsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XkJYUOnm+jUv0At3PwLFxIblwxzGGYHTzUjuzyQmNJk=;
	b=q4/I9JAWS2Rn6za/6wyxF6fbk1JyzIKbMQcZt5NpXR2Z13MzIeQFHSC4iQ8V0b85WwAf
	 fX03ExzF2uSuPyLFVSLlCK+4aRPogXTw194yiGPQ/FlG/zQyw0QSgoJatAExVtRyZYZvM
	 gfp7IMACSXCjcS5xszsPea3Sn4GMEXOHdT6G5+0JUhaCtYU2JSiOeHQeke9Is7QWe+6GQ
	 FaLZVluEWmY06vxS8veNSgK0aTpGTviRtytYcJ6qoM2X1m6UHR3s9G0RN1w1mQjra6F+n
	 YbKajPu7Hi5F3keNg8hy9JHYRotSXK6wCmm8WbHU3TRD5XTU3zJgJJ05tqVn55v5HjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OZ/eOdRP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55552606A330
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZ/eOdRP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FA61F00A05;
	Thu, 12 Nov 2026 05:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794460441;
	bh=XkJYUOnm+jUv0At3PwLFxIblwxzGGYHTzUjuzyQmNJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZ/eOdRPoAL6GilOd1DedpIddGORX958QP8eoLX/MLz3GwhK5Av/rHQBlkJPrsuKf
	 6rc+fPkZF73YFPuMGRBHR87tWRWNTn1eFc5sXpbYuN+gjj27Y2+sIPN3E1wbUHxk8Y
	 oSCslapVhkwnyHi5mTlsWJtBwQuiWvg/zNxwcn4EZJvbVgpRrzD68Ic2EDVZ2xCLz3
	 213WqGDZL5gZGpAUU4rnBXTXKYxOaq2uR6nghk67lmtQBXTipavjx36ROizcHjUZyz
	 jeexfj1lkAlaQq5hFjiWkFVJeN/A7YQZEpBOJ/4kH0dWj2V/ED1cSOA+DOdtkDQK2f
	 X+TMFA9adwLyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] hwmon: chipcap2: synchronize ready IRQ state
Date: Thu, 12 Nov 2026 00:13:57 -0500
Message-ID: <20261112051344.2630398-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112051344.2630398-1-sashal@kernel.org>
References: <20261109200334-failed-6.18-8c02722be2ca@kernel.org>
 <20261112051344.2630398-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit 8c02722be2caa6604a837b81faeaba78250eda4a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/chipcap2.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 49df66728ae9d..3eee0e41e1e4f 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -120,6 +120,16 @@ static int cc2_enable(struct cc2_data *data)
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
@@ -127,9 +137,6 @@ static int cc2_enable(struct cc2_data *data)
 		return 0;
 	}
 
-	/* clear any pending completion */
-	try_wait_for_completion(&data->complete);
-
 	ret = regulator_enable(data->regulator);
 	if (ret < 0)
 		return ret;
@@ -159,6 +166,9 @@ static void cc2_disable(struct cc2_data *data)
 	scoped_guard(mutex, &data->irq_lock)
 		data->process_irqs = false;
 
+	if (data->irq_ready > 0)
+		synchronize_irq(data->irq_ready);
+
 	/* exclusive regulator, check in case an enable failed */
 	if (!data->regulator_enabled)
 		return;
@@ -498,8 +508,10 @@ static irqreturn_t cc2_ready_interrupt(int irq, void *data)
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

