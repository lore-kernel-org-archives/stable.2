Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1FF4457A8
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745536; cv=none; b=QgkNxIhYUTvMmv6441okDT2Ne9VH78Cch0raOcQzAWSsiMBrh8pHPpWxBwhw699cBX5j3891Jb6dSdi1L4tzaw6rlkFeLXrl9oaKgAOd8k2+4zp1SUjVqzsQhy6CIMi0U/qPiOGMfFSqRfwS1ZBh1QQVpfPSb5vrQW8KBErQ9bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745536; c=relaxed/simple;
	bh=8G5JFQf11oY1Pb9BSO90QsxIAS55V+9iM640EC2/TvE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jsf4+Q+JiowsAWvlBlTGhGWXCqFHmqUBejQ1wwcxkZb2/Q4MPceu5YxsqPBl1MrrPVDAUYwK00pi6lDCGRgc0XlsB5nQwbe1Mfj/UGvrGbJpki1U1qNzkdY5GwYiV29tNum5YMIGixo/FXqrwFgb6nOLqWOaXsiiIjDnSSNveYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQyuxM8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQyuxM8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170101F000E9;
	Wed, 22 Jul 2026 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784745534;
	bh=kdeCuFL6dgt6z0kCa3uS1nUZQbVJM2tBvqN4cgqIjUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NQyuxM8rIr0PqNmAgviuKhD7MFpGQYKiFn1SQQ9qi4INUUCB5ARH6g0mkbfTNc/ui
	 v6M45MJBSNM5/tnO8ARjASPTMoDtSgxqcFQ0fsjE0n3KGzFgcPmzDSzYOGyf6Xr0dD
	 xVYkcpo4/tmfu7j3LC1zGG/eNzVL+2M4Ut+tlj8KiyuElpclB4DpL7tZw5GB/KZUe1
	 6zHHv5Io7EuymmFvHR9AYME1AA0lvK6SQee0l3plHsL1zEX1jfGVSrU/13Eldp859K
	 uBTtghD4Ksx+GeLtCHEknIO1wowuxPaOUj6iXjL9smBm2E/xlBx8e1N39WleQ6O0xE
	 qNdsVMGT7pqyQ==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, include@grrlz.net
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] cpu: hotplug: Bound hotplug states sysfs output
In-Reply-To: <2026072036-pentagon-armory-48cd@gregkh>
References: <2026072036-pentagon-armory-48cd@gregkh>
Date: Wed, 22 Jul 2026 20:38:51 +0200
Message-ID: <87pl0ekgxw.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Bradley Morgan <include@grrlz.net>

commit 86f436567f2516a0083b210bedc933544826a2c3 upstream.

states_show() adds CPU hotplug state names into a single sysfs buffer
using sprintf(). With enough registered states, this can write past the
end of the PAGE_SIZE buffer.

Use sysfs_emit_at() so output is bounded.

Fixes: 98f8cdce1db5 ("cpu/hotplug: Add sysfs state interface")
Signed-off-by: Bradley Morgan <include@grrlz.net>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260619163719.12103-2-include@grrlz.net
---
 kernel/cpu.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)
---
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2319,18 +2319,15 @@ static const struct attribute_group cpuh
 static ssize_t show_cpuhp_states(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	ssize_t cur, res = 0;
+	ssize_t res = 0;
 	int i;
 
 	mutex_lock(&cpuhp_state_mutex);
 	for (i = CPUHP_OFFLINE; i <= CPUHP_ONLINE; i++) {
 		struct cpuhp_step *sp = cpuhp_get_step(i);
 
-		if (sp->name) {
-			cur = sprintf(buf, "%3d: %s\n", i, sp->name);
-			buf += cur;
-			res += cur;
-		}
+		if (sp->name)
+			res += sysfs_emit_at(buf, res, "%3d: %s\n", i, sp->name);
 	}
 	mutex_unlock(&cpuhp_state_mutex);
 	return res;
