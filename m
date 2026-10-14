Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC2647ACC5
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005684; cv=none; b=LYzNIAdYt63M9Tpaj3ByonZnbQ2hMSKbA3UTguBJCrWffkcKY0StWJ/1S59bFCoGF34k+OWE1aRNqKOgw/9KDqX7dYqKx2bLv0VYVd3u/398D1UxQkvmax7/Kz2V91Ou9c81Ss4p+4GVf0H6LyLcDF6jmBbieARXgguySY9BGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005684; c=relaxed/simple;
	bh=UrMyo00SNY2ABPsFiD1pr1qfiLMNapahXhN5HWuZbvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAbijKibca4eUaywlVZu8Gstn694vHNItcBAg7JWyQa0SnX/wsYDmJfpy3z+8n6sF5JE9D1CgGGURTnRtXKsgenZYmxryRLKClSG9ZLab9lLdGY3NASCDv0fyisnGK6R/8VdWRBDnQGWCZClCKqGGwWuVZ+RXOysUm6bevCtdHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=H1gVrXDD; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="H1gVrXDD"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-353804b591eso7946937eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005681; x=1792610481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKWPHyXm/RBE3XBdWdQ17S7GMceJugCqc25wfMm20QQ=;
        b=H1gVrXDDyQ8UIHoIheY/+RwT1BBtBVvr01/IgjHfyZE7qdDB2zt7DWFgONB1MGERH7
         54ifE5QIzGtLNpgOKoVBC+4nLj4LCAQDu3eSPf/l5DB4JRZN0GNgUMlKinpJaBlJIn9m
         Jl32acUW65YGx7i80VXQLOc/kSCrsaH2tc0H4DjPk5EJszqKvXF9taA6jt9CWqIEs/7n
         6jJj4fdU92UuAu3uOThf3UwkkgCd8Dfc8VX8MXdt/oQvnzppu4iejtPSLZ44k7TIfHR3
         Dv4/vkZeg1JRpumV2kljA9C8WjgCSAG30fzdrZI/DM4f7AtaBSmKKdvBBytwDqC0vkHN
         iH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005681; x=1792610481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKWPHyXm/RBE3XBdWdQ17S7GMceJugCqc25wfMm20QQ=;
        b=QynamYc/lucSMa9Pwazwqcw/rTFBuYLr9Z89bVC6pM0CHtULcYtgbP8wo6P10GAG1n
         D8mt5IEfyRX9R0vWw4JNbSEkCJugEtCatYOc0YWCeKGnFIhv7fGpKwgQlX+ArlAQS19d
         zkJiUyAS7w7su3vLi66z00QbsjGwZrfmLGnQRaUgTcsjEFDLIE7YxrJSsOs7R+ZMBymZ
         fx2T/LAvOOW5wy0h/JzyR0OOYuB3/xlC+hcHlV3GMrK2C3fxISS1PenGsl2B6EPjP70E
         sKnewoG5H7OhfSKriE6rchoBOv5hUgCeAciMKMk2uATP6dD0Vlg8XCBLBsQV3yoszSAi
         vMNg==
X-Gm-Message-State: AFq9FYIUUt/P8sOvFaQO+0Gk350ZoRu2fYrAjqtiL1t46RjuvJOp44WV
	DqGIpQ+XWS3GHAHwtz4dsV8AoYIboYwjZ/FMT9msm5rtdUmZaIQH5Nq3HY2utIxMbHMj5uPqLJl
	5KJ+CTum/IQ==
X-Gm-Gg: AYBFou2M0tBBMTIqoBk0d/sMkEQqRJknu8ajkdvRgWzwRfkGoaehl4jsqy3wiQ9AanM
	Yszq6VxQ+oUpzaR8+g5spcigjcIROqr57OVYVqBv2ZoPUJcwZWs1OmCuCbeSgqDaJV2wPZPy7d8
	2wQbTY+jt2rDW+dREKOiWLAYNOtTmKdn7G2by5AlK8J1FTj/QRRsqhDuvLmwOZExPBKJLuo1lws
	C5uaehV1FpefxGW9MMGN2UdiDQoOJj/TipiQmXho8H8lMa5rHPkNPW4xoaijxiey2rxKhFu2LyV
	Ourp1gQXlLGzXokSahK/P07h4tyjOQ/Y8V105Y6PxttilyxHmTCE2iV77kTv1XxPKnuvJBPoYSW
	onzZUAIUiTh4ce8/tT+nKY6Hl5q6KxHxHUZqFmpIPFhbUtIB9b2g/rgDwIv31GRxzwdGAJIlmQX
	8qUHoi2TB7c2ynMuRgRqWtMZ4Q5Z+6aIc+1kqHfL1YveQB8ZC1vK0DvvE8g7LB7wG96F1tEiGMC
	Q6taNcXsb6x2m+/rp7hJDQ2EFZr0zfMKF7qhrfRin5IxfWaHcQzMilNfKi8UKfTMNBdUOY=
X-Received: by 2002:a05:7301:53c1:b0:351:5cb5:53f7 with SMTP id 5a478bee46e88-3537dedd531mr23549875eec.3.1792005681162;
        Wed, 14 Oct 2026 12:21:21 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm38670979eec.11.2026.10.14.12.21.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:21:19 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	tiwai@suse.de
Subject: [PATCH 6.6.y] ALSA: control: Don't add invalid kcontrols to LED layer
Date: Wed, 14 Oct 2026 15:21:15 -0400
Message-ID: <20261014192115.24210-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 74e3b979ce8b78a690f8b94ccf2e2c965f7f5c11 ]

The kcontrol LED state layer tries to track the all associated
kcontrol elements with naive assumptions that they are readable.
But one can create a write-only element that has no get callback (even
a user element can do it), and this may lead to a NULL dereference at
the call chain of snd_ctl_led_notify(), as found by syzkaller.

For avoiding the Oops, add a sanity check of the kcontrol's info and
get callbacks, and just skip the invalid kcontrols before assigning
the kctl to the LED layer.

Reported-by: syzbot+b7fe2760ea6f1ee44b4d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/6a9007b3.1d9ded08.62e62.00cd.GAE@google.com
Fixes: 22d8de62f11b ("ALSA: control - add generic LED trigger module as the new control layer")
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260827113951.893291-1-tiwai@suse.de
Assisted-by: LLM
[ Backport to 6.6.y: After the target's locked control lookup, reject
  missing info/get callbacks via the existing unlock label so
  controls_rwsem and the card reference are released. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-90060 to 6.6.y.

The code changes are identical to upstream, except missing-callback
failure uses the target unlock label; see the bracketed backport note
above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: x86_64 objects
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 sound/core/control_led.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 15acb07c651502d4dc22f72bcc9e3a47923caf5e..639d86e4dd1623df612ead223a11e049fbf39afb 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -253,6 +253,10 @@ static int snd_ctl_led_set_id(int card_number, struct snd_ctl_elem_id *id,
 		down_write(&card->controls_rwsem);
 		kctl = snd_ctl_find_id_locked(card, id);
 		if (kctl) {
+			if (!kctl->info || !kctl->get) {
+				err = -EINVAL;
+				goto unlock;
+			}
 			ioff = snd_ctl_get_ioff(kctl, id);
 			vd = &kctl->vd[ioff];
 			access = vd->access & SNDRV_CTL_ELEM_ACCESS_LED_MASK;
