Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007414;
	b=SMDwdmhR8Gh/xpDdAEWwhSNp760HAaGTUah5tiRpRVlOzfyVAHiTktjSpfVGYayvJDwb
	 KV0wshDyVymNH0L0i93iQv5yasAt3N5pFXfMJugSd5rHKx/1J/N30c2bkV2sdlucCLU4N
	 mGWCOQ2nzfRulDmkRBAcJ8eWKnQudr4itnc/frzRxhLv0HAFOPT74SRbmons2oindQktM
	 CDW0WEkMW0gEDnkjLFhA4X2SlFiAiAV6cdKHrCtM5/Kj6HMRhYe5To7kMEbtVlU7hed38
	 SIxLX0TL/KAM1faj4s6qS1mMNSYigFBsb9Jt2ZWAbYHcSOZnJEVqHwywt5RvS0WB0tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HFolVHsdlQxrFn7oJcUktRPcmpRgRmH6vLNq3RWKHsU=;
	b=SDcc/FALOvSheWgFG2ote57Xn1XT9LNSjeHaSdu88F4sU3r2t38eu7vyv/LTytbK1rWL
	 NpPHd+rq6xB7uX42ndaf76aDb+sisPVOrZ1f9wTDt9jwGBPpJCsXH/5MZLUzM1M7LkP7i
	 pu8aGMr57pxYxcRpmXNUWq5FL19UopQiK9ZOitG9KB+ylj+ryfOxIfRRGPdjs+bDoXtvf
	 Dgn4EF918QoToN2KwlwDK1lW+79+jjrplRf/wzBVW0fHNtn2AGWDnNgNAjcEq35VCVAGQ
	 Ugvtc/RxA2UOpFk9qf0XvWgAEZlYuOaaFR75/P5WQb9BH3iLfi15Oj+rf/7IwZ3399w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=beLxm6Tc;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931C606D824
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 23:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2931C606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=beLxm6Tc
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso455201b3a.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 15:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794007407; x=1794612207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HFolVHsdlQxrFn7oJcUktRPcmpRgRmH6vLNq3RWKHsU=;
        b=beLxm6Tc+6Bxsxoeh2ubotiYZME2+AaKr51XOjMpuAM+32lbdM0ERjIFNpsP6laipI
         wOCiy8RKV3rp5a8r2vBwM7Ko2yk7VBEQ21t9H1AWid9L9lq/Cv3SucgAN+DSkr4alx2O
         PQKAmsj3j5iYVD4RlkwnO/ClKhDu3DaG0mcYwgaZYlJ2NxXBZgxEtIy1HKJj9s5AreV8
         L49LkACX8K5T8lCSK6843GjGBjqxDTZcEhqVu3GtqFba8zdK60w4zgOaeUgcsqSON2ha
         hpPFXsPo7rqDqh1v8Bgx1Nf5f8c+eqFMpEPjWiU3w8cUJfheHpNa05ny8zTBNzIMtS7r
         LJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794007407; x=1794612207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HFolVHsdlQxrFn7oJcUktRPcmpRgRmH6vLNq3RWKHsU=;
        b=Lwy5gk/gfX6quaG/bbgeWEGdQ//jOzmNTNJur0LbP1xJJchLLZS/L53+3yiFenaRng
         Ci/ALhsvwb5/VyZoASJdBLUQwtlAbPDOesjKowIS5TD22KYShXdUbjjLZlfKGHcqxeFa
         abaB6MRgtH7+zN/1heCQ0gdsnTkXM1WVZt2DcCTgVVPNf7zwRfiZkcMxiCxJAlGc5IeT
         Atf6ymDotKoB29Z7FBRQdlf1yFsJGkpoddhAuSN9AfbPcdnCPB10Jbo8Fgs/tYkHzSSL
         Zh9LNG6IORhmE/OXP6bcQf6dtEqeC55y1KTG+iCGfrqKQLH+vZLcL/9HfeIn6I9zn54g
         9XxA==
X-Forwarded-Encrypted: i=1; AKwUvBy2HPvDvR1MHBXaSfdgzFVS9Wxpdq0EHuy3NPlJmmu6Sex4ogsLSS1vjSTvPLsOPqP2vwlfWoE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6/CkmN4pryts3uc1PhMOO3hlcKu5fNUtZNF/zIW5F7sHv2Ug8
	ahAcxY5f6G/SUHYRhs/GHDieBqpO4UvYHoHjQYKQUMUtuNJ6p5k6jb/9c+a8SOvl3A==
X-Gm-Gg: AYBFou3XyVWHS6ax0GAnPccO85FNiFRHZTUvKcgdO3vtG1jFlVIMPCwbu8bUrZT2UvG
	6829st9FC0j9MF40zA3pzRPudJY32a0/PrejnrRm0Y1gHvLs9aRHcykf1EZd2yS1M6JJGtJ/22S
	Po4Xsuy3ROE8TBbB5xq6HZI9JPAU0qwhhBjms6e9o9GXwRSPplMwaLYkdQHAhyAJIFcpCMmTeDx
	thYDVVUYLd3D6MBuQARHlYGkJlNVyntJ5VG/gN40PUzfttFbeaYj94Om3UwUOhlLZ3SJpa71l/+
	ExM2aIdq3U01ZV0KDuGzScjIzEX5fM3t+AR7GX0KMD6ObWW7pGlNdlxF626xuKuL9Q1+6dXtoB2
	faqh9GJYfm2uJp357hCROhG2cXtcaAMur2hxY6j7zdM0umxYxmf9YAKZlXnI4NsSV+r7QaCAp+o
	SAAe8zcrkWCLfPlGdusaSPcaxMQkOcK6fmcAv72WCCxfe02ooldGMIRflANyu+l/0FGjLMyVKfW
	nuYbT8QzTeOdsA2e054s4L0daPzclUGO/FgTTKCRrNbxPR+qhHM/DndC1kOY8Q3XxaRDXjsE1+X
	1CgbQVdvTt+vJ5+Ce1QPjn8gtEY8R1Tm65TjcKEh4LNgrLyF56CpLMtEuBQ=
X-Received: by 2002:a05:6a00:4515:b0:89f:e1e7:e7e8 with SMTP id d2e1a72fcca58-8b37aaa7740mr3885857b3a.18.1794007407226;
        Fri, 06 Nov 2026 15:23:27 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b356c2c5a5sm973657b3a.7.2026.11.06.15.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 15:23:26 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH v2] rpmsg: virtio: Reject a message shorter than its header
Date: Sat,  7 Nov 2026 08:23:22 +0900
Message-ID: <20261106232322.1093165-1-lian@is.s.u-tokyo.ac.jp>
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
Content-Transfer-Encoding: 8bit

rpmsg_recv_single() checks the msg_len field of a message header against
the used length with an unsigned subtraction, so every msg_len passes
the check with a used length shorter than the header. The rx callback of
the destination endpoint can receive a message of up to 65535 bytes,
longer than the default receive buffer of 512 bytes, so rpmsg_char can
copy the whole message into an skb and read past the buffer:

  BUG: KASAN: slab-out-of-bounds in rpmsg_ept_cb+0x4d/0xb0
  Read of size 65535 at addr ffff888002484010 by task rpmsg_echo/140
  Call Trace:
   rpmsg_ept_cb+0x4d/0xb0
   rpmsg_recv_done+0x29f/0x840
   vring_interrupt+0x32a/0x540
   vp_interrupt+0x146/0x180

Compare the sum of the header size and msg_len with the used length, so
no subtraction wraps.

This patch is assisted by Claude Opus 5.5.

Fixes: 9648224e564a ("rpmsg: validate incoming message length before propagating")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v2:
- Leave the check after the dynamic_hex_dump statement.
v1: https://lore.kernel.org/all/20261102221504.175116-1-lian@is.s.u-tokyo.ac.jp/

 drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 23ff6c8b7a20b..3d58bb19e9297 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -676,7 +676,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 	 * the reported payload length.
 	 */
 	if (len > vrp->rx_buf_size ||
-	    msg_len > (len - sizeof(struct rpmsg_hdr))) {
+	    sizeof(struct rpmsg_hdr) + msg_len > len) {
 		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
 		return -EINVAL;
 	}

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

