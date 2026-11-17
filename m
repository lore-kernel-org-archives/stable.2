Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910435;
	b=OQoWbElkUb5TiUIxs9eHKkqW3ktlQlBOJi+UVdV0ciuaOg4tAJJmDQtOVjSHCXdwljPO
	 7UO1B1XAr8A8tUrM6D+JtxxMVpXrkWgKCWL2Lhf8Kh31JUy6mNbjihXKpou1eGLO1g38I
	 Eif7P2yx+A4CAEMe9ebTqRmZ7M+62/wEt4C9czyNyXcSTMXj69AmCZN7EUC8W5bU6zAjk
	 t2OhYKNHtHYJaMQX1wq5WOTH5bdeIEF+EhpS21DiX1m3dCzgB6wu8zJokGC3r1AVyo84z
	 G2mEk5BFhisB9DRD7l5PXL8OxdXMajs1Ssfi/myawqALXryAWQltefP3kfDrooE5bBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910435;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NazeYi07uqcxcKhSRYMPz0ncxKRpBpKBgF/I39qumoI=;
	b=059mbk3zO1fyYgnM0YrIh1pogtQJBbVJ8Q3ZDBP915k1ppJ6yCRCWzB0gWJ0UmDAp6+U
	 dFt1Vlar/Cz+QygGNLsFflJLcq2v1o22PVkZHNmMMWZ6LGbF4jaIr/fBtj9kxdbDMlG7G
	 kED0/fJJldAqMPZVCxVbTrUjcitZhWjPKXP8HJpIP6njiL8TxTLyKWlSFOJuSQFD6FIOM
	 fLxzzxocrf/PbPa4NfuczEwITcIf4OQ+vKhJZ5Sr7n4eIbtTA6POuPPS4MufjCc4pbS7i
	 HvrPQmzgsFWL4bQVOwuBR4qUhnhispfucICpT3uF9cuKe2WB+S3EpaQXzud2iRLoppg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEaLUxvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63503606A887;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEaLUxvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141311F000CF;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910435;
	bh=NazeYi07uqcxcKhSRYMPz0ncxKRpBpKBgF/I39qumoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YEaLUxvJ1Zvi5cMzWcu/K3ekW7jxOjiJpJ3MzRk9rCgvAq8II6JBT5nZpEDGl0H10
	 N6JskYLFscE5P3nY3kMsvijlUlJJiEtxzdV1+wsVxpbyX7tUZiIEjzStby9Wpn6H2c
	 R+Km1cQ2J4PGFR0px8M2FgjQbcW4u3ZSDwTrh41/rdpWtGSmwrL98MoU0FYKzExNZz
	 W9ss9muU/GPG12/pprUyxeF1IiJN3BUplKwfQc/UD88yXxQN2OT2bofsWofOu47PKV
	 nRBiAMOczmbqiZ0urD/z3fDylPitlf4+i2u+8Dazzw8KGDxSPmDf8TESFO3N/fQwlo
	 9AvIVJO1IS1GA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTGCG-0000000470Z-11lP;
	Tue, 17 Nov 2026 11:13:52 +0100
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v3 2/8] i2c: core: fix swnode use-after-free on client deregistration
Date: Tue, 17 Nov 2026 11:13:30 +0100
Message-ID: <20261117101336.980216-3-johan@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117101336.980216-1-johan@kernel.org>
References: <20261117101336.980216-1-johan@kernel.org>
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
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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
2.56.1

