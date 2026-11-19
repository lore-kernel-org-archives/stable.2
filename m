Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795108646;
	b=lqPieYbkWaMK22/xn4/Fmh55AQj3TJNSF4SFCeltS0V0XoMM0oaVuNcPBkz1J4IW09uP
	 RSZ896Q4xJRcd+kY08RUC6ehOIFHm7ZBgGv83O/mDTNRSvuVnJ9mOxMEkezcPlOHXxb60
	 VLWqG+Mhz1X2dj/Olfnht/HSJhhbAGT9vgRcCmeKEGZWXPCL7Q+LhZBIDOgbCxQkEn0XG
	 jQxjnWo0YaPg+uqD0EpS1h6GSS2sTKwxI7bsdFzwg0sfnKe5wAd1I6l+5rPT95jjXqdM/
	 MadCUDLIs2UGG7nv4aqFKtRZ7pgL0dzu7K+GmkKz+RxxmIw4KFU97li6NjwqROXLL3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
	b=3nx4BGJGsIKYprGy81bWVx0B2MnTdynV6keSfVoQAlrAebVd84j41AFJFDCUK3EMvxnW
	 StCUZ+hWo2cVuvlFpkIDegexoPR46UcNoqND+rTIQLJQeXNJkY04pjwT+WciHX1ynZK12
	 Qf10WtO/3F80UOw3NwoFjT+kXJ0W2ivafKm+AYcTQ8SuFSr0GK5BOIzJ+cvPo/lYbiqdP
	 qoWIkFjj7HxSBOoscrySxeLHNHQCxvcIg1b7+kP/jafd3kGZ/vKR66ll+K1h9I6DunU3e
	 oXu9W3efJ01iQ5B//nwwAwFw9Pbz8hMBsi/Yeb6L/oIKVcasxmrjhUpA4LYdos0PYeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DOwkiBkF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDEC606A32F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FDEC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DOwkiBkF
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99e0d9b3438so9666241.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:17:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795108645; cv=none;
        d=google.com; s=arc-20260327;
        b=Db81Qf/hgLuVLgJrjUZplU+IIrj6p80HOMSItzaL00A2FE2RxQjGWwf676sFckSgJs
         WsftTDfSAzuUGoIIcnqR0rGg3xxRuHWVklXGwxuvOaNjq6k5F+0PIQ8SgPaKAvNEkW4j
         44uaiRN+lEMFepLGakXU8fXdkti9VD/uNnd7RlRniqlT6Tb8/y/20PcK0zB8p+B2xLfa
         ZdxLtX5dhl0feaV6rQ1dfPuVoAjq/pn05jAUYTykq24OsjMqIt7MRfO7kjL2lxU9aup8
         beMZPRBIEd0T1QSAuNk1MfpRWGOwSBZFjUkbPr2tLnf7khJcxVBo8+BTmZlfDQ2lVcZG
         rW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
        fh=QY6MKDfHbhjcNtA/kfVLGooq97PhahyAtK+gimqShhc=;
        b=i9pdgduNqrg2NpvA6kXrdkkbFwDheCv8R/UaQS+gYR4yZ/rCYNv6dsadnSM99Pl1Fq
         2PlD+3rx3Ngn2hqh7FDHTcFOrw01VgURbGtSylu+ybx70TSWvPTfDxSzUHV3N+/EtWPd
         SGXPqZF+6dzxJ8cXfxbElrZmc/BQ0L8Dc652gjtky0840h7ywv45PN9NbzChUJozWD/w
         qdJlGK06nHUZtshcYO19weAaqbSi9Kvka9FAREEwrWr7DvqDeRIxnWlQJO80EV8lzeKR
         UDJGhUFOTMxkYjoxd04WaY2HIJKazv1FAXETjR7MCzBODhW6FSZ/9gyKOS7L/T4VWHsr
         3+Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108645; x=1795713445; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
        b=DOwkiBkFxu2laaP/PJsF9QKYRNsBJLVyNQ3wVlF5KzOEvDGqC20ani5FWQ58SWt4gA
         MNLgoH00AnUO3gdOaPCf4CCLS1O+1MM9Z7Uyn6GdzmU/7XczKOrNvn2h5DWlX4funW4n
         bareHEw3H9RfVvHTMNU3UWG/SU0hIx/3FdrUv5TVCrjqegozzzh1XCErPF1sQ5LWMwdv
         pVllbqAhd8VO3g89k2GhJCKlUkKJ3AQOX3sX7GSEMpdsFY5HAokn61B9bu2bKoLV+1j6
         DBwqnssUDKblGLMS4hzaJvjTgGTwMUCJQ0Uv2p712xU0rxdtf/CvHV87Le8My6/xip0H
         muTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108645; x=1795713445;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
        b=pLw4Nlx4iSpQ4W/zKI/hOos5OlwtrG7b5upcl6zEQ25xVWH9/hBmgjU8355/BXBXwC
         EnWDfhiVRWkG81es+lGH3zTkLBCV3XsUq/swthcz8LdQbJ7SmNl43VwWoQbhvGy11ksG
         OKpV3ewn7cpsNoXav2z6KfgGnjeCoyhFoYykDNMtd+kWDPrE7cLfrXGingdEJM0m61aw
         s/tp27N4qfwa68viYK2UBiZKnbvUTl+74EuIKpyKp2v8AEcGFfxmTjXPWbZNJcLDW73E
         vqSj9JXjZxrGREvDp5oKRdsbIH0xUtsPoHv6b2SQDrDrhIkH1nxGhC8rGJLVomBpFc+m
         gcGA==
X-Gm-Message-State: APuU4Z8SvCp0I7l6R34kNkE+qk81WjuARAcsnhyssQ5MTA3RYVvZsMGS
	EhiExd1wWIDQ5SjYQHP/q70w/HCz9/raxSV+D1j0uFfSQPKpiIT/AncMCHg+xvmLwBd34R5ScIk
	Tv5l0kbrXqkWREPGmhUMK75sn6bVR7F4aGA49QHwxnvD3
X-Gm-Gg: AYBFou1ICERJwvjPVgbNn7eX8kN20+Ge/Xe7o45X5sNhbptudZyRUZtHtkpabHM1Hot
	e7BC9vjb9wv8JDlQOLEhR6IRx+sHSy5bkbkTeIH4nGV4ktZIDxYa+YbwPBCwoTsQ9bmo/bt4P/Z
	iJmildGSnYrUqDGCRrgSPlKRxwnweCwm+nWNk3h7EHFMMfVPZIIazwQRrTmXVC66kVGugjCV7KV
	VmTlKZQljTF/6rsxuPDMT6PrO4hn/qmDC1mfWnMG1vO4h5MVsfvMEK4rRirJ3tCoIGqQnbGJ3x5
	LuOC+6hMnenJpuA6tf7mtj25T23ayZ+nz+mugwYjpitCQs22K/ny5Qq2YehA9xBCAudDSsZbVVW
	E5dCOHOQUNN1z5YnchbM5fVRiPm0Ib6vxBv0eYnwIfkNHBHZabw/I7BXGjCQ6/N8Ppi8AwH0Ofd
	Twy1gjX3qLgWj3bUWYnKk=
X-Received: by 2002:a05:6102:3ca4:b0:7d2:7266:2c8f with SMTP id
 ada2fe7eead31-7d7395d663emr47788137.23.1795108644793; Thu, 19 Nov 2026
 09:17:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 12:17:13 -0500
X-Gm-Features: AclHuK_wGd5lftye4QEQQKDXm9b57_wmZnMy9eWRumfAlTf97NWJHZg9LoWE3J4
Message-ID: <CAMcAce_iciQJ31U-bmSpTbT61NxYPJNTq2mfcVNvAxMLXa6o2A@mail.gmail.com>
Subject: [PATCH 6.12.y v2] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
To: stable@vger.kernel.org
Cc: sashal@kernel.org, kpsingh@kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 49b18315be4e590fae0fc39c87d46c87e9ec903c ]

bpf_verify_pkcs7_signature() passes the return values of
__bpf_dynptr_data(data_ptr, data_len) and __bpf_dynptr_data(sig_ptr, sig_len)
directly to verify_pkcs7_signature() without checking for NULL. If an
empty/null dynptr or non-linear skb/xdp dynptr is passed, __bpf_dynptr_data()
returns NULL, leading to a NULL pointer dereference in verify_pkcs7_signature().

Check for NULL and return -EINVAL.

[ In 6.12.y, bpf_verify_pkcs7_signature() is located in
  kernel/trace/bpf_trace.c instead of kernel/bpf/helpers.c. Adapt upstream
  commit 49b18315be4e to kernel/trace/bpf_trace.c. ]

Fixes: 9b2d3e911295 ("bpf: Add bpf_verify_pkcs7_signature kfunc")
Signed-off-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Fix diff formatting and line wrapping in patch body.

 kernel/trace/bpf_trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bac2db7..41e237d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1384,8 +1384,13 @@ __bpf_kfunc int
bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,

  data_len = __bpf_dynptr_size(data_ptr);
  data = __bpf_dynptr_data(data_ptr, data_len);
+ if (!data)
+ return -EINVAL;
+
  sig_len = __bpf_dynptr_size(sig_ptr);
  sig = __bpf_dynptr_data(sig_ptr, sig_len);
+ if (!sig)
+ return -EINVAL;

  return verify_pkcs7_signature(data, data_len, sig, sig_len,
       trusted_keyring->key,
-- 
2.56.1
