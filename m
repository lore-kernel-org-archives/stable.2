Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300727;
	b=pQZfNIj8TjcLjDiJT7tIusGhDUkj3r3TglObQzvpBEuT1LuA/AGIS8cG0ZpCyQZFLpSw
	 sKJllmndltjJga/7GtkMHM3VdMuiGpmyPU7XV/VN9G0rPxJbXfm0FkClL8jGWPTCx4ym4
	 Q9CuvJexxkQUvkVqYTE0j//Ze3Pr2xwodcCEBaYgJXRntN+enEivh64pO4b+inrfGUnBa
	 WK4nnf70NJoFO9tKuFvP2j9KIF61slQrHAZxfcVvPbyCBklFbZcKeO5KmNwe8GE1CtiHV
	 QvbEVGQ5Qd5ySimrpooSEu/Muwsjh8TKo7HH2CERkQUZ1JskLe35OEokFlrfghIVMig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300727;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d5D9gpQbjcvMZ67GL0qNxbnaUW9mk3vSJgCblRAk37o=;
	b=pFZZZiWSCDxBHUUX5faLphPgcoO7HBAlZqGthCIXZ9Prr/ENL/27FMpJCQPD4/tXqwkC
	 WKlkzaczG9G8RZ8/mWgM485N2ULeAO4TNU1lnaqXj1mFaH0aogWAp0kw2j2K3wImfzH27
	 yLoMJVCKMyItlrIgxJb/EcydNwSwi/1DENqbTHB1ERUGWLKu7QMxd6hVWPrCpnwFHh45z
	 S6zVkicYheQxP4k4R6Tkco5HIbrzu9rOyuuoaDN+td0MJFJSC8BTT0S/tOQ27rJQAmcoy
	 RIVfh7eZURhlWTo57bG+d4VFUKaydAPBfdnV+2WifxtE1W2RowLRboMawHq96Xxv7rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSLeLu0O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E923606A335;
	Tue, 10 Nov 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSLeLu0O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EA71F008AB;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300726;
	bh=d5D9gpQbjcvMZ67GL0qNxbnaUW9mk3vSJgCblRAk37o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cSLeLu0OaYIf7z1JFrvxmM5DcaB2YxeXeyQe6q07WYjBpwmbzFwoER4QX9Kta9Rs6
	 pfy5Idc5rE//MhueULqcB6/+AgXgZnS80L0XHJLkd30mTuEqi8BrLCAO57yq2CjraH
	 20ycrfdGfXldAgwPmyY9n0BU9696COZ+H1/YT/Wcohc04W1/bkb4si03msJatM2UGz
	 o7m4p6xkvM62Ynd25tEgBDfFXge5uMbpJRXQmqKiUkS/Ft81jx7WbzOvnEfL2tP8x3
	 aF5ZZajRnEnhbDqbC3MbUGU08xHM317t7krG7PCVLR/RTFMgUt2cXnYZdEgTrVPOEd
	 A5PDPI/OqAi0g==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQhaG-0000000Adc8-089A;
	Tue, 10 Nov 2026 09:52:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 2/8] i2c: core: fix swnode use-after-free on client deregistration
Date: Tue, 10 Nov 2026 09:51:18 +0100
Message-ID: <20261110085125.2535508-3-johan@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110085125.2535508-1-johan@kernel.org>
References: <20261110085125.2535508-1-johan@kernel.org>
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

If a client has both a primary and a secondary firmware node, the
secondary node is accessed via the ->secondary pointer of the primary
node.

Use a temporary variable to track whether the firmware node is a
software node and remove any software node before dropping its reference
to avoid a use-after-free in device_remove_software_node() when
accessing the secondary firmware node.

Fixes: df6d7277e552 ("i2c: core: Do not dereference fwnode in struct device")
Fixes: 1c24e5fc0c70 ("i2c: core: Fix double-free of fwnode in i2c_unregister_device()")
Cc: stable@vger.kernel.org	# 6.16
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 81603317b64d..c55ca14eaad9 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1056,6 +1056,7 @@ EXPORT_SYMBOL_GPL(i2c_new_client_device);
 void i2c_unregister_device(struct i2c_client *client)
 {
 	struct fwnode_handle *fwnode;
+	bool fwnode_is_software_node;
 
 	if (IS_ERR_OR_NULL(client))
 		return;
@@ -1066,14 +1067,14 @@ void i2c_unregister_device(struct i2c_client *client)
 	else if (is_acpi_device_node(fwnode))
 		acpi_device_clear_enumerated(to_acpi_device_node(fwnode));
 
+	fwnode_is_software_node = is_software_node(fwnode);
+	device_remove_software_node(&client->dev);
 	/*
-	 * If the primary fwnode is a software node it is free-ed by
-	 * device_remove_software_node() below, avoid double-free.
+	 * If the firmware node is a software node, its reference count
+	 * was decremented by device_remove_software_node().
 	 */
-	if (!is_software_node(fwnode))
+	if (!fwnode_is_software_node)
 		fwnode_handle_put(fwnode);
-
-	device_remove_software_node(&client->dev);
 	device_unregister(&client->dev);
 }
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
-- 
2.56.0

