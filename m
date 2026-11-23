Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458761;
	b=IU2B6IBk46ETrqOT2/bE6fwATAx+lNh3MF/sylRP77dtR5QB6UpDYg/opJQgJKiB1Xk3
	 v2jLuow7h59bkqsXxB7V6iT2YbZ4AIfu+sVMf3+nZFrHYr5OIcSlG0S9v/uF6ER9NCDs5
	 gjfxjoCkjRz+WocEXXMk4yTuXolhDMGwA1JiasIutQwiMkFGF/zYhN2yFM7cGXzO3ehDE
	 97CZra+j+oXlgvUDzeqy3A4RqGzWyiBJ0jhvURD7zZb5dsnbZLb/OLxIDArgRa6XO1U3f
	 fG0Xe45opAdvvgPNRf5L4u0V5412lCZYmfu65v2WtA69VwK/Op/FZCLv7Ov7L9+o75g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458761;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZvOaChR5qJW9QxRGc38ZD60Y8kBGkcLpTHhpADdCCRM=;
	b=Ml4hoEKgmLJUh14PzJsh6i3vo587F8nqUnmDTKiUxRm/ocC28QW+ucGe4utMugluez+I
	 i6ZKLx26A3uZxh8LI+Hi1CTO5RQoDfD7dQd1pgvYwFTgaTp/In2Vz8jL3xDkINlwzvpey
	 7Qc6QPWPetVDdSVlZq1skg/GGo7ti7Z3p3uKwYstG2dMUk7wsAbHBEfYtaaFJyk1PBnaG
	 ZzG9LiP5EMbxvl37ToFcF474M9eO6klbEKxpZE7QWiRuOheWkqgynxFYyiJuePPzsY+9H
	 Z8O1oY/ih/sz3rSjJYoR2U6Bitcen451bYQ8V9daqaMpmQjOw2q+YIq1tgCNoz6tWCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y62II9IL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93085606A681;
	Mon, 23 Nov 2026 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y62II9IL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6571F000C0;
	Mon, 23 Nov 2026 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458761;
	bh=ZvOaChR5qJW9QxRGc38ZD60Y8kBGkcLpTHhpADdCCRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y62II9ILA3rN3No3O6m5eWsc4cqBw6I17lR0XMhB4mPbY+o9smCMNRy+QaDbn6qfq
	 Lg5kSnFhk8u2oI0d8XhAXaRfFk/2KbuUL5aNKQSTCRd2lCiIpSypF7iFctu5FiAFr2
	 EnlbEkjqPcrPOrKGVvbPx/BBvsHHKvlpraAMO8a/PZ7IvLOj86gsxx9HpAK+QGbxYo
	 mfjo8hvryUyTXxlOJu+B+/v6b0P1y0fS0pyqyTfYY5nAAEZsr3/zSUsgeF+xX/4btW
	 3PBBRrFPEsNhov37l/B5KKeleDpfuwjfLCrhgQtoVD4D9Pvj5izdjqcO2Vn4l+WxJr
	 hXTUXbX0pWFDQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vojtech Pavlik <vojtech@ucw.cz>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] Input: stinger - zero-initialise driver state in stinger_connect()
Date: Mon, 23 Nov 2026 18:31:11 +0000
Message-ID: <20261123183200.3900004-6-lee@kernel.org>
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

stinger_connect() allocates struct stinger with kmalloc_obj() without
initialising the signed packet index stinger->idx.

When serial bytes arrive in stinger_interrupt(), negative values of
stinger->idx pass the stinger->idx < STINGER_MAX_LENGTH check and cause
stinger->data[stinger->idx++] to write before the start of stinger->data
on the heap, corrupting stinger->dev or adjacent slab memory.  Initial
values of 4 or greater never match the stinger->idx == 4 reset check and
permanently wedge packet assembly.

Allocate struct stinger with kzalloc_obj() so stinger->idx and the
packet buffer start zeroed.

Fixes: 17dd3f0f7aa7 ("[PATCH] drivers/input/joystick: convert to dynamic input_dev allocation")
Closes: https://sashiko.dev/#/bug/linux-bad333c0-5b62-4ca5-ad93-204400bcba3a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/joystick/stinger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
index 011f9b137dca..021216f811c0 100644
--- a/drivers/input/joystick/stinger.c
+++ b/drivers/input/joystick/stinger.c
@@ -118,7 +118,7 @@ static int stinger_connect(struct serio *serio, struct serio_driver *drv)
 	struct input_dev *input_dev;
 	int err = -ENOMEM;
 
-	stinger = kmalloc_obj(*stinger);
+	stinger = kzalloc_obj(*stinger);
 	input_dev = input_allocate_device();
 	if (!stinger || !input_dev)
 		goto fail1;
-- 
2.56.1.750.gf70dc682cf-goog

