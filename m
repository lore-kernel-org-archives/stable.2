Received: from mta1.migadu.com (out-236.mta1.migadu.com [95.215.58.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29337B402
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609341; cv=none; b=qHFBuOPslKBGliLWc2sRlooxbu/CH9RCTW89Xia389bGx85apmEy7sOh/su8RCbJIfv8lOcb3InxicVFIubtcdvQ5cXNNaY3QgSTGabQ8ycsQM8VwHW/jVfJ1984TcIvi9FHO2j6Uv8xFVz17nFcno0wiumxSHfjMX7j0kf0MjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609341; c=relaxed/simple;
	bh=pxk76wC4TAnTsZKwj0UIutLV3kMVPp7RrfYY/k2CTxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NONQ+iEAhn1MuO7Wl+WosDUz/GgOZx005dFA31lL9Hyf8XD8TBJM5as4iWyBVRqYHeoVi2memC51BJMwCSNa11h0EUdo/g39gdAzhEOSV584arJf9VcC1ko+Uw27CZg5mqB9SchNzhjayLcEA+ooBwcYY60FOGaiFWeaBsLN4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vv4VMlN+; arc=none smtp.client-ip=95.215.58.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vv4VMlN+"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pxk76wC4TAnTsZKwj0UIutLV3kMVPp7RrfYY/k2CTxs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786609337; v=1; x=1787214137;
 b=vv4VMlN+Aq0NKxpFuQb0ir6XJ+6PNIVxDZzPs+SAGD635pqIsJp+6rvsO0f+W5v7x1+6JpXE
 pGK9mi/w4e0McgrsOou83CTfh8GQCxDMeWMqEQXk9GvNhq62X6e1xUZhXrmHdbQxW+LaegsCGBT
 IN3eh3PZR3RI4aFneNM9XLOM=
X-Envelope-To: stable@vger.kernel.org
Received: from fedora.fritz.box (62.216.208.217)
	by mta10.migadu.com with ESMTPS id 29a3cc04b4b5c0e5;
	Thu, 13 Aug 2026 08:22:17 +0000
X-Migadu-Flow: FLOW_OUT
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
Subject: [PATCH v2] platform/x86: think-lmi: Fix current password length check
Date: Thu, 13 Aug 2026 10:20:49 +0200
Message-ID: <20260813082049.41209-2-thorsten.blum@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=thorsten.blum@linux.dev; h=from:subject; bh=pxk76wC4TAnTsZKwj0UIutLV3kMVPp7RrfYY/k2CTxs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFm1dYmXFaU2NM1tu81odurZ1+zq19UCbr6eNsX+HB+dO N1mtRp0lLIwiHExyIopsjyY9WOGb2lN5SaTiJ0wc1iZQIYwcHEKwETc1jL8FeG6cXxdudWBPWyL TtQrLXhftOlLdoaXZqzGsxreJzPMdjP84a10nGGp9+9h25yOS1tmuP4wf2PC/76EqeCl+B1p94N F7AA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

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
Changes in v2:
- Keep and reword the newline comment
- v1: https://lore.kernel.org/r/20260810132018.156868-3-thorsten.blum@linux.dev/
---
 drivers/platform/x86/lenovo/think-lmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index e215e86e3db7..d0ceb6aaa69e 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -438,14 +438,14 @@ static ssize_t current_password_store(struct kobject *kobj,
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
+	memcpy(setting->password, buf, pwdlen);
+	setting->password[pwdlen] = '\0';
 	return count;
 }
 
