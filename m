Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8221DC985
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234106; cv=none; b=e3U2cphK8n1RYG6uW9Bsj5XoAWM9SqbOEx5lMcGOV2HHc0r+tYTnfv6gN3alFD0GUGwnBw8ByXZ1KlAxQHCcpKLUEZyJpux0vs/yjxnNnPfMQRkEXQIDmlptGxOwhkczcQ/jpDJQjz0f6dwb7QglWsS/ewpc9+rlzvNv9EdzrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234106; c=relaxed/simple;
	bh=a2r3SaEcmo1vXRTikEb5mYwXGPxTs2s/FQ04pnJ5R5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYkITwWITrmmhb650Kfiw+Vmjd6IFWKNK6gtMaYI21y+37v/VDhFA9JgrqE3RBVZwLQwUdwLN3U62ycXYKePHOeD+KTDYsSnIkmrzlqVOe9Zq2Dy/28M71biYdYjpeJNnM8RfJzdG5DiaKvhUtpWU5E4zieUcVitCCZJNINdB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=bWc2OLTl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="bWc2OLTl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c7902f47so54298155e9.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784234103; x=1784838903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EcO4tM1S3A4dsQuKJz/L4WTtHD8wctZEu5fpHjbBuSo=;
        b=bWc2OLTldqwUGev8rjSWlNyUzqyJXU1Pq239JOCc1yfyGWKGAUmP3mAue4vb5HkGAv
         koX7QJ1IieQWablWsRwCoyald4FSYej+qfk9iaZ9RDs/KFTa/ZPsawyew6HF52JaTIBr
         kknvAr4Tcu/VfF2WloiavqVI0NAfecO/4nufIPOTyI4yp1oDbDRpku29teH0KIn5C3cl
         XG1Q8KMr85c1Q3WR7B4BGPBfZnJeZuLCAiiTdam8dVDrLwWOGNQfCSW03Bn8s2oBjMBq
         YCofz7VfwHoKrg0rhJWRupc+8mqdnP0KDmoXf58xJa1PLSSnrvZBePG8t6rIkzQMZshd
         /bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784234103; x=1784838903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EcO4tM1S3A4dsQuKJz/L4WTtHD8wctZEu5fpHjbBuSo=;
        b=jbkvusEIcsqVN2Xy0ZgwtOUwT5shM3e4ZqlY5LuDiQ0KOk6zxA/E911LV4TCjDBAOG
         v+02oWOlwBTQDT0E0p3PtoMGizfKv+1cLy8lo7RhWEMCV2sNyjadXQcWthlQxAB4yUM2
         w5pwPqHFeQFTKq1jGAUxHJ6pGkQ9gsZtzgowVoIraAeCOwd3JjTTrnMB9GxknApr16FM
         z9wWoJ0br4dZbc5J7tgd4kLG0Zl+XKK6Kne+EV0VWdEtrPEeUtIqiIIA6UtcBUrnpw6t
         Z+hnh93+shdZGp2ZwWxAEdpPjyU42P8WHS5VleA569pg4I59mkOtJ8MZbuLN6eBpKEaS
         kk3A==
X-Forwarded-Encrypted: i=1; AHgh+RqzFYxsR3EApxI1h2S8Xptow47s3myiqKefmt16Cdi0KOcPcZa90lQ0qfxZpBY9weJVZsPYQHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbV4kA4hF4aeFkTVg4PDN9CFu/7vJh/Z+rpymc/+tsUqbXz0+a
	fL3WoiauoioRMB94pFB/CqUbx0d09oYiVnCDYYdvCYNLV48iMzrCFwyGYlBAC+aEe8Q8
X-Gm-Gg: AfdE7cmLXHihujIXytLKWwQ3Z71llERaQJmkTCuAsMIfdGXVeQVBvqck8I2+PBSVHRs
	vL982EYiPi9rvys7NqZNS1mtV/LgSauMsVrsUDwD7STlZrWfVJoUtSjAqggouzmTuq1N100YYwb
	e1+xhPl1HvawvL4CiR5J6H5MhQZQQREjHOI/CLgxeH2NgrtQWCSUY3v22/N9lTYqCJvEG+1TdaU
	rUsAvXFLpapQSKvvCt369RvNaIwFvSZlPWcnkWjypVrh5G+eAewm1Yy+T9j2MzIMF8rA74gOWEY
	ao+z82uNY+GkaNyPEfG5A/80JACZgJnbXOTWDeofH5gZLh8L8E4AKC+p1rMH4rZtc/17eM/gGFh
	rvSWZYR6DXwekfpayYsINmO81aKTFMz1DXsBq32mP4s+wQTuI6bSx38ECbcmQxVyInlljUQ+BaH
	anJcRBlSqmfTLWIl8/R8vm3aiKO//6ezi6r1TI3S82qyZQ1CFwjmyjUspt1w70C+/3dcTEVIXK4
	X/vTPcPtW63lu6VQlBS0yE5
X-Received: by 2002:a05:600c:6d4d:b0:493:f6f0:d66b with SMTP id 5b1f17b1804b1-4953c14f0a7mr76349675e9.1.1784234103380;
        Thu, 16 Jul 2026 13:35:03 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm4602835e9.1.2026.07.16.13.35.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 13:35:01 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: fmancera@suse.de,
	sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 0/2] vxlan, geneve: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 16 Jul 2026 22:34:58 +0200
Message-ID: <20260716203500.70573-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent series "require CAP_NET_ADMIN in the device netns for
changelink" (8165f7ff57d9..27ccb68e7ccc) added rtnl_dev_link_net_capable()
and gated the eight IP tunnel drivers (ip_gre, ipip, ip_vti, ip6_tunnel,
ip6_gre, ip6_vti, sit, xfrm_interface). VXLAN and GENEVE share the exact
same shape but were not covered: both store the underlay netns sticky at
newlink (vxlan->net / geneve->net) and their changelink() operates on that
netns, while the generic RTM_NEWLINK path only checks CAP_NET_ADMIN against
dev_net(dev). Once such a device is created in or moved to another netns,
a caller privileged in dev_net(dev) but not in the underlay netns can
reconfigure the tunnel'"'"'s underlay.

This completes that series for the two UDP tunnel drivers that were left
out. Same helper, same placement (top of changelink, before any attribute
is parsed).

Verified on next-20260714 in QEMU with CONFIG_VXLAN=y + CONFIG_USER_NS=y:
an unprivileged user namespace holding CAP_NET_ADMIN only in a child netns
issues an IFLA_INFO_DATA changelink on a vxlan device whose underlay lives
in init_net. Before: returns 0 (reconfigures the init_net underlay).
After: returns -EPERM.

v2:
 - Correct the Fixes: tag on both patches to the commit that added
   changelink support (8bcdc4f3a20b for vxlan, 5b861f6baa3a for geneve),
   as pointed out by Fernando Mancera. No code changes.

Doruk Tan Ozturk (2):
  vxlan: require CAP_NET_ADMIN in the device netns for changelink
  geneve: require CAP_NET_ADMIN in the device netns for changelink

 drivers/net/geneve.c           | 3 +++
 drivers/net/vxlan/vxlan_core.c | 3 +++
 2 files changed, 6 insertions(+)


base-commit: cc2b5f627e8ccbae1188ef2d8be3e451d7f933a5
-- 
2.43.0
