Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7533CF204
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363742; cv=none; b=AytPEvDA3eUTpHFOhvXoltCxkirjZOEYRE8HVOjRoEJYwBN2CrXKAhlbiBcrIHcahMAZIEcYhjYVgWcR8AD8Ggifx6aNNgMcoahEAKXjtT5mvqciMSNqWBPkHPbCiNUFPgIwSmsPuZ3G41k6Qn7NpcMoyd54xao22W6+G5E036s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363742; c=relaxed/simple;
	bh=U4fw6K0jbbfWcl1otGdcy/8VsRx1MiOGRJdoL2ZxuAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyOpZ2beY+guaQVLWByxi3i4kVVT/uymXDtkwiKatQE4SMaXO0439W5RPEQMjf4WyGj56tdNAlcFJPNwviHv7ZYZTV5TPYIRmwCDlT9IoM3rlLzrtBRTqn4Mb6sJ7nTKZB5fFaKrYr+kWcJJhqLeCP8Zbs98Oh/fCaV0xj0jmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ei4Qwa/g; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ei4Qwa/g"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786363738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u42IsK0yKh8ND4vKo+j2G3uTh/twoaLRw1rWp9I/ry0=;
	b=Ei4Qwa/gEPrneG6tDeNwJ9/Bs5V4gxWPRRc/eJzugp5FuxEvcVcuoZIZRKOMWJQ8Uzo82Y
	bvj94e5vKLmQ2Kj9dgNdksU85PpVvRb218a1PKfnlgfOr4RwrdYASTVlzQMx0EAHKKwWJy
	lpip8rMteeS5DoqQLAKcFWFsniPzP4Q=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: think-lmi: Keep pending save state on failure
Date: Mon, 10 Aug 2026 14:08:32 +0200
Message-ID: <20260810120830.149804-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=thorsten.blum@linux.dev; h=from:subject; bh=U4fw6K0jbbfWcl1otGdcy/8VsRx1MiOGRJdoL2ZxuAk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmV++3MrtzwWfN5A8u/7qiWxns/q9+Uny1+sVXYl8khm 9dUzuJPRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExE4BnD/7Ib52eI255Nb7j5 gfNra41leiS/XsvNP6I62T9m5y7YLMzwP4F9U5Dod91V5Qt1/tYItrzc4s61ym2BVvvK5myP0+H r2QA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In save_settings_store(), the opcode and legacy password paths do not
check if saving BIOS settings failed, but instead unconditionally clear
save_required and set reboot_required, losing the pending save state.

Check the save result in those paths too.

Fixes: 318d97849fc2 ("platform/x86: think-lmi: Add bulk save feature")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/platform/x86/lenovo/think-lmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index e215e86e3db7..cc0a85d1b832 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -1347,6 +1347,8 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
 					goto out;
 			}
 			ret = tlmi_save_bios_settings("");
+			if (ret)
+				goto out;
 		} else { /* old non-opcode based authentication method (deprecated) */
 			if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 				auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
@@ -1363,6 +1365,8 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
 				ret = tlmi_save_bios_settings(auth_str);
 			else
 				ret = tlmi_save_bios_settings("");
+			if (ret)
+				goto out;
 		}
 		tlmi_priv.save_required = false;
 		tlmi_priv.reboot_required = true;
