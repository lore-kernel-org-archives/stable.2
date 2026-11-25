Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620148;
	b=WlpGJ7p1M3BwNOiOMHALYu4Lb+O/XjYSuv7LZoiDDRe0W1JwyenugJr3XM2yWI+ybD1v
	 Id3Pd8YvYiBuIFrwrWe5T4RBpg6AdB2/FwMk8SQlp9A+/c3LEthIfwb6kDR7Lj7IRc9B5
	 KzxGpDMNB4pgag7Pryq6vGMZfhmA7gKQIeV+5TGrlQuqgzHmfjkeqAzVRsn1gXDVqd8xa
	 19u9z8o5u9knnKyJ/Qn9/84FV+7Wm8P0iyCScNEWisu8yJOH+KCY1YgK/ziUoR1DiegRj
	 pQIurxiu50YdXc0Zhjjt8Z9Q2gVfUiaBFt9Mcdtwr6eoNME+h58B2EmfQoHN/TeyMDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZOVH7GPrhhsO60hstl6R1o81Xncu0EyH/gOszIASMlQ=;
	b=HnrFS/ChYMB/bjONQ+oRzNF4bQbqPS5cyX23NOCSBexaQBCniuoSnceUdvSTB0zC1NlR
	 KimikCzFyPIUEvX6BaluP6rjtnMxwUG+mIouaVddIt2Qelr4hhVwdpxP/9o6k26zsgTgN
	 U13wQBWIet3wpsL4XhQuqZZ3KP8KuEcoOjKmYbhV0+eUenNDTbTGa//HbVjP0mxE4LvlT
	 rYJ1C9KDBqM14xmXuxgN3omqYayaDVAAfxAcnu8p7Hn+1ZAjJ8QnuSYZoqMucQysORyRT
	 p0dCxwpXH9ySRkCIcWUlTSHj+a/o/JSDnuqiWPtd80s9v1tm5UZcnR9dL/bGhZxT7wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPmkv8Pe;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A2606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80A2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPmkv8Pe
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so3104049b3a.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620147; x=1796224947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZOVH7GPrhhsO60hstl6R1o81Xncu0EyH/gOszIASMlQ=;
        b=jPmkv8PesLa4C6zoxhIKZOfN+riZ7aay+ijRUaAeWqiffleQuxgF/xyzsGymgLXQ2K
         c2EIOTlZARL2nWO4NDlS5KFLUVw+8/R7GZ/99j8y/7nkSm3U6D60u3omHxRTyvqLImXg
         JPQJjTY71Ss1hSVM7QAe9o7JPiDdmK3mXaGjuyAfvk3Quvf5oAarmN/IvIovCNY728Jw
         f6dvv27kIOTWl/E293jgTa6mkda13TdnSLRd1mG97MZYZDzpox0CNTCoTcCW6aSG95kt
         yAyQ5Tg/CfVRuTFBT5wrGq5LQgvLFvaqQmpgr8lcIK1Rp0r4Pz06lluw6RYeoV9ApWO7
         q6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620147; x=1796224947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOVH7GPrhhsO60hstl6R1o81Xncu0EyH/gOszIASMlQ=;
        b=kuxNH7pxjMtm79Kw0rbTj1UlKI0ms47sjs0hWKToyZPo2jEF0G4jtdVDFljkvVUFgy
         oANGw3WSCS2xX6FwWrhQMUlSbSsXgyLlNbOEB5Tciqtr65bUmuTcVlT7DnES2ixtAf9b
         dHfpNwuZSgvqdx/LkXpC9ttSmjhYgXRAtZYrvCwxxCd2rGh2ss/BW8wteuz8fLenQeiy
         c9MtcE+7Q6bBhoRlHZuiJIjcb8GQbfwcdPfrnuNtH2SgrLWLtajRxjN8N67t6k9FuPU5
         rYnfvw/WEuuDLCdAK9pCqoQQ+4FYT293eAGUQly+T9uOTnDbl2JkFu+CjYBIu2Bq+tOY
         LjuA==
X-Forwarded-Encrypted: i=1; AL+hErHOPTkhp9a6lGv4asSknVcWIFJBS2s4+66a0kuK5rDjSRFMvlvl76jOsYMWo01ZgvE70ziRfQM=@vger.kernel.org
X-Gm-Message-State: APuU4Z++r8LvFHMZdG9oWEkT6unfkWk1VKx4ESPtmrLgX2Ze4vE+qBKd
	w6lkC+442cGCFcPtS7fJXedIPJ+jUFCIoS/ZFfKTLc/oOrBO3JpugrA3
X-Gm-Gg: AZFdTZe7Igge4yAqWu02/HxvtAcGWt0D4GcKHe8fPh840+PQ3TB6EuqbuW+uB00bnTO
	l4SPmMmxcgFSBMowcBQeukNAIzy3YMoG68Y4uKNYlnOsXChsk0HURTzyOAD+Zqf3bfjbWsHWx1h
	n/higw/5z1P875NCEC+t7nhfTZtN6KFitj8J5iv1a32aUkERehzRqUmhA3iExkocTKlW0vR9sA1
	0FO9nKmb21HRiWM4T4kYthXE8w5mE/gnkEWNmnmxjgm5myKlNCVGRtuS0cJR9NhPlvzxE6RxiMc
	G8u1PiWkvPHKJXfXpoeN0QN11NglPQpONqFioNXsfZdoLhKJuB1S2UU2oVLW6Jz1eogh388Oaw1
	v+tdmjKRWps5eOSMo+MLaT2BDh9v4DOPGnuXZEg3/Z4Y5RqhWGZ4NWhVWCuFN/eyVuR4zLzgg2m
	JvVwWsHmGVTCqK48iUIdFYOM9YmL0k7XmLgTM7rFdwGUioPTb06FcGMZlpropdU8LFw9W0bqVP/
	UnxEda0A9F91h7T6cjSQ16MikaeCU+s1VfeqnnyxRmGk8Y93ZU9mPzt4GxiSdTSUfkjA96Xz44Z
	2SprmB2aHxTu6+F/UrpKoKxD
X-Received: by 2002:a05:6a00:348f:b0:88d:3f61:20e9 with SMTP id d2e1a72fcca58-8c87d124ee2mr13760222b3a.48.1795620146973;
        Wed, 25 Nov 2026 07:22:26 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm9221775b3a.8.2026.11.25.07.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:22:26 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/2] Bluetooth: RFCOMM: Fix listener shutdown and TTY setup
Date: Wed, 25 Nov 2026 23:22:16 +0800
Message-Id: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found that an RFCOMM socket can still start listening after
shutdown, allowing release to skip accept queue cleanup. Reject
listen after shutdown.

The review also found that failed TTY registration can leave a
transferred DLC open. Close the DLC before dropping the port
references and purge pending input when the port is destroyed. Use
the existing RFCOMM_CONNINFO locking to avoid waiting for the socket
lock while holding global locks during handoff.

Cen Zhang (2):
  Bluetooth: RFCOMM: Reject listen after socket shutdown
  Bluetooth: RFCOMM: Close DLC on TTY registration failure

 net/bluetooth/rfcomm/sock.c |  2 +-
 net/bluetooth/rfcomm/tty.c  | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)


base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00

---
