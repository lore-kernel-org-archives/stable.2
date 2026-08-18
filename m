Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA9520125F
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032076; cv=none; b=nYWVt3962wpa72QnV/gL5VebSdXzcOUgPz5I7l5bpxNSpPVi94MyZoHbfY5EndMCS6ly69krhXKIE1CPSvziUKKQnvKH1/qS2UnloOP6TYdISvx/G1na4o667NsexKCothV7RUMSVY420H+o+z8C9fyd5MVWOXigAK5D4BlEegE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032076; c=relaxed/simple;
	bh=3kwUH9VjOFNvtVGD9P+Sv3DG838jDeBeyfBh1fP55f0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qw1Eu7YemR4/Ye2iO1WPlUf3p8QJeOLxTS5PFAsUNG9PqAAICVWeZ6ITjM5u6Y5ANKm59ySjGpkubsME8woVhujyulS3ht4SqGQ9vufvavyff8hDYE3LJ5ATjCmJK9t2+3s9rZci7fUgLIkFzBTQnvFJRihytM2M7ykf3WmWhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJBl0DqR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJBl0DqR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce98cb8165so6433305ad.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 22:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787032075; x=1787636875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yeF5s/zx6+8hMLW6H+qKAJyqoTB1cdRg+gT9WgtCNI4=;
        b=TJBl0DqRaxaljV5xtkEogIi4Qcmwy9tYHiHxSoMKhzSzCAImiEeJNJ2xMRFnA9vU9H
         ShHKZ9nQFAhhH4COS2SEnM5WHf2+uGnZTDdP0flP7a+EZt5hS7Cm3x7LnXwzl/EIDqa9
         bgfBbRBVp02rmpgLvLUqcCERJo2OD2925Eh5TgZZWvybOrFbcTHF0EeIAcjDDSaa7qu5
         qX9MPvfPNbYVJdTpxdlGfFe5L42ECXn25TCEu7lmTpysS/sn0Et5JCsGbhdK+Ph48v89
         Q9GaqLqTJfeNmo4qPSH7t56ArbbWx+Sof54UmDSaxZHIv7d8WXeq8mPPTeEQ+LpZX1OI
         nw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787032075; x=1787636875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yeF5s/zx6+8hMLW6H+qKAJyqoTB1cdRg+gT9WgtCNI4=;
        b=LBSaewXMQ9JMtzoGizqZs5EB8YXSOQCyiDBDH5687YrN+SCn1qy9rCmsJKE0sq274w
         OFAUl7/RZqpGsqDQtAEf44hHG1BxGHc9Vkby7oilXotlJ9rpWqZBG08i0R3ep7Jf9qNG
         SE4oSBpY6A6Agv1+KkcaX128LdbHAwPqVhDcdd+kpYjBucdIJuv6FGMf6mCgoMhAPK/8
         FpUCUBipP1B/HZIv8SYXikwRrhKi5SrOxhnXphaWtTiGYR443gBEjGOu1b6CxGt3bbC6
         pNjDKSin3JiINdXsX0lOuDHAgtZzXbmivkW4lhZFkCgVhaAmh7FdZWEPKJVHaJzJzrkY
         enjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqnq8dXcRaw3F0EOVTWpWgyKTpp+rpw0XItF7roWa2mKY9pnwaM3WOruu9/JuS4QodQjEc/tH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DsgIfBmrQ/J/0wnQAuJavFh3RUMoigk5Db7iOOOsiskmrDuM
	J6teiJNxVjrfrF2bmZX2lAr64M5hfo8pSaHnCNwmHLk5iP17vU0lwevh
X-Gm-Gg: AR+sD12EagsZmEnhVC7jlN1YnPVVRTbW2L+1KdB3ExN6uCZ5Nl7pusLZgtbebKJeGXR
	7OT72a22BfeHE9M9FLXzoK/CAx9PbPaAB8RG5W5zyL+B1gHEKX3H3lJ7S+jWL31DdOyY4pqqyQF
	2Sua7SlBUQf3WATOYh9S+exRH33qQp1NbNyAeY9ysDG18HnjIK4l2VNGtImbQvuX4vtR7Xvxogf
	bOJZVYHN2jrHHfhMhr+E8PsQ6bFJ9dZDvo/0DE4nMoFYJojxuXt211Tcs7k0Fpc47Wcw7Rfd4oH
	52CLj2zsAeBTW7Z21jR/KhqfRCTok47r5O/r55DQAL2+LCNjIHQKlxXFJzxJ1z1HJv7HsrbVRrW
	e+fWgxrZoXGCPGVnNSik0ZPYsqWdCk4aonqrABkFyJQ1Mq7FPFbeL+yjMLxNjGHd34agE15zdZg
	dyOxxY3p7+iG0fbYTcsmuyTT/HXzVV+VkHNu/QvK1reG3+h25eLC7p47QBPv1KZj5SK0OovdUJl
	cg=
X-Received: by 2002:a17:902:e78e:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2d5d149bafamr31963995ad.7.1787032074635;
        Mon, 17 Aug 2026 22:47:54 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb514bacsm13097505ad.27.2026.08.17.22.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:47:54 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: amit@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] virtio_console: do not free control-out buffers on remove
Date: Tue, 18 Aug 2026 13:47:09 +0800
Message-Id: <20260818054709.282196-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__send_control_msg() publishes &portdev->cpkt as the control-out
virtqueue cookie. remove_vqs() walks every virtqueue and passes leftover
cookies to free_buf(), which treats them as struct port_buffer and
reads sgpages.

If a control message is still on c_ovq when the device is unbound,
free_buf() reads past the ports_device object.

KASAN reported the use through:

	free_buf
	remove_vqs
	virtcons_remove
	unbind_store

Drain c_ovq without freeing. The packet lives in portdev and is released
with it.

Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
Cc: stable@vger.kernel.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/char/virtio_console.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..6e9bf064826e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1886,10 +1886,24 @@ static void remove_vqs(struct ports_device *portdev)
 
 	virtio_device_for_each_vq(portdev->vdev, vq) {
 		struct port_buffer *buf;
+		unsigned int len;
 
-		flush_bufs(vq, true);
-		while ((buf = virtqueue_detach_unused_buf(vq)))
-			free_buf(buf, true);
+		/*
+		 * c_ovq cookies are &portdev->cpkt, not port_buffer.
+		 * Detach them but do not free_buf().
+		 */
+		if (vq == portdev->c_ovq) {
+			spin_lock(&portdev->c_ovq_lock);
+			while (virtqueue_get_buf(vq, &len))
+				;
+			while (virtqueue_detach_unused_buf(vq))
+				;
+			spin_unlock(&portdev->c_ovq_lock);
+		} else {
+			flush_bufs(vq, true);
+			while ((buf = virtqueue_detach_unused_buf(vq)))
+				free_buf(buf, true);
+		}
 		cond_resched();
 	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
-- 
2.34.1
