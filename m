Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4038389118
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714000; cv=none; b=h+MJ8Yjlhhz7G7UyY19defjNPWVkvrPmCOvhUZGPHEY/nLFwLfLD8IgNgloUzW7fFs1ThaLptmsCNf1xVGcg8j8/qa1oHelX6xnGzw+ENYa96ft+LV7zEFxoCkIW2pBRXdeo013cuCohse80Xkd2EQsTN4WpxLYre1j3xjtFyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714000; c=relaxed/simple;
	bh=IaJ+dTDfOdJ0O/3Frg2soqa5JY1FQQqhve3hMOhF9mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOjTjbovBzRsBA5EsUX71qQwr9UsBswHyBa2t8b4shFdv9AVzzSUZcmy0gBeFEo4qKZhERL1Asz7narGQWfpbWH1u0NliNaifgdRY6wbMWQvEGj72RzvEUZ5fhEdfT08LI7nZclvjnG6FIkrylwVL9A/bY5USvS4CURBTtNkTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCIK7TWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCIK7TWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645881F00A3D;
	Fri, 10 Jul 2026 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783713998;
	bh=ejLeF7wU9H3jgwPpsIh1fqEJX3uBPHIOmQBi/d/W8uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LCIK7TWtp2sZQEgZJ21RpiQoBSCTkTtfhPQYxRNyRZyMY9WCzFdYscZOFX9O3Rfq6
	 wxpXtDCxLNbpMN4U7diJOs4ir1lAcOotvz1fUtEiA2BM1QpazpMW/lQZNf2sID1ihJ
	 q1OzRuIQxFmr8mDo2CY6Wf82gbL8iuGm7lML1s40+PsLyvAJ9rRSUl7+1jj7ejqcjE
	 7nVMwZmSKh7/uhra6WpwltUozUwzPRvXED9TsV6q059yHOmIks+61F/kFE2srTHKgm
	 S1/PIfQ5XNFPg5L0u+FXWqbhFS2RvqVWvt7eiinMW+L3eaRWilEvnDUKZvuq2Nj0ZU
	 e2Xz70fMG2Qug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] ACPI: NFIT: core: Use devm_acpi_install_notify_handler()
Date: Fri, 10 Jul 2026 16:06:33 -0400
Message-ID: <20260710200635.395836-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710200635.395836-1-sashal@kernel.org>
References: <2026070932-overdress-unsaved-5212@gregkh>
 <20260710200635.395836-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 198541ad53c0d0d891fedea4098f9953a0f566c0 ]

Now that devm_acpi_install_notify_handler() is available, use it in
acpi_nfit_probe() instead of a custom devm action removing an ACPI
notify handler installed via acpi_dev_install_notify_handler().

Also drop the explicit ACPI_COMPANION() check against NULL that is
not necessary any more becuase devm_acpi_install_notify_handler()
carries out an equivalent check internally and use ACPI_HANDLE() to
retrieve the platform device's ACPI handle.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/3048737.e9J7NaK4W3@rafael.j.wysocki
Stable-dep-of: 18a00ed0e718 ("ACPI: NFIT: core: Fix possible deadlock and missing notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5a1ced5bf7f6fa..562fee47cde32b 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3296,14 +3296,6 @@ static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
 	device_unlock(&adev->dev);
 }
 
-static void acpi_nfit_remove_notify_handler(void *data)
-{
-	struct acpi_device *adev = data;
-
-	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-				       acpi_nfit_notify);
-}
-
 void acpi_nfit_shutdown(void *data)
 {
 	struct acpi_nfit_desc *acpi_desc = data;
@@ -3344,13 +3336,8 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	acpi_size sz;
 	int rc = 0;
 
-	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					     acpi_nfit_notify);
-	if (rc)
-		return rc;
-
-	rc = devm_add_action_or_reset(dev, acpi_nfit_remove_notify_handler,
-					adev);
+	rc = devm_acpi_install_notify_handler(dev, ACPI_DEVICE_NOTIFY,
+					      acpi_nfit_notify);
 	if (rc)
 		return rc;
 
-- 
2.53.0

