Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045928;
	b=Ieuiisof3yjmaPTW3fMapxlgq+krELFJ7oiM5N8tVfDDx5HIpe9kzD1cX4Iaj7vlbWj7
	 XMvATvhnY6749cEdbZ+TO9HlEO6gY6HDo9TvIkA8+Nl/MynGi4dfqmlUYQFXWjKK0Xv2M
	 gM68iMUV0N+nJ0Srua82mIQNk9Mngvj3bH8UPoGQbQaCEC0CpK7eK2x/MkEBC5PbYjsgs
	 vlNMCYZwIhf2z9lEaE+ctBcN5y41w6EkSSnHF8GnMxNJsUMnCkeaXiQeaD2WMUQ+0VKjg
	 XLIXzVXAt13jYf2b9vJOC4CzO0Us2DJp64Nx9QLcgvgHPUQVBod2wQUHhGVidWtSwmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045928;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iWSdCwPUdrL/6fsQxAFsDk6+dbufmvxq19szKPgCTLU=;
	b=x3/ebipWvgexMe2fjrtPMHETSq+17CadsKdW7+RXDHWpf+WErxY3SrteCIeUQsivkYI+
	 IMDqj0YpkiGmqZYZ6V82nluJj/qVkw5Ql8nPh6zePV4swOPr1zl0C7/vkWAnFGYBP5a/Q
	 N4J6dybemFcLh9aHaxobtenQd0OltbEGMdiutqoQ5JUfixteZ0zke9NMA9jAqMLneQeAX
	 4/A0uc/abW4QUzQU1WZTSs8BNwVGHVl/egarBTnR5jqYsCrpofRdzfQXctrLbztYnTkRx
	 IshhzC/RAnjWFAqGghvQ7y8IJxq7R3Z0Oi+L2f0BeZ2EcH4AJYn5Dc5Df3Lrp2DwxQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cl2JBdBz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B195606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cl2JBdBz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3631F0089F;
	Sat,  7 Nov 2026 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045928;
	bh=iWSdCwPUdrL/6fsQxAFsDk6+dbufmvxq19szKPgCTLU=;
	h=From:To:Cc:Subject:Date;
	b=cl2JBdBz4Wcn0o/HTLCWxsDTfFCpdwzHkM60B7nwfyUDyyXBO25zJMUHGmmYpOhaq
	 /Lw0PGto9RV5isvRCpMxeSPyCRZ/+86i4ye6VZuAmEcM9iQ5Apmca0BQtFiBgjAdGB
	 /Uo210g35ux4uSL5muxU07TDMcfAJD1oVJPng1yPjeQ3ZbwZSZRYGPuAnjuYOMuAho
	 HWoMb5369G/hHJfTcuXKPiHmc9KqzLlocEfFpdbeTSuprxmvCv90LibWnCbLNOUtk5
	 gUFTGMg6OgIsY7/lSU4ZgM83WUwitpoSV02V+vgEdZxDIh2rAQUqXS+pdzgfl3FFG3
	 rzF4+kcVvOCYg==
From: Sasha Levin <sashal@kernel.org>
To: aliamemis@disroot.org,
	c.stratakis@proton.me,
	johannes.goede@oss.qualcomm.com,
	i@rong.moe,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: battery: Evaluate battery methods exclusively" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:26 -0500
Message-ID: <20261107050526-failed-7.3-645f370c932d@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 645f370c932db2cd3893f7fee61aa8b9debc8ac0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050526-failed-7.3-645f370c932d@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 645f370c932db2cd3893f7fee61aa8b9debc8ac0 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
Date: Sun, 18 Oct 2026 15:22:18 +0300
Subject: [PATCH] ACPI: battery: Evaluate battery methods exclusively
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
without taking the AML mutex the battery methods use, so _BIX and _BST
running at the same time can read the wrong page. Since commit d33e89d12295
("thermal: core: Suspend thermal zones later and resume them earlier")
this happens on most resumes.

Evaluate the battery methods with acpi_evaluate_object_exclusive().

Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
Reported-by: Charis Stratakis <c.stratakis@proton.me>
Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
Cc: All applicable <stable@vger.kernel.org> # 80892972ff23 ACPI: utils: Add exclusive AML evaluation helpers
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Rong Zhang <i@rong.moe>
Link: https://patch.msgid.link/20261018122220.678822-3-aliamemis@disroot.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8599949f87867..6edea559a5bce 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -647,9 +647,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 		acpi_status status = AE_ERROR;
 
-		status = acpi_evaluate_object(battery->device->handle,
-					      use_bix ? "_BIX":"_BIF",
-					      NULL, &buffer);
+		status = acpi_evaluate_object_exclusive(battery->device->handle,
+							use_bix ? "_BIX" : "_BIF", NULL, &buffer);
 
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(battery->device->handle,
@@ -688,8 +687,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 			msecs_to_jiffies(cache_time)))
 		return 0;
 
-	status = acpi_evaluate_object(battery->device->handle, "_BST",
-				      NULL, &buffer);
+	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_info(battery->device->handle,
 				 "_BST evaluation failed: %s",
@@ -739,8 +737,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
 
-	status = acpi_execute_simple_method(battery->device->handle, "_BTP",
-					    battery->alarm);
+	status = acpi_execute_simple_method_exclusive(battery->device->handle, "_BTP",
+						      battery->alarm);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-- 
2.53.0




