Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801574;
	b=NtwG8jN4RyMDRFWYqSzZ+z8wW/2LPmqeJ0k0OEgomDFp7kpqt1hWq5e0mIYlYZF3r6MP
	 RFmFI24I6UIc+d9YOzX/XY0/LtFh/c/PzAjQ3KY+XT7UUk2pH3bKTlIQtNVaLIQFhwl8q
	 vh7gFsvAXXJxmQpGl0H9HiMfJcdpnVqjtKFbllORZ0SP5qmC8v71XqxMOLiWNueELDW9o
	 +qn9fwWtjolViPvvZuuQWdKN81fkel7gv2a0IDQiwmuB8rknYovbuz4gYu8APEzTAYpuA
	 o1S+5ib8N6vwMcG1b4zi5QdZvlIC/idW+wDwCnjInJyFwUNtwcktNn7QNCRk0whcmaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801574;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=6AJSYYW5ZAgrqBGJS0OC9W3bPQi0BhlyPP+rFdFD3pI=;
	b=OBd+sDly22rspCxlR7hmjMgcY8k3tv1U+LwplY1dtzPt+ZO/UvqFRDOFEVxrJz0U/nYf
	 kguMJuvfSe30vug9Kthok/RVv85ppi6GYIwHfpAvOKvSmNqm/OPAuJs1ZjnacJzH3h6Mj
	 OJANNXRx8OYdOClh+XDcqev59yjwQQjPw6vPveoFVWF9FAzSM3N3DOODangdFsw9mpmm4
	 ytW9s6b3HnMjI3YHq5d0jG7L1mrY3cNOarV2nH96KRsaKapRLQUcDG80Ku35Ym/5Ms6BU
	 XU/f0bir4QrMNo4n9LSJK4l7lJ/0COY/43XVHLHGF+/b/KJbnB6aZ0BfqIXfz75Elog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1C606A33B;
	Wed,  4 Nov 2026 14:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58E1C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jKS7y5jVyz5B15L;
	Wed, 04 Nov 2026 22:12:46 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A4ECj8P034143;
	Wed, 4 Nov 2026 22:12:45 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 22:12:49 +0800 (CST)
X-Zmail-TransId: 2afc6aeb3d61529-2e41a
X-Mailer: Zmail v1.0
Message-ID: <20261104221249196PEndOlhSBLk0FozQ1xnab@zte.com.cn>
Date: Wed, 4 Nov 2026 22:12:49 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBhdGE6IGxpYmF0YS1hY3BpOiBjaGVjayB0aGUgX0dUTSByZXR1cm4gb2JqZWN0IGJlZm9yZSB1c2luZyBpdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A4ECj8P034143
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 22:12:46 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB3D5E.000/4jKS7y5jVyz5B15L

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_acpi_gtm() evaluates _GTM with acpi_evaluate_object() and, after
checking the status, dereferences output.pointer without checking it.

acpi_evaluate_object() can return AE_OK with a zero-length result and a
NULL output.pointer.  A _GTM method returning a reference to a method
local does exactly that: ACPICA clears the reference when the method
terminates, so the caller ends up with no object.  ata_acpi_gtm() then
dereferences the NULL pointer while probing the ATA port.

ata_dev_get_GTF(), the sibling function in this file, already checks both
output.length and output.pointer before using the result.  Add the same
check to ata_acpi_gtm().

Fixes: 64578a3de723 ("libata-acpi: implement _GTM/_STM support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with a PIIX3 IDE
controller.  A TEST-ONLY SSDT, loaded with -acpitable on both kernels,
adds a _GTM method that returns a reference to a method local.  ACPICA
clears that reference when the method terminates, so
acpi_evaluate_object() returns AE_OK with a NULL object.

  unpatched                            patched
  BUG: kernel NULL pointer             no panic; ata1/ata2 probe
  dereference in ata_acpi_gtm          /dev/sda probes
  Kernel panic - not syncing

The diagnostic is emitted with ata_port_dbg(): a _GTM method that keeps
returning no object is a permanent firmware deviation and the check runs
on every reset, so a KERN_ERR would spam the log indefinitely.
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 4433f626246b..a0b85f74eabb 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -376,6 +376,11 @@ int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *gtm)
 	}
 
 	out_obj = output.pointer;
+	if (!out_obj || !output.length) {
+		ata_port_dbg(ap, "_GTM returned no object\n");
+		goto out_free;
+	}
+
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
 		ata_port_warn(ap, "_GTM returned unexpected object type 0x%x\n",
 			      out_obj->type);
