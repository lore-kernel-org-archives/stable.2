Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586130;
	b=W5mzqZVlYm+bJ2925PPQ7ZYqs0/gPHjc1fFrnOLBRDdQ5TiyaD5ZwyZUYkS96nhRFmwe
	 GIzvZWVhKvSnLbIoeVoKziOIbqpfjjE2PZwRa5Aw/EiHaAUsUlCNvIkuZ7YNKQjWSIJ3X
	 05wBgs7Ginz+YA1wPuIGTW/Hy3LKJS/K48SZVC/9DlG/aVALWpRMcXPUWTdN6yCHO+GAb
	 llrMO02bTr8tsQ3eCzfdk1+IcGM5vjrzABwnlBTLAqqtYZLqqdrzheOU1LDongxhxt9tO
	 7PuHimv3rmmqrUcckC1JV4kWNXN6vSdUsS8NKso7JWflbY6xCGOq3Jx7y3v7gAXbDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586130;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZfhpFA1hBp9g4oB8NcHFvXI0N3ULCr8scmvCksinIGs=;
	b=m61Vk1dkoCbUSKgErYMJN+GtnOvUgpeKKZg2ce3jPFYs5IYEQzg6T8/hoky0fk27YMU8
	 9CVzKQnq26BfvygmMj9x7ui7rd5Ya6nSz2WnM9ADPsU0p8AoTPG9zl4BLOjkwajvKW/i1
	 rghp6IVsUd7jqJfdf8YfK1jWSAIoXxicFmO7EGUp9g3GKI3a8ls1dKMUW9/MTBsrUQPHe
	 IKjGYfrViSOaIhxdmD2sN0qEVHMB3S0a92ZsMDZung4fZ85teC+UDT8McE8nn4J89c7/R
	 IBiKAHAIPA6Wxdg/oV9C2xwk0X44fnwkKzlqdAGEQ7kAl5oYZBPgKr0ggH3E5HkmtHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0Svwnqd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7C60A6F6F;
	Wed, 21 Oct 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0Svwnqd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDA41F000C4;
	Wed, 21 Oct 2026 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586129;
	bh=ZfhpFA1hBp9g4oB8NcHFvXI0N3ULCr8scmvCksinIGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z0SvwnqdBwzgAJziSHJvdIGebufXtgMuh6/iJg+EKHnLfT9SKEsUGTD/zoBqVGQf9
	 AcvZFluKN4n6u6BLL1UoZGrWAaTHt0JtFKcR3ENepQbssfbLvCxW2ZVwGvnE+Yb6Jq
	 QREJ1M2EIijiBG9IVuk8xa8rSeRABybBY5kfhi2m5H8USgdyVo9LsckM+z1MVLKLMU
	 dCfvG++lCYgt++2uNXgWx5ZZxnLGVyECgjDB4yV8SdgaLfNLpuKPuH2KRlwr6iSol2
	 oqy2DhdKRzMKa01BZJfLxbLf46+5uJ6kSlnB10bSiOwIGwp09Udiib/Mp9gNCwOJ07
	 kAaOPSI+8rATA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Bryan Wu <cooloney@gmail.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 12/21] leds: aat1290: Retain child device_node reference for device lifetime
Date: Wed, 21 Oct 2026 12:32:21 +0000
Message-ID: <20261021123406.3163547-13-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021123406.3163547-1-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
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

aat1290_led_parse_dt() acquires a child device_node with the
__free(device_node) cleanup attribute and assigns it directly to the
*sub_node output parameter without consuming the pointer via
no_free_ptr().  Consequently, of_node_put() is called automatically when
aat1290_led_parse_dt() returns, leaving aat1290_led_probe() with a
dangling pointer when it passes the firmware node to
led_classdev_flash_register_ext() and v4l2_flash_init().

Because the LED core stores init_data.fwnode via device_set_node()
without taking an additional reference of its own, consume child_node
with no_free_ptr() and register a devm action to release the reference
when the device is unbound or probe fails.

Fixes: ac69b9038f82 ("leds: aat1290: add support for V4L2 Flash sub-device")
Fixes: 1e63395e58b2 ("leds: aat1290: Use scoped device node handling to simplify error paths")
Closes: https://sashiko.dev/#/bug/linux-2255c65e-840f-49ab-9dc5-227a4eab4c37
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/flash/leds-aat1290.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/flash/leds-aat1290.c b/drivers/leds/flash/leds-aat1290.c
index 4bde0b07fe78..ea9af6c3fbf4 100644
--- a/drivers/leds/flash/leds-aat1290.c
+++ b/drivers/leds/flash/leds-aat1290.c
@@ -211,6 +211,11 @@ static int aat1290_led_flash_timeout_set(struct led_classdev_flash *fled_cdev,
 	return 0;
 }
 
+static void aat1290_of_node_put(void *data)
+{
+	of_node_put(data);
+}
+
 static int aat1290_led_parse_dt(struct aat1290_led *led,
 			struct aat1290_led_config_data *cfg,
 			struct device_node **sub_node)
@@ -279,9 +284,9 @@ static int aat1290_led_parse_dt(struct aat1290_led *led,
 		return ret;
 	}
 
-	*sub_node = child_node;
+	*sub_node = no_free_ptr(child_node);
 
-	return 0;
+	return devm_add_action_or_reset(dev, aat1290_of_node_put, *sub_node);
 }
 
 static void aat1290_led_validate_mm_current(struct aat1290_led *led,
-- 
2.56.0.218.g1ec904b173-goog

