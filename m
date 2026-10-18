Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513113D9DC4
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364086; cv=none; b=P+DYaA7bxaeHYZlzOQfsrg2qGHXCKryvN4uR7OHa4AM8wVbziRQxSm924q6DCuosz/NLipCPz3UUX36t3GmkRVr20xObJLxHgNMHEXzQx6hy+nzkYO7v8jZSiv954TqQR7+H1MP9EB7OUVZQXm4N1D1f5JBK9DXc4ZHhct4qsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364086; c=relaxed/simple;
	bh=shS/TSAUSNZgZFv/tt5i8sgh58BoIorLEH1w73xfFIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CppK5bOmcxJJGfAjx806pWMtN5cf72qqMwAbQhwXOJ1MfrZtPOuZnY5rGFjzEm/gxZ0lXxWzJbxsZDxIVlmbDyx2Lw0698OdnpBYE+4Q8nlsYOpaU74aDC/qoV7ZpTvmrxjCHSVDMKvvnM2IXdZkS4/qeeRzRVxRXkIS7wvVPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyJqh3Ht; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyJqh3Ht"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso17792315e9.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792364081; x=1792968881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HdnS6jJ+HWOjTYJzZVT+srPkMgBGEUBcpFnCAxSY30U=;
        b=iyJqh3HtVLN/JmrJbNJCnRK/Th2aF220EnY3746QupEgxPL3R7i9U6hMrA+QblFW/I
         RygZBY20FkmzCSInuQFl1YqcWSyijx9xyS5yqvmI9W3GgtDlC/16TsTys8/ODZGqBKlR
         Sbx/sW4gNDkcUJe863Mm34uDdAjlrqIcKsUy8wb+gqkkmAbwhhFJZ/ehUB7BEgNRv/lQ
         Ng1yKAJ1CkPYtdd8IK8y7QbuJtaYkCXBu62ogY1kMTMzPQ8IY2pS22eJhS9wubJ8WGh7
         YOsxjggXtbSwyUseR2iOpYin9LSqhBoYrOwYiAWASI7PtySOFhvHCPubhJiTWKSbOa53
         bhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792364081; x=1792968881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HdnS6jJ+HWOjTYJzZVT+srPkMgBGEUBcpFnCAxSY30U=;
        b=ccnLuTJPodddgjs/5hlrS6295i0ta0bb67it3O0a4xlpDgJrPjIj3z1T4bj1nNKIHH
         K1ik2FUdwOfT1/z22jy5gA/FAWDPutbT1fXsbw/Q7oqcxPxhBuemTMB3N2m63u6ixx4G
         rVnuWrwhNgJJhE2D4Dcc/F9X8SjjYGJT95SXzWjrYUCQjV+Wfmj3RURBvoqmu5I+uaFZ
         htDbmGLFssKT4EEN9zlvMLZgkq99kS/V41Gu/1P1d9cm3HhICrR3TqLHJ7s5gpSwsiJ2
         HRAsDxq5wnP/4sozPS9zTRpiBfETRIX7eeqW6pJryN/Cf/J4x2ITFPAMJFUNvasxuF3D
         1DOg==
X-Forwarded-Encrypted: i=1; AKwUvBwoX4pIAbciexsyr042TWIeHjwfHaOzhimeKvViy3NXTIca9JYoGdFUj/OxXfZfEYqj5VsOBFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3aDIydpfwmzgG/JaGs8fN28MKd/OK+DxurjilDmNwRagmlExl
	WvKDttZ7Ijf6HIDitgV7D01qfbcSfhelbLmQtEqJWClABivdaYU7Xsc=
X-Gm-Gg: AYBFou2D6BzHVI+fBdeJDrLRd/KEe3XBpQ9Ivtioj5gVxCakbiGSqaSQ8NP33xg3Zr3
	auYdTWUxPh+BjcpymbDdQ0Z/brbV9dlz5lZr0qTQw6e5rWsHzv5YsguyCph2eIXZHTcvi5pzdUj
	tY6UnVSejx7OcZsO70/E1oEGJoS+d/TwzWYeuuB2J4ta61z54hh9OK8ZqwwiMMVW6TlGv3KzfZD
	4C48iL4js8ZIWWnffgC+vZYblUW3DKsLHiFsGbMWwksWvpW4c4leo5ytLu226zQ0vjoikBO4fgL
	4NtWvEnCLtHBirAZYu775shxg6AlKA80sU28FT856YiEPAeIZUYJsxH3DeKvHyUarnCJd3j9cN/
	ljAQH1pflMHBRDAvP5Qiuw2CQRbsw1rAIU88S9QSvLTIu8L+GwBEgLiPrrJLClZHkotf1BqNx1j
	sSuGMLCCQEDF5c9Tz8vRuCWje+QlSIHPWTu5cOL9nJeyHNK/C3XA==
X-Received: by 2002:a05:600c:a48:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4a1d7612bf4mr127226165e9.17.1792364081099;
        Sun, 18 Oct 2026 15:54:41 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e19ad17esm42257355e9.3.2026.10.18.15.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:54:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 2/3] media: cx231xx: require minimum VBI transfer length
Date: Sun, 18 Oct 2026 22:54:36 +0000
Message-ID: <20261018225437.2655311-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018225437.2655311-1-tristmd@gmail.com>
References: <20261018225437.2655311-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

cx231xx_isoc_vbi_copy() enters its processing loop when
buffer_size > 0 but then executes memcpy(dma_q->partial_buf,
p_buffer + buffer_size - 4, 4) which needs at least 4 bytes.
When buffer_size is 1-3, the subtraction wraps and the memcpy
reads from an unintended offset.

Raise the minimum from > 0 to >= 4.

Fixes: e0d3bafd0258 ("V4L/DVB (10954): Add cx231xx USB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/media/usb/cx231xx/cx231xx-vbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-vbi.c b/drivers/media/usb/cx231xx/cx231xx-vbi.c
index 338e101484653..c019649c62210 100644
--- a/drivers/media/usb/cx231xx/cx231xx-vbi.c
+++ b/drivers/media/usb/cx231xx/cx231xx-vbi.c
@@ -92,7 +92,7 @@ static inline int cx231xx_isoc_vbi_copy(struct cx231xx *dev, struct urb *urb)
 	p_buffer = urb->transfer_buffer;
 	buffer_size = urb->actual_length;
 
-	if (buffer_size > 0) {
+	if (buffer_size >= 4) {
 		bytes_parsed = 0;
 
 		if (dma_q->is_partial_line) {
-- 
2.47.3

