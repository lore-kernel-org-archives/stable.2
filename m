Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914127;
	b=Ag3286gmtFgZImJzoGuAwmraQZHDZNZMI2aqIVlsvG3fV5tTj3f9bXFCG12EaKBvMddj
	 7N6t9WtkdTwgdkENuZBu5/M0dpgr1XMV+As/PMOezZuqhXgqNdx3ZxsdMCF+btV8vDSVC
	 snhTTAf15vhiZ3tjd1CEE6hmJFuKFn4p5wJHrrmUkYjxY0uHjqAzCpFHu/Kj0XOXW74sQ
	 ZV48ssygfsTOeQsA3hCfHsLxP6atO78JtzYZwO9NOsqQIsfK6caFHFdPm5Fum0Oa0AzfO
	 Md1HgheCGTqMtHmM/KEGv8bHjzhb5uaGXV3ECUp45SiTCWz2AjDhxzQYfchn7/9Xwmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=R9thyVNeFK9yczHShfvrLBM/SBStk1V4iKn/81Hubf8=;
	b=AxLK111Js/KaO3D1GvDmcIcj5elbX5UCRMIAWfnEU036Pl/FfYrEwlmh6+l4hBVKUBl5
	 PaxI+AeJTE/tLLgKWKcH6QyLPpI7Lk9+mQaXwf2mVy6vz3Psz25T0R/XU4xmGvGAi40I0
	 tjlD1OkWreYLEFQScLNu7ZlSMIQKnhOrao9mpItCoeiw+aeVF4F6NmNOK3Q4tUClu7zfU
	 gyH6RrV4IPCSkT+bxgaYEzVdruK31BU4M8kRy6LZ36qXe0lviT8Uo6KpsK5Sn+t9wnVOy
	 90r8+fEnaYrPvTT3ueq057fBcHZxMEM8dQQ+6rgOjJg1d2225Rv9di3HO2MU3BnWE5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=4aKx9RlU;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98225606A33D
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98225606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=4aKx9RlU
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so18541195e9.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 03:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794914125; x=1795518925; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R9thyVNeFK9yczHShfvrLBM/SBStk1V4iKn/81Hubf8=;
        b=4aKx9RlUXMeXqBBpugMtt6aua/VZYGgaTWsQW4rgrUDb3/wXxshenWwlT9HKsR/LI3
         vNZ6UrqNsIEgMm5BNWZUbJbcTRuiR+ZLOKRLxdrLIVYZfJKjagx5dcdYfRb5HLT32NBW
         tbxSGcYkz8Ab3/fh1EwVJBHOc7vc9HVQzArIr4yiVwvb1vL/ivcorBFfV6X8Vmk+pOSp
         Rm8dHwUDbRKmjP4+lmSjzXfGTp8VzGuYuZeTaj+gBpzB0KQa2d/m479CzHCNCQBRts7k
         OCe4CyZy3ZBNw8Ta6g26lBTo7avcCu+Gd52QdNgCcpOqd1O3X4/GlAdRuxYlK3ZlLTHm
         8vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794914125; x=1795518925;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R9thyVNeFK9yczHShfvrLBM/SBStk1V4iKn/81Hubf8=;
        b=euUnPx6hlV1mAg6kJCAVEedSaL/5hH4lDm8TST1Em8mLpmumdYcJIzcltBpFo2u0fq
         WwtE7VWBPuH+b9epcTC7W4MxVva3B/0yNMgmAfzaWKYTsl5IvlaUBj8hI6fejOZBjmRS
         v6YQnnvJzD8XjIi7SNuQC+DjyFu6FQ1GlH5aLODRGQXbvBlhY/2B1qKWYHExWnJTcz3T
         OoyhnbFY914gBxpui2CBT4pEgle+VJlk2FWPclCP0+TgBiVuK7SjxGeGBiQt856YXOUz
         e7Kc6gk8Nc2kqreaiPCr89ywk1098J7Fi+BwJdL2CwNT78l4KbgptdUNhYG12/gmaKyj
         95Qg==
X-Forwarded-Encrypted: i=1; AL+hErFleJXfV95gtsfxEcWS+/+EjS1B7vn/WzzhLHwk13fdpTuhBT1lKal5/cDigax5T09+5yhThIU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qmPwxGB6J8A0d58GaAyEU0QxG0sguD9nQMw2P2Wu1VOZ7B+im
	yPita68U99NLGXOcP4Pep3a9s52zV3S3gkEyh1SWwsQcKLjIAIAKcv8Nh8IOdW8FoA1f7l/36A1
	oBT2b
X-Gm-Gg: AYBFou0/8d1/YvFIXV8F46wp4IJaNbl4U8rq0GMZUp27Mfa2qzc2+cCzIzVZUGX62UH
	lthJnpVDGGxr+6HAjj6EN7c45qUXqC6631im2vfTMcaPaMbv7jzhPwGlZu8R9zFzLeizFstQEAC
	sBqHaTn0rANZauhKoQHzWHOVdAAGO2TsZZ7ouggVww69Igsa3R90/9Pdlt232rBoCscX+EtvZD1
	GTSye+62uYeimQ9qxeAVTntZai1Mw+PhuoypPY/DyOI+tZu6yvKZ0EOXxg9LG3kNaMEv6tA9+y0
	AiP+Fm84Rz1exVR/kZU43avG87dXzovXwq6q9RYzoujlm9POIUuNVXxCKfeL51/pQgTINxdx474
	EH5joxTCLZBi4SWZPbyHf3/lRFg0obrfZl6fCzLfgV7SIy2drDHb728kNhrrQMsjAnAvlSXvBes
	Gv1GyQAUgTY6NhwTcQlVdQ1v9SuLzQuAnqiRCsB9kXYWPST/obpdsKXgnUguaFr21j1fy8HNkMx
	6Pd/bskaM8kjYgTu/dAYBCGHnNTpxNDpiCFftrnxsQ4zDTcxlzbpWMcSZF7S8Mm8VXsCR2RxTr6
	8el84xL7843/su8lxr4Btj5DnjnwX0npxyZLqGBh9gwueuo2p9/H2wVc9ZBBN6GRSgWvnQ/SXmp
	A+PDS2ZnjrO0=
X-Received: by 2002:a05:600c:638e:b0:4bb:5bf3:8ee9 with SMTP id 5b1f17b1804b1-4bb5bf390e3mr260911265e9.31.1794914124967;
        Tue, 17 Nov 2026 03:15:24 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8220sm59773745e9.5.2026.11.17.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:15:24 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/3] usb: typec: tcpm: Fixes for talking to the cable plug
 as a VCONN source
Date: Tue, 17 Nov 2026 15:15:14 +0400
Message-Id: <20261117-tcpm-soft-reset-sop-v1-0-c7e1543828c0@flipper.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB0wqQbbq4gLEyftCNWQiUUQ7
 26qu/ct3r+DUGQSeBU7RPqx8DJnqLIA9xnmNyGP2aArbZSqakwufFEWnzCSUMoz4NPYelCN8a1
 +QH6GSJ63q9r1t2W1E7n0T8FxnFCtlG93AAAA
X-Change-ID: 20261104-tcpm-soft-reset-sop-96b4a156f823
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 RD Babiera <rdbabiera@google.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-usb@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=alchark@flipper.net;
 h=from:subject:message-id; bh=gHWuQ7jOWigjSvi21cvS3TrAf1L0yhsS2pG75G68CDQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT9MfdSbKtsaeHVTFRYKRrDb8sXtewzZ6X3ldfhVSaMu
 elNdXIdE1kYxLgYLMUUWeZ+W2I71Yhv1i4Pj68wc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 kY6xjhEDF6cATPX6eEaGKSs41yzd+aPk34c1wQI6FlLfJBwF3wXneDusfTpdmF3pJyPDldfLW3v
 0Db3DDexnTlbtvb74U+f7PbE5X7wTZnd7eRjyAgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

When a TCPM port is the VCONN source, its exchanges with the cable plug
on SOP' can leave state behind that later affects the port partner.

Patch 1 fixes a Soft_Reset meant for the port partner being sent to the
cable plug after any SOP' VDM, which left a source without a contract
until unplugged.

Patch 2 fixes SRC_VDM_IDENTITY_REQUEST: it either replays
Source_Capabilities after the first contract, or stalls until a Hard
Reset if the cable plug NAKs or never answers.

Patch 3 is hardening rather than a fix for any known device: it keeps
messages from a cable plug that breaks the rules from reaching the port
partner's handlers.

The first two carry Fixes: tags and are meant for stable. They are
independent of each other and of patch 3.

Tested on two FUSB302B ports (RK3576), source to sink through an
e-marked cable, plus injected cable plug answers (ACK, NAK,
Not_Supported, none) and stray SOP' messages.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (3):
      usb: typec: tcpm: Keep the Soft_Reset target apart from the VDM one
      usb: typec: tcpm: Leave SRC_VDM_IDENTITY_REQUEST whatever the cable answers
      usb: typec: tcpm: Keep cable plug messages away from the port partner

 drivers/usb/typec/tcpm/tcpm.c | 94 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 15 deletions(-)
---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261104-tcpm-soft-reset-sop-96b4a156f823

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

