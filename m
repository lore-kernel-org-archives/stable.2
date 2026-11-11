Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366918;
	b=rKoYkbz23mj40FApNcli1sBG+aiV0hHchNfsxuiYasezR4O7ztmpjFiwpf5DbsJIYy2n
	 2bBQem8ErVv6py7VUTlpRwFxbZI3Zz3WcmeYFQyjrRiEhjhuVJY2Aa40mVjoCMaY/mpkb
	 zYl2bM9QxC2h6ALeGCh/Aq41VzCJXGhrVygzBIhuaqTXbLne13Jiuqje/H5FePq2UEaYJ
	 mIVK14i+qrnvUIioZDV8AYQ8gXA0YlI+LWtZ8sRpBfor3VG/FLqynESuQ6Z2a1VeJm951
	 V5LAc6vYOtiEzqGDY/ChqG1FK1HxlwPZ22gEH3JvEgf1Dx900LmwfTYOT0niKU2hzuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=XkFwzz+nsZQuIbU/MoU+CL6VdYaimSfsq/YYqrN+wq8=;
	b=Gx/CU3z9HNJeGfATk1EVV1gXAkkMLooNQ9wQbEtp/8xojR1plKzDJKcWbsMe9oNgiz5l
	 nJonTDA2SyRXnBxNPK7J/c5OhSm6V9Xc/xG410HZQLRXF+X4I6Tmpyh1v1u9cRHxcIHUF
	 iwEcWr6gaSFn7iT+wwCZIJXwX7mLOa6/0l99EWPNMWAkLkO2yYdi77Q9HnMD8cF79BZCX
	 AXw+Rf3xIz34qG7ZT2jD/QdjyzweUMONXfREnb0kCwYxWlWGLvTpqo4u8J/S5b/jlSiVa
	 /R1ET0mRdhLQsdatgbVvxFPNLZL8q1on2AyldOnEGah63QKBkBc/KgcvqfE4C/j+bYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EcEGLZYW;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA35606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA35606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EcEGLZYW
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-85ac281604dso1577296a34.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366917; x=1794971717; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XkFwzz+nsZQuIbU/MoU+CL6VdYaimSfsq/YYqrN+wq8=;
        b=EcEGLZYWauf705j2dXemnFq9TPU/u+piYGtJwaMA3dzdnJwpvYiX77mxUKHCry2ip4
         YgGQmAiv8bZ0dP/SiCXDJYqw7eLMZ8dKHx2E8/eFM8s5EqDceStRMAfp9F9PITBksXXU
         stVUyMJ6gvH5z2Ta+kDzRZmJJytE7BtnleejthG3ljI2yaI6fl5XzPPdS+ZA59yXGMLp
         sIJ4Q9f35mxrXxNsPvbtoskibvM5+Jh9EHT8sEdskWilyQLmDoaI43jDIWDVO5qvP1gP
         XyJ6pCFrr0pVeSkOgWjBSHNHT6v66ZHz4S+yeN+1ul0HAkPm8qcGjLhiyfTsjUL4k8GC
         TeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366917; x=1794971717;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XkFwzz+nsZQuIbU/MoU+CL6VdYaimSfsq/YYqrN+wq8=;
        b=DHT8xdb3Q93s8UnbBbFgUyk5AD6hDS6sIrBHHrTQtbbnSCKDbjhxaFRZoRkITf5til
         TfxWSxGLkrhyu5Z9EoLrFgLMzu968HiwZhMYBoeUMW4/C1GfMr1fme9WdNCK9yt1CfHv
         qiBCYNagtfC9zwYUbK4RjVv1S4dMfoSFRWIDG/qjeyK1Zr9xOjD0exRGiO6Y/iUJ+9+M
         T50B+Ny4yFsMa/dfv6dKEMvx0qZNbVU4L+NWtWfYjNzpJNpFTHYmNH9fIeyGBwnT+DpJ
         RSO6BiwR4BJiXvI32wHrc/miLcNbfxLZMh+mC/4vl6PoJ7BtgVSTIsMeAs2+6mVhgps9
         oIhQ==
X-Forwarded-Encrypted: i=1; AL+hErGMJnSwo+9tH5EhhhdhznPbaiHi9qIKS1rMBFddcSbPMa8qRmdnP1ZhDR4e6H0t0RdPHCZx+c4=@vger.kernel.org
X-Gm-Message-State: APuU4Z//R20HHyExgdFV+Hubc26E7LvtLc2WbbwbqbNiEWEoD8erMUe1
	I05DzvWC1Gavl9zywHlfbFTiCxsQnQehWTpZ8dzcevWm8OxyE7f2vVoC/60WbfHL
X-Gm-Gg: AYBFou3vJHSCo+GWdfj16T4BieWbimiVvS8hxN2QD42kj5r2AVbYGJWpVHn+Gko90Vt
	g3Fl8Lenk3UvI+owoLWrKcsiXuS7hYD9KLOjhtzowmqhvIkdUYugLG5LcKso8F/qNw0kZNCzHd2
	yj39d+fjD0byAASR/RCi3O7Xt/gx/Xzc5qR0YN6SCpReRkceQ58FyTsNo5IjeRQuCL5dw06kPjk
	chi0Y2a/rgsRdCQKKpLjCyZhmFqquyX1YPAhL69dfHbs7X1RItAsuWcna7IFgtlgqKnIqeH9Y3m
	IAWDXFAcyUF7QR9nROm4gHbGKV3+7QY8Q9lh+5NmCPeR6aZH23dREMQkV4UwIWOfiK5ZtCfggDg
	StkohVztrt8+HW/sZjpCkonT+qCtvG7eZKR71MFIS8YfHfSwQeoTTr4cUp2wup3Bz7TALali+hd
	RPk3S++RxYy8s5dT2x7b7BVpW4urq1NsIZjo8JT3kFvNptdeA62PQLvAQKhb3bvLpyKg5msiTGB
	z4fySms3AN8aDACp4NTLFeID8ovFj6Z/x5BhoxbgFqKtWRxsetr7/Ed/BS1kF2ZteknLXdzxfZF
	4Jt/OXqUXESqrOAvrcwwf89v+xPIrRSPdoASZNoWuXl/WDr/1auAj1RlKW9zRYujxHkdmRIp+Uz
	zXhG+fFFO7PnqfnNAjD98mrKoZfEg4/9/K6DpUPoVLzskFgB1FZ09iURDncHaAsq18f6Ps6t/iG
	Lqsu4x6ZHfcBQeBS5PfHVOZ4JGIx3JbdgWziheXrBdhcv5XJin/C0=
X-Received: by 2002:a05:6808:3a0c:b0:564:5fe0:dd60 with SMTP id 5614622812f47-56b92843216mr1025863b6e.9.1794366916979;
        Tue, 10 Nov 2026 19:15:16 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504fdb5sm3999345b6e.3.2026.11.10.19.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:15:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v3 0/4] dmaengine: dw-axi-dmac: fix termination and pause
 acknowledgment
Date: Tue, 10 Nov 2026 20:15:11 -0700
Message-Id: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwQ6CMAwG4FchO1tlQIB58j2Mh7EVqJFBNkSN4
 d3t9OJNk13+pf36P0VATxjEPnkKjwsFGh2HfJMI02vXIZDlLLI0K6VMawjXZqAZ7A30ncAOGsI
 8TjDpa0BYJBiVtxKrspKlEqxMHlu6vy8cT5/MxBnNHNk40WjebLx2po9fTKLryOHus8cTPfEN/
 3iXXGSU/u/DLwVT1GikQoVYHLpB02VrxkHEPkv27anfXsZeWWjLpm0rlX9767q+AEx2aNxSAQA
 A
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
James Hilliard (4):
      dmaengine: dw-axi-dmac: poll the correct enable bit during termination
      dmaengine: dw-axi-dmac: retain descriptors when termination times out
      dmaengine: dw-axi-dmac: use atomic polling for suspend acknowledgment
      dmaengine: dw-axi-dmac: preserve pending pause requests

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 120 ++++++++++++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |   9 +-
 2 files changed, 102 insertions(+), 27 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

