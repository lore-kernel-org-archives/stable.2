Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7A4E50AA
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171875; cv=none; b=cQ3VX2WhS8kk7ElGsRZuhTz4dJFd5CjSh8y4buT6APcngT5sZ6/M6ATZtyTDuI9qE3EouoD87gwAV+aBICEUYXZArNhQbw9HiUONEE5ACZqs37oTA0XN2oTeqsTd6rfuKWu0ubNoXEcXsu83xcv2jJuTaK32kksgh0ivOv2t8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171875; c=relaxed/simple;
	bh=GS/EYR98hY2wryjgXLxl9nwG+m2ja9oOJZKWvsufTwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aikLmcSYDuHE0pzFmUA9FZO5364CXI9RZEVDxX1fH49iZOP/WNeUuc3CcSb76EZlwqOhKhDQEFAvAxCxUHRBIAs3sxpp1uoSnEUqToZvl3B7l3Nb83BMqFszwL9CcXOWbjTHKTwxndAbpTqTB/h9X5HP/YCSQQ/IFnzZO3BM2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgj8YaVP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgj8YaVP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e76469b93so14009885a.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171873; x=1792776673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TReqZzgYDqKUCRA8nMpcehhIY4deNasK2PBu/OtaUHI=;
        b=rgj8YaVPjyJJe2jhDcK+nRaeEgbVLVGUvEYtFIvCjOrfs1eq6SWIxYIQSLzSme6iTz
         EQU3r+m/SQz6xahvsEF4BPGLJQMnaulTfqKbu/SvjHn9o81UbNt4iuRyxJQfRU1krEmJ
         2pVryk5/vdZXS5uEqVqWJYGPgtW/svQ7SlVdBhK7e+6FTuBYPvEerPOsHVdTo5Ngv8q+
         FpJv7wTA8o68f+uuEjoObaehGZ8VGgTJ6pZIWJ/qFVf5RsI/elqulmzdIDxSqyUpNNcq
         cxAKL7XQn+b5tcLjXO9ciXrSdR0I7UjN9IGA0kyUP9likfUIVC/Wbyoi74Xk8Auod6Q2
         X26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171873; x=1792776673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TReqZzgYDqKUCRA8nMpcehhIY4deNasK2PBu/OtaUHI=;
        b=EX1HZn0XsQoNn9x8pVjYXJ6Scw4/h0eMvtqwv+Ux+aNSt/6bPt0PnlqSLHZAsKOJhR
         1wVFjO1yzZQanrUtNek4wDTQ0LxYohvEXhS6A2aSNNxyXb+Kyfy7X03CdtMoON1ludVz
         zimWToaT3+qUxKb0s4Qv6OdYOvy7r/bA1JtKOllNNdkbPFS/+zpQCGK9rglxyOkDnDMR
         Jl7IliKrEd4yq92JGOG+geUMiHMfUGxfiGf3aAYvSQ+KQ7fDaRxaNkVegozCZ+A703NA
         zecIT9OEMZiASun5ESNGRuFW8/hVV+f+n0/MZPNXNdzTZtj9sMUVxvS9WYreSpudwt5H
         RMYw==
X-Forwarded-Encrypted: i=1; AKwUvByq7+LYTyyhQpZqEnGIE15TQMrKtGc/lrKNhIwB2t/YDwu271zUIAtA9QEpA1TKL0VJ67Uiqes=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+tjionWsIuHr9FsIWzBySn0OhEr1pDHTj9CkWbhiwOnazQhI8
	3A0tOTOM+KzPAMvFHxrtS9mEN6LUPEOgXX7f8xxX2tKj3xOCUaPapTbB63GK8FuSF+Y=
X-Gm-Gg: AYBFou3BqTCi9zrZ5LpZnB9WRBB+gJp4uhYcKqmNAJWyvenexISYdM5XMI/TOtkR/Lm
	kqoJRqnUHFje4/NZtOtbvnN30ddW3+Mnl2YYrmzTRr/Z8ayxJEBWDOMbQGjPrmEGaWsWqN2XyV2
	JQtrk5zkHmHGNQ+VmMfEZN6sq0JduL2K/zLdOtWV//uwB4oSV2Zl2KxE3VBZHqDtILu6o2D3FVw
	ThxH3AQgTrf3hB5DKH/OXH3UwVW1jFvHW8x2hrXJC10FjofKFggwgLwofj6a8RSNVMaa5kpuv4T
	3mqpTW75CHc49CMPGgKHEXVf5ZkNnUEZ+fnLGqIF0ivsD45+yZ5J6XaOFRsRvUyhi4+CnutHCUr
	P9PIQKFsUVkfdAmsjxj/glsTuMGQclYe7247SH7Ypkt09wgaJtXo8ocVS1yMK7cX0tzVEcAbaOB
	x7/m1h+W496hujn7hbuifvjGMNVkebFOSfRGikeBRshVUX34+tw1MsnPmNKzEnRgs=
X-Received: by 2002:a05:620a:4547:b0:93f:2610:fb6d with SMTP id af79cd13be357-93f29cc832bmr99546585a.13.1792171873049;
        Fri, 16 Oct 2026 10:31:13 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a18510fsm262760085a.22.2026.10.16.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:31:11 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v8 0/2] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri, 16 Oct 2026 14:30:54 -0300
Message-ID: <20261016173056.3397211-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016163349.3293666-1-qwe.aldo@gmail.com>
References: <20261016163349.3293666-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v8 fixes issues found by Sashiko on v5-v7.

Patch 1 keeps input_set_capability(EV_FF) before input_ff_create()
(ff->ffbit needs the bit), but clears both bits on failure via a new
ff_cap_clear label so a masked error from the caller does not leave
EV_FF set with a NULL dev->ff.

Patch 2 keeps the devm_add_action() design.  Changes since v5:
  - module_put in hid_haptic_destroy (not devm_release) so the module
    stays loaded until FF is done; __module_get for devm_release itself
  - guard against double-init (return 0 when haptic->wq is set)
  - NULL haptic->hdev and haptic->input_dev after put in devm_release
  - restore dev->flush/event on devm_add_action failure

v7: https://lore.kernel.org/linux-input/20261016163349.3293666-1-qwe.aldo@gmail.com/
v5: https://lore.kernel.org/linux-input/20261016135516.2957381-1-qwe.aldo@gmail.com/
v4: https://lore.kernel.org/linux-input/20261009103333.2476105-1-qwe.aldo@gmail.com/
v1: https://lore.kernel.org/linux-input/20261009031207.3233206-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: reorder try_module_get/get_device before input_ff_create
  HID: multitouch: fix use-after-free of haptic data on delayed input
    release

 drivers/hid/hid-haptic.c | 108 +++++++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 26 deletions(-)

--
2.53.0
