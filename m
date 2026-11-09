Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200561;
	b=B5xcFOOmvmfiM6npbSaTBSZWtn6BlAqieeHZNCa8H5C+40Ng65vYw6cC3ulRhvFGCV9/
	 AivUz4VpkwY/lhsICn2PZ6QS8Yp9FjtDiv2wRZz6nHePiJSpidXpPyhvUZYYMFotEXguU
	 WCQdQn8RGWq/sRqqztuYZfod2d/VLNQxxhJ9q5A5T9HbWf0D+c891AsS5D7IG1kvyg4NG
	 LsauouuFFMuCVCqoXHvnKCU8xyeVfbYrwO3YIJUAHQJTfsakVM5J+4wPxFO0Kt35hjJdT
	 mybLNGLVb7Dy1ztHPDfzLr+hh09teeq4V4CaUB3Lds7jCVvp8fhdaYOAr3pQv+Q3uow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=yodLZKxnYV5I2eY1U3dtFzN1Z8iibbm+KfUX4glKyUM=;
	b=kewwGLLzmnVoqb4W6InevwNK2Qvn7w5UoUC61oTWQRDsXiKFsHzDCuIAgKNYzlx0SFAd
	 dyQFUfD20pyAJNbjjjTeArZVgIh6uju/jwisyZYWjiC6A2pDi3kZeO4cis6bOAW55QgkY
	 mpb82wN8L5+HhrFDTV8ny9S7XHhi8uD3YwVFFFcFwmqcklZUIqUctGH/N7BkSC1VLzzAc
	 NBP2RrsjLKKcj3cew81a3uAcGlE/ZKgks2w10+3VY4TxfReeeUqo4l++Vgb1EOdyE++V7
	 8lXF3+YPdNdPZ0oOSfrKxwW6SJJ2OGIM03Ae6ojsY1Ni5cszne4i/ySrJ2jZ5rYlVLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NeFl0mo+;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0333606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 05:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0333606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NeFl0mo+
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-53ec9237600so221129b6e.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 21:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794200559; x=1794805359; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yodLZKxnYV5I2eY1U3dtFzN1Z8iibbm+KfUX4glKyUM=;
        b=NeFl0mo+kN5LveCEELqE8KYxpHl+jkjeyMtjDNMZKSqtMpdKxX3L0Blep+eF2G3OhO
         DdyaeUGbL1F16FxE9mjuvQlOO5wqBLl9UGKSja35X7oYAynGfWg1greYRpthzM0WidBT
         u3Q8R1iY4H7YKRTd//TbsHZW7VBGLzRYJG1DeksEzcRzEYeSDejBFFRbVoNmDWq3MY28
         piGNKzHc6Q4O//fv+5iQueeC48bpdjGT8f+hLvf4WRKS3CrgYXDN4UK5kPzxIWm8+I0D
         MOqKjeaoMckZcQeJ3l7Ltxr3W9csyk5YlhXjPwAG7HIrqns6jnEqDRFQNT3DOxyByZUw
         a0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794200559; x=1794805359;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yodLZKxnYV5I2eY1U3dtFzN1Z8iibbm+KfUX4glKyUM=;
        b=c1ebiGFlyYM5JfSZeay/iXA4LDIrNcvEtywKzRkOBN9+03QAeatpuV4IGm9B+vqmCe
         rsTxIdBjOz+ObieziVw4GQx72sBw7romLxMK7XLg75h7ijR3eVdm7gVgrDVMhNnX4Ozy
         b2cRzHqiVRkd7NjEHVid0SPuFZJ0rNs53C1RIs/rAFjJobE3oUM005cFAg0UrWRp93FM
         3AmggruMuvUYwEFTtpMP+feBe4ac0bJqNVmxb9v/FUkwoMHFdktprg+e2vZ7LblIvWSP
         CvbY/qsEI5sv8U7Wlc1LFYnmN4L8YBkqiVs/wkzLI2cQ2A9tNKzwciBhOYdED3oL3TjN
         99LA==
X-Forwarded-Encrypted: i=1; AL+hErEFH7nonJSu1BbjirwaDWlmSu/6SIDZ3OvjRIxg59+WL1reGeD9BEQpOelOHlSg8YqWrkFtTuo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uf7RHF79NOq8qj0Y3SyuhVwu4yP4YXvBwk22i8C0spPQiojNE
	+GyqWS4nbIjv9fVCTm9t6K5CURfoRZaSHd7u/TGOiCkp7hlBdXPqO0qB
X-Gm-Gg: AYBFou0Hw3fG/+Bj7d3XXGgVd3/I4SXaNPneoJVv0bV2ZDFdnQy9yrIyaTOqXcsBfH/
	bwQxiPMb+u2zq+WM40fbLi2V71rn6RLybnFnVOlnKFy9nQ5QmlJuk2nrgbNQiXRLL1g0aEEaaG/
	Vx1P0UMWBPIGv1M+uPfRncZ45tRSLzdXLRtIAsQyJeXrZC+Sf3oox2bAN79n2fwdF9iyvrBFZSS
	LHg/j48Fq7fjNbt9PU86Q+S2p/yijVtmQDzwjmsTB4cQgq34RyxkiHCDVzM2/j0cNszeliBgqFZ
	u1vjj3ApE88Es7Dv1hu7Pzs+zVw9eyGHorPx/QlVhxK4186fXfcptZs6th8IX4z1Zp547ruKTR4
	8KqzCbw3j2EWJbIHrtvWSIXF5WxuZhmC/6pmtG5NsYDdjchKUw1V6EFJcl3yO4IVT8oB/jLb1Ty
	taxKwcdZUZiZzHAimAdqG9cSrsUAJRHOO1st5l55Ej4AbMNhIzFyQnu/wrtHFqMZAEnPsownOM9
	yiD0JDrbATta1OMRYAatzA1JyA1ZZUa/ij+Oo35BUErsUmnBcuBp8tlpDiTECJXSUQ2KZ8oaDVh
	UJfrfoavrNFvoptPtrF9gj+9Hz4Gj4RRHlzenNS4vvQc0wj29yFShFSDXY2ZLT/rkz/+qhcifZK
	Xdv3c02mBATLLOP/xNNn3Wd9/OluboFQdbF09QZlyK7B4ZkHYSqsSe/lb7ZSy5Aqdc4F/NetrH7
	T3RKUBWQtp94RSIwlYq6liZAooHKOHUMH/zQRXzoMFzzWYV0BC1XU0/dFjlpyQv0ryF6sSS6tVo
	w==
X-Received: by 2002:a05:6808:1686:b0:53a:88c6:96c8 with SMTP id 5614622812f47-568144504a9mr1814998b6e.55.1794200559552;
        Sun, 08 Nov 2026 21:02:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813ac6352sm3570841b6e.1.2026.11.08.21.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:02:38 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/3] dmaengine: dw-axi-dmac: fix termination and pause
 acknowledgment
Date: Sun, 08 Nov 2026 22:02:35 -0700
Message-Id: <20261108-submit-dw-axi-dma-stop-pause-v1-v1-0-c48ec19e9ee4@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN2wqDMBBEf0Xy3KXGQqz9leJDLqtuwRiy0Qriv
 zepj2eYOXMIxkjI4lUdIuJGTIvPIG+VsJP2IwK5zKKpGyVl/QRezUwJ3Bf0TuBmDZyWAEGvjLB
 JsN1jkNiqVqpOZEuIOND+f3j3F2fFB20q2tIwOi9N1N5OJcpK9CN5vF+78/wBHmDM+aUAAAA=
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
transfer resources when the channel does not stop. Keep suspension status
available until the polling pause path observes it, including when an
acknowledgment arrives after the polling timeout or another channel
interrupts concurrently.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (3):
      dmaengine: dw-axi-dmac: poll the correct enable bit during termination
      dmaengine: dw-axi-dmac: retain descriptors when termination times out
      dmaengine: dw-axi-dmac: preserve suspension status until pause observes it

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 34 ++++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-submit-dw-axi-dma-stop-pause-v1-c93f1e767169

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

