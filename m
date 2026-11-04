Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832828;
	b=cJ3d1jQ6A+65JVQ38kvrNpsCJFleQjGyOdeHbV+1E3wqmXx3+R+Q+At3RggmF4BUQGAV
	 QuxH+YvP/nnQd/Wm9GALE/qXoID7neMGyD3utrrF7COJEkXkgDWjFhvUm49tlfVOqt0wR
	 tS4TFM2i3Rq91NzmMUfwcXzpbyX7KWiWUMoUNKFrn7OVYSkwjO+aLTvV8+2UwNbk1Vfil
	 ATHDSkrfsawWmCluYaF+CrftmPxWCJY3KhSV+FTltWhJEDEiOSwGuYqG91o9dpFJEGXTw
	 Kc02fjs4e+P+auVA3jyNhNeGRqqT5pRv/0ZhuUGnAIApOmuenoj/VLFHyOUC7d3uBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7tGNI2eX9ZvC8wJYeM5sERNU+zBObcPkm9PiJEc/DAk=;
	b=n/ZWmEvWitdNxAM0uOS3oIRMgtKQf55MCWD4ov0Girv/X/kdehdRIMFAj1aEdycbjJ00
	 4xBGe2TaZIeMC2u5cJjDSl+hFtTIsDypt8FQeZv5mt1PfWrWo9BKNM3/aQP0p1V4HF3lY
	 7U7dWtKYGHs2d6G13JGMH/50q1wrV8I1sIkssjp2TvXyqfufI+fecto6XgPsJJQPeaOjB
	 l+5iIJG6EqWqajBopPl1QqlnKw0K+z7VgEKSLrxqJEQI9hSLzWa+WdiFrYyLyK7vxHkbt
	 5ijNcuTmyI02Wujf3DJ3NvA34a61tQJuUQXyGSKVAwlsygP671EPw8rC7i9N0Hz3trA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBVFTY9d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D710606A339
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBVFTY9d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC081F00A02;
	Wed,  4 Nov 2026 22:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832828;
	bh=7tGNI2eX9ZvC8wJYeM5sERNU+zBObcPkm9PiJEc/DAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OBVFTY9d5yqF9zrMvL+RV0T50eJyK/Ys92GgXxApnbglTTIfkeXzKa3hNVnjSDsXF
	 HW8fUvObaHvN1/BvGT+c+OvesDdV5+grKvx/Nlps+O/Qu8yO1ZjzWQu/C08r8aVJkq
	 Ud1T1haWlwPmIuplXnOW3GZjrIMiBJ/g4lAW/2b0Yn87AB9xfvChjd8bn2mcRU5z36
	 h1TKXMJqJTReIcVsOJJXrg2bifVcRrPWZPRjJ1MtlzVvgo4ETSZXVD2187808hXCFM
	 UiQB0yY878im7FcKkuj3ERf/4HPLIH046CFPBkM4FgZGNT3AFPjPJQXJCkS+NlZaNy
	 WCTbj9QN84dFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Nguyen <congnt264@gmail.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: microchip-csi2dc: fix async notifier leak on probe error path
Date: Wed,  4 Nov 2026 17:53:46 -0500
Message-ID: <20261104225337.850033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110443-shell-unplanned-01c4@gregkh>
References: <2026110443-shell-unplanned-01c4@gregkh>
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

From: Cong Nguyen <congnt264@gmail.com>

[ Upstream commit c7528789244ce7329ca883170fb9315d739ae985 ]

csi2dc_of_parse() ends up calling csi2dc_prepare_notifier(), which
registers the V4L2 async notifier with v4l2_async_nf_register(). The
probe error label csi2dc_probe_cleanup_notifier is reached after
csi2dc_of_parse() has already succeeded (e.g. when media entity init,
csi2dc_power() or v4l2_async_register_subdev() fail), but it calls only
v4l2_async_nf_cleanup() and never v4l2_async_nf_unregister().

The notifier therefore stays chained in the global notifier_list while
the enclosing struct csi2dc_device is freed, leading to list corruption
and a use-after-free when the list is next walked.

Unregister the notifier before cleaning it up on the error path,
matching the teardown already done in csi2dc_remove().

Fixes: 2de0b3c0f678 ("media: atmel: introduce microchip csi2dc driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/microchip-csi2dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/atmel/microchip-csi2dc.c b/drivers/media/platform/atmel/microchip-csi2dc.c
index d5b359f607ae9..19d6cc5984445 100644
--- a/drivers/media/platform/atmel/microchip-csi2dc.c
+++ b/drivers/media/platform/atmel/microchip-csi2dc.c
@@ -734,6 +734,7 @@ static int csi2dc_probe(struct platform_device *pdev)
 	return 0;
 
 csi2dc_probe_cleanup_notifier:
+	v4l2_async_nf_unregister(&csi2dc->notifier);
 	v4l2_async_nf_cleanup(&csi2dc->notifier);
 csi2dc_probe_cleanup_entity:
 	media_entity_cleanup(&csi2dc->csi2dc_sd.entity);
-- 
2.53.0

