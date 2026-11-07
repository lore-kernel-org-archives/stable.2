Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045776;
	b=Wif9WZ1WpJicgbRSRuL8XSyo2qt8BnxbrLbsLFZwxKyemU8jXPjCuaDb5BYm1KaXtN+o
	 YSfXRtTEK2iWId8WiNUHZgdeJWnsv8vtIUTiwBk3m7b/8VXCOGOIrL1lXn2GZbyKrkI0+
	 CQZOKN3qrIaY8+ZbxaKwb+82WesmLGpBEHSqvgulyazNBQv85SkkXx2d92+QduCqGXP5N
	 rEfs+dIpRY5j15oey1cDw7L0v1lURUXD5eu4YHfJ2ujhnjI8w0sQS9xX9wfIiGARPe6qP
	 oVAsTc7YPba02dsse8FFY5Ov2d7xq+NW/PzzsZGC8PVgH/Re7BR03m1w58C/3AuxqKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045776;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=a2n4LXbbESxZjXBDC97PTyyTrI1jL/vjAsOoD4R8K6o=;
	b=GXxN1mfJbC5NmRCY/HErnrZ7oDv4ZAD0cd928xwhEUwxBrL9OjdtOTpusG5UknRF72W6
	 wl/cj/mb3hU8EeTzHdHueoG57nvzIhYDOn3Y+LiKgDMdbkDpMdulsPSlYgL4KOUx6KleN
	 bO+3z6N/5TK/mk4EOaBeFT2KkMSc3quTZsX4oYgXFnz4NxUi/hL+7c0YP6l0Fnc73U+gM
	 kjTkOf3b7ZHd3Gw/ylrAqCEFpRoMdeJYlbV+GpmMAGTXAmFkP1KGHoX2KU3gIEy7LAgO4
	 89KFaGiGbM6t+PhSdNZQjhCmWF7wkPQ9yjQcxNb2/2nExkZJJW6jZuXGCWZ99ssrdhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOuNbvG4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5013606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOuNbvG4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA81F008A3;
	Sat,  7 Nov 2026 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045775;
	bh=a2n4LXbbESxZjXBDC97PTyyTrI1jL/vjAsOoD4R8K6o=;
	h=From:To:Cc:Subject:Date;
	b=kOuNbvG4U+/z6+GgTcVIjqi8NxO3C5yHvnua/PgR7hGe6Wm7h170gnu5URegQ9e2a
	 EGJXtoh5ZsiM1KIWpkbxtm7qY26lewCvGmTIdhCRs1KDDSYMi5eECDd5Vgx2AeNuLo
	 cOiRSKBVo9zeodzslrIb2sUIGwEVzkeG2SQJf7YOqou8zTCKQJd55dKzCXzRHtZ9N9
	 2iOrUs1InEOjUgmi5A5UfKvsMog4s5RDU/E+k1KFjUAZVHh9QQZwCUljoSy6t8N0nC
	 iCniD++z036LXCxsVoZFr/9VxbPjmGstbT2vu0ZJMeJjtaWE86CvfFk6/Q4IGEbSUQ
	 KQvtR+WOHjg+w==
From: Sasha Levin <sashal@kernel.org>
To: gvozdoder@gmail.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: ipu-bridge: do not use the CVS device lookup for IVSC" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:53 -0500
Message-ID: <20261107050253-failed-7.3-ce92674d8d8b@kernel.org>
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
git cherry-pick -x ce92674d8d8b29562de397b437e16bee499dd92b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050253-failed-7.3-ce92674d8d8b@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ce92674d8d8b29562de397b437e16bee499dd92b Mon Sep 17 00:00:00 2001
From: Sergey Zagursky <gvozdoder@gmail.com>
Date: Wed, 2 Sep 2026 22:15:24 +0100
Subject: [PATCH] media: ipu-bridge: do not use the CVS device lookup for IVSC

Since commit c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU
bridge driver") the internal camera no longer works on laptops where the
sensor sits behind an IVSC, for example a Dell XPS 16 9640 (IPU6,
INTC10CF, ov02c10):

  intel-ipu6 0000:00:05.0: Found supported sensor OVTI02C1:00
  intel-ipu6 0000:00:05.0: Connected 1 cameras
  ivsc_csi intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: mei-csi probed
      without device fwnode!

No sensor subdevice is registered, the media graph has no sensor entity
and userspace finds no camera at all.

ipu_bridge_get_ivsc_csi_dev() first looks for the platform device named
"intel_vsc" and returns its mei-csi child. That device is created by
mei_vsc, which on this machine only appears once the LJCA USB bridge and
its SPI controller have probed, about a second after the IPU6 probe that
runs the bridge:

  07:59:29.297  platform INTC10CF:00 created (ACPI scan)
  07:59:41      intel-ipu6 probe -> ipu_bridge_init()
  07:59:42.391  platform intel_vsc created (mei_vsc)

The commit above added two fallbacks for CVS which match on the ACPI
companion alone. They are reached for every entry of ivsc_acpi_ids[],
IVSC IDs included. The IVSC ACPI device has two physical nodes:

  INTC10CF:00/physical_node  -> platform/INTC10CF:00  (no driver bound)
  INTC10CF:00/physical_node1 -> platform/intel_vsc    (mei_vsc)

so bus_find_device_by_acpi_dev(&platform_bus_type, adev) returns the bare
platform device. ipu_bridge_instantiate_ivsc() then attaches the IVSC
software node to that device instead of to the mei-csi client, the bridge
reports success, and the probe is never retried. mei_csi later probes
without a fwnode, the CSI-2 link is never described, and the sensor ACPI
device, which has an honoured _DEP on the IVSC device, is never
enumerated.

Before those fallbacks existed the lookup returned NULL here, the bridge
failed with -ENODEV and the probe was retried once the IVSC device had
shown up.

Skip those fallbacks for IVSC devices, keying on the IVSC IDs rather than
the CVS ones: new CVS IDs keep being added, whereas the IVSC list is
complete. CVS binds a driver to the ACPI device itself, so matching on the
companion stays unambiguous there.

Fixes: c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU bridge driver")
Link: https://lore.kernel.org/linux-media/20260901194526.6369-1-gvozdoder@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude Code:claude-opus-5
Signed-off-by: Sergey Zagursky <gvozdoder@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 125fe5da7a60a..883a90249602f 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -232,6 +232,19 @@ static const struct acpi_device_id ivsc_acpi_ids[] = {
 	{ "INTC10FA" }, /* NVL */
 };
 
+/*
+ * The subset of ivsc_acpi_ids[] which are IVSC, rather than CVS, devices. The
+ * CVS IDs are deliberately not listed here: new ones keep being added, whereas
+ * this list is complete.
+ */
+static const struct acpi_device_id ivsc_only_acpi_ids[] = {
+	{ "INTC1059" },
+	{ "INTC1095" },
+	{ "INTC100A" },
+	{ "INTC10CF" },
+	{ }
+};
+
 static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
 {
 	unsigned int i;
@@ -283,6 +296,17 @@ static struct device *ipu_bridge_get_ivsc_csi_dev(struct acpi_device *adev)
 		return csi_dev;
 	}
 
+	/*
+	 * The lookups below match on the ACPI companion alone. That is fine for
+	 * CVS, which binds a driver to that very device, but not for IVSC: there
+	 * the ACPI device also has a driverless platform device, which would be
+	 * returned instead of the mei-csi client. Return NULL for IVSC so that
+	 * the caller fails and the probe is retried once the IVSC device shows
+	 * up.
+	 */
+	if (!acpi_match_device_ids(adev, ivsc_only_acpi_ids))
+		return NULL;
+
 	/* Try to locate CVS device on the I2C bus */
 	csi_dev = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
 	if (csi_dev)
-- 
2.53.0




