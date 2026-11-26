Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795669609;
	b=itzSD4HsbWoidiwTz45U8JH3exgA+P2qdxwKR/m1gELJ+mT3Xhj1M7FbjWcU5ykvY/Pp
	 4aqZkNNOErq4tWKjpF4gqr5I4k6fk13HGUXen3GFKr2psyeJyHoH6KzG4NpUXNT/ORraw
	 Y/gna9z+z8BAFsOX21uRvQNp9L3+Lg4Ppck12AuoBZmmYnjubAR6qkYnhdLOkveoUOSuQ
	 OOar08dSOnCDfBIWCB8/xaQGvbyo3j6gbYTHMV8S5y9voTNqhOtg6YdeH5fyhe7JBoSNe
	 mNsqZ6pYSKkTY31YOx4Ujb48YM3K57T9MyjP8EuIiMHMpc3UnoOnjeQXvHExeOBXWKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=G/SnJOKEnCaT8XEc1/RnU1pLsZbQMom2QyevXmQVkZ0=;
	b=feTGfxr8Q/DBC9X2g6PWQE90drQLMBXb0vjcEcXk6IYojIlP1ftmGTQhe2BJ8C+NgoPf
	 UL+XrkkFmo6oXVALEdziiPG7Nk9DAuq44wDbgYsMM8qf2FNAJzf8u+tqcHQbMMO6tU+jy
	 Q37qYt6/2VuqZngYrb/CXJC/1P86XPtpZGBSrZI0JKLqrzlc12tMfxwqnWiiu1Oa8bdZS
	 ibq3lqH5vTczHpbJvD/V4Auas9PWkeXhHmRGjHAdrIFJKZKGyCX07fEiFuKuPJ8kZdoBa
	 RD7iEzHItLqFBc3JM2HpzyPVS2mEtBj2D+lHFquYEE+wqKeUjD8DN8Tx4KgvfcVtzrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=RYKjaYpM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290F606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0290F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=RYKjaYpM
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67db3a48dc6so7912177d50.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:06:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795669608; cv=none;
        d=google.com; s=arc-20260327;
        b=MsitkgVkp0KzgGfNDaWyqdNbUg/zLa/3PVyXbqnDGUNrHUe50svtr9Z6/win66sQac
         NBHpXkHbbIDXyxCx6ZhnQeDQcBGh9xzzYInpQzQve5BuY5m6mosqmagFN3KrOwwXwbDj
         90fSxICb3nj0at9tP00jdMDfM/R6D/GTiwuGZF43eigwR/hBgn0RdMGZ9p43bhyRGczp
         hj2zrt5+pr0GfNOjS9AvffAZMmbOuLLIxk0rnP6kPTK4fqOixFFqgFpsQiKatWjnM2pZ
         a+m19Ch4cs78MpkQnRYC+IsfwTXLpQFcM1URQq6TImgNFPKqArNNc/hl5U76q9+pyL8G
         vUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=G/SnJOKEnCaT8XEc1/RnU1pLsZbQMom2QyevXmQVkZ0=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=X3wgZkS4a7/bx3zM4c7nZ1V1ZoHcouCtM/85MwR2yi5OTmDlJQsi4eBytBUS1n1hyF
         SGIp/AnpW4tNRpSolVc82UjnsRGe83AFSOjKxzDDuvs9YtkypNqm0fPmSM3pPLWkgX2Q
         n5HbYWNqRf7wFFjdBphyCZduK8N1K6QVSwA4NUTWTBiedFh+PgliYIBVdpDmivOarfqd
         Pav1SSGrT3ZoHSuPVd6RSzWf2KxMuR8h0Cp7ABftncZ8Eix/BavZ1U5f/uqduOEkxDbg
         fJW/NVDjRBZ2vnD3mOg2wkMb4I955MrccHZlaO0aQSik8g6Z+Flg5ayjg5SbGrOh5qpD
         aOBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795669608; x=1796274408; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G/SnJOKEnCaT8XEc1/RnU1pLsZbQMom2QyevXmQVkZ0=;
        b=RYKjaYpMJvg7vaO3aQI+Iq+TYGGNkIylO9KmgJtZ1i71PgkXbgZ6UlqikZC3mvlRXf
         +DKadq2edrjP8s3t0xewoZIY+CXnvT8KTbz9u++BGlKLNPNWm0H9sxVnJAfIpJZ9ZaRk
         0TB1OYQXGX1hf1GoO2LXO6Si9PNHP8thFQ/+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669608; x=1796274408;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/SnJOKEnCaT8XEc1/RnU1pLsZbQMom2QyevXmQVkZ0=;
        b=uvsgC+bijCd+9vFo2PKgq8Hv8MgUzWLD6AKLlSLqNBF1BNk2YP0xKW3CPQs+n7S/HO
         1Fkq8vHk3k57ttDPzBuGg2obpRtKJKbe4VREhI0IJAEjQ0cCmv9hgjxqJ6suee9nV+2U
         s2VA0HISlrajARL/JvKzQt+fnTQ124i7LHYG9CEG4umkSn6pfEXIrDwkvZnMamJketot
         01Y2opVpcgGnEIIpHWzS6bLDXtGg+J4SKUaewypPe3pGdd7IBEu/7Au9WAVKs3ESyRnQ
         ZNplJJtMRDg0T7NsrafuLZYqRw8fRrcFvUpQxseX2dbGETUPXdb5IMNz421ju27LQnMt
         Lpvg==
X-Gm-Message-State: APuU4Z8O41co8K08PTDveVvofaKIWJjvy/8Y71p629v4Wgw70lGT7dxw
	KpFvHaQdc1NuLhX9KwpCIQmiShCvKqNYVnExdf0LyFYWxc/ML6lrBg2c0LBZz7QRBkJXFbTdx9U
	ZIuvTa67xhFgAV6HEM2KbGhCoJAr/vDG81lMNsnbgSgJQBWAZXCLWMF8=
X-Gm-Gg: AZFdTZe+gxl1cWBVFORFB/ZDG4Yix07cxv7mMnuO75rmmvf7AJJ4uCRXdvWGh9r0GAV
	9wu0cGUqAKNJjr24gXIf8F+G3BjeL5ENBaTRxtVUm65F6q4EPi9ba2x79BDccCYq47IKU5lEOoZ
	GXVbKfQwom2uRh1jM8iPXOfnmdvS0espdWQ+GBu5fCmJ/DiR4DLBtDpWmVHLWwPoBNf66EfYrU9
	DqH3xIfTQ02x54z0PRfKMjBjHQeJynsexlarssmbETAq3QKg6quuxTM415U6HxybKYehkz2N2rg
	D7qu/Wxzd2c6aEa1ta3DLujVJW4NQnW8TwQwgbsItYEjX8J+9jZypeRXRQSWWFk+Uv0v64Aom2j
	n0m+ufA3qA0jb6Sxg9CjVD7+xNvZFV9i5cFMxTHqeTgRvOySM/EkOLNyfG5flFA4qhRfOozF7mB
	ToLblEun55SI3Hwg91q6L4uJ7UWx6JbhKNr+R6M5jdEScJE/KHc/WIWXSZ33HTpRSIPbkVcaEa7
	QWwN8F31b+NvOkt4ORuHboeA4jK2lLhVoY8
X-Received: by 2002:a05:690e:441c:b0:67d:a102:b8fb with SMTP id
 956f58d0204a3-67df44bad93mr3978765d50.139.1795669607927; Wed, 25 Nov 2026
 21:06:47 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 23:06:47 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 23:06:47 -0600
X-Gm-Features: Aa3M54riv59FTKxnyEZRqeYySBZAiXTiqz9MzwXe5qN6ykIamKxJ7_no2dZfBVY
Message-ID: <CAFaZ9erY+wo3QhtNvBdw1q2CB1fm4d2Zrx4t2QuJWEakDmo0bA@mail.gmail.com>
Subject: Request: security fixes for 5.10.y, 5.15.y and 6.6.y
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg and Sasha,

Could you please queue these upstream commits for the trees below?
They're security fixes that every newer stable branch already has, and
each one cherry-picks cleanly onto the current branch tip.

5.10.y:
- bea3e1d4467b ("hfsplus: fix slab-out-of-bounds read in
  hfsplus_uni2asc()")
  CVE-2025-40082. 5.10.y already has the earlier fix with the same
  title (76a4c6636a69); this is the second one.
- 90f601b497d7 ("binfmt_misc: restore write access before closing
  files opened by open_exec()")
  CVE-2025-68239.
- d46c69a087aa ("scsi: qla2xxx: Clear cmds after chip reset")
  CVE-2025-68745.

5.15.y:
- d46c69a087aa ("scsi: qla2xxx: Clear cmds after chip reset")
  CVE-2025-68745.
- c0b7da13a04b ("scsi: qla2xxx: Completely fix fcport double free")
  CVE-2026-43414.
- 8ec9c1d5d0a5 ("PCI: Free released resource after coalescing")
  CVE-2023-53743. Upstream tagged it for v5.16+, but 5.15.y has the
  coalescing change it fixes as 26277a425020.

6.6.y:
- 59e1592d3c27 ("ALSA: seq: Don't leak the extension cell pointer in
  the bounce payload")
  CVE-2026-90220.

Testing, on v5.10.275, v5.15.226 and v6.6.163: cherry-picked onto the
branch tip, W=1 build of the touched objects before and after with no
new warnings, and x86_64 defconfig with the relevant options enabled,
built and booted under QEMU/KVM. I didn't run targeted runtime tests
for these paths.

The list and the test runs were prepared with AI coding tools (OpenAI
Codex agents, with review by Claude).

Best,
Dickson
