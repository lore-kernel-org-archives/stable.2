Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F92F3621
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206802; cv=none; b=XDK526fOqIe34TWY5fIYKhtK18rLC+lshRW1JX6iIB+GMGi8TPTRNOtMqhQZIqNrDd6gdN2jkWwmMTlfs5pL7bTp9ElwQpkoE7u560iGBGeCM0E0znWg/vi8sUzZCunIplsPUD5TXiSqfX/RLes0Ocq5gDhP0qcoWQTQGQpDFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206802; c=relaxed/simple;
	bh=Le7GaKho9Lw+A3K0rYUUwLrZO4yDP9ZHBiAv/GVkOeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwrxGjINI+qiwln7uWj8R+9cQXGg11ZLVEWZpl9IFFJE3DbaTgdlMze++Hm0zwCG3NO/0ExS/dyTBefVMQDUe/tcd5ObNl6zVpBrW0jGMdi74e6IbQis980GfNQMDlE6YhcsKkk835KWUHovVwAxnWnzqORJ7ypOU8QBKJMSw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR+ogVJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR+ogVJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B34F1F000E9;
	Tue, 28 Jul 2026 02:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785206800;
	bh=nYu5sFm9D/JhrPvkAU/JhGW+fts3Lh+d4FDOjtvNjLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FR+ogVJAsTzuqY5MyVtGyjacKkqRrjDV/vXgl9CDyWaKuHSWqeB2ZTN9V+CiSQv8z
	 At+cv8fvjvPGQRKNxczoUGlhnqeeylHH1VD4r2FfFqSolS5oDQINFFkucOdI/ugqrN
	 xv9IP4pTywOEq0FDVEeca7gJL//gSUVx4Y//M9p+8tgQx1h7JIGuNIgQx+zvmI7HbZ
	 vJVE8jZD6j7ez3v+HjUzzQ+5FNYGMyaJ8oSeWHOywpdiOuiamUDeisVyfMoxIgLcru
	 v+Bd6JuZ8ZzRo8KqEd99LILQBQKF7SjiCoxFc7VgejCyyZgKc7P9H2KJdyqH4u1Yz1
	 dsJurRlo0W3tA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Luis Chamberalin <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] firmware_loader: introduce __free() cleanup hanler
Date: Mon, 27 Jul 2026 22:46:37 -0400
Message-ID: <20260728024638.3058096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072051-gong-sweep-0821@gregkh>
References: <2026072051-gong-sweep-0821@gregkh>
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
index 25109192cebec9..679da6013dbbd7 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 #include <linux/gfp.h>
 
 #define FW_ACTION_NOUEVENT 0
@@ -118,4 +119,6 @@ static inline int request_partial_firmware_into_buf
 
 int firmware_request_cache(struct device *device, const char *name);
 
+DEFINE_FREE(firmware, struct firmware *, release_firmware(_T))
+
 #endif
-- 
2.53.0

