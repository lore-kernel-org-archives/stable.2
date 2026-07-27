Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3B345CCE
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195282; cv=none; b=gNZyfcoHgZ1CXgcchPR3C1d7VsuQSAZH2dyB3N3MGO2hcE2EVBdPCCfLtBzinV/xMB7ANIlDs+7LeU4M/G6DDMRsFRdwQGYlPcHVqmGFajzdvPbuiTG2KzvebRWGwFS03srU9wEnRbETaX80OWQkJrksmjFFSEhVsTmLsAF4PRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195282; c=relaxed/simple;
	bh=DDf7lGDFGFBcFwYvJh3pt0um6TmiCSuHD7m39FoIn9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvbLUQsRbI92Fhpq7QK0fW5rGwB40hvb2V05MY4aX7zVi1jQL4PJBAvPIUg+kzpFb/TZt8Nlk48Y+6yZdoGrcY79stvHSMjNPMlnxWLIBuPYdUA/hjWR8hD9fDZftJg7utuqfV5/+bYvsV52DYCVksiUB71WnOrZK7OKWTpiY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R31REli0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R31REli0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3E51F000E9;
	Mon, 27 Jul 2026 23:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195281;
	bh=bwHvp9Lq6yi9h65/cGeI3a/8wKcXAvuo2CdDQoc13/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R31REli02fO/q3+4EyCNURy3bEv1QEU6oUfoZd5CKN2i/RMC9UhbUb6fpEB9zXvF2
	 WHqGlpkrVVq027MZ+8w3vT3AaMbdX0wybX4iUKN6zBAlM0UMzyo7Q5RLJ/AD+R4jOe
	 mBXAmwV4JxACXh1i2rqYRKrZSQXyGJe4+mfYV/jQxq73201dTvBDHPqK4wdy5n2Vbp
	 EHNZRblfg6ea6gj/f8onHucFfJJFHDebH85lt4OBg7IHUgDZSavV19Jl1ga9fi9piG
	 KMiKn7Dks13wjRMP1710EfFXws4LcErtuOycxRNwmvY9jR3Wm85zlRacau7d/QefvD
	 7bEYDhxxJbeVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Luis Chamberalin <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] firmware_loader: introduce __free() cleanup hanler
Date: Mon, 27 Jul 2026 19:34:36 -0400
Message-ID: <20260727233437.2425385-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072051-scenic-thermal-f0df@gregkh>
References: <2026072051-scenic-thermal-f0df@gregkh>
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

