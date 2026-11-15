Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794730889;
	b=EgW4vEklsgzi/SLiHfXPNU5MLHdbeMIif3lMktqeTuCeqlxUFe3YZ/mzttrZH1xyi4dB
	 24jM1qk982ams3mX0Gh7MgOIpbO9zkdjRiuhrrum9p8zQYeadNZwJRRYh/YrkxyjM67V8
	 RrKOX9Ogi6DT1sB+jKHpsDPHS10bSwQgPmYoZmHEMVRI3pk6ixSrFkmLFuDUlLY/Vvm6+
	 H6tIX6g1wgFdGr77cIBp16PqXFLxHKJvjZ8mihFPTmeKoIlWPQGQ6Qw/1f/S4FdqUWAIu
	 NXFfbaO6FqhFUnzataga/MiVtUfMVcb33tq+wKyREdUvHpsM824LUSOcTz3PtU9GuCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730889;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=2Gm1niHwn94JPZGn5PVHkH3FZDaWwSEi7IqQ6yWaOZU=;
	b=L7qtKTgqsGHD01Bu57CEg3Y/mxB1QkEkx+zWCtDJp7qD/f6//dy8U4tV2H92lecd+4xe
	 RxUoDeG5+MN/6KXzGaT6HvoyVj8pEhva6FLwLnbgHJjhs/Vz7wnHzLYmFg7tLOPSeTOwO
	 LQgZ2sR5swed2riA4tgVMbavuuBDS5uo/obuETvTyKNiXqgseYmspRC+hCSkUlFltMM3b
	 mvHSdiYzVI/aN4o0mBKIVM3TPgb6LPazlvsb5aEJUgVoJq9klppKtt2Q9esMhpp/hEp91
	 HI/FLvBD8ylVP1nZ9lzO5l1uLbXQ2OB6jMVxzcMrmLmuD2j85Uk7qjkE0dnAlzfF3Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FU/uU0Pn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8B606A31F;
	Sun, 15 Nov 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FU/uU0Pn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794730889;
	b=cbOnCvyby97a17fJt8vioEGQ9L2fTzeCwx0LGcNDsdpjXXfM/gaZaJWV9DglxLOVZSUJ
	 ubF0Wd9e6rIB1Gz+hJqKTT3TnpddcrLYkqwS2Z7lnfTWpeznr4/UApnz3oKceNjID2ScC
	 MbzHDNFh41zgwCyeSASCcOYi3u4SyDYBz4Z1kh6gLkdwooSBnj7tPAqbnjqOhgorqC3eY
	 UI6Q1/Tpafh91xmo9EfspRMG/dLtD6YAtX4GzEOkBp3mkOSkxugcaTHgDIEV8RsTOPrN5
	 cGkRlJNkCXBLl/kG36sRmfcEnKdYB6HMricyfiPsNnGqcBS3ceOiPSCPRZLsF1HhS3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794730889;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=2Gm1niHwn94JPZGn5PVHkH3FZDaWwSEi7IqQ6yWaOZU=;
	b=RXzRCSwG9VHByTIe3mbr/ObY404lTRiktIgZo5qFb0KoFQ7UpKKbS/LKDEtDRTjWqTLY
	 S9KW+Gpp65KfSqJPB2bA1mlGjRG+VCIyokUxRI6O0y93o7N4YriQhHzPPLgixAsaQInHn
	 /aEb/66FGlHo3dYBAaGrMrW9tU9TmSn0ti8vFQj5haGp5LHHjuwrY4NlmuOTYpDBiB0ok
	 r77IDsb0NbT9keYYtklNMMzND9w2I2m187kY+No9tjtWcdlE+pwjq1bkjh8j3aEsH1D7S
	 TJE480Y4/6HR43nVBQ+QEFdgP9N9fxIGyY/O6iKI/4l1rLZpOQf7QoaDiDxUMLTfUDA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B50CE1F000C4;
	Sun, 15 Nov 2026 08:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794730889;
	bh=2Gm1niHwn94JPZGn5PVHkH3FZDaWwSEi7IqQ6yWaOZU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=FU/uU0Pnjc5CleEYBEa46Fym4G1kTC4QrQ9ag3U9TyliL2muCNBmvfGipOukpjpmS
	 2bHLHtjGy5VcqcYgWBlXaxfwN367iItBHLIkxr8fPu5/HHgpt24KcHSgospPf/OsRv
	 Z5koIfvJdejZO2fe+xIfxXWzpKL7z9cICsKaA+95UYBpxdf8yjIcOiY8uM5euf0CyT
	 vSns0xZXKjlNrDZQ6HhWietwg3ui+dVUfhNrc5lbJBCPg0EMmI0qoKIp5Q3x/sOIvg
	 uc3FqgPKkkA5EdKK2Uqnkx0efRA9ZfkOssPzVAwqcxaGvqfd7X3olr/pXbasdPkFRC
	 E+yT60tvtRQmw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1543F49FDE;
	Sun, 15 Nov 2026 08:21:28 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/2] media: rkvdec: Stop VDPU381 and VDPU383 cores on
 timeout
Date: Sun, 15 Nov 2026 08:21:27 +0000
Message-Id: <20261115-rkvdec-wdt-stop-v1-0-59e687c6cc63@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2OzW7DIBAGX8XiXCwWcMBWVfU9ohzwsrTUsp0CT
 tpGefeSn+NI387shWVKkTIbmgtLdIo5rksFeGkYfrrlg3j0lZkUcgcAmqfp5An52Reey3rk2Cs
 re6OhR2T16pgoxJ+7cX94cN7GL8Jy0zwXib63miqPGZspZ3dPDc3rs6RASN3tWg1dJ5XhwF07u
 b+45On3PdYX1jZtbzff6DJxXOc5lqHRNlDnjFUaEYSwYK3xZkTfhyCcRudRBWeRHa7Xf5WFBgj
 9AAAA
X-Change-ID: 20261114-rkvdec-wdt-stop-c938297419cc
To: Detlev Casanova <detlev.casanova@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alex Kazinsky <a.kazinsky@ideco.ru>, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794730887; l=1762;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=vXWQKYqD65FGosSnp3CAGgFjhJ+XWPam2Tye34T89dI=;
 b=2i2GBE9TZ5786AIiy27G0vx6e0j71HcTkOrGbu5PMhpK7IEv5Spj9aGfiDYZzqjRYpmkN0l+8
 EgZ+OjQtN7LBMlRglqt/sq4LBCzBbMkZ33U6J9qr9fEs03gBunTosVQ
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The rkvdec watchdog writes an RK3399 register on VDPU381 and VDPU383,
so a timed-out core keeps running after its IOMMU and power domain are
suspended. On RK3588 this corrupts memory and panics.

1/2 fixes VDPU381 and is board-tested. 2/2 fixes VDPU383 and is
compile-tested only.

The series applies on top of Alex Kazinsky's "media: rkvdec: Handle
interrupts without a current context" v3 [1], which touches the same
lines. For stable this needs [1] first.

Tested on an Orange Pi 5 (RK3588S) with KASAN, my pending
rockchip-iommu fixes [2] and the watchdog cut to a few ms: unpatched
panics within 8 s; patched, 5955 timeouts with no KASAN, IOMMU or WARN
report, fluster H.264/H.265 unchanged.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

[1] https://lore.kernel.org/linux-media/20261113102456.4155237-1-a.kazinsky@ideco.ru/
[2] https://patch.msgid.link/20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com

---
Arun Iyengar (2):
      media: rkvdec: Stop the VDPU381 core on timeout
      media: rkvdec: Stop the VDPU383 core on timeout

 .../platform/rockchip/rkvdec/rkvdec-vdpu381-regs.h |  4 ++
 .../platform/rockchip/rkvdec/rkvdec-vdpu383-regs.h |  4 ++
 drivers/media/platform/rockchip/rkvdec/rkvdec.c    | 82 +++++++++++++++++++++-
 drivers/media/platform/rockchip/rkvdec/rkvdec.h    |  3 +
 4 files changed, 92 insertions(+), 1 deletion(-)
---
base-commit: 48fe5a7834cc10081887d7bcd9ff0a4cadc3fa8c
change-id: 20261114-rkvdec-wdt-stop-c938297419cc
prerequisite-message-id: <20261113102456.4155237-1-a.kazinsky@ideco.ru>
prerequisite-patch-id: 4199405920f24e49b3993996a6bd951136e52e92

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


