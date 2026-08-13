Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB451F8691
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786585585; cv=pass; b=j7kg5dn7HRu8md5rTkYGyDMDPQaCX3MWqPP3ztrv7XJ/MnmVr5YWXRpl1rdGMgiaL45ETAB6wpSiaYqDjXhsmOU0SzkpoO34+HXWONwuJPbV3GoiKd3c6pXhRJ18ZQJ3E2U+KBrGQTbgjo4DXIVE7HXyOWVCo7wOgMUSP8LB9LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786585585; c=relaxed/simple;
	bh=8zsVKbd7rZ4kyHv3ec1MwsHX32ckqjo3g74aZna+Cbo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g2hW5OsiBlrWrMPQ1k3RhzC97UXHe/yMoQrHKCmoMhMhXonKHS/sXLBKzp8utDgJ+HdI4/sJpgLJcAh1t972OGOHs+Bc/adm/TS5pa6uPRvzlVaQTFayv3XIojiGFs3qlLNMCSIFsACw/UWaY8YRfCjS5X+5Zj0N7UCL1IDiXqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpFkOidg; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpFkOidg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso2897225e9.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 18:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786585582; cv=none;
        d=google.com; s=arc-20260327;
        b=AvFm7kLSWyR4SVdgvwSuYnPIeGjRSWuktK+jGUNGjKTKX6GjFnjB/GYRRAN3mQv2UO
         0livW2Yata9rWua1ZHtdpm/EIUzvGsOdJzIEWR3LYIKgBe0S1OWFpsSA8qCGW/P+5nYS
         TR/WFtWDp5wmGv+hlICXf/kzFeY79PAP05YP+JNL0X7IypNvfN3S1OhVroW/tOCgj45P
         mZcCjQwGNuSXiYKyx5XaJFlh7lLAEgkD5SlqXLmkIcy/49Vf9QFSH84Tae899JY6lIFj
         WNolgunxgwovobBSqy24jM3TVUSYTLiOrME1XCNjtNrb7k1IN8wRpuiqmR9ZAwvn5PVt
         6cFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8zsVKbd7rZ4kyHv3ec1MwsHX32ckqjo3g74aZna+Cbo=;
        fh=afq15lTum68b0GXlJOu5j87vf8a6peJICilNiymUpr0=;
        b=XIZ/wixbtgv69p9lt/cjvP7PGZ0dSSmEoAtreKkTnM4Kaf4xQ1fbbmJCJ2I/hrwBWg
         B11rKClsp3OID9ASs4dV8x9KQWZq/jv10aaxr4yR3UqLySAJGpReYKXNN2w7QNFLToiJ
         Efy81bHTVOQmXRfECNBGV1AWUIb/dYwCXccZsyADDKjT0hJZ8ATekt7IVcxFrZC5nZJ6
         WBAcz0R8gdXorQBAY36vX15sCvfbBbMueiOxLylinXEbN2fCXpDp+u+Eq9eaJC7ovWnD
         cC1kgfybJfA7KbXKkc0cxavpLOTK9Tlk5w5Vy+QjcCgTjjlawxTqwx4LgJ7V8t9fRe4Y
         +1tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786585582; x=1787190382; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8zsVKbd7rZ4kyHv3ec1MwsHX32ckqjo3g74aZna+Cbo=;
        b=QpFkOidgxXdRrgkBSeSRUjM4ChWy6wfDyoWyd5/UlOTDFWT4Lb0HG2uuxb1eQhXK05
         Z3DhHrXYmhilo5KQpy8MU496nB2YOV0t1mDF0WcXq6vePgyMx8SCzi6mLb8qdgPiNG02
         NgG4/PfGDA3tio0Bgj8P6yWcj3aBjmTjSSAeRsbaL06vbpU/ge279KroiWRQcxJ0RzrC
         1x6C1CscH27Un3IkyIIltS6wbt4x6WhXchHs7S7+4JrcOGUEoKHPlLTPW/E6kh1VIxQ8
         uKA4Oo9pvKQFnS0biiQ/ZZnF04kh6ic6QnNKOkPxnrHINdpwH/dL2PiwV9b+ADVoS0MB
         FWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786585582; x=1787190382;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8zsVKbd7rZ4kyHv3ec1MwsHX32ckqjo3g74aZna+Cbo=;
        b=JFOewzkhrKIcdQlToBFNxHuCvQleW/pwNk70n87J+2haw32+kFACRsxbUvXhM5p9Cf
         HrMh2hq6m3q4YXTRAwp99KJhGf3wQM//+OA4Fp4mrJlSfmyLSHZ61bhnX/ssUwukf/sL
         3hDvHs1V3Bd1e3rb87XNaJJl2cs9TCzGzCd67rTVaIQCbY0OZ9tS5wyMqd3red8EIIMK
         wivFtir8E3Z2O3W/dPgZ7PlyaLOWqT/UpgYihZVFcRoQw17qv4BScz5OGSH1CzTLtIVz
         P2aj7qsfea1DxETUETnTDacm1K5veOv604+ScFf+HTZ0xhH48E0wMB+LzEwVtwEQPYvC
         Tx6w==
X-Gm-Message-State: AOJu0YzZZs+WhUlxnC0vi+8I+DxSB7+OXFs2He7T2R8Xz//Orl98TZMq
	prIgr6IrFpkzC/9fzSCtIadHIB2t46AXfC2w89pgZB5EBQLgLl/b6UxLOdivopfLooemtTU4zZZ
	gkhlfyqL2MxcOBGLCM0nyHvDnQN38M/PC6SD2h0pEU1MG
X-Gm-Gg: AR+sD12XgkcNZA6KwUPJNaZRKO0kxZ7Qir3W1+YlIAzj9Y/qplaF6aehWEIfTnJNZox
	97ER8/VleWS/o8dtQiRYYj2zjWJWH3HoDmm1iSqVunRjbQWUYFmCOkUN4Qn4moXZwdUXwuY7AUM
	Amw7rUKB94/OxqmiBfTQufCAaeng9yCtrUxL5x9XxbNBDboUeullAzyqfhy0CjD1JVfDIhLsJOy
	2dPIE1U5znlbLq+IEleWg1Y07BMiEpwaeeLv8xvDCqPICCK2iW9tufq1gFgq9Br+Cd6d3F3GwHn
	9MN5AKudGi8vOz+CZsEtkw36HXARTBXnaNiO5vRQmnu7
X-Received: by 2002:a05:600c:314f:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-499821fafebmr15881525e9.1.1786585581976; Wed, 12 Aug 2026
 18:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5ZC05rab?= <rpwtsama@gmail.com>
Date: Thu, 13 Aug 2026 09:46:09 +0800
X-Gm-Features: AUfX_mwjykauUGRd7p0JKAKBT_PY18R1a8DeaIypAi_vxLHJDca3Oj2G0IKRXMo
Message-ID: <CAF38RzLOUW1ZB1f+Q2f9mhnYs+t4R2+UQA1PCihz_FKEu-nSew@mail.gmail.com>
Subject: [REGRESSION] Panther Lake 8086:b082 internal eDP black after xe
 takeover since 7.1.6, still present in 7.1.8
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, intel-xe@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting an Intel xe display regression on a Panther Lake
laptop. The problem started with Linux 7.1.6 and is still reproducible
with Linux 7.1.8.

System:

Laptop: Lenovo ThinkPad T14p Gen 4 (2026)
CPU: Intel Core Ultra 9 388H, Panther Lake
GPU: Intel integrated graphics, PCI ID 8086
Driver: xe
Display: internal eDP panel
Distribution: Arch Linux x86_64
Desktop: KDE Plasma on Wayland
Regression status:

Known good: 7.1.5-arch1-2
First known bad: 7.1.6-arch1-1
Latest tested bad: 7.1.8
The issue is fully reproducible with both 7.1.6 and 7.1.8. Downgrading
only the kernel to 7.1.5-arch1-2 makes the problem disappear.

Steps to reproduce:

Disconnect all external displays.
Cold boot the laptop.
The Lenovo firmware logo and systemd-boot menu are displayed normally.
Select the Arch Linux boot entry.
When the xe driver takes over from the firmware framebuffer, the
internal panel becomes completely black.
Close and reopen the laptop lid.
The internal panel starts working normally.
The issue occurs on every boot. Connecting an external display changes
the behavior and may allow the internal panel to initialize.

The failure coincides with the following kernel messages:

fbcon: xedrmfb (fb0) is primary device
xe 0000:00:02.0: [drm] *ERROR* CPU pipe A FIFO underrun
xe 0000:00:02.0: [drm] fb0: xedrmfb frame buffer device
Tests performed:

Adding xe.enable_psr=0 does not help.
Disabling my custom xe SR-IOV service and booting without creating any
VF does not help.
Linux 7.1.5-arch1-2 works with the same firmware and userspace.
Linux 7.1.6 and Linux 7.1.8 consistently reproduce the problem.
I have not bisected the exact offending commit.
Full debug dmesg and system information are available in the linked
drm/xe issue:

https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8902

#regzbot introduced: v7.1.5..v7.1.6

Regards,
rpwtsama
