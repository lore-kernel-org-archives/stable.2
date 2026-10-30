Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356470;
	b=wQiFDS47PUkiVFC1jfQhPz6mN+GyaGmHrZqDJzPaMYBThwoZP5OXz8OUywZ8o5Gh20xP
	 4V+kOOAUksxDiK+ztnGHKq2CEFVWNpH9PWIwH/mA5vRrN5NBtP5FvZBMi13g40UpXWoFL
	 O+gXy1PC5LKJgTGEl+6QNZICFc1vTCIYH48SjyCXUNcDKl89ziI8PWrFeLSEtz2FCUOjv
	 PIttSNrNrzMivJIGvDkgcazqsxrlQGn/TJy7MlPZGe1aGkEAtyYfZfG2wItxS5w1Z3Oea
	 i486mgVDAFVJm4GA3xsMz7Eb9SytKSfbxDoidX5Ft2eG+jwzaHBOV/URYXa44WYfXuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jn3WWUSpxlxzquDqb3HP/nQ4UVG0PTGaWTA+bx/jhoY=;
	b=fqSmCRPZyZiNxPkLNra+KCcihkj/RQ8NT/GKYJ9JdHi7fxThAlNXuUfL6r3BfbTJjLnk
	 BmNn0w/dmSE/rGYOhKSQlO7afctpu7maYq6VQppNfxO/qCnGtEOmVckkpuzguPYCFkiVD
	 gjYnoarZxIxoLDgq4lW0hgK3sJTVGascZAfHU8BOMkWqueZHJI0SsJDwIypxW/JKHVe0j
	 p6xUlDJvMK/a04XpxkQKaQcCYjEo22LqdQFXsgqU+lGv/RFft/s4uWSy04IFYu6tq0dh6
	 XBykSgylhKRMol1axG12ezcgxaIil1vdJ9CppJzqCPvwVVuCXzw0ZfHO9kOQcTzipVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R7uPye9h;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1D60A380D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A1D60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R7uPye9h
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-369f33df08eso1184176eec.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793356469; x=1793961269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jn3WWUSpxlxzquDqb3HP/nQ4UVG0PTGaWTA+bx/jhoY=;
        b=R7uPye9hRRylkWD7+S1Qq+9noxbzbRUtgQmloxbZFB0mH93+b/d4x0BPq+mQmQN7dU
         QeP/Vfj45dqmfhySc6+8DLyFFL74SX/z/B2TLJ5x0UwrO50x00Fi9HT6UhOpR6X4Kja6
         YIEQeQxwedq2BW+pWYex5AH8EzyNCfn2squnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356469; x=1793961269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jn3WWUSpxlxzquDqb3HP/nQ4UVG0PTGaWTA+bx/jhoY=;
        b=yENmaQKPwFcFSSs3L4iqgCAPaJ8UMddMMwbz9nN89/8JybEbMyutaUqnJYx+Ba1bpJ
         sx4mZXbh2mO1JqiSuQqcMJwx7X6LJARB3/cSepC0kIjZwBN/z2NnHPh3i7LFm0uE/Wwx
         Gvf1v6fNJOI516O+gIM9cBFepb5CtTpMQAgeNwie2nag4VV0fGOF/dXlyIaILaNEW9MY
         bcpQGBPp5HHcPPn7fCr/E0Dp/8OQ/JyFcNaEQAm0D6zteyhklx4GZM2ZvV5u7GJk/97F
         rCD80WQriFHCA+GvB8lDLBQb5i0tZlBhtnJGo/1yxUOvdW4xgrr9liR0gPXHWNIVsuCE
         sz1A==
X-Forwarded-Encrypted: i=1; AKwUvBxQg8wK5GSOWMyvX1K1dFtnWsKzeZjjM7oDPYZaqwo/i9b571/S6WPxug+D+80vOTN7ycNSuYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJso2eno0BJWxWgnvFmAabGXUvaQSeyED773CEh27jpYmnL6MI9
	CBPIZh51gQQOHArhXKHXklFpYR4n8nsUITsyQfQfR0rq97bTPB0ipPnIoLJpBSF0aw==
X-Gm-Gg: AYBFou1mnGigo6DzrxsvrTUJo+0gb54g6PeKxPFD24RcavH4zMzAzFsBIGCptYtcBM3
	q1jL6Yx/SxmrLHu608jySVQ9z9Ug14FLHxXk21DJrL+Kp9bugqUlyttGxFsWrgrjOv5z2ZVCsD4
	jHJmUU+g/M12OqXiduBaOv+Hgg2m5+ecRee82ye6DJzH/7VrOvh5c2uj3Op6yIaBjuTWU3j3B2B
	5OYYaTpw3dMx94yCN8CEiu/Rsf/m/0Kb/a6uYVK62SnRCg49bmq6vpDJHOyxMA2RCtFg3h6H9W4
	Yce2qK7XmIM+E1bWHg32ysvVB+Ol26z+OynRnh8shExsRTl0lk8PIukd1xnM+XFpLXyHmLgRuXS
	J2NRuaQeW0yE5Cvemn4DtlLFHua+J8D5lYAlUnHT5Q5CRNn66Iv7xKUcuS6fgHfMEGVOjKJGrvG
	Ue6jXNai1c1swAfJzhXxw6IhpWywNasvWQZjZDP/1pYjzuuSWWa+Erv81uMjAq6HUKO5jSeQ1+r
	t1ERoBecXLnmi0PeCesy8yimkml0ARePrOKcWYxSIUo83UqqVc/+CBxouoZSFUZa6Ijpw81Ftpt
	345drDZkMXEVqdcEOE9CIQbTZqbBF/MEy3wXxONXB20oHqUpeobpyZbkNqnq7+m3uVooV2YD1kS
	nAyHqiWB0q+aE
X-Received: by 2002:a05:7301:6194:10b0:369:f937:9a7a with SMTP id 5a478bee46e88-36a42437876mr3100348eec.34.1793356469205;
        Fri, 30 Oct 2026 03:34:29 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:6ef0:e162:ed32:a99f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a61a0csm7471774eec.22.2026.10.30.03.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:34:28 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: mediatek: mt8186-corsola-voltorb: Add MT6319 ramp-delay
Date: Fri, 30 Oct 2026 18:34:17 +0800
Message-ID: <20261030103418.2355854-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030103418.2355854-1-wenst@chromium.org>
References: <20261030103418.2355854-1-wenst@chromium.org>
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

On Voltorb and Squirtle, the MT6319 buck1 regulator supplying the big
CPU cluster is missing the regulator-ramp-delay property. Without the
slew rate specified, voltage increases may not have settled before
switching the big CPU cluster to higher operating points, risking
undervoltage crashes.

Firmware configures the MT6319 slew rate on these designs to 6250 uV/us,
with the value provided by MediaTek. Add regulator-ramp-delay = <6250>
to mt6319_buck1.

Fixes: 321ad586e607 ("arm64: dts: mediatek: Add MT8186 Voltorb Chromebooks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Patch created with LLM. Values were translated from raw register values
by MediaTek.
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
index 0250b4eeadd4..2ec343f49da3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
@@ -84,6 +84,7 @@ mt6319_buck1: vbuck1 {
 					regulator-min-microvolt = <600000>;
 					regulator-max-microvolt = <1193750>;
 					regulator-enable-ramp-delay = <256>;
+					regulator-ramp-delay = <6250>;
 					regulator-allowed-modes = <0 1 2>;
 					regulator-always-on;
 			};
-- 
2.56.0.317.g454f8302e1-goog

