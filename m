Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B672C3244
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650542; cv=none; b=cr2fVpivDUKslPeOGfexOF7QxBQKRRWmQaOSKRBiVI1dVFD+JM/G2r4sK7zJnyTL+PuG9ip5ye7ioGFCA01CkChVFqUati1ue4/eWoc2RdZsUdqm8qpp8y15GV7NGzG30dVccNZszJJ962ZuyxGkDDL6ziE1T8SvJYaS58Cq6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650542; c=relaxed/simple;
	bh=IJkqPJypQc7GLzpERLUahs7dKBADnN+RxSys4p0uAWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njoruulTtHALIuwLxRlS04KKgb/To6dXyT53tNssn430kiuviw0CrUDwZXb26iGRIDJ6eI3JkpOYEiqPTm3xJj4Ux9eYyF1b/bzeZa+3dPJAs1jhDjpqO7tJp8pthX6y4hXodAqnpSwkHqJs0+rCy+LiUPrHW03yts5cDWthlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp6qZNcy; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp6qZNcy"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92ed3993c1eso23139685a.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650540; x=1784255340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eokHULuHuReut0+2I3ViyzYy6XEeFIbj+NJmSsqM9JY=;
        b=Fp6qZNcysCjj+oR7YU6eK/Kxtf/8NwStFvYDclOODYj3LicZoJ0/QPDC1Ew6D0gWtL
         ZTlrPmUc7UhNVa4DKAfaKjklPqXHOUFCftLJgIbtkdGgdJKqy6bY6qqSW7Xqbcf8LZMC
         UNpafK8KLzIPgEXMgq2xPC/WxrmtrqMU43d3QKJWRrdUfQEgQ4tpDqdvI5EZ3gd06+Dr
         7LvF/B7HJqWYhWKhnvTZS/frP8zVwhXhalppioD8rbO9a2b0N9DTNPzGS4dDxJ/dovi2
         bpigm1dlqcyIBuflepWSp+PDoHeAZ1G96GAvqJCLQ+6HPqWpGGxG1Shw4Qu65twkyTvd
         sEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650540; x=1784255340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eokHULuHuReut0+2I3ViyzYy6XEeFIbj+NJmSsqM9JY=;
        b=II8aTmv9ADdm9FSvSEG8cHQ4KybNvtvrEA+2zoSmRSj6l1IfkC27niuHMi6T0eS1QR
         B7XQLleiQ8GDI88zS1HiXEp3VGSeO0qfqZvPcxecOkGONzxvp9iBrRXpZfV72FP8Y/Ks
         U9G3vLis1MqWv3YZrT1ve4BX+j3sGcagvS/jPeQtabr3V3kMe9gE0bTZrgZ8TR8xVg60
         uC4fqdOSMhlR3IADOgbPG/HJypj2RdMdgrRhW360oxCE7z9kEeOgwqlAK5r2ZrML1Vn5
         y9Hd8rrFVo7KWVRiP7vsQDW8neUfm3y3gzV5KGBh+d6MxErEQNWuR1OY1YP5m+S1Sphp
         aHeQ==
X-Forwarded-Encrypted: i=1; AHgh+RryPL5y14vVaHNJKbSWhhr3MT/F59CxHesZHfQvkifI5xcT9PVoAVfOW+fnOesh+8qn3+4Q828=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBn5BFEXVLAdqZDb5ym/Asn53bW59YUj/UdOuxSflVh9CMOB4M
	SMGsHS3LrHY8KOW+AjTFVEoDCEmw5R0oPpPsEEJMaTzyT+0hA5pfvtHIKvvmVy81Akc=
X-Gm-Gg: AfdE7cl23Cwb1fWcys8JVZcxw+LEQ8/xBVqUNhw2b7sB6rRCEdcsfhuyKyMep4uXHxT
	Xpat3YvVZIheO6tA/t+cob3TV54VC0N3J1T3hdAGXVEABK1TRs3izBrTErVgd1EWupn2o4OeOXu
	FdBZ4KzddJDOlLx+NX1EapLia20ZPFT2zdZETAyIQjyCgAW4FQpvHmbP0+ckuenEzF/26NcZMQO
	KtIIJHFoDoJVmIv6BHuGicYldbB2nxlrXD58KLYRXJqw9RICR7RV3d3Hku12tm3fS8+c8kgKnTb
	73Yw6IGmpX9YGiP8FWgVvyaeRYIjTmt8TrZ6Rata8uyLO8WfA6VUAkbDn8uPBhsJz+9MJTIts6n
	yWiiWhrapvXjEbMe5ai5mQUbT0yY0YcF9HZuxwUqM7S0ytKoX/EWl7iIOBlO14niJ+sdHE8PacV
	iEKbU8RFbrbLra4T3T4lp2hEmAbTczrUrNgGjaF8keE+jCik6uzFTk3v7BVp9VMnoODHD8kA5ZS
	dr9GwZYcibEMwBBN15IybCURuUtYPC4
X-Received: by 2002:a05:620a:46a9:b0:92b:67e6:8ac2 with SMTP id af79cd13be357-92ecf6b4bedmr1085970385a.60.1783650539736;
        Thu, 09 Jul 2026 19:28:59 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm90507885a.11.2026.07.09.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:28:59 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	kys@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-input@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] HID: hyperv: bound initial device info descriptor
Date: Thu,  9 Jul 2026 22:28:52 -0400
Message-ID: <20260710022854.3739558-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

A malicious Hyper-V host or backend can crash a guest with a short
SYNTH_HID_INITIAL_DEVICE_INFO message. mousevsc_on_receive_device_info()
trusts the HID descriptor bLength and wDescriptorLength without checking
that the received VMBus packet actually contains both byte ranges, so a
truncated packet with an oversized report-descriptor length makes the
guest read past the received packet while copying the descriptor. This
matters most for a confidential guest, where the host is outside the trust
boundary.

Patch 1 passes the received initial-device-info size into the parser and
rejects descriptor lengths that exceed the packet. Patch 2 adds
same-translation-unit KUnit coverage: a well-formed message that must
still parse and the truncated/oversized message that must now be rejected.

Reproduced with the KUnit/KASAN test: stock reads past the packet on the
short message after the benign control passes; patched rejects it and both
cases pass.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  HID: hyperv: validate initial device info bounds
  HID: hyperv: add KUnit coverage for device info bounds

 drivers/hid/Kconfig      |  10 +++
 drivers/hid/hid-hyperv.c | 144 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 144 insertions(+), 10 deletions(-)

--
2.53.0
