Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6AC3C454F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104952; cv=pass; b=PbMeI5ndaZfysjOIUtiL2dZEOqYyTTAknxbQoLvWJWw4x3yb3dgZMoAiup+WTR98y4vhJ1QobT+lLJsklQFTfGDzplBefchXEj8ocdqnP8/KuOjmwI4nXIwzfovdN8IfmFSkVTGfx0e92nwqMWkevlInxgjwFefCJpZFMCaVC7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104952; c=relaxed/simple;
	bh=FrghvNfO6wG37HOsjGNu81UndxQM4a69x6R59D1YIa8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hmvldCpNPwLoMyOiGJu2mMbPZ3oE8zImeTtAetl5+zLQWxjlcoaFE8DCbtZlyHuQGpDdfewSLdLF6cvbwdRXR4wlHAV0rk/82yD4QxcBHVwOn0mCLCRCgBJqXuqFpGoUcD6r7Gq7GWIFux4WqavU2iutGxbRbv7FzMbrNRdyqi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loGAi4Lc; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loGAi4Lc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso1775825e9.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790104949; cv=none;
        d=google.com; s=arc-20260327;
        b=CpWbWEA22qwGH7L/Dz7JbOFZmlJy4S4rAGN3lynM7OL0yeZ6hRgmls8J1n/CBH+xxl
         PhEfPKO6lxzSOBtPf+eECR7rWK8Xa7UV7Zc+HtoOYzaLk0sxCG8w4DyVa8yo+v9+iyuZ
         DKXJBEChNIpFJc22CJpLD3rGpSjwT4Zf5S+SUn5TeKePGOrXl8xqbwoUa5Y9JQnoCY90
         fTSsoSg8HuqMuajsBgoG5dcZQlEDn6z/0Twv3q6SQrMrO/e8q3BAg8LC4PVaDbH2KBKN
         YLYmjPBJuxZQdEfRXJyzghbRCk+2W4+J2H5foBlG0R02bWfu6kn8DQqhkr9yS7Teo+BC
         4eAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PaneUziA5ZoH4HTRhCIK7Hhw0UG0gVQ61sVYvGw4p5A=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=KHpWF+u3u8Na7JHMumZOzYuN7v3f5ogBrBFiMmHRRJw8ZguBqJ/FGySYtdR5tjJgcn
         EgIEN+1SrSsG2zwGo/PTUBDvBKfxYGCCohti7S5RQXVPXcYtbu108KWE2rr6t/1K6NgE
         fhHOQZ1U0YUR1QcKWGpMfT6R1Xmbs3PHYrFNXrAnWA1CwlV6q67jBZ8O6mfW21V1cqWf
         LBVbUn7cZkS/iWt1pD0SccT+HjBH0BBcVeEkHJGLMrccTbFtDllFP9kj4vz4wcHEKIAF
         9h4sYdY9yy9Ana7eyr2gq9Hgo38BO5WkWoQcvA5VSDKIf20Q7LlsY1X1uflSRDcC6mE6
         xmMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790104949; x=1790709749; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PaneUziA5ZoH4HTRhCIK7Hhw0UG0gVQ61sVYvGw4p5A=;
        b=loGAi4LcnzWL8fX/Et732//3x1cqiVPN4ObdJ9b75b1VyQt9GoIeMzfHbUtrQ/qiOs
         4y0/yO0co0WrO5eZvAlbM8FuDzPd64Tai63ctTQSralE2rnicomMVN1JhQjqcFJNSRMt
         ZxO5mnh+9CHTmBuMf39SDkbmt2TxDe23rxcRQKITjsFUe+OXabTvq+eeWrUjMWfs/mNR
         ppBrg8oqVLTXWPBbRpXEqSBd0cipVL0bEan0VXNRAPb3LRIPrfZu3xrCCTGiSCukXMLX
         zWnKT6RIYRNo/DmEBacLNppV5XjNBov8qpaMTSRK+hCG2lPfereWUXczXd+TN0SmX1ZN
         Hhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790104949; x=1790709749;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PaneUziA5ZoH4HTRhCIK7Hhw0UG0gVQ61sVYvGw4p5A=;
        b=RnQ0y3AfxtxoJhkP2tzeq52sg/tDEn2q0z8/XgNmLaVGh2LtcR0BqvblRt+w+sW7T3
         6QZ0JySjBMCXN+uqMO+HHJEZXgEpzfMdxVmjxet06JOtskTmkawS9MbmkFDCzdrWHoBE
         SblvcbZGLorU41BpKFBpEHFSViDs04/xdkG9cu3DewWBJk72wT/2Th7Q2sgMvGWkSb/m
         kIO1a6mwZDeU6GFl+sPkSo6C+25Ryh0Zu3CF1adcMeGHjajw3YrpesxMOy7ti/gRDYdN
         6gArBOMu7AB48Hu1QKEJeE8N4FvMTeEGj+DwrslcC/q5n8qG2UMoCux6tbTJuWOd/Xr+
         IENA==
X-Gm-Message-State: AFuF++lMcrQGhthUF24iJJDvtlhXusTMY1bEE3A6kdYrnt/n/cT3lZmT
	3fkwrh34C+DRYKy94uIw92zmT/niLvEJVMuioQ1bgiTLAcnt21Rc6BLTam0xkK1P4qzumsy6Vm8
	U/b/tyW5FwBEUjD0UpbhAlUqyoPY2XwuvATGocFlIIqBNbCACK2NgVWBzFqY=
X-Gm-Gg: AYBFou2wbadkM4SAkWEWz17+uhYyExuoFSdyKnHo7NL+yampxygXAu5PuI5oKatCcnt
	vnNTnLfofrsDMdTWy7KD1kIp1FrLa5xrHzf/1cAyL2yT6ufchMF512idbXE32IZQfN8xSlWJBAt
	SCOTxBwNR5ahsQt9540ICjuYeSF4qZ6z2BE4TPRSOO6OFdfckZ/7PTt9CX/b2PlwEYu4BgD6owD
	dJvJHW7CQCWAkHM2DxCZ8I5T6/BytIVHdsRdilnucTThjBcJB5ZxychSe2rVmh/4++eSEzOAHzO
	Ek5bYVbnVSW+T/0ADIhk/H19t6kKtHqgx7cXpxFORPq6rCsCsS73eukt9ZUmjTwsB1fRO/1NcMf
	GE+NdFHRIG2+Z+h5Tkg93
X-Received: by 2002:a05:600c:6215:b0:49d:1e09:694a with SMTP id
 5b1f17b1804b1-49fdf0fd2f5mr3154375e9.11.1790104948764; Tue, 22 Sep 2026
 12:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Sep 2026 21:22:15 +0200
X-Gm-Features: AclHuK9_1to_5H48A_5Cg8z7nauN_oUV9xO4yWHmKgbTfypVtoCbct8v2nimMCM
Message-ID: <CAH5fLggWya+4rz8LWjaCqYQ8eBfds2-yim9NFZ7nZpz6ABdG+Q@mail.gmail.com>
Subject: [stable 6.18.y] Backport request: two ntsync fixes
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi stable team,

Could you please queue the following two upstream commits for the
6.18.y stable tree? Both apply cleanly to linux-6.18.y:

  180a232ea78003d1dc869b217b4e49106fd58e8f ("ntsync: Honour caller's
time namespace for absolute MONOTONIC timeouts")
  61611481f7b599e0526a3782c626b1a9deeb48bd ("ntsync: reject wait
ioctls with zero owner")

The first is needed for correct operation of the driver, and the
second prevents wait ioctls with owner == 0 from leaving an unowned
mutex in a corrupted state (count > 0 with owner == 0).

Not sure why Fixes tags were not included for one of them.

Thanks,
Alice
