Received: from sender-op-o12.zoho.in (sender-op-o12.zoho.in [103.117.158.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB2272E6D;
	Fri,  7 Aug 2026 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118481; cv=pass; b=Rh+y7zqccrLcitrQeBTIaZWw+hEQdCpPCr2v/5SkkfXa+PlLrJgXMmdfH4hshPdl96uFQ+CKQRuSEuBelpC83T4tw4wMc2xSaqb5Jy5PGNYT6qdCcsxyAV1t1nlUJOeOEZlJROOyFXzgmedSNyq7k3zF/QYfXIKx2v4awWKTJXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118481; c=relaxed/simple;
	bh=CbqLFC/ynbutdqdRVJ2+rQRSfK3vUOzv00+iyCVRgjo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=HkO1sXvnFw5h7AzZ17IokEFXnF/Oi59H5J9NV6PnfBjw+NiLKc/jP2mE5erv15E9ow7H49GNfW5UCvqAF+7s+E3ucRWkBNikxs3YBJL9cl++b9yLmODS3eGy/XX2vx0RAgtoDIgY8NAD3SEzC218PV3kOJAei389+F3Xn9OPSFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com; spf=pass smtp.mailfrom=a0rg.com; dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b=KGDeWrx5; arc=pass smtp.client-ip=103.117.158.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a0rg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b="KGDeWrx5"
ARC-Seal: i=1; a=rsa-sha256; t=1786118473; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=By3+RgZGDGzlwNZQ1PR79PBU4TfUXk+wYkOB1LqYqJV9WS/piyOkJOotintp5AMxp6z93oR3JJQmgqsvv0EXZci4QKDwRtePkYsTDXDoqwRvHrCQNpJogk2kC09hvdOuF2qe8a78t3Z/L2q9IRDwwz5XM62aD0uzCrubaeZZ8Jc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1786118473; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+5mHdVOL3AsTDSQ9gEwxTbj3Od1NhwaFahkb0yG5B8Q=; 
	b=Yo6AnU9I0N0HdyIgWW9DvKz2kpZ3qZdunzhOcLk7jNoFjA/vt5mXnTVOXFOtDIybsdhYXMckyeIuwzbSN30wfmVyJs6z8Hlj7E7xlmyoNCZsYRxDdhRta9y5vO6qmvGBcW7WmyvD0bfWLNOXyQ1GRQShOOHl3vDrec9zWj2pYKo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=a0rg.com;
	spf=pass  smtp.mailfrom=icarus@a0rg.com;
	dmarc=pass header.from=<icarus@a0rg.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786118473;
	s=zmail; d=a0rg.com; i=icarus@a0rg.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+5mHdVOL3AsTDSQ9gEwxTbj3Od1NhwaFahkb0yG5B8Q=;
	b=KGDeWrx5Gwgns7iSmBvnLS0SyH+o9tkcyraIYZ0FiMNEAcCwb5hTNkBicfdWku9n
	LPZv7jCKjvsAXZjiZSfbpY9GX7oTU38MlNri5WMmdCOD6goUuIIFALY6DrHfp5XbDVM
	vypS97ylvAmMj0LAmb4/SOkKrmxhu+4RzW8uUKiY=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1786118472101387.84855302587425; Fri, 7 Aug 2026 21:31:12 +0530 (IST)
Date: Fri, 07 Aug 2026 21:31:12 +0530
From: Anirudh Prasad <icarus@a0rg.com>
To: "linux-acpi" <linux-acpi@vger.kernel.org>
Cc: "rafaeljwysocki" <rafael.j.wysocki@intel.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"stable" <stable@vger.kernel.org>
Message-ID: <19fdcf5017a.193154c01134335.5292960934110253862@a0rg.com>
In-Reply-To: 
Subject: [PATCH v3] ACPI: pfr_update: fix stack buffer overflow in
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

Introduce a helper pointer to out_obj->package.elements and use it
to validate each buffer length against its destination field size
before copying, returning -EINVAL if the firmware supplies an
oversized buffer.

Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Anirudh Prasad <icarus@a0rg.com>
---
 drivers/acpi/pfr_update.c | 47 ++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 6283105bb0e8..79cedd4cf2a2 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -120,7 +120,7 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr,
 			    struct pfru_device *pfru_dev)
 {
 	acpi_handle handle = ACPI_HANDLE(pfru_dev->parent_dev);
-	union acpi_object *out_obj;
+	union acpi_object *out_obj, *elem;
 	int ret = -EINVAL;
 
 	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
@@ -150,7 +150,9 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr,
 		goto free_acpi_buffer;
 	}
 
-	cap_hdr->status = out_obj->package.elements[CAP_STATUS_IDX].integer.value;
+	elem = out_obj->package.elements;
+
+	cap_hdr->status = elem[CAP_STATUS_IDX].integer.value;
 	if (cap_hdr->status != DSM_SUCCEED) {
 		ret = -EBUSY;
 		dev_dbg(pfru_dev->parent_dev, "Query cap Error Status:%d\n",
@@ -158,29 +160,32 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr,
 		goto free_acpi_buffer;
 	}
 
-	cap_hdr->update_cap = out_obj->package.elements[CAP_UPDATE_IDX].integer.value;
+	if (elem[CAP_CODE_TYPE_IDX].buffer.length > sizeof(cap_hdr->code_type) ||
+	    elem[CAP_DRV_TYPE_IDX].buffer.length > sizeof(cap_hdr->drv_type) ||
+	    elem[CAP_PLAT_ID_IDX].buffer.length > sizeof(cap_hdr->platform_id) ||
+	    elem[CAP_OEM_ID_IDX].buffer.length > sizeof(cap_hdr->oem_id)) {
+		ret = -EINVAL;
+		goto free_acpi_buffer;
+	}
+
+	cap_hdr->update_cap = elem[CAP_UPDATE_IDX].integer.value;
 	memcpy(&cap_hdr->code_type,
-	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointer,
-	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length);
-	cap_hdr->fw_version =
-		out_obj->package.elements[CAP_FW_VER_IDX].integer.value;
-	cap_hdr->code_rt_version =
-		out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.value;
+	       elem[CAP_CODE_TYPE_IDX].buffer.pointer,
+	       elem[CAP_CODE_TYPE_IDX].buffer.length);
+	cap_hdr->fw_version = elem[CAP_FW_VER_IDX].integer.value;
+	cap_hdr->code_rt_version = elem[CAP_CODE_RT_VER_IDX].integer.value;
 	memcpy(&cap_hdr->drv_type,
-	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer,
-	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length);
-	cap_hdr->drv_rt_version =
-		out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.value;
-	cap_hdr->drv_svn =
-		out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value;
+	       elem[CAP_DRV_TYPE_IDX].buffer.pointer,
+	       elem[CAP_DRV_TYPE_IDX].buffer.length);
+	cap_hdr->drv_rt_version = elem[CAP_DRV_RT_VER_IDX].integer.value;
+	cap_hdr->drv_svn = elem[CAP_DRV_SVN_IDX].integer.value;
 	memcpy(&cap_hdr->platform_id,
-	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer,
-	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length);
+	       elem[CAP_PLAT_ID_IDX].buffer.pointer,
+	       elem[CAP_PLAT_ID_IDX].buffer.length);
 	memcpy(&cap_hdr->oem_id,
-	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer,
-	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length);
-	cap_hdr->oem_info_len =
-		out_obj->package.elements[CAP_OEM_INFO_IDX].buffer.length;
+	       elem[CAP_OEM_ID_IDX].buffer.pointer,
+	       elem[CAP_OEM_ID_IDX].buffer.length);
+	cap_hdr->oem_info_len = elem[CAP_OEM_INFO_IDX].buffer.length;
 
 	ret = 0;
 
-- 
2.55.0

