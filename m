Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAA582BAD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971227; cv=none; b=JmsiS97ViQusW1ARCHHq+MOp2IpQJ3KR5AWzw99PzjXr/VVIsAj8jTV3PkiDUmPvNikA/txBvGqq3rwAvTrPyhxrYxf5jSW/u3tpuMgyIwrhwZqoe6xOgTVwA52xIoK4s1git/K/hHoHJcbMlogrkxcd8YAk+39vPpxMaC361Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971227; c=relaxed/simple;
	bh=5JBc2/hCMR/rOPuYanL40Amdu2tAvF5ulVAqbRxVlUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMDy5SOMrZ4fTU12nl0YtleQwBddEJuwS1TLf7XXsEk6ktAyYa6xhZLz2iUy9fGKb4cQp1BT8f6TRgKvrlCe54RC/LuM12ofYroEQ819arw91tc9GM30K5q6XoflC+Ukv8UOVzF/R6ypUciIUDstAk382q5Th9R56Iv4rg5DTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVE+xuTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVE+xuTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C95C1F000FF;
	Wed,  9 Sep 2026 16:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971226;
	bh=EK6TJ7VzTUZqO0A8Wd5WjEptTXeThGTa1IbjCDdIC2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WVE+xuTwoCCCVVQeq3RJhs4sKybuvqhGYlamLQfK/poUXZP2n90CipvHA74/2vB6b
	 DIFK+N18nfc3aO8MrCdxJhHsZI3dmXwEvALA4d0pDuyRvjnixiohMt6RlI/mlCcD3b
	 AG2hJ4OrZ6P9EUc2t7gZCHJYXJFz5qdclShP8C2iMwL18KIPHj+KXzysTYQrKprfOn
	 P/1fRG7v6+fVwPw1VCMqIoeyGKbmSS8x133Bd23mdXqPH2cJJFbNuw5Dgq6DXa7EVc
	 i9RKlHzcl9dORphyG/dI7GnCNLaD6RRDvpiCTdNLGDKs0XxclmlK6f5W0ZzrmSkEbx
	 wEp+FPD9fgbCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] platform/x86: think-lmi: Fix certificate thumbprint sysfs output
Date: Wed,  9 Sep 2026 12:27:03 -0400
Message-ID: <20260909162703.2982330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-banknote-slogan-6f7e@gregkh>
References: <2026090327-banknote-slogan-6f7e@gregkh>
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
[ Adapted upstream loop changes to the older driver’s three explicit cert_thumbprint() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index e7605bc97f2b0..31f545a2f0a58 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -681,9 +681,15 @@ static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_att
 	if (!tlmi_priv.certificate_support || !setting->cert_installed)
 		return -EOPNOTSUPP;
 
-	count += cert_thumbprint(buf, "Md5", count);
-	count += cert_thumbprint(buf, "Sha1", count);
-	count += cert_thumbprint(buf, "Sha256", count);
+	count = cert_thumbprint(buf, "Md5", count);
+	if (count < 0)
+		return count;
+
+	count = cert_thumbprint(buf, "Sha1", count);
+	if (count < 0)
+		return count;
+
+	count = cert_thumbprint(buf, "Sha256", count);
 	return count;
 }
 
-- 
2.53.0

