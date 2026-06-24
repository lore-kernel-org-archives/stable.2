Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9F19D8A8;
	Wed, 24 Jun 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782265797; cv=none; b=rxz6dOiyA0ygl/yaZ6jrNzK1vj6M+ap2/qW2yH9jAgfOE+XgYtImSCxRlYTKDdTwUEXNOOluYp4y7PAnIjui5J/l+9hQbXe23x0awN8bOWNR59KMcGcSIOmdBm2UwQMjuSjR9dPPiIiC/nO21XEAM1n3xueRLAab0iAWBIM1ync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782265797; c=relaxed/simple;
	bh=aXdha9Lzm8KNZOGqt6ca5f0gEqRdjSX1c712Za0soR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDVSxpoQYhE9Tcq8V8zbVYIMLHjZum131lapZpH202M5UBe3oWVY1zeAqu/UJxJ2Gj+4g0IEl7x+8ECRFjmVe1Pz/9Md7wJGwj36eetOZIkni9D9hY641172ByuHUo6NocWFLMD8cxwcCRfC9YVaaNZbNDv8mNhdrDexJorQVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UA5YXMt6; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UA5YXMt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iP
	8mrG11w2dbFP7B1CMCKm8J3kEi2aLfDVcWGB/L430=; b=UA5YXMt6CgWwOw6RyA
	MhFEf4xjAQGbuvEecXBKP1ryxUafgLbYwK+U7jOTZOuLdEGIFzRKl/SBZeIquvo6
	iTNEJINaNtlenRLaBTCurvwzS7hCMWaCt0RHXR+TUdqGsDRAxTTHfDf1Th6XcCQ+
	PfmxpgKmrGHJt/FOLX0mGyW1U=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBXr7OXNztqde_EFA--.60164S4;
	Wed, 24 Jun 2026 09:49:17 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: srinivas.pandruvada@linux.intel.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mgross@linux.intel.com,
	sumesh.k.naduvalath@intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] platform/x86: ishtp_eclite: Fix ACPI device reference leak in probe error path
Date: Wed, 24 Jun 2026 09:49:09 +0800
Message-ID: <20260624014910.1226446-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXr7OXNztqde_EFA--.60164S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryxZrWUuFW8WrWrKryDKFg_yoW8Aw1kpF
	W7KFWrKrW5Gr4fK348XF48ZF1ruw1jv348GrWvkw48ur45uF92qw42ka4FkF1kurWkJa4Y
	vF1xtrW8AF1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJGYdUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC1B1eaWo7N508GAAA3h

ecl_ishtp_cl_probe() acquires a reference to an ACPI device via
acpi_find_eclite_device() but fails to release it in the error path
when acpi_opregion_init() fails. This results in a reference count
leak, preventing proper cleanup of the ACPI device.

Calling path: acpi_find_eclite_device() ->
acpi_dev_get_first_match_dev() -> acpi_dev_get_next_match_dev() ->
bus_find_device() -> get_device().

Found by code review.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
Fixes: 7b6bf51de974 ("platform/x86: Add Intel ishtp eclite driver")
---
Changes in v3:
- add missing version changelog.
- thank Srinivas Pandruvada for the review and reminder.
Changes in v2:
- Capitalize "fix" to "Fix" in subject as suggested by Srinivas.
---
 drivers/platform/x86/intel/ishtp_eclite.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ishtp_eclite.c b/drivers/platform/x86/intel/ishtp_eclite.c
index 93ac8b2dbf38..bca7e217878b 100644
--- a/drivers/platform/x86/intel/ishtp_eclite.c
+++ b/drivers/platform/x86/intel/ishtp_eclite.c
@@ -600,13 +600,16 @@ static int ecl_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 	rv = acpi_opregion_init(opr_dev);
 	if (rv) {
 		dev_err(cl_data_to_dev(opr_dev), "ACPI opregion init failed\n");
-		goto err_exit;
+		goto err_put;
 	}
 
 	/* Reprobe devices depending on ECLite - battery, fan, etc. */
 	acpi_dev_clear_dependencies(opr_dev->adev);
 
 	return 0;
+
+err_put:
+	acpi_dev_put(opr_dev->adev);
 err_exit:
 	ishtp_set_connection_state(ecl_ishtp_cl, ISHTP_CL_DISCONNECTING);
 	ishtp_cl_disconnect(ecl_ishtp_cl);
-- 
2.43.0

