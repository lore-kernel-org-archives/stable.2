Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826385;
	b=pmaHIoKe8Omipx4Gn5KpBll3Atv98MJcN4WPwtDnw+NyWLaUo9aSP5jh7bRPTZY2lD7C
	 1lBqbRLLf2gAxDg9Ji3GCelgo/5lqkZ1Hqy76My3tqSoHSCJi7fdC5UqgvBUdVwj03dAX
	 trFmjvRhoOLPpPHPJfLtaMuerlkTU6wECuBDPnzIyjOZ1qo/ckfTu5IPZoKQDKDnLUDGl
	 VKIt2qAIBGWkv9g8rwpZo3fuVqdlAUg706XYt0yGUqBEeyLI+04LuDLMr0nYVs1zEA6uW
	 XZumuepMnED0XRo14R0yQtQBhMNiw71JifiLKQOA/h50gvjasmRlbRXdHNLwaFCPFng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Tj/8Pm2fTV3ey8dapsvWMJiajUxVVR1CyAbN2iUPwZw=;
	b=yrbMaEIgzFbliVyC5fDqJSRyC2hTEsNxG+1fWwiZp8UhXVTdVwTWD3qLFViOaFSyJtp+
	 u1FXR8Eh8SVGrXVMho1KhNxRAZN4GUvFulzpmKyaOLNJ4RaYhPb0YU1U7B5/Ask5x1yEk
	 Q1Yg8jfQk3EJGffa3+SbAo7zJVjsFf3tTMGiC3c9frRfrZGuIYINwoOodM7mGX+jDmWBR
	 bYcwfSptxCW0ZT2BQXt6iW3z46XZEVH/BYYpBtuc2E8pBdII2lAEQHLmK/V/w/rdinwRL
	 krWESPWfel+aGlsIKrxgz2/6hdSLWTwSD71UaKFEDjF69/VpMOJ2eREd5t5S3NlJu2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rIfAPW0P;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3EB606A330
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB3EB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rIfAPW0P
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-833e671ee9fso4408210a34.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826384; x=1795431184; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Tj/8Pm2fTV3ey8dapsvWMJiajUxVVR1CyAbN2iUPwZw=;
        b=rIfAPW0PvGowM9yXVlgvAomAq2XEyvblM2w77mNogN6pOTbJ8YN39Kl4O64YPc8XOS
         4PAy/3Stcv2puEl6ljj9JEBj6rvE00zzTvjJa5zlpNm5dXPOrWBVegRK21j/buuFqPJh
         DJktr6wOTrjiQ0tIPeaLLlKd40/lj/M63DXCYM01RsGDzik/iydblKhAxlnli2JBsYyf
         pvPdXen+amqMVFJmjKqBmbv6G1OwYpwWvE9oJ6KB/yconVN/sZw+NJ9bU52ewSegLbFp
         EetTDw/NIii1F4ksX6sdrDeKZOQPttOksC1jH+m+t7AK6Cws2aifp0F5KTzT5b48lZaP
         ZEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826384; x=1795431184;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tj/8Pm2fTV3ey8dapsvWMJiajUxVVR1CyAbN2iUPwZw=;
        b=REOFO+rDIuwec5+HmrxFUe4V4mbdRgp5hGKb4ow5FhsUTp9qvpggV1kg1fPZ7Xa6u4
         1kkv+D02GX6ey99ItYzeUKsnSwdXFAFCF7U6YQCPNEZw0o+WeCQlTMWlMrNWS0OYH9W5
         TP7ZXsy33+beqSnkuu/Obf4K89feSHxR8qeTXUUMlWmOH1av2GlULjn/O2hFRH+iGs05
         iN4564XVUEObjCOxCk8Uw5es6wEBxn4BlM5YG/i1n9CWBL1uqjwQgYQhoq1TgxGIBFBS
         Sdi0Up9GvI7GaDV69y2hsP1VU8NUkleUBSJC5+hH6T8jOotjr9HSRXqGAR9xRTImrZW3
         nsGQ==
X-Forwarded-Encrypted: i=1; AL+hErEug8oUhqqLXoLsSeRRlxtD/9lgWQFMwKDG0GlmSAhiG0WdlGGwXX6XkqTRjdNalDgC/BBiWUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TUxH4lsdECXiKCsw4gOmApgKbNswInA9QB1tR90kn5q0ceJsQ
	bQX1FfzrROlhQexWbcP1gbwTReJFTCkxBrpVX5oYqnjypAGFqyYnITK6
X-Gm-Gg: AYBFou1NcO1BMN2OeQedtPJt826vSYhqktjFAkl/hXhom1uV/3oIDqXY8oE+myoZ+wy
	cALgrvLajRpvo49MGqpGytANwHVe8BZ/YTUcqeT2unvJN0wRFn0qB/ObMKvfjZy00c33xktz9Hh
	UzolpGXYh+1xPkF0h5spZSMYnwdqSiAk8xhYowIr2uTVQM8fsrbQ66YCQWAUrbv4JWjOB6uB9Nq
	e7pKc5ndoWzpkdw4QLt9oqLw+Iz5jRr1dtiFEAnkMdBZG5yRUPMIbhux4ynloy6K0qwchxrBWjQ
	5PgNtbBJNwj+H9+dZ136UCvjzQCPqgsSO9slJCA/sFtN/4jE6mSV3gz7Sl/zQiqgsRZZo0uPUbK
	pHUUJLr3x6PAQuOgURzFJSu1tNH/GVBN00teqHcG77XoUYTl3eezTQzG3ZJhE74bJkoiU3bSOFx
	AsdS0ZWx1QLxz5i0SkjndMuxNVGogA8BxJDo+4jz3iwXJCgV9wjYdgeHFQtzS9G+CsRSJxuzGlP
	755hAr5Z2C5ArBeLp5zY9wkA3iTtrXVkHZ/LO3E0qCqri1RDvrOzRLnx6NYgtfHwI0X/mJbE9Qr
	1U7CqUQ2Jz1F+S1hHUnuneaJI63bmvgDZCOesSTpybuFw203wsPvTdYWFHLsqF8K2iAV6+N1iZl
	kNj/I7skAjJjOhXqZtKpX7oPV9y32xAHl3VcTiH2YNnf41JYFI47UTyBIco+cz4Dpqh3C6Z4U6Z
	kenZt8YVvWSmtVziJWqR+xK17PRRFtvukWsRTjoom8+AgTUxyvOyM=
X-Received: by 2002:a05:6830:2e13:b0:81f:8a6d:7b52 with SMTP id 46e09a7af769-862898f68e1mr11462851a34.24.1794826383865;
        Mon, 16 Nov 2026 02:53:03 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862b08b8b5bsm5555546a34.5.2026.11.16.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:03 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v8 0/6] dmaengine: dw: serialize completion and termination
Date: Mon, 16 Nov 2026 03:52:28 -0700
Message-Id: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QwU7EIBAG4FfZcBaFKVDqyfcwHigMXYxtN6VW1
 03f3enuwVoPNeHyk5kvP1xYxiFhZo+HCxtwSjn1HQV7d2D+6LoGeQqUGQgwUoDk+b1u08jDBw+
 t4/nc+ePQd+kL+SQ5ai2iKmOQwTEiTgPG9Hnln19umfZf0Y+LuUzULiOvB0fMckUmdk3q8OG2R
 xPHlMd+OF8bTnKR/lmGjuTGRas9BBNN9dS0Lr3d+75lS5kJ1hjsYMAF16AUVip4Z/0WK9ZYsYM
 VhHkDdRTKRu1xi6k1Vu1girCITqkyVBGs3mL6ByNtB9OEhQJEWWob6/jnz8wa23umIQwQhS+UB
 VBhi5UrTOodrCTMBmpVBFXhb2ye528mjfUyygIAAA==
X-Change-ID: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.17-dev

Use virt-dma for transaction ownership, deferred client callbacks and
per-channel synchronization. Keep DW hardware event processing under the
same channel lock, including polled completion and software-LLP progress.

The first two patches serialize completion and error recovery with
termination. The third replaces the private descriptor queues with
virt-dma, including cookie accounting, callback synchronization and channel
release. Three separate patches then extract hardware-LLP residue
calculation, calculate it in the status getter and report queued residue.

Status polling can complete transfers without invoking client callbacks in
the polling context, while synchronization waits for callbacks already
running on the selected channel.

Each whole transaction has one virt-dma descriptor. Its child hardware LLIs
remain owned by the driver and are freed together after the callback.
The controller tasklet continues to process hardware events; virt-dma
handles client notifications. Submitted transactions become eligible to
start at issue_pending(), and residue lookup covers both submitted and
issued queues.

The series builds on Serge Semin's channel-restart and callback work
[0-2], using virt-dma following Andy's review [3].

Based on dmaengine/fixes at 6628e7d4c6b2.

[0] https://lore.kernel.org/r/20240911184710.4207-1-fancer.lancer@gmail.com
[1] https://lore.kernel.org/r/20240911184710.4207-2-fancer.lancer@gmail.com
[2] https://lore.kernel.org/r/20240911184710.4207-3-fancer.lancer@gmail.com
[3] https://lore.kernel.org/r/avrHOJ-fVZOO32bI@ashevche-desk.local

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes in v8:
- Replace the private callback-deferral and synchronization patches with
  a virt-dma conversion, following Andy's review.
- Place the conversion after the completion and error-recovery fixes,
  incorporating cookie ordering, completion-list cleanup and channel-release
  draining in the same patch.
- Keep residue extraction, status calculation and queued-residue reporting
  separate, adapting them to virt-dma's active, issued and submitted state.
- Use per-channel virt-dma callback draining while preserving polled
  completion, software-LLP advancement and controller-tasklet exclusion
  during resource release.
- Keep child hardware LLIs under a single transaction descriptor and
  distinguish submitted transactions from issued work.
- Correct the residue-calculation and queued-residue Fixes tags to identify
  the commits that introduced the affected paths, following Sashiko's review.
- Attribute the cookie-completion and channel-release fixes included in the
  conversion to the lock-splitting change, following Andy's tag review.
- Link to v7: https://patch.msgid.link/20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com

Changes in v7:
- Use a scoped channel-lock guard in dwc_tx_status(), following Frank's
  review, keeping polled completion and residue lookup in the same scope.
- Collect Frank's Reviewed-by tags for the residue and completion patches.
- Link to v6: https://patch.msgid.link/20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com

Changes in v6:
- Keep dwc_get_hard_llp_desc_residue() next to dwc_get_sent() when
  converting it to return residue, following Frank's review.
- Remove inherited RFC notes from the individual patches, retaining
  the revision history in this cover letter.
- Link to v5: https://patch.msgid.link/20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com

Changes in v5:
- Rebase onto dmaengine/fixes at 6628e7d4c6b2, using the shared
  dmaengine_chan_dev() helper for channel logging.
- Split residue handling into a behavior-preserving extraction, status
  calculation, scanner simplification and queued-residue reporting,
  following Frank's review.
- Share completed-descriptor freeing between the tasklet and channel
  release, retaining callbacks for normal completion and suppressing
  them during teardown. Name the helper dwc_free_completed().
- Carry Frank's additional review tags and put the submitter sign-off
  after the review tags.
- Link to v4: https://patch.msgid.link/20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com

Changes in v4:
- Split v3's callback-deferral patch into cookie accounting, residue
  calculation, channel-release draining and callback-deferral patches,
  following Frank's review. The resulting seven-patch series preserves
  v3's final implementation.
- Place device_synchronize before callback deferral so clients can drain
  deferred notifications when the completion list is introduced.
- Carry Frank's Reviewed-by tags on the unchanged channel-completion,
  error-recovery and device_synchronize patches.
- Link to v3: https://patch.msgid.link/20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com

Changes in v3:
- Order channel-completion and error-recovery locking before callback
  deferral, retaining four patches.
- Require a locked RAW.XFER event before retiring a transfer; zero source
  residue alone cannot establish destination completion.
- Preserve polled completion and software-LLP progress in tx_status(),
  queuing client notifications for the controller tasklet.
- Serialize cookie updates with termination and report queued residue.
- Drain deferred notifications on channel release and let a pending
  tasklet return without MMIO after the last channel is released.
- Adapt Serge's two patches and retain his authorship and revision notes.
  Drop the Tested-by tags that covered their earlier implementations.
- Identify the introduction of the synchronization API in the final
  patch's Fixes tag.
- Link to v2: https://patch.msgid.link/20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com

Changes in v2:
- Carry Serge Semin's two posted fixes before the synchronization change,
  preserving his authorship and revision notes. Add the requested stable
  Cc trailers and Andy Shevchenko's Tested-by tags to those unchanged fixes.
- Add a separate error-recovery fix for stale error status, empty channel
  lists and software-LLP state when terminating or restarting a channel.
- Use tasklet_disable()/tasklet_enable() instead of tasklet_kill() so
  synchronization preserves scheduling requests from other channels.
- Explain descriptor ownership during termination and acknowledge the
  shared-tasklet scheduling race reported by Sashiko.
- Link to v1: https://patch.msgid.link/20261021-submit-dw-dma-synchronize-v1-v1-1-6af85c2d6f69@gmail.com

Revision history from Serge's series:

Link: https://lore.kernel.org/dmaengine/20240802080756.7415-1-fancer.lancer@gmail.com/
Changelog RFC:
- Add a new patch:
  [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
  fixing the "XFER bit set, but channel not idle" error.
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.

---
James Hilliard (3):
      dmaengine: dw: serialize error recovery with channel termination
      dmaengine: dw: use virt-dma for descriptor and callback ownership
      dmaengine: dw: report residue for queued transfers

Serge Semin (3):
      dmaengine: dw: Fix XFER bit set, but channel not idle error
      dmaengine: dw: extract hardware-LLP residue calculation
      dmaengine: dw: calculate residue in the status getter

 drivers/dma/dw/Kconfig  |   1 +
 drivers/dma/dw/core.c   | 493 ++++++++++++++++++++----------------------------
 drivers/dma/dw/dw.c     |   2 +-
 drivers/dma/dw/idma32.c |  18 +-
 drivers/dma/dw/regs.h   |  24 +--
 5 files changed, 226 insertions(+), 312 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git fixes
change-id: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

