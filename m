Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300728;
	b=CAfhx9H7D3/G0ATYNayDNfTCoZnl6rNNk/Yzb/WQWYi/zdSu0Hy5+sWoWKd3G1zi4UVr
	 dc8vJ2HB2y5nF5613z5ETzVWnx/hAKUgR9z9wHML5FaF1vO4uh0Uec7WdbBB2DgkYed1w
	 oUmGEs7Chhnf4SR165Fce/Fr9vanEZ3I/5ybbpiYw1yHbrYFeS/U6KjlmrhBp9mNtIa/o
	 ZnSdZwCLSf0U8Toip+HNU10QqpH0zmW5tr8ZATGPsUs5sAzcLQAzb5nbnnugZ5nXyJEfw
	 yBygPFNPnYZysfQ2k671iWMsHTa8PMY9n5G8UIhu56q8lUzVbbfkw1CU8617GH7cY9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300728;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yV3HrO4sB875j9dq+PUOEpzNA5g/u+ASOnUiDHJot7s=;
	b=Bk1bxzpg/G77bmzoiHvjAM7AGL4ZfWVNiIvkfDo9efgzBjBNZ/j2S7Dvgtu3aNl9/SKu
	 2oRZvjCx53us7uVu+TgAL6DFDY3fAWx+44XfHv8NAEOyeRfjNzRLSjtPs46qN5KxlLoqq
	 VVBWEw07Me5YI2YHWtuqTOIfJbtPExyj9g1sy3rK/smgUgxZ1o79n9sr7vR+dacomHjou
	 RVQHQSyhjg/cxZZQGmQrhIpqnHMnoccKNaZDpwJC+rxE4Ed3kan5KvGoby8DrUAUlcCs5
	 SXr1MOahpjQAYvCpPrzeMCx7GuV3Y9P2MFReU51KIA/HWcR5qOFtVs8ctxcWCqr5kGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnXUqWKE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D56606A33B;
	Tue, 10 Nov 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnXUqWKE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF171F008BC;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300726;
	bh=yV3HrO4sB875j9dq+PUOEpzNA5g/u+ASOnUiDHJot7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FnXUqWKEHzshOhgqUXQrR36k84e3a372+EYuMroj/Y8B0xK/PljvnZ6jmuV17AZfj
	 avKkZ60HX1oayiLWj8Jm9aZiENctAZvEERYiI1SRcrRnu7M4dTh5+kzT+v1tzRe6yA
	 oPqiX2sjUZFPcgioDnKbpM1ovvhErjiD3iqYcVV0XnfAjuCieFjMfPMRWkUkbyjsy6
	 xa5ECuY7FX8HdyMDq69nrfYCk8bhbX8ObHi1PgDylmv0sFJPcjLMn1a0ZcwwEO2Jy1
	 V4ICUHzfK9G6ORfxAF2VTOexRnBWnqoSgs8BjYTXhnKIvaTnIgHb6m2i8ngx4UwshM
	 /xd1BFobQkWqA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQhaG-0000000Adc6-04Qw;
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 1/8] driver core: platform: fix swnode use-after-free on device release
Date: Tue, 10 Nov 2026 09:51:17 +0100
Message-ID: <20261110085125.2535508-2-johan@kernel.org>
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

When a device has a software node, device_remove_software_node() may
drop the last reference and free it during platform_device_release().
If the software node is the also the primary node then the device fwnode
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
2.56.0

