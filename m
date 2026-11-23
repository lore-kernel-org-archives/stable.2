Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458735;
	b=I8NJq/bLR4hOsc+EjdY9blKkzWy0/bPXaUBp0y0QyHdHOqw67N3bwlZjDFJZtKn4thLW
	 ZD2A/7dGs4lPAQnEZh3ogB09k+jh8xJSVEeinrnTo0HhSWxuC26T5JEhVLw0dmrQX92Zr
	 sbYWmvEPJ0MXPfyymjM20qWZC6r1G/BUiEuHjD9tFxW0+SxVsBSV/laSWr/NNLNTCMR8E
	 BLrryAuoRkQ4ZBKP/S8QYaMJSTQ1ip3jw+BzZWpaaVztRKQFETDjq9BhLMWTgTqOrIAK0
	 W2HyxzL5XwxMtcT3SM/+ojof9L8bm8VWPqU2TiP3WkvERtTYCLpHt70LboX6Neag4VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458735;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9zegeB5gRRxUPqcdiHr7DadAbcfKhJYs6IujRNLISxk=;
	b=zxIIHeWaJoLdZeSN1w2JMPhT/K2xdK9HQ4sMNbVpliup80juZgTNYnpsANQ7/IU5t+gk
	 aI1F5tZLjP3RkUJKqbK/tQohojjbeutiHHhmmRPH8G0iLf8apMFvHVVTIXySTlUWcIXtu
	 T+mNqbmCAxLgi6wL7MJnnc8/3NvDH5p8RFTIRxU4n9xsud+OqKl6/Ac9Mk4mTNnwCnqPB
	 K2JzSZy7WFu8nCQO5rvMENbBp0gmSnu5R3RVhedlNKguo4GGwg/0JS2D6P7ZBmdAHD7Oy
	 4Tki4slm7kWcxOZOQ0TeRsBQUdrD9Z+xEGqRU8DR2H0qOctcbNMU+Y3U0oP2dANcCgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oT8hQM77;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91188606A31A;
	Mon, 23 Nov 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oT8hQM77
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014FF1F000E0;
	Mon, 23 Nov 2026 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458735;
	bh=9zegeB5gRRxUPqcdiHr7DadAbcfKhJYs6IujRNLISxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oT8hQM77uV3+RT6gMGqAYeZzzFo4iPPIJjZ72ab4Uh342bbVwMBA1bCLaLlP+ZR0P
	 yh/Grf1XkOEg8Uemn1Wo+wDrSrTLHuOCR86Pzuip0bpQbG4YZ44iaKR4JTYzqDxZo4
	 mzGaEYi+GSAcEbwdAyvNTTHr4Ee9b+c2dW9ZAgM3kkhmmWw6hYXx60P4Eylr/0o0o/
	 pXI3L220HP5PY5QRaYdQkSmSN4Xj/+9rOqGar4zIa6fBWujqddevuA3ffusm0bzSXB
	 g9HkAYw+XtQx9gFnxwKURGB6uwhQEgdUib2eYyjB5k3T00in9T2qkitSkI2o5qIBXp
	 GnIwtuN+YBKYg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] Input: matrix_keypad - validate GPIO counts against matrix limits
Date: Mon, 23 Nov 2026 18:31:07 +0000
Message-ID: <20261123183200.3900004-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123183200.3900004-1-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
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

matrix_keypad_init_gpio() obtains the row and column GPIO counts via
gpiod_count() and only checks for negative error codes before storing
them in keypad->num_row_gpios and keypad->num_col_gpios.

If firmware supplies more than MATRIX_MAX_ROWS (32) row GPIOs or
MATRIX_MAX_COLS (32) column GPIOs, the setup loops write past the fixed
row_gpios, col_gpios, and row_irqs arrays inside struct matrix_keypad,
and matrix_keypad_scan() overflows the stack-allocated new_state array.
Conversely, a zero count causes get_count_order() to return -1, leading
to an undefined shift when computing row_shift.

Reject non-positive GPIO counts as well as counts exceeding
MATRIX_MAX_ROWS or MATRIX_MAX_COLS, and size col_gpios with
MATRIX_MAX_COLS for consistency.

Fixes: 584bf366f8fa ("Input: matrix_keypad - switch to gpiod API and generic device properties")
Closes: https://sashiko.dev/#/bug/linux-ed4b89af-6c76-4e5f-b140-fb2b107b12d0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/keyboard/matrix_keypad.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 11018382e84e..c2f839a3de90 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -33,7 +33,7 @@ struct matrix_keypad {
 	struct gpio_desc *row_gpios[MATRIX_MAX_ROWS];
 	unsigned int num_row_gpios;
 
-	struct gpio_desc *col_gpios[MATRIX_MAX_ROWS];
+	struct gpio_desc *col_gpios[MATRIX_MAX_COLS];
 	unsigned int num_col_gpios;
 
 	unsigned int row_irqs[MATRIX_MAX_ROWS];
@@ -302,11 +302,16 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 	nrow = gpiod_count(&pdev->dev, "row");
 	ncol = gpiod_count(&pdev->dev, "col");
-	if (nrow < 0 || ncol < 0) {
+	if (nrow <= 0 || ncol <= 0) {
 		dev_err(&pdev->dev, "missing row or column GPIOs\n");
 		return -EINVAL;
 	}
 
+	if (nrow > MATRIX_MAX_ROWS || ncol > MATRIX_MAX_COLS) {
+		dev_err(&pdev->dev, "too many row or column GPIOs\n");
+		return -EINVAL;
+	}
+
 	keypad->num_row_gpios = nrow;
 	keypad->num_col_gpios = ncol;
 
-- 
2.56.1.750.gf70dc682cf-goog

