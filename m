Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471784;
	b=L4Jb4Kx7uEc/mqxInladUJI+vhoxpnQxW4gS/9xnk1R5I0Cj7oaOIziQn6N0IdGVPcqd
	 fgnLGr4dIPTmmYcgRr+q0eL/2sHKuPF8oFKhgFt5EI9em9Wd7SnWNtIXqPwLfqj3Di01o
	 ALTfZNGxBdhupzr17nVUHfPmyydwBNjHOdavycsqVBIZrE2gUtOGSS/vba9ZwsLkSA1dq
	 flgF+X4qnjVlU0yDWEh8tpTSPGjySGtbolTFyY/WU6YKvMVdBpEyboL+4R8jUVS5Nus8u
	 /Hoc0wxAMwnUPFEMOVh+BNbXVWAtGEd6w8FhEPwm1oO4dAMVYnYEMKOmAyDFjzolCeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=IMVMSY1N9cWE50jOBa7XB5ola70F+EY/IlZ2ZpXdsZU=;
	b=0WLa2/r1PErwhzMmO3owE0QPVN60C7TG+Jr6wlMwvXTk17pUVdA6Q+xmgw8AltznG2PZ
	 cEyBD5Ojzd9NP1GP58bqp2xLCvxKHsrmQemt9J1qCm/ws5M/nZuI6QgvfdqDTXx4VEC+M
	 qDkFKaUYOOlnJNH1XABP2yhiJkZxeAgPQDAFOoYSYPXHN8eGARAOi+oqqhSrQWHB8/oE7
	 FutwYif0TSikBwoFVtwlNNyx4sy/AhJZUG2ONSpNdpAFSx+YAJ41mgV8DgPbqBtNTUNuW
	 aXHlxjvETHp6uapsndSwbkPrThrHmWAVS4+yX1BD+CJeKHw/++yD7THTGS/kc98PWow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uqMmGXbQ;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F10606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F10606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uqMmGXbQ
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-843cf077f10so5030908a34.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471782; x=1795076582; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IMVMSY1N9cWE50jOBa7XB5ola70F+EY/IlZ2ZpXdsZU=;
        b=uqMmGXbQnJ1MynnAHssFD7u504cZ7mF5/foFaj+J4vVrepxKy8NSjmFf7hWJdu9e+N
         JNh3HJ73kycnQqxXl7OKfBITf9hPqFRo0214onyeG4sZdpIccZ1BcoJuUWwM/3hyLLSt
         sTbCxMnMs5YGANaKsHVdZyZX9Tq0uQybi/EOesprykpNXvTfBfSnWMuAVlFVuMJROqBE
         Fqi3CzLKu8xaSVz4fnMcGC2etk+GX9yfGkaz2/hsFCqwWt8FrXt0TFTlxPqHh/bnaVO4
         vyHBRGr+kRpnDkefiFOM72+fLicMUUYFt8z+WrNuwrdUYzfONU0H22gFFwp4Ru2CBmWR
         038Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471782; x=1795076582;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IMVMSY1N9cWE50jOBa7XB5ola70F+EY/IlZ2ZpXdsZU=;
        b=HWLdW708rL2iWUmJJbQfiIYFE4aez/novHNPC2ykntXhuKuMP7nnItDO+NSOri5u6/
         K3T09Ji1bPNk7boKhe1op60Lla6jI0655iQC4UZ0cY+v5bh7hD2UHweeDz7SMQoQ3MY4
         PdOFeNZ2Hxe3QQYz0Fg/UHu6OLZNPU8m/wF6ZVGZOHhDibVN9W/ysqez9tyIz8Zyr3fD
         lbKdzJj9erqNoHxvS7Sec+cKgaPI8LyV+UB9scsDXFFPcY254/lPwOcC/CFKhwQs/d1F
         3vo8VaYS/6yH1QkCm8g22f/2Gi8d6YtYf6MFoWhmJQi8696kJe14zGfWLBhyfVPMHF8j
         P1VQ==
X-Forwarded-Encrypted: i=1; AL+hErEwoQCKRGcmFpxIsVamp8bEh+LIlZviJKpUSsWqo4eEHT8JEJavhBLzHh8c29O9GJPbjHgqx4U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BzYfr60QDbuh3uIh/0aWhGCP7It9OJItW0iJfE9qOIVcyPcT/
	BaXLjU4yEBm+TH3eEOq0BaTDCkWg2uBLq740SyzuPzhodlz+1nUbu5QM
X-Gm-Gg: AYBFou0sjiPP0vwg9lDklFymc7ec0IDRQppEY6uhCw3cHnAqu1PPNUxn7jSvE39m+Gv
	NBndRDVYRe88uYMqnPhzRYMG/UlTUsk228JUW6BXPdjwqWgKP3BdkHowt+dY4Ae7t476Vykj43j
	XE8WmfVkwCbPryMBXZUbJ+Ta4HWErMQkJllRJRSA4UzoTGgMUMTiiclW5gXUz+QkID6rHoLDlNz
	DmUZ3h9B1h++NbVUEzRSc9RvE2xbsuUdMXIPlDpPet8yW77oVs4G5CICq6eVnq5QwVdZMhCUxfL
	qJkOKaXNw+HEdB/rnLXml17XcnsYvEQtpmnztKcBHeZ08EHcE/BjsuQf6g70++DHk1uJfKpLahu
	ePXxWqz0Ah/MzUPl9WWrX84yl70NpyxnXjCZyKcqKOlii7r+6Q8RsO5LCLLokhqcnUSInuI2Q/Q
	6amyCS1BIKbjRlm8rSPy7b6sGdx4B+oXwf+kOjZeSlGWLN8XraVfC4PfaphlFSjNZo8YyTcjFCq
	kzLIcJ1UwxI5PFQSZPMnhGyuYIFJWo1kzRMalOa++bxlcT3lyfqjEKf+sNkF82SU9xHNxmRlmB5
	od4Vf9PMgeHaf8jj27DWHTo3D043863Hs2ftkQeyGJTYpskK873OWGaM1BpFT1Ow1tX3LMcRUar
	dbjx9aC8Xl5v3XRioUKnlpcM/eegsIxX8vvIsSyvN37vPCkH7RIoE1TSQ4cZp7QcigRJvLOuI9x
	NZu6xEFOqEJ/XdLearRh9sFvZhzsNaFsk6ytMy1xXg3WPKSgE7IhY=
X-Received: by 2002:a05:6808:1645:b0:4e8:721f:2824 with SMTP id 5614622812f47-56b98031f11mr4803302b6e.60.1794471782468;
        Thu, 12 Nov 2026 00:23:02 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905d3bab2sm7411157b6e.12.2026.11.12.00.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:23:02 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v4 0/5] dmaengine: dw-axi-dmac: fix termination and pause
 acknowledgment
Date: Thu, 12 Nov 2026 01:22:49 -0700
Message-Id: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTW6DMBAF4KtEXndajKnBWfUeVRb+GYOrYpBNS
 KqIu3ecbFA3qeTNs2a+eTeWMQXM7Hi4sYRryGGKFJqXA7ODjj1CcJRZXdWS86qDfDZjWMBdQF8
 DuFFDXqYZZn3OCCsHq4Tn2MqWS8VImRP6cL1f+Dw9MhFfaJfClgmjadMkHe1QvojE2IeIb489m
 hgC3Ug/95IrL9L/+9CrwDYdWq5QITYf/ajD96udRlb6rPXeU8+9mjzZaEem860Sfz2x83j13BP
 kiXfvvNGdkdztvW3bfgHG2N2aogEAAA==
X-Change-ID: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

Keep cyclic mode in each descriptor so failed preparation and queued
work cannot change the completion handling of another transfer.

Use the layout-aware channel enable check during termination and retain
transfer resources when the channel does not stop. Preserve suspension
status for the pause and resume paths, including acknowledgments that
arrive after a polling timeout or during another channel's interrupt.

Keep a pending pause across cyclic segment completion and resume the
segment only after the client releases the pause. Track the active
descriptor until completion so queued work cannot reissue it while its
interrupt is pending.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- Add a preparatory fix for cyclic mode leaking between transfers,
  following Sashiko's review. Store the mode in each descriptor so
  failed preparation, error recovery and queued work cannot change
  another transfer's completion handling.
- Link to v3: https://patch.msgid.link/20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com

Changes in v3:
- Wrap the atomic polling calls by argument group and correct their
  continuation indentation, following Andy's review.
- Move the termination return-value check simplification into the
  channel-enable polling patch.
- Separate the pause-loop conversion to atomic polling from the
  pending-request and cyclic-restart changes.
- Annotate the suspend-wait helper with its channel-lock requirement.
- Pack the lock-protected flags into existing padding while keeping
  cyclic separately writable, following Andy's review.
- Link to v2: https://patch.msgid.link/20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com

Changes in v2:
- Use readx_poll_timeout_atomic() for the single-argument status helpers
  and express the termination polling interval and timeout in milliseconds,
  following Andy's review.
- Track pending suspend requests separately from confirmed suspension so
  resume can handle acknowledgments received after a pause timeout.
- Use the atomic polling helper, including its final status check, and
  report -EAGAIN if resume cannot yet cancel a pending suspend request.
- Defer cyclic restart while paused and track the active descriptor until
  completion, preventing resume or issue_pending from reissuing it.
- Reset pause state on successful termination and channel allocation;
  clear stale status when starting a new descriptor.
- Link to v1: https://patch.msgid.link/20261108-submit-dw-axi-dma-stop-pause-v1-v1-0-c48ec19e9ee4@gmail.com

To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Sergey Khimich <serghox@gmail.com>
To: Sia Jee Heng <jee.heng.sia@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
James Hilliard (5):
      dmaengine: dw-axi-dmac: keep cyclic mode in the descriptor
      dmaengine: dw-axi-dmac: poll the correct enable bit during termination
      dmaengine: dw-axi-dmac: retain descriptors when termination times out
      dmaengine: dw-axi-dmac: use atomic polling for suspend acknowledgment
      dmaengine: dw-axi-dmac: preserve pending pause requests

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 149 ++++++++++++++++++-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |   9 +-
 2 files changed, 115 insertions(+), 43 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

