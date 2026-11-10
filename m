Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279970;
	b=Ld9H2s24dNXjV8V+YfFJsBuYJpOf8Sd5JPk4zEvB9/ur3V5rNcI8NBdkxPpjefDwumht
	 d24J6Hfgwq228JSSVjiKYIqmH/Paj8dYv4URxm2t8GWiqjJFFe/lRHxnQG89UKvayl0D/
	 24BAd52duAsrSCcOM1lWOwz7cvkK0UGdRVFtYARb/UX0dPcqFHjoJ2p+j5jI6gBFV65Rv
	 PoNu6rR3kTSbCSr1RnUNQlqu6hZ+NXXwsrHct7GKjVwH6K5uyPFo8dzr3Wcm7wOFuy9mJ
	 e3h7oTZCErDbDUSPtST4bKMZBoB6ZZAXdEGcp5QD7DcjO6wCBeg2pSFsVAd9DXwubaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=/SYARMV8I8wsqdjQWYUWZSLyGBS+FqhbkB8i/PouCPA=;
	b=s0CZaO3L6MPy36BcJrLZag/z9VWM9IQAMHrMLIEa8O0Wy7YUfdYEhdxdqzulks2uk29D
	 cSZMhhO8OD6ck2+mjvqtZB2zx1x8dzd7yeHn2Lp6fQTvP/VrQNoky1Ee0+iUCRzWW4elu
	 nwaMkjpU7GPQaB5e5Y3uznKTvj0L+nCQutLDtK7dKxzG/08zUX+jod8BjqW0YzohojwrG
	 HKzwMCmWz2MM6L5qVR4RJxOWjVCUIHOJFU660FIWSA4Mq6jKaBLoKDOR2CVHcdrJlWQRV
	 Sp3s0AaVSBMOt/ij7bMqmHa955Ek/0zeRbKMhRbnQEiyHZRz7nQoEed5x5I8R33PHCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X2hZugRe;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257A6606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 257A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X2hZugRe
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so1018374fac.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 19:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794279969; x=1794884769; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/SYARMV8I8wsqdjQWYUWZSLyGBS+FqhbkB8i/PouCPA=;
        b=X2hZugRewfOJgt4gy5Y4JYZOmHxUH8N047o0reWVoO/+9T3InzQM1JpUL3dZ8nWIOk
         OjEhESJNnXehBIqTvZvJoxqh3flahsh1fuhpD9/XnH4i7gf0sn7+S2F+BjlozaoZPNsB
         xAMWWePGkg3YIxa8s8Vxd6IsUXIrH7bWaHR6iMQ7t8qcSy26b4tsMj67iDBReK4xeB76
         ZvVs2xWNZq28VkAqaIWUBvYL5d7kK7n4l+FC7LpwuA3bc2c/TcArBw0+wkMIHCipf90P
         FNsjek7M34NRS11/J2Ccx8cV3SARTsbSW28y7CbjzHYwxU+4kWB1Iy4NypY2YnoukTch
         4mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279969; x=1794884769;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/SYARMV8I8wsqdjQWYUWZSLyGBS+FqhbkB8i/PouCPA=;
        b=N0v42qHu4we51lZxCSmhs3XKHIz923lFi59VbvjgfgO5hyVCzoGmQzIF9FuXP0PaIU
         aYxh0nIf0LE2opZSMw1HTAW3DovC6+cS03nnLO0zUrLR9RmT2ujKFNOIXpHvuEMUXUq1
         Q2t9HE9O0wNP/oaYyzA6cs1GB7G8iPbIIrjripY+dy66Kzak3OKI77f9baA8wwuXsOMy
         71BxyI7EgxSEHj11nFO47NEoFVNSu83xaZrefHPBB5IAVU4dyoC0kEfOD+qI7d1I6mGQ
         6RifC6vUGH4hv/mxxlF9Ryyt/rsda0fH+gZgFVsovvtvJZpPbP2x2GCN0qOg2IK+34gi
         Rprw==
X-Forwarded-Encrypted: i=1; AL+hErFCjuBwFvSSquG//Mczk9Umf4fnDDBAavKa13eaPCJJxEi8oMDzx2RYyZsEr3+FuE8Xzrk40Mw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BpqPDDttn41sShAdvR4rGLG3+8on+t6G3AXlsxHIzj/xBjAOc
	V8FAzF7TSD7tgcygBzY38YYrwixGX/FxwmdOo9R5osiWHnoKmdIc/vyH
X-Gm-Gg: AYBFou1UlqAkgzFfvTpV4bfOMALobGdsq6DhUipoYsT6ffmSeUkGUlAJYc0acmlazwa
	2hmpjobynS46a8yJ3V9FfwhsU7TecVUx17ZQICuB9lETUMd4IqOggIZ6wLcKxAZNE+2EQPxJYBZ
	Det75rkjKsOg1+L3G/BdwZnT4iiBnxY4Pk6LAuPBUcuGkl5bQSYLMx6nPltjj7ZBpt3zX4jgYN2
	whEDE2Ek9lWJr1TUdw4pDHkwizLgQ0nn8HRVaMIwCMmXX/etUizLLwJhOdPzvt9DwNb5tAEviQ6
	9hTXjuZr4Bjjit4rqKmsoRxfgJqFK4+dZfJTo43Ke/xBJMICwKJjQbga/puu0i6Y5Lpt1S1IUhF
	MLfBCq7g942qjbI3eF7xLGajmIkZVttt/0zhuKcH0nUsDcCeAHSd8kJNbGR3BlX7+zAY1NRJLxq
	FZxEHqCQt9Lu34uJaa3LVsBrzL3FT1PEINvj3cyPYvX4Q3LNq092f8/vVdid41zflM1YChSMTe2
	bD5e+l+dX+/JkbI6sGiNpgARKhXverq4tHnnu6YwrA5sniJdsQAXwMuGPtypgM+fLIqPbpRILrn
	aYOtLIGDu3NALjhDM76pPQ+tv5e503mcr/cJ79JXZlErN5hCxycX1ZOFQZzfExjm2WCOUAIqlzB
	8Ltc5iYu4Lrg+cR4QYAtCja7jKA23l0G5neD1BlcMGU+zPl6khMPt1FbHK1STSobCvNVUSwP1PM
	wTH3TLr9CWML1p1bxGDfu4S60elCwSpP43HMnN3YgAvvzcfOIEK1qP
X-Received: by 2002:a05:6871:5826:b0:48f:e107:317e with SMTP id 586e51a60fabf-4ae2271656cmr758240fac.49.1794279969033;
        Mon, 09 Nov 2026 19:06:09 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fcdc93sm683389fac.10.2026.11.09.19.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:06:08 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/3] dmaengine: dw-axi-dmac: fix termination and pause
 acknowledgment
Date: Mon, 09 Nov 2026 20:05:59 -0700
Message-Id: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OwQ6CMBBEf8X07CpFAtST/2E4lLLAGimkBcQQ/
 t0t/IDJXmYz82ZW4dERenE/rcLhTJ56yyI+n4RptW0QqGIt4ihOpYxy8FPZ0QjVB/RCUHUa/Ng
 PMOjJI8wSjLrVErM0k6kSTBkc1rTsDc/i0Ix4oRkDNjhKzcnSaWva8GIk2oYsXo8cO1riDvfdR
 84ykP7fwxeBSXI0UqFCTB5Np+l9MX0nim3bfkDiaRwCAQAA
X-Change-ID: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

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
James Hilliard (3):
      dmaengine: dw-axi-dmac: poll the correct enable bit during termination
      dmaengine: dw-axi-dmac: retain descriptors when termination times out
      dmaengine: dw-axi-dmac: preserve pending pause requests

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 118 ++++++++++++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |   2 +
 2 files changed, 96 insertions(+), 24 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

