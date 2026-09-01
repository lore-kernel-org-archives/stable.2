Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92253D9DC5
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267997; cv=none; b=B3VMlb1v7ERKaB1MPOy731DrsUnKfjd0Z7KsKIjFmbWsrmSPLU7luLXn+AupcJjNylWxDPU9WFKRHRiPFn+nY0Nop8U2+4VAM29cnC51XUmGv1vfWXseocJLfKbpfhcM2q5M/u49PYOjTBzqqKtCOlVOPaK9NH+4HT8J+OyZk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267997; c=relaxed/simple;
	bh=+aSS3GsUC+5ykoHOso9YQs/0VWovAtIdiffXxIc9lCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sr1VxHxd7Etb/uNbPpYOx66Z1kwu/crIcdPoPjBwv6bpjcHYjcwI/2j20+y3LpwVY32sZk5I3DgIijUTCK/7tHxY9EguForwhTP6S3PTTLq/4CgKVhwTSkMb5pF9XRXv5jHzI3FZ1oKs4S0U2xrLn8hENkyfTHIvXu4fOWAvYqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLliAHWA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLliAHWA"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8615bb9d857so7755027b3.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267995; x=1788872795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/VKJC3MqZBrocLkf3UenbeidJdbk9BN7cs7RjfXB2Q=;
        b=bLliAHWAROTalquPY8T8YzaXupd8fBk+hx/8ptRKzbN8E5Ss8rUlx4MEROXzn0cPMT
         H+yBc3Q9QGFpC6GQdpV8MdWfEljWDP1bpWRClnijKlP7FwugWjzRMPTQZAfbVhlDSrHR
         I6MzyH24FCTFf1vnflWPiKlDaSdLjipH37euz0OhnxxwvFJt8sX9KIiGTPXO2/vOo9w8
         tgEOcz6Fp51Xa86k7BQtx3n2w9uaqvx3d/YvfhrKQe3q9lD68jen4f1mu7Tq6XFIPEAo
         u6ZNI9FYkvtYOXzB7Pr0SUz7FCxIiK3yZKW8UCnSItNqqG6NUBvyicHUcaX1Cu5f9zS6
         rTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267995; x=1788872795;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3/VKJC3MqZBrocLkf3UenbeidJdbk9BN7cs7RjfXB2Q=;
        b=aG3uXbW8krvdIrkuZXR36TXTJr/giFNPcGAJ9Ori19MvtMG0HGvcgcQRRZsm4f9te6
         MfNw6XuNXA7Bc9G9Chvk/OW8tL6kLNT+8AtYYCoHZ7RIXSJV0NZi1jZHUDXNXciJTy/Z
         bsZYH1A+rvecCbwCZbeDB2bt3Ihe/asE7a7QuvizL7W1jopGlJR4RYKAiygx1lu6KBCo
         zxl6WSrGBQ8DrcpEGCTtezjWf7wt8i4jugk+TP77ZIZzvvf6k9Vd01DTl2fgBBdmcC5A
         L5qmJ6VHE9wfOL1bf+1x6KUJ2HAbLHi000ocIKBq4OdEhOKhPg9HZq3bgfaXuK6zCLeW
         fzPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjK8wV4grNwDRZNaMwJXDSvedLxK6npvNc5x7hvhApkXVXZPYuv2g9VCDRz02slYZfOzptV30=@vger.kernel.org
X-Gm-Message-State: AFuF++lREmo6IMHU5h7ZZ4VSklBKYn4B3XXlXyYm39zuu/+CLrOnJspF
	hqE9EdVFavfQTKUJfQThbC/rePQ4dzbn/NdDkwbYYljD6SUBd6cfJGM5
X-Gm-Gg: AYBFou3BDZN9ayEkTYIfYDbQ3P1ClhpfeoQcF6Y8mY+nGbSox31EZ9293wul3K86172
	H1AiM4+rbRUBdGoGYSW2rP7vjmcrgGCYaygkzHTCfToRA5oRfQkh92soBF4tp9fybDhoBZtxhRh
	R1SIZbwdlIMpKRId9+pqFMONufmMQoW76HFszmkqAap49IalCY2zpPYC1s6B1Ie8DJZbbGrsevJ
	r97geIxCnpMGt/4aAaBxB9cgPyU2puKyFLXGj+4yUcjFSHrSLzRqrmiVpRjKJYYn3cpc5msC2rR
	JVrUp04BNuOG+d9ej/6O9DvJ6vy4j7QFVnyuosOaFFbDYo922s0Mtjw4jEb8h4hd0PZ2pt1BhDS
	mAxUrDQViavWXwbLPx/r34tYU2U7HLP1xwYalLj84TxVQa/Ry+pSuWehqSLmUrgJDSju+4AQ6pC
	rWrae4UreC3wm695B8Jqw0EjvRBvfH0QQ+snMyDr7KlDCzBlXbwR1JeLzTvQ6k9BwQ
X-Received: by 2002:a05:690c:f:b0:866:4769:d60d with SMTP id 00721157ae682-86647793634mr55746487b3.22.1788267994609;
        Tue, 01 Sep 2026 06:06:34 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1cd5bsm73290547b3.17.2026.09.01.06.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:06:34 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH 0/2] Input: fix two kernel stack disclosures via ioctl
Date: Tue,  1 Sep 2026 10:06:26 -0300
Message-ID: <20260901130629.24078-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two places in the input layer copy a user supplied, possibly short
buffer into an uninitialized on-stack structure and then keep the whole
structure, including the part that was never written. In both cases the
stale stack bytes can be read back from userspace.

Patch 1: EVIOCSABS copies min(_IOC_SIZE(cmd), sizeof(struct
input_absinfo)) bytes into an uninitialized struct and stores the result
in dev->absinfo[]. EVIOCGABS returns it. Only the resolution field is
currently cleared for short sizes.

Patch 2: the compat path of input_ff_effect_from_user() aliases the
native struct ff_effect with the smaller struct ff_effect_compat and
copies only the compat sized prefix, leaving the tail untouched.
input_ff_upload() stores the full structure, which a uinput based force
feedback daemon can read back via UI_BEGIN_FF_UPLOAD.

Both are fixed by zeroing the structure before the copy. The patches are
independent of each other.

Compile tested on x86_64 with CONFIG_INPUT_EVDEV, CONFIG_INPUT_UINPUT
and CONFIG_IA32_EMULATION enabled.

Iván Ezequiel Rodriguez (2):
  Input: evdev: zero absinfo before partial copy in EVIOCSABS
  Input: zero ff_effect before compat copy in input_ff_effect_from_user

 drivers/input/evdev.c        | 2 ++
 drivers/input/input-compat.c | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.43.0

