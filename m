Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078F367F3A
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789327354; cv=none; b=lohXD3WlKBfdRbB0C/sX2ZERvNOVdja7o0P2L9f4bMePJCdiTbK4zoFxJq+Akz4RUIVlkGl8o44pOyTw1vV/MLw0SseYVU4xq8ZR87CoWAPNwV/Qe9+Bp/hooLppltC5jRQzZK0JXdDEAcKotoI7dY9QjnlxdBkBC48OVPtv5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789327354; c=relaxed/simple;
	bh=qQilx/XJAAeSEVVpMCFNrvnuxibowI9VFpjoi7rJZoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bvf+O4+o7tI4jO8DlvL19DcE0Mcl9MzM4KLYEGt3gBMgsAbOsp1ww9oaq6Aws/odHoc9R4cstZPAYUm6C04hrZxD2iLANxwgjMwy1Lfe9NSf0GpdPN4UXsRymrJ1Q1qoxM3lp/0l9tV7t1UPmgBjJ05MUm2b2RWszvXVcK8RJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH83cDMq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH83cDMq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-486e70f2457so1243016f8f.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789327351; x=1789932151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQilx/XJAAeSEVVpMCFNrvnuxibowI9VFpjoi7rJZoQ=;
        b=eH83cDMqaUYlMrinv4dVl580L4XIR+uXF4lLqz1o2baJyhAIOKM+2av51Jml1dDUjI
         2BoJrm+BIxHUUCQzVobd9FGg5PmuZbS4j2edhNsZSln7BjlXQKIpMCJU5I+ICzv0mOND
         Sj80yd+YI8YOjUZ6MLnxZRb2X0ybu09N7SwTsYJxsD5nshqYDvs+cuD+1ttU2UK/OKKF
         vH795OYUbp1lFumG32WMhUYX8yYBoQN85cpP9+hRf37qyLakSzl071AEkAdM6bWLu5Zr
         ngYEJ2bTzA6xEUwQFrmwXK5OeyvJ1D6xAhRArPRvAghHAZO8+Vs48IpsizIZi79xeNIX
         QH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789327351; x=1789932151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qQilx/XJAAeSEVVpMCFNrvnuxibowI9VFpjoi7rJZoQ=;
        b=A4IAb7A/LHPy3/8gEM+Q6HVZOfm7XLEOYbGRI9fP/t6el7beij+GQit3Ir8ohynrvN
         83Cv9DthPDl02C//RWFMTjNvICAmnHtzmq3gFl4ToeSiTGsVGp59Gn0/M2A8A5+Y3zW+
         JG+eZ/k8qRKmqFiz8WWDVltaukUyhDceJDPXcgVOKgmnjB4MO97NAFVARnsr8uaqSCPB
         VW4qWkumUjF84t9XUvH1QDlwItYkH6FTxrTxrBeCj1MtARGZF6qllhtCUDgwm6a5jgSA
         ljY7RcJS1CDbSrDzhNwW3KTHHxQwzEXgkS4wTCLPBgi/MUIixYCJ5wnxIHJMYFeYE/SW
         bUXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOgOVdrtI47UK5LPy5I9sEZLmVNCYmDWH9STx+6B20dtUegum7SKkDega15BlmM++7nG0r1mM=@vger.kernel.org
X-Gm-Message-State: AFuF++lpE6U+NzItXZXyENmm0k/GKxNko2CEtU8IGjXD6VxEKUTUS113
	k+1hCo2WU+dP9n70hVQSXqiqy5o7WSbV5GRQUV2NlWVeNCZQLf0vkCkC
X-Gm-Gg: AYBFou3GVhXUsxzfzXf/dkWOYANd9QDZ+GaVzgq50Q2HogQCRp3OKEuqZ5bTxI1aBRz
	tnmWqxFXl838++jEod91uL0YbSfNYtzlj1aWtc01d4552Il3cA7aaKeOQE1qjCMz1+3NAfYyWYS
	uCC3W3Lu2MxmcswjSv5UVynTtt5p82TdPU+ETWiYcvWbtWgdyxCYUNUoswQXrcYvpYj9IdvvaJw
	e0wKozJ/NiD2kik3fQ6wBgxoiU7dPZKt8CMIW7TfqL6NpsF3+gHIZklM/6e+NtFnEyueX9/TBp6
	hcXtdVp1GCGaWXDMXlrwuITmB/x9r9MmeTScVmamk/xkGTJUX1HbustlWDJ1Dpy0S+Y9p4HLmYa
	5oNoMWsqar5+iGvWlN4LjqXA75V0Fj1WiLinKxuJbHwsbyTBZ4RHfqSWMLOZuT0PFz1LIvJA5eh
	L9wwn4+7jU/gk+Ts1iHdAyZWdpd3vmaHzMATfBebmb0kVBH6cvpdTtcKtnMvz3fgNY9cBGFGzJS
	chtsTnHrZRkv8F8Tw4yroPzHjVRJVSbbzHxUiRTQ1X2p3Us01FXPgoilgeecx0GPN8zyBfp/HyP
	bOOhPyufeHroMcVO0mNFpNZx1oef6ipLTY2JEO6u6oRgHcvzO51xhA24F0GrNgCsQKq2JkdzzaW
	lfw==
X-Received: by 2002:a05:6000:25fc:b0:486:fc00:b0db with SMTP id ffacd0b85a97d-486fc00b1f8mr4127609f8f.30.1789327350656;
        Sun, 13 Sep 2026 12:22:30 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb359f38sm19681970f8f.30.2026.09.13.12.22.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 12:22:30 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 0787/1424] bpf: Sync tail_call_reachable with callee state on entry
Date: Sun, 13 Sep 2026 21:22:24 +0200
Message-Id: <20260913192224.2361-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065624.923073650@linuxfoundation.org>
References: <20260912065607.279695368@linuxfoundation.org> <20260912065624.923073650@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless a 6.6 backport of upstream commit
54c27ea6dadb ("bpf: Fix tail_call_reachable leak") can also be included.

This patch resets tail_call_reachable on callee entry, but 6.6 lacks the
parent-state restoration it relies on. Returning from a clean callee can
leave the root program falsely unmarked and make the x86 JIT omit required
tail-call counter handling.

I reproduced this on 6.6.157-rc1 in QEMU: Linux permits 33 successful tail
calls, so the test must stop after 34 program entries including the initial
invocation. The unmodified rc1 reached 35, bypassing the limit.

With the applicable 54c27ea6dadb hunk applied, the same test stopped at the
expected 34 entries.

Thanks,
Karl
