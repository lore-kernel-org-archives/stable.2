Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032833;
	b=X1phToJOXjx+wdz5+5PKIAmiiI8D2PQIb9sI6ryNZaqCKskGSF/f056p1aIGY2CVkA0+
	 vtpxdJ7eHE/JWPyvAKxd1YusQ7gfa4QXwVrD8K2F8F/pS8qz7lFbYPolETAW8A7TOBCio
	 6NOvsX1axSlJm1QzoDo40tOrJQaFWbsltpx3qNocMNPxPt0TL3Xd2yI4AVOtIv7VtHjpJ
	 XdB78WyZSHaSloBOmp8/irpyTAO/2V3b8zWK6ukyJ40Vp3G+paE9pYYqJ+d9fxcxRgr/Y
	 PHiNfikk7uRTHRIb4mr/JE8lb0SHMyoTaJRCvhA7DsN12JmMKVxIV10bscPWQpC/NNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=klRyRRDnFZYZ2CDpmJK+E/gioA1RuNNa1jRJVKORvEE=;
	b=kwie4p+nZzr716eykEBVIKPypUs83AXufKRO6dTv9lKEBiSs60sBinYEC3vVbplnfgvu
	 tQ8ItTenOtJm5fso3Phzdf7jqs/bfsQZ4dHXvMFe2E4H2fUxSxPxrx7psJwStmjiVETcu
	 +PXJKVzfTt2oEJVJEzH2bTdxiPuaEcdXXyUPpIl/vl7/ESAwaYAi8CRQz4cZhDQntvTuO
	 dDCfqmwOuSS2ixE/dJ9ZCrTjFKxotDmz7aDn14R1BSQDsPINoOCkOzGh/HvBpRrbSnvHW
	 2a808Pf3TvTzi61zt8MmSCX2ujgY+WsMJDFsWlv2J5xaZ/yIk/goUwvNh/BicHP2JzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=neat.no;
	spf=pass smtp.mailfrom=neat.no;
	dkim=pass header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=dz7SCdLb;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC45606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC45606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neat.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neat.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=dz7SCdLb
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so21627705e9.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neat.no; s=google; t=1793032830; x=1793637630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=klRyRRDnFZYZ2CDpmJK+E/gioA1RuNNa1jRJVKORvEE=;
        b=dz7SCdLbThCzmZC12nFqMLnO+viK5xvFhsXspqN0DcrbgyOtLnVbgCSW8kkHPAQlkn
         4iUYa4Pq5+R5Bdj1UyY2Is5OwYarh7PlBsRTUMe9TTiyb9PssfamefeyiJ80Loa8GMgE
         6oLu3+EeQpsY10X/BIEjoVt0lpcrC3KnHBZo/UHXiAVarfMyPRbVHlAXSUYdDBgJf2iJ
         8Aunp+OpixoeUaMo+D6cPcWZxCfiopwNSk9i+hblRbiC/sVtTIvtmlMdMdLXN/h7ojPu
         +SbKPbVITzSuAUlb7973QBhb4pmajrjNCGPFoZHoz1IwME3VoZdcXVOhqSCrweLLzwR6
         FKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032830; x=1793637630;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=klRyRRDnFZYZ2CDpmJK+E/gioA1RuNNa1jRJVKORvEE=;
        b=hYerO7rYnnSbimNHsiN0pSPEph9BH1ilLe3AWGIgndbLQmQydOEdzC6dFG+7Ecx6JB
         PkDmIJWqv3eaLkDlYwGBon45g5qY0TCChFFE4d8nPDtQacTZGJpJlu/0QKH3Sd6YyeOC
         WXXh+1qRaoxJ0/Fx4M38VtWGSiurmwzMzj0jyRXiFN3oxmIGQ3cytPXj4nN53NXdWkk1
         ULRm+toijKQfcsulBbza8rMgTuFNwMvZY875YN0FWnu57eUwSj+iMNM30vUBmwJlCzu8
         ZV6DcXDQuCWnHaLn9knUwjxtksuHCNtoee/NH1W7+h76PjG6BVyAPTnOJ/m1MKvTK3v0
         n+qA==
X-Forwarded-Encrypted: i=1; AKwUvBywQX/oRu1gtlHQ5UO8UTQbtT+2zV/oj+6dMvCw4OZdFQJ98TpUW4/zpurQyuXRORETh5rRlMI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJG8SNtLvYeE2Ev2WL6Ugs5uh9jBT/x45Pge7rSfLrxZXXp/ZpF
	qbRHo4MfrHKNN7VOYNOcDmqJ5NFZRA9cxA2Xq86fiyITPKBKrYfkDw12oEirXiRcvX8hfrCTlXr
	O96Qa14vZRgbkrFDJSk1a9r5FmgPJ6+sNsGqPIEqe7J0Zxo1/Zs6tf8WMj/BroR23An2VLXTeoZ
	gg0FI0pr8CWgxL68Qdbj0ptMOvDBMrS0g3Tm+thsX1WdmmbmfBtONGR9TiVzJrZTRvaJ8MdPDbi
	7s=
X-Gm-Gg: AYBFou1AYyf1e8D6BxUJXTmcGML5y/iTMZN8aaYrwnplv/qJ5wLm86J7DbEdd53H8Qg
	vnQI2ykCazJystcVkIOBije6+UJT6tCrG0ZOYX8DLfYl8rzLVuLKNEpRKw8Oe7kHhv0PW2JV5MW
	NYAi3Ig/yzfjlDkpcV+JStVuBS4IHxo+6cu/wQmT9+3DJfQnw6UyXZB4gMpzLNoFf4A4C/ByRDy
	OzsKzsp2U+dSTOiXRq7aOd3yc1cXE+Ho+8JV5tjAVr/w0mV2JEiQsNF1K3bSrGCoL0Z8xeVb8fX
	+y/BgIYdyL37WV+MiVM6qXoYgW2v//LRVpS9RKVKPGt0AZVuw3frKBsd4slRcBn0T+1XeBCGY9X
	HpYU60c/wyULZNuCu0E2iKvidTfAy8Lk8ognf+X8aGPEDJHxLUXbnuE+Obd4wvTxLMH+m7uBCim
	hDpa/5elu9NkN3wj2dOijcCdPNjvA2ecjZSmfLUVR6GtZ+xw/Ngqhj64DVSaZPr3levI6qeVKiy
	fZMvZi2agjJaRtzxMv5aOfh5QYi9QLSvIi4JMFqLuoQcRd+mSXjWtqCXx+yv1U3
X-Received: by 2002:a05:600c:4e87:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-4a35acbea9amr145367215e9.28.1793032829991;
        Mon, 26 Oct 2026 09:40:29 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a30e22csm205961655e9.2.2026.10.26.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:40:29 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS clock starts
Date: Mon, 26 Oct 2026 16:40:25 +0000
Message-ID: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
the TMDS clock is stopped and to start the clock at least 1 ms later.
vc4 writes the bit, and enables the scrambler, at the end of the enable
sequence, long after the PHY has started, and clears it before the PHY
stops. A sink that samples the bit when the clock appears never locks
a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
order work on the same sink.

Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable()
was an empty stub upstream, so the PHY kept running after disable; the
Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
pre-existing race in the scrambling work cancel that the fix would
otherwise make easier to hit.

v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 kernel
with the same change applied, against the sink that showed the
problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sink
reset and a sink power cycle all lock with zero character errors. v2
and v3 carry the same code; the hardware test of the final form is
still pending and will be reported in this thread. Mainline was not
booted on the Pi 5. The BCM2711 path is unchanged except for the
enable order; I have no Pi 4 at hand.

Changes in v3:
- Patch 1: rewrote the commit message as requested.
- Added Cc: stable@vger.kernel.org to all three patches as requested.
- Collected the Reviewed-by tags on patches 2 and 3.
- No code change since v2.
- v2: https://lore.kernel.org/lkml/20261020151948.83459-1-lucas.tanure@neat.no/

Changes in v2:
- Add Dom Cobley's vc6_hdmi_phy_disable() from the Raspberry Pi tree so
  the PHY really stops on BCM2712 before the SCDC bits are cleared.
- Cancel the scrambling work unconditionally with
  cancel_delayed_work_sync(); the pending check skipped a running
  instance that then re-armed itself.
- Enable the controller scrambler at the same point as the sink bits,
  before the PHY starts, instead of leaving it at the end of the enable
  sequence with the sink descrambler already on.
- Drop the extra usleep_range(); drm_scdc_set_high_tmds_clock_ratio()
  already waits.
- v1: https://lore.kernel.org/lkml/20261020134941.631907-1-lucas.tanure@neat.no/

Dom Cobley (1):
  drm/vc4: hdmi: power down the BCM2712 PHY when the output is disabled

Lucas Tanure (2):
  drm/vc4: hdmi: always cancel the scrambling work synchronously
  drm/vc4: hdmi: enable scrambling before the TMDS clock starts

 drivers/gpu/drm/vc4/vc4_hdmi.c     | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.56.0

