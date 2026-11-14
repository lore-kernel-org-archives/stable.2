Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630435;
	b=npgXCGDm4wHgD9RCbBv2mXu4sAs3Su5PswYx9kJzSLxl6SBWyKrAKyE9hRr0nXfowAR2
	 cv4zX3ylaVyURCTEYXQVWintYG+SycAvrd1sAnf334vGgSxvNLhVZLYgnhmN6hqTlmefb
	 z3+P6lTfC0YL17axijrv8//9mxhp5Guxd6nIxiFQSA/Dxm0EaBYqLx9JhwGGprR+E8jo+
	 oKvnxnyN8lYsFH5DTnM1erkbUwNB7nZ0ucanKVmtPDgvoxCsLqZ7g8wDQ4oVtb8F8SIKU
	 mpQmcEESDIdGZ1aot4kE8v8NF+GMfXygqYcNzhVjirB6y6BQqKY7usK/uMMJyyUAR1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vK5wFlssuUg9RtHgjXl+u5xduQnhEj8SROXucwW5d1g=;
	b=DjNG9yAUJbHaqJv2EQAu+ysYw8tN11Mb3iSlK3SKQb241Jcjd2DEwHco4whBGqg+HouM
	 +H48fNuVJpKxuxj7AIyxUMJpukKxm/u8ofpgbQBY1r/gCTP+jpfDBMSoAZgiO9eTcWD/H
	 nmc9pdDyhL01O9+2Gu8dhsFYfNe+MMHy5bgzLFp0oPSDOdJQ3S7r4GY5vmKSMkdSZZj2H
	 KAQtzloEHajYZfuMQErFzI62aDqTqrvmWrOFUY3Kr7DLwuoEKnX52jcSJIGAowVCUAC9Z
	 R4deCXW5T54LODoWc7da2Wo8Y1j2Ck3wc4sG8qq5Gvh8uZ9ccI4COwsX0E/ex+brPpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUHtsVBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538D606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUHtsVBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02261F000C6;
	Sat, 14 Nov 2026 04:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794630435;
	bh=vK5wFlssuUg9RtHgjXl+u5xduQnhEj8SROXucwW5d1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUHtsVBnFJy/2Pt7vd4O/1xJv7mDHgUxvZFN5IKojxSpUn81Rz/HGbEbkW3oCjpBo
	 Tv340a5lZlh7EMBYs8OVRS//DslcSOpORaYMSzsgTPEJJsfvzyFZydcN0xXInyBN8t
	 vGjxqLGp2H0os+XiGi1lG8OSoiyMiq4D9c3I81uC1IS32nUdjzcLYUZvxxCmj5zQ+O
	 pLWOIIbtHQx0mYtgrN3XajoiLNeh3FfpdQ5PhI8/tcCYc47nbD5SmSpaTmmPa6CEtg
	 MhH4BxAn4m7UAcie8OFVVuRJQtF2zTRvPP4CSexZ3QlGkRUK5nIyU2VDV/GeS1v2s8
	 fXVKwnWNOFBCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <blum@kernel.org>,
	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] hwrng: virtio - prevent use-after-free after a failed restore
Date: Fri, 13 Nov 2026 23:27:12 -0500
Message-ID: <20261114042658.2897777-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114042658.2897777-1-sashal@kernel.org>
References: <20261109201748-failed-6.1-0f7bf47f5a0c@kernel.org>
 <20261114042658.2897777-1-sashal@kernel.org>
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

From: Thorsten Blum <blum@kernel.org>

[ Upstream commit 0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74 ]

remove_common() frees the driver data during freeze, but does not clear
vdev->priv, which points to freed memory. If probe_common() then fails
during restore, a later remove or freeze can dereference the dangling
pointer.

Clear vdev->priv on the probe_common() error cleanup path and before
freeing the driver data in remove_common(). Also reset the device and
return early from remove_common() if vdev->priv is already NULL for a
safe teardown after a failed restore.

Fixes: 08e53fbdb85c ("virtio-rng: support multiple virtio-rng devices")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <blum@kernel.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261016103640.4989-2-blum@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 14ab1c2a7350b..0c32991e5754d 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -188,6 +188,7 @@ static int probe_common(struct virtio_device *vdev)
 err_find:
 	ida_free(&rng_index_ida, index);
 err_ida:
+	vdev->priv = NULL;
 	kfree(vi);
 	return err;
 }
@@ -196,6 +197,11 @@ static void remove_common(struct virtio_device *vdev)
 {
 	struct virtrng_info *vi = vdev->priv;
 
+	if (!vi) {
+		virtio_reset_device(vdev);
+		return;
+	}
+
 	vi->hwrng_removed = true;
 	vi->data_avail = 0;
 	vi->data_idx = 0;
@@ -205,6 +211,7 @@ static void remove_common(struct virtio_device *vdev)
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 	ida_free(&rng_index_ida, vi->index);
+	vdev->priv = NULL;
 	kfree(vi);
 }
 
-- 
2.53.0

