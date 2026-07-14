Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B94D98F8
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047599; cv=none; b=VF9pXMMzUKeb7l5i6Ch0jO4fTxizN0hd419zGAz8BwWJFVvL9UW9vbYe2C/b3OFGV4eIdkTnJbi54O8NU20hEmnLNZ235TGTj7/7Y1RGAWg3fSIJjTkSVT6LnlnyXXuFeULm6dc7dUb/J5AkaoKTT9mHT6y/MIaWDKPlleK40kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047599; c=relaxed/simple;
	bh=9iodVMrU+2GAF2BdS6r4I7mPchCfTnRiHaGN1DpNBHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0PRd3VT20zYRPVGCaIkxwOocQbWkajEHJ1boqxWuK4ltAR9SwLWRWbbdMl8DpXYKyYziLbMXBmq4iir6FjhJ9s6Su5Jezs2YMAxkGAlkwSS8aFIghtUoRnewSvudwNuA4dlY2zeZqnE1IZZ4uF0VMQwe2U8vHPYJlBbaiqqE5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=encKXvoW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="encKXvoW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so3432417f8f.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784047596; x=1784652396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xA34URPmvLevJFaYVe08J7EpsJU8i+fALDat5zmBi3g=;
        b=encKXvoW02r8DklJ2kIbfxCvf+XSZ4XX93lJ+91p9CLzAhZc0nf2oNxfRoNmrk1lYe
         AzcDgQ6kOEU2YgRvZf2dz+pCJd6UDqlfx+4uwFzPPXoulFLYcDzob7EpTUc1QTPgN3h1
         fXluyw05AuWLt7/v3ym37dkQiVoDREZyCfCl1S/4G2IPAXel9I75g9J+pb6oTFjsVB2T
         frhKYBMXlg1VVviLk/1HLWBR3TbLhmfEuP2l8oTbYoDKEkKaKoJGcU8gkW6/sWtB3T6c
         jBbmpFdCHaRbo84Jdc0xw0thhfSG1KWCPki0gaHhXv7W2bW14/VnU6Gl9U3kcx8S/vMy
         7Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047596; x=1784652396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xA34URPmvLevJFaYVe08J7EpsJU8i+fALDat5zmBi3g=;
        b=gLJ+2I5coKZ079tj1jBX/x0fhHqajY/revcG9NGrYuHuELp+5HVaBDXr35uYyO3tkC
         seGhK5iYjn+eX9/fBuRSArys8kiLKiIk1xjEEKTvt1ZHnweg0r3YSr64J0WT7R75+kpi
         rb9jjc/mAgI5vm9z9WTRjYL3f/IKNgHq1h8wIWPUMjypTmjZa8gKOcaHo57bBKFcaRpQ
         PutaLbWSGHq3MchH8fUpETCxdVzSqEjKLascUfXi1OjcX6RVYWJ1dsP/m7uXrOQ6aLhK
         yn/o0sEAilePjc8GYJMeJtuzSQMxOgE6DEpjYFP5BsGNXohJHu1fIZZf1sU5Frli1GQu
         4asQ==
X-Gm-Message-State: AOJu0Yz3oCxHcz0CuNxIo17D/ebnso/a+6XE1kyARVv/WqhzWx/cv8MZ
	v9xfGiRATz2umMcFrPl4MKP3EIH38a+MvR2OhgaoCFCrF8m7U1g6PWRPKoayXa2m4K3m8QQB19M
	SbdThFwLZ
X-Gm-Gg: AfdE7cmulMUvILgggJj1B7hmN8NJVlVZCC7gwiCdzm8JLAvk+5ryed6N6+nUtO+mg0/
	4WoZmNNiJX37sLHf1U1YY7Dlfom4XqVFhrUx5H1nHa//U8fGidjiRvrbxDYzacJX25QjvBpdCdp
	u9ZxaxDWi06LPYPEw+AXjb5ZPHW6yz+yWXWcxw4tGTRaSJKvf58DyW7ZSqs075heur46cUO3LLN
	J3p1fq3sKo4anGe0FrlWfNal5YBtCOUJXNDmhi4tmCicVTrYDc1D3kjRj+a+6k0S1d4tVYvKzoO
	Msq+zCk4N0Sede/cJolaDvgnGHnQbbzTUqVMUnAFp5uQrDbOE+uaXJS3Sk3180QLXvTa7S/DNSf
	QTw+A8zL5XW1Q5aMz4IHea2hzhTlPZf0Eqno5iH8+zrh+gs7HcwOqFlHaUUkw4l/IgGOuqqdfqO
	NNcpC8hSB2OS20G3PWv9attk0qSdC5ZaMqb2gZSzKUdo3kR+ZxPwCiMTPbXrGZ/mjP/mYQELwVT
	NQ63AoS884jgU0BaEgScpC/R2OGvWm4gZk=
X-Received: by 2002:a05:6000:4615:b0:46d:d6e0:9cc6 with SMTP id ffacd0b85a97d-47f2dcf556emr15992661f8f.44.1784047595602;
        Tue, 14 Jul 2026 09:46:35 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0d9sm9739781f8f.2.2026.07.14.09.46.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 09:46:35 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: stable@vger.kernel.org
Cc: olteanv@gmail.com,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Please backport: DSA taggers OOB read on PACKET_QDISC_BYPASS TX
Date: Tue, 14 Jul 2026 18:46:33 +0200
Message-ID: <20260714164633.75135-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please backport the following mainline commits to the stable trees.

Reason: the ocelot, ksz and sja1105 DSA taggers dereference
eth_hdr(skb)/skb_mac_header(skb) on their TX paths. skb->mac_header is
not set on the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path
(packet_direct_xmit() -> netdev_start_xmit(), which bypasses the
dev_hard_start_xmit() reset from 6d1ccff62780), so eth_hdr(skb) resolves
~64 KB out of bounds -> out-of-bounds read. The fixes below make these
taggers read the header from skb->data instead. Reproducible with an
unmodified CONFIG_NET_DSA_LOOP=y kernel by sending on a raw packet
socket with PACKET_QDISC_BYPASS set.

These commits went into v6.4 without a Cc: stable tag because they were
made as preparation for reverting 6d1ccff62780 and the bug was assumed
to be future-only; it is not -- the bypass path was always unaffected by
that reset. 6.6.y and 6.12.y already carry them.

Prerequisite (helper, not a fix on its own; needed or the ocelot and
sja1105 fixes will not build on pre-v6.4 trees):

  1f5020acb33f ("net: vlan: introduce skb_vlan_eth_hdr()")

Fixes, in mainline order:

  eabb1494c9f2 ("net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit")
  499b2491d550 ("net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths")
  f9346f00b5af ("net: dsa: tag_sja1105: don't rely on skb_mac_header() in TX paths")
  0bcf2e4aca6c ("net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX")

Not all fixes apply to all trees (the vulnerable code was introduced at
different times). Per tree:

  6.1.y:  1f5020acb33f, eabb1494c9f2, 499b2491d550, f9346f00b5af, 0bcf2e4aca6c
  5.15.y: 1f5020acb33f, 499b2491d550, f9346f00b5af
          (tag_ocelot has no ocelot_xmit_get_vlan_info() before v5.16)
  5.10.y: 499b2491d550
          (sja1105_pvid_tag_control_pkt() is v5.15+; ocelot is v5.16+;
           skb_eth_hdr() already present, so no prerequisite needed)

Ordering: apply 1f5020acb33f before eabb1494c9f2/f9346f00b5af, and
eabb1494c9f2 before 0bcf2e4aca6c.

5.4.y is EOL and also lacks skb_eth_hdr(); not requested.

Thanks,
Doruk Ozturk
