Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597599;
	b=2kbcd+GKDF19L3fpPgA+i8Yh6dNthAkhgP+SBEbWWvQ/LVF+4l5dAV4NRRqO45vPuM58
	 EJX9ZvNBECSKfFvLJnzilQVlcWXeAqoMaIJAFT/8PpuJA2GB+eXs+xhQNVOUl76nE2vZK
	 d9T2I5Eq3jJpWP4LZNCRkb15ipqlanNjegAkDEVYV7+yVZGHltumZzWhcO0bjT+5pwKB6
	 DXq/VvnzMesMbAeiJlnwNzTMjFYt3meKWN+8VhriZyaXqjFXU/TKRK2Iy1qANLG72g3q1
	 uVxvJ9eUO4kJuMnkn/Vp60AEX6itayoOM3vNNLKFOdq67LsEGxJQwzaFmv0fk/VwkWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oE7Aic43oySX2ufBY/K+5voFcrRN+KlpsTc8hK+MGxY=;
	b=AhjAmj3IzGBYMA789YaTmu8d62epR51+ZNZY5SymEuXsR22Jh3E7G9gyqdfODm+atAHo
	 r+hcWFLcgmAx7/b8z/25CXNAcoUYMZOhVNPssPZy5ZhtHVrpgQLlkzqpU4cw3fPLP5UX6
	 +clRLPn8xHXtDFoNQsd8po5apy+nozOUG6lSrdD3qC4WzKM21ixGwV13lv5PVOihAnDRy
	 5RMr0dHVCh6r66wR+klRm9b3CdeP70ufFIq7EEw2zjFfGsUHASY3ra9r4+r8szf2DRN43
	 PYhph2GzheBPb1Qp8sDC2GUVJ4S6EVauAzQCgfHCMg1SwW1efgyhl5Es+0ynbWapKEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFnisHrC;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E2606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 034E2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFnisHrC
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386c71feeeaso1780743eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597598; x=1796202398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oE7Aic43oySX2ufBY/K+5voFcrRN+KlpsTc8hK+MGxY=;
        b=eFnisHrCI7kZN77oTOFlqkMxz0qfVB8BVNADcvtjDNXTyPbki94moUDi1hNWCDL6nC
         FZSd/dxe4yjAD/IZWRvYkbcWOp4fECdnUYGq7sx1S9l4S6JAdzRlS3FYckb4OtMaVoDm
         qQ8r8gKFYmBsz7LMXZMKZezwXQqNqvBeWLqF94kwjMEm8NCd0OpJCBhz48Rnlq8q+IoS
         4V5ssMZmDiNMfdqdvmb3+JSzU/cvEL6N+6uqy6tgRKsYCs0anVRyJLSRKzbVu/SPr2Ih
         SPuknuy9+Y7o1QnO38xejXYgTy8bYbbRFhadUhs/3xADslqJh/YnB6esDl2Wpw1ShIXy
         X1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597598; x=1796202398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oE7Aic43oySX2ufBY/K+5voFcrRN+KlpsTc8hK+MGxY=;
        b=Byuq0C6quZcOu6UPWOjCDBQd6/HXDzWWz4Wd1zDH9zRcoG/lJpHCdHkR1WU52/+iRq
         N+iGQEoYGkrtRbQZuriv+R0d6DRT3nRAwfGBT/BDd65ZlwiSl0giemXTZelC4M+fiCIQ
         0ZWqp2EhrycJG/h+oDpeJRxhO24QGxoiKKN/4+n4e7i9RUnaCflzZqznCeZhluwTFt+5
         vFELvsQnkQOzUvhoF9OT5X8nAA2oLd2qxdg3tcRHw299NxIvAfIho1V1j5V+NbmgmWAU
         Q6VpccKqNQKd1viohFsVQH3kOe8RiZi94yJO+MlhIpgoOdL8Zmn5KbZqUHWPYgSvdQjf
         iDTg==
X-Forwarded-Encrypted: i=1; AL+hErH7gRwE9je6woRewrEUc4sDHOY7T7a5YS9Mcc17yyCX+Nmdnh894wsRo/MNDnogcqxv096Ds80=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bUVearLqsJPTMd9RoOmUqgyTTB5Psxe52vsAXrmRbmqfEFiTs
	kmxEaN2jHv/l+rN1bJeAEYUKBwhz7vnd1nVjqOQIp6hFjcZaYSObVsRP
X-Gm-Gg: AZFdTZfHP3C2xnziQDwCXzNCdrIBGs2qFndbp+Wnb7ceU3SVvjE3pQJBiUjpIydwlkw
	KgsF/oBLW6/haeWRbJ5wjPXZlFKd6xdv0GBK7BgKHqi9yycbpWP6BiVtvjpe3atL8Zm4aXJCi6P
	MFRoxpFnOR0xZCWSw5Kb9tsF61URsCtiryyk2hPPSn6nq2+45HkrHXHo40fCe4hbjboz0kRRa0V
	L8Sbk/MIFy7furojT3TNeg5Cwryfn+RsJ4mozX1iVDm5+r0CA4BV1aWjcPW96hYYDiO0rkHQAHc
	HKHMxcvmhcwIwRRupIZXC41zxhXZd2yBhiWXtpv2Ate+KEbvi3RszwOlexwOJYNWsqdm4Vw1jtb
	W3ofG6Z0gFNcVn6ZJnL44ZUAOJXm0uhsJ/rgqe6mGDmWyD25ylkIVOgScKsuxuqTqgKcYQKPMx9
	H9mMLOLPL+OfC2kcx2Dbh2+TEfx21MM4AJ0DTfASHTlB8Wvm/GLR7PdPtcdykzAXUM2ovSn1Woc
	ULmyK6fGNKj7d0nbTCdLpD3K//HbaaW9Tu6iyq+XtmmLY25wW6Keg5WsrEXGnHcem9vJ23q6fQs
	GNgqAWr20F0enqVQgRnuj5Zrsbvl3LriG9vLTvaJOq7cTDlYaeVXHy+Z3SbcjFnBQ6S//0Jvn1k
	=
X-Received: by 2002:a05:693c:65c7:b0:386:cffd:bda6 with SMTP id 5a478bee46e88-386cffdd34fmr1205867eec.5.1795597598099;
        Wed, 25 Nov 2026 01:06:38 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm58712596eec.24.2026.11.25.01.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:06:37 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] HID: intel-ish-hid: Size the buffers for a later, larger response
Date: Wed, 25 Nov 2026 17:06:31 +0800
Message-Id: <20261125090633.1385386-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Both patches fix buffers in process_recv() that are allocated for the
first firmware response and then reused for later, larger ones.

A pending patch [1] limits hid_dev_count to MAX_HID_DEVICES, and it is
still needed with this series. Patch 2 does not depend on [1], so it
allocates U8_MAX entries (2295 bytes). With [1] applied first,
MAX_HID_DEVICES entries would be enough.

The series is based on hid.git for-7.4/upstream-fixes. In mainline,
patch 2 conflicts with the treewide devm_kmalloc_obj() conversion
(4dd10fbbeb9c). I can send a version for mainline if you prefer.

I used an LLM to help write the harness and these patches.

Changes in v2:
- Patch 1 ignores a response whose done flag is already set.
- Patch 2 allocates hid_devices once for the largest count and does
  not reallocate it. The subject of patch 2 and of this letter changed
  with that.
- Both changes follow the Sashiko review of v1.
- v1: https://lore.kernel.org/linux-input/20261123092816.2200718-1-maoyixie.tju@gmail.com/

[1] https://lore.kernel.org/all/tencent_130404E5ABECE66E8D0E70D8E6892C751C0A@qq.com/

Maoyi Xie (2):
  HID: intel-ish-hid: Reallocate the descriptor buffers for a longer
    response
  HID: intel-ish-hid: Allocate hid_devices for the largest device count

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 27 ++++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)


base-commit: 10bc1d627c297097cfdc099377f8a13efdfffd86
-- 
2.34.1

