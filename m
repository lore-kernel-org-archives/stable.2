Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046663;
	b=TQqdWBRJGiZBhGogym+WkijVf70+HavlfFqNhTND8lHBZbPt9lvLMvEyQ0f7Q03D3cgG
	 BkiVZIOj6eonaW9AOq0KYJnybMbCuL1MDhVtYmUGQalOA6DscqYppdoUT26OFboBrhLsA
	 PdaEeDD05UFqT+mpz1A/tXWk/vBeZlURaegS5u9LJ8ng1N2qoj2QlLZGIYWSLldlXlXQs
	 k2+ySDzO/NF4cq/NPGQfYni8nPkd6wayZ2jRkjFeYAhFmjalYX6krb+BroMPiM94/fyNn
	 KSwgPKvRUeDCMR5abE6VNzo7JVw032UOCIMXHlN2eE9C1c/Z90ohekjUhIyoW+FxGaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046663;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YYDytZj4yTbPxofbgrDg5auJIbb4XfcVPQlTvC7+lRk=;
	b=RWo2HmzR9y9Iu+yKfSpK8YxDtSbVWax12JJalqY5XDdCKs/9xrE0byQA9tDJh05qzd7s
	 ieqTt+sSbOLfIAKjJvylGxBkXGc+LVD5KWDgrZfTF+uodNt94+bFw+9rR3lHc3jj2zhkV
	 cy2MrOtWNBdU99cgtzivVxxcm7rZZBENsA4zgphmHMnMwTlijIurj4lK4WcHQgIEogPQQ
	 QTDSrQGUzw9hfgvj0LY89Ls+qVo3mWXe0xhVDtvaM4Dr+RXtnVOGZCa6ZgL1pBzZYr1M+
	 3OiguhbDXACuV4xCWvQFEWTsaa65FIiZhxTZgkoZaaJG/86COox7TkMf3oPbVV+YZ5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvzIyXO0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA45606D807
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvzIyXO0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF23A1F008A3;
	Sat,  7 Nov 2026 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046662;
	bh=YYDytZj4yTbPxofbgrDg5auJIbb4XfcVPQlTvC7+lRk=;
	h=From:To:Cc:Subject:Date;
	b=hvzIyXO0bx0+VVzX9gmzVtoTkqcR1BmWdSP9rEuSHrhpdSWcQaLLUBUviuySjoJxf
	 eLWWpo3SPhLh1QoUL2Vh7Ecd9Uu7uAhDPPmj69pIfAatC00Lf0GSDbNKzUnMs2NGqr
	 HzxtJ/IK5hotl6TIhWp5jzXtpl2WOzNxXp2+6bbnpHCG9HUwINkjDHskvyb/wYgvsW
	 5fKIp/9B+3h2kxvYrp8cq2nl1b/PMz1BpxXV9FF9olFhlbWG6BRdFyMU00QgsUMQZ0
	 It+WdN7x6dDosmHxNv3HYghOkFxnOSP4bBNewHF1CjIthcVrL29lBOTt8R71L8iNlU
	 S+MuGB7b9NVIQ==
From: Sasha Levin <sashal@kernel.org>
To: casey.connolly@linaro.org,
	marco.mattiolo@hotmail.it,
	neil.armstrong@linaro.org,
	david@ixit.cz,
	linusw@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/panel: ebbg-ft8719: Set prepare_prev_first" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:40 -0500
Message-ID: <20261107051740-failed-6.12-4eeeac9d7c36@kernel.org>
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
git cherry-pick -x 4eeeac9d7c3600a6cae75b2a7bc9c5b67530923c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051740-failed-6.12-4eeeac9d7c36@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4eeeac9d7c3600a6cae75b2a7bc9c5b67530923c Mon Sep 17 00:00:00 2001
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 8 Sep 2026 14:45:02 +0200
Subject: [PATCH] drm/panel: ebbg-ft8719: Set prepare_prev_first

This corrects the host initialisation sequence so that we can send
DSI/DCS commands in prepare().

Cc: stable@vger.kernel.org
Fixes: b00de0e237da ("drm/panel: introduce ebbg,ft8719 panel")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Tested-by: Marco Mattiolo <marco.mattiolo@hotmail.it>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260908-ebbg-ft8719-fixups-v2-1-5454ae1f5581@ixit.cz
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index fb9f9f42be4f2..1ab09c50a6306 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -198,6 +198,8 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
+	ctx->panel.prepare_prev_first = true;
+
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
-- 
2.53.0




