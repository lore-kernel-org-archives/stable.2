Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E240D57C;
	Sun, 21 Jun 2026 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782067614; cv=none; b=t66MJCIuWY80LG3wLd52WQ6lVmoeTA6Mi8wUX2OgWaV3LkYjRn0A/9Jxk84YIRWk3hm0+VOt8ggd/85moLNvQQ9HJ4GqJ3OnBzDvCAx4LnR5xFi78e03+GCC0FC0toGw+wQdLAVIv64m1noOXLKZnwNNnUdL7fTURAKj8o3xTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782067614; c=relaxed/simple;
	bh=QsiTzMBVk6IyNdwojx6arH0oHSpW60MCfB/wgdI+qgg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Obi17CigoRPgjXWcUKS5r5SkUqXn/S1/mBs5qkI5q30IAcSk3wc3kWj2rQ1+6hQxfFxfT0EoAkzFr42r8KjVabu8vmprkKskjA5+uYvyTQKX5RPGtERf0cUpbCKkyxrO5iGFiaDHmGakCEvdRg6MvHLS1OoZGEUtOSWxyijBAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RKj+Gyve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WkDFgVNj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RKj+Gyve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WkDFgVNj"
Date: Sun, 21 Jun 2026 18:46:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782067605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6m4pAlecSkXd0x7l+cZtdZqiGnRugpItkoTUcGGcvU=;
	b=RKj+GyvexWFnSd55CRD23ENChrM+fiBLmBYF3zDrzuHnR93m9oD3tWQRAZln4d05LNJI/k
	9Y42orpKHhE3B83QxJDBvVNSL+7rr7c+bqCt2gatfWyignOJx/U8l2IkDz5K4FuyXUrKlD
	fEKm2Y2VeVAo0MPRAU6BgwEgsff4VutXSHK8fdEKaCpkjs3vcuYx3k51Gd/Ydg+IGlXgdO
	b1tgldZqHJTggm6BihOh8fCSJqQbc3tQnlkHCgJ46G46UOjeAzP5fHiDbjlbze1GMgx4B+
	AZLC3pP3Ex0cBCvgr5oqcsWSkHy9Eu79wWCcbVN8E9558+JQm4HZZ/gHqD2F2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782067605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6m4pAlecSkXd0x7l+cZtdZqiGnRugpItkoTUcGGcvU=;
	b=WkDFgVNj4sVph+vlWiEzOqefFxkh8Z72WT7vV1xQiqLYUAZkbNqrKgefO0I/ANBuFTWJ/T
	oPeEWQgv4haoY1Cw==
From: "tip-bot2 for Bradley Morgan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] cpu: hotplug: Bound hotplug states sysfs output
Cc: Bradley Morgan <include@grrlz.net>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260619163719.12103-2-include@grrlz.net>
References: <20260619163719.12103-2-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178206760315.2745857.12106856415011653223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     86f436567f2516a0083b210bedc933544826a2c3
Gitweb:        https://git.kernel.org/tip/86f436567f2516a0083b210bedc93354482=
6a2c3
Author:        Bradley Morgan <include@grrlz.net>
AuthorDate:    Fri, 19 Jun 2026 16:37:18=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 21 Jun 2026 20:44:00 +02:00

cpu: hotplug: Bound hotplug states sysfs output

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
 kernel/cpu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3ed24c7..77fdb20 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2865,21 +2865,17 @@ static const struct attribute_group cpuhp_cpu_attr_gr=
oup =3D {
 	.name =3D "hotplug",
 };
=20
-static ssize_t states_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t states_show(struct device *dev, struct device_attribute *attr=
, char *buf)
 {
-	ssize_t cur, res =3D 0;
+	ssize_t res =3D 0;
 	int i;
=20
 	mutex_lock(&cpuhp_state_mutex);
 	for (i =3D CPUHP_OFFLINE; i <=3D CPUHP_ONLINE; i++) {
 		struct cpuhp_step *sp =3D cpuhp_get_step(i);
=20
-		if (sp->name) {
-			cur =3D sprintf(buf, "%3d: %s\n", i, sp->name);
-			buf +=3D cur;
-			res +=3D cur;
-		}
+		if (sp->name)
+			res +=3D sysfs_emit_at(buf, res, "%3d: %s\n", i, sp->name);
 	}
 	mutex_unlock(&cpuhp_state_mutex);
 	return res;
