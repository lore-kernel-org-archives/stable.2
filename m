Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791147;
	b=dwsnMjltbPrPpBdv0cRC9mABCYMjGxty7f6KmwHdvgsqxAKUpu5n3lPO8WxFCPRJlRVU
	 loT8m1fML09pYTFVyMLklL15n5iT/JQ9U4BG4qYAWD527HlqPkmJG3X7ZGdrg636nCn3Y
	 iBddxHrXh2Tkoqr7dqNrkrdNU7eNdWvOeg61W5lFjyAKt6LqXyta6xowCmtlqOvwavplb
	 MGBhkE5AV+6olcG8bbW8JgP7ydK9hEp7+D34b4Eb4MTEVgwGp79ZL4ExxZZuW9upazH/p
	 LSXpOnzGPOVRFtFPwjbVve0A/tr9pHIWh10gqqfNeEox7q45qlyxEgekm9hymdcbJ7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791147;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s1BZfvVutIxlUpcCiKJC2UenceNXJLwyD6jsVdX7YhQ=;
	b=4HwM39vgYUcQcIQsb+8bFVsJzb23Sk1JKLoLJRiB+o9z7KfXsezB9INbBXwQHkg+7w74
	 3Mx93CWWDTDIKvhzGgHIhjBzf2mvObreeyHCPgxBwTR39IVoKjo2RRKyfbIKGbAZLpmI/
	 Yh+H0Zi/EH03LYm//iuxfWvvuhmbafE0kQZRwcMXi3ZvzOaxMZm1WEm4octxr0c/9pu/W
	 hybU+NPVCT3wmIrv5WiaAz5IU9P1J/npL2B5Om/E9+K0UCjIZrKtjqpeg3Q65fUmLDGl2
	 NK04EFAFtOs6oOCG2vXU7AEJ3nISjDpQeiUvryWuj4OA4QyKqDJKbPc/jF7z4AqvagA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+r02Qyt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A67606A31C;
	Fri, 27 Nov 2026 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+r02Qyt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFF61F00893;
	Fri, 27 Nov 2026 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791146;
	bh=s1BZfvVutIxlUpcCiKJC2UenceNXJLwyD6jsVdX7YhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i+r02Qyt+/gqb6NJ52iQwDLXOfXm4i8ZKtQlQ5mViOQL2kzq+tgReqz2aX2u/opk1
	 Gqf1xTpJ0Px/BRqQuOrRLdoBWk/rKE+v+LXrl48MA5r8mPOItaznBhCgNpdKj+pmMC
	 Q//1EWDo3KwMwTg/Utq3l+l0J9+bgTrurvMrT4uOf0twjrvvrJM/KJdfLnJOC5ZRcd
	 LJGjr3zGhOnTxkc/0Zp+W1hDbQNXYFwCbChTHIIL1VajpKNuzMRofUGjg9HxdgczJF
	 OMNiVlvkb4PbN9nsuOYKf8S9fU/8enA4vHIjvUL7KS6oIvONUht+U98e1DINrlA3rb
	 VeHAS/5ETOWDQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/3] Input: applespi - disable touchpad registration work on removal
Date: Fri, 27 Nov 2026 14:51:55 +0000
Message-ID: <20261127145209.2884170-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127145209.2884170-1-lee@kernel.org>
References: <20261127145209.2884170-1-lee@kernel.org>
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

applespi_probe() allocates its driver state with devm_kzalloc_obj() and
initiates an asynchronous touchpad information query whose completion
schedules applespi->work to allocate and register the managed touchpad
input device in applespi_worker().

applespi_remove() disables the ACPI GPE and drains in-flight SPI writes
and reads, but never disables applespi->work.  If a touchpad info
response scheduled applespi->work just before applespi_drain_reads()
completed, applespi_worker() can run during or after devres teardown,
corrupting the device resource list via devm_input_allocate_device() and
dereferencing freed driver data.

Disable applespi->work synchronously after applespi_drain_reads(), once
no further SPI responses can schedule it.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Closes: https://sashiko.dev/#/bug/linux-bb2fd773-6c20-468c-a092-6814f008077f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Use disable_work_sync() instead of cancel_work_sync() in applespi_remove(), per Dmitry Torokhov's review.

 drivers/input/keyboard/applespi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 1d059aff1f1b..1e63719dec4b 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1822,6 +1822,7 @@ static void applespi_remove(struct spi_device *spi)
 	device_wakeup_disable(&spi->dev);
 
 	applespi_drain_reads(applespi);
+	disable_work_sync(&applespi->work);
 
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
-- 
2.56.1.839.g22a8290db9-goog

