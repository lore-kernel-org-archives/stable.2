Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD84E430F
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361747; cv=pass; b=TC/VJvKMpvcfbdIfwYw6NtjmniX9EHHPLxnwZnOV8V6JKSeyX4sELsKgjL5m4L+7v0BGf0YTIrgb61AFWEu07e+KZAOxYTuHif7GeJNrbOigZOl1Qk7H2GW6PlZO+1BOl0MjxHBub9t7D7i4UCEKVETF6/mozbyAFOXjWAcWinE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361747; c=relaxed/simple;
	bh=hrTFA0SFmbn2rhmMV3Ste6+KH/y0c6VQdoL8hcnAOM4=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrGFGqDEekrvTcvw6ql1ORWDUhwFiTBBjoDxKG/2X1/JkYGMMMysix40d6Xaxind4wlAmuwYMbYXT+tdxfThtGTjpY4vPOGIFVoJRDY0jKyQ0IlCkOXcQcpMtt980ZGJxrETfvg/QLFhGok/7t1JcxO8RLOrxAIIs1See1Lifp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pO7e4zZo; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO7e4zZo"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af22f8e38so104360166b.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361744; cv=none;
        d=google.com; s=arc-20260327;
        b=mxhElutDlWMFtc6sqdt+u0OZd0RPy1rlFEKkAawZ+TwtoQ7TK9wFvguJ/N/DGyxO1U
         qOt50hRsJ9ivzF5G6m/3JJd+FqilTB7ihnJ6Vq3zypJkzUguKnck2pEDBcHdXMfJ23rY
         /EBy23gYXJb+DDU9/0+T1Df7QrIRhLiITjp34MvDG5PeStSWuaea+vx/up+XnOYophf6
         3jZDilST912F30Q2p9IaeR+tR5pagrakgUbgvVixSKVAZP79ASGeLNIIjM9MB3KKhSpp
         rStbPpKXsbNBibjWbAuGyDNu053wFdLssMvVSL41K6nYtLQBlORGtlxxYK53WsJ6kJNp
         gWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=zYr/lFJO//fpk4Ze4BmIq34iQIgTlgcqYAY84Z7aXAg=;
        fh=NdcQgtBzfICaNz96+IlhCn2cnea7HHdMKE0+0j6BYfo=;
        b=Xv/AnUa2RI5iq/cYTxrXWlk7i/nJYrCxDubid8uapdGz5ZeYvbiGR/z4uPMfG6SZn8
         gcidDDGdN/P7hiixB7pKhfA3/2qKM15naPL8QG0SV9g1rAFYN1bxER6zc5zEOghEgeXn
         SFgeCVa+mRb7nh2ZRwYvEA0ovdtJgKxwI8djj5mAet9PUrdngkztEUFLAyzvTkwrtPYK
         mtsCX90mzJYeD7cXaPcf5JvULsa50HmreQ+Gc0PYdB7urVLNfgOQtl1Ob5uGOe8flml/
         zQeCQSbznVBhNkuYijhQijvXen8LUZQWRpW2pdkCaAycP3jgiZEJ9T6UMQ7BW8T3RJ3X
         6WgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790361744; x=1790966544; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zYr/lFJO//fpk4Ze4BmIq34iQIgTlgcqYAY84Z7aXAg=;
        b=pO7e4zZo1519ppE5GIz7ojI4kdnqQwVuj82ZTdM+2vrqECGG/E25Ld3Q4tW12Rdc/R
         Tz+E04YrbkoLZfXVrcMqzOcrmlvaEUKygB/asD9o9Zijn7sW6Jopn+e8Hd3Cy20zvofT
         cM8gwG3i7nDA33Bn1keVRr+fvfbTzuKPRFa3HLFkOc0t8ZBnk8Yu0CaNcn5zBfNVuDZY
         /K7AyIjWEzQGdiIYN9AI6hRqHVOgmpHuFE5De2aXFiVg+DnPMqt0HGAQyZ/WoXOYyRKz
         bfDF0RFeo61dPkkZi8inB/Gqcbm/JJCj7OAEPvv65ETHGjcltWdAhErbSaUEsrRSYffQ
         9ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361744; x=1790966544;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zYr/lFJO//fpk4Ze4BmIq34iQIgTlgcqYAY84Z7aXAg=;
        b=dpGGVR418UDyYAWxu6vHsj9M4cKp7s6jNtPiCPTZ8H1UshrcY81lyD8yCPPPXYlQEi
         3nqGAoGMt5Pv6LqnQEgO1qaZv4ftTD00jszCPGM41KVah/zNsLym219+jBTKQ5O/U7+t
         c0V/bGVvrbt1hUptuFW48MWMJYxLQGEusUButjsWIae950v5PRhFTBh+I1HzOSGndp4G
         gMKGmMZiFBjv1KUW7gnez4aaMoM8GlUaa1A670sao8keZwvT8jlSJ5kF6hBwQ/6sUX0T
         JVvlSeRSck/kSajPGetAthqCUBnhoiWpBiN7/fYPo6es5oLvnhvtceqQcT/rU9mXBz6W
         dNcQ==
X-Forwarded-Encrypted: i=1; AKwUvBymkaK8Q474sZhynFUdRkPyMPXbVnsgVHtnmXP65b71bHLUfXZkMqwg7Hobcox+VJ3Kco55ZA4=@vger.kernel.org
X-Gm-Message-State: AFuF++mPj7zCVZeuLbxUOY7aYPoQpeqc2Dowy25FVTsWYk1Qg1GlpzvX
	G1ltrnzrTC2nWZafvWW93yX3HZ/L4O5V+h2tVkhAN19LuTJtVqxCHLti7bXh278clJp1oRt/dbw
	rQD4Ql5vqFJHrLZGXHvtuRN64TNzTog==
X-Gm-Gg: AYBFou2UXAWh+eE9nv8gGf9ex+Yq8hfWadZpC8iIYhYa9YJB/kNFML/vwSCrQ+ZlFrM
	DD4DChK05CSY9Zol8XY49GG3kdNrN5jIFsyT+uzVLqsvj7PQhsmCjo0VqcI3ffqssN+crIbYmfY
	EG3eH5hQDq7/2cldqS0xFZ+eXX5gElBSPy1leEV7KQhr5Dl73G7RmVNhrNKKKp/i8z5PIqkDALG
	FP1a5s356HJejBQQ2jyo5UdKvJgCw9MGtnG+bPAXr/3/2J/YFefbkdEAag1CAorMcamCS6wIonT
	GVxSZfUezhxAlY3KK0vBFUjzAZX8DauVQIhVacxVsdtWqOn+Cc/bVSa9qIC2gtNLB8mgAc3/89E
	aWLKRuqwfagt6lGM8GzAZSI7maTibULuAjoG//1fJvut8QhwpAlHgvn8bSCBM4uTw
X-Received: by 2002:a17:907:c602:20b0:c2a:f360:1c67 with SMTP id
 a640c23a62f3a-c2af3602870mr155361966b.35.1790361743598; Fri, 25 Sep 2026
 11:42:23 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 11:42:22 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 11:42:05 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 18:41:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mhun512@gmail.com
In-Reply-To: <CAGEsz8HtRE-sAM2YfC0_Vzcq9OeuMiRVc0cMTpWogt0Uwc4-1g@mail.gmail.com>
References: <CAGEsz8HtRE-sAM2YfC0_Vzcq9OeuMiRVc0cMTpWogt0Uwc4-1g@mail.gmail.com>
Date: Fri, 25 Sep 2026 11:42:22 -0700
X-Gm-Features: AclHuK-b91Uq58Jkr9vpiDUZfFWzBSqSctMSgFDJ6Ik34Htw_8K-UmJ0z9VCStU
Message-ID: <CAGEsz8GXrP1p1HM3TNJ4nWnL0GLqgp=pjsiwA-v-28wVosjtJQ@mail.gmail.com>
Subject: [PATCH v2 1/2] media: venus: hfi: disable IRQ before freeing HFI device
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

venus_hfi_destroy() releases the interface queues and frees hdev before
calling disable_irq(). An IRQ handler that has already read core->priv
can continue to access hdev and its queues after they are freed. Clearing
core->priv does not revoke the handler's local pointer.

Commit 640803003cd9 ("media: venus: hfi: explicitly release IRQ during
teardown") added disable_irq(), but placed it after kfree(hdev), too late
to protect a handler already using hdev.

Disable the IRQ first so that both the hard IRQ and threaded handler have
completed before clearing core->priv or releasing hdev.

Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260612103333.5585D1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c
b/drivers/media/platform/qcom/venus/hfi_venus.c
index bd82066bb6e7..e7e4e78a186a 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1689,11 +1689,11 @@ void venus_hfi_destroy(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);

+	disable_irq(core->irq);
 	core->priv = NULL;
 	venus_interface_queues_release(hdev);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
-	disable_irq(core->irq);
 	core->ops = NULL;
 }

-- 
2.53.0
