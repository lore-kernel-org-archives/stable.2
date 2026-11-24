Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542391;
	b=J6lCaUoAaLiDrCMYCsQVpF7Qdm7+inZ3onrasu3cv4ZP4yun7ZtYSWuEJUg85ddqCEt8
	 jB1d5rsx+5VLf+Q0Bwl516Cy6E0rd1Q/sAapzJ2oFqiQ32OdLZxuJ81f5WUsTk3nRjpel
	 L0Q8N9z1xOXD/73pgYvUbHlLSJVbE6I28WHHbg5QK+DLLEyFRnall54ugfk5vQHwEcMc1
	 7ujHOxw44vEyWSgexocnbx8Eux3ZlaqaLVphbHGp6gJZPn8uMkXnqtSlfPDK4bqh1LZ4Y
	 DdM7pKlKziIYNGySs8WCfMOHo/ajrBa/KGQ5Lk0paswbhDu9ug3zYo1XXN6nySX2B6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AZ3m4IXRO0daintvIWIx4Ztq4eIIYHiwztaanniHigY=;
	b=qU5/YvmgkDY2YVNJ+xE+YFAsk5MGZLfOMPJtHAxJmU3H7UmOtd9l/Kpa3QW7hG8njZpy
	 vwiIllUv9qqD7TAGOQSsFDmTKMtmWtezmWKRGXF/dMPebDrma0dlI8TvpzDRF72HfXxUJ
	 H5cfoss5j9nB4z/7+PFmN8MV9sD4wA8EtOFfeP+/fvV52/PMmQk1XR6pSlTfs5hDrQWwf
	 XqdGzde+A6fgi805fmg3zPfQhHsqm+Ddg+g8Ab1TCxRkOWmkQ26racxCaTIzM2agmZbuB
	 WQE49dxlVrGHkZfd5Z/ZK1SR2bAXbqTDTZ137PKOMyLWYgQCm/0Rf7AkpmDoSXDEmzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CTS0tIiE;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760D606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A760D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CTS0tIiE
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so31036945e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795542389; x=1796147189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZ3m4IXRO0daintvIWIx4Ztq4eIIYHiwztaanniHigY=;
        b=CTS0tIiEPYrstz/vo4sAsctLwS7uUMOWM8Qa20/yOPjzguFXm6lOeSDZwwBUP9cr0T
         ZogE+jFrzDbzV+pW3fHnxAfRPisDT8pO7IuAgMMSU0NuPTjlHueeRp/WClFEgXhUffT8
         v1rs3okgddoD9vBmIbzNmycLyWpbIXcd50+0+GaL7V3Q8MKnfxBWcd7fvitsEypgHsQz
         SZL/hG8IBnb2HucdeBpgQfQmuGuAT5tdFy+hCGGiIVqEBO4znaiITBm0NtfWjTPtVI5s
         M8g4ez7dfmApI2ucdybwvVWOd9/NrYOiyEiy1+V4LVAU3fB8ibc89pbBVnWrPRNT/1gG
         F8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542389; x=1796147189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZ3m4IXRO0daintvIWIx4Ztq4eIIYHiwztaanniHigY=;
        b=rtg6sU8B8IwJTdPo61fSTbwCC/kuhQtkc/K687JwEhTY0pnWLChUYXe7kGWb9cRdu9
         vIPIJHWzvC4rnAaiblBvehmYinx96pTrIdY9LpFkxUnxbKRQfz08Q9u1GQ+g9SWwJphe
         sbqWEWvyP8beyJMq5PRRuMy2wkT/7KD1wY158Q/pozq2a7gtKMOQN7CV5JeGPiLMM9SE
         FaXK+OGF9wySyPWEbrHR5l7jX2mJ+mQLaXP0GnUkTUIPLB5sFn/gCqWHv+II76Zq1rCF
         2UpynwPIfuXk6BeAqBjxXoMqLf4Mc1WLgP2b0pcTtuDzYX7v3Aa1RXVY2lPO9kHdxR9T
         H+rw==
X-Forwarded-Encrypted: i=1; AL+hErHPoZDJGLIZxOZB6qPqMwqCWvHLPX5bJ4IxXMVxrNMv9lJPIlrMvLHo6L4kXqmYUi/m1g/Ui8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/q8rNJyknuJHj/OsxN7iW+QeYXRG+IA3Aser9SPEfnb65VK3eu
	RQEehTzL5LFtGsqxspcajtvLBiY7OHZQgST/l96rCKFYQ/VnNBZqGSkRhGVr
X-Gm-Gg: AZFdTZd4+zEEa6TUpJ1gq/uRCLitP9L3RUf5JMEd6FHBTX6B/EQsqiSWD3vuvgKy0F+
	K1/GQ7DCup5T7o9k2gaV1O4JLmrjgJgPiVHU30XSTwF1WwUqjlfOCNal4HfdWmHnOdWIZTOESP9
	MsnSJyKqicFhcfM4ZPa2eQFdV9dPx/wXjW1UmSrOIjLQk54dX3szPfnNRMbaC3vyt2tVCLyXzO1
	7sCkLV7FXT1dmvmrp0SvWVJynkJaiEHWX54/2MtfuomhPo+Bs+989ZOiWg7ilGfxYlqSz9eALRy
	K/97sUVzzp3m59GWH6IrZHjjUejQo6i5MEfX+YJgyQK+FxDItpKU47aQDhu9EaUShLTCaUy/ndB
	ety8tx+sjyKhEyLXsvLI+dNybjPM3E6NVnLgKD/lmPNEC0okl6+C6OhdjEpr/XuYD/yJR99iWpz
	r+rvPod5nufhOQfktm6XWADIdNLDA5NiPWR73AZ9FNMAjNtGhMRDkU4UzGglbHdAghFdulNuTZ8
	TU3Vrm5r/Hc0XeHK+MjryWcB8lIdet5CRgGBlBZRZka2fPh/uGGWZqSHkwX3zX3nXXwWQyP9ZOy
	p9LQMqsrnZRFSb4dn0STLhatgPomHuNOM23G
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb88818156mr312370375e9.16.1795542389016;
        Tue, 24 Nov 2026 09:46:29 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm413261165e9.12.2026.11.24.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:46:28 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 0/3] wifi: mwifiex: fix three firmware-triggered validation issues
Date: Tue, 24 Nov 2026 17:46:17 +0000
Message-ID: <20261124174620.1572200-1-tristmd@gmail.com>
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

Three validation fixes for firmware-provided data in mwifiex:

Patch 1 bounds-checks the TID extracted from ADDBA responses before
indexing aggr_prio_tbl[].

Patch 2 validates intf_num in multichannel group info TLVs against
the available TLV data length.

Patch 3 caps the TLV-derived length in IBSS connected events at the
remaining event buffer size, with an additional guard against
unsigned underflow when the fixed-size header advance overshoots
the buffer.

v2:
  - Patch 3: add underflow guard before computing remaining length,
    as pointed out by Jeff Chen: when the header advance overshoots
    the buffer, the unsigned subtraction wraps (Jeff Chen)

Tristan Madani (3):
  wifi: mwifiex: validate TID in ADDBA response handler
  wifi: mwifiex: validate intf_num in multichannel event handler
  wifi: mwifiex: cap TLV length in IBSS connected event handler

 drivers/net/wireless/marvell/mwifiex/11n.c       | 6 ++++++
 drivers/net/wireless/marvell/mwifiex/sta_event.c | 8 ++++++++
 2 files changed, 14 insertions(+)

-- 
2.47.3

