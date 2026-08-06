Received: from sender-op-o14.zoho.in (sender-op-o14.zoho.in [103.117.158.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96736894B
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023690; cv=pass; b=bKotKbnCjfCclprXgr1sZZt7psmOJnnB8JxO09bXq6QFQj+J46Z5tSAMuPjSi+1zsjBV+W0nX3YNa97O9X08QcRKZs+Bm99VNO92oMzsyczBrY8YBOjPcTrlOZc83i08Rw54cBARxHi/ScihXr/cbVeRfFMkNyOuGq2xKBRlzCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023690; c=relaxed/simple;
	bh=AJ+U+u8Uv9hQcQnkdYn24MvKrMfdDEjLM+I+luzS3E0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=hufgwFVZpUYoqsU9F6PtPVfAzPov761YDpFY/ZGB4/vGyyFkrGPto6cEDH2yKNXaGIkWYpigzr1kKGVze7MfMVU9ofyPtEe5ytgMA5BN5L0AU9YO+j3YBtb431ztVSOfBYzNua4x1Iea/IkgF8vlQGcA79huIfoOyxwoimqlmG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com; spf=pass smtp.mailfrom=a0rg.com; dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b=J9Oy3mNV; arc=pass smtp.client-ip=103.117.158.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a0rg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b="J9Oy3mNV"
ARC-Seal: i=1; a=rsa-sha256; t=1786023660; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=ANs6EIpMMwOUEWuhx1bhPh4ULB/hfcdnTftymzpw1TTiIy1iQ8SsLPd2N6QXhiAAfPjP0i8yElOIzXoIWgJBMLNdFfb4Qlbtp/kzZ62ucuEwa+76sqAg2jOhNsCG8EYhUFRnR3mmtrzQmE6ZsdzZ/DsYpIrXiy+BEKwfM1W6kaE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1786023660; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RNrf8XA0aLcTC5gGLRtcrxtQybjxP214KmJXq6p0+iw=; 
	b=VdUBA8TT3EsJSJ7QPjpK8efINR2T4EhoJNtk6/ULt0Z4IX/quhCjEL655TkYRIJqvI7+zrv6QOOcLyTIhHsaZp3ZRWLCJZN6JG0yVqvdQ/DUPmznVqFn9KZ2Kn8cjjruOiF7UO6k86C407Q09sTGEEY0fjTO282TydgLqZi6OEc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=a0rg.com;
	spf=pass  smtp.mailfrom=icarus@a0rg.com;
	dmarc=pass header.from=<icarus@a0rg.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786023660;
	s=zmail; d=a0rg.com; i=icarus@a0rg.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RNrf8XA0aLcTC5gGLRtcrxtQybjxP214KmJXq6p0+iw=;
	b=J9Oy3mNVvB0LbaiG8jDymqMh0q6yMVUvTPopQOZW6uI9Jba889guX6ZS+RxHOUZA
	/L/L+EZMQFITawRxDicsVFDLxiu5jA+5EBn/6wp0bL54yzFqw/x3kzGlHEu9L3b+uBE
	mZkL9wQmBYU6ZXsYK1NwmyQUy10xXbG1AH5rwX2U=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1786023659188155.00129407899828; Thu, 6 Aug 2026 19:10:59 +0530 (IST)
Date: Thu, 06 Aug 2026 19:10:59 +0530
From: Anirudh Prasad <icarus@a0rg.com>
To: "linux-acpi" <linux-acpi@vger.kernel.org>
Cc: "rafaeljwysocki" <rafael.j.wysocki@intel.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"stable" <stable@vger.kernel.org>
Message-ID: <19fd74e46a8.25f5bfd941182.5953196137231825269@a0rg.com>
In-Reply-To: 
Subject: [PATCH] ACPI: pfr_update: fix stack buffer overflow in
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

Fix by clamping each memcpy length to the size of its destination
field with min_t(u32, buffer.length, sizeof(cap_hdr->field)).

Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Anirudh Prasad <icarus@a0rg.com>
---
 drivers/acpi/pfr_update.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 6283105bb0e8..0219347cd78f 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -161,24 +161,28 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr,
 	cap_hdr->update_cap = out_obj->package.elements[CAP_UPDATE_IDX].integer.value;
 	memcpy(&cap_hdr->code_type,
 	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointer,
-	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length);
+	       min_t(u32, out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length,
+		     sizeof(cap_hdr->code_type)));
 	cap_hdr->fw_version =
 		out_obj->package.elements[CAP_FW_VER_IDX].integer.value;
 	cap_hdr->code_rt_version =
 		out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.value;
 	memcpy(&cap_hdr->drv_type,
 	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer,
-	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length);
+	       min_t(u32, out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length,
+		     sizeof(cap_hdr->drv_type)));
 	cap_hdr->drv_rt_version =
 		out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.value;
 	cap_hdr->drv_svn =
 		out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value;
 	memcpy(&cap_hdr->platform_id,
 	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer,
-	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length);
+	       min_t(u32, out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length,
+		     sizeof(cap_hdr->platform_id)));
 	memcpy(&cap_hdr->oem_id,
 	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer,
-	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length);
+	       min_t(u32, out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length,
+		     sizeof(cap_hdr->oem_id)));
 	cap_hdr->oem_info_len =
 		out_obj->package.elements[CAP_OEM_INFO_IDX].buffer.length;
 
-- 
2.55.0
