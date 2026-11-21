Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795242623;
	b=vmYEDmSpTgi7VlfYncEqeB1F5WE5OX7WvztnOB1W8GANZuZ3PFd+dcF37l7tRhpcPRWD
	 7jycj9ZbrxZum89vlaafXbjbASbEyzJsuONHxUQNl7ZA+fqLsQdwtJpJyPcAXWBkWFtkn
	 tcEArauLTZqKDT5JwioUhjyTRtBRm6Wnw5TQn46ATeYmXqx2Yk7qKHlJQWF+6kClmoOj+
	 wo0g92Y1pfPcOh/MzSDSd3yBp6WASvEs2lKhZCF3JHslMiwuRibphPiKpUhQRP+gGCYIQ
	 yEQjTA6sp3OMqIis8FEma4o0NCrI1UdW39Qqiu7tHViWxmFkeDUH1mRybTFPUKJ/Yfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795242623;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=A5koY/tSPulYUbnh7DbCFDd9lC2ipSi9cXlOxREffJQ=;
	b=f7puPWykM7vnD5lHPHLoDRCue2uSH+ZuEvEoGKpzXhilc52ThQIGnfHUYAnPh3vdcDmj
	 unlDQKWhzRHOKEZQoGuPlpJdpgVY5Y4CsYNDk6O4uT7CVaoK6yfnqcM8ASnnjaAk7vo8o
	 GO6oz/0UEBSZ8iqx/oM6QLmmwP7N6ezYtOJioiOC6quAjPjmP9iaIlNavUpHGQXQTi0J1
	 MYjchuMCvs0SkqQCFvv+5bg2yMCD6oQRULHmfaHsWv587w/GF1LNY0PFaz7o/npo5GIcy
	 Vi9nK99YLTeHKj3zsURDW3IfFsEYafI1tfzSpmY34LuR4xYbAb+X+MyZ32YxytyEYXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ww2C+t9q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C65606A681;
	Sat, 21 Nov 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ww2C+t9q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795242622;
	b=fmp6MjERae5yDj/8/1MFvAbMrjZLF2FY1ceHaamDkiw8r7LvUT0kaoTLbkP8PfpeDGsl
	 HY2c2ggytdyFLKOsLF1D3wFTyLgIwoZhkEFQi3qjogHvlAOHwGHSpC5rEHImz2TSlqAcF
	 cWZkS/J2o2u0BBetqYmAO21unujsQD2dInDRVr8SzpSk4Rk5kkWrv5Tb6ETq2C7M01LW4
	 0xKouYgISFth+BGcfINqc6En1yi/FzM8YikXYHvMctdPGirU32mdNLEKUrE3hTrpbEB4h
	 eyjW1J5PctYn0LWWl1Tn7/m6ivN7njIzBJpcvDp7VicwP4PwNLwwVmo6Z1sPAkbx/Yg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795242622;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=A5koY/tSPulYUbnh7DbCFDd9lC2ipSi9cXlOxREffJQ=;
	b=J0VP06zUgffyu+8NO81hWx4PQGTmHeJKA7LacR1x/nGwPLKxYQ176+b7mD0M7mP1t2Ot
	 PnKSd+51cHp+T56Dkp7SdJY+8L2PTQQjlvrWokyhLtDEUXixm9f5/QJs8LbHtRH/jMmBw
	 ggYyQkHqqnQeZFotTHJ9Svwf074/zBCCwqIaYQww1fZ2AmMsfmOlXqcll/0Ss0JCE9UFC
	 YZ+z32lrB3Kc1lvNzREROBvkFFmfpqZ3GKIhr2xOxOol8HzDNLdcddIWBFidExtFSFxqR
	 UAx+v45FeCqXSlffBwvtdVO/8M8NczQofWRoZrrbztPwknKz9IIwtANQxqIoRiPbp4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EB8EC1F000C4;
	Sat, 21 Nov 2026 06:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795242622;
	bh=A5koY/tSPulYUbnh7DbCFDd9lC2ipSi9cXlOxREffJQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Ww2C+t9qBYZQRXk0c67kUJDAjB1ZAw1/bPLCZ7UPJjLbXcv0rDMmh6E34XSo59u0S
	 f5arBspZ2L5PlbAzaI8Ajte6hcaTdmTZ5bbKcoqaUSe8C5irw7ti1MLjST3BQfQQex
	 JSiuIbLpGHFG9lPRKCp18a3CJA0FsVEuEE4PxUEjuUg9HKHCNnmKQbedsGNaKg2t5P
	 Av/jjXphmfpxrDm3cJJKKVUwNW7SSX/XyD9po9ImX/gDFP4uC36foHGMjBNhP+nSSG
	 AlYkTEjfhySPpIyJRmg4sHGiZFMwHXT5+NBwRrI2aIdUf5XKdB99etM9195ofeBcpm
	 WHSXxrMk8+EYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4CFC54BB21;
	Sat, 21 Nov 2026 06:30:21 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] media: verisilicon: Fix VDPU2 decoder error
 handling
Date: Sat, 21 Nov 2026 06:30:20 +0000
Message-Id: <20261121-vdpu2-errreset-v3-0-073b5e5bdd64@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNTQ6CMBgFr0K6tqY/UIsr72FcFPgKNUJJC42Gc
 HdbjAnR5SRv5i3IgzPg0TlbkINgvLFDBH7IUN2poQVsmsiIESYopQUOzTgzDM458DBhKaQ8EcJ
 LrjiK0uhAm+cWvN4+7OfqDvWUKmnRGT9Z99oeA027b7z8jQeKCdZSq5zwSiiuLm2vzONY2x6le
 GA7nZE/nUVd6hx0UYBoAPb6uq5vOxtlqf0AAAA=
X-Change-ID: 20261115-vdpu2-errreset-8688700393a3
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795242621; l=1971;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=1u5taNj+P7yOouobMLZ53fRbxme9fnoguPLNBW4jIKQ=;
 b=xgWfQ8NIkGVMLgnHHe8JrgTb7tJzzFTuTK/+ZyPcmWSpQefkaGuBU1+8+AiHQB9TeRfCnDWj4
 C2UajmH4aO0ACL4Wo+FKfEIlYGKWlszh5mhQH6FTirgq6jMfFPXkA0O
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The VDPU2 decoder reports failed decodes as done, and its interrupt
handler can finish a job the decoder is still working on.

Tested on Orange Pi 5 (RK3588S), v7.3-based KASAN kernel. v2: 72 H.264
fluster suite runs, 50 error-stream runs; no IOMMU faults or timeouts.
v3: one suite run and VP8 61/61, same results. The decoder was still
enabled after both buffer-empty interrupts of that run; a later
interrupt ended the job.
With a TEST-only patch (not in this series), the IRQ_NONE path ran
200 times on real registers; bus error and timeout, simulated 5 times
each by injected status bits, were logged and ended their jobs at once.
VP8 stayed 61/61 bit-exact.
A TEST-only injection of a decoder stopping right after the status clear:
with this order each re-raised interrupt ended its own job (bit-exact);
with the v2 order it ended the next job early.
Build-tested on media next. MPEG-2, RK3399 and RK3568 untested.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v3:
- Patch 2: read DEC_E before clearing the status, as G2 does (Sashiko)
- Link to v2: https://patch.msgid.link/20261120-vdpu2-errreset-v2-0-8f4ef55e6dee@gmail.com

Changes in v2:
- Patch 2: no reset after an error; handle the interrupt like the G2
  handler instead (Nicolas)
- Link to v1: https://patch.msgid.link/20261119-vdpu2-errreset-v1-0-f8fa403b6a3a@gmail.com

---
Arun Iyengar (2):
      media: verisilicon: Don't report VDPU2 decoder errors as success
      media: verisilicon: Handle VDPU2 decoder interrupts like the G2

 .../media/platform/verisilicon/rockchip_vpu_hw.c   | 24 +++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)
---
base-commit: aa0f4c41d4870a18e65772a1817af16427200371
change-id: 20261115-vdpu2-errreset-8688700393a3

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


