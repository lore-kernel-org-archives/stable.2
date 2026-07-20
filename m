Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E03DC875;
	Mon, 20 Jul 2026 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544848; cv=none; b=NsK94ASfC6EnkB2wdVGRGqcBsQ5c6/OtJLksx/0o5aDI+qrIdNf3npKae9kBnmhjaLWUHzRZ37wghPTgdlmpd5R8PqEtDQ3yaxyuQUIcxrJp0Kkf7eEx6iJa3FgySq+CfzOkDBDGoMXM9yR94vRbTeUKFezAypVrFlbGtYUC2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544848; c=relaxed/simple;
	bh=1/MV4sscPF2kD5vFub3HZlqscaIocv5tQPkG7Ke19HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Aon5HDc7XXz3avh9BXmsaUdcz4qNh7u8KyBH3bdXYhfgYXnhRyqY+LGw9sHomyGb9SvuBSkXs650KBE6oudpjSaWcUWmmz5xsmv1fMS86xszRq5mYl2SvGIwrLTXW50hCtXxSBQp/70WEFUW+RCFX7PoH2DKpoeoXkkzz39vg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC0eiF3T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC0eiF3T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 722FEC2BCF7;
	Mon, 20 Jul 2026 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784544847;
	bh=1/MV4sscPF2kD5vFub3HZlqscaIocv5tQPkG7Ke19HM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sC0eiF3TRuijpybPCzLUpU1jbhqR477o/m8qkHilgAOwP7XSuY5aWtW4GDyVNF9fK
	 pYXUSj9m2ir1cLU1jgKmCucecFUkTud4t0quND5ymmmtVB/ZE0K/pOwBk824Cip1MG
	 PQsgIRcS5KicIMQqKFXThdvoQXNwyQYYfHGMst+3WRjzRtpeyXaeP/uhTLPtRBLP0I
	 GD2pI7kEbH47TIaY/7cHm7qu+pqVxQKb/cew8G+fUsG8p3zvNQs5niWGYvSuRIqO1A
	 V25k5t3q5Jlxl42g0gRyc03PSC0GlrybMdyGSDiUY3Gde6NFBgQbXn3/8FheFl8mZq
	 tST3pKDV7Tfbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDFFC44515;
	Mon, 20 Jul 2026 10:54:07 +0000 (UTC)
From: Pawel Laszczak via B4 Relay <devnull+pawell.cadence.com@kernel.org>
Date: Mon, 20 Jul 2026 13:11:58 +0200
Subject: [PATCH] usb: cdnsp: fix incorrect endian conversions for APB
 timeout register
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-endian-fix-v1-v1-1-b5681fa1ea9f@cadence.com>
X-B4-Tracking: v=1; b=H4sIAH4CXmoC/yXMwQqDMBCE4VeRPXchm2JEX6X0YOPYrodYEhVBf
 HejHj+G+TdKiIpETbFRxKJJx5Ahj4L8rw1fsHbZZI11prKGETptA/e68iLsxT1rV5cCAeXPPyI
 vV+/1vp3mzwA/nRHa9wNSwcW5cQAAAA==
X-Change-ID: 20260720-endian-fix-v1-c16396951e1e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Peter Chen <peter.chen@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, 
 Pawel Laszczak <pawell@cadence.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784545944; l=1525;
 i=pawell@cadence.com; h=from:subject:message-id;
 bh=4tdqriBTc2qKtG8H7cGabgQJM1xpL7ga0H8aaUvEcOc=;
 b=35y75WntvdfaxWt0sa3KMXBjGHpzkqUmWJNoSU0uLyGAZxWxz0d8Hx0dmpAGE2492xKqXu0OR
 L+tYpxObi9WAs6K+dTh8OzaPNsmYMM/K/g40gDha/BlppgL+S+t0XIu
X-Developer-Key: i=pawell@cadence.com; a=ed25519;
 pk=EUPBvLO9CDg7j6defeDl2iqi+z5Ivqu4Z46aiqe7dYc=
X-Endpoint-Received: by B4 Relay for pawell@cadence.com/default with
 auth_id=707
X-Original-From: Pawel Laszczak <pawell@cadence.com>
Reply-To: pawell@cadence.com

From: Pawel Laszczak <pawell@cadence.com>

readl() already returns a CPU-endian value. Passing its return value to
le32_to_cpu() is therefore redundant and causes an incorrect double byte
swap on big-endian systems.

Similarly, writel() expects a CPU-endian value, so passing the result of
cpu_to_le32() is incorrect.

Remove the unnecessary conversions and operate on the MMIO register value
as a CPU-endian u32.

Fixes: 241e2ce88e5a ("usb: cdnsp: Fix issue with resuming from L1")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index a5275c2fb43b..7a516e509198 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -163,9 +163,9 @@ static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev)
 	offset = cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
 	reg = base + offset + REG_CHICKEN_BITS_3_OFFSET;
 
-	val  = le32_to_cpu(readl(reg));
+	val  = readl(reg);
 	val = CHICKEN_APB_TIMEOUT_SET(val, cdns->override_apb_timeout);
-	writel(cpu_to_le32(val), reg);
+	writel(val, reg);
 }
 
 static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)

---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260720-endian-fix-v1-c16396951e1e

Best regards,
--  
Pawel Laszczak <pawell@cadence.com>


