Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542392;
	b=yhmFBw1mObeQFkTg/JdpxECSIc4rpGmo50GUvB8imr+EzqoP8E8qa1tNL3nfdu5f/8lK
	 5mafek4PFfAZgFe5Hj5nnsIXUcSyOu9wP5fuyihVRHe/Y6A6qSNxyUmkJ+8J0pSbefP+E
	 R+ZUJ/PMUrA71XKwCR8xuNmxb1ycCyMNjTKUwVRVfWKB5zmoWgm0nmbLEmxzxLi0/WciO
	 YZFANIlLkL85F5ljjqBoXbpVMdjTe9IvHqYqiGvLuYLQN/JuhkwCJ+NBRbTe/EIa3OXTD
	 SaBG4uNZRo7Ve8sW2P7DTFjhCAdRbdMSQspknGXzfmtvzdVcG0E05+p66oqZHo4OBlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=J7dP3VXODxvOhlIhNJe3oI07fAUOlBnY4o0etILQ0Qc=;
	b=SZVAIv+XYNsCLsTTNfscB8LcZXnvzEIwyw9b1XuZqI4A/Kli3nC1L1XZ4SXgyRuDGotM
	 6ozVioUDOwGgN48id8t6OPQIjjGqy74vN5KuXaNnQxc38MfiMdVi7AEnzA8VlOYLZ9W12
	 7sMTcSYZuwf3DY0f2nq73fuwogHFvv0kzub6rEEFD0O3r58tcN7VgO1Hdb1IdIwBjBpxv
	 CkJyeeQP0jBmGW2NOnnrS9AXqdJKNkfjqiSi/2Owmv0fORaz29W5O5FFTsH/q8ysSA+mf
	 ihRxzQSD3sVHI3MTNT0oyTQzZ+JOhTnA0M53RPAvPYIj0qsEBm/GhhTd3TNAvQvskSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NDTZVDK/";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3E606A32E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E3E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NDTZVDK/
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so38869655e9.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795542390; x=1796147190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J7dP3VXODxvOhlIhNJe3oI07fAUOlBnY4o0etILQ0Qc=;
        b=NDTZVDK/M5vxdxtSwP1Li0Hjpknc1RCM8i347pZflqzsX3rbzen9SBKedF6t5ycs4L
         9xCS3UYx0vbppq+XARgVPXY6aZZis+xzthTdyPY8Iv+t2j7iLeb0TCFNJcGy5pDNbKFx
         yDxcoSbA7eqzxJ9ad5jCJ1LrAOasagqN3IobL/Rxr3IxEABRULBkm6azD+uWDi1mbCen
         8jUuqkOlW41DxMW/LZFRql8b6kfFHqU+vKRfuOpLYBIWNKjGsx7Ixg1dCdKZnmLZIzxZ
         07ddZfHucLNb5RPxYYmfv/iJarHOb36oGlim9wcWauLGbodI8R1y0E/8WLhJyQ8xacgZ
         xMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542390; x=1796147190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J7dP3VXODxvOhlIhNJe3oI07fAUOlBnY4o0etILQ0Qc=;
        b=OB8ndvDUaFybFEq4Q+kh+Lxiw4ew01aQyO3rFWnuIeWSNZoK+lRg3/xH1NXmu+bo1C
         CoGNScENlIyQe4qBr7SPzjpwP20e8YzCcX9J7zGnyrenxtIqYfu8gfG265vWL7fRW5Fz
         3wO756p8PMWoSQC2JE2TvlPnbkEeCm977SfVvwbzfKZJYJ+/kpUiPz0wOflNz3MtUNHY
         TLdShTx4KNZkZ7s1L38mLi4wURwYUdMwYHSsBRNQ8xgJmdC9zAl7aOvo9ygRJBJ7qoVN
         1WB/Nv2n/f9vYnXwouNuXBfuzgIcYE9LkVPwZIkk0hGC6c/TOEJeVugJ8rNzaeQYz284
         uBeQ==
X-Forwarded-Encrypted: i=1; AL+hErHCCvO93F184IkI9pyMLNm1SeSbWL0OFZtywLU5L/s1lA/jlLzMJXe8yakg8tGKkzA7WLtmdc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jFjOE4WlZaerArRa0l4Xwmr/xP6O/1BMFDSkBhhvGsc98utmF
	UAeYQrXQyNAz5auXA01Cc+8NKKq6gqS82ylL5uoLJBPRsBSnL+ImL4k=
X-Gm-Gg: AZFdTZcNq3D6w2TJlWTma8OoG/gqzrTM7daaewDAN8C93nl1FD3lS7SB1IqVyr/cCeQ
	Sj88utmNVOJSmQlYxhF9+9Mv2PUBpb3WWf9LAYN6wPkJvwkoyAvT0XLfGQxYFDKCB+uLFYBY+9h
	ehmiBnoSymwjwlBdM+QEcQ30EqWJiF6r/0xv9LAWK60BJaufOlxHUJl159utCN0+WPQO7NUGnBf
	KuV9O9IlYR+saonzRjlt4ijfIoyJw8J6aSixHOclTkw1FmDTcoWlu3yVZKALfwcPrzhf0BY73+j
	F0J0gVsusihh7O3LwB0zQF86o7BXpov13AXBTXfEHjTx4dPnK2930Q9G6iZoBCJBygscfTi32vK
	u58LtGqR9hNAOToSFtGJH+B7XmsBNM9rsyYKin/LtzdK2sNOtkyCbiV+/u9fUSUw8sCLB90Yx2q
	abNgYTiQRW9lamtGkGKRUUq8mCMC75DsUJ1FrsNkRezc/77KCK6xAcfSnH9mCWzGSD5lWo9z5Ki
	hmSyE5CtISn6DYNsPuKRUrrxJJSEh+ExplMigcG6k+pFdXebbIowUK5tHsqv9n88h20TJLscALe
	Vo4ATq9tVTyMHuw=
X-Received: by 2002:a05:600c:468c:b0:4bb:6d61:af7c with SMTP id 5b1f17b1804b1-4bb88944bf5mr305609045e9.35.1795542389963;
        Tue, 24 Nov 2026 09:46:29 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm413261165e9.12.2026.11.24.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:46:29 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 2/3] wifi: mwifiex: validate intf_num in multichannel event handler
Date: Tue, 24 Nov 2026 17:46:19 +0000
Message-ID: <20261124174620.1572200-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124174620.1572200-1-tristmd@gmail.com>
References: <20261124174620.1572200-1-tristmd@gmail.com>
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

The intf_num field from the multichannel group info TLV indexes the
flexible array bss_type_numlist[] without checking whether it fits
the TLV data. An intf_num larger than the available data causes reads
past the TLV boundary.

Add a check that intf_num does not exceed the number of entries that
fit in the TLV data.

Fixes: 8d6b538a5eac ("mwifiex: handle multichannel event")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Chen <jeff.chen_1@nxp.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index fecd88967ceb8..1f746e8f6b3e1 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -450,6 +450,10 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
 
 		grp_info = (struct mwifiex_ie_types_mc_group_info *)tlv;
 		intf_num = grp_info->intf_num;
+		if (tlv_len < sizeof(*grp_info) - sizeof(grp_info->header) ||
+		    intf_num > tlv_len - (sizeof(*grp_info) - sizeof(grp_info->header)))
+			break;
+
 		for (i = 0; i < intf_num; i++) {
 			bss_type = grp_info->bss_type_numlist[i] >> 4;
 			bss_num = grp_info->bss_type_numlist[i] & BSS_NUM_MASK;
-- 
2.47.3

