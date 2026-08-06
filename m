Received: from sender-op-o14.zoho.in (sender-op-o14.zoho.in [103.117.158.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85230E0D6;
	Thu,  6 Aug 2026 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029436; cv=pass; b=Oq/n5uBp/h0DhNIgyt9di6yRjp//c5SLVhXILcaSXw2/eRFrexGQ7iAbKJgjZqbfoXcebCd+IuIzjMoS/BABhhVKbcBY+VR+LX19fLJn8/PDd7A+tHQe28q221bTn3uHxUJ1fzebZvaU4xIDAYhK9XN55SXeOjLdSQzOHyJx/eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029436; c=relaxed/simple;
	bh=Qhzyq3vBVbDH9v7Ok0XmtdGUCaOHCrmPbFFZYOP+VQQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Q20OPBBB1CXhugxMHuGoxdzdicOpJ5udKBySSAKZw3TviaFrEnqICI4/l4owwI8bJt6zOLto0+tViyNko1REa5K8d8JkYFPeWyAi4NTU2YF+Ig5d6MCjneSEh/nnFZs2ZygkEnsaKnbUyadZBWYutHocyn9+eY/vxOg3dip2bMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com; spf=pass smtp.mailfrom=a0rg.com; dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b=eGXk90Xs; arc=pass smtp.client-ip=103.117.158.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a0rg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b="eGXk90Xs"
ARC-Seal: i=1; a=rsa-sha256; t=1786029428; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=LFzw7p81Cxt1KPXLpgdTgq1ml2SXIell2md/KvCX+Is4ZG+CWSxRlfVJl4SN/JtMytu8FGV/nCwSzj33qKK/Qx0TNfYYZR1g3KS/NYpT+Km5BJ0hwxtYv0J2GhO4Qe9RK2jU8y0tEfjLDPGjfznnI65g/zOvatE0ZiFi2xJgeJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1786029428; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HBtRMe4r3wyhrvEPAawnN/a45MhtYc0r0R5r3Qi96sA=; 
	b=ehNStz2krUc++7XJs7F/dV8LiJZygiVLbb7HqrZ5ofR1rEEbo3OLoNmG8P6JFJojW5I4AdkW6lYjCCaqUiza2ZIyILO7zQOiXiPDeIdsD5IMZ3gV/6pN+7m0c5Wsto9nuhJBqMY3RlBvo76TBl2eJiF5jv5QyIJ+sZMtqQG+sMA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=a0rg.com;
	spf=pass  smtp.mailfrom=icarus@a0rg.com;
	dmarc=pass header.from=<icarus@a0rg.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786029428;
	s=zmail; d=a0rg.com; i=icarus@a0rg.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HBtRMe4r3wyhrvEPAawnN/a45MhtYc0r0R5r3Qi96sA=;
	b=eGXk90Xs+L94PpgZ+BACRSZNqSvnwBU8gd8VSCwGqbkUINam31kIh5rJorYV9PRk
	0yRScngOGi5wHqPaJjlP/FeSmgtFTo3jFYJFUMj79/qfKQpwKXCtBbo+jzvNkSuZVpc
	981NizHCrsgu9KZvTgD9+GKE4deUWzDhddg2HQdc=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1786029426639815.3097152056939; Thu, 6 Aug 2026 20:47:06 +0530 (IST)
Date: Thu, 06 Aug 2026 20:47:06 +0530
From: Anirudh Prasad <icarus@a0rg.com>
To: "linux-acpi" <linux-acpi@vger.kernel.org>
Cc: "rafaeljwysocki" <rafael.j.wysocki@intel.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"stable" <stable@vger.kernel.org>
Message-ID: <19fd7a647c3.1059430542637.572965728630481984@a0rg.com>
In-Reply-To: <19fd74e46a8.25f5bfd941182.5953196137231825269@a0rg.com>
References: <19fd74e46a8.25f5bfd941182.5953196137231825269@a0rg.com>
Subject: Re: [PATCH] ACPI: pfr_update: fix stack buffer overflow in
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

> If the firmware wants the kernel to copy more data than the latter has
> room for, the operation should fail instead of pretending to succeed.

Agreed. v2 validates all four buffer lengths upfront and returns
-EINVAL if any exceeds its destination field size.

---

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





From: Anirudh Prasad <icarus@a0rg.com>
To: "linux-acpi"<linux-acpi@vger.kernel.org>
Cc: "rafaeljwysocki"<rafael.j.wysocki@intel.com>, "linux-kernel"<linux-kernel@vger.kernel.org>, "stable"<stable@vger.kernel.org>
Date: Thu, 06 Aug 2026 19:10:59 +0530
Subject: [PATCH] ACPI: pfr_update: fix stack buffer overflow in query_capability()

 > query_capability() copies four ACPI buffer objects returned by the 
 > firmware _DSM into fixed-size u8[16] fields in struct 
 > pfru_update_cap_info using memcpy with the firmware-supplied length: 
 >  
 >  memcpy(&cap_hdr->code_type, 
 >  elements[CAP_CODE_TYPE_IDX].buffer.pointer, 
 >  elements[CAP_CODE_TYPE_IDX].buffer.length); 
 >  
 > The same pattern repeats for drv_type, platform_id, and oem_id. 
 > If the firmware returns buffer.length > 16 for any of these fields, 
 > memcpy writes past the destination array. 
 >  
 > struct pfru_update_cap_info is stack-allocated in pfru_ioctl(). 
 > Confirmed with KASAN on 7.2-rc6: three stack-out-of-bounds reports 
 > are generated when a DSM returns 64-byte buffers, with writes reaching 
 > 44 bytes past the end of cap_hdr's [64, 156) frame window into 
 > adjacent stack redzones. 
 >  
 > Fix by clamping each memcpy length to the size of its destination 
 > field with min_t(u32, buffer.length, sizeof(cap_hdr->field)). 
 >  
 > Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver") 
 > Cc: stable@vger.kernel.org 
 > Signed-off-by: Anirudh Prasad <icarus@a0rg.com> 
 > --- 
 >  drivers/acpi/pfr_update.c | 12 ++++++++---- 
 >  1 file changed, 8 insertions(+), 4 deletions(-) 
 >  
 > diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c 
 > index 6283105bb0e8..0219347cd78f 100644 
 > --- a/drivers/acpi/pfr_update.c 
 > +++ b/drivers/acpi/pfr_update.c 
 > @@ -161,24 +161,28 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr, 
 >      cap_hdr->update_cap = out_obj->package.elements[CAP_UPDATE_IDX].integer.value; 
 >      memcpy(&cap_hdr->code_type, 
 >             out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointer, 
 > -           out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length); 
 > +           min_t(u32, out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length, 
 > +             sizeof(cap_hdr->code_type))); 
 >      cap_hdr->fw_version = 
 >          out_obj->package.elements[CAP_FW_VER_IDX].integer.value; 
 >      cap_hdr->code_rt_version = 
 >          out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.value; 
 >      memcpy(&cap_hdr->drv_type, 
 >             out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer, 
 > -           out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length); 
 > +           min_t(u32, out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length, 
 > +             sizeof(cap_hdr->drv_type))); 
 >      cap_hdr->drv_rt_version = 
 >          out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.value; 
 >      cap_hdr->drv_svn = 
 >          out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value; 
 >      memcpy(&cap_hdr->platform_id, 
 >             out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer, 
 > -           out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length); 
 > +           min_t(u32, out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length, 
 > +             sizeof(cap_hdr->platform_id))); 
 >      memcpy(&cap_hdr->oem_id, 
 >             out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer, 
 > -           out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length); 
 > +           min_t(u32, out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length, 
 > +             sizeof(cap_hdr->oem_id))); 
 >      cap_hdr->oem_info_len = 
 >          out_obj->package.elements[CAP_OEM_INFO_IDX].buffer.length; 
 >  
 > -- 
 > 2.55.0 
 > 

