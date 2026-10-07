Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E745D5E2
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363490; cv=pass; b=KcZ9odLvzDNL/Frxr5CHTxeioqXNyQkITFTX1n51Wb1KaoNt37ENzVLwqMJQ2kX03qkF5Z5c5C45smxbuVKRbcS8+A3eIJnYIMt0pIDirV1uokp7Qf+zfP9VbNPBw31eAaboo1mc/Ca7FIa365ca+JHb0GHflVGqkEN7YXEPj6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363490; c=relaxed/simple;
	bh=qXAScyJBP8Ix8YqSyidlmIUJCqlWPS9oijDB+zo+cxE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qyew1d9ginloWt/2vLEAbsBDRFhc27PzWs3yCwFD6SkLTqmfOzOMWJ5X3R4IG7LR/wPoIAt+1U1bJihoUDPxNWHIWiWmEsTErScxr3U5qS120sfmsPfRF+V164udYM4EEdBzYk+cPgOYPQTp9b/S3zscr8H2le6KMzqR8U/f5u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0PJr2QG; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0PJr2QG"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-82503732024so667275a34.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 01:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791363487; cv=none;
        d=google.com; s=arc-20260327;
        b=futLENJWWbkObIlCUBJp0SxMIOlKeRttg878Thf/mJrMFmAcqTxKqKW4EKcZSfbhsl
         qh/5DIavWFLyuuW2VjiHaelLtXmdkCnVsp16uMqX6RrwvtqUCmSPhWzr/lC3ikeYiYdE
         qxkTr2ntu0hN1rEr4LzWntHtALQJs320dK1RZEmNbGs/Nh3YiHdJwmbdJ48GaXWwur+U
         1kqMUOvjxoJZF+0/WtBfkwPtb1xpqLwSwLvtnKn+He1+faIoTddm6j4vv5h4iuN7ivPQ
         zcSjXt30JHN88/abdZ4XZWHBIs8Mue15iISoTRkgR4jPtrrktBIBO8W7f7L85uhVSIjV
         JTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dFFzVUvDGPx4cWOuhCtO/dkoffZgG29srLq5Q2rN2Gs=;
        fh=jgJklHX98ngQMsouFB98Axy2AOtnDRwhjrre8BMsWTs=;
        b=EFJa8iLOBRH0A47RXx81YBo0TUI9L3RslSjenVgj8iA847BqGZXOM9rJwHCZY3ZPPp
         mQSaBAXL5EyiBBM+13stkThGdE0qvUkt8rxlK7YWBu7f7lHC+jIMMH/L8KfYbrh10Vmo
         0esLTkC/fkhPyXqWTPeWpR43e4VM5skL1pQxsF7rdkVhvky4koRsn/jmr0A1oJbE0Sxc
         3yml9oZnw3yVZgcGRRuFBx/TbGiMTY6vLaeft4Qa/IUas1tbb8ByVwjU9R8+suT5LTXe
         byIaUFJ6vU6wXKr2XQv5IajKhKDALC6DwYXwefq7qIvfJEbweN5h+MjO2tNA9a6IwSr0
         0EcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791363487; x=1791968287; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dFFzVUvDGPx4cWOuhCtO/dkoffZgG29srLq5Q2rN2Gs=;
        b=D0PJr2QGyFgC5Dir5MFVXYejsk4tgaBNR5ldvRwJwMfF/Nlt2k6SsMbyieOuK/Knp9
         +SGbGzzrqLS7wpEya2YnrxaO79rX/UhgEPeyPgQdgneWZGOB8w61E1rYbC8n2BGeFzWM
         NrqbnBwlgZSnLEHTb3FSxVC9731hntp6C0m9s9X3EHLZm2CZ0PqQENWTjwD2uNUwzvkq
         0DP0tECFFZYNjbDCQQQrfIed9SWGx9DWCOxVI4AFfQmJujG5peJV6ooX8Sc4QqWkIdKX
         00+oCmamwY9ogJ/ZPyQWs65wV9eaTgbw7AksPuo+jHP9LqjQZ5cotdfwQvJHiw7ihVlu
         VlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363487; x=1791968287;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dFFzVUvDGPx4cWOuhCtO/dkoffZgG29srLq5Q2rN2Gs=;
        b=l4EcpPLnbpYMeNIoITkjhJAoMLXu2cXwhNSy0R0UBNZ5WtOWxjVW4IKs6Ph8llWERJ
         /aHdtmSLEP1uIA80cuIJddITMHiZeDrjO5+fSRBjzXog9QiQAnGfaT4PyTuJdRjysDm4
         7JtxMX2yV3o/R8FlvVxTgYB3uu/pYh2xcI/R5fN6KeEKFsGA7xX5o22tmI4aU1cvFRL1
         2akRRgKElfS+agRY2WnUSO1iYMuAG7y04ymb4S5c0S7LkadoCJXqoeHzJPjs/xLX3UFI
         lj0DevEU9ENJe4qxEpjNjJyaWPKK318C+b8fymM4pcHal4GBlXbt9pU56hXjtBk/iM02
         6T+A==
X-Gm-Message-State: AFuF++nLuWPUAi6E9gUOctUJwn3JyEbNbnVbmygoHdmoF0XnvfBGNBeA
	VpG46JlBH0GhWkDPaJNRpCZDJvm9CLnIC32fD/3c1iik4TpYlY/QsloOdTWFhhmexx+lwU2Wxkt
	cL/OkaTwLqUHCeidCNvM55fok1JX4A2MlwPQnNks=
X-Gm-Gg: AYBFou2HktBJ4TUduteHHkmK6KCWFbaZpJeBGzo2EslY+rex54YmKelGNhZ4CqC+FSq
	/isKxjfMUNxrHMXN8XnI0K31oBACfu2ZWbgG8kcOCeWw9lBa6Yb/qa6JATdhoaY2IIWyjVGH64a
	rRZQwSFOrjhLn/oEXGqAL6dk5so8QmqH4kRG5MOIqRrY/9hCl0rypODIaR+WCt4J5/wNo0EpAgs
	KrjsXHDFbwWVXQwnn6BPuJI01irji23UhMP2yoynnKFwuViwb7xdqjbapwaOaXYEyBV9zlo+Txc
	8LQGE03zeQPVT5+nEBTMBuIjB5hudnzUPhgXBEvQNqEdlyCB3xIpxg==
X-Received: by 2002:a05:6830:6f81:b0:7fa:ab72:9e01 with SMTP id
 46e09a7af769-82ad05bcd08mr2728833a34.25.1791363487510; Wed, 07 Oct 2026
 01:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gilberto Conde <gilbertorconde@gmail.com>
Date: Wed, 7 Oct 2026 09:57:56 +0100
X-Gm-Features: AclHuK8I4SeveVc2elYJfUoDWNdJq0rtjbxrwk8dv_F5eQHMvB4OdBSsT-5rChg
Message-ID: <CA+rCdHiuoYZbg9F15+_9AzvY8go0zfHJMfwdTgV_MhHKfCvQ-g@mail.gmail.com>
Subject: Request to backport "net: usb: qmi_wwan: add Quectel EG120K-EA" to
 7.2.y, 6.18.y, 6.12.y and 6.6.y
To: stable@vger.kernel.org
Cc: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

please consider backporting the following mainline commit to the 7.2.y,
6.18.y, 6.12.y and 6.6.y stable trees:

  0f2fd31f63c6 ("net: usb: qmi_wwan: add Quectel EG120K-EA")

It only adds a USB device ID (2c7c:030b) for the QMI interface of the
Quectel EG120K-EA LTE module. Without it, the module's data interface is
left unbound and LTE does not work on devices using it, such as the
GL.iNet GL-X2000 router. OpenWrt currently carries the change as a
backport on these kernels and would like to drop it in favour of the
stable trees.

Thanks,
Gilberto Conde
