Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF73E63AA
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967456; cv=none; b=bBzFVel5/mNhHQwMGN8FvPAB5Vj5imkXvj7M7/HsZF4l0AkVToSgZyVvXBWW62tG87CNhvJajcplxCFE3DQJcWW2QBWBO42tbAIRXJnqd/DDSbpGNSEgpw6NyoXpB63frIXH2vz8DCre/ZYbWJUsycTf9jIzDVf2wsQZuYnVJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967456; c=relaxed/simple;
	bh=rwJNIapA800sCs366jCkk8FA1RafH1+/r936kftYCMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PgI8CipaCiLxf6orG4Th/SOwN8uDSHOfD4lgyuJdZMfzscdzwWKXUYGQ6VhStEm1iWnVraTRp+6ukwvDoPqE7FLzIXzMSUkjwaS7E5gsVU5n1AGRyIwyhK968ab49BGTysLwUyey8iRdvLKNYde84dAok/VfAr87quLeijQqE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=j6/ndEV9; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="j6/ndEV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786967442; x=1787226642;
	bh=+ORQCulCc5ZwcXJKsviVRkoHboXo/P7l/HLfq2cCUS0=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=j6/ndEV9kGMsmGayX+8qfSwHTpgf1NN4VeoHRPsn3d8fzPB3I1lznz3hiHS3dyOZB
	 Gb93WTf7Tl7yUi4ZPmMTq2IrsadhRa/Nc3idCZQd1+bIn5jCzfdRMA97n4pIVKnkq5
	 +dSmh5W5l6O8EbSaYqOWUtkhuTFkKsBv8SBvMj5Lol5Blc9Vn6eW1+fCzyQ5oBJRPi
	 5H+prC6n1xDF7TNQ6VKD3xE2PEpng/DL9hlfrEiBFv+NMF+lqjjtip+dKGl2rdyPzG
	 29AE6GaNrDew09CbALUgRw+4Ae53+ZyaWIfmiR6DgKOyUT8WzkYRaaBFqV8iXLExg2
	 Z3bUbJiYpuPgQ==
X-Pm-Submission-Id: 4hNrkR4Qdqz1DDs3
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 13:50:27 +0200
Subject: [PATCH] Input: gpio_decoder - fix bit order reversal introduced by
 bitmap conversion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-gpio-decoder-bitrev-v1-1-6ffb77e323b8@geanix.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrE1CQ4mriIV2BmOh0iIScXfF8
 i3+vyCwFw7QJBd4PiSIWyLyNAE79cvIKBQNKlM6q/MKx1UcEltH7NHIFiNURVmRrgfSykAsV8+
 DnN+17X6H3cxst3cF9/0Ayip+PHcAAAA=
X-Change-ID: 20260817-gpio-decoder-bitrev-2457d68fd62b
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Esben Haabendal <esbenhaabendal@gmail.com>, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786967438; l=1881;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=rwJNIapA800sCs366jCkk8FA1RafH1+/r936kftYCMM=;
 b=Nd1TOhgVXbsJnhZ6kENTdL98wgw1fWm+J8b+Er2ez/EEKVBT8la+xUaciXbdu8myVomJhwAPs
 Fytk6IkgPFfBEuQb7sm6D8ozdVFs3JE6ouJbBj0b3JT7leVGwRdH2Cc
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The switch from a manual loop to gpiod_get_array_value_cansleep() +
bitmap_read() inadvertently reversed the bit order of the decoded value.
The original loop treated GPIO[0] as MSB by shifting left on each
iteration, but bitmap_read() returns GPIO[0] at bit 0 (LSB).

The previous bit order was correct according to device-tree bindings, and
the change broke existing users.

Fixes: 4eec8772e4f5 ("Input: gpio_decoder - replace custom loop by gpiod_get_array_value_cansleep()")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esbenhaabendal@gmail.com>
---
The refactoring from a custom loop to gpiod_get_array_value_cansleep() +
bitmap_read() caused the bit order to be changed from reading MSB first to
LSB first.

The device-tree bindings explicitly states that that it should be MSB
first, and the change obviously is a regression for existing users.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/input/misc/gpio_decoder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/gpio_decoder.c b/drivers/input/misc/gpio_decoder.c
index 0e4a49845afa..055bfcbd5235 100644
--- a/drivers/input/misc/gpio_decoder.c
+++ b/drivers/input/misc/gpio_decoder.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/bitrev.h>
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
 #include <linux/err.h>
@@ -39,7 +40,7 @@ static int gpio_decoder_get_gpios_state(struct gpio_decoder *decoder)
 		return err;
 	}
 
-	return bitmap_read(values, 0, size);
+	return bitrev32(bitmap_read(values, 0, size)) >> (32 - size);
 }
 
 static void gpio_decoder_poll_gpios(struct input_dev *input)

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260817-gpio-decoder-bitrev-2457d68fd62b

Best regards,
--  
Esben Haabendal <esben@geanix.com>

