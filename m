Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562601;
	b=DCnsyal/CmWn2zqYbWb31OynIzCNUSiIzRHohaMONUco03HDoRtIYj73hvGnbMbroJcs
	 hyYZLO4h532rm4ei7SX5YtL9LRE3l6VJ7B2FrYnt9TZN5DKMDTPKxcdEDn0k88Mr9B/+2
	 F35MJjm0YpWN/mG4eCzgYvlyhygeM7IWKlqX0MMYMMPyrH+cuUjJO835oCo+sWIXroMCW
	 dtUig/AC/xIeo7WpPEpXXmFEq+NfrQOpbJ6D6vpWqGJRv6YJ/UDF4I7ExGlhZ23dNuLZY
	 R1k80F6atS9MVedkBBoO1wZWAPNhV1advH4OFe+rTmgp93LpKzay43uWUlvy0cvTASw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=H3sP4UGbcpDrylakHUH6tdQBwksSME2bDR3mbB/dTNE=;
	b=G02W+1Bl0bH4qhg03hIQdCLiaiQ0DAXX7Z93+XBTPsVB+0aLSmKJbExldu1do7olKo3O
	 NVti/TD/aN2NqVYo/m/CcIulM3XakXTrfTsIUHYCd+BC/Ss0OMxUEVa/C7ht5xhqaS9J8
	 0jbfUhuRSH3bpO33iaDdFJsgNNcznjDJeSmHbEScBAC3whBo2js8BBs5a8uPfXHxJaEuQ
	 PotbSS+uWrw1dxOcZg8vU0xB093Sxpjjv+RzIe6m1jUAgjpwxiLTfyXk8XoAoG0Qf9uyI
	 iGfmT+lU0py6ztyQxdJDO8/aEdTDhaP+l1Bd03wMwyOcL48R+ESu8jrrDh9+NUl0iaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aMeq6EFA;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A9606A33F
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F3A9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aMeq6EFA
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-843cf077f10so1718417a34.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562599; x=1795167399; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H3sP4UGbcpDrylakHUH6tdQBwksSME2bDR3mbB/dTNE=;
        b=aMeq6EFAXHo35T5yN+yPcc4Ifi5QMO7XBPc6pu4rSr5eC2shJYkyFFc6q017pDd5cY
         HQVzIfexF6S3gOfpVpf0TeQ7h5RwPwoxmeD/3Hw+kNi7A8XpYK4hTOVer8sDqwD+100T
         kNhGNbALJ3nHsPA3Mdn/SByVeReTuhe8kVv5AmNSiGhR8xxsXppT3r3Vg8O29yIQ1CID
         b1M5uryWn/EFxk3EMNERRrJh/jC2j7BKX7eh7VQpuxwtNiEJGlH1tpFkOMCy1q8SYcMb
         ISuGEUJe4W3YoCFtB17tE57F+skSDY5+SXu0XOXap60RC/fpkhvNTtYloySrKNsj2ylX
         S5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562599; x=1795167399;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H3sP4UGbcpDrylakHUH6tdQBwksSME2bDR3mbB/dTNE=;
        b=UM9nn2yMuUS7FNRrKqG817V31e3A7A8Jc9fmJOQpPykHSjdcj2PJSZ3kBoJrt9Hxf7
         6OKW8QpR7d1mTjzXbnjGswcLzkbIpY/X3FZR5JQmwpe62AL2bKRManjGpGmw+uhWvEdN
         fwaHMMw+kpbWglkQde8HLcKOHdoKv+xHoqoyyjxqxypoSD1vwE+CboRSF8FebVwjzpBe
         i3W6WbNZJ2JHv+/fPs3Xqb8Cd1C44ocn76kkkaP29pZFXmawCDXAMyT5kD3y/tTQDaPM
         VRiqbQQMNrAzrzFDqvww72h8L+1IftjFMLYgyryrgzmLi3cc15gFnTRVDT0TKWXSJ5Nk
         in1Q==
X-Forwarded-Encrypted: i=1; AL+hErH9JjQSKfIAiTh77rfPQNPWg+tnRKB7+IgeGOM7C6z48BDh02RkmQISqp6mKkQDqYVGPWcw9Z0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JsbxzgEvKRaOdYMakubzhnKxviof8HGbNpHoCJi3+naBcW7Ny
	ycLOfOFjdAevfRXsqehlj1o3uagTQg8n9t05SwVpwtZD2pF2KDgSPrL/s7mVzg==
X-Gm-Gg: AYBFou35kev+ZJaCj6dpkzZ93wBzlkBv8zADBwHmRxqxCUX3ej1f114LA8Xh+Uj01Ub
	gHFf5sTiYR4mZEuxTBm68VoN4iM+ZxzN7vC+SPI3uCOPy4aEO2tlkz8lwiNTNEy+dH0/T4kfVIi
	Nx77dRBXWRCqFZ45rOLS5EW6mbjJ8AY14MKdCxkIcLH9h9EAhv3Ey0B6WhA228smYAGbEp5JmdI
	3TN1Wux8aqRhtlV77mC6AIEARRI35mOYIAhpZGZ3TYABmMDFaCdYzPEb0an0Vtj9ZR9afxfGp+z
	eCnS/uREVE/pwxtGRAfxI6PtXMXmOuM7EbLFs0TA6MiQH/VJEYqLX9QfyBoDPuYlE+sumOw1GSc
	HtS781gjcMO/SlKC0PPbSgtG2vitlsXSciuuy5WAuiTHTg4z8z6zRIwDCrSu29m1S3cehiAK+2I
	xxWrHfj5su1MRp5tCEu32XAxFavtDeOir9Wmf/y/bK6FccGHhPC/KDLxQGqBejZcb8Qn7NKKDPa
	zvi41MVNBYqNWJpt8DLhpu3GHLrG69qqLXMiVUA0jOeVGXXsgEHbawT5TC2ow27GMUbgeJ6aglT
	3HC0bq98iZGYApqN+3XF1/g8yDNVLbNfGnYsmOtVn77JOV5Nq0fgDRt6BWVvaNRnaKVMAY73l7g
	5pnIPSYykoeDxoBwJdeIB/eqrRwXPCJq7/5CwG1Xaa4vKBje1fo3uph3MmnMka6YFoP9BJah4Fc
	qugmiOD6+RGe6zQinvwmQCPVhrCdRIs3TdjhHCDIvoYDD9Aay0upY/
X-Received: by 2002:a05:6808:1983:b0:4d6:90f3:74a1 with SMTP id 5614622812f47-56e645e19e3mr1879498b6e.44.1794562599227;
        Fri, 13 Nov 2026 01:36:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6fc42a8asm1627607b6e.3.2026.11.13.01.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:36:38 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v5 0/5] dmaengine: dw-axi-dmac: fix termination and pause
 acknowledgment
Date: Fri, 13 Nov 2026 02:36:33 -0700
Message-Id: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Oy26DMBAF0F+JvK5b/AjgrPofVRZ+jMFVMcgmJ
 FXEv3ecbFA2VPLmWjNn7p1kSAEyOR3uJMESchgjhuPbgdhexw5ocJgJr3jNWNXSfDFDmKm7Un0
 L1A2a5nmc6KQvGejCqFXCM2jqhtWKoDIl8OH2uPB1fmYkvsHOhS0TRuOmSTravnwhCbELET6ee
 zjRB7yRfh8lF1ak//fBV1ErW7BMgQKQn92gw8+7HQdS+ix866l9j6NXS+3QdL5R4tUTG49V+55
 ATxy980a3pmbu1ZNbj+97snhgLJeGS+HM1lvX9Q+okhJC8gEAAA==
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
Changes in v5:
- Use a positive enabled-channel condition in the suspend-status helper,
  following Andy's review.
- Initialize the resume result immediately before its first use.
- Separate the lock-protected channel bitfields from the preceding fields.
- Link to v4: https://patch.msgid.link/20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com

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
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  10 +-
 2 files changed, 116 insertions(+), 43 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

