Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618163;
	b=Azz821pINxdQKVEsz6HVD/N7pivLuAfi5W97sIparw48oswx3xO/IICUQhFYKDUviCT+
	 RuljhCbh7SFRUUptT2rxvz+b5StrND4h2DZb54PU78cyQQFn4eTM6M+jtHXeKDjP3KrqH
	 rR8wm4L0R2yE+csmP4nQ5UDgLp6oq9jI6esIoAPFQzQ3/3lp3AuowwefHSG930RBfCHNz
	 DTwJEc9z+pPBjM8FG9HykzTchYqGAdZgUFdnNKu/meGyMnmBSH10UHWGgdEkJd3CeSzGZ
	 Ix2N3FOZv99xoH1KLhwz7CgDe+FFNI0lOLdBfMDDwBwBsrTIJH8FQwWD8LvFjImbt/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618163;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fLYaH8M14870OTrL/NbVoc9Tvu/OmPJCwvPEuaXdpUI=;
	b=pSCfXM2Co/Jwll6d74ocWa7SG1Pm1xyD4Vqv1+Gzik+ZnrPKgTnRA0Ng5kXpZ6Mbat+e
	 72Lfi271j3pjGzFNS52LogzuBL4FuZ2WsZa/d/NeMulusOTgb+hVlNOYdtuojAR9OueII
	 Rowp1u1JCPafQi3/uVD/Ldlt9zEtUSn1/jyTfUnrMiOA7/5iS2DfpA83e0rJhnDQ7QAUf
	 7IWj4zzzDPpkhnJEebYDazisauOmVDUS1PqBYXToGtNP245cTT1F7xlj86+kLI3F7VRPO
	 nIafvbNYkkdNGji5Q4j88BAIF9/u5YyF+TfLmlrZkhwMS++AcwjdCHS46kwJl3oVJkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ag1SB2uz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BBF60A2604;
	Mon,  2 Nov 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ag1SB2uz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BFA1F00A1A;
	Mon,  2 Nov 2026 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793618162;
	bh=fLYaH8M14870OTrL/NbVoc9Tvu/OmPJCwvPEuaXdpUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ag1SB2uzsdcrsCwJlNfnKNTWj7UbL5OlJxjDqZU5d+gR85E+EVh4wrEmEpuvnPYRp
	 qSuAZZF/9q63enHT+HS9E26ccG+S0jTtgjefK8Xv6fQzB/jliGBkhKmZ/SYGlngfOI
	 87vizUMyDYrR98Ne1YZdgU5Cc7wz4wrhY8/BegWoFP8rbVCF6A8Uc/9zTrmlc+Pk4e
	 sBHFx5EZLYshOkV9mD3O8CvSDnwQOO+r5LlAS5FWSEwpmfGM+d5zMRiD6cCm0aFaNx
	 3Tb8tUTtndmJXpoMthoYSre3zeDxSeu+F/s2nZHaDtsyeGHrwdHeCELBv+G0PfPNk3
	 BdgrF0E3ueYrw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xNq1A-00000005aDw-0x1t;
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
Subject: [PATCH 1/2] driver core: platform: fix sw node use-after-free on device release
Date: Mon,  2 Nov 2026 12:14:19 +0100
Message-ID: <20261102111420.1330760-2-johan@kernel.org>
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

When a device has a software node, device_remove_software_node() may
drop the last reference and free it during platform_device_release().
And if the software node is the primary node then the device fwnode
pointer is currently never cleared.

Use a temporary variable to track whether the primary node is a software
node to avoid a use-after-free in is_software_node() and having
fwnode_handle_put() call a function pointer via poisoned or reallocated
memory when the primary node is a software node.

This issue was flagged by Sashiko when reviewing a related fix.

Fixes: 7d80509ff0da ("driver core: platform: unify release path")
Closes: https://sashiko.dev/#/bug/linux-b860000b-f1d0-46a0-ab52-d47cec8eab99
Cc: stable@vger.kernel.org	# 7.3
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 979593e5cca1..ef0bfa972653 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -598,13 +598,14 @@ static void platform_device_release(struct device *dev)
 {
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
+	bool primary_is_software_node = is_software_node(dev_fwnode(dev));
 
 	device_remove_software_node(dev);
 	/*
 	 * If the primary firmware node is a software node, its reference count
 	 * was already decreased by the call to device_remove_software_node().
 	 */
-	if (!is_software_node(dev_fwnode(dev)))
+	if (!primary_is_software_node)
 		fwnode_handle_put(pa->pdev.dev.fwnode);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
-- 
2.55.0

