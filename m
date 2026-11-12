Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475200;
	b=bU1xnZZ5AkPBVxiOVt6tAwWspbVVBl8EmN1yBhrt8pd9Mo26NOee3i5wavnY47hbopMn
	 lVDQznny4izBrgSXWq7LOxbu8NLhbdUq1soI7v6Qwe/isiEjPIH8l9VtUxI1GWtWUwyfa
	 VWmQgZlNlxvSocC4/z+YCT9KTFmv5VEXsMHLicurh/vpi2IPxoAb01fjF23B05toYLWCR
	 zXFwHTkAbBTttIkTe2SbJPjcoYahqn+JwdD0FRuNjwlNTd3+3PKjIMfDFAOIiohw1/2ea
	 ps3nWOYJaNNJ/g2tlum490KM2uYby1VRjyF7HXxyuB/XmD4vyyTYzRSYsl0VQf512lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475200;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=5wHJHaXQBa1716W1dMoYWa0PbRnI7INut6Puhlu3wnY=;
	b=we7yodpAYDqm7JkwIe7Zbm51ZpjiqBd8vh2sg2PE2KsM8vB/m4UOpmkkBEZzI4a0iP5H
	 GDfMFl/WB4iQVfnBY/U0Y403/K2M9tvTiZvTBVbcGy8gUAllS4KRo9vRu8Hk9UUNbIxVN
	 +NSvUp42HwK/6xHgEf8Zv+xzvje9i3oVKtis80EUiPFVoko+Z7CiwGqgNWVaiVVM4HT0/
	 5hFIlgNaWQSd4BfTLIcY9MiowYb+HX2/G2y9XpQBh7GAoU3uj6/h+L2l/s/RLizORRtyB
	 oCG3S+4Cu9eeQgMDfGfWJzF3S4UeDxFhujnCflEyFlHIoaU2IwklL1jBINct04fLDRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Zw8yRxXN;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719D606A32D;
	Thu, 12 Nov 2026 09:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6719D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Zw8yRxXN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794475183;
	bh=5wHJHaXQBa1716W1dMoYWa0PbRnI7INut6Puhlu3wnY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Zw8yRxXNbPbTKfhzXcBCM/KNG7q8pId8ZZMWSXFGp1zvmFDlK9600Dv7THXsHb127
	 LC2ER29fhjmIWi9zWUmvA0tutVjkgFIvYNzTBsmRRP1WdZyOHi3Y0ZfXDxl0ikWfVI
	 E2ljBo8d/T7ujkpU+ire0DGWbhkt6woKUjhK737A=
X-QQ-mid: zesmtpsz7t1794475177te7180ca5
X-QQ-Originating-IP: ge1uDlrwCAGPqmU36gNC2yLFw/hg8wdzYiyNV0mMeHU=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Nov 2026 17:19:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9293025895918087849
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: property: Do not free embedded subnode packages
Date: Thu, 12 Nov 2026 17:19:35 +0800
Message-ID: <1D6D9530A62ECE64+20261112091935.1394634-1-raoxu@uniontech.com>
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
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M7sWA1GV8vClC61usY7OM+X70fPDrGhh9vvaeM+KxEC4esoo9UoAo4dn
	oNq/uQVLs2S/S5PYtcUpLfsP3xCK8pmdF3Jw0M52rZBRJe3NEdgggnAejz99RC4lQpuz5PO
	0BdiBn8BaIj2oD/NFsd3PmmsCpFApFQ8LJBQShPrDUx+D6yI6t9WRoC8cMTtZdVel5dQaH1
	NlfPIBAvbgAdPZM0cGYByzTGrH29edQoDXk/AGQSX+Ci0VV4IvjkBjfJKD4wmPIQ9N3l5yr
	9k5wb16vdGDCmsCIjM1LwPLTMAD2XqS8eNYJWNwgV84VFP6wgEg9TLNaKVBYiUNMJV8amRq
	cFC9UMztdfqm5rfL/RCm14X56K3JJyyX0aGRtvlDlXJYDtAy0HpS1e+AWziXB4XyqLeJtCL
	lnDhlhS5fctXng4m3ZUZ3IBtcNmkdHS/HgESe9dRfL57nZOHUaZr09/3pLeajW2idl5PhYc
	MLG2T37+rE0pqIRyI8wAeAn7cSxt/EFD2urHySQ/foX+uRnLIHBWblJfwvQ88k9SLEiT0FB
	g5pmflWHvnUUjYjT3kjfhqCP+KF0XuixK3ovIbYv1rZ5mduWIryB9kaYj0NE2NqzOlDllmS
	5ewgT5lGx7EQp3thsx4xHf7hGM30atXbAMtzZN6dzAsiNmiuUVHq/Hh5HLorv/MyluXRUR7
	NH9FhN9H1BV/qqQ3zEoI+fjYqRDYMvaEQr4eBDpmLR3FIC+wDjS2Sdcx01Kpoz7xNjGVaA2
	ILybJOQoV6vPL14IZV3wPY57broWwsFYR3BVyhzn+q7raS5uxkQfoaHsEedJ8oK+7yq8CMI
	ByAVyQ/0KC/NgVnifynxZqiocQWWyKwi5ni89khFikp81J7URHOadTZobuH7TnN2Uc3L5FO
	T5MWCxNFW0hmJsq/xiSSRGrlq9c5kdoTFS5gl3O+Vm/RPzEhoXomKjiAyI5ujlAWXqyTjzu
	nGZUW8qurXdv5rjs7yuLF485hClwDiG/LI3aJWKIErYhyAzKt/TeA47kGbXfK586ljSvZ++
	OGZSXfbvl6Vq+kbRachM4rk6sj9joSJeVP/iAP2JZ9IpRpJgV6I2rD5qFFaoLccmPlIndB8
	LZBRCGm/YGZvC5GvSUlDx3PYKbNGLzae5P4YHJJHbZj
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The _DSD data-subnode parser accepts both named-object paths and packages
embedded in an enclosing evaluation result. For a named-object path,
acpi_nondev_subnode_ok() evaluates the object into a separate buffer and
passes its handle to acpi_nondev_subnode_extract(). For an embedded
package, acpi_add_nondev_subnodes() passes an interior pointer into the
enclosing result and a NULL handle instead.

acpi_destroy_nondev_subnodes() unconditionally frees dn->data.pointer
in both cases. Unloading an SSDT with embedded data subnodes therefore
attempts to free an interior address, as reported by KASAN. Subnodes
created exclusively from named-object paths do not have this problem.

Only free a subnode's result buffer when dn->handle is non-NULL. Embedded
packages are owned by the enclosing evaluation result, which is freed
after its child nodes have been destroyed. Keep the property-container
and data-node cleanup for both kinds of subnode.

Fixes: 99db5ff7fe0b ("ACPI / property: Hierarchical properties support update")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Link: https://lists.openwall.net/linux-kernel/2026/06/05/10
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/acpi/property.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8ee5a1f0eb48..3a26df35979d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -664,7 +664,8 @@ static void acpi_destroy_nondev_subnodes(struct list_head *list)
 		acpi_destroy_nondev_subnodes(&dn->data.subnodes);
 		wait_for_completion(&dn->kobj_done);
 		list_del(&dn->sibling);
-		ACPI_FREE((void *)dn->data.pointer);
+		if (dn->handle)
+			ACPI_FREE((void *)dn->data.pointer);
 		acpi_free_device_properties(&dn->data.properties);
 		kfree(dn);
 	}
--
2.50.1

