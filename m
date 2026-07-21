Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF7375F69;
	Tue, 21 Jul 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641800; cv=none; b=tjw6iGoR6oArcCoWiPHNj+1HhKJGRl01KUJQLbOqoogDuc+iy/FqBXpymc2HwBr/aEfn2IbmexMxsdaM/dC1jjOtPWKUsoDvbctOGMWDudFZ4wLMS0X3iKs/pKL2JIjoKwgUJV2/GTU4UyBi0JiIRZV2MlXLWzyVvmMPEpREZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641800; c=relaxed/simple;
	bh=V0Cz0mi+LoXe9x5QGz9fZQadK6cFW3vSovqAEEEnD78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TJn9D9hm2UxhPOsNHMyDgLg4+rEbRBGs0cbQNXIBsxS81yx/1L7XNKVMaZxppQB6V0N6uRoSi7sS4mhRYNjqUfpeLwFujQLuMAEVQyfiWbhj4lGxyo2eTbvHP4UYRwLCPzXmgs10TQeNn/kxz0SK2szaotyqobYPOmw9ti/Y4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ovUD1F6o; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ovUD1F6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qF
	tS1cyXiss5O+tpSA4K0a0dG7hXX3ZlQEbtz7ZkF54=; b=ovUD1F6ohHNUZpOZyN
	PAofoi+2eB+EsCeXmSxfr6SziwjsOlO9xHsx9kAZ6AVS0WVY59Vr3N7n6bbiDER8
	H0BsCYxTjm/UQrTfqmZbYDhck0cv/Q2yexW5zqP4z/lbvm9BDDLpKu6lJYdigszB
	3t3uFf8nRGHHIO9uSIj/a4O8o=
Received: from lwj.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAXQpXbeF9qOuCyKQ--.50215S2;
	Tue, 21 Jul 2026 21:49:16 +0800 (CST)
From: Xuan Tang <x14786623579@163.com>
To: patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Xuan Tang <x14786623579@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/gma500: Handle zero-length GMBUS writes
Date: Tue, 21 Jul 2026 21:49:10 +0800
Message-Id: <20260721134910.844678-1-x14786623579@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXQpXbeF9qOuCyKQ--.50215S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fJF47ZF1fur4rKF4xtFb_yoW8GrW5pF
	sIgF4UKrZxJF42y343ua17AFWrC3W7Xa43GF4kKw15u3W3XFy5JFW5Wa4aqryrGrnavrZ3
	trn5KFyrWr17JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRrOz3UUUUU=
X-CM-SenderInfo: j0rulmywwsjkixz6il2tof0z/xtbCzRzHt2pfeNxaWAAA3y

gmbus_xfer() uses a do-while loop to preload the first bytes of a
write message into GMBUS3. The loop accesses the message buffer
before checking whether any bytes remain.

For a zero-length write, the loop therefore dereferences the buffer
once. Decrementing the unsigned length from zero also wraps it to
65535, which may lead to further out-of-bounds accesses.

Check the remaining length before accessing the buffer. This keeps
the existing GMBUS transaction flow unchanged and preserves the
behavior of all non-zero-length writes.

Fixes: 5c0c1d50d7ba ("gma500: Add support for Intel GMBUS")
Cc: stable@vger.kernel.org
Signed-off-by: Xuan Tang <x14786623579@163.com>
---
 drivers/gpu/drm/gma500/intel_gmbus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma500/intel_gmbus.c
index 5933ae04a6aa..bf060a62b3b7 100644
--- a/drivers/gpu/drm/gma500/intel_gmbus.c
+++ b/drivers/gpu/drm/gma500/intel_gmbus.c
@@ -294,9 +294,10 @@ gmbus_xfer(struct i2c_adapter *adapter,
 			u32 val, loop;
 
 			val = loop = 0;
-			do {
-				val |= *buf++ << (8 * loop);
-			} while (--len && ++loop < 4);
+			while (len && loop < 4) {
+				val |= *buf++ << (8 * loop++);
+				len -= 1;
+			}
 
 			GMBUS_REG_WRITE(GMBUS3 + reg_offset, val);
 			GMBUS_REG_WRITE(GMBUS1 + reg_offset,
-- 
2.34.1

