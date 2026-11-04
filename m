Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816523;
	b=uvXDcOkuC1WA1F/EcEtqLq5uQDb9zJ8VAVJTpkJMBO+jFYh4X4ZkLX6+JFv5RJaCWa94
	 XVd5kNx9cDYpzK6A087w5etjYTBdaaxCcGS6/SgTLz8toPxkg/+8oQd/q0dXyouY0x+9I
	 7GacP3N6DbToubqO1dB4sdptMr9WpEJgx/IZVSHw6OdzQ4PiBgayMedaoxZIsilLevbHg
	 9vtCLxsbW8TQ9ARygE+LzT7GL0yCQ2yY9kU8rwCGeesimknK6GPkXVupKg/KESwWQk2h4
	 yT8kOwm8G8VAcnuCp4AoS8Ba0QJC6roM58pI+dq5Co6SLs5ZA7u/bYnSYAsDQkX4T2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816523;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2Lb0uNXFZKwxApFZZbX7951Z/FqgPJAvA9lFJWo1YIE=;
	b=jTBSWqLj5ctSbpr02tS31uDpidk+4u41TlrsmnfPYX78TJ8unGybrnt0bf2aWBbU9i/T
	 OY35skWKyZ24/FCpFxv3vBK0Lj703Blem+32t84lt5A8jBkLPod36uFpemu0zAC/zleyw
	 lOsVv1kDFCXKq7upJSysqcVGOw2Zlh4entFcFLybNtW11slj7xO8Trx16Db3ZnOeQJVLK
	 kNqIRkRP5mAqbypDq5/yr/vvvaJQFT53pJWCRTCjjgYxVMP6bdoGH7BBnACC0bmzyinfa
	 ZUmsRe9rphrmLQuPuIbNKDOzuZN0OnfGYmNv6oFPLctuXk2kIg6oqa7+MuKmuFulgOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ia1HK0ow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69023606C464;
	Wed,  4 Nov 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ia1HK0ow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980691F00919;
	Wed,  4 Nov 2026 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816522;
	bh=2Lb0uNXFZKwxApFZZbX7951Z/FqgPJAvA9lFJWo1YIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ia1HK0ow/x67udk5VYPpnXi4bDg3+tYbm6RZdaoLUnr4gUwMHy0nSL7q2G2bXt7uj
	 I2JCbXirTWjSZBBYhHYa/EcFCg+KU8ZkQOn2lq64tW7o8Cd42YIM6pXLKjvcTmyzEt
	 rBIkLu4YnjUO+9/uXS78Q3tYKXFAdj92DFbNikvADgiv0X3x5x2jNcPVfCyTXTseFV
	 qwNET3qXzV9bCY03aIG6ijEC125pbKJVbrO1uN7otCkOh5WiZVNyXk4X3N9+bDFHQP
	 XsL8lL+2zhD/C5XSwpIIbfWEkMhSuZ4gAeUsBrDAJxgD8t1SXxMTkM9gyxjezlryNh
	 ZqVBH6Ji6RqBw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jiale Yao <yaojiale02@163.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] regulator: irq_helpers: Clear caller handle in regulator_irq_helper_cancel()
Date: Wed,  4 Nov 2026 18:20:51 +0000
Message-ID: <20261104182148.1176116-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
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

regulator_irq_helper_cancel() is documented as clearing the caller's
handle pointer upon return, and takes a void **handle parameter for
that purpose.  Instead, it assigns NULL to the local pointer h before
returning, leaving the caller with a dangling pointer to freed memory.

Dereference handle to clear the caller's pointer as intended.

Fixes: 7111c6d1b31b ("regulator: IRQ based event/error notification helpers")
Closes: https://sashiko.dev/#/bug/linux-5c3d3b21-3823-4654-bf5d-85407c5fd05f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/irq_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index cdbd170d2b15..7b25eae667e3 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -403,7 +403,7 @@ void regulator_irq_helper_cancel(void **handle)
 				destroy_workqueue(h->wq);
 		}
 
-		h = NULL;
+		*handle = NULL;
 	}
 }
 EXPORT_SYMBOL_GPL(regulator_irq_helper_cancel);
-- 
2.56.0.385.gac671c819a-goog

