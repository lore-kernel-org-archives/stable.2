Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E701F427C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200282; cv=none; b=eiEyVo4ofpbCtwZixZgtESc37m6X3twuRsQa1iyiA8ed5ojCmQ5NGfCg9FSFWhL0ElhniJ7ETKKJa1j5rXnjIdtbO4bkx685jN31Xm7kXdjaibH+euXfVq+E9UlQyhMhDEs1M2KYNsTIBgv1YF40fnk1/D5u3mo3a9d+71/frU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200282; c=relaxed/simple;
	bh=DDf7lGDFGFBcFwYvJh3pt0um6TmiCSuHD7m39FoIn9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPrScHwSMzm4ksXC5W+3JZaGs9lfjKwDkHoIWG2rUPC7oWqE9FoEzVMKYd7eOLA/XI/0invXClDql6X8q+xwbiYF7fG4eiC8ZPJQrwypRsDPC7xKcsc0lb9AIDn7rf/YcNM/otrDPRWxRjVG/6t0aJ32Xt4hBuWKu9OxnRYvd8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMLG8Z7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMLG8Z7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFD61F000E9;
	Tue, 28 Jul 2026 00:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200280;
	bh=bwHvp9Lq6yi9h65/cGeI3a/8wKcXAvuo2CdDQoc13/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMLG8Z7ZMioEHmsbJEBDBkPlsvXhXYIjWF2+OXTx/BcEyya11F8O0wmHSzjnWdI96
	 LW8/nJ7eaT4RLTrNNTiSobSurGpRd+t+V2M+k5jKNW8TMeAbP1A/E20RztGMufye/j
	 rhq1zfEPx3O7C9PAuV+BjgJPRDlxtP1GeCWs/SBiUdRyFF3toRHWlwzhojpOjkwyM6
	 Kl9vwebk0L9kmpH4ogRxUjYsL9Mux3p3qeI61ZcsmNkjOE20M9+8MSKg9uX0/tmwNj
	 GtHq+QGv3WTj7s6+xBDBRpX45SEk7oB16oSxz2NORqq7wq9hJBdbShhUrJtqd+Wq8+
	 Zgk+JFfLmCKFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Luis Chamberalin <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] firmware_loader: introduce __free() cleanup hanler
Date: Mon, 27 Jul 2026 20:57:56 -0400
Message-ID: <20260728005757.2692793-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072051-anymore-flashily-03a1@gregkh>
References: <2026072051-anymore-flashily-03a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 8dde8fa0cc3edce73c050b9882d06c1a575f6402 ]

Define cleanup handler using facilities from linux/cleanup.h to simplify
error handling in code using firmware loader. This will allow writing code
like this:

int driver_update_firmware(...)
{
	const struct firmware *fw_entry __free(firmware) = NULL;
	int error;

	...
	error = request_firmware(&fw_entry, fw_name, dev);
	if (error) {
		dev_err(dev, "failed to request firmware %s: %d",
			fw_name, error);
		return error;
	}

	error = check_firmware_valid(fw_entry);
	if (error)
		return error;

	guard(mutex)(&instance->lock);

	error = use_firmware(instance, fw);
	if (error)
		return error;

	return 0;
}

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Luis Chamberalin <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/ZaeQw7VXhnirX4pQ@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: d48795b5cd68 ("Input: ims-pcu - fix firmware leak in async update")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/firmware.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index de7fea3bca51e5..2035a0d9cc86fa 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 #include <linux/gfp.h>
 
 #define FW_ACTION_NOUEVENT 0
@@ -196,4 +197,6 @@ static inline void firmware_upload_unregister(struct fw_upload *fw_upload)
 
 int firmware_request_cache(struct device *device, const char *name);
 
+DEFINE_FREE(firmware, struct firmware *, release_firmware(_T))
+
 #endif
-- 
2.53.0

