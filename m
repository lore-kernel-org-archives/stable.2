Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618163;
	b=5o5ciN7zHUMYuZ9rHe/wj4cJ74U2ea/8NyotKD6n115DqDkeMStEQJr3wlkRtQVGHt8P
	 AS9SZ3qrZDBIS+biQEWCjxnYZCW+d7I5pOwgtHhTM9S5aMg3nyXcXDV4pAUZ9VHwcRgcS
	 OW29J3ht8HHvLhhnEwnhNsk3f0K3f77w6bpE8z7yavKrMqSguBufiPCBSvnptQjQet71Q
	 0kWuHWDXj59gRnu5949gb94oUbaolw9JyQoL+Lu93XBFgLL55ugL83PweP2m9z5Y9t88p
	 6khrbABY8VMGJWLt8W7+1472Lggo4HFiBuiIVUlHt4L0mI8R7+5R71Y+Y512g7Yuaqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618163;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ndKvpmqpsXXKNWXd8KEPVUmv4+a8DRhy1Wexw6izFEo=;
	b=A0T4GmIZKOmMrAjdWetSuxlbKOLWRTNAFM0i7sTBFLlw0uvQTcH47HAy0vIYG4OT44hH
	 S7Xa/fm3oNzwXJ3nSx45IVlbVuf5Z+3gPPl+1oI0iWnvI30W/9t/IbplDQyIv0V1HS7Yu
	 Qeo27208lClHhgiMDzCEJ6B2PC+QdAiMXSIUdiSK0De9u255/uSSuNmJtwYpy6/Gp5fOm
	 CbqMh4nfcvWLs/0Hv+qgy+RuOF17mQY1yb0SCMxxw7RPcLzn4aC0qpC0OGWAaYxmokw6l
	 11l82/1t6G3bGWRbePgD6YLnoakaTdWAbuWdgOThkrsP/nD2VBwbU1+5zKzXuvwRXPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLox7QM9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420B606A33F;
	Mon,  2 Nov 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLox7QM9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E1C1F00A17;
	Mon,  2 Nov 2026 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793618162;
	bh=ndKvpmqpsXXKNWXd8KEPVUmv4+a8DRhy1Wexw6izFEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLox7QM9nPlrGHmnxCZZ4vF4foTEpvrL5MWrlI/o7GRu4CZ42Qe7Mv07gwsLq6Rvo
	 4rxjPokHqVAwxxLn+cy5EO7WVDNYq7DDg2nkIwiRVUg9T+zjYx5i0svDKx82aV1bfu
	 QTgUsDSRlpF6QrtaHx0EYclwVbmmzk6NqzgvVKHfbZkBbs4jSIvS16cMCuzJUXagUH
	 u2f6zr+rF3RXW0P2ZIrJa6YDLKn1vVK2QuCSXpz2S5uTnEaGrAT8fzx/uAH4gU9CUr
	 j6tWtRgxhMkc96Uidq1qCCd5Z4G5fauLU5pr7P89AGmbvyNTc2o2HAeaybQ4gQGqUN
	 65tuYqeS4M4AA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xNq1A-00000005aDy-0zdE;
	Mon, 02 Nov 2026 12:16:00 +0100
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
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 2/2] software node: fix primary software node removal
Date: Mon,  2 Nov 2026 12:14:20 +0100
Message-ID: <20261102111420.1330760-3-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102111420.1330760-1-johan@kernel.org>
References: <20261102111420.1330760-1-johan@kernel.org>
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

When removing a software node using device_remove_software_node(), the
primary fwnode pointer is never cleared if the software node is the
primary node.

Since commit 7d80509ff0da ("driver core: platform: unify release path")
this can lead to a use-after-free when freeing a platform device if a
driver or subsystem (e.g. mfd) has already removed and freed the node.

Clear the primary fwnode pointer when removing a software node that is
the primary node to avoid this.

Fixes: 7d80509ff0da ("driver core: platform: unify release path")
Cc: stable@vger.kernel.org	# 7.3
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/swnode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 84a77ffa3dc4..9c98234979ec 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1110,7 +1110,11 @@ void device_remove_software_node(struct device *dev)
 	if (device_is_registered(dev))
 		software_node_notify_remove(dev);
 
-	set_secondary_fwnode(dev, NULL);
+	if (is_software_node(dev_fwnode(dev)))
+		set_primary_fwnode(dev, NULL);
+	else
+		set_secondary_fwnode(dev, NULL);
+
 	swnode_put(swnode);
 }
 EXPORT_SYMBOL_GPL(device_remove_software_node);
-- 
2.55.0

