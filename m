Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955742;
	b=asd/QnJuJatn8KRjR7NJzf8SCiP5p4bWXy7Xg71Z9idkd6WvXkZU5d8sxJb8/CF2y/cl
	 zCXNHktYp+YD8V9indPHqL5ze4Y6SrOkYrAdqdRBdyl7aFWX1bmZ+iNceRmMxx8sNvJt0
	 MNDY5a4ClLXinO3bK1S8Tc9aRfuUcBHJQ7zRYM8IkkYj7ggSu7j0as+Vc3d7ScKYrggnR
	 jttAbGSxLoE90y4goOQn9V6VTAoDfy94QLLXS9LKY+V643X0ap4e17wQEvRYJIBmeQZoD
	 rregDq38T7Ci/2DAXZCbnl+Zv3LeHNcm1nROPRmoChYRo4vOtSfYymBUtllGFikeRQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=p1SI0PpHlUSgmkJJ7etP8wZysJe6BXKW+ZLQLVa2HK4=;
	b=Se0JHYitvu5dyLVf78orw77ANhi6zFzbufNQ979lAEfKisHGUDJxKQaec4gkzNTeCwXY
	 m4sUbwSt8TITu4D1IMRbqQE22S6KwER/a2t3F9xHM6rWLZ5GahjzKKUJboo71zFt22o0G
	 Ew0ElG8fxSAEmawD9PZTyBi0kXAj11nfm/5gb/aRlEXTAzucOEDw9ZfnpcGqyShKsjekv
	 ALJHInSadd9yoJUkfqKUnc5avRUnqVRwkLr4xV3txBQeF1jv8cSkCtkgECvE7plP2YO/8
	 aFGcrxd8qPFgAa/cywkdQ9MZuYpLlS4NpNXqBQtNN62vE1HmGELIlXTnJVukX7n4bSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zX4C5cHG;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B087606A331
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B087606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zX4C5cHG
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-57297329b3eso139604b6e.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955740; x=1795560540; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p1SI0PpHlUSgmkJJ7etP8wZysJe6BXKW+ZLQLVa2HK4=;
        b=zX4C5cHGgvCvel0fCNWPzdowOTp6Uv5RwkFjyibqqeqIs/LFXtTtECP4wYmSsTdcFh
         PEGqwDUjMpjO9Qgz7rEJUhshfcCHKyu2P2B1st38hv5Cika7hXIN+2nRjuGng7XbWYQx
         P8BGZeHJ2p2UlTCsZJxk2q6YdH7ROAXq+/t4s+C5pCOi4CyZ4eiBOhkk/7Dm7Oldrrbs
         TFlCjSQI3BCwlReY5pA1ENngaXizuMjIFK2j3kQZtX/NMArMBxR8iWoArwSDDRBl86v9
         L47CxVDe9Rf23ByQT0YZ44wrRqJfKW1vSzttW1jcSOiNzN5hdD3BnhD4SsGasS4MKTyi
         JzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955740; x=1795560540;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p1SI0PpHlUSgmkJJ7etP8wZysJe6BXKW+ZLQLVa2HK4=;
        b=QOTlXVQQ6rNlVmJ8ODtCruiPE3eD+FurXrhJQGZMm3/0PRIAiXEBushokIqpjHvgcZ
         lFLd+6wKFmq+INLKS0KIf/aOmdsHditMhtQYigYawCTpC9IiVQh09mnMXcXjnLknI6yL
         XWTpCb6E0+MQZSo+nkTP5sTR9BjRKV8uQ1kl7YN+fe4rkwA0RdC/ODeJoj7P09kZrL/t
         6V2f5Svxf1JH+HRVQqotpC5dXrppt5Th4bbvWHW7NM8p7GpPZCS1cpdoCZZp76o0LZhy
         elnkrWWQrnErzy01BfOcI0hPCZnTvymvDlQT/gMouF1GpvEqYmeSfWrgTp9DvFlDCzOO
         aknw==
X-Forwarded-Encrypted: i=1; AL+hErHgOW5cZ5w2876jLDkBcaY2EPOGE/gtEGnDCQZS92dba4Bq6cmi8kh6NviCw3QUuX74MLpCdJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BpKKa98xwMJKpanCFClzfJABjRb9IKl42dC+viyDXSCtGZOTM
	e8RQak5/eaErgYy8xhB4x8XcVMVDehyWaFk17uPqbU5PAT0Nnr28tOfE
X-Gm-Gg: AYBFou34hZs6OfjT0xmfTOYSJlGlNjIF0cZ2xfwxUED+SoeQif8KyW8C727wZka1AAB
	n5OdA5U+66vR6+ABhpMdmHcRap2ScBj02OC3tUMxfzufYMKJhWKlIcMyeeiufrwW9EUTP8httow
	AIOdeFRH+lPs1yAJot8+/D15kt41tEcXKJPO71JaPCch5WRHU1Cp5GAPamR+w/qpLzxUp+9ZNp7
	lpR2e2O2F5wPP7IV7rOlv9IKq2QOxcBoXyphVPtIS7cLgjixVZTwp6qx2h5dlaT3+i8rQgRWne1
	4j8NERtcSoh2MQdOk8J/OfR5enmtKYQQlLO53pb+edbjuk5PSD0lUfgGE3shHA8deNq4sc2r4up
	AVEzzlMfJ0D6XYOqO6bhnfrkYyXnDtLYEPJmNAxqMS66R03CQVLbLozrUJHwjIQ+51gOtWlfSSm
	77evDohh22dKce5yFJ5WPEGdsuMBfccGDRIzlT7L85JvrI3PEpqboardSHGDZZmsuWgH+6fwwVM
	zUK+LTl+II/BxRBZx7F064BlmDNPjBSTMuqnqdqseRiSLTtwrsJ/ttgwjFQPa6isvrk9CnPb2ZQ
	DvaCYKLjaw1PQVScie5izFkhhG4KW9bU4PvRuj2sJi0saOnu6woJpoS0AlMZzUK+KtAOZ3xKdi2
	s8hsSVVLzAJSiWjOjOfB7tw/gQ28DPDYvUcYITlJ2B1tK/q20OeV5kshJo+Ekx42whY7osT0H4p
	k4H6PZLW3soxH0tm1fIYPIwjYfjJPjlBz/cnLDY5MyqehS6e/ju+w=
X-Received: by 2002:a05:6808:2211:b0:576:4595:982e with SMTP id 5614622812f47-57740e45155mr1255822b6e.34.1794955739668;
        Tue, 17 Nov 2026 14:48:59 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:48:59 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v9 0/6] dmaengine: dw: serialize completion and termination
Date: Tue, 17 Nov 2026 15:48:35 -0700
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43SwU7EIBAG4FcxnEVhCpR68j2MBwrDLsa2pqzVd
 bPv7nT3IOkeMOEyZObLP4QTyzgnzOzp7sRmXFJO00hFd3/H/N6NO+QpUM1AgJECJM+f/ZAOPHz
 xMDiej6Pfz9OYfpAvkqPWIqo2BhkcI+Jjxpi+L/zL67Wm+Tf0h9VcO3qXkfezI2a9IhPHXRrx8
 TpHHfuUD9N8vCRc5Cr9MwwdyY2LVnsIJprueTe49P7gp4GtYRYoMahgwAXXoBR2Knhn/RZrSqy
 pYA1h3kAfhbJRe9xiqsS6CqYIi+iUakMXweotpv8w0iqYJiw0INpW29jHmzczJVZb0xAGiMI3y
 gKosMXaApO6grWE2UCpmqA6vMVsiZkKZglTztK/UNEH6UrsfD7/AoCckegXAwAA
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
 5 files changed, 225 insertions(+), 313 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git fixes
change-id: 20261021-submit-dw-dma-synchronize-v1-e550f47fd1da

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

