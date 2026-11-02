Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608134;
	b=RdYfEwclw0ir6dam0NCGgHY52xcnuUsxZb9BORsrqvUY3EqStJGF/4LRpCpDorMx+mRY
	 9OwKnii1WsICr8h+LcCEpjLSKM8OXiMry1339bMooV7xTImkSbP+NQiZzDhRlistMinPc
	 6u8f+NjiWt+ALkXpUDXXKL6qqvwoYaMvGm7x5nOxi9BOpFm7baV20yqACAr+r12ViBzpc
	 ln5r7yvWGl0gv83+u6WUGEGUKf6kpcY4wDyG9xULybMKXMcIpSARy/rdlzccKWMpGMehq
	 7RbN3NlIHfrYRBz0l82xeSQAGYBhnBtu67JteRVeNDXD5LulOah4BU9a06rY6yLmdEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608134;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZRrtV4cXLsAnCpJIyAQ3ENe8TsYuX6DXwBdX6nqjxSs=;
	b=RwPf2mnEVHbUzNDF729vbFhetlrlP7ZJagxHM5PpWVa3pRalecB1nymRCHH3tqV4CFAT
	 L4XnxpW2OPu5fCDUzOeZeA9Y0MRoar4lsPGTuxfAz2+bnBLXKvdl7M5OL/Tp34eFJ7O0p
	 kcJNYm+Kl2wtUAb1iu/1Nz59YFZw1nFdXeK+g7NbKMMvqyzX2GM/wweHBh7bi7AgPs48n
	 Vo94hqx6yzuOsc2m0ERtTRKWry4AzYzej/bSKKpbkLNgTQlhhXXMhTuKJVdsK7llP0u7/
	 Nvx57BQFLG8rbwaBKoJ9fB7Mxs+iBZCXVXJ1A0soUM3A4sfd+PDlXAhFroLGO9xptBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orJ3OuXD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A464606A324;
	Mon,  2 Nov 2026 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orJ3OuXD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC10F1F000C1;
	Mon,  2 Nov 2026 08:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608134;
	bh=ZRrtV4cXLsAnCpJIyAQ3ENe8TsYuX6DXwBdX6nqjxSs=;
	h=From:To:Cc:Subject:Date;
	b=orJ3OuXDVfQVa5i4MUWO3y4lNNhRoEPHM33flesUeTx4vcnhKifDB89UZ4eDGxdn1
	 uw5K6cNOCJ3FdqKfN9KhpFWU8TDHie2ulB7KqNnnS+/HRDk4bvfMe912jfs+TEf8ip
	 /q+bQJCzxLDQcUInYQx26Q1IOeonv0xVgNm2KmO2uqmuARDXKEdmZ1K8WzoAJQqQzZ
	 Vr15rfsuLUHi/CUojP2XlIon3aCMEFnrhmC+tsRBANWL/AMULzhAUlh66oV8auUoS9
	 He0OMqk8MjZvYonS1mo1E5h2JBECKKU6GhA99BA3nHi+OkRZUhEeCNMn48rR8+SfOj
	 8iEF6YnN1pZ8w==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xNnPP-00000005Lnv-3z6m;
	Mon, 02 Nov 2026 09:28:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH] driver core: platform: fix fwnode leak on registration failure
Date: Mon,  2 Nov 2026 09:28:22 +0100
Message-ID: <20261102082822.1275425-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
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

A recent change started taking a reference also to non-OF firmware nodes
when registering platform devices.

The firmware node pointer is however still cleared on registration
failure when ACPI support is enabled, which means that the reference
leaks in platform_device_release() when the device is freed.

A software node also stays registered as device_remove_software_node()
returns early.

Drop the clearing of the fwnode pointer when registration fails to fix
the leak.

This issue was flagged by an LLM.

Fixes: 7b5b51b2b05c ("driver core: platform: count references to all kinds of firmware nodes")
Cc: stable@vger.kernel.org	# 7.3
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3593d45f4a7a..979593e5cca1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -971,7 +971,6 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
-		ACPI_COMPANION_SET(&pdev->dev, NULL);
 		platform_device_put(pdev);
 		return ERR_PTR(ret);
 	}
-- 
2.55.0

