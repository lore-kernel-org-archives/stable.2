Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242529;
	b=DP+c5GfJnkGh9fvHTlNFTja3hH0wmK7SKqWjdM19QK8Yyvns+E+5w8UBs9WDJUC60krf
	 qTrtWb5f7LH+HyC2ew1xkgaNkC9UK6kVsIuYX7VGkNVq3U8LcJyl3c89y0JFqhZa8lUHE
	 d+tfyCqZhARAVD+9l3+Z3yB7zzx2ZqWqupmu6DWPRsI2Hhs1XazPYRQwdUqArHmvn5UPf
	 wBsxzNMZ1Jh37XZSEbykbBtBeL+oZSmyi/sdfUzGRan8CpAq/0edPljbbFzSao41YyxoT
	 g9r66DFqHLVOCpjEhfarYRkpZz5soPzHqzYd+PL9Ig4o0TFoqRn7UEXjuZpmpBXGsBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rTBkN4SoXpbnTrjKm6a9r9Hi9WyVrqwpfUB5k5zGKJU=;
	b=tb0sItbdFQ9l+ycGbtf99V3vz1lKJAE3GDzZQjSp1ucKhttJILkcXHAANR0oWL1rFQRo
	 0tTFSiCNl7uJ1M/mm24VGVNRJkWOXDaIkPbJsoCh2yY/I/6t8YScenF3Wg7nRrl7aSe3P
	 jK+xqtYutTm4lQDlzfZEdlTBPIPX8O1hyxr+ljghtVUsy6iXSF6Jddn8ZFiV5UY7M8xzS
	 z3zRyuoC/REKcUjQsoj+OpyLbLoko5KJVEshYqOAF98iRhaL0QQOp2ImDKl/58oeXfHxE
	 QIHgXM2knMEL23/naOIw7WEaLrjoTeW6tSUMufrJVpVF07iFd3RHGMphXo64afTGIUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fk/Wy5WQ";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539D606A326
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3539D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fk/Wy5WQ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so6500435e9.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794242527; x=1794847327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTBkN4SoXpbnTrjKm6a9r9Hi9WyVrqwpfUB5k5zGKJU=;
        b=fk/Wy5WQCkWdrah+qLMkXKaos3bTrw3VzUEGV9pSdILWJp2hlmbRjEzGBmV1bKwBJy
         XxBdw6jsIznlDUqJUlEUo3FwW0YnH7+a3nfRimB4b4WzowxYh803gXzalSJFwzfkMXYl
         1rzi9QoOuS1UTNcE7mQHA6tESqziqaEBvmpsckEZ4PwtXmuwFS84r2vvpl6M50bORGdq
         IFlGwM4zwaZmLsM3IvPqQ8nPz5tB1tcfuUQvLinXbWruDJFjdNxmUczmwB0r6DF4Ko1Q
         Jd13Tq9tesDAqI7DZAR8EXNCbZr0F4/K8Z69mU9CiXtpZoOLHmFPUdwq2RMB+GhZ+B1C
         SH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242527; x=1794847327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTBkN4SoXpbnTrjKm6a9r9Hi9WyVrqwpfUB5k5zGKJU=;
        b=QFkmLeQ1pA5QiRTUj0OlNRtry6RSnwEAuugXC0dGkBSPYwedcg2VAG1+Yjw3bI+aU3
         oC+yWIBRYWypgWKyVL4S999cbUyXI5QXV61k0gizjPyvwg/UWPRVGsWGBdkptFUWkz1l
         KRSfxPuY5Kqx7iPmSKpANUTsqnlTXMaV4gWiPaHkiUOfitpXfJ+pAFdDUm5zyuvQKg8T
         B0FzqsyRN56TXK91NIfvgXHT62+hgFMg4Bdzb8FaG3ia+fU3TzOFSZy2DF64ktEJsJuH
         bvn3m9JiTHiNuX4UsIpUZSeqsb/Cs1H9je4aJxTFbz3CTIfyqa6JJXPkk6KT28bkBc0b
         LzIw==
X-Forwarded-Encrypted: i=1; AL+hErHSWCb6qsQuWJXsqRRUcn9+V41unO1bc/lDSZkJv/alfVpUKzwgKAPfKbSzNvVAhc9LW3bKfcc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KZ8sEpMH8lTuduNs9HoGD35wmmfEq+wz1eGTTus6PkDUlqqHw
	g7Db8ER7AAgWlqbjR0YMwSAtH+vvt+UOPNZdxRe045OoPGFEzk1g8oY=
X-Gm-Gg: AYBFou34Ts6G5VPrwl6Dw8Z9T3M94krLIjnjLZn9dAhKVngorwXhvUi63DxhgKb6LfU
	ipo6f56mj4RcXeYcV9WqjPBdKI66gYymE1tjzD7KvLTvufOsonW8TPZUiOcIHXyfNwASGOJx8GO
	coDegq+BOPEkjP1mo7wzm7aENnTDgmHnp/H9hhoov+U15c+6uFmD5sriQyw7H0h5fNjDIkYc+Hp
	xvpnCAcsETLHnMAv76FB0pwUi7M/rRNdvhIdDH5M397Ov1FdkuytKA0PwkxIBLV+rMuBMlS+nFZ
	BH9isF6StwU70Sm/s4LyHWRkGuRs5aQTPrS1ro/9fumjsQKUSm4GHQ+k4CrebFeNqBX6zglPPo8
	Rr0pblbjebjCUfIWADbLrq8Jh11ljYPYdwHm/TwDH2f98/xz6ZefV3N8wrMa8+khIL2mrx96nb3
	vSLe0UQGPg7aWubDy6/2LhDDi6hZdmaPV2yDoeZzO3KuzS8pbLJgHoSvA4BWE/Vrq4SbMl/qNsN
	5TUU01c8rmUL3RNK9+kLiTMDiUqvvIA2/VuaPu5TdcAUJBM4lIPJHliM0AVFFrUfyJzb2CSsUq9
	exp6FPMU7Uj6/oGdA5PgsOFUWPZp+cjn+J3nS2oC8xFlFmwnyFRfcMpRDsHm8fCrObhHEKY5TIu
	ENB15l16LiUDDp+hC4M9VGCxBI4nEh5nFOxrnqtVuLIPM/UowV38UDZDWEIFT5e1dgmaLTKvtlA
	==
X-Received: by 2002:a05:600c:8b24:b0:4a2:d:5ccc with SMTP id 5b1f17b1804b1-4b960d9b66fmr79533325e9.10.1794242527085;
        Mon, 09 Nov 2026 08:42:07 -0800 (PST)
Received: from chateau ([194.65.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597371cc4sm10639482f8f.36.2026.11.09.08.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:42:06 -0800 (PST)
From: Sergey Zagursky <gvozdoder@gmail.com>
To: Arpith Alexander <arpith99@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Antti Laakso <antti.laakso@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Jake Steinman <j@metarealtyinc.ca>,
	Dan Scally <dan.scally@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] media: ivsc: csi: Add sensor node in bound callback
Date: Mon,  9 Nov 2026 16:41:59 +0000
Message-ID: <ivsc-csi-tested.20261109163952.eaa256f0cc02@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103200226.100989-1-arpith99@gmail.com>
References: <20261103200226.100989-1-arpith99@gmail.com>
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

Hi Arpith,

Same regression on a Dell XPS 16 9640 (BIOS 1.4.1, OV02C10 behind the
IVSC, HIMX1092:00 in ACPI). I reported it before finding your patch:
https://lore.kernel.org/r/20261109142140.ov02c10-hm1092-regression.e938253b8516@gmail.com/

I tested the same change (identical apart from the declaration of ret)
on CachyOS 7.2.8, with modules built from kernel.org v7.2.8 sources:
- 7.2.8 plus only the HM1092 entry from 4fdb0342f05e: no sub-device
  node for the OV02C10, libcamera skips the sensor.
- Same plus this change: the node is created, libcamera and PipeWire
  find the camera, and "cam -c1 --capture=10" streams at 30 fps.
- This change without the HM1092 entry, so .complete() runs after the
  node already exists: still one node for the sensor, streams fine.
No kernel warnings in any of these.

Tested-by: Sergey Zagursky <gvozdoder@gmail.com>

Sakari, if you pick this up, could you also add
Closes: https://lore.kernel.org/r/20261109142140.ov02c10-hm1092-regression.e938253b8516@gmail.com/

I used an AI assistant (Claude) to analyse the problem; the tests
above ran on my machine.

Thanks,
Sergey
