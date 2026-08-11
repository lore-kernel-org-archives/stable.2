Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28936194A
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478005; cv=none; b=phCA7554w/S/vuavBwD3dizHqurAJq4MrspBGMtkI9FNvm/Czn80oC+K8UmiLQyCcsXnTr6/CmiqCdDoa8egPWWWxWnaOn+Vyob2hs+LFpQaZEgXDB4puotE0PKh1XVLLWlKElgXujyWesSKfIRnuVr89d+0DBAbAElzCJAG+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478005; c=relaxed/simple;
	bh=nASdhlnQj6W0dV29+7od0oNAJnTGdxlDy+BNJaTPeLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzeegXO9XtXMlKaqNkyND5FM+rmRRe2NVKoD7w7lTGQOadUddlf6LjrragelGZoVOrsW9G7njeoMUk11QX+KnYmipYbjfrPxywBWtJY/0SCTUQ3rYmHQzWZ4BNLIvCn8f5zeQCD3DXanHwJle4CH9knV8L/Q3qZDLqXhPzQXjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az3elION; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az3elION"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso581975e9.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786478002; x=1787082802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cV+CdfERh/o0eu5vkzQXpmPtNLbsSOir10XB4s2+AHo=;
        b=az3elIONsfI3tIfDGp3fYNZOug9E9X2Q36kW5e8A6bC1coKZRq2wggjlXD+y6TObdS
         jrJOvZ66E8UolemXji5R3dOz1vqRENlcnPTd4sAsQVFjKqVxC7Pmx5Y9vZy0GB0nQB/C
         aR/a5yK6GW3WeSkFU8KL8OK8HXldRSDvTmZgDHz1/AV/HhMRCQllZ2KYX38Zymj1hJ6w
         BiZJhwPKeCx/z14bDoYsQgYgrqiVSD/8H4DkjCVVI1NfujjtYHmPplizkPtkc0WtXu7v
         lxgujBqL+2QfKIhPNuA4XlYpy+z8kmpqZFuUGlx7aYnFSYYG7asJGA5QzJnq0c3uUBsR
         5ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478002; x=1787082802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cV+CdfERh/o0eu5vkzQXpmPtNLbsSOir10XB4s2+AHo=;
        b=EvFIEq8lXRq40agBXJ924v7rdKCh/VCXuWKVEYsvZHr8aWVbvrPOYRX4plsOkxEpj4
         3+uXSPYyHNJcwb7ItcaGt2FnWllrUnkhu36/Aswo+3zqwhJf1JNuSOhb1cmaswxTX8xU
         XjS3Buk53Jbsh53tZpcyYHgWUogukGKytLW2FJwa3Zior37eYFmMnYnTObVMLfUe/2/g
         YqDlGv3CWlv/8UQ06nqzfmtxel/piWHAuWcUfKzxTIkI78OXv+SKq1HhfBixpY9yCsuD
         BWzK/eYq6X5j1ZmUjBF0n0JVxqxcIx1pnZGrTL7kOTlxdRRcUEGAKJMxrON1vZouDQ/7
         cTFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpffSq5Kd5WY2jvDVQHaS3axaMXgu47DuYgoOn6BwuWNrwKcBOL8Zg/oSa+yY+0S/b2bliLfR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxP1KPkIhdmSQJlpj1UEOvcu032a7eDskqeTe8A1wc94woGvfi
	j4gMREKirgsMWXOX8SrkUJEYayyly6u0uGbj2Dr7xnmuO8YGrGqfqTN76xUIyAz8
X-Gm-Gg: AR+sD12LrTENo8+UBmWJFYrnETbCz5D6h2e5hicZZ8EN09SRikhDYEbzii8qbl3c+lZ
	/fpXP8pks+wPJv4ccTJSquAI9FHzWuBJ44O6YpYhl5iSpdwXl1w5vaKPqPEkf0OM9b9gHE3JhKo
	3bN+IvNSTKvmLpN2XAvt41Je/WwYMUnEX2ODGl6eWW41iOFjv5XFwsHuZ7fzGXo8XnNwFHz7KE7
	qsQiTJEf9wEgXGvAcrH9aeTyMEQSsAKYRP3DDTq/WYdt+BG2DWNofVRhzTCU7ApyJWFHPmPO/H3
	N8K0+WELmgZW6DRxhZd4kp8Bb2NL2dbfogasUWn1JEljEcwzy3kVMaNpDNQLmJun1mNSh7pJr8b
	YGQ2SNNR9u+FgmaygbeB//6luLBZep8OZYKbtNUJJxhOXYLyULEKrEp0OICbIeNT+eTmBaHHbTZ
	gOSrl6mE8WPnpADTWd0zmQtQEN4I5uu3bFBOTU90FLVnAbcusaQEsuqTOI7bpkUBs6OAY9/RUwp
	I/n5Ny49A==
X-Received: by 2002:a05:600c:1c11:b0:495:4b42:8677 with SMTP id 5b1f17b1804b1-499784658eemr81929555e9.18.1786478002355;
        Tue, 11 Aug 2026 12:53:22 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:cc3:6030:4761:992:27d8:3423])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b15b807sm11666785e9.7.2026.08.11.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:53:21 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Jie Luo <jie.luo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks enabled
Date: Tue, 11 Aug 2026 21:53:17 +0200
Message-ID: <20260811195317.128954-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8248f034-d5a6-4f9c-b6e6-77eeb8ca3ad4@oss.qualcomm.com>
References: <8248f034-d5a6-4f9c-b6e6-77eeb8ca3ad4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/11/2026 Jie Luo wrote:
> The board booted successfully on the IPQ5018 RDP platform.
>
> # insmod ipq-cmn-pll.ko
> # devmem 0x1856308
> 0x80000000
> # insmod mdio-ipq4019.ko
> # ls -l /sys/bus/mdio_bus/devices/
> 88000.mdio-1:07/  90000.mdio-1:1c/

Thank you for running this. Your result is correct, and I can now
reproduce the equivalent on the failing board - together the experiments
finally bound the problem tightly. I spent the evening on a GL-B3000
running three variants of the same tree, all with the fix reverted
(i.e. vanilla put in probe). Full data below.

Variant 1: gate delayed to idle. Vanilla behaviour, but the last
reference is dropped via pm_runtime_put_autosuspend() with a 60 s
autosuspend delay, and uniphy (the only in-tree consumer of the PLL
outputs in the OpenWrt tree; mainline has none) disabled in DT so the
gate actually lands. Result: the gate lands at ~75 s on an idle system
and the board does not care. runtime_status reads "suspended", both
WiFi radios keep serving clients, the console works, nothing in dmesg.
This is your RDP result reproduced on the board that dies: with the
system quiet, gating these clocks is harmless, and nothing in steady
state needs them - your efficiency argument is confirmed.

Variant 2: same DT (uniphy disabled), unmodified vanilla driver, so the
same gate lands right after probe, during early boot. Result over seven
boots of the identical image: one survived, six died with the familiar
signature - silence before the serial console comes up, then a watchdog
reset. So the crash does not need the ethernet path at all: it happens
with every PLL consumer disabled in DT, and it is probabilistic.

Variant 3 is the stock configuration (uniphy enabled): 100% boot loop
on this board, and the same on three boards from three vendors.

One methodological note for fairness: variants 1 and 2 are initramfs
images booted from RAM over tftp, so their early-boot activity profile
differs from a normal flash boot (no UBI attach in the fatal window,
for one). The 6-of-7 ratio is specific to that path and I would not
generalize the number. The stock 100% failure, however, *is* the
normal NAND boot path, so both paths are represented in the data and
both die - only the probability differs with the timing profile, which
is itself consistent with the collision picture.

Putting it together:

  gate at idle          -> safe, deterministically (your RDP, my V1)
  gate during boot      -> dies, probabilistically (V2: 6 of 7)
  never gate (this fix) -> boots, deterministically (3 boards)

The only variable separating V1 from V2 is *when* the gate lands. That
also retires my earlier "shared CSR bridge" theory - with the whole
ethernet path disabled the board still dies - and explains every odd
observation from the last month: the victim being whichever device
probes next, and the failure probability swinging wildly with binary
layout (both are just micro-timing of an asynchronous pm_clk_suspend
landing somewhere in early-boot bus activity; which transaction it
collides with is still not pinned down).

It also shows why a consumer-based model cannot close this hole: the
fatal window lies *between* the cmn-pll probe and the moment any
consumer could possibly take its first reference. On boards where
Linux is entered with these clocks running (every bootloader does), the
put in probe is what creates that window.

I am open on the shape of the fix - if you would rather see the
reference dropped once boot has settled, or a synchronous gate, I will
gladly test that on this board. But the boards are unbootable today,
and holding the reference is the smallest change that deterministically
removes the window, so I would still ask for v3 (or an equivalent) now,
with refinements as follow-ups.

Thanks,
Stanislaw
