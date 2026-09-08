Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3459B692
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892139; cv=none; b=MLt0+PeRqXS+GqWwdJPJX19refAIJNJMGGgKkzCXoP23HCC9Mtmfwo3BXJNn0EnXjrUp878Vc5DGHSwtCjIAQjGXv09gwHwZrMn2YE3eGI56cH32Hs+K7g8luPdqgvoXz3xEXrxDVmAKH3AtMDG8A15SifxwJoWP4a4BdI7KEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892139; c=relaxed/simple;
	bh=DBSmK0FtI2/4pdedDGnCfPFjaJqA94om1cYVFPrHiVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9PvUxJzq5v5FBVmj/bmh9o7xSDbapk8MfkH3UaOW8zhQ0Eh4++Anz69e/KbQ4g8M0iGeysm5oJovzcg6nmd05ajdKt8+zWRWFs8Tz866REb6uflBW5zK0fX1r45Wkl24zO865TW/eM3GfYpYFaf8zclFfB+ub7+wTDODx7ox+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQTD/kMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQTD/kMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97A71F00ADB;
	Tue,  8 Sep 2026 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892131;
	bh=Ps+TXygEf9R+x8VNWTgLQ8UNZ6wg57mlNtNQE5R/vo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nQTD/kMnHtV1DLxtwY8fKg+9LFK0I9GibUVYAjE01lezOwc+HwCTW2D4UkUDomJtA
	 0ub+krOO4XlkMDX7aTRg3rm0mFwO5WsGmqiXfnoXbV5JOxUaJRpS4UX6wdBbn8tua9
	 DmmFtoRsoSpm2XhBRgVBSogVPH2q4WE9ADQT19AKryyOcVxz3C+uF9v/VM4MNgDV7Z
	 0Pre4zyzITZdjtfXKxvl+BNyE1yRv/wRxABHjthw3A3Ix4aS52xa1fQH4QS0+B/nI7
	 awICRRJbBjIzwqYLWk+caOdjW92OwxLdeShDKcQyCLp97zap/lIO1FHzfW6irueveC
	 bLHGa8khVhj6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiacheng Yu <yujiacheng3@huawei.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/6] params: fix charp corruption on allocation failure
Date: Tue,  8 Sep 2026 14:28:45 -0400
Message-ID: <20260908182845.219246-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908182845.219246-1-sashal@kernel.org>
References: <2026090333-barista-diagnosis-cdab@gregkh>
 <20260908182845.219246-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiacheng Yu <yujiacheng3@huawei.com>

[ Upstream commit 3dfaae04243cde460d82dfc2a7dd0bb6664d20ae ]

param_set_charp() stores charp parameters in allocated memory after slab is
available, and releases the previous value when the parameter is updated.

The previous value is released before the replacement allocation succeeds.
If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
left as NULL.

Failing zswap's compressor update before zswap is initialized can later
trigger:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:strcmp+0x10/0x30
  Call Trace:
    zswap_setup+0x3b1/0x490
    zswap_enabled_param_set+0x5b/0xa0
    param_attr_store+0x93/0xe0
    module_attr_store+0x1c/0x30
    kernfs_fop_write_iter+0x116/0x1f0

Allocate and copy the replacement first, then replace the parameter value
only after allocation succeeds.

Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index e6d96f84ac1b5..ca87641c289f1 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -265,6 +265,7 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
+	char *tmp;
 	size_t len, maxlen = 1024;
 
 	len = strnlen(val, maxlen + 1);
@@ -273,19 +274,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 		return -ENOSPC;
 	}
 
-	maybe_kfree_parameter(*(char **)kp->arg);
-
 	/*
 	 * This is a hack. We can't kmalloc() in early boot, and we
 	 * don't need to; this mangled commandline is preserved.
 	 */
 	if (slab_is_available()) {
-		*(char **)kp->arg = kmalloc_parameter(len + 1);
-		if (!*(char **)kp->arg)
+		tmp = kmalloc_parameter(len + 1);
+		if (!tmp)
 			return -ENOMEM;
-		strcpy(*(char **)kp->arg, val);
+		memcpy(tmp, val, len + 1);
 	} else
-		*(const char **)kp->arg = val;
+		tmp = (char *)val;
+
+	maybe_kfree_parameter(*(char **)kp->arg);
+	*(char **)kp->arg = tmp;
 
 	return 0;
 }
-- 
2.53.0

