Received: from mail-ej2-f17.google.com (mail-ej2-f17.google.com [74.125.228.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886BA4D9F7F
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361732; cv=pass; b=S6TCPpOTB40ooZKvBvGYD63C4aBf0ibxHMi+pP0zuVTHPUXHj1nk7zWCLTajWUQEGcokInrat0J9Vf8NyWzjoyiRcRrxxgixVf0YQDPidZJ1zVkbs52xY5CPzvGPyyPwdQS78Vl2aYqoJvVT/tUXW855q/15/jHm9TkDMTxUTUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361732; c=relaxed/simple;
	bh=EG2PHgTixg9rBHSr4w1yLq7tvCjPCFuWWWvAJw5rlQc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kB/qmgTnnKa6LLpqr12QPSxUF7E5ba8tI/vbCYiMuaW2zzH7Z2gNQNP3wcuyU3Muso5XgWT7ysGVBaVjwr0V/SGBKwUKrVLrvYpx3z2FoPnurwTdwDjW4g9Vj4bQHgPUnQpZvOUMuPb6Ghn0n86hQKU/UjifJF48lHk9tSD6zE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc3ck6Ur; arc=pass smtp.client-ip=74.125.228.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc3ck6Ur"
Received: by mail-ej2-f17.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so197465066b.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361728; cv=none;
        d=google.com; s=arc-20260327;
        b=BkPDfDb7h3ZjGNXedJ7LkMGRgxxEKrpkftjExh3BQDpvVMpbeM3OimtvxJZuH7o4t3
         4Rn6kKhyE21zJDBp1IVWZdz6Y1Bx0iZYYd67XuWFNHQOThrjKjh9hdjPQMWW+lKmzp2i
         cw8WsbEuyLUUtT2rXXZQob3xRtnweF63S6goDobuA9VjpjKe1uWzbDSLf9gkeWqNjw7/
         6PjBC8va3NCkgGr1JxlvHDBYuzjG3m1soFjNc9+JBsWoYSK4CXp0+WstLQ665qyKX3bk
         SswXGoIaLJpAi96ZtSTfyWeBAQA4+rCvgWDoNuS7ownyvSBLpAnbA9NuQI882IbcY1fo
         rDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=iH33DlG7lPeRyDNU7/KmTL8YXtHt+KDjYSFCKP0/eps=;
        fh=ZK9yLWvZuWHAcfOe1JTcSun89665t4VfwqIAp8QtY08=;
        b=DI+PHIqVz0GjmBak5SYw09hDFrQQNZNBko060yRhm1ZVaW7T+QeJBl9JKUj6ftOzGq
         5NgfYifvJ7hONAfByjJPpKze3Hj3heDr7mQws/rmdateGDPNczv2fA1tLT/LPZ4ZP6WZ
         O7rrNse1CysE0k3s0/Mi72tu8CtQi64d5bd25UO3FaJKg42HxWg2LbMy5MNp94OmuwpS
         Wfo/lqHeXr1tTNvVmrnrz67hE5BvK3ndjyWlVPRS4NyQljytS/x251UW2xBwjthGdORN
         q1T+PFGS3ISo0D7PDb2kdIzqOgULaxg6fx7W11iF3IbPLmzIWiBuIx+h0liX2iCnQSH+
         ZNPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790361728; x=1790966528; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iH33DlG7lPeRyDNU7/KmTL8YXtHt+KDjYSFCKP0/eps=;
        b=Hc3ck6UrOQDwxnK63GsfDThgGWBOpQd13H9nIYM+xizWrGjXwpIcJxg5DdJy/sPd80
         cwgzlsSbt0sFvuZu3W1EuRslN9S497d4E/pcYfB8xkS5kn0hgfdzrcmM/dHUaFb7PtgF
         GtBMtxi6zPDZbjknWJYdwEpACj2EsQYUJwcrjMbzPSmntWYwi9FkDT2xDnx6Y+5ihTO7
         B7Q1y4ZvMksps/7T9gdRKciyGQOSsXxrVSullgeU/EVyK/3Rtv9VPRqYu5zStJNclXmH
         Wx1lKKmJT77owEBdXgbr4QrbZbfvco51Z4QQUOmGyxR2ejj59HP5sWJgb0yJ4Ii3f2je
         IL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361728; x=1790966528;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iH33DlG7lPeRyDNU7/KmTL8YXtHt+KDjYSFCKP0/eps=;
        b=rC7tfSb6YSZHbAad2a2foDPMyEXMKL+ZOAxM8S/Au4tWoiJDWnJp71x4NfciKvHevZ
         vEQzMfNsHzkTcBXqueq9eNTbJJrMRzUaS8qtVzI3cfNU3eoKIBCEA+jfmPVSq+AD99HI
         GcPP9l5XL4LlhJpCnfNeh/ts/fR3dYqIzzQwWYYIUPziDsRAKNwC5060HAlwesGuySiO
         R0gsTF3NxESICgt5FU0Si+jiQuiPAsqrYuiVXFreMrXDCrhcSRyEDALbU4kOi8eoPg63
         LIoOC5X4bK4luX+4r4anUpfe6xNz5Wrl77t/I38uozZ0BSukEiYBl3PVcONNdqN4FIlK
         QMag==
X-Forwarded-Encrypted: i=1; AKwUvBzLfikh7bXat+OyCkhLrM8YjmdDZHb03QRgm39xHbdp1S7M8Q8KbKtqk+yCS6N4JrPtDiGXhxo=@vger.kernel.org
X-Gm-Message-State: AFuF++meAowt9zBA6yDtn6QqkvOgjg+W3oMDWQkYA6919tGXzLKuaaD+
	TUQHahlDrTR854JrIswsjid4/H1xa9GrWaCG91NRfujMD3UAnPcTdwXT2J33AboUavCVj7tb6+v
	4kX1TsY+CcYiEEaMnZHb/uqMeY7aypg==
X-Gm-Gg: AYBFou2LUIoxrPK6HAPJ/x4o29iM9n6TNenaIF00C6VE88hBUbZL/Dz3gSvEyZhxDeg
	7gzxzn0zwxNbtP7Ds+DIpMiAMmL4flz9QdJ+OzZ5AvLQ+Cr72SAxphMO2r5kONpK4N7kwcBrxDt
	zC40OhDoGqprPQlMGxkycnpdR6bqMzHVS9WwFK/Tl77eLWaDBgISjNCN7a8ACdktAm/uYStDz1m
	36QleBzKIm4ZcHl+ywqMYp+n0FwODP05uS6LeQI8iiB4rdoz9FQjCYL3C3NyJ5JvSirSNDoPMgb
	iq9o7dmuveM1UVymVeZuYaB4h+nJ5zLhY+0jE9kaq8uQnI/R2ECB8b48gXB7vaAWs1rGxgTHUPy
	c+wQw8O0mf8iZTR22ltCA5iOdxniMOh6dPsYxkwNRU+IHTdOk1FBZi/9FFzEi0CXGKlrtizWcAZ
	k=
X-Received: by 2002:a17:907:e918:b0:c2a:9e6a:3b4e with SMTP id
 a640c23a62f3a-c2ac228e60cmr610461666b.0.1790361728266; Fri, 25 Sep 2026
 11:42:08 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 13:42:07 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 13:41:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 25 Sep 2026 13:41:44 -0500
In-Reply-To: <CAGEsz8Hurq=5MJXLD5uA-+uPJdMp55auATafawac1_3mpv65PA@mail.gmail.com>
References: <CAGEsz8Hurq=5MJXLD5uA-+uPJdMp55auATafawac1_3mpv65PA@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 25 Sep 2026 13:42:07 -0500
X-Gm-Features: AclHuK-11njtSOspeCyZG4OM6KWbRhEYVXC0k2M43DNY4OjfE88LmT1g-L_uDk0
Message-ID: <CAGEsz8H4wT2Cswcr3g+5KJJDek0GACj1-gbFAC_NunHV+d78JA@mail.gmail.com>
Subject: [PATCH v3 2/2] media: amphion: prevent unbind while video instances
 are open
To: Ming Qian <ming.qian@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>, 
	Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

An open video instance holds a plain pointer to its devm-allocated core.
Unbinding the core or its parent through sysfs can release that memory
while the instance remains open. A later ioctl or close then uses the
stale pointer.

The video file operations pin the module, but sysfs unbind bypasses that
protection. Suppress manual bind and unbind for both platform drivers,
and warn if core removal ever encounters a live instance.

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/amphion/vpu_core.c | 3 +++
 drivers/media/platform/amphion/vpu_drv.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_core.c
b/drivers/media/platform/amphion/vpu_core.c
index a0c58ec97a42..2e8e08e05de7 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -696,6 +696,8 @@ static void vpu_core_remove(struct platform_device *pdev)
 	struct vpu_core *core = platform_get_drvdata(pdev);
 	int ret;

+	WARN_ON(!list_empty(&core->instances));
+
 	vpu_core_remove_dbgfs_file(core);
 	ret = pm_runtime_resume_and_get(dev);
 	WARN_ON(ret < 0);
@@ -846,6 +848,7 @@ static struct platform_driver amphion_vpu_core_driver = {
 	.remove = vpu_core_remove,
 	.driver = {
 		.name = "amphion-vpu-core",
+		.suppress_bind_attrs = true,
 		.of_match_table = vpu_core_dt_match,
 		.pm = &vpu_core_pm_ops,
 	},
diff --git a/drivers/media/platform/amphion/vpu_drv.c
b/drivers/media/platform/amphion/vpu_drv.c
index 2cca61f41bea..9c6f32c5eae9 100644
--- a/drivers/media/platform/amphion/vpu_drv.c
+++ b/drivers/media/platform/amphion/vpu_drv.c
@@ -205,6 +205,7 @@ static struct platform_driver amphion_vpu_driver = {
 	.remove = vpu_remove,
 	.driver = {
 		.name = "amphion-vpu",
+		.suppress_bind_attrs = true,
 		.of_match_table = vpu_dt_match,
 	},
 };
-- 
2.53.0
