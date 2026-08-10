Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39F2641CA
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368184; cv=none; b=ugwdcxV4nWIOpO7JpuwLNgLpbk06rqF3HX6mu27+aZ1U59jwxJuA230siFnGgEtbrODWIvZFyKRkEC0pmlDYX7KtLADDzcoMC40iRscYMuKS7AcV5FFrqedllxVENiTWzCSUMo/AG1qZa1ZRxy+LJiCaKNP4KCtaJAn4PvDRjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368184; c=relaxed/simple;
	bh=OYPFC/gEPzlUdWJJcy+x0x4slZGuAu5zp77YNifcl80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhGu2VLjLL7hc5w7IfrrRPoFgTvKCkbwGoay0btjgBC6gKib5HHiWEo08T8F+wfyG76nn/TxL5LXhQPvnGG7FLuxO6zvdetuSKVICL2kA9ERzr/CC4PlH6v6ACskSeHtoaEQYxp3BEaLhQM+HU3sniQddvoijJs2O1sQPewVMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JeRrOhaM; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JeRrOhaM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786368178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Q5WZ90Z+RvgAZ8GPWsZf/FI1jZNc1ucFZ5oCDV7F0o=;
	b=JeRrOhaMAPoENtTjgJ4xlzv/+ciD8na6jKRYjzqyByaHTohyqdZW2XE1u280CrmjRl+tHI
	+NZvuu/2zITvvwmUNUeotxPUbE2xoc07CnvJFM3xnSgX/ui11M+LKlqzbUzmUrS/3fc2D1
	6oUhUUZ8fh0bzVOub7Hi1BBfyCLIYNE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Mark Pearson <markpearson@lenovo.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: think-lmi: Fix current password length check
Date: Mon, 10 Aug 2026 15:20:20 +0200
Message-ID: <20260810132018.156868-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=thorsten.blum@linux.dev; h=from:subject; bh=OYPFC/gEPzlUdWJJcy+x0x4slZGuAu5zp77YNifcl80=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmVF4TMHZcsa+jwznKIe3xIyeGm9frgCwf392mrndkx+ Qnji+VSHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjAR4UJGhjUd4hsviql3/tlv ZuB8ZePu2bn/PDls/7i8crrctGd//GuGPxxnpdZn9m9RubHgcOb/Y5nNb473bHvQHfnwp85VIf5 pPDwA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

current_password_store() checks the password length before removing the
trailing newline, which can reject valid passwords that are exactly
->maxlen bytes long.

It also passes ->maxlen to strscpy(), which truncates passwords without
a newline.

Use strchrnul() to measure the password length up to the newline, then
copy that many bytes and add a trailing NUL terminator.

Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/platform/x86/lenovo/think-lmi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index e215e86e3db7..860224dc8c21 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -436,16 +436,14 @@ static ssize_t current_password_store(struct kobject *kobj,
 				      const char *buf, size_t count)
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
-	size_t pwdlen;
+	size_t pwdlen = strchrnul(buf, '\n') - buf;
 
-	pwdlen = strlen(buf);
 	/* pwdlen == 0 is allowed to clear the password */
 	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen)))
 		return -EINVAL;
 
-	strscpy(setting->password, buf, setting->maxlen);
-	/* Strip out CR if one is present, setting password won't work if it is present */
-	strreplace(setting->password, '\n', '\0');
+	memcpy(setting->password, buf, pwdlen);
+	setting->password[pwdlen] = '\0';
 	return count;
 }
 
