Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2B317164
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209172; cv=none; b=cq6YTW7ZC2cjVYpd1SuzW3Djz4BHo1mqlkpr6w6XrysR6cS0QKQWZViTHU3s7+1KbjLu+umjKofxAxdh5GhcgjFIaH5Vws6fBNeGeH2NeYw5/BWTE4tCZrlPjWtH7lJobaZlJeyY+CRSPtl444BNPYstHlwg84VDOVvyU7nJqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209172; c=relaxed/simple;
	bh=fMHypd2kEs5J/LbOkx6XcgJ5gb43gPF/B4dlzWZ5VUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqrghT99+7kuWUYE/WpK7hWSIu3pMIRuBDcylHjCl9CMVytAfAvAUoK2V1qkRlgddWrnpBgw1b4LIoZR+go3Ar5vVCDwl8PL5j0TR120kDAr5s63K4W7qHwePg9aE9H/yIzcpcVHoN+Cin76gAqX9cLzZC1n+3Qmk6omKMiHdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTD2FR1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTD2FR1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144881F000E9;
	Tue, 28 Jul 2026 03:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785209170;
	bh=jaxOKsIrRU4+vunW3+xe78xRS5DzjYDGTOoLj+2kDkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTD2FR1VNvF0vK7bKL1Atn/nuzKLjVcrZpxCLACKE2TBhQ0bmzx0bZ46EWoxDDy63
	 GXrke96n86liZUWJwGNM6m6XVlFp4sEp+J9mFtbiWk575O+Xufs27z2rux3ITzhfIR
	 P5QLWKltqD7CgjwZqX72OkooSZQywF5zLrV1QDX8JEG1WPscU34+hhoZWZI/Ay36YI
	 anlSJvQCyz2UtDMeQWwumwzPKyBbAUoESPd9gjSNlMsIrPcsUr2HiF7pfbKi/KK3jz
	 vr2SJPZ17vfyp09LmW0+moxs2huOPSNzW0/Dg8XSMhwObT1UCYNadBk9LyZUOq/tF3
	 fGbuLT4MLz6WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Luis Chamberalin <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] firmware_loader: introduce __free() cleanup hanler
Date: Mon, 27 Jul 2026 23:26:07 -0400
Message-ID: <20260728032608.3151832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072052-exterior-oncoming-f12b@gregkh>
References: <2026072052-exterior-oncoming-f12b@gregkh>
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
index 84e346ae766e2e..2235ffec3fae0c 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 #include <linux/gfp.h>
 
 #define FW_ACTION_NOHOTPLUG 0
@@ -118,4 +119,6 @@ static inline int request_partial_firmware_into_buf
 
 int firmware_request_cache(struct device *device, const char *name);
 
+DEFINE_FREE(firmware, struct firmware *, release_firmware(_T))
+
 #endif
-- 
2.53.0

