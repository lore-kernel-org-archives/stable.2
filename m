Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F73AC0E4
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980854; cv=none; b=RnFevQlrsrlcL9XXJD8kEDnTS2uPUgJ8PyBSw6F3LjHx1zYul9YoHV7C35nmOUw/0jzmG/vVU51u5KpBlc8R1EwdvbQupWfUCD6VDYCdjJy6AY5+Qb+s57P76AEMM7CT3UoRuB9iK+XfgW3W1TF29n4n/unen9D/ic8xIY9VRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980854; c=relaxed/simple;
	bh=UlOuErsjgde/eTLgqAGlWv/rtVXQzCigvpXPfJf2Fj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPPQcCuZOBxURo2+HQYcjnbNgbLiRCNXzZ8H7J5O7L/IlQUnwIJZ1MNMsAsk6psApJTUAtI1YRJ3pNVAz0Kw2easNyk71/f5newSQ7VjqC9tLebR/p3Pn5lUYzCt13im67pYoa5T+GKwyxgknVPO29NY/2jbUaEcwIb4/2ctpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3klusF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3klusF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60DC1F000FF;
	Wed,  9 Sep 2026 19:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980852;
	bh=TCYwKv0Lhrsa+CM1Ax/m6AwaDzaEK+fFynoR8Yt28VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C3klusF4+z8tPztoZvDIm4OrAbyOBBU3G8/QAS83IqP9mdtPXdaoP2itlKg4YQllE
	 f/Dr/roj9UeAyG1vcpnxBuAnxjEKvo7GyW8MwDNfurl9Xn3KEsfKDrnpSj6eqJx3E3
	 2qEQjNnL6jZLpF5A6Q9blbC19hoLCWIqPWwFCJN2SSOeCkGDU0UiiZwyZyn9a7jQfv
	 A0diPDQeGksAMizWmN/9IQspAYYRpPT2rWDx0K1oCtLBMe9oB49If+1WunQ3kmb+CW
	 oimnOT+HZeZz9RV33IPVze/J67ogy46mqbae2mCx98uwPw5mpaucFdnO3oLhj/pGBM
	 vRU6MqjuIcKuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Len Baker <len.baker@gmx.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ALSA: usx2y: Prefer struct_size over open coded arithmetic
Date: Wed,  9 Sep 2026 15:07:27 -0400
Message-ID: <20260909190730.3537245-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090344-refresh-reissue-e253@gregkh>
References: <2026090344-refresh-reissue-e253@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Len Baker <len.baker@gmx.com>

[ Upstream commit f02f2f1bf9d154148325eb60d74bdf199022ea52 ]

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

In this case this is not actually dynamic size: all the operands
involved in the calculation are constant values. However it is better to
refactor this anyway, just to keep the open-coded math idiom out of
code.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + size * count" in the kzalloc() function.

Also, take the opportunity to refactor the declaration variables to make
it more easy to read.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
Link: https://lore.kernel.org/r/20210919133727.44694-1-len.baker@gmx.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 36aa66de481d ("ALSA: hda/ext: preserve PPLCCTL bits when clearing reset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usbusx2yaudio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index a6ed4f0230b7f..3816d2d6723da 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -641,14 +641,15 @@ static void i_usx2y_04int(struct urb *urb)
 
 static int usx2y_rate_set(struct usx2ydev *usx2y, int rate)
 {
-	int			err = 0, i;
-	struct snd_usx2y_urb_seq	*us = NULL;
-	int			*usbdata = NULL;
-	const struct s_c2	*ra = rate == 48000 ? setrate_48000 : setrate_44100;
+	int err = 0, i;
+	struct snd_usx2y_urb_seq *us = NULL;
+	int *usbdata = NULL;
+	const struct s_c2 *ra = rate == 48000 ? setrate_48000 : setrate_44100;
 	struct urb *urb;
 
 	if (usx2y->rate != rate) {
-		us = kzalloc(sizeof(*us) + sizeof(struct urb *) * NOOF_SETRATE_URBS, GFP_KERNEL);
+		us = kzalloc(struct_size(us, urb, NOOF_SETRATE_URBS),
+			     GFP_KERNEL);
 		if (!us) {
 			err = -ENOMEM;
 			goto cleanup;
-- 
2.53.0

