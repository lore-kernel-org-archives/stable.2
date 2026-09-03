Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C294F0528
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453811; cv=none; b=es7/DxiSJZ6QtJpD4/Kv7IthSQGi/21sDAxovSpLcWqlub+u01Wm21lks/NCqg2oXK89Kozsav689Ezs/PaW1f5WCHM23gajvG42DJSLFE9EOE8SeC6z0lTu9jz8IdFhFH1UL8IdmbJNjNT4z0Z1zE5Tk6iBbtVXK2AVpKHefcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453811; c=relaxed/simple;
	bh=CXulU9ugcVs/yCyjMFB12dfhXuE9IH7phZFtkCoFrBI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QRFML0/cEXmvvw+js/uSTgULLg+1KL+/3RFlIimCx0wHrXXpdoS5wDeT/D7BMPa/nWdptPPFf9qfuc0Bk25nB2b8IEM3/ta4w9AKtEOUCD+1q/RFmdIE/+WKgOWG56cEIktl4+GCGIZhQ9SKq9v7urzwmbTahE6JZfR2hUp7nzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6+ROWQ5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tdylXGNq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6+ROWQ5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tdylXGNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788453808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8sg4Ic+uUI0uGmJLbnp+7IK0wyVe9CAzpqU2xH+Oy4=;
	b=c6+ROWQ5UUQdmGn2N8jgzQ4WsIZpogGpMaJ7r51XcFdwEmEHQ8gWwj4Dv39yqfCY9JZthM
	KT3U6uWRA2su9WiQPNsCSeLVESsmXwHfTKp2hcUPNoOxyhCgKY55a9ZJUeq6bYr7xDWwiL
	sr3+s170a+WZOmADRWnAtxV3xc8KCIc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-7R9J-Qi0NxmpLZ4SRmBFOg-1; Thu, 03 Sep 2026 12:43:27 -0400
X-MC-Unique: 7R9J-Qi0NxmpLZ4SRmBFOg-1
X-Mimecast-MFC-AGG-ID: 7R9J-Qi0NxmpLZ4SRmBFOg_1788453807
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9390a2c895bso1098885a.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788453807; x=1789058607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V8sg4Ic+uUI0uGmJLbnp+7IK0wyVe9CAzpqU2xH+Oy4=;
        b=tdylXGNqqpvXvwpy0/7+K9soCjiiFW9jZ0tjkd01krRIZ7wMX0K0MPjinnArDUJUSN
         5AT4E9O4qOf8xxnNMjsSOIDwpgsVwwTtRlKhQ7SK/ptVvS1Yi8wDmV4DSY+6sHlWUVHM
         F+atvAF8ogtaXR3xr848mEypY2pvxELyhfg+r7x2Bai/NO6qcSidMwRzQySQ5XKkmTGf
         aZr8mvwr/Oq5bxp7MzMZFr9JUAV+sDZopaU6lD/5nc7MCa8pdUW28s4PU+0TyT6SzO79
         rguRUw3fR0N6rd7o+ZlycTawrF1n195EMSe+Cuazs7G+SAH1aQIMfKEtBjvqCrP/JH0E
         RiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453807; x=1789058607;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V8sg4Ic+uUI0uGmJLbnp+7IK0wyVe9CAzpqU2xH+Oy4=;
        b=Jz+IRxeNHWM27TsGjLKlHnR1wJ2zzEpbETjqr0iXl6mA/9SqhG1EyXQ4FYxHYayzyP
         E9KrJgo1XGB7d5/JiEPyg8kqLo8qx/wdz1NfrHitfu14e8xth9JP3A8QbLWwdAgH9bjV
         Vxj3b3IoxhRZSCqdQoLhYzSGKeRwXfjvWzKriPd6wAMtAiED3E9zP7FayYpnMEA6Qzih
         Qd4qKqFZiT+W5o498P8PaLEqKFT0b1tw0GYwQzJt0vFMf2omlQemoTMc5lOgBJ6ht7Tq
         dfTN5ZOmtvmDw4EvQG7aYM6u5z9u6tIfipawyTVpzr2xcyRjFZtIF4Ut3TmLBS4Q88vI
         KJAA==
X-Forwarded-Encrypted: i=1; AKwUvBwnnohhd87lWaUukWAgpGXkbqPd6OhdORbjTdq3/29PDkaw/1tALUxn7dnj+i9CMv/edcUtD+I=@vger.kernel.org
X-Gm-Message-State: AFuF++mFQ0eHM2DmRAN5c1da7Fjr6KJHBNSC5Lz2QRSwyt5qvLfPcwmF
	qm9On8IgVkJnfa1uFlZwv3XIyleLz5/umM5nl2o3CEeNDiimjCXBqvbCqvNtlX8EQFJNpKmiMXM
	XHtwOQVo5hxnjt77tNvCgcWSnEnyhRyTglbhmtz9mkyZabDVNqNOE5HvsPA==
X-Gm-Gg: AYBFou38QJ8U3vpgg/RT0e6H3lzbPo1lKCR5uJh8PgJ3p0vDyuYVYpomHGTYzWltmxK
	Bg764EzryWy+Z7MdvHge+sxp8owoRh/YzAsFgZPlxYMJmyktrY7fwLd3Ybje2Kmf8a6P7ZT6W1X
	Vt9bWYHAKmAVPPudiNJKaIj+LHYiaenOrt1BtV0PzA084Y7T3gYQyKQXrJZMJ1xLT+aNIblBn8L
	/gQFOszRboU8fXZo2IQsXVJ9/6/IGGY/MgjzTbVNgHJSCgcId2M8ja0GtYSnOAND9GsNiouWp2w
	InEPQ+JS8XuITDDBsiDCRS72Px/2714TE2svxOqgnPQXodfH3Z+fXMNHQN2mBGYWYWKF83hJorK
	WFpNzWtjkBIPYZGFod//1Crc8d+YN9rF5tLm/xmo=
X-Received: by 2002:a05:620a:6187:b0:939:6df3:d7f6 with SMTP id af79cd13be357-9396df3de25mr992474085a.49.1788453806592;
        Thu, 03 Sep 2026 09:43:26 -0700 (PDT)
X-Received: by 2002:a05:620a:6187:b0:939:6df3:d7f6 with SMTP id af79cd13be357-9396df3de25mr992386285a.49.1788453801386;
        Thu, 03 Sep 2026 09:43:21 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee270d0sm47491336d6.18.2026.09.03.09.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:43:20 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org
In-Reply-To: <20260831-common_clk_mt8173-v1-1-2d7241f70379@chromium.org>
References: <20260831-common_clk_mt8173-v1-1-2d7241f70379@chromium.org>
Subject: Re: [PATCH] clk: mediatek: Add missing depend for
 COMMON_CLK_MT8173
Message-Id: <178845378565.22448.12859439275506649984.b4-ty@b4>
Date: Thu, 03 Sep 2026 12:43:05 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=317; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=Y+oggqG3Z8L+JxkjNpwIvq7dXqEwG7Da2Hajvvt/Msg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJmLp4vln/w9uWnFpMnBh3+s5IzyCRo3jTeQ88mBbj8y
 GR/EvCgvqOUhUGMi0FWTJFlSa5RQUTqKtt7dzRZYOawMoEMYeDiFICJ3Ahg+O86/dGb5RGeNw8x
 nv+Y6dMhWWrzZE5A6oGlMo+NmKP7Cl8y/PfOydx3s8egMeH7vrvRv2R+z3jEeTuj8P9/m8aGvU3
 r23kB
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Mon, 31 Aug 2026 08:50:56 +0000, Ricardo Ribalda wrote:
> clk: mediatek: Add missing depend for COMMON_CLK_MT8173

Applied, thanks!

[1/1] clk: mediatek: Add missing depend for COMMON_CLK_MT8173
      commit: 84964d0ce3faed815e1b8e048ce5ce1c93badb18

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

