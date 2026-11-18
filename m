Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043837;
	b=lhDR+t9o0ac7ZHixgtJUoxTfaI4znADH9qk0ufoNQ7FWmQ3zO168tp1mFlTuPIye7ACc
	 krIDtyzOMA/u9I+1vH4ZUsOvLV5vBLzdDsf9viGs6E1wGPQh2r95aMrKQ2IJS7F+gMkWu
	 ExHAQsXE826r8Yio4cinXK4jdygiyFwdgpUBPfYKsakqjOt06WhA7Aeur2i74HlEPBjAW
	 Eiek1ey9RMqL7+NMdHdbXsH5cklr4hcbUX0zNaqDCMGnKKSSmytjElaJuyPbN6f/0MgX8
	 uttmBytzz+MIcJaWRBhwhkIxFdUzq6lvXrzzmcDJOkxYYvkdj8EnEvf2B1FRiSGphEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043837;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9CeY2H+xs1/uP6Al65hZcJhz1eI/t+6B7af7ReXxmio=;
	b=SAR3rW6ytCDBHajljeMcNtq6dMzL5kAoxQMroKi9p1D6+S+xr3+UXasELgjVsetY2zpL
	 bJfo1GsF5zMZfTUwQ1/lB/7lf85/ejXsmhn+Yh14JfWlbj9fcnbI5kmNlTHojxqwNAe4/
	 ygAlhMtrTL9UoeG7SXCeFzlVEjrTImHbXcFHNoQUypzGuEGi46drTuRtAF9NAhGJPH4YB
	 dgF+EUWBh8xEau5DqeAbdDuyyrHUZ7QaAICMz6jYQZBYUJN05e6q/OB7+0Ys1LkXsSIvo
	 cTypv3ByLUv2Ya0lhBIrXSUttNiMwYZF+SjmGaPu3j59Rn9AGUzVYLhn4kN31pI53Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eB9KIEms;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510260A2607;
	Wed, 18 Nov 2026 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eB9KIEms
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795043837;
	b=KZAhjkJNrkRajDLFanC/3Sq5h41vlCENifPQSg1qfjLs1aJpQHZlz8qZRy81nhGBo4u4
	 HLpQgCGKXZoWDo+xCS/HXBOnei1Hs3aI1DkfygNxLMYw2typDtvp4f69byQk7oZRZc1Vg
	 33YiUgdhRCaZzQs+jnhWHjnJTyQMdWw2imssNdulNmf9Nszco4dEZWYDhhkCwpBawf+Hn
	 g5e0FaAIusNhemI1ueDLQhLfqeKmX7Xt1x5QcbqHvXbkgy43SqAaZSe2Oo6Z6sM18GX7F
	 AcqB8/uows7IrMMCydchPo2vbtQh6TdUJXrV+HaTV+vN+34NMhxTAJp86vE/h0efkLA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795043837;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9CeY2H+xs1/uP6Al65hZcJhz1eI/t+6B7af7ReXxmio=;
	b=TGzPfIIXrz0YImeJOgsUCoBZOp5yAoCNIJhORSUgcc+e9X4LShRd1ZXu3Z50hISkUmSJ
	 4EtTclvr17YLox9PERroRw1wC0iaYcGh/0fzQS81wS7S/oPiOM0PjpSbLnbNtlq/wXKKv
	 NFKmbTKJ3VoqSgv38b2QTYxaCCpv+VJsn+/U7n9FWebXkv6Iq97vFHDMj5lnwSpQUUYd/
	 oQYCm9tml9VNTAhP75YzvgTshxzMkDnY64VeSy4Ee+fvhYV4/4OpJUQuk2stMw7+3OXel
	 GWkbTPA7DzxC2PpffCnyQiY9BfrWpYy9QgAYA9aYjkZXS1Ke9bDFlf4GhQynaosypbw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B7DB11F000C9;
	Wed, 18 Nov 2026 23:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043837;
	bh=9CeY2H+xs1/uP6Al65hZcJhz1eI/t+6B7af7ReXxmio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eB9KIEmslW5ZrbP1xXQKV1Dw+n3fpU429nb9V5lc9TPrYBhv9xtNg/MhPCqybbF+k
	 t5Mvci3IaHZ9cMoKdABQfiORhpafgQijRKCdN2eeU8IEH8wR/s+qRwp7zDy7hUYCgX
	 L/HBZfRFaEFrzUSb64JEBsPPILG2U0pQ4UGIve/Of3jCwbzgsIOqctLW1Ud8Ql9z3U
	 kfjHvLXX/P3NZmZ7ArNi0iZZgcLRSd2G/Ayxph3QpMF59NHAsO9y0CCH90D01teK8J
	 b5O6T10EzcFi8Epxup7c5JZF1G3IDAJCCB/ZSnO9XhKTPqlTCORFtrU1YALxc356UG
	 zfdnBDHsKdvYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 489AD4B01B;
	Wed, 18 Nov 2026 23:17:15 +0000 (UTC)
From: =?utf-8?q?Alexandru_Andrie=C8=99_via_B4_Relay?= <devnull+alex.andries.aa.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 00:16:51 +0100
Subject: [PATCH 2/3] power: supply: qcom_battmgr: complete ack on callback
 payload errors
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-upstream-qcom-battmgr-fixes-v1-v1-2-ca83700c08c1@gmail.com>
References: <20261119-upstream-qcom-battmgr-fixes-v1-v1-0-ca83700c08c1@gmail.com>
In-Reply-To: <20261119-upstream-qcom-battmgr-fixes-v1-v1-0-ca83700c08c1@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
 =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795043834; l=4014;
 i=alex.andries.aa@gmail.com; s=20261118; h=from:subject:message-id;
 bh=4a5S/RCiOR+4vQvgLxF6hT1Z621jRwseAFd13o3O2w0=;
 b=CkKPXNOplgo1JQ1Ks5iRvi3VDP4HJqvXCRCoVwGYk/kboEMLmTEPGZKDftPrE4glT65Y/l1pb
 UZd0A/aH3UVCuFfCyqn20nYFE+QowQ2EtzPvLLbSBJnrkb7Gugg10zQ
X-Developer-Key: i=alex.andries.aa@gmail.com; a=ed25519;
 pk=kNAqgavfB7uUd1mA8o8TszhGxzyqBwY71PGO/oK4v84=
X-Endpoint-Received: by B4 Relay for alex.andries.aa@gmail.com/20261118
 with auth_id=1564
X-Original-From: =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
Reply-To: alex.andries.aa@gmail.com
Content-Transfer-Encoding: 8bit

From: Alexandru Andrieș <alex.andries.aa@gmail.com>

On unexpected payload lengths, qcom_battmgr_sc8280xp_callback() and
qcom_battmgr_sm8350_callback() return early without completing
&battmgr->ack, stalling qcom_battmgr_request() for 1s until
wait_for_completion_timeout() expires with -ETIMEDOUT instead of
returning -ENODATA. Aside from the 1s delay, -ETIMEDOUT causes
power_supply_uevent() to abort the entire uevent on firmware with
mismatched property payloads (such as shifted BATT_MODEL_NAME IDs on
Xiaomi SM8350), whereas -ENODATA lets add_prop_uevent() skip only the
affected property.

Set battmgr->error = -ENODATA on short payloads as well and jump to
out_complete on all payload length errors.

Tested the SM8350 path on a Xiaomi MIX 4; the SC8280XP path was
build-tested only.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Andrieș <alex.andries.aa@gmail.com>
---
 drivers/power/supply/qcom_battmgr.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index c07e2db8f242..83e67d22c432 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1285,7 +1285,8 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 	if (payload_len < sizeof(__le32)) {
 		dev_warn(battmgr->dev, "invalid payload length for %#x: %zd\n",
 			 opcode, len);
-		return;
+		battmgr->error = -ENODATA;
+		goto out_complete;
 	}
 
 	switch (opcode) {
@@ -1300,7 +1301,7 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 				 "invalid payload length for battery information request: %zd\n",
 				 payload_len);
 			battmgr->error = -ENODATA;
-			return;
+			goto out_complete;
 		}
 
 		battmgr->unit = le32_to_cpu(resp->info.power_unit);
@@ -1325,7 +1326,7 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 				 "invalid payload length for battery status request: %zd\n",
 				 payload_len);
 			battmgr->error = -ENODATA;
-			return;
+			goto out_complete;
 		}
 
 		battmgr->status.capacity = le32_to_cpu(resp->status.capacity) * 1000;
@@ -1388,6 +1389,7 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 		break;
 	}
 
+out_complete:
 	complete(&battmgr->ack);
 }
 
@@ -1403,7 +1405,8 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 	if (payload_len < sizeof(__le32)) {
 		dev_warn(battmgr->dev, "invalid payload length for %#x: %zd\n",
 			 opcode, len);
-		return;
+		battmgr->error = -ENODATA;
+		goto out_complete;
 	}
 
 	switch (opcode) {
@@ -1415,7 +1418,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 					 "invalid payload length for BATT_MODEL_NAME request: %zd\n",
 					 payload_len);
 				battmgr->error = -ENODATA;
-				return;
+				goto out_complete;
 			}
 		} else {
 			if (payload_len != sizeof(resp->intval)) {
@@ -1423,7 +1426,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 					 "invalid payload length for %#x request: %zd\n",
 					 property, payload_len);
 				battmgr->error = -ENODATA;
-				return;
+				goto out_complete;
 			}
 
 			battmgr->error = le32_to_cpu(resp->intval.result);
@@ -1514,7 +1517,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 				 "invalid payload length for %#x request: %zd\n",
 				 property, payload_len);
 			battmgr->error = -ENODATA;
-			return;
+			goto out_complete;
 		}
 
 		battmgr->error = le32_to_cpu(resp->intval.result);
@@ -1555,7 +1558,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 				 "invalid payload length for %#x request: %zd\n",
 				 property, payload_len);
 			battmgr->error = -ENODATA;
-			return;
+			goto out_complete;
 		}
 
 		battmgr->error = le32_to_cpu(resp->intval.result);

-- 
2.56.1


