Received: from sender-op-o12.zoho.in (sender-op-o12.zoho.in [103.117.158.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC9330301;
	Thu, 13 Aug 2026 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605091; cv=pass; b=jrwK6eBJprznpLaDpucRxB8tG7qfcVIWLEBXd5M0uorPHSdIOkuIInI1BKxd58xudLGTnNcutxhulGv4i3suOG8+KTg+roFTdrwd4uKhFlcbnagN6A9E7R1mQM2jNzetxDVhJrXJJdOfy+I0cABpYr9QWQ5iKsWe2f8cNRIIww4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605091; c=relaxed/simple;
	bh=fZ5C6Nrevz/tCw1/yt/+lBfnDv9QmTE/ijkt9cbd5o8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=f3yUh9iy1P8qN3RmquX9Nv2JUDqGz9oXLO3+gO5ccMZpzaoRiP+pz3d4vcp/G1n2cB7ARormuxA/IyOfyjZPE3V1ySe6x4NFpjrlkqGJfVaSsGywXuABpXpDjfiBxLCi4Fg16g4QgBJJp8Y/Rr4gLcc171N1A4dH8//K4+tDwug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com; spf=pass smtp.mailfrom=a0rg.com; dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b=WmYDGEdv; arc=pass smtp.client-ip=103.117.158.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a0rg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a0rg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=a0rg.com header.i=icarus@a0rg.com header.b="WmYDGEdv"
ARC-Seal: i=1; a=rsa-sha256; t=1786605079; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=Z+EoJXsXtVQIORsJ3sZcuxDW8YpVtJb0X3XcblUegb8KbfcbNhxXs/ZxdRSRS4qfKO3vI6Jd794kf4ZGXQHQ3+0kScIXPu87ApXvTsMKoSUlt4Jag9ncptQfbPjbVdcjOa5yNUEF2nkCfaezOf8/LIQgePWYDzQ9ptNje+wbI4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1786605079; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=96OEejPnQuneKnEwTCECyecmPPt751F4H3Yz7DeCxaQ=; 
	b=RzdZQa3MJKcimUPA5rUDMz9ShXmZlRMpw3toUpvpgSQgWiGKq9TpmOTJBe34CLnIt2cYl40edNIGjxHCXXL8Bz79XfrNIejSnu0hnSyFqaKLaz3l4VsKqnHOVVetzaZzE4g0V9OG0Y9j2PDNXxpHhy+6opg6LzmNyKLkFvkHZP4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=a0rg.com;
	spf=pass  smtp.mailfrom=icarus@a0rg.com;
	dmarc=pass header.from=<icarus@a0rg.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786605079;
	s=zmail; d=a0rg.com; i=icarus@a0rg.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=96OEejPnQuneKnEwTCECyecmPPt751F4H3Yz7DeCxaQ=;
	b=WmYDGEdvQ0zmNveryW++ZWIpljRMzCUuqszYR/PSrALGDh5B1jkaOeXNK2hZU7ee
	pWUOUMiBW7ICO6s5RRvGQ7Jun/khnUXUYWQDqDWKle3YpJ8B1xIo3haCu/qssxg/3U1
	yhetwMg6cMrGq6QiCsnc0ms+RNuFvzEQ+HREUJK8=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1786605076030512.6942028504891; Thu, 13 Aug 2026 12:41:16 +0530 (IST)
Date: Thu, 13 Aug 2026 12:41:15 +0530
From: Anirudh Prasad <icarus@a0rg.com>
To: "linux-acpi" <linux-acpi@vger.kernel.org>
Cc: "rafaeljwysocki" <rafael.j.wysocki@intel.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"stable" <stable@vger.kernel.org>
Message-ID: <19ff9f5fe16.152015f52867129.231910284877135436@a0rg.com>
In-Reply-To: <19fdcf5017a.193154c01134335.5292960934110253862@a0rg.com>
References: <19fdcf5017a.193154c01134335.5292960934110253862@a0rg.com>
Subject: Re: [PATCH v3] ACPI: pfr_update: fix stack buffer overflow in
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

Hi, just gently nudging this. Thanks!


From: Anirudh Prasad <icarus@a0rg.com>
To: "linux-acpi"<linux-acpi@vger.kernel.org>
Cc: "rafaeljwysocki"<rafael.j.wysocki@intel.com>, "linux-kernel"<linux-kernel@vger.kernel.org>, "stable"<stable@vger.kernel.org>
Date: Fri, 07 Aug 2026 21:31:12 +0530
Subject: [PATCH v3] ACPI: pfr_update: fix stack buffer overflow in query_capability()

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
 > Introduce a helper pointer to out_obj->package.elements and use it 
 > to validate each buffer length against its destination field size 
 > before copying, returning -EINVAL if the firmware supplies an 
 > oversized buffer. 
 >  
 > Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver") 
 > Cc: stable@vger.kernel.org 
 > Signed-off-by: Anirudh Prasad <icarus@a0rg.com> 
 > --- 
 >  drivers/acpi/pfr_update.c | 47 ++++++++++++++++++++++----------------- 
 >  1 file changed, 26 insertions(+), 21 deletions(-) 
 >  
 > diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c 
 > index 6283105bb0e8..79cedd4cf2a2 100644 
 > --- a/drivers/acpi/pfr_update.c 
 > +++ b/drivers/acpi/pfr_update.c 
 > @@ -120,7 +120,7 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr, 
 >                  struct pfru_device *pfru_dev) 
 >  { 
 >      acpi_handle handle = ACPI_HANDLE(pfru_dev->parent_dev); 
 > -    union acpi_object *out_obj; 
 > +    union acpi_object *out_obj, *elem; 
 >      int ret = -EINVAL; 
 >  
 >      out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid, 
 > @@ -150,7 +150,9 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr, 
 >          goto free_acpi_buffer; 
 >      } 
 >  
 > -    cap_hdr->status = out_obj->package.elements[CAP_STATUS_IDX].integer.value; 
 > +    elem = out_obj->package.elements; 
 > + 
 > +    cap_hdr->status = elem[CAP_STATUS_IDX].integer.value; 
 >      if (cap_hdr->status != DSM_SUCCEED) { 
 >          ret = -EBUSY; 
 >          dev_dbg(pfru_dev->parent_dev, "Query cap Error Status:%d\n", 
 > @@ -158,29 +160,32 @@ static int query_capability(struct pfru_update_cap_info *cap_hdr, 
 >          goto free_acpi_buffer; 
 >      } 
 >  
 > -    cap_hdr->update_cap = out_obj->package.elements[CAP_UPDATE_IDX].integer.value; 
 > +    if (elem[CAP_CODE_TYPE_IDX].buffer.length > sizeof(cap_hdr->code_type) || 
 > +        elem[CAP_DRV_TYPE_IDX].buffer.length > sizeof(cap_hdr->drv_type) || 
 > +        elem[CAP_PLAT_ID_IDX].buffer.length > sizeof(cap_hdr->platform_id) || 
 > +        elem[CAP_OEM_ID_IDX].buffer.length > sizeof(cap_hdr->oem_id)) { 
 > +        ret = -EINVAL; 
 > +        goto free_acpi_buffer; 
 > +    } 
 > + 
 > +    cap_hdr->update_cap = elem[CAP_UPDATE_IDX].integer.value; 
 >      memcpy(&cap_hdr->code_type, 
 > -           out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointer, 
 > -           out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length); 
 > -    cap_hdr->fw_version = 
 > -        out_obj->package.elements[CAP_FW_VER_IDX].integer.value; 
 > -    cap_hdr->code_rt_version = 
 > -        out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.value; 
 > +           elem[CAP_CODE_TYPE_IDX].buffer.pointer, 
 > +           elem[CAP_CODE_TYPE_IDX].buffer.length); 
 > +    cap_hdr->fw_version = elem[CAP_FW_VER_IDX].integer.value; 
 > +    cap_hdr->code_rt_version = elem[CAP_CODE_RT_VER_IDX].integer.value; 
 >      memcpy(&cap_hdr->drv_type, 
 > -           out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer, 
 > -           out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length); 
 > -    cap_hdr->drv_rt_version = 
 > -        out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.value; 
 > -    cap_hdr->drv_svn = 
 > -        out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value; 
 > +           elem[CAP_DRV_TYPE_IDX].buffer.pointer, 
 > +           elem[CAP_DRV_TYPE_IDX].buffer.length); 
 > +    cap_hdr->drv_rt_version = elem[CAP_DRV_RT_VER_IDX].integer.value; 
 > +    cap_hdr->drv_svn = elem[CAP_DRV_SVN_IDX].integer.value; 
 >      memcpy(&cap_hdr->platform_id, 
 > -           out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer, 
 > -           out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length); 
 > +           elem[CAP_PLAT_ID_IDX].buffer.pointer, 
 > +           elem[CAP_PLAT_ID_IDX].buffer.length); 
 >      memcpy(&cap_hdr->oem_id, 
 > -           out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer, 
 > -           out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length); 
 > -    cap_hdr->oem_info_len = 
 > -        out_obj->package.elements[CAP_OEM_INFO_IDX].buffer.length; 
 > +           elem[CAP_OEM_ID_IDX].buffer.pointer, 
 > +           elem[CAP_OEM_ID_IDX].buffer.length); 
 > +    cap_hdr->oem_info_len = elem[CAP_OEM_INFO_IDX].buffer.length; 
 >  
 >      ret = 0; 
 >  
 > -- 
 > 2.55.0 
 >  
 > 
