Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640206;
	b=Ybai0ip5GDOdD8t0OXn7usrPG1esX66txAwUT1XkjZ4IiK7ss91x8aBWY630zsZZDuSq
	 tLredMlLVR3nuUboUAQNZObIxZ7cEVPv5Sqivpsq70XuEf1LM23cwPzn+FhEEkzPDM+sx
	 jmnHxDtBCEGvo3dVsB3ibFQCoAD8OvQoK2ZpGABXxjb2w2tEbD5Ft21Qb0vtAbzW2t5c6
	 apQnUDWN3v/2K49n106abHw0eZVlqhVLBnlNXAkyBkQbEVRGctAph3/yrYynJBiqpxzI+
	 HmPe8x8IGCu3SEVHLuGbJTf7usY5VpqSIl9f/8bjPbzwy/FRsVUnYzb4ZE4ZzHomPPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=awwXifPb5aHvVxBftaP8w2SImHVCu8Aljuq6PIur9ho=;
	b=M5nwlQHq1mLZMyATf1rHiFyxLaBmKMaxZmM3ofsRpRXJTg8tPlTbTgJehjOQISETvA3f
	 zqA87oeQ7yvUqWFLpiVum+LkEl4UR7hxhRQPWzGeOAXKGI5d/610nFYvNHYkfAmeBboRm
	 OuDZe3bgLhHCPChqDD/advlQ8TMh0pfyAQDCqFS9LY9JrlaKzQDGGWh7X9YHPrW6SP9pn
	 gL0jge9aFPcu5V5Wwa0ExsKrJ+7CFi1S+0o/lZj0A4BpgVFsLeS4mKpPh7I8FTKovIzrI
	 2uLoE9nb6gYhzjgthFZJYwMYhgIXe4Qm0vNqz6aVR63N36gsRtBvFxDfkIT7nR7gSzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZWowEBAm;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B82606A333
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B82606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZWowEBAm
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53644ab1f7bso11551981cf.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792640205; x=1793245005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=awwXifPb5aHvVxBftaP8w2SImHVCu8Aljuq6PIur9ho=;
        b=ZWowEBAm3ZpvS9spxy+hCOtyHpZUQRXfMV7VGJrGBqePtMutqUsUT3HkHt6OkJuyNC
         Ua/alNSXjOarGoORxbJ2qdgHrZxI844ntFXlED5191iWqDiQQ6fBp4Uno6ME57PZ+ElQ
         FFZ1kzUwIWtk/jSENQ/ZfDpsbca7wUKdstXfRtJr4A0yMF7NNReaf1HW4whoef7z4ujb
         ZrV/9LgSehijvD+JxnDfj8hFR9bRlZSxyH0z8Ff649a35Kbuuxyt+ijoLnzjHT/TSCzT
         J42z2zn8NfpNI8AkL3HPkFh+4tzoJ3YcY5EGAVT5nbSPjH27mfU92/0RdKy6w0sA821H
         JF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640205; x=1793245005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awwXifPb5aHvVxBftaP8w2SImHVCu8Aljuq6PIur9ho=;
        b=o0IiRdS+JU+F8j7q376gsQYUXRuQdI3aAudFzmInL99mhD1sDKIS08HN4Ms/zz0nHr
         oe4Jw2Z82MkaVuszGBLGl8bDj9avA1F9ydYXtyYzAi1JdTA1OKuQ/m7yw6Gp+wBtYe8D
         FACe/qCGD+rA3LT+Ephmg09x+Vih4JiT2UQjf3yOb/czRTsoVaQctQ3/8ai6zYZQ/mag
         +d1DXCa3aNqYdeC0tW9LIZfbHjibqzBGUVS+OPz4SoZxvNWQ2c4czw0k3M3R9FwYVgii
         00FG5vZ3HG1l/jhUwxuVzUt68NS+IOpZmSF/mcm8wfDoDDb1aG0Bxyp6hVgIc0xK7aKY
         dgcA==
X-Forwarded-Encrypted: i=1; AKwUvBzX+wBfpfB4IduYFLJ6OhRf/OBhtUu2H1CO9kmM+H6EGd5T598nwndKdLVCKnKX3WnKyZRuFRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgBLdgwfz7jWR4A6NOp9/AeMs8U7G6sTugnDfh51DmTWWStCBV
	/ciQqQVo625A0JS37FdoGB9DrfncsW26ibuYg45ZxlctKXtZDfpLq9/f
X-Gm-Gg: AYBFou056Z5AB1QdcSze5b0pvHjtPiMaxQwtTBVFkDws5E8FtYbNdcZ7gJrYX7ox1FC
	arlzUCyPmlM1Jkyeiixm5M3y3s2q8VBWqA3NDtkT0I0bUox3slaG/hYKfbq0mGOTDzEPyxFpwnM
	UW2jjnxrYJjHM3voqBFBVvgAjGsHj8UEvYPwhqWi/BqcEwZnh1wy9urMf7WjL7sDKW1PZEMY0OJ
	OIfmAEapidve02NtVN9kYSLFjG5ELYeiuz+RCGj653+pFcUsJ10BWe+xUtlr4YmO83oU8eeTYxL
	5GwfbhaHvre+gV3fU83CAsMyaWWKU6UGyPq5PlHr+2hUyUlrMAFZ6bMdxFa+gVhwrgTSWE5/j/h
	UlqsF/VUmp7DLCnzF40PAq9O3Z7S3oNlEpSRlZg/j1MjPc40ktiqcoKnF7vglkUlVfSUV4/LQsm
	H2DNBxAaCRorhmNKZpAJ87WLDIeY9fWDs2kTY59gKPngDA93f3Psk1bkAH8GjlMBAE0WJNCqdIA
	ar9E/Gzpr5ZW8FFdWFkSFNeJwhD9B5rftZ2hIUNddrlFWB5d81wXYBsYYcyh+rBiSGYq3TcLyU5
	Bqw=
X-Received: by 2002:ac8:5a85:0:b0:535:2763:16a2 with SMTP id d75a77b69052e-5369b8f93f9mr64806861cf.43.1792640205211;
        Wed, 21 Oct 2026 20:36:45 -0700 (PDT)
Received: from localhost.localdomain ([2604:7a40:c601:5090:676a:ee3:7aa7:5c53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10bd5d8csm40818286d6.24.2026.10.21.20.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 20:36:44 -0700 (PDT)
From: Saurav <thatsme.saurav@gmail.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] i2c: qcom-geni: HID keyboard fails reset on x1e80100 (Yoga Slim 7x) since 7.2.9
Date: Wed, 21 Oct 2026 23:36:36 -0400
Message-ID: <20261022033638.32460-1-thatsme.saurav@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Hi,

Since 7.2.9, the internal keyboard on the Lenovo Yoga Slim 7x
(x1e80100) no longer works. 7.2.8 is fine. 7.2.11 still ships the
same i2c-qcom-geni.c as 7.2.9, so I expect it is affected too.

The keyboard is a HID-over-I2C device on i2c0 (i2c@b80000, 400 kHz),
address 0x3a, VID:PID 048D:8987, IRQ tlmm 67. On 7.2.9 it fails with:

  i2c_hid_of 1-003a: device did not ack reset within 1000 ms

The touchpad on the same bus (0x2c, hid-descr-addr 0x20) keeps
working. A USB keyboard works as normal.

If I build 7.2.9 with drivers/i2c/busses/i2c-qcom-geni.c taken from
7.2.8 and change nothing else, the keyboard works again. So the
regression is in that file.

Five commits touched that file between v7.2.8 and v7.2.9:

  82339215fc00 i2c: qcom-geni: release DMA channels on probe error
               (upstream 268aacb2e2a5)
  139efdb3ee6e i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
               (upstream cb97bf3d4f91)
  6c3420d6ba34 i2c: qcom-geni: Store of_device_id data in driver private struct
               (upstream 692e0c84db5f, Stable-dep-of cb97bf3d4f91)
  4edab037132b i2c: qcom-geni: Move resource initialization to separate function
               (upstream ed4b34033db2, Stable-dep-of cb97bf3d4f91)
  fb54df3645d8 i2c: qcom-geni: Isolate serial engine setup
               (upstream d8d3bb127ad1, Stable-dep-of cb97bf3d4f91)

I have not bisected within this series. My main suspect is
cb97bf3d4f91.

#regzbot introduced: cb97bf3d4f91

7.2.8 always wrote 0 to SE_GENI_CLK_SEL in qcom_geni_i2c_conf().
With cb97bf3d4f91, geni_i2c_clk_map_idx() uses
geni_se_clk_freq_match() to find the index for 32 MHz or 19.2 MHz,
stores it in clk_idx, and qcom_geni_i2c_conf() writes that index to
SE_GENI_CLK_SEL.

On x1e80100 the QUP SE clocks are registered as DFS RCGs
(gcc_dfs_clocks[] in gcc-x1e80100.c). geni_se_clk_tbl_get() builds
its table from clk_round_rate(), so the table comes out in ascending
rate order. I suspect that index does not always match the hardware
DFS perf level that firmware set up on this machine, where index 0
happened to be correct. If so, the engine runs from a different
source clock than the SCL counters were computed for. I have not
confirmed this yet. So far I have only shown that the 7.2.8 file
fixes it.

I have not tested mainline yet.

System:
  Machine:  Lenovo Yoga Slim 7 14Q8X9 (83ED)
  SoC:      Snapdragon X Elite, x1e80100
  BIOS:     NHCN62WW
  DT:       x1e80100-lenovo-yoga-slim7x.dtb (in-tree)
  Kernel:   gentoo-sources 7.2.9 (genpatches do not touch this driver)
  Good:     7.2.8
  Bad:      7.2.9

I can test patches or run more debugging if useful.

Thanks,
Saurav

--
Drafted by Claude.
