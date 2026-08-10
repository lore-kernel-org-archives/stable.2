Received: from out-178.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA883CBE9C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363606; cv=none; b=AyNVRMXldStdTIBfDflOXHEO6Jy0zYgzPtP5wkoJ08NtwqLggcaHygGasBeIKlfgE/ScbrgelRfqrPI1EfJv+KX22G4Cl0j6IauA+YRgbnAzS9Kpb9dNLTHO9orrAotIcNRsqKSrMH3SgxjKTZPON8Ek1UjrewYRTB5IUngW2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363606; c=relaxed/simple;
	bh=j6ZtgeD99olVxSpFVSutIsjUmBA00pzXsxOTQVOvAH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yb+gvwwMXLpJgwndYO5VZBZapo6hIADqNp8RszPKqbJb2+JJWoJ0vbcmeNpNsRsDAYeEsSfJE8pZ6RbfrxsdQjB7cdaVOUsGoLxtjlZuwxWMWo87GNC6O2Pr/nXWqKtdnCPVwnPcYqjHYuoYwWmsMVaJPrXMx2GNN9S3wOapIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FkeCibsb; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FkeCibsb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786363600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FOf+cgpUurtbJSr/RtSzO80ltFZO2buF1poGk0/N6cs=;
	b=FkeCibsbC710deaBH4J/wd/LKLBuAZEuIzeY7jypRESz+QX5rDIx9GPIIlETuEB+E0G8GW
	VZctrxhPk842eYCH9l5irKynietf0088zDkRywx0sGyJuWDLOc/SPuokRxXW6Dl0y9hi5M
	w9AYyBcZiGvdZApCuYJ7vbnGrtRfvbk=
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
Subject: [PATCH] platform/x86: think-lmi: Fix certificate thumbprint sysfs output
Date: Mon, 10 Aug 2026 14:05:57 +0200
Message-ID: <20260810120556.149416-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=thorsten.blum@linux.dev; h=from:subject; bh=j6ZtgeD99olVxSpFVSutIsjUmBA00pzXsxOTQVOvAH8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmV+5ZIeCheW1311NrORGvm58yvbfWLUpPZdh0XZ9V/P sujQK69o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbCEc3wh0uy8mNOPefUZfJ2 curzOSZLzvi1Uzjw2fu+N2l1LO1XljD84fW97ejzX3znqTa9Fo5PapdnbtroXl+oE7DCpo8r8I8 dHwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

cert_thumbprint() already returns the accumulated output length, but
certificate_thumbprint_show() adds that value to count again, making the
next line use the wrong offset. Errors returned by cert_thumbprint() are
also ignored and their negative values added to count.

Assign the total length to count instead and propagate errors correctly.

Fixes: b49f72e7f96d ("platform/x86: think-lmi: Certificate authentication support")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/platform/x86/lenovo/think-lmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index e215e86e3db7..441fca37b523 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -745,6 +745,8 @@ static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_att
 		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(thumbtypes); i++) {
+		ssize_t ret;
+
 		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
 			/* Format: 'SVC | SMC, Thumbtype' */
 			wmistr = kasprintf(GFP_KERNEL, "%s,%s",
@@ -756,8 +758,12 @@ static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_att
 		}
 		if (!wmistr)
 			return -ENOMEM;
-		count += cert_thumbprint(buf, wmistr, count);
+
+		ret = cert_thumbprint(buf, wmistr, count);
 		kfree(wmistr);
+		if (ret < 0)
+			return ret;
+		count = ret;
 	}
 
 	return count;
