Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7952ED5E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966626; cv=none; b=ScO+niYDaH5dp/y+/2l5UV3oyKO+VMWTBLqWdg9bMoR5odnSdCIRzHew+jl50Sp6yMHKm+Td14s2fSeYUbuOb8otJRrxo1w6RmFW2wDvyYx5khQH+iHLCO56AIlu+pob+6cTo7KM08XwDOHZjOmra/OXX79yG4JFNrz4FFdcPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966626; c=relaxed/simple;
	bh=3M6abzjNlyDQy+Y/zVc/Ptn2SOYJZsfz7aZavyRovnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVG5hEKiWPD/k/06cbdJNndRQgPEt2USlITWtmu3zdv/Zb0r6Ul3UU3N2ylV1NgpPSL9Mqk2UPCAe0ITFdkBfhRKCxxwL7wm+4y1jJAaC2TfmrEydMZ3N6omMh6Q87TIMLA/PcreQ2lWY32+j5xLLKTrrRpM11MveV9G25aUgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsIXlfzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsIXlfzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D1D1F00ACF;
	Wed,  9 Sep 2026 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966625;
	bh=uh9gxkwqRcNm/jnlXs+iK1igpfu7WbIn6nIoUaHPBEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsIXlfzT45nbzSddSOtU/kWHQ3J6Q92bXG2LocJDdcCNDc3EE/0hrztuTuT3pU+7h
	 LC3XbO05ICqfS7KjX4LzPa1wse0NQngy69RgP4udTGipntMuZusV6nHrF+gk9dsRk6
	 dUoPehS934lBS19HO2XUvoBdLGIbVdnEb4ndzNwklOy3QXINzSbB22owUJkVhxkLAl
	 HrNjf0nmUfAf5oMtxP9i7S7RjOy+AEpis0+U8WVcr1PEUGVl/C6lXtcsKX1lFoNB0b
	 yuUjn9CrqtNYakHB6wRNgzczNsFIkUMPxMgZf+OskMOrS8W+Mz4tBWgCm1JxOOMwEz
	 WvYn1+bVQ7Tgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] platform/x86: think-lmi: Fix current password length check
Date: Wed,  9 Sep 2026 11:10:21 -0400
Message-ID: <20260909151021.2821213-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909151021.2821213-1-sashal@kernel.org>
References: <2026090342-prepay-dwelling-6bbb@gregkh>
 <20260909151021.2821213-1-sashal@kernel.org>
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
 drivers/platform/x86/think-lmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 3f26d9293027d..17baf25ae0009 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -396,14 +396,13 @@ static ssize_t current_password_store(struct kobject *kobj,
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

