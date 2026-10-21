Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579643;
	b=dO4gcxxbIFvLHp5vxZvKFlh7N7u1lmYD0FhHFDu8xREWfwXzoSYfhVfJy08Dgtfy+ijx
	 NEY/2/c42NJDYRxVpIvNChHFkQpnDi7yREJtOacuPUi9DOdjqCNCiYc5SYBTEbIIR8cXa
	 nKjSLXxvjqy0A+96HpTckLLRXoTkq1kozWnvjVP0dBxGD4xk1Wptrwtdnyd3FYadid8WQ
	 jvo/9nRWZ678eywLxYzY1VUIBN8vY32DK/8YsT1l/akGzyx7WxkZQvmVf4dxBdbm8Rk9H
	 otyoM35oXnUeuywT+fP9TMt/rjAVYteRIyFa63wcsoKDG78sy2a2oAMJ9crcwmcl1Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579643;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bBJUmtbuATtCQI4WXAqiNK4mEbViXdkWjhd79WEwXiM=;
	b=DdGVg+ckdszA0oEkpecHMyVNcbUbOtldhc3gWq2Kvk2Ka+4zjwlxqg6zFqOAEX0XMHK6
	 86c9oooVUPY10VCdSBuMj4MgCjiUuYg/8OHcEPZCpvfQYVBPaGQVMLVRvTFGk6JPKDaOt
	 3UiRyWEoa50ck4dj3PeZEYitASd9Ci0lvlC9RjI4ugvsh50fVcd1A+NlrwSLBQ8iOm6fs
	 lqedWzFrydKJ2TL9F3Qed0+XSMpuoSZYe82PnhGsxsx2xlMMEfckP5Ze0m9iV0dFvZFNx
	 VP8Kd0ymx6C9Vz6VcALiaRIui7lZ90Z6CMFHG3T8wc6IhcWaq/eafrUPMlmrJpgTAqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GaysVL2o;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62C606A339;
	Wed, 21 Oct 2026 10:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA62C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GaysVL2o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bB
	JUmtbuATtCQI4WXAqiNK4mEbViXdkWjhd79WEwXiM=; b=GaysVL2oznaB6ZBhTY
	uJrmrvdFgr5hKCApxCt8UPZeQlp2BWqh4znUXe8gD+kzm/TQFkmhgdl/4Uwu+CGJ
	aE+p+QS8VXo7QNikOfEfH7IniSMtQtpAmUfEK/IsYHRBJ0On1ww1qpbSEs/J+zTF
	WzVck64z31PHFS5Fwu2N2dBRM=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXXzcZmNhqXKxSBw--.62283S4;
	Wed, 21 Oct 2026 18:46:52 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-edac@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] EDAC/zynqmp: reserve space for injection input terminator
Date: Wed, 21 Oct 2026 18:46:48 +0800
Message-Id: <20261021104648.4105938-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021104648.4105938-1-yaojiale02@163.com>
References: <20261021104648.4105938-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDXXzcZmNhqXKxSBw--.62283S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1kAr4xCw4xJFy8ury8Zrb_yoWDGrg_u3
	4kAFykJFWDAFyDt3Z3Aw4YvFW0k3W5XF1kW3Wa9Fyavr1UXrn3ZFn3uFnxXr4UuFWfWr9r
	KwnYgFZ7Gw47GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnFksDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhz9OGrYmByFkAAA30

inject_ue_write() caps the copy length at the full buffer size and then
writes a terminating NUL at buf[len]. An input of six bytes or more
therefore writes one byte beyond the stack buffer.

Limit the copied input to one byte less than the buffer size.

Fixes: 3bd2706c910f ("EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP OCM")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/edac/zynqmp_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index cdffc9e4194d..048a7b9becd6 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -304,7 +304,7 @@ static ssize_t inject_ue_write(struct file *file, const char __user *data,
 	if (!data)
 		return -EFAULT;
 
-	len = min_t(size_t, count, sizeof(buf));
+	len = min_t(size_t, count, sizeof(buf) - 1);
 	if (copy_from_user(buf, data, len))
 		return -EFAULT;
 
-- 
2.34.1

