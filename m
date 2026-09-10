Received: from forward400a.mail.yandex.net (forward400a.mail.yandex.net [178.154.239.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FF56E070;
	Thu, 10 Sep 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062200; cv=none; b=b8DRa8uoG71UgPubDO4EfslshVCrAi8BI0c9PGMDMhUVbKMPlt5LsFzInkrDilpdnEIaRF9U2R0fbpVhqCkjY5AH5hV9qYxBSb+QBYGnG7ZYD6gR38PV/sqT2TJ9/VW562QETD36W9JYzVMU4oDi8EfDlnZEbv0ULOEEK6uM3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062200; c=relaxed/simple;
	bh=u70VVk9lickgfND4F/WJPlfvi4AFn7ySCn2KEJJA7pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/Pi3ksUopVvvLY+ge1BSgYYXSCmz9zRQ5yUE4w6OBsJmt8V0Fly1zWd2vc+Z8xrP1/MzqMvSGm45hUVg/SVjN0pIxbgFv73u2w2mu60m1nrkxdZK9jrwybV7ES1RgBhFQLREilAGmKOLQiHyhLPPLGqSn55+zBpfl2fazI+dfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qQ94PLib; arc=none smtp.client-ip=178.154.239.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qQ94PLib"
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
	by forward400a.mail.yandex.net (postfix) with ESMTPS id 4FC4AC1802;
	Thu, 10 Sep 2026 20:34:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp) with ESMTPSA id pYTK6qleDeA0-umyu9rMG;
	Thu, 10 Sep 2026 20:34:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789061692; bh=/w6I0bR9juTZK9iJyXX1KbrXF3UOCLi/woVjIOkqNUE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=qQ94PLibwbkO9kYGE9uoT4AwE/lXDJ4Nzfp+EpV8ByfqtRkjJm8DYR8n3ARXfECdI
	 9hNZkVPgCDC4RJZ0k4aS4v9eNqj7oUN0iWS1KMo94PscaiRanJz/34he0JVyRzosAV
	 pU5nKDlkQSYPBzg6mgiS68Q3EJRUxROkTL8F6wPw=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: nathan2049@yandex.ru
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] ACPI: APD: fix off-by-one when copying clk-name property
Date: Thu, 10 Sep 2026 22:34:51 +0500
Message-ID: <20260910173451.61469-1-nathan2049@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zmanovsky <zzz4android@gmail.com>

The ACPI string object's .length field holds the byte count of the
string excluding the NULL terminator.  fch_misc_setup() allocates
obj->string.length bytes for the clock name buffer and then passes
that same value as the size argument to strscpy().  Since strscpy()
writes at most (size - 1) non-null characters before appending NULL,
the last byte of the clock name is silently dropped.

Allocate obj->string.length + 1 bytes and pass that same count to
strscpy() so the complete string is preserved.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7fdb98e8a768b ("ACPI: APD: Add a fmw property clk-name")
Signed-off-by: Peter Zmanovsky <zzz4android@gmail.com>
---
 drivers/acpi/acpi_apd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index e7366fcb76ee..f2012dfdc511 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -82,12 +82,12 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 		return -ENOENT;
 
 	if (!acpi_dev_get_property(adev, "clk-name", ACPI_TYPE_STRING, &obj)) {
-		clk_data->name = devm_kzalloc(&adev->dev, obj->string.length,
+		clk_data->name = devm_kzalloc(&adev->dev, obj->string.length + 1,
 					      GFP_KERNEL);
 		if (!clk_data->name)
 			return -ENOMEM;
 
-		strscpy(clk_data->name, obj->string.pointer, obj->string.length);
+		strscpy(clk_data->name, obj->string.pointer, obj->string.length + 1);
 	} else {
 		/* Set default name to mclk if entry missing in firmware */
 		clk_data->name = "mclk";
-- 
2.43.0

