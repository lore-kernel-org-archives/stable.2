Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344A3E315F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966761; cv=none; b=VlA6gch/gzLOeAKFAdaBgXpSEf2s2z4j3SsoPAVoe9MdX/82NMOqUvSY0bYkPSO9jDBcuGtkWkDe/xtkGdQeUcnCo3jKAimPeLflqzydbDCYOIe95Sudx2lSIBAY7OUG1MGuNgEUrc/CRjz+lXvr1ExND3lykWxrLHbs9uSmTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966761; c=relaxed/simple;
	bh=fkkUAa9A++hqWlQSw31xiG+t/DN74CvgOmHLfIwBEh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QloKVCcaefnV3hpHBsXDSqdoqieBfkresW2/3ctx0RdhZpTzhMdFaP3r05XGyOIaQVGui1g7lu2R44olM+fRSHEoTZtKzDo71hQz1DMlXq9Zlqa4049j9NmjZgpeCUDUVOggkGfcXtlaBXiQ9x3WkOvdSmU9rqJszOk+n+S6GTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKsVH+ch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKsVH+ch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E31C1F00A3D;
	Wed,  9 Sep 2026 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966760;
	bh=LVUA9+DgeqXB25Jk4nXarcLYU8dvL158mQQdfbOEwPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKsVH+ch9I9QlIgCucWGH8LbVtwhiFbqX3ngYuSSgUxEY7t1ubc4ju878jNRwX21g
	 OsEhaWTpm3sUVfeBeViBmn3IA9++W0IwIG33aqk0Oc6z2LPtBJXG9BpM55UC3CUSAr
	 4nSsB0kiL4nU1yO4M6M6Kfgey25W3yF0yBn7oXA/fldGyy7LTSFQ+XAUJef59bpyFG
	 xu+FL0S6F6IcC6njPFXsYPr+HsUSSP3kyi5UlEdg6R7acO8BO5q3du3wUnJ0sRxY3t
	 aa/L0vfsTdH6CJqY6S+otolgfShbM+rv+D+N4rqGAZauzV3fycdCK940PAsccUK6g8
	 qpXc1vR5A8N1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] platform/x86: think-lmi: Fix certificate thumbprint sysfs output
Date: Wed,  9 Sep 2026 11:12:37 -0400
Message-ID: <20260909151237.2839173-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909151237.2839173-1-sashal@kernel.org>
References: <2026090326-unmixable-concur-5982@gregkh>
 <20260909151237.2839173-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 9b048ca18d006..a5dac28ced2f5 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -686,6 +686,8 @@ static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_att
 		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(thumbtypes); i++) {
+		ssize_t ret;
+
 		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
 			/* Format: 'SVC | SMC, Thumbtype' */
 			wmistr = kasprintf(GFP_KERNEL, "%s,%s",
@@ -697,8 +699,12 @@ static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_att
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
-- 
2.53.0

