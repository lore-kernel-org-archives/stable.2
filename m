Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910435;
	b=iuFnvDABH1ZtlJQShFpHMeQ9sBaa/0ypRERME4TlpgPumozbAzOK95MTfMe7rTkfkmtV
	 A0n7V2a+q1BM+GkhcIKgF4cG9r/efA4GbV4E+x+UjWIxyUP/jKkvrTDiR1/ktxm0QLbMs
	 K9Dit6y/RrfkToU56fVbrl0WP6oyKUtFGowdbaWV0v/UdxQJDyAyZj5smi0TTqc1Mu7qM
	 7yt9VXy9UWis9YLCYYTfujTm40C38GDd1rxnmCpj2+eJkxEfibMHytMf5MPGigGabR31Q
	 vYdYcKSNwyT7K8V1q7TlbOEZTQTJRYXzXlsbl5HL3vz+2SMm4LSK2k5AU8armB2sehw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910435;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NrDgELiH7jCpU6qEZQHgkbeHL7Q6wPnevspskrtfvuI=;
	b=SLJkZBoi5IbUwlUAE2OKPf1U5u2DoPignHHM02PXS01ZZ5qp03GBG0cO7qO4qzMaHK6z
	 o50fvrVYDIRp8OujO6HiRH6nNPMDmiR92EHLnVciEjztK5XTKNj+CbA8o6iJo7T5HNBEh
	 DWK9xCfKOrEZi4mNVQ+ek0Gbd6chW1P88owEg3gEyWv8qkgDTq9bTrVaYdIIwt7+js16F
	 /z5WXyOin2xFbe25TiC70f2Rmidk/yIrSY0z2WlB/dhmvxglw16Xn4buLNw9CmrdQ/3KJ
	 qpIruRwr56Uoh2t78BVZfbTCKuozaYVQiyzvTU2m2UNgGMVWzgPxFTmLCiKTcCRPqDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="osh/TgUd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36634606A329;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osh/TgUd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DAC1F000C6;
	Tue, 17 Nov 2026 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910434;
	bh=NrDgELiH7jCpU6qEZQHgkbeHL7Q6wPnevspskrtfvuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osh/TgUdg0zUjHqBIgCQa3OVWQ5bgTICfiJW3K8mAv62MD7u/GwvwtvlykqvLbtxI
	 97dqG7XcZmUb+nnV3s3Kb2EfEtI36Uy+QsQCBvyFTEc7B48w7vjuHXK3ZR9XWk4ZyM
	 ptX7sCwQq1+oco2hfxjtjP8tIqg5g0rpog+mC8sCNBoZQC/WV5JdFioEXd2FssesOk
	 B0NdQ656k4FGeYCwnic1x0lVlW0V/lprZejr0jcudwnHs/CJn48ywGJfmm124UgDT0
	 NX+T2Yk1k39nlam+G0IfuviDsEyY3xrEy6PmUGMurWXdW53+QEwi+B8iQhCJNVPJ11
	 btgoUSRXFCdTQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTGCG-0000000470X-0ypM;
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v3 1/8] driver core: platform: fix swnode use-after-free on device release
Date: Tue, 17 Nov 2026 11:13:29 +0100
Message-ID: <20261117101336.980216-2-johan@kernel.org>
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

When a device has a software node, device_remove_software_node() may
drop the last reference and free it during platform_device_release().
If the software node is also the primary node then the device fwnode
pointer is never cleared.

Use a temporary variable to track whether the firmware node is a
software node to avoid a use-after-free in is_software_node() and having
fwnode_handle_put() call a function pointer via poisoned or reallocated
memory when the primary node is a software node.

This issue was flagged by Sashiko when reviewing a related fix.

Fixes: 7d80509ff0da ("driver core: platform: unify release path")
Closes: https://sashiko.dev/#/bug/linux-b860000b-f1d0-46a0-ab52-d47cec8eab99
Cc: stable@vger.kernel.org	# 7.3
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/platform.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 979593e5cca1..be5d2f315fdb 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -598,13 +598,14 @@ static void platform_device_release(struct device *dev)
 {
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
+	bool fwnode_is_software_node = is_software_node(dev_fwnode(dev));
 
 	device_remove_software_node(dev);
 	/*
-	 * If the primary firmware node is a software node, its reference count
-	 * was already decreased by the call to device_remove_software_node().
+	 * If the firmware node is a software node, its reference count
+	 * was decremented by device_remove_software_node().
 	 */
-	if (!is_software_node(dev_fwnode(dev)))
+	if (!fwnode_is_software_node)
 		fwnode_handle_put(pa->pdev.dev.fwnode);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
-- 
2.56.1

