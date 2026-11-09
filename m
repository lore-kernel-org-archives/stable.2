Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192472;
	b=vLfFjWGEkZpr1Q86+FCDE19ahBHQvbk3cWRVp3SiMKKKtTohwy/Gy679UBBDzLihwwqh
	 njyFqs1MIEOJbCpxYHXs10jwT0zK/KgvMeaMw0kcMZ/addq3AbElNNEniG3VAvot+/z/C
	 FHBBWAoGoZFYCb44DXTIU2H+q2CZe7P17mlQULE/4OZxb+1S2ic5a+1Jp0FIyTPHa1FPB
	 cotRjPI7torcEmjbMJR2AggObJqdpOTpNRVZr3frwOzNNX7mRs3hTAxiGBy0/NNBdRdPJ
	 X6Wl0y3gG4DBleuVsZD+/YqoslQvod/nqk5ztz9DrN3ev73vuethkvJTLqyIQlN4U9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192472;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GRkGWJdow7LnKbpX5JlZPVilDl9b6ZVAJ9cwufjvibU=;
	b=NOXz2JOi/W36fcgqNr2rS+hsm5weMN7sjMVqwzS6QGZNlLBGz8ukjDjUi5Mxk31tyxPF
	 absiBcm3FieISTmRsRfrdDOPXwWdYPhni89WVK+eJq8nQ+zy6fA1UNaOx1af5wmIimhao
	 tbu7tQcRDphqcvVLrKrojZoTY/gRtzqIAPYXm7nkxoRnzv+UqpNdUZB4CKk05MeQIEPUX
	 Aqy2GVFoOjBsuk5Bhgjm0BJzaQLEhR5Up8URsR8vlmlVbku+ZQxD04BCilfJW2ijQp4K0
	 e/tMJlglm5DAYY8Ngg+9b9KG91s5i9CI8qSvNssxbMXBVx4BeBUfCdnlwKhkBLqBTSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTXdwLkQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B9606A31C;
	Mon,  9 Nov 2026 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTXdwLkQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC6A1F0089F;
	Mon,  9 Nov 2026 02:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794192471;
	bh=GRkGWJdow7LnKbpX5JlZPVilDl9b6ZVAJ9cwufjvibU=;
	h=From:To:Cc:Subject:Date;
	b=YTXdwLkQ7A76X+YsKQWOO9LHtIXvgozb27OOGdfMy1nB3k0Gckke3O1oPfZJyLSy5
	 pvDNWfdUUROYtJBPTnEsENqRgft47eiU8nhRUtgHM0rBoDVg4H+ngX6EJY4IYpQdAN
	 DBwSBFjNMMGFUiPY9l1i6U5esIPT7COeOFMzGivHJ120uZ6e7qgfZBSDFat7Kilf6P
	 N//oxW61Gf42mGWLXJ3keeE28qXc4jYLFfbeML64saaxagtxRZQlAK4qPJpW2aYa2F
	 O/HDt6U8mG7cVH5YjjOaLBJAvHsZFG8LW02IU5Z5G9ZSvfN8Q9ddxz74MzmovKgqd0
	 1I7Fst2eXDSkA==
From: Jonathan Cameron <jic23@kernel.org>
To: iio@vger.kernel.org,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Kurt Borja <kuurtb@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: light: opt4060: fix inverted own trigger check
Date: Mon,  9 Nov 2026 02:47:45 +0000
Message-ID: <20261109024746.1253593-1-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
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

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

opt4060_set_driver_state() is meant to keep sampling and the interrupt
on every conversion enabled while the buffer is in use with the
driver's own trigger, as that interrupt is what fires the trigger.

When converted to use IIO_DEV_GUARD_CURRENT_MODE() the negation of
iio_trigger_validate_own_device(), which returns 0 for the device's own
trigger, was lost. As a result, with the driver's own trigger in use,
enabling or disabling a threshold event switches the interrupt to
thresholds only and buffered capture stops. With another trigger in
use, the one shot conversions requested by opt4060_trigger_new_samples()
are instead forced to continuous mode.

Restore the negation so the code matches the comment above it.

Fixes: 8284a4985416 ("iio: light: opt4060: Use IIO cleanup helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
This was found by an LLM whilst doing a refactor of related code.
Indeed seems there was a change of behavior in the sited patch that
wasn't as intended.
---
 drivers/iio/light/opt4060.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 8253a6a8bee4..1a7d429453be 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -310,7 +310,7 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 	 * IRQ and sampling must go to or remain continuous.
 	 */
 	if (iio_buffer_enabled(indio_dev) &&
-	    iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
+	    !iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
 		return opt4060_set_state_common(chip, true, true);
 
 	/*
-- 
2.56.0

