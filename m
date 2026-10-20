Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510883;
	b=Ke/opw9Giiybgpmup2KBiQlSt9Lh/FUq2OOau26q4Xmz5HVP1zBCPtu3b9S+PJQ04fsu
	 RFZSEZF2HUqp/jCWuqIV6TwKzO/EGewQCh7lLcZ6Nmncgr6RQobcay2G946uUcXtPTgyj
	 +/OHnXPdMdsxY2MxRgUMOrQ2KT58bGgnwkYlp8+nVHGDMmAecVfW7/GtxCGDwa4d4779v
	 Iyfu0xsM64uUqmrqOli49zShP+d/q5DtiTLdEUwa8lHGgV27RJIOYGftv1uGCJ6xtRfTa
	 tHiDO35wXtgKaFleG7xOquD4s9E5IXVf1EySfbo9zqvnefST9lO/3hxvqomJpCRy6gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PbotHI99tftecSRxei/okpKKDZBbbGHapfuivs9s/Hk=;
	b=fGo+qvqG+nvPczjt1nHu15m/Soayussg0M9Gm/s5A2igMChXBhV+LaiQpdfbxpa4xrs0
	 AqgDoQMe6BfkAv4AJLEOY4x2PMp6+6GQ74FzglHHnRcqJeu8x5oOklh2xbNvG49WrA5gp
	 Vq+fIH66nEsO3ex5ujxsIhO9b2+F3yCe0GWfA2NNfDMpdN+hC0nkLoaTNTG0Wjjek4us7
	 nVxFx+PqREVcaF6ezgmHT1XMyyP4AcwyNlodkb1xBKI4quR4815RQsd34W1N0op4LB5lv
	 I1z3bSsddFG9jbS3LD48PKqrYbURPfL+Yo87mRuiRb0igA3KmoxAzAHw/estml1ieGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EUZoVCgE;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8F606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37B8F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EUZoVCgE
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso37338095e9.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510882; x=1793115682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PbotHI99tftecSRxei/okpKKDZBbbGHapfuivs9s/Hk=;
        b=EUZoVCgELz3j+oN2CgMRKyp7JaxNmw5ownN9/r2+E2tpmbuT/HyEZcZnsA40fLxwoq
         GFC3DLYvi64xceDDGOE75OTBQgtXTTQ4F0Fd/bjCIkwD18sWtAKJs/rDTR8wNQqcYY/u
         SOyR1I0O16vZxIIyU2xzkddNpoxKJZeyS7mYMQBPZE13YAlqkO6pLXwOdbUWm4cRdywq
         nzyXEwbMw3hxGB7BiBpruzAigNJ/5zSjJ6Cv2EXxsv9MaTj8OXQhj2Eb1jsdrVn1B4Ua
         kEX3309WTkzs3Wr/Q25uHwUDWTcHUpaP+nZMZNFivOYH7bofRA/LpDz6Vy+LJk8UWEZh
         BjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510882; x=1793115682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PbotHI99tftecSRxei/okpKKDZBbbGHapfuivs9s/Hk=;
        b=Czd6qAAwHR4Rg2cJeyJDlERQBYXSEFSbnsVx0Gm1Gm3cj2Sc6UHJ9YT8rAmyE0fhHy
         FegvMd6W4vmR+w7gUBsvawDg32ctg5f40Umgs/BZvBs05Vy+Cp+Y2m+zLTo3Rl7LoUql
         3yNd2rjISVUhkNgtIBJgxfBkoj+wnD8X/9rvBwuoPdyGmvUGd4ZB53iiUg64arA6+l8l
         /lc8Fm9gxMhGv4FxWqElmScN/oBglrVHfgkNcl60psyjaInuZ0i7MmfMhMLvB6elGiOB
         L2RUb/cCxed8uOiYJvly2xFCMhmrCTn4MwaEazaKXd8fze2M/uaomCqGOPqxV05exgJS
         6m/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzgiSphsfh6K/OVDXwB0Ip4/hNyqJ+P537NFGBNeogXZ/vjV2MIWCfs35HU2WD94DGUM8Mb7bg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2lrX7tq+H5xSO1TfpKnCapCHTEBK6kpl/oQ/Dxn1Jsp7gCj0L
	174R1kYVf1Fg3S6aGWAW8Dt6pPCgvCBQ6NF9p/W/RXb46F4CRCZMlc8=
X-Gm-Gg: AYBFou3CQKe9bERDTDI3X/0R3wE/mO1o+QZ2+EaZnkL9Kt95XFZW2u5sGNqSaCZ3ekX
	PuHd+oPTTYWYDdCVqnxWKyGeLohdg4swfFVJa3ZOa9V53fIVicTg0jET1wdXutiBi5xAiPAgt+1
	wccVMUHMX7Jj1qCudD5kp9Daa0JVqYsguNwskD+AUPt0OUMHZWZW2gtYT/VpiIcSc9AONqe1vLl
	AxUl9nvM0P/G4pI+cAIdCn42U+10GpBmkUnHM1+ZV2Rj2aa8nPs1NwhbCQR0wa6z0dWNKGKW3wc
	ndFB59i+1Rf/SYeBzHATzEZhb9/aQOjBnXo67ukFJ9d0c9PuHXUy0USp1ff5yszRMyUccI8blIc
	qGMxNWsf9QkTEmVmJkF0ftjKe8BFpIJJtskk1jCVL10OKs/gjqFWg71O9+CDgzoZ8M91A1+QQyI
	uwLe9TsFnCDvT6e3rLR57pdoDSygV3N1wLlg30aJo=
X-Received: by 2002:a05:600c:820a:b0:4a0:eae0:769a with SMTP id 5b1f17b1804b1-4a1d7616cfemr234758485e9.28.1792510881449;
        Tue, 20 Oct 2026 08:41:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca31234sm256606155e9.4.2026.10.20.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:41:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 0/5] extcon: cancel wq_detcable delayed work on driver unbind
Date: Tue, 20 Oct 2026 15:41:14 +0000
Message-ID: <20261020154119.2568395-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

Several extcon MUIC drivers schedule a delayed work (wq_detcable) during
probe for post-boot cable state detection, but never cancel it on driver
unbind.  If the device is removed before the work fires, the callback
dereferences freed memory.

Use devm_delayed_work_autocancel() to tie the work lifecycle to the
device.  This matches the pattern already used by extcon-gpio,
extcon-palmas, extcon-qcom-spmi-misc, and extcon-intel-int3496.

For the Maxim drivers (max14577, max77693, max8997), irq_work was
already converted to devm_work_autocancel() but wq_detcable was missed.
The rt8973a and sm5502 drivers also need the devm-helpers.h include.

Tristan Madani (5):
  extcon: max14577: cancel wq_detcable on driver unbind
  extcon: max77693: cancel wq_detcable on driver unbind
  extcon: max8997: cancel wq_detcable on driver unbind
  extcon: rt8973a: cancel wq_detcable on driver unbind
  extcon: sm5502: cancel wq_detcable on driver unbind

 drivers/extcon/extcon-max14577.c | 5 ++++-
 drivers/extcon/extcon-max77693.c | 5 ++++-
 drivers/extcon/extcon-max8997.c  | 5 ++++-
 drivers/extcon/extcon-rt8973a.c  | 6 +++++-
 drivers/extcon/extcon-sm5502.c   | 6 +++++-
 5 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.47.3

