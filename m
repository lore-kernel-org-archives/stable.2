Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A34418EC
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394513; cv=none; b=AudQZI6YYvyqQjwwm0vrNDsJ4Ye6ZHFkVIE4UKTgXUShowwyp0OJ9mipHZL8wZ/O6IT0zOIpxJxq2y9NdzLkhshvg6gj0A+GXC0i4ZJJCSJXJ7BkiFNK+fpiwBkDyvyERnVFIFiYWn3wzccB/OdXsMKT6LYgntNg3rvya9u4DlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394513; c=relaxed/simple;
	bh=XtWzZTT4AnJfPX1deXxIUrgprZjuOygWZDcmLRXB3mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STxR7EwGFW0Qxu8yewMZ4D9IozPbYobK/q9GgTCyE2wn5IINqim735ao4eAudDKwa+EfYR9liDtybrO85Epyu2R9wQI2Icpsjt+ux7d+xuLeKnJ6tTdQ/EFaTu4TxofzQwUO06TNStBgjzb6uvGwfn49Y065V/X+l26CvaMctQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eGsxl4+q; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eGsxl4+q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786394507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JPIIn/AseeGgXI6+lYaSU1ZzHmCj62UnEe5Y0V80ywA=;
	b=eGsxl4+qF/FKWpUkVHucIkp70pK7RTZJhC9FWpbc8SKQlZWqjYiuBN7Yxj6PY3PBbetyxo
	FaEtEAfQ1SP29sGNglwnSfTA3Gp3AxFep4A+PQCuSZJgkC6PBylmEm/ieAbPMy9YiFG45g
	l2Aexf2XYhzahZkPAnxQSKCtBfDksXc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: think-lmi: Free system certificate signatures
Date: Mon, 10 Aug 2026 22:41:07 +0200
Message-ID: <20260810204106.165895-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=thorsten.blum@linux.dev; h=from:subject; bh=XtWzZTT4AnJfPX1deXxIUrgprZjuOygWZDcmLRXB3mY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlV5kn/tpTFcBydEjyTSVx//xyrL12B/CVhj/Ju/v06W 95SSD+so5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACaiYM3wT+9kRZnKx2Xny/eZ avB+MzqUlq++s3zC1nbupFu6DInrGBkZ9mxN1dt7//OCif9fTlFW7X55//Xapr1nTVMKSw9XLUp x5wMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Multi-certificate support also allows the system authentication object
to store ->signature and ->save_signature, which leak when the driver is
removed. Free the signatures to avoid leaking memory.

Fixes: 5dcb5ef12590 ("platform/x86: think-lmi: Multi-certificate support")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/platform/x86/lenovo/think-lmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index e215e86e3db7..e3e683bf3469 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -1456,6 +1456,10 @@ static void tlmi_release_attr(void)
 	/* Free up any saved signatures */
 	kfree(tlmi_priv.pwd_admin->signature);
 	kfree(tlmi_priv.pwd_admin->save_signature);
+	if (tlmi_priv.pwd_system) {
+		kfree(tlmi_priv.pwd_system->signature);
+		kfree(tlmi_priv.pwd_system->save_signature);
+	}
 
 	/* Authentication structures */
 	list_for_each_entry_safe(pos, n, &tlmi_priv.authentication_kset->list, entry)
