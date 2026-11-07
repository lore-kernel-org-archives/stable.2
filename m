Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046625;
	b=nTj8kLfrrnwoapbAnl32v9VCeaS/3IAkUZVF8Oh+5gKAaeeo+OOq0k63iuU7FYiXuxnV
	 xa6GeTipnOBsxmji7yWgUrYNCQkj68ZPndBht1S2pWYPOvCyONB4fx/sSyyUob82D2Mpe
	 Cy4dTBWho7Rkf4uTh/0tqfI9M+54xPmDBK0p7qA/g9rWWFwoFa17wzckIcVmO9MNIUAfx
	 +vhOuW7Ah5NEBq0mAIdCUtcuS2y+KFZveH6HVQCGD6rWp3RF5Sy5QwGqIwXNOqRrbYcEE
	 F3K2PCXgxayFNr3st749sLwDIC1CeHOENlWueQ21vmmTBJXEMshTG2tucKOSPT/B4PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VvfcOOLcLZzTIK+CgZ8QFHGlfdQmq2IWxk2hgMApmmU=;
	b=h8uPqXSrHY0i0tGWkf6eZbic4T44TGMt0D8edbkNlLtRZ44P/1s9fq3KdyQ5AXbMJBkd
	 2hq9gD9N/6TlI5kHyUVpRcCr7qSoRnvpyy8hUOjrhjbnM197oQ3H2Ag3Pqa5ELT2zauRC
	 JKxbKXLpXZtNzZxifs/FxCJ+1wlGxEFGAnm2N6/QOur16/yV1XepPD0J+5Na/tt+onpWf
	 HQHpw8L6uqINI9fqXTaG8LEc4U/NGheK4qPwNSLWAb0aXIC5xXnFFAWkeaLQ71EXKq0aD
	 UT0+0+Uac/OD9r5cYNIHnrOL9nZdrNfPiZJKKiml3nheYn6YCTxjY2m2OI1Ob0SA4Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H8HOhnG/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03E60A3806
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8HOhnG/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9FC1F008A2;
	Sat,  7 Nov 2026 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046625;
	bh=VvfcOOLcLZzTIK+CgZ8QFHGlfdQmq2IWxk2hgMApmmU=;
	h=From:To:Cc:Subject:Date;
	b=H8HOhnG/SF2/YPXMIwX4HRT3ev9MwcKyRcF5dBVwPtPqlJiH5r38M8dY2UmVpTwhg
	 U00iqSo0iR9vRG3w5aNEYcWQElka/x2t8zSjFT33FacFM5IqHxBhYAcNcQLhijVfip
	 Es/8V7JkW3wOtBoii8fHSIpihMpm87subaWsD1s5z1c8buv+ahJWfUhjOLo84WjHnr
	 X9G96XJKCqck6tBLFHiDeKuacTYZHABEr+XywMRCDbeXcZhDT5sliclKhB1hX/vCIi
	 atlmF9jrVYdSOHX8RhuQpTwVsUOsMwFMg/ecCTDkIfZxyXJMYlkOX3FkYqxDYQoa/m
	 9DLHmwth/8dkA==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: i2c: og01a1b: power off sensor on remove" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:03 -0500
Message-ID: <20261107051703-failed-6.12-a26c5ac46191@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a26c5ac46191ae34b3413f7a45d6241f63e15d42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051703-failed-6.12-a26c5ac46191@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a26c5ac46191ae34b3413f7a45d6241f63e15d42 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 15 Sep 2026 16:35:34 +0800
Subject: [PATCH] media: i2c: og01a1b: power off sensor on remove

og01a1b_probe() powers the sensor on explicitly before identifying and
initializing it. After a successful probe, runtime PM is enabled and
pm_runtime_idle() is used to allow the runtime suspend callback to
power the sensor off.

The probe error path explicitly calls og01a1b_power_off(), but the
normal remove path only disables runtime PM. pm_runtime_disable() does
not guarantee that an active device is runtime suspended, so the
sensor can remain powered when the driver is removed. This also leaves
the xvclk enable performed by og01a1b_power_on() unbalanced.

After disabling runtime PM, check whether the device is already
suspended. If it is still active, power the sensor off explicitly and
update the runtime PM state accordingly. Avoid powering it off again
when runtime suspend has already done so.

This issue was found by manual code inspection.

Fixes: a95ffde28783 ("media: i2c: og01a1b: Add support of xvclk supply clock in power management")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/og01a1b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/og01a1b.c b/drivers/media/i2c/og01a1b.c
index 1675f0460969a..1cece90c59eeb 100644
--- a/drivers/media/i2c/og01a1b.c
+++ b/drivers/media/i2c/og01a1b.c
@@ -956,6 +956,11 @@ static void og01a1b_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 	pm_runtime_disable(og01a1b->dev);
+
+	if (!pm_runtime_status_suspended(og01a1b->dev)) {
+		og01a1b_power_off(og01a1b->dev);
+		pm_runtime_set_suspended(og01a1b->dev);
+	}
 }
 
 static int og01a1b_probe(struct i2c_client *client)
-- 
2.53.0




