Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849E36196E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973948; cv=none; b=Ie7qt2bYEMjx2dkA3qvD18vPA7i4XsFp5DaSPEpi9XUbEZ9U8MHR8kVEVjOaaD6wDsKhPXqKfR+RSNPAqWJnu7bUZYCXRnszOCiVq7aVrOb2LUdsqo+3BWz4HQpoCbmkXcvautYhJc8dJB4rik+hRFms4jbauLEl2xGULHPymUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973948; c=relaxed/simple;
	bh=4xNicV6qFbI1LpD4TljUPgR8yM6Dr+1CokWUR/Mg6TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvHeM/IlrTFyViNmD/pxImnmK9WrPtEMrPtvs2O0gQq//3ACrK2Pzy04Jp/P38OM6isgzKpnzIiy8gIK8k2s+G70eiRyy+4WPa87moOTzpYr4WSjDWBQSNynrL4Lip57U3xfdijLP5TdaHlPRL1HfIP81i1LLdqVPudtOp7mb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIzq2wfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIzq2wfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBAD1F0089B;
	Wed,  9 Sep 2026 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973943;
	bh=DpCn6reNfE3GUI3k2GhVMwkn48PtDAyW7KJf/MBieVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIzq2wfNqNflXjHwpS4unlvkPEbC2v5L6mnb3qOvUY1AIvZxnads2eRI4j0XjCKpS
	 KUDZIOGq+kwQSsyCkPOdmDR5wMHBTw2/lhFqCeVppXj6XsC62mNBNk+bfW1noflU8b
	 7tyYEYKfjg428Bs59LC/cUdl7kWwwRcKbni9BXhT2HkHt6CHcVwF3Z7rh3O8Rzq6fO
	 +7Y3qr1gq4ihpRodpqCzhh8fkkJXaSf/nnnw2bo+GFbhbXxxGaTe6XPFCLPLt9WSTq
	 QTWdLcWTNjYTlDEXxFNKU0jVKkgUnCoJljESpHUlk+K+NtjekP6uhKh3pxx2j8w7yY
	 500hpPZAaTZ9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] platform/x86: think-lmi: Fix current password length check
Date: Wed,  9 Sep 2026 13:12:19 -0400
Message-ID: <20260909171219.3227568-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909171219.3227568-1-sashal@kernel.org>
References: <2026090343-sarcastic-pound-fa39@gregkh>
 <20260909171219.3227568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 54745d563114b74f6fecebce68cd020d06c1772b ]

current_password_store() checks the password length before removing the
trailing newline, which can reject valid passwords that are exactly
->maxlen bytes long.

It also passes ->maxlen to strscpy(), which truncates passwords without
a newline.

Use strchrnul() to measure the password length up to the newline, then
copy that many bytes and add a trailing NUL terminator using strscpy().

Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
Cc: stable@vger.kernel.org
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260818151635.37094-2-thorsten.blum@linux.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lenovo/think-lmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index 9548f96c6dad8..c0f1818a5a5e0 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -327,14 +327,13 @@ static ssize_t current_password_store(struct kobject *kobj,
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
 	size_t pwdlen;
 
-	pwdlen = strlen(buf);
+	/* Strip newline; setting password won't work if one is present. */
+	pwdlen = strchrnul(buf, '\n') - buf;
 	/* pwdlen == 0 is allowed to clear the password */
 	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen)))
 		return -EINVAL;
 
-	strscpy(setting->password, buf, setting->maxlen);
-	/* Strip out CR if one is present, setting password won't work if it is present */
-	strreplace(setting->password, '\n', '\0');
+	strscpy(setting->password, buf, pwdlen + 1);
 	return count;
 }
 
-- 
2.53.0

