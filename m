Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176E400DE1
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221108; cv=none; b=SIxjg94UzWyi2bbDspehdf4YYLGguc29DPx9gPKKAnaQTIHaI/vSk4tW7phvMPdq7snZo7syizFz6MzAx1+FsDfrnmwioHU850aXGMzPDbXBBX8w50wcMWdJLHaYi4Cn1WOzjxoDRbOAbV5lCeVIqB2CLxyUakloPMhO2qq4mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221108; c=relaxed/simple;
	bh=8MasO+dXRse9oNs8G6DKM2d+FNiyDBA15XhW4S0ONo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmwWpXj5WlMnWKIQojoo1gufTe30DxwnxNLPVyC1ToK4LCXEdzg9lhTtKIih6kzm2yGWTvuYRiKOsGOXD6HiZOe3JnkQ0Wli5rU0JrBBAZHt1gxglrUCGnZWZAZA+hhUO7SC+cERHD3RhretsYoWyfIoi++Whre3GtrR7fTE73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWZSoTg2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWZSoTg2"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so2453434a91.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787221100; x=1787825900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8MasO+dXRse9oNs8G6DKM2d+FNiyDBA15XhW4S0ONo8=;
        b=sWZSoTg2s+VBTR52EKuq8Tbyybd+SK8273NDcb7IGm0bbNbS9qoCd9HjgmauqeEBYC
         Uclvcx9GylpMI4Hq2oh9nphRNdc4In646qItfdS2gHAKQxd77/TVTTW0mp7ecazD0bfX
         wn0GpMIbJmcL+JZ+9+CdjQXslKrcOaVVwOQMGRtnpFqPcy6Uc5VrCw8MpmUpJJ+WyUlj
         +UKZr/BVfo+9IOpRUOIvbYB8VB7FyThdPtMAE807JRt6oTI1WWkI3WYiRYjnqs7OWibg
         01Qo5RIVIJawtotBqPc5lPo8xDT/sJnUWDlvJqO5H1Fl5xxMru1TiG1ZFCr9SQDdqFl/
         YsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221100; x=1787825900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8MasO+dXRse9oNs8G6DKM2d+FNiyDBA15XhW4S0ONo8=;
        b=miuQJtwzqyMfU68NnDofR5BqHWBp8D5EH6oVEkZ+r3VRNyMA0kR5wDKLRe9hBCsmH7
         sjhViqs9f+UYlnjOVq6ciYBgqHu+VozEI+bp/H2fo81Vy9qIzboqVai/8HAkjfRtjEY7
         s3kYY+RfJf+Pse6wI+RWbybRY7JaQlcVpkOKBJ+phMJUQ6eFRHWoJh2YdRhpTR1i4jYC
         Bp8CmIMf/nCVMubXHp2mJPRSYgVCi7hRm8FHsniEfexqr9FFGHdQINDo0wz0rvJKy07M
         1Te6cHpsyTHSPe324qODuSofl5MD4ur3awCH7u8NOhBs5pi6nsypcT9YKVScQavAoH9k
         /SKg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4R+ZIe1qMnJqNFuzAFIb6EJfaR4sgsiN4cvoOGsEOTDXEXMsvAGMso52W7+PhnxueUqn7sSM=@vger.kernel.org
X-Gm-Message-State: AFuF++n/SvthWCsmEYxzxkito/JblGC9KBiFWeBuPSq5CU8tBlJhu8Vm
	+PyihFnxfH0rFmLDGjDfYZFqFQtxZas0BaQ242mPSwWVkqAutPt61KIX
X-Gm-Gg: AR+sD10MWrCNnr5g4d5msduKyGsxYqc3YmujvriufXNE5v8P7jH75e9w0lTJd0JvyQb
	tBTNmn+PiyWNXh0ek3uPBaia1HLtaGUHFi8VObYtKQZf2MElmpIbKSaPcHWIAUHpdZJq9glh00P
	7U/26eGrMeEwWgvZc0uvkWBElbyqOjzq8iw8nnGFBCE5ruypvJJ/u5yTCBOKSd5ptmDV6gllau3
	4x4NmK6D5W/OFmoF/ZajIOYc6wzhO+l9MgLBOEuNgYwrNH10wk+4oU835mcrjGtacuZdRIIRT0g
	Wre3bnrUNXQ+nH0QDEdYvHllzG22eZnovYRerT0xZta9qhtinBKw6jJ1RtSGQ6hqaGxBTZRyoo5
	3DtfSyP5otXV03gi5BMT64QJyIf4Q30xE8D/tuuWTknz4ClTDIb/kCximSHr3dq6ZZ6LYPmRdUa
	OzuYEoB7iKHbYxgPM9odfUgV6lAsTzMrO3QV+syh48njVCgOkXCf34subTg0xUXe7xGqANUWQ=
X-Received: by 2002:a17:90b:4a4b:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-3958054b82bmr19417140a91.0.1787221100254;
        Thu, 20 Aug 2026 03:18:20 -0700 (PDT)
Received: from Default ([2409:40f4:1024:6824:6cd5:fefe:4ae2:d94b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c3fc6675sm22408447eec.13.2026.08.20.03.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:18:19 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: jeffinphilip14@gmail.com
Cc: gregkh@linuxfoundation.org,
	i@zenithal.me,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	valentina.manea.m@gmail.com
Subject: [PATCH v3 0/2] usbip: usbip_host: remove legacy rebind_store in favor of drivers_probe
Date: Thu, 20 Aug 2026 15:48:00 +0530
Message-ID: <20260820101800.14650-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811160541.29461-1-jeffinphilip14@gmail.com>
References: <20260811160541.29461-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Aug 2026 21:35:39 +0530, Jeffin Philip wrote:
>do_rebind, which sleeps normally gets a mutex lock. However, it does not
>or should I say, cannot check for null udev between spin lock dropped in
>rebind_store and entering do_rebind. This is a potential race window
>already. So, even if we check for null udev under spinlock, we cannot do
>it outside. Regarding do_rebind, it is called during stub_device_rebind,
>but that function is called during module exit when all files are removed.
>So, do_rebind is not designed to work in a concurrent environment in the
>first place.
>
>We have a safer function that can already do what do_rebind does,
>drivers_probe. So, we use drivers_probe to rebind the device rather than
>use rebind_store.
>
>usbip tool references this function immediately after the device is unbound,
>which is safe for the tool itself but since we opted for drivers_probe, fix
>it by using drivers_probe rather than rebind_store after unbinding device
>which is more safer.
>
>Tested and working in both userspace via the tool and manually echoing
>the busid in the related nodes. rebind node is still left active with a
>warning to use drivers_probe upon encountering rebind_store.

Friendly ping. Let me know if you want me to change anything.

Thanks,
Jeffin.
