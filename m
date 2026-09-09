Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298A5678D8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965193; cv=none; b=Vl6UrjG3lDu0Haf+LmS8u4QZiO64GSYjqZOBh5Rct3cmaWQ2K4IL9n35TXOubFYmd+qE2ybedpnZRF9GGfldiWI5SQAxovMvsPPxJi/eylwABAPNZdv5KSsHKy0cPtuiHnGDmSo19z1yQMuWu0KhEHnLvuJ8rYMUUSAVfCzDweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965193; c=relaxed/simple;
	bh=89j5DLUowoKCzle15OejtW8anLyFgWkOjLehWdSFzpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgIdYfPhCKfK7vcAZsiqyQ9aKCtQEK/glCMjHUh87ygQiKJp4FoZJxdw2G/3WSU9Gn42fJXNdLEsGNFBB+OtNRJIlmquX6kp2FiUvc+5T8NgOsg6X4+Cf5V0yqYvCJkTNxLVGUY4qA/rueJIJeikUFon07VD8x6ehnLaRGV44lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx/ZDhLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx/ZDhLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48191F00A3E;
	Wed,  9 Sep 2026 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965192;
	bh=BhWEoZrmD9jpHK1HJCcnn3zp5ZgSIE8AEAt+hr2GFnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mx/ZDhLixc/Kj2ic2YXpaDkq5SjuqJVPRnAukcZqD0vbP2x0E7MReCqQi3/jWDdzE
	 UqmJy7pXXpK/hBJZiHdSGp4Zs8okYvHNH3+z7/unXo5vzZnZHIIUFPap690NrmXvRD
	 vmWx36oOu6CvfP+hE+CkAm2WfYxIfjU19yySw+Cf3Azyok/o4MyhW4kblAHSPxkepU
	 izFBy2a+Fx3ihYQNxDQHPyQGVPuCtzbW26sjAYRt0BpnqZ3BYj1RalaIe3Bvpt6HkY
	 eqxovXCkU48ilHYxzMUxNXx26lz+zGrLh5F0fuM8YQCOKkJfh67sF4aQFHDqwVFWDu
	 ZKRj/MYJVNL5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] platform/x86: think-lmi: Fix current password length check
Date: Wed,  9 Sep 2026 10:46:30 -0400
Message-ID: <20260909144630.2652147-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-fester-concrete-f38b@gregkh>
References: <2026090342-fester-concrete-f38b@gregkh>
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
index 6ad2af46248b9..4da6ac3115a44 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -402,14 +402,13 @@ static ssize_t current_password_store(struct kobject *kobj,
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

