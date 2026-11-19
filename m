Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121498;
	b=IAsrtKCEn8EWxixjpPkLKZDHiCwuTR8psP1lKP1I2m58arsABHJU6mj9sT5Wjx4Je34I
	 n1FZtmpOOPt9GHxYdhTj0qW2ygJyUM5WoLu4OBk4fLIWJUipEDHJwkXKh9CJFCr6pW4FU
	 +fdpujSy5B5k6Bw8U6QgGMEmdtgxFNiHLtdgOORC1e2jTItGg7/iysbSKxXwS0wrabIqh
	 1wE2ZF0Vz0PeOT/vTPEAeqzuK2Ui++eaFQuXIbcPjaK6cBalWW3AccUSPYotORk5EhqI1
	 O1Brf0z+5Vf7HXIxdKY3HoI7VNx2JJA2koxUcHSNzVWiy8WYndpgLkzBdh/YydCjngg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=soxlIylootx2LrMLsFxRQH6OReb/MBAokdhIglKABwc=;
	b=SQFkA0gjX3QBIdqYqh7gtyVIbaxY4/WGZd+veLmXglmw5xgYtSofgetmnBhYa921IuTu
	 55zKRfgJlmw3+HeTIHOA8f02W8JyGVTRhENMzPSgwrFASKz6K1bWJRXIUorMrJ7Qg1qyr
	 N97L+FlSMDO9lGMwGvLjOQWkhlIdza34DOknq9QvQ5V6LDh9EzA+oE/TALpbtTFZCd5wm
	 7lRJUhIfhZLthmUt+RuR/RBFO+g4oBclrm92xSP+FOBGarPLlPN7dMxsScDzTIsiI0ICk
	 EMH+LFA9751O1eiRsLhCDsDnfz3Ty9J6Erfyj7YIl94F+zu2VjlvV5grxGNLA6UTBmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVPz6Nda;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E63606A939;
	Thu, 19 Nov 2026 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVPz6Nda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232531F000C6;
	Thu, 19 Nov 2026 20:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121497;
	bh=soxlIylootx2LrMLsFxRQH6OReb/MBAokdhIglKABwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVPz6Nda8QVPEGVZtsccO9VQz4HXPaaqzUIMe96Jh0thezpdIRWNMmfTQ0aFwi6ZP
	 DBdKYu3D8TIM0cT9EmkyQ1Yi7K7LmXh3JQAekax7L0P67NQ9pMfS93Qq6pAtpokhRk
	 a/O/c7oyyLG+sfTWkouBMU3UpHq6np9D6xHZKyUwtHzmIhVfZVZqro8v541G2mU2jE
	 rBabblxnDzKbunSYWc6Qi5DqTmMJa1meyBvU+Q50t7j9VgP5yLUK8U3VjDMN0JX519
	 YAbLxFFw4agyhMTISp30UVmpm//ZVbTGxaHXEop7krRupVF68CsweK6V3pNS4IfaaZ
	 J45zh583exBkw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dvorkin Dmitry <dvorkin@tibbo.com>,
	Wells Lu <wellslutw@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Andrew Gaylard <ag@ffroot.co.za>
Subject: [PATCH v2 11/12] pinctrl: sunplus: Validate pin_func index in sppctl_dt_node_to_map()
Date: Thu, 19 Nov 2026 20:49:07 +0000
Message-ID: <20261119205013.2563811-12-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
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
Reviewed-by: Andrew Gaylard <ag@ffroot.co.za>
Tested-by: Andrew Gaylard <ag@ffroot.co.za>
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: Collect Andrew's Reviewed-by and Tested-by

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
2.56.1.750.gf70dc682cf-goog

