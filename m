Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804610;
	b=sYgGXR4dVpY/YPkfZOf0T0lI6GDMBkMV74tUM6hwL3V1dxlihyHh1vB/W2MP38UqaRAI
	 pq0HlbrR+04ONA6FAwYrt7GCKFwfWMBAbKe2K97vxZG1VBaUi1XCExu5u6F0LNzygb8le
	 s0pL14aJ8SL91OAurpLJavN9fvAO2w/jihvPcVJAiMR7wg/tNb9LaZsfcTo2WLz4tE+rr
	 mwj6z45lXwoC763Rafw60VP/Px7NxccT6DeUSeX60gnM5mYA14EkG613TZijwAI9yFV5z
	 tJV6B2D/LzFLaAsiJingOsc8kL/4fsxWI+TzbGxIeuLSpGAZAHNZyJsSWclcpJ6/t0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c9OS2azmNlSLBcd4n3RTnzdEGHNMnl37QCh2ccSxVD4=;
	b=ZoyU0sCYB54N4JUkH1EVtEzIdlN7kxyENRFwxLfqj32itGCoA0iUNNl43bG9Q/x2NV9C
	 SVcqtKhJlspOtsHf/Oh0ixlQ+HpOpIHIi1K0jq5icFXAcJ9g0gMeC/CszbpC5DGowmuJ9
	 CcG/mcZH6oFUeKeyU0N1NPMmKNITE/epU3WdYY7S5Uzetnj5oeYKXOcxUibJbjSTq80FD
	 DkViIhDgKvekDFMrk1gsRUvTrS/D8Gkcvs/SBI1XxEfoDFzXUrzf2uEQA33Ws5Y+Vp92u
	 7v75GjnZCe6MVG5dJspaSn1VKk5+37qbVuA0Gn42WqPZl1LeJn0L9aiKD6vrYlUPaRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ds20111+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1320606A334;
	Fri, 27 Nov 2026 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ds20111+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09581F0092C;
	Fri, 27 Nov 2026 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804610;
	bh=c9OS2azmNlSLBcd4n3RTnzdEGHNMnl37QCh2ccSxVD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ds20111+2KN1q2dkFSUuBH4U60j093SvnLq2b8/CA+dHItrCf4DjINOje1lXgIKWp
	 9Vi4lIDAnYt01OFbCGSXp3vXNOzTfN/HH/tl9IHO4SIFHGFsCC+bUkXaLartZ/mnJl
	 iyI3MYbG2eJ9VOHzi7YWNUxjPwn1fTnwd77Zv6KBSUh0NYRiBESCgTbm1OxPHiFzM0
	 CQHvZ1MnxV5vgMXsuXC1+g+T8bggC1n2FAQGbt7tH7cGAKvrKIXOcNiUKV8EtuXNLa
	 MuS2Wga9GNkBlbswf2h08r5BZTODEKNrUSHjQ2ba9jcqpmMeQ6VdijTNCVi5gWm1LZ
	 Taaz/uuZBxNJA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Uday Khare <udaykhare77@gmail.com>,
	Jerome Neanne <jneanne@baylibre.com>,
	Mal Nadar <m.nirmaladevi@ltts.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 3/8] regulator: tps6594-regulator: Use dedicated handler for external regulator IRQs
Date: Fri, 27 Nov 2026 18:35:43 +0000
Message-ID: <20261127183624.3341010-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127183624.3341010-1-lee@kernel.org>
References: <20261127183624.3341010-1-lee@kernel.org>
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

External regulator and VMON interrupts are registered with a pointer to
struct tps6594_ext_regulator_irq_data, which has no rdev member, yet
they reuse tps6594_regulator_irq_handler().  That handler casts the
pointer to struct tps6594_regulator_irq_data and reads irq_data->rdev
out of bounds before passing it to regulator_notifier_call_chain().

Add a dedicated tps6594_ext_regulator_irq_handler() that operates on
struct tps6594_ext_regulator_irq_data and logs the trap without calling
regulator_notifier_call_chain().

Fixes: f17ccc5deb4d ("regulator: tps6594-regulator: Add driver for TI TPS6594 regulators")
Closes: https://sashiko.dev/#/bug/linux-e6806c5e-76ed-41e2-924e-7110aa9f7d58
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/tps6594-regulator.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index 1bbad407acb7..66052753610f 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -509,6 +509,23 @@ static irqreturn_t tps6594_regulator_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t tps6594_ext_regulator_irq_handler(int irq, void *data)
+{
+	struct tps6594_ext_regulator_irq_data *irq_data = data;
+
+	if (irq_data->type->event_name[0] == '\0') {
+		/* This is the timeout interrupt no specific regulator */
+		dev_err(irq_data->dev,
+			"System was put in shutdown due to timeout during an active or standby transition.\n");
+		return IRQ_HANDLED;
+	}
+
+	dev_err(irq_data->dev, "Error IRQ trap %s for %s\n",
+		irq_data->type->event_name, irq_data->type->regulator_name);
+
+	return IRQ_HANDLED;
+}
+
 static int tps6594_request_reg_irqs(struct platform_device *pdev,
 				    struct regulator_dev *rdev,
 				    struct tps6594_regulator_irq_data *irq_data,
@@ -827,7 +844,7 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 		irq_ext_reg_data[i].type = irq_type;
 
 		error = devm_request_threaded_irq(tps->dev, irq, NULL,
-						  tps6594_regulator_irq_handler,
+						  tps6594_ext_regulator_irq_handler,
 						  IRQF_ONESHOT,
 						  irq_type->irq_name,
 						  &irq_ext_reg_data[i]);
-- 
2.56.1.839.g22a8290db9-goog

