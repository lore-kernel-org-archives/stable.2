Received: from sender-op-o12.zoho.in (sender-op-o12.zoho.in [103.117.158.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66794397958
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113643; cv=pass; b=qfs6CFKFPRyEkFgaQ612Z3jcE5o0ybItfUm162tbcrVgSjPQlo4v4Vt238kqeSOg4DLGRbm8AcZ4BCski9BGYO+P8iPdBaydvauGvOjeTlH7ravRmlZQQpTTAQFJwZre9c5hR4+MVgyistbbydusZJwmQVqjsoZJQNyQ3hixETw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113643; c=relaxed/simple;
	bh=Kpi+UXt/mVaJSt3kdXa3E43AhBUvbW4u9EIi7Br0syk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=isj0QBxdqULVhgZT8S+JscNOV3udDa2UoZOLeFmz9QgQVHha+Qvv1adVTQ2eFpvX4CD76vqpXgQEPHiOcPC72AYStJ7ZjEHyYuksycNQr4W9+q94c+QrJo6h+kJdTGjOla/vt/HCToCjiKNO4SoLiQxFkAfuJCob0wrWsWG/Pnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com; spf=pass smtp.mailfrom=a0rg.com; dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b=YODa0nr2; arc=pass smtp.client-ip=103.117.158.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a0rg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b="YODa0nr2"
ARC-Seal: i=1; a=rsa-sha256; t=1786113571; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=bEMxvV8QnZDsivTPulioGVAtRhEFhgGXduhYcCVt0RX+ARroEg3Q5BsWc5Oaj0Ll9zbwLnAmIYHyknrl8wz2Fpv1cz0R1dJYsbSmMTK/aeyFcBHwzPuaZLZD5Ph7u868jqoAWSbBZvWsj8c9eDM7QOGKzsBCxTv7qTvKNRrJKMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1786113571; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QFyW7em+a6TgHJzmuWJ2E8pdf7m8X3qSXLj5q/I1U5s=; 
	b=ZXgY3XubV0FLLwVcRYiL4+ZGIfUU52uKb3SAcsQuRfOf/gJC1G8vHdU2BiFOvxFx2/qgUdYtHaflj1e4yewtcu2t+Nwt38JLaHJL4gd/A2Q+vZ4SZfjl5nJH+jP5AeZUETrC7u5cKakAWij3ExgUvSbkBYEkY3a8VKSdHZWm/MY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=a0rg.com;
	spf=pass  smtp.mailfrom=icarus@a0rg.com;
	dmarc=pass header.from=<icarus@a0rg.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786113571;
	s=zmail; d=a0rg.com; i=icarus@a0rg.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QFyW7em+a6TgHJzmuWJ2E8pdf7m8X3qSXLj5q/I1U5s=;
	b=YODa0nr2hJJIUnyyBCYDEG3lvbUX+2r1ftpY/ZYxBQZg0Ooxou2JdVSzLHDrkTQ5
	YYp5/zuJ10GJ7iWcRY7VYB4zQBwt/hhDhSeM0lF5QQpIHDrtHcmurfx9viB0D46K3/z
	XSfIoumjqfpGrqLXX3v/S09bjKh7hYcuDcZUVh48=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1786113568825928.4737957537083; Fri, 7 Aug 2026 20:09:28 +0530 (IST)
Date: Fri, 07 Aug 2026 20:09:28 +0530
From: Anirudh Prasad <icarus@a0rg.com>
To: "linux-acpi" <linux-acpi@vger.kernel.org>
Cc: "rafaeljwysocki" <rafael.j.wysocki@intel.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"stable" <stable@vger.kernel.org>
Message-ID: <19fdcaa3013.263bb5511124041.2034910216820799254@a0rg.com>
In-Reply-To: 
Subject: [PATCH v2] ACPI: pfr_update: fix stack buffer overflow in
 query_capability()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

query_capability() copies four ACPI buffer objects returned by the
firmware _DSM into fixed-size u8[16] fields in struct
pfru_update_cap_info using memcpy with the firmware-supplied length:

  memcpy(&cap_hdr->code_type,
         elements[CAP_CODE_TYPE_IDX].buffer.pointer,
         elements[CAP_CODE_TYPE_IDX].buffer.length);

The same pattern repeats for drv_type, platform_id, and oem_id.
If the firmware returns buffer.length > 16 for any of these fields,
memcpy writes past the destination array.

struct pfru_update_cap_info is stack-allocated in pfru_ioctl().
Confirmed with KASAN on 7.2-rc6: three stack-out-of-bounds reports
are generated when a DSM returns 64-byte buffers, with writes reaching
44 bytes past the end of cap_hdr's [64, 156) frame window into
adjacent stack redzones.

Fix by validating each buffer length against its destination field
size before copying, and returning -EINVAL if the firmware supplies
an oversized buffer.

Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Anirudh Prasad <icarus@a0rg.com>
---
 drivers/acpi/pfr_update.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 6283105bb0e8..e14e053cea44 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -158,6 +158,14 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr,
 		goto free_acpi_buffer;
 	}
 
+	if (out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length > sizeof(cap_hdr->code_type) ||
+	    out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length > sizeof(cap_hdr->drv_type) ||
+	    out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length > sizeof(cap_hdr->platform_id) ||
+	    out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length > sizeof(cap_hdr->oem_id)) {
+		ret = -EINVAL;
+		goto free_acpi_buffer;
+	}
+
 	cap_hdr->update_cap = out_obj->package.elements[CAP_UPDATE_IDX].integer.value;
 	memcpy(&cap_hdr->code_type,
 	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointer,
-- 
2.55.0


