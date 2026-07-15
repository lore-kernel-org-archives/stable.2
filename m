Received: from sender-op-o14.zoho.eu (sender-op-o14.zoho.eu [136.143.169.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684344A724;
	Wed, 15 Jul 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116394; cv=pass; b=Ne4JgvKlmPIcsa7b+mreiibe7y5uMMKDLRLYb86hxk0bgTtG7s/roXajdtsdbml0hgE4blh4IlVjTehIYkN92L7ZP52JDKqe22uy0BshnPLbhQYCJUpiNyYjXK+joSRsWITnXfzDQXwdWMYjXBRFQaiT2YMdAXF41PdBWsDy+RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116394; c=relaxed/simple;
	bh=IDnj6jWj43uN67WqhPH02BHmfO4b4OCBIipMh8UinE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhGUAHRIdjxjIJNpHVCaQjmjUWy16xubEdZBbQNHmJ4lUKB12sELbOuQ3IVNrU6sAZhaVRlbT5OQFB2wog/Nho7mZwASUYMJeE3DafsxdJFy6RVInjk1KX1IE6zLlLdEJpTMxHszVUl6grdPZvjKT+H3QLyDsOD4zZwUZCzjV4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=lCmMGAhB; arc=pass smtp.client-ip=136.143.169.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="lCmMGAhB"
ARC-Seal: i=1; a=rsa-sha256; t=1784116385; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WEhFlhyaZDao1NHMWCiJuJwfhV7ICbDNhQjOVjK8N+HO7FEZxogGZ+Xg5j26DMDMqKWWENiFtP+gSLh7/fcxAhGlwn59a1O2PniJXEjqchIu1jxkRM0rx7VA0G5/Va+WzMrP+QcLA1ULSV3TNiv8zVM7rkUGsOBmwaTb4nYWJxk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784116385; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=64i3jyHPMZVmvneGCETJ0OwDHHz60aCU6qdo6hdHYoU=; 
	b=bgtxK0368wPQQvrFaosFc4lvS7/C/01HSyQmpHsb8nnd++AwXf5H+fRz29SBzkhBfUf3geaLRyfnHhIy8sDfoyGLccTufByDwtivv4nF9+Y/s+35Pe6VbOQLkkG3tJRoIRzIOYttQ2Mf0hqr5EleH+UydEKitmJqcW40cTviTEw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784116385;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=64i3jyHPMZVmvneGCETJ0OwDHHz60aCU6qdo6hdHYoU=;
	b=lCmMGAhBbRhSwTEgp4f+mJL1wkYrp4RwqwVEC1QjcGZiMS+FWUOeB15yK3F7PlPR
	Dcf3Gidi1OxPvmHI/mBleDJIpZvBI4mJbLXwsDmoXlCggzpeNRbzI5QQQ0v3rJJejJb
	Vh4k5jhZkeCVyxO0wf2jQpvf7milAyd8jUBxMTOs=
Received: by mx.zoho.eu with SMTPS id 1784116383652928.0873188209995;
	Wed, 15 Jul 2026 13:53:03 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: picolcd: clamp eeprom debugfs read to bytes actually received
Date: Wed, 15 Jul 2026 13:53:01 +0200
Message-ID: <20260715115301.91063-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

picolcd_debug_eeprom_read() trusts resp->raw_data[2] -- a length byte
supplied by the device in its REPORT_EE_DATA reply -- clamped only to
the caller's read() count:

	ret = resp->raw_data[2];
	if (ret > s)
		ret = s;
	if (copy_to_user(u, resp->raw_data+3, ret))

It never checks resp->raw_size, the number of bytes picolcd_raw_event()
actually copied into the 64-byte raw_data[] of the kmalloc'd struct
picolcd_pending. A device (or a spoofed picoLCD) returning a length byte
of 0xff, read with a count >= 255, makes copy_to_user() read past
raw_data[] into adjacent slab memory and return it to userspace through
the debugfs "eeprom" file:

	BUG: KASAN: slab-out-of-bounds in _copy_to_user
	Read of size 255 ... picolcd_debug_eeprom_read+0x214/0x2f0 [hid_picolcd]

The debug-dump path in the same file already validates the device length
byte against the received size before trusting it; this read does not.
The file is created S_IRUSR (root-only) and a crafted device is needed,
so it is neither unprivileged- nor remotely-triggerable.

Clamp the copy length to resp->raw_size - 3 (the payload actually
received, minus the 3-byte header), floored at 0 for short replies.

Fixes: 9bbf2b98ba11 ("HID: add experimental access to PicoLCD device's EEPROM and FLASH")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/hid/hid-picolcd_debugfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index 085847a92e07..1f7dfe60e9ba 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -99,6 +99,15 @@ static ssize_t picolcd_debug_eeprom_read(struct file *f, char __user *u,
 		ret = resp->raw_data[2];
 		if (ret > s)
 			ret = s;
+		/*
+		 * raw_data[2] is a device-supplied length; also clamp it to
+		 * what picolcd_raw_event() actually stored (raw_size), or a
+		 * hostile device overruns the raw_data[] buffer.
+		 */
+		if (ret > resp->raw_size - 3)
+			ret = resp->raw_size - 3;
+		if (ret < 0)
+			ret = 0;
 		if (copy_to_user(u, resp->raw_data+3, ret))
 			ret = -EFAULT;
 		else
-- 
2.50.1 (Apple Git-155)
