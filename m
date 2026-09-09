Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14244583AB0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971241; cv=none; b=O2CWsSqvgVif6tL5MeDBAsA2eDFt2RQ3AODDQy/nEv2SdRuuDZz7R7WFlK1lcQrbkOyPdK9hGg3oSrAR7ixWGvAj9dZg2KgMJSBkqXOcNrpU/01xbU7J/qw7xe/Jo4glgjTZuwCkNplUKwu6T6jJyym3XGYHGNco9cyN9dY6tgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971241; c=relaxed/simple;
	bh=qmoWL/i1Jmbnv3Mgx6J9OgPuk1tl4XWeeAkiuOYi+O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciulD4Pgaw7ZMZG5egsxueWD8WP6OIP+Q3gqNAhVm682OZSVSVkpkTgq7l/5ooLRNdP2pSNhiVyDq4hjI7AHYhUyoaXkL19btCxNv3mEr5vDZJ46F1hqhOQBszjiJeOR6uJGIJlU3gmHF7GuZ36Vp8BiZyIewCXP3XiV12f9GGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIEddecy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIEddecy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5B71F00899;
	Wed,  9 Sep 2026 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971239;
	bh=WkVLNwEgK4drLIxQck4PKH90kklvGjyfhiHOrDaLVLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BIEddecyiFlp+CCSEIQGKaEVLWPwEKe02+W6GDb2yyyJKxF5b9sEKdyGcJbkA63oE
	 X3vW0wrYYVVXeRuf1TEIAKltZjph3v93R4HB7+RfnMXEwE3Q4VwLIpTmCCTQPUUqYX
	 W/5paxuwv70QsGQryZ6+4+t+jtq1VMjWVdbLiVCgmxtwj0Xv+FJtn/8CKMyCnn/Y0g
	 ViCr4wIHRWU/STeVCN89DQtWBrYqMEwXKK3p2jsQfdOKOxy8Ix1pf6d+FLHU+kJyWn
	 6fyf2xk322Ym9r5fN/3g5x5dcDzpXEJ9fd0ZcyZSgwhbfl8Bba5z48jrrv1q7wABxE
	 NjnZhr5xpeX2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] platform/x86: think-lmi: Fix current password length check
Date: Wed,  9 Sep 2026 12:27:14 -0400
Message-ID: <20260909162714.2984324-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162714.2984324-1-sashal@kernel.org>
References: <2026090342-duct-salutary-5524@gregkh>
 <20260909162714.2984324-1-sashal@kernel.org>
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
index 00d0cf34196d4..e3faed0565266 100644
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

