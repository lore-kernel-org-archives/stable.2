Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903994FDE6C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965551; cv=none; b=QAEXKOZ0S3Qc9PseRpUXHLvABOUOUfuabYg3gn9HP91LU79gaTJNRS1aZG8M2C8skTQ957UKX7rPYy6FAmJesfCFvtM/uMFstRG1B98eZWbeCE6xxoGwFgCTukDmJUd8oyvQneBfNDznXaBUHkgnGzBPyfwZNVAuzJcWejLjvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965551; c=relaxed/simple;
	bh=7gV1cvbYvXCQSwaYqZscp6R1wU3m6zw7g9pHhPDp+iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxoffJzafZNK/BbrZYc538CJNCmN1REX5mTWHoM5kB7sBE6Zrkxk5+HoTKqbMKHZDT52hhmXAd0w6Jqzgq2q+PtbneSKxikDf4IZZeZXjAtd4r7IzMbp4webqJgByqyEA4TPsKq/Cp+kCW0QWPBuGdXJI9R2XkW6M4KPaazfNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itVMmBZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itVMmBZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDBC1F00A3A;
	Wed,  9 Sep 2026 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965550;
	bh=9ZUbRWq4Pir/qb7Da6Vc6VmllLJ/Xal1s2Bnl2uWxzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=itVMmBZW94GoFt9VqiVcp6K0OS6pFltx7dXN20I3+6xOFGexGHZ5aUgL+Vv+R5yEc
	 B8uMsxnDfE7OIlC4kCbr9uxpat+6fXTtS42IKVBYMS6yy02W6xv3TFeZuJmc25gdvT
	 S75DTrI5GqKDllUGMnIdL8M5zsJHe0m2bvwf68LDV0ihpMyqcG7Fgud3Zz+lmGIUh9
	 Non7qiOZNKZzHxUn1ljLtMeYzWxs7DAyLfX7DuYLlCXmUyjINgZngGgIX57IcswFtS
	 9ZdTcDppjT/2t7+ZzF7TtHEGfD98sFFgrupZh6s2FxK+EV2JYk8TXFQ6euqX0t92oa
	 g4qyk7i0p4wzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] platform/x86: think-lmi: Fix certificate thumbprint sysfs output
Date: Wed,  9 Sep 2026 10:52:27 -0400
Message-ID: <20260909145227.2687665-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909145227.2687665-1-sashal@kernel.org>
References: <2026090326-stilt-refined-4e17@gregkh>
 <20260909145227.2687665-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 4f3183f5ae9b8ddfe338d79a96146a05342bbe50 ]

cert_thumbprint() already returns the accumulated output length, but
certificate_thumbprint_show() adds that value to count again, making the
next line use the wrong offset. Errors returned by cert_thumbprint() are
also ignored and their negative values added to count.

Assign the total length to count instead and propagate errors correctly.

Fixes: b49f72e7f96d ("platform/x86: think-lmi: Certificate authentication support")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://patch.msgid.link/20260810120556.149416-2-thorsten.blum@linux.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ adapted upstream loop changes to the older driver's three direct cert_thumbprint() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index f6f76418ecdea..e43b329e685e5 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -672,14 +672,18 @@ static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_att
 			 char *buf)
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
-	int count = 0;
+	ssize_t count = 0;
 
 	if (!tlmi_priv.certificate_support || !setting->cert_installed)
 		return -EOPNOTSUPP;
 
-	count += cert_thumbprint(buf, "Md5", count);
-	count += cert_thumbprint(buf, "Sha1", count);
-	count += cert_thumbprint(buf, "Sha256", count);
+	count = cert_thumbprint(buf, "Md5", count);
+	if (count < 0)
+		return count;
+	count = cert_thumbprint(buf, "Sha1", count);
+	if (count < 0)
+		return count;
+	count = cert_thumbprint(buf, "Sha256", count);
 	return count;
 }
 
-- 
2.53.0

