Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985413;
	b=i4QSMc8/0jUuVogwON9MTAGGFO3i6VD47l1ujPncHSRKfrkRhFr2rtsml3NgDpy1fgkR
	 HzHO24dsK94/maTHgu/TpQL0IDCIN2uLsuJsYWGK5fp2uRtXZYMmVJG6iBhPq0K3xkgnO
	 jvRjrB+yUESztXHaSyVrq8ZP61iuKz1xeXpT0TiMN8yDADE1xUUw52obfzNKdC+11S3W7
	 vfS/3OgAXJA2NhoPVKC4UTq1wwNY68gMb/oildluYkliTPjHNmcFyL7uF7JI0GXyJCrde
	 CaNwI5JCdrAmVPWYW+3GLlJoMeZ6a5wXvOYPt9fl49HZbV/ft2RuQFaWtCUUg+6WsjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985413;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=h1VBUKnemsO9XaRfaEdwM906RtF4ETg965AOGYzb7pM=;
	b=SqfPFAEMYKV6HW3s69Vj3zOp1P4IjFbzB165v3+bmVhZP7UeeG5OOyqmqXN3Ooyubvqn
	 SqZM9bO9wMy8lw86TS48VzMZUqC/+YKf4XMdMRxvTSJTRyLkDlHjATK7zWcN+d0LWLz0L
	 6oRk+jRu26PwdNlkOo+a55bn9gdYExhyS5qhcF+qxVaHPpWjYpZm+CJBmNlj8Jf4KNaDc
	 IrbWyTUfglfliD5LmidxLQwExnvmlnBH/sYQK13Fn02n4IJn8THtXKe8ZqMRIE6Tedpls
	 TQ+fdGhWI+TQL0GVUl/2hewsfTbkWj5MxTiGelhDZRS4FyyXfwBIW+T7zKQYjW2VoOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sellers.id.au;
	spf=fail smtp.mailfrom=sellers.id.au;
	dkim=pass header.d=sellers.id.au header.i=@sellers.id.au header.a=rsa-sha256 header.s=default header.b=hyg8TeeS;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEEE606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EEEE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sellers.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sellers.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sellers.id.au header.i=@sellers.id.au header.a=rsa-sha256 header.s=default header.b=hyg8TeeS
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id TNTQxX29iVK9UTZhcxFJOv; Wed, 18 Nov 2026 07:03:32 +0000
Received: from just2044.justhost.com ([173.254.29.206])
	by cmsmtp with ESMTPS
	id TZhYxVyLwSeuLTZhYxHG7x; Wed, 18 Nov 2026 07:03:28 +0000
X-Authority-Analysis: v=2.4 cv=NYvm13D4 c=1 sm=1 tr=0 ts=6afd4dc3
 a=pynxHT4M0AVwz8ROpNtnNw==:117 a=tbVZtiplu92VKpH45hjydQ==:17
 a=zJRp6_cAMcgA:10 a=QzMiS2WfBm8A:10 a=VwQbUJbxAAAA:8 a=tjeQfB6RoHAyGUvcEiwA:9
 a=sW6rCsXrbcaOzks2YK80:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sellers.id.au; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h1VBUKnemsO9XaRfaEdwM906RtF4ETg965AOGYzb7pM=; b=hyg8TeeSeHVlMc9tDvP9mzfRMU
	XtpWm9AmiL0Ikqz3YfVJ+9dEYQCVAHwCJwCM437+ILMiFabokkWAlSaTlC1tfiuH4uG0ABTQbYDZP
	afkGRs9Px0FlaiI0HEf2HIdwAEyaDavxs1y4vpDkYZqw+/bWw0onp1ughB6wUONVlJdEm0ukr9ild
	qo7uBgYrBofTHdmLtDqUb/f6F29S0LiO6L/26SAflATF5aIU7//DCoJFX+nonpibPeKNATpMsXM/b
	GdDJcIy+RjP36TWQw1ea8HfqNbzGrtD2KQCXNmCY+FeOCHX4M6jdZHU9tPQYW7JAVmFwaltHthMtG
	bqgnLj8g==;
Received: from n110-32-20-158.rdl21.qld.optusnet.com.au ([110.32.20.158]:44998 helo=localhost.localdomain)
	by just2044.justhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <dean@sellers.id.au>)
	id 1xTZhX-00000002U0j-16Iw;
	Wed, 18 Nov 2026 00:03:27 -0700
From: Dean Sellers <dean@sellers.id.au>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dean Sellers <dean@sellers.id.au>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: pca953x: restore output registers before direction on resume
Date: Wed, 18 Nov 2026 18:03:21 +1100
Message-ID: <20261118070321.2557621-1-dean@sellers.id.au>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - just2044.justhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sellers.id.au
X-BWhitelist: no
X-Source-IP: 110.32.20.158
X-Source-L: No
X-Exim-ID: 1xTZhX-00000002U0j-16Iw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: n110-32-20-158.rdl21.qld.optusnet.com.au (localhost.localdomain) [110.32.20.158]:44998
X-Source-Auth: dean@sellers.id.au
X-Email-Count: 10
X-Org: HG=bhshared_jh;ORG=bluehost;
X-Source-Cap: cmVhbHN0cjE7cmVhbHN0cjE7anVzdDIwNDQuanVzdGhvc3QuY29t
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDKHU4x+MKYWHIYEcDT7KZAYKLloqlnhTYxRBw8hiL0ds/UPEHzwDF+jiD+/DB0AM8235EdEE4oR2qISuoL4BqUEO7NS/itiTfe81XvJeRW4MwoUJ0p4
 WLWPBh+ADIEnex0jCFoK8ZvCTjs5pPNz9V0Bpd2TOVU5Qi2EdoeHxAczNnI13tPTdU480H4iHWNlXjV8DhZl3rvmOdB35yQ2jbw=

pca953x_regcache_sync() restores the direction registers before the
output registers. If the chip lost power across suspend, it comes back
with every line an input and its output registers at their power-on
value, which is all-high on most of these parts. Restoring direction
first turns the configured lines back into outputs while the output
registers still hold that value. Every line programmed low is then
driven high for the duration of the direction write and the output write
that follows. Where those lines drive a load, there is potential for a
spurious output.

Restore output first, while the lines are still inputs, and direction
second. This matches device_pca95xx_init(), which already writes
output before direction when bringing the chip up at probe.

Fixes: b76574300504 ("gpio: pca953x: Restore registers after suspend/resume cycle")
Cc: stable@vger.kernel.org
Signed-off-by: Dean Sellers <dean@sellers.id.au>
---
Testing: developed and tested on a TCA6408 on a 5.15-based kernel; the
reorder was exercised through a configuration-restore path there, not
through suspend/resume itself. I no longer have that hardware, so this
version, rebased onto gpio/for-next, is compile-tested only (x86_64
allmodconfig, W=1).

The rebase onto mainline and the changelog were prepared with help from
Claude (Anthropic); the code change is my original work.

 drivers/gpio/gpio-pca953x.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 3b2407690281..270cea8b4b49 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1337,20 +1337,23 @@ static int pca953x_regcache_sync(struct pca953x_chip *chip)
 	u8 regaddr;
 
 	/*
-	 * The ordering between direction and output is important,
-	 * sync these registers first and only then sync the rest.
+	 * The ordering between output and direction is important: restore
+	 * the output levels while the lines are still inputs, and only then
+	 * turn them into outputs. Restoring direction first would drive
+	 * every output at the power-on output value until the output
+	 * registers are written. Sync these first, then the rest.
 	 */
-	regaddr = chip->recalc_addr(chip, chip->regs->direction, 0);
+	regaddr = chip->recalc_addr(chip, chip->regs->output, 0);
 	ret = regcache_sync_region(chip->regmap, regaddr, regaddr + NBANK(chip) - 1);
 	if (ret) {
-		dev_err(dev, "Failed to sync GPIO dir registers: %d\n", ret);
+		dev_err(dev, "Failed to sync GPIO out registers: %d\n", ret);
 		return ret;
 	}
 
-	regaddr = chip->recalc_addr(chip, chip->regs->output, 0);
+	regaddr = chip->recalc_addr(chip, chip->regs->direction, 0);
 	ret = regcache_sync_region(chip->regmap, regaddr, regaddr + NBANK(chip) - 1);
 	if (ret) {
-		dev_err(dev, "Failed to sync GPIO out registers: %d\n", ret);
+		dev_err(dev, "Failed to sync GPIO dir registers: %d\n", ret);
 		return ret;
 	}
 

base-commit: 90000c03a9f6c74759f773a5078088db81514347
-- 
2.43.0

