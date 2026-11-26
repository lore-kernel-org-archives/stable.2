Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691001;
	b=omZBLODX/3G69NBoO+CkYueApkZ1ScHrO+FALimbeneSR133FkoM50BWAetxYX+TzpKp
	 R9lgUnIuJzIW4KDr62FpQcF0/1q+xKoo7mvIOy3faFruZypowoLa8YrJ8eLBlGVX45GH9
	 EiWhi/PAf0H8iIqhQdgyzivTX3J7A8002VBpGLFO6X9lrYEWjF4Ev7y1uOA2St8mr5dpW
	 FSD6H7gX3xnzSpva2Ryth6AmibQLuDOxDaFhRuTM69Y3EAcR9tS8+CsndbujB819LkOEk
	 2HMX8kRIo+l4ICaXfkIc5uKeMwVWuQ7dcyOu16NvZZ4v09HEeEHmnQ4r2TgCMYnphBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691001;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Jj7yOsZTTrZ0ZiuR67XlxFYrMv4FL8e3RY46ndUied8=;
	b=Pk7kQl+9cbvLSdLGWD+mdDkPtqX0OxNum8lKJo8ntfiAScePJl6mn0ah7F197i2Ku5Wo
	 vq8cZ/G6eVaVg67z+EJ/jsjte2KEJHkfeAR9+tq1StMN9G30+fjiZq7VB7p7bXZpg5qJQ
	 HFYqDWZgCG+n5xkzvA7MVon5NHMZ2yBJf6EorKGSz6IYHea3asCGCNzmxz+p9We1J/UU3
	 f7dS6lh4bSa+gEWd+AaKGUXkrWE82eV20shlBsw8bJu/GHo5uxfCTGmQ5mEkgUT7hI+kl
	 2vYrDMZTXl9uhan8tXshH3meLJWX9V3v3j2F/tbs/vcr6+1dTaRfelJwETUpDHAlJfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR9UF0EK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929CE606A31E;
	Thu, 26 Nov 2026 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR9UF0EK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795691001;
	b=jWJ5MDUrazx6Cd2vKAAOPe/rV2ZmmSPizP2qlZK8xf5PNnQmLSNAUt8gheiRvAtDzf9p
	 ET4CsnejJKMYfGBAehtrkeMWtJ4hp7HWaFpuQ/JmhJZWPbP7TjPBdZu/96PXOTKNq/x9w
	 9lP3AA9em7qXddK5QkgiDvlfqJMBUjfezG2pqmRfDxEUWT3qb+d1gQBFCRoZv+bSIZdzY
	 hJ/fnv2BesrpnbMSmsOVQnN5dS9Ki86zJFrQls333vPfE60D3K1Wlbf9+/yqgpV204ry1
	 cWepwWoSyIjyh9wI1pxPBgN6EGbCcWQPVC7bbTqykQhIUe7gL6bne6A+YL4IEU0tGrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795691001;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Jj7yOsZTTrZ0ZiuR67XlxFYrMv4FL8e3RY46ndUied8=;
	b=vW2wHn2AoRPnnQiJj/BLadXTsUwILwZFWw74B7X59Va3329S734h49DONwLhZJsBX5QK
	 bXlEeH+lXOTOuKXKP14KVc9VUI6uIFwYTkN8FTWyxtyrQe2XgXUPXRfNfBmdMP80T6GAY
	 aJQf/0f/WfoIHkLpnRokxpdOTc87q+cL9DMGYcAiTFuU/6yO8sAJGkrb8uzlHzlfro6mH
	 KJdEmM/FK3IWmffDVJXGMy+V/vXo+rQZroWA/CnNzpxpYPygTkW/mDcc9UK1rOrWvYF0f
	 n8iH1l1+3X2ZOsYewYbM/QyOL8KS/GV/QDtPayaSjInTicH2L07Vkep/qch73vkv0jA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1F75D1F000D3;
	Thu, 26 Nov 2026 11:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691001;
	bh=Jj7yOsZTTrZ0ZiuR67XlxFYrMv4FL8e3RY46ndUied8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=BR9UF0EKaV2IMREb8IH++PdqudyW6dYG/iRNz4X08PDtp9tJs4tL043UtgmGfVQIz
	 9PgsYNYrnuHn0ifRLElznG9TThJRJae/9RkTSVOy1uRY4tY3l/nisp3YvNjk8gY+/9
	 lOQ7dAv9qq7T0CXBch7qht32CsQkxnlcnNJSUVRiYW22JEcoRloHkPI+bAfiMW3yW+
	 C1IUWz3u4ybNwH9q4VMdnKWHd/syltlPZcVzcHZfJsZz9OZNkBnWo19T59uwNfMciI
	 AFfh9ijdeHb2TRpHlU5wV/BgLswoFt2KSC4cnziyA7sL+n1KNHnS2BZ+N7muFoRE6j
	 L1tFkc69zJtLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6C7A94D45D;
	Thu, 26 Nov 2026 11:03:05 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v4 0/2] media: verisilicon: Fix VDPU2 decoder error
 handling
Date: Thu, 26 Nov 2026 11:03:04 +0000
Message-Id: <20261126-vdpu2-errreset-v4-0-a955b1c8b119@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNTQ6CMBCG4auQrq3pP9WV9zAuCp1CjYppodEQ7
 m7BmBBcfsk874woQvAQ0bEYUYDko+8eeYhdgerWPBrA3uaNGGGKUipxss+BYQghQIQea6V1SQg
 /cMNRRs8Azr+W4Pny3XGorlD3c2W+aH3su/BePiY63/3ih208UUyw084IwitluDk1d+Nv+7q7o
 zme2Ioz8sdZ5toJcFKCsgBbztec/nGeOSl5JUFW1iqx5tM0fQB6SH54PAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795690985; l=1888;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=11oMye5IkP9PU+O+uZwvxvHF43EAO+r22v9RqX+wWWA=;
 b=46EXLdYywrCDMrE7/4LRwjV52TTjcTlQPOOTob2WPUNbuO4utqURogAo66ZFyD0dwAugtxaHO
 OWr3wB+yxhICoDmr2YJp0c8pOdGsIgeop8IxufxYqpfNRdhvIJEAkTM
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The VDPU2 decoder reports failed decodes as done, and after an error
its interrupt handler can finish a job while the decoder may still be
active.

Tested on Orange Pi 5 (RK3588S), v7.3-based KASAN kernel:
5 bus errors and 5 timeouts, simulated by a test-only patch that injects
the status bits, each reset once and ended the job;
buffer-empty kept the job, output bit-exact; 186 resets in error-stream
stress, no watchdog; VP8 61/61 and H.264 conformance unchanged.
Build-tested on media next. MPEG-2, RK3399 and RK3568 untested.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v4:
- Patch 2: soft-reset the decoder after a bus, stream or ASO error
  or a timeout, before finishing the job (Nicolas)
- Rebased on media next
- Link to v3: https://patch.msgid.link/20261121-vdpu2-errreset-v3-0-073b5e5bdd64@gmail.com

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
      media: verisilicon: Reset the VDPU2 decoder after an error

 .../platform/verisilicon/rockchip_vpu2_regs.h      |  4 +++
 .../media/platform/verisilicon/rockchip_vpu_hw.c   | 42 +++++++++++++++++++---
 2 files changed, 41 insertions(+), 5 deletions(-)
---
base-commit: b4e3c4b6a36fd76f57bf3e48638f68ddecc54ba4
change-id: 20261115-vdpu2-errreset-8688700393a3

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


