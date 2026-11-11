Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434051;
	b=piKBhtIfbWGLIj+BnXP8a1QUFX2Jq/po5d+semue3OUWkw51xRckp6OmK2GKtNZSgzZh
	 wNMJfZkX9aeDaEqh8DzzeQGXC86pfiSU55nhXaR5DstrMW9fj3eut3V7dV/XPDQ2s13YK
	 V6fTAxEtzQT6whPTSqPvVbeuQKIGhFRQM28gq+bLvdqbZdwFS++EAKVh8qj3WaWJcqKgJ
	 iD+U8WJZ+ZCrhxoadnpXnhWz9c80PcC35zRi7AoP4JuTmDCqPZbFip4597t2w93zdHWSB
	 c9TlL1c9KfU7dzw1w6G/808Jor6ckgJsogG5uzsdJZ9togZ7/asZI3FgMYLMwfexOSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X4BlzCeHQzorY7dg3XAAg690sqe0fbcnZHsVN+U+YqI=;
	b=SbUR1AZZH6FDm8OSXTLsMglW+J7CLt3gvn8Un2ZyMEUPpXQllFGXWgqef+3WSWRI0jK/
	 4qx204YAIIt5k4Z/ZMLpon/e70PGXuhTDe88jFYeEQ68ox2TCwuwb/NAOtpw1mkWDzpXK
	 n8c/jRyheNBEftP1pktmoYB3VP/4ovGcXYgCTIjkpv+cmd91OzuaUbDvTANZ9r2RU0C3M
	 HxembUoJ9ZmeaxpIREfK+AJ3pYsPuIyq9a/1VmM8xW+eHaJINHNoJsQxuA6z+K3Z5m4cC
	 5qiLSLqi+5FcVCp+P1G9LP5g1sOSg0RGuYzJB31Rc/KQGwWuBMSZEaONT7freth/ONw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtHaOoS9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D418606A31C;
	Wed, 11 Nov 2026 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtHaOoS9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3361F00A0A;
	Wed, 11 Nov 2026 21:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434051;
	bh=X4BlzCeHQzorY7dg3XAAg690sqe0fbcnZHsVN+U+YqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GtHaOoS9vESStZIXTI4ppzXxIJQXp0OiTgIVfzRrnb7tWGGcGUN1gT+aW7AFJ2V7n
	 sdsoZXNJoGLwr3U573wxWPV5gE1El7jWOCxTMvNsCCDLZwxOd4q3qbo/Y4hc7nV+rL
	 V89lsTlupWpmgSBU/03OgML4NrIVYFYd1v69oVnK6OElvfnySmOlXwY691AOKbkByQ
	 RgH/ELSKDx2m3Y0Y8BNziUTp1xoQe1AvzNv9bx7ucVxEz7l/kIlqiZ5JKWBh4x2Qeg
	 rT+fSoISTQAPc+hG71Kqr/UQuKeIGo76FTnuZrZiYKBmdiX8IItAuBO8kZIBSpj9mk
	 kulFkB/y4a16w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dvorkin Dmitry <dvorkin@tibbo.com>,
	Wells Lu <wellslutw@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Gaylard <ag@ffroot.co.za>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] pinctrl: sunplus: Validate pin_func index in sppctl_dt_node_to_map()
Date: Wed, 11 Nov 2026 21:51:54 +0000
Message-ID: <20261111215256.1982044-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215256.1982044-1-lee@kernel.org>
References: <20261111215256.1982044-1-lee@kernel.org>
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

In sppctl_dt_node_to_map(), the validation loop checks that pin_num is
within sppctl_pins_all_sz, but does not validate pin_func (bits 15:8)
before indexing sppctl_list_funcs[pin_func] for fully-pinmuxed pins.
Check that pin_func is less than sppctl_list_funcs_sz when pin_type
selects a mux function.

Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
Closes: https://sashiko.dev/#/bug/linux-977252d6-b0cc-4d3a-ae2d-59d1e2f8a649
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/sunplus/sppctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index 8a3fb9b56597..843641528e4e 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -867,8 +867,13 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 	for (i = 0; i < (*num_maps); i++) {
 		dt_pin = be32_to_cpu(list[i]);
 		pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
+		pin_type = FIELD_GET(GENMASK(23, 16), dt_pin);
+		pin_func = FIELD_GET(GENMASK(15, 8), dt_pin);
 
-		if (pin_num >= sppctl_pins_all_sz) {
+		if (pin_num >= sppctl_pins_all_sz ||
+		    (pin_type != SPPCTL_PCTL_G_GPIO &&
+		     pin_type != SPPCTL_PCTL_G_IOPP &&
+		     pin_func >= sppctl_list_funcs_sz)) {
 			dev_err(pctldev->dev, "Invalid pin property at index %d (0x%08x)\n",
 				i, dt_pin);
 			return -EINVAL;
-- 
2.56.0.567.gdb80ae8cd5-goog

