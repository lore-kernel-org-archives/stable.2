Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082548;
	b=QdZxPCg47u/w+OGyzbs7CsZkpdBcNhGdgfKM1fqUBhs6lv6AKsAKMwK9X88bYRdn85YC
	 JfKY8+O33xocyLJ/5qJHMja9pY7H3OMOVear3IbQm/W8f9z543Yx0SfbWLnZGH2yCZ54o
	 Bge8I6oeanFfd6sPcJ7MtaNhfRJ9h9vA1xoCABYb0J8p5LhSfaDJpDlyKqK5xP3MaR8Ft
	 fLcVru/VQq8VJB3tweiIuFCxwozjj+DqZmxM+4SKqmQl2D7ngnfsbTZBQ10XhbPz9ZTJK
	 JZKVA4xWSr1MsQP5PiYNVrd4z6vTJ00y3nkxNvSEQhUolvWuJ16BiwNm8CKj9yIcq/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=D8hYj5tsIjDvKDaCqFJ/7W6N6FqJoCQM/5nsT8oMXek=;
	b=D2AMHwjlWHJdVkVB918ieVgKI6XoJ7u2Vh2BgZjml4fEWjdErcJZADbZIrx/P0c4OAqL
	 Mts9wObG0l8L+RJGCZ1ovrwUx1iEif86XHQ43moCYyDM0IVJBh7nQp0CK8eQVGY8KF9fr
	 m83tnArQCFhUlPmwlv8Qcps6GW2FWuFA+jIkACv0Dw02xT3cAeSXi6cDoFO+WreL5X0bS
	 SJgaKgG57m3ynNPOcdv1F28rUVkCVkLe+Wny0jcsMaqARlYueRifcwD/M3kD0LJvpcpn1
	 u0mx2SR+s/Jw5S5ALxfPgGJ1nrywaD87I06yvqBQyMZUKUN+QDeJS/WSjGKv0Lpuugw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1z+UYgf;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB36606A32F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFB36606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1z+UYgf
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-70b875f6f13so1727383eaf.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 02:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082547; x=1795687347; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D8hYj5tsIjDvKDaCqFJ/7W6N6FqJoCQM/5nsT8oMXek=;
        b=v1z+UYgfSKO2IoV1Jj9y9AT29S1N5RHG9j/LdfPYyQgqTcyje3Wrs5U91c8/mh9kbM
         vvbx6sSCgfoB3WB03bIcN47rArblhIa9OyzBwIbbAtG0LmqHxmBn8FFeI0WYSZWFULSZ
         2CWXsWtQFaQ/WadUODw/AMrXl0B1pFM3qfP1WrJie6SEmjFe95EzTtSDZLTRUm23NOLZ
         VM57BlUW2HMywc1qDXXZcfGMCygehgBzFMZOUuTcUVofGHihmw6QqP08o1HJYFe2qciY
         f0EtL5+Ao2PocaAyy6r2kBvr+nEHqcVAGwEaijUCr/tAHmJ3WetcKhWv2/tK3kgd8A2a
         kqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082547; x=1795687347;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D8hYj5tsIjDvKDaCqFJ/7W6N6FqJoCQM/5nsT8oMXek=;
        b=YeeS0eij64A7y4nnQRebIyKfWLzIAR8k33R1Cc8F6d75R3My27wRsdiawdmCd0ZJtr
         6BSkh8oXdmsOrj212U2PXJurxaTzZ+LfNipK99BWoXAW1KD3qttZP3tdwgkikT8ezpbo
         80AAnhe1fsf4ghtcuwwHH89ZLJImDlSm933jw7lWLs48UlVzMaOo9IdMRFB7gSP0x57G
         nLJb3Ew6EJrme+QR0FLbSfH6huZ+K7j9fx3AQ4l0gRfgjZNobOgxiFRujcEMsS36GTR4
         nJCRbYcD8KpxYp1cqWOz+z+3UVpxIuDKvH4LvnDEM2n55yo54r3wl81bGDz93fl9idwe
         TF3A==
X-Forwarded-Encrypted: i=1; AL+hErH7dPhZ2IqbyUkevhIdIaBZseFNwFr7+5ocu6LVqovQm2KE/H5nLuJnnj/TkqpMjVUGMsK+Jr0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8e6XO9DQLNp2dSYGbeEaLlZHlwivfpOYR8tc5Czyqi413B2r3F
	YEaOCd10eJyyg65hQ7DlHPwlBB8eYmn7ZDMA4LYfFkCRQIQ8DOM8bRV8
X-Gm-Gg: AYBFou2WTC4jtm/ksjXLcGXd/0aCRHW6gkFs6gRbS0sLDUCeLL2l3Z5hfwBXFw0Fbpp
	qo6ReD0oXd65lJKdvRd7OkLH7u9rT3vItJvT5NFwoOp0fDNGeAXFg7Plvfe9VWETEGELXAGW/XG
	W95ERCrBWn/nbr+bFjsOI1Ui1s5MxHyEAIl5Fr4s2z/X5FqTKOYIB7G/so9XKr21/r7lK/+QEUT
	avSzgXjlDa8WeWmfwf8+Wtzel+N+cg6rOSUBAKSyYGdSkz60jIBiEhLcmBeu7Dy/ILEKUka6rZZ
	KCp6sISws5szklUrxE8by0XYg/RtCcVMOLZWQFEg9LP2iUVNDSBL9Yl9UWqsGUkKJCVHpIPk/f8
	5T4Lv2F07jRO+1pXkgvlw1O3uLxQrv6vKSWipzrAOF0+wKQrANIXfLgEOEoySRw6OKxfBxFbVQe
	T3hQvSJ8efYPXGM+Bv0fseiD2Ph/mDjlA2B7G+f119r3qOxzxAMY0w5K/EjrUvn6y0Y2nvu2IBT
	tAk+TiooiutYgfQduZNJowKND7LrpRjScDqG5Gi6XMOq0uLqt970k6e3mQ9smgQ+rzWGe85Co8s
	YEGvF/lbdDxzz8H+9Ox5R9sWCeREuBkol7yt2ZL40U46NiTHX7RsrDwjFl9sKdkgOtYT1bpnnCT
	kL45lxEcifMDBABIXItg0QhLCcHL7RTCiga5nJQH2qibZQ68rP+X9xBjqZNkE5Th7+XYuGkQgfx
	pr48X29goXSt/SBuPEd0bNIo7vWqMviGP+IlYD1c8SzXQz/F5jKBumQVQpBArQUZa40Ow5LslbF
	Q==
X-Received: by 2002:a05:6820:a289:20b0:71a:e5a4:1881 with SMTP id 006d021491bc7-71b1861967dmr3072296eaf.77.1795082546496;
        Thu, 19 Nov 2026 02:02:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b18fbb9a8sm3906194eaf.0.2026.11.19.02.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:02:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v10 0/7] dmaengine: dw: serialize completion and
 termination
Date: Thu, 19 Nov 2026 03:01:34 -0700
Message-Id: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43SzU7DMAwH8FdBPRNI0nxy4j0QhzR2tiDaonYUx
 rR3x90ORN0hSLnYsn/6J8qpmXHKODdPd6dmwiXPeRyoEPz+ron7MOyQZaBGI7k0gkvB5s+uzwc
 GXwz6wObjEPfTOOQfZItgqDVPyiYQEBoiPiZM+fviv7xea9p/w3hYzXWiCzOybgrErC0ycdjlA
 R+vezSxz/NhnI6XiItYpX+GoSOYCcnpKMEk4593fcjvD3HsmzXMIktMVjDJONNSKfQKYnBxi7U
 l1lawlrBoZJe4cklH3GKqxHwFU4QlDEpZ8Ek6vcX0H0ZaBdOEQSu5tdqlLt28mSmx2jUNYRKRx
 1Y5KRVsMVtgQlcwS5gDStWC8niLuRIzFcwRpoKjf6FSBBG2mC8xW8E8YRYiNwaBdzGV2Pl8/gW
 v/YQVZQMAAA==
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
termination. Patch 3 moves the DMAengine channel and its lock into an
embedded virt_dma_chan. Patch 4 switches the descriptor queues, cookie
accounting and callback delivery to virt-dma. The last three patches
extract hardware-LLP residue calculation, move it into the status getter
and report residue for queued transfers.

Status polling can complete transfers without invoking client callbacks in
the polling context, while synchronization waits for callbacks already
running on the selected channel. Both status polling and result callbacks
report a bus error with the number of bytes not confirmed at the
destination.

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
Changes in v10:
- Split the channel and lock member changes from the virt-dma descriptor
  and callback conversion, following Frank Li's review.
- Preserve the bus error and unconfirmed byte count for both the status
  getter and the result callback. Reserve error storage during preparation
  so submitting a prepared transfer cannot fail.
- Use the DMA core's existing callback drain on channel release.
- Link to v9: https://patch.msgid.link/20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com

Changes in v9:
- Simplify the software-LLP residue calculation and remove unnecessary
  braces, following Andy's review.
- Link to v8: https://patch.msgid.link/20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com

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
James Hilliard (4):
      dmaengine: dw: serialize error recovery with channel termination
      dmaengine: dw: embed a virt-dma channel
      dmaengine: dw: use virt-dma for descriptor and callback ownership
      dmaengine: dw: report residue for queued transfers

Serge Semin (3):
      dmaengine: dw: Fix XFER bit set, but channel not idle error
      dmaengine: dw: extract hardware-LLP residue calculation
      dmaengine: dw: calculate residue in the status getter

 drivers/dma/dw/Kconfig  |   1 +
 drivers/dma/dw/core.c   | 595 ++++++++++++++++++++++++------------------------
 drivers/dma/dw/dw.c     |   2 +-
 drivers/dma/dw/idma32.c |  18 +-
 drivers/dma/dw/regs.h   |  35 +--
 5 files changed, 333 insertions(+), 318 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git fixes
change-id: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

