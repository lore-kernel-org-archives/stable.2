Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474658;
	b=HgOp1UNibHZf/OSS33xZ27XHOrAmOGPSnU4qMutm34vMjux54r+25oDfncY80Zzkm7+4
	 Zbzymxz2Owqdz3wczCB4fX4F2L7/11/n5TMFRF8DBa2p489z0EYwH9OIyVjhYzb+kJ7R4
	 ue0AIQFEap/+gOXJAEyGja7lYCfL/o91h8AOXkIcuqT3+d9YWXuNk4I5Y+1cAI2hb5h7H
	 IqGAPjKtHosprcyj7tMyfyzRHGePJwcgYhYFWfiSk7X3A0dJLmTBNbdtYHAQ/gRz8EjgO
	 KJNOmo7qE6/1AcNlnPSv5Fv9KTtt3VCOl4t8obxJOZzw7XKQvzf1FLmA7m+do/7ekUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474658;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=kL5yNFxOQr1bNwj2yp9xsvwd7EvfVdlHCAwOgWjtFQ8=;
	b=PTLeOY3QDrBLrZlxpZJx/bPgn03zEqpPTZicBQcnb4evXaK0e71CweK/pcxDBhlUTD/u
	 PXLzQzw+psey1/VMO5z+y1DbmoSYLinXPORLlMcL4+jAHn9g1ljiMGjTn3ho4jF/MXJCB
	 BJGTxdPJWlkBBxgkwfPPEke2NTmJWjIh30mQPtFyIML7J1juC96f87lhmMjcbclJtXhWq
	 qCiT/3Y0Cx40NPFT5mcQ0rwQctWRp0QISgnPgjxa7PYmY1OszNKPO4fu+aAOHusN9wPl7
	 1fl+DUlo3vOwhFoWMZAV3Mhxi7upAwQSJs8zTNBhtQEGPmE1D+FVtS68C6T1PyydHeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=F8Is5QRG;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E162606A31C;
	Thu, 12 Nov 2026 09:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E162606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=F8Is5QRG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794474612;
	bh=kL5yNFxOQr1bNwj2yp9xsvwd7EvfVdlHCAwOgWjtFQ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=F8Is5QRGRArslT0hQqs17+XCYi0XDx8/8CkFCti4JQVvG38wgGUX5j/QelAP40pdd
	 Y94psaF1g5cgAQKo7UYaWm/xQclNCD9K/jdJvSk+1ky71HcdScColWSFNesdFld3HF
	 ldO6dJBLI97Celqvk2R9VmG05yJdsiibTLNBsk5M=
X-QQ-mid: esmtpgz11t1794474596t6e10af42
X-QQ-Originating-IP: Ia2ZFIUMrwIr2+SQEeFPwzme45b8gAUcBlQNMeYD3iY=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Nov 2026 17:09:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5409456588328214645
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	sakari.ailus@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: property: Fix leaked buffers after skipped properties
Date: Thu, 12 Nov 2026 17:09:54 +0800
Message-ID: <DC796DD7AB1437C8+20261112090954.1388267-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MdX6KBrQ9NyucedZzOI13e4aPRB5YJmtlC4eAyT55xPct3WOATXmnaaO
	16DLlehhi7M/gaKIloyNAZfvV8e4xf7/22ca21JXvXz+0Lll5DbcdSuFpR2wt/PuzMKYKLK
	8OW+OUj5k0l3Is+xVkHKvXKEufAHO/JwbJOUCz6BiWcVgF1kGCQVdf7Z/9WmAP66O7OMt4S
	9XoMVFVO5oXuE6O6cyzDBT9Py0OYL36hkI7KpkQP4Bmd2xk/covkbbpx7wreMmX4h5QLQHA
	Ebj/GAT1b+C74Lbkqj+5/970gJB1YRsSJGHspurTL8gwva9pBi6vkgK6F3iu9a0i0ceCF35
	MVkw1eG8Z263Y8S4bM813oSzslE9tT2cdJW3auhOalICe46guFs1qKg2bwRDdDQ21Ftt5/E
	oC4CYe/SXKnA6eR5nmMiWvAWlTYshq6Q7/iVcmijh1uKji6YVkQvkV0DQ2yW9a74L+zepLQ
	H5IAdhh7gAgByA4UAFcSe0lAxWMZUsUDUArFypW+CFwghJKyWKnN5kvQtzRpynGnnE9JUMv
	7zcFewo3Yr8flbUcw1k35M/CpGi7VODW8Qriqf+zdzTzXHVNvL77MzZPjruku3mMikdZ85W
	XaA6zZD57zl9ppT5yxLBeffBplrRMBbALzuT0P2gm91x3jk3cyHt+hLQaeGbupZMxUJPPfW
	12k6yEshIYrHt55KuLWAr0r/aRCxX4wgzDoOmpIjiLaUwZvKpMWLhm3HwUtGcmwctDoYRmf
	QppvN31WnS2Gt3NDxteKxo9TyDRR6GiEXWTaYo6MI1Tpr5CLNf5KDAjTBrR7Vvol+h64Zrs
	jN18JcpX49f0JBti2G6x9b7QR5gfPIFrYVJke7IWUSjpCb8Wr9ypsqTwkWJADR4L3qAt/aA
	d1JmnsjLZ+4TiVJwt/mc/Ojq9NsJPcxyU4G2PEDkpBD4gu387yNnAew5T1XN8RCGZ8jEpCI
	WPEPW/MmciuuyZRpDyxT4JuUY5VjdTnwQe0VQpYZyQ5owRaDxPGNL3qOVsp8dXOdHyeYeF7
	K2J7M61IuamIc+oGojUStzrBXvmi/bL2qZu2jO6hV7ZcHENtoXTo+ixisrAtY=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

acpi_data_add_buffer_props() compacts successfully parsed buffer
properties into an output package, but stores their separately allocated
evaluation buffers in props->bufs using the original input index.
acpi_free_device_properties() only frees entries below the output
package's successful-property count.

If a property is skipped because of an invalid format, invalid types or
a failed object evaluation, later successful entries can be stored past
the range visited during cleanup. For example, a failed first entry and
a successful second entry leave the allocation in bufs[1] while cleanup
only visits bufs[0]. The evaluation buffer is then leaked when the
properties are destroyed. Lists with no skipped entries do not exhibit
this mismatch.

Store each evaluation buffer at the current output count before
incrementing it. This keeps the ownership array compact and aligned with
the cleanup bound without changing property order or buffer contents.

Fixes: 103e10c69c61 ("ACPI: property: Add support for parsing buffer property UUID")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8ee5a1f0eb48..fb6b214f2335 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -523,7 +523,7 @@ static void acpi_data_add_buffer_props(acpi_handle handle,
 		obj->buffer.length = buf_obj->buffer.length;
 		obj->buffer.pointer = buf_obj->buffer.pointer;

-		props->bufs[i] = buf.pointer;
+		props->bufs[*count] = buf.pointer;
 		package++;
 		(*count)++;
 	}
--
2.50.1

