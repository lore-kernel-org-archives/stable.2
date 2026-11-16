Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810225;
	b=Dd4cZAGLH0399v6W27HmYBH/CEtZUIDg8OqyFmZbz+rH+LTxFjh2q46md9QClGo05yqz
	 ey26yzibkAURcwsuJXbBOjAXodAXsJ62OCuuMVuYmg4BryVeHWBSlkMq9mRzVVNq02811
	 pdrReR87ioT7wT/cO8IGkWXt+V6Zd8XvS5YEiJIrjfQfLke2LqOEFhbvjhSLoYHSamASP
	 TNMXIJuiebi6PfSkQfFc71NNlYDg9vTVtUxoulaXnIQhKpCTGrX0CJq69Iwt5t8TQJFt2
	 MAdfkeFJdk6uF4+LP7VMgjzwiIaUhOxgKo0UnMYIO/cEuzUzt0dEmNyhK/jKFN8vJRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810225;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=KQlDVWjXZe3NXqiXUZIGcGPVYKyfWxuBXPObZCUjmvE=;
	b=K+Xuh5/XwAgQfPZw9QNBVjOreiPUr1r/ZPnNFRMFap7jjcv4ZmFMjHTxkqV4z2w2HfUN
	 1ujN8d7Vk5Ql89Ir4514YkUhGm2AppTN+xzT/vnFXWvP+qnxZOGBbaTLGd4KdJ4I6q/0J
	 HlNJ5gNnfJQFSRlbKbhR6ucOEwmWSknBnJIv+y/68WmPhOKnqXiNPtHVz01jBHGn2X7W8
	 1AYWrdcvJraGk5gZLP0Lms6LVNFbpmNEVP5V2oXRKrT1Wnga9NxU5dH8I4Hscgvcg6Hao
	 f8dpCd0iWEQ47Zon4gHlkWnraValR5YIscV8tSufBRAIzrMwRZOCvSeM8OX+8i7S8hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE8606A323;
	Mon, 16 Nov 2026 06:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37AE8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jSd904hpVz22V1;
	Mon, 16 Nov 2026 14:23:32 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: [PATCH] libceph: fix 32-bit object_base overflow in ceph_osdc_new_request()
Date: Mon, 16 Nov 2026 14:23:32 +0800
X-Mailer: git-send-email 2.48.1
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Mon, 16 Nov 2026 14:23:32 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AFAA164.001 by FangMail milter!
X-FangMail-Envelope: 1794810212/4jSd904hpVz22V1/6AFAA164.001/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794810212.6AFAA164.001
X-FangMail-Outinfo: 1794810212/6AFAA164.001/4jSd904hpVz22V1/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794810212.6AFAA164.001.4jSd904hpVz22V1@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFAA164.001/4jSd904hpVz22V1

In ceph_osdc_new_request(), both 'off' and 'objoff' are 64-bit file
offsets (u64), and 'truncate_size' is also a 64-bit file size (u64).
However, commit 864e9197f10c ("libceph: add CREATE osd operation
support") inadvertently changed 'object_base' from u64 to u32 when
moving its declaration into the extent op branch.

When accessing a file at offset >= 4 GiB (0x100000000ULL), 'object_base'
wraps around modulo 4 GiB. If the file has ever been truncated
(truncate_seq > 1), the per-object truncate_size calculation becomes
corrupted:

1. If truncate_size >= 4 GiB and falls inside the target object,
   'truncate_size - object_base' exceeds 4 GiB (> object_size), so the
   per-object truncate_size is erroneously clamped to object_size
   (e.g. 4 MiB) instead of the intra-object truncate offset. On a write,
   this causes the OSD to truncate the object to object_size while
   bumping oi.truncate_seq, causing subsequent MDS TRIMTRUNC operations
   to be ignored as no-ops and leaving stale post-truncate data intact.
2. If the file was previously truncated below 4 GiB and later extended
   past 4 GiB via writes, 'truncate_size <= object_base' can evaluate to
   false for objects at >= 4 GiB whose 32-bit wrapped object_base is
   smaller than truncate_size, passing a bogus non-zero truncate_size to
   those objects.

Change 'object_base' back to u64 to fix the 32-bit truncation overflow.

Fixes: 864e9197f10c ("libceph: add CREATE osd operation support")
Cc: stable@vger.kernel.org
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
 net/ceph/osd_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c181..7dfac7aa93e3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1090,7 +1090,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 		osd_req_op_init(req, which, opcode, 0);
 	} else {
 		u32 object_size = layout->object_size;
-		u32 object_base = off - objoff;
+		u64 object_base = off - objoff;
 		if (!(truncate_seq == 1 && truncate_size == -1ULL)) {
 			if (truncate_size <= object_base) {
 				truncate_size = 0;
-- 
2.48.1

