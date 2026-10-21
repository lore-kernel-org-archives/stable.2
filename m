Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586181;
	b=UwfnoOQ+2NHnStJOonyvaJkFNfHWOV6IsILvuJL5OSRh5Ai0RgZ+3P9BaJSGd79sGO/q
	 Hw+7whKsHlDmIpu63KBKDaKdOBFqQSY9MEbExBL2Z8T05a1mTXNKzSZi7cjaIYcwNm3WP
	 xRDcZNnYLHuNS/ip+RUkVIdXoF6uPRGgrYtZdKMJvAerN2eEU+qTex1ExbCNcd+gS6uv9
	 XkLrP8cbo6lr5VMBJoWMULXiMaIt5KhHabgA9lx+3VO81wc8N5tALE/JfctHfSicZFYOk
	 XWbTz8L91aP0HGhlFhJlRXIuop0BtBXNaZkpr5JgoU6hQ0aNsZrGU8/smQDFCEs+y2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586181;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xjld/NBg73CwWS+nkV/1581JmFygmKyQS9DEvNev1vg=;
	b=Is9bu6yy88Uki+kIEMK6Qws29JyEOBJzToZav8JAa9rkmGlEVaqgOCGuJ2nAd2rVFQz0
	 afwnhhGZ96gvJEN0/bfmNIZvABWoP7KqamLMFiBjM7pFTvjqpLEyGa1EQSemUdDm/O7Ju
	 EWm6cFSkWLQHCcX9V5aL6A17vjft4YXeN4yk+tAR9bE3N5C5mL9KxTl6CiMIc6bI2OfrR
	 s6NSYFv3qDecyBMd+s3klwkX+Rz+V/OdLCVdrGlCE1HyMcaOEwUeDfoRVUfNvutfcPgYm
	 IkxvuXG01DAyDX5mnMOvbn1MxobfnRBkB5Ymj1TXhcuLzVnZdactermyuqdVmWsY4nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIKhjIJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2260A261C;
	Wed, 21 Oct 2026 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIKhjIJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2984A1F000C5;
	Wed, 21 Oct 2026 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586180;
	bh=Xjld/NBg73CwWS+nkV/1581JmFygmKyQS9DEvNev1vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GIKhjIJE9TrR6wTt+YVcsP2TUlh46RejA0tY0fWLo9Qt5+eKuzaBEOdqt/GiA2bb/
	 6GT3Kp2/D082ie2bnDsRJIm+nwobbgqVZ0OexaO4lNAzC4td6igT7+9YR0VMkfkkjN
	 OL/jLVsPlXNMDvHnEEBQNHSYTMfdFD3nvwXpNaPKffKPn7KSk2UNiTKW7oJmhSc+ZB
	 kNZdvphhZtqFtMak9SvUqLS9/oe1jiA2n3lQ/9cEDXcf99U/rSb40WKYF774g2dXQF
	 4duCzzu2RHFC/35H45tEu7Pf6zpA59SA+Br6mXBxTsmqXmP/MGNORCje/tgDnhvbNI
	 AZlIWy374ok6Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Bryan Wu <cooloney@gmail.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 20/21] leds: flash: Terminate sysfs_groups array with NULL
Date: Wed, 21 Oct 2026 12:32:29 +0000
Message-ID: <20261021123406.3163547-21-lee@kernel.org>
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

led_flash_init_sysfs_groups() populates fled_cdev->sysfs_groups and
assigns it to led_cdev->groups without writing a trailing NULL entry.
If fled_cdev is not zero-initialised by the caller or is re-registered
with fewer operations, device_add_groups() will read past the populated
entries.

Explicitly NULL-terminate flash_groups at num_sysfs_groups.

Fixes: 7aea8389a77a ("leds: Add LED Flash class extension to the LED subsystem")
Closes: https://sashiko.dev/#/bug/linux-ad7bad43-ab12-40c5-addd-7d1f23d83391
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/led-class-flash.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
index 16b3b6b9365b..90ae93f16193 100644
--- a/drivers/leds/led-class-flash.c
+++ b/drivers/leds/led-class-flash.c
@@ -273,6 +273,8 @@ static void led_flash_init_sysfs_groups(struct led_classdev_flash *fled_cdev)
 	if (ops->fault_get)
 		flash_groups[num_sysfs_groups++] = &led_flash_fault_group;
 
+	flash_groups[num_sysfs_groups] = NULL;
+
 	led_cdev->groups = flash_groups;
 }
 
-- 
2.56.0.218.g1ec904b173-goog

