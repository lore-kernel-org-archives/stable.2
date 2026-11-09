Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227025;
	b=WYoTOdhKHm6CU0P3E6Kd4Nq6nGdytVeq9yJNvlSey9ysAJj0wasIIeoOlIde9RVxEGgD
	 wB57sk/RwNL+whu2VoBlkJ1MblD4TtBCH1XEKsYkXspc8Vq6cuXUapveYbbaJ+ZNjnI64
	 msax3osCSknVN2W6PFtuUwxHtiS7Y56NV1EB2ajoGttDb7gHqfkgO8pghz1rPTCQeYbrD
	 Jz8Xki81ZVNJ5QidWZKAEDQMGePoTX5zeqqtG/msO0MEjPKQ6WgQEWu7AKDVwCUqQXYEA
	 TrS2f4AmzuWp0tWTW1QjxbH4yqiTOjcX1v2T8fbA08eEjvrYPE5NOzABnuytuVJKwUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Kz3bB+vsuGd2wTXDnL7xzs9PrYxFrhVkmgaoPhitFfE=;
	b=MhFTye1EzXzVWMIy8swAavPfST6+ZsQbKOSGvBg/BfuC3aV3keDXC5AlsHrN9uC0AGCq
	 /9qFFs6V+LJQYgAeVeL6SvZ2uSLs3gZmM3CY2fS9Km5gVZmKiRqYjQab/iO8YVO/2dSnE
	 xjox8KCxwaLyaNaBQ3TaCixdi6qmSXbdzXwkSbULPqlFzTjxqI2pq4EIsA1kD+/JtSRep
	 QotuRgcCV/d4br+bhOIVA2/njevBoXNBpZcUct84vNK9SsOtR5uluuJVVWW033Iioxepd
	 LHDiCLwz5n7F8ZMgee+j4DKqKiUbOZbeepn7t6ciKvUCcFyZ7GF2Be5x9BxXre1UC+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GZknsHKa;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6F6082BC7
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D6F6082BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GZknsHKa
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4922523d1afso421318f8f.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794227023; x=1794831823; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kz3bB+vsuGd2wTXDnL7xzs9PrYxFrhVkmgaoPhitFfE=;
        b=GZknsHKaFPAErfD8SOn9xIzpaKI/N2zurbyUyRh6tw5NlKsXXe29Wks1dwvMnoWjOs
         nfrc/sLKppuyqHicUc361Btd1AjgDaCJ2YBXKtpjGOtJpUswx2+fgg98ZizSq1ARQSs1
         b5ADn1iRwIQaBKcT+Jvrppg2C9jqpuGn0mJb1QunJSCoioYLu+DzX7E0iDSj2NSpBciX
         oOI4UaJfwiMKy9VfBkLuBtctVJqb9/IXAc0E/Txw0bSYtS0teCPH125wgSGUsktfk8hm
         MUzuDpTEr7QNhcTDoEMLaqorTAIc7U3Q/M6SLVLZzuQSNw4jX0ZRnLNAQuRCpxWguu7b
         TPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227023; x=1794831823;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kz3bB+vsuGd2wTXDnL7xzs9PrYxFrhVkmgaoPhitFfE=;
        b=sn+4AOOjyR/VltVYz0t68PtOk3hWrRpkmrrqUoc2z+cCgHuOgaQhHdzZ4sP3jxR78B
         bt+S6XZORche+PaAHpP5Xu65/EIoh5xBst9yr8m+ei21VKdxnUBPARo4+FBhRyq2pn+/
         GMnTYuP9l4/xKMRNy0ivEpvu4dBbscItOZ4pSaC8YmGpjRxc9+0TTVCxmCvplVWXVR/I
         EEGXR40Jyeh9qaV+WR1TKlq2Antg8c2uUdP7TelXoaGJzHh1GF/vxY5Sb3QqcUFr+rZ3
         QlfWrCchZdoMA6TCtFv2jzJFR50+pye07qgsbkEBSUwarqkEMnlGfwgh7o549QNOsXrN
         wGPg==
X-Gm-Message-State: APuU4Z+OxqGbSiWGOF0Y0ubiO8N7PB6+CMEE2ys+NyoyftfWywEnJcrG
	kOKsyg65C8TGzrH4FdWw6jp0bPcIkdwSZhBgVsVzUeeHtYV7NeXkFiT3yE0Qro0d
X-Gm-Gg: AYBFou2uWd1Mhw4QpAUlNRVNGYT43McLfgQPiUch3MWrMEdUHGsdTtNXVrZfezuXdwU
	3b5dZWn6SLyLvH9I7FFG82AKIovEHa4Ap/zZM33SV8AiWxz2+OzsMr/ajlLyH6KRITy8CMBm/71
	X9Fiwvktag6RCzviRqAa5DM+xU7wJznJDAEtz/6AdpTLE+iYs7VvZgN0j68wmYJz0R0YBpDS1Xz
	8W5WZB070KtKv4dhxwXdQiBnGyR/VkoRyNC7gKGTtIznzZUAk6AHeqsjAm/X1ef0+lnclUZ/Giv
	1FHFHbUDBdxt9CFppJ6Ybec/zeH7bb+FbmviOrSTNHz51K9FM30sXXfBtoAhOwFaz3IYKF+RxXT
	7Nn0tn86dKMBZ1s8Ccg9KYC5ilJqcynW3rl3ztcPiAYd540macwMZ9BrurvVqixV0Qxqz5LE2XV
	OCfZsNvpt+O+PzCUSzq9uhJxQY9v0FjYnX9m6SZ38DHThE7r3yPAikQjpQaFXmOh/5a5+qhp3dU
	TIxtIUYMbwzVyX5fSAglWPsJSL7rEvXT22Z572qc88jCzqtF0al9kbmEPc2ll4kR6YHOZ57Ibg5
	4Y2+/UxiYrUi7AgM643iEuybdzq/Zy6QDnXVvIc/OTOFPhqL+lrSeVBcaGicBG47rDaJUXtTrBa
	PgaRXiw==
X-Received: by 2002:a5d:5f47:0:b0:492:820d:1e with SMTP id ffacd0b85a97d-49582badd84mr7720642f8f.11.1794227023376;
        Mon, 09 Nov 2026 04:23:43 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959774736bsm10609850f8f.43.2026.11.09.04.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:23:42 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 0/2] nft_byteorder: fix the uninitialised-stack read
 without removing multi-register support
Date: Mon, 09 Nov 2026 15:23:41 +0300
Message-ID: <179422702104.5131.8115555421206983838@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Pablo pointed out that the full upstream removal (bb061d3) cannot be
applied to stable trees: nftables versions before 1.1.0 can generate
len != size byteorder expressions, and the removal rejects them, so
existing rulesets may fail to load.  The removal is tagged
stable+noautosel for that reason.

This series restores the multi-register path in 6.18.y and fixes the
uninitialised-stack read with a targeted initialisation:

1/2 reverts the removal currently in 6.18.y.
2/2 zeroes the destination span marked initialised by the control
    plane, but only when source and destination registers differ, so
    in-place conversions (sreg == dreg) keep their value.

This does not reject any rule and keeps the old userspace-visible
behaviour.  It removes the dependency on CONFIG_INIT_STACK_ALL_ZERO
zeroing the register file.

Compile-tested by reverting the removal and applying 2/2 to the
pre-removal tree; runtime testing on 6.18.y is welcome.

Abdifatah Suruur (2):
  Revert "netfilter: nft_byteorder: remove multi-register support"
  netfilter: nft_byteorder: initialise the marked destination span

Pablo, this is the stable-specific alternative we discussed. If a single
folded patch is preferred, I can resend it that way.
