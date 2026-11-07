Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046943;
	b=DZWRRmTrT/9dGScuSy4EmLHGA4UZQF0zQNwvq7031Yy9B33USWlYlsl8iysZcB2o6zrs
	 GS0ImIkDxOjMBl9qv74/Q2BV97fbnrQWVVYwMjKuPhN7ZcEh9grad3fJ2VgktblPwjacf
	 rhCkvb/eqRl1pj0ftCV6PFX194ADo2dSLl+lJoHd1HWLWjkoIan2u5KQigP4rGY5BPRF+
	 L//HN5cBjGNh1AiwwGtDtuZISviN0CEB+60uosVuav7mP+DxlujcUNJwWNGd4RrnEFXAt
	 PwCGt3bTVEggRUzso2biuiBdDEd+Qnf+hsN1Ix1kS5tA1mBhcL9kmQXvhALaJaxUt4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046943;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Muy1I0walUDS47H3Ow0BUqQO60yKZA2xePbMNrxRg5o=;
	b=x/50DnL5pYRUr5WTEi4Y/krr7SwUz6BKm0hhSGjP3hZvguyaroE25DdIr0JI5XLg3WP8
	 t9ROQqnMRlUr7yc4JzwUVigfJjzjal7JKl16tU4KyWCfI9ZJWrneUf4WIjRXC+nC/OTI0
	 uYnJ9v4f04Vfh5UMueMG0ISEUSFGB/KdKeVVJcheK6T7BH6fvrDCOM0NBh77xS4KFoVEk
	 4XeINVyzqq5DePsHct2FbvEUBZCp3YjW2TsGvr/6Om+UFHWGSopiWU1S2aWlClmcB5ak1
	 Zow6ZHszrXr6VjBuqhNl8dKDFoO4Q/0blQkXUfZwMMWxvCKYQThf+4gcBPYi4neeA/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEducWEB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB1606A8C0
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEducWEB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED321F0089F;
	Sat,  7 Nov 2026 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046943;
	bh=Muy1I0walUDS47H3Ow0BUqQO60yKZA2xePbMNrxRg5o=;
	h=From:To:Cc:Subject:Date;
	b=YEducWEBTKZ9xeAMQPhhohijqB4AIW4vyeIFfkD2daGK6mLd8+ICMv2WQYwiOOLdi
	 SXQcXE/rxM+mXMIecXlqPT6yv6MicQMiGBSg1PAuK/svqcleU+GeclqlLHRXuhov7H
	 Ld3m8PCr2LjoLkymVuB1CtfD086TBQc+uscL/xfiYXNQ+3cg2+05779YkvDgizgG8U
	 xlMkAzXPiYBtlU5Gol/xVvIeNiXdxQEjS8aGxdmwa0MtoohRIdP0jfkzszpFC6nNoK
	 wNRWZ20jFKh0aXyzPHNKSy/S8Q2cQp1WPbk9S/WzwlJ8BHFR5evtMAkTLUq+0X45UJ
	 RNS6EilgFXmug==
From: Sasha Levin <sashal@kernel.org>
To: soyer@irl.hu,
	g.wenzel@gmail.com,
	philippdev5396@outlook.de,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/tas2781: Skip invalid TAS2563 UEFI calibration data" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:21 -0500
Message-ID: <20261107052221-failed-6.12-a0f0325e92e5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a0f0325e92e505db6a6879d79da5aa88e94a36ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052221-failed-6.12-a0f0325e92e5@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a0f0325e92e505db6a6879d79da5aa88e94a36ab Mon Sep 17 00:00:00 2001
From: Gergo Koteles <soyer@irl.hu>
Date: Tue, 13 Oct 2026 15:02:21 +0200
Subject: [PATCH] ALSA: hda/tas2781: Skip invalid TAS2563 UEFI calibration data

Some Lenovo 14ARB7 laptops do not have proper calibration data.

Skip these zero calibration values and fall back to the calibration data
provided by the DSP firmware.

Tested-by: Georg Wenzel <g.wenzel@gmail.com>
Fixes: c3ca4458cc2f ("ALSA: hda/tas2781: add TAS2563 support for 14ARB7")
Cc: stable@vger.kernel.org # 6.18
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Tested-by: Philipp Oster <philippdev5396@outlook.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/12a1ab265a1dc0e3a062a54287c8ef48682c4efc.1791895478.git.soyer@irl.hu
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index cff8fab8133a8..44855f593daf8 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -372,6 +372,11 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 					i, j, status);
 				return -EINVAL;
 			}
+			if (*(uint32_t *)&data[offset] == 0) {
+				dev_warn(p->dev,
+					 "Dev %d: Caldat[%d] is zero\n", i, j);
+				return -EINVAL;
+			}
 			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
 			memcpy(&data[offset], &bedata, sizeof(bedata));
 			offset += TAS2563_CAL_DATA_SIZE;
-- 
2.53.0




