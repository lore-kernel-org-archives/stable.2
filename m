Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB81356747
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791260697; cv=none; b=eiC4oHo2NW/1kGoN2XOrt/klrd5Cu8g3Fjt51g2TFQI0HdSsBG3KXUlqknES6YO0CW0rWuHARooA+fMpuN6ep5bQRlB1SdIEVIzIGqmfQDOspJQwUKVF9VR1Yi+Cp5TORrwU7rId+G/Myd72lJzGpVzN9cGtHoJsqfIpB7IqGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791260697; c=relaxed/simple;
	bh=XQVxNylR2P8v/oTLjosm+EQuzSiRHFCXGk6+dBAYkTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+AcC0ks5/Tc5ryLFytg5dBa2Pu86kySHxlw0A8pnOyMVXHYPBY1FG3Whvh4HE4mm+njRd5kThuf6Vuxcuo7tScnBbnTLGMjFijiu4PmwgNHSnTB4JBziYgFcpoe6aAYKiBZY2Hu/q+Vpx4YtI9lTh/uj6mzYcu3UxWKJx6gKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=iOf6KPYY; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="iOf6KPYY"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35127e848feso154126eec.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 21:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791260695; x=1791865495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uo37arCimajCV353Vnyw49uN/c9H2oi5GOWiIgl7tSY=;
        b=iOf6KPYYF7myY2F/Il2tbmyoS5IRwcM+O6qP5QsjKNe6gLCi83iYH7shMW2OPgn0J3
         LWV2kooNBqM++DY1AeSCps3BOk37mdp+46Az9Fk+74C+HJd7d9ouP8Jfzyhm9N0G6M3c
         /7LrGtXCKHrsQADfNL0M3tppcln1QmW9h/P2/Q6iXZ5QgppWteb51FbhnnBI9Ig4oJiA
         ESrkn8U6eI538OdsOmxJyDrw03yHq5makV2xxZTGxEJSatJaw/OVLtFVYw1w2rKLBHcd
         eChjD+p31S8H0YFz4q4kTZKr5Wn5+SJeCxfHQDCAvXj8WIarPl9yXefB5XgTaz6hf4F2
         U5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791260695; x=1791865495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uo37arCimajCV353Vnyw49uN/c9H2oi5GOWiIgl7tSY=;
        b=EjuMiZCFxUmR0j6GlKTldZO1pSEpGxlpMMyNjp1APRKprM5uuAfgfEx/sT6Gd3m4vv
         j/V4431r270ljAUPEDmHwp0SVetyRb8vJ0+POK1j5aNVGkR7zxsJ3srrmDd//1pdRLVW
         UeGXEc5F/z9hoLvMSBJKwooOmV2mia9Lt/OGE+5vhdlgfAiuVsz/aEvh2aIjDRGo8e6V
         uhcCWxeIPWXzmOkRKeDibMDR0SHMaxG3MQWBXKUewXVR7VhBsDP/kvAjepAJhbk+V/Cj
         /pc0vfCKSFtPqx1I/WsFWVU1n0vOtKFQ301GSamIVaY5zCfe9dXXBGqlv8xuhmLgj3Q1
         J5kg==
X-Gm-Message-State: AFq9FYKa805wrA8cSs7NJSMlQSniGWhDGzTnfkYYOennvQ6e4mIEvK95
	VqmQb8cFVlOCrOxrMsyl3x5BZieVCJrN7ZXmWJxVmlKd1VvT6Ea0ozkfwHgmSgwWwpjgvD1dc67
	CZ8dUISA=
X-Gm-Gg: AYBFou2Rwx/SCl76Xn3iaIt4R2YGyqzxTKx/GyCDNIds8OszONsDJV4DWyyrU6tms5z
	zPq8f/V3lF3aKHJROoJERxEO477Ln2z9FcFyQxnBSnQk9mZo0d0cXJTtW7DHHVLykfAP0X3okNP
	A2bwx1/jBSc+4qGcOrTuvBcYcO9X3TRx1RLK17A2qv7BN+R8M2uLPKP9sD67syQHTZc0TYlNIW8
	9ZFUbtt+yTj6iTfRWXrJgk+vQ20PS9+sNmu38apjQCJdv0xjZRRKB1JBdUe7v+9b745NtV8wAj1
	7kvgsBN9d6wWMHm6OK6fDjhcdoLpew9x0qIlkVvMv/EDht3DF3YSac9wnsZYiDTuFVck3gBnrqc
	hiy13Bo4UU4JA8Lzb0NRYpqzF/PyNBkXOCY5g48mcSgJ7Myf4pU7ZqplBjCeR/dZjDG6XxAAlUB
	uZmjnJh2C8p2efeuNnhwvkLoNOmWkm2veuxTEx1yRrXuGy6HkB9IWs8ob4LuP2Jm2MXMKuq1Tqf
	jhwByECIzC8f8HFe0e+XjXmvH0K4yUNY+T5flfNldYC9R/V4il7IfSaL8AQ+MrdrxFNk7A=
X-Received: by 2002:a05:693c:83c3:10b0:34c:e77c:f92f with SMTP id 5a478bee46e88-3514e2fbed1mr117620eec.37.1791260694520;
        Mon, 05 Oct 2026 21:24:54 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:74a7:81aa:2e95:53c8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351468b2cfasm4361830eec.2.2026.10.05.21.24.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 21:24:53 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please consider these upstream CVE fixes for 5.10.y through 6.18.y
Date: Tue,  6 Oct 2026 00:24:47 -0400
Message-ID: <20261006042448.93194-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and Sasha,

These eight fixes are in mainline but remain absent from stable trees. 

Released Linux 7.2.9 contains all eight fixes. This request also covers
every gap in the newer supported stable series between each requested
target and 7.2.y.

Could you please queue each commit for the stable series shown?

  79c81d137d36f9635bbcbc3916c0cccb418a61dd (CVE-2023-53651)
    Input: exc3000 - properly stop timer on shutdown
    Target: 5.15.y

  110e70fccce4f22b53986ae797d665ffb1950aa6 (CVE-2023-52561)
    arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as reserved
    Targets: 5.10.y, 5.15.y

  2e4ce62385c1b8a887c5370af058ac7b52a8eaf9 (CVE-2026-89539)
    SUNRPC: reject duplicate CREDS_VALUE options
    Targets: 5.10.y, 5.15.y, 6.1.y, 6.6.y

  5dff41a86377563f7a2b968aae00d25b4ceb37c9 (CVE-2025-38204)
    jfs: fix array-index-out-of-bounds read in add_missing_indices
    Targets: 6.1.y, 6.6.y, 6.12.y

  c6c156d931c33b92362383cf76f6d6e1291dcbfe (CVE-2026-89912)
    KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save
    Targets: 6.6.y, 6.12.y

  11709573cc4e48dc34c80fc7ab9ce5b159e29695 (CVE-2025-40158)
    ipv6: use RCU in ip6_output()
    Target: 6.12.y

  e346ef7bcb137f50c49f969330ab7dcf64ea1654 (CVE-2026-89527)
    svcrdma: Use svc_xprt_put to free listener on create failure
    Targets: 6.12.y, 6.18.y

  5d3cc8e388464f485d0944b87b8f9426e637d082 (CVE-2026-93179)
    drm/amd/powerplay: fix VoltageObjectInfo zero-stride loop and OOB read
    Targets: 5.10.y, 5.15.y, 6.1.y, 6.6.y, 6.12.y, 6.18.y

I used AI assistance to compare the histories, inspect fixes, and run the
application and build checks. I also checked the final list against the
Linux CNA records, released stable histories, stable-queue, and prior
submission tracking.

Assisted-by: LLM

Thanks,
Artem Dinaburg
