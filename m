Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213948;
	b=uHYGX8exIL4F4ja/IxSpZAjLL6icS8/UiFNDpNtfKyF89VViepm5qWwL9TzRzMia+bYh
	 4zMdSiRYB9suNxZiOTu4wRm6J06baiWNLQclc90mm/x/Jnr7Ox6TPhpSMnJ7dVHOWHSbU
	 IqIVLSLa2kqDrrr7w7D8MOx3w4Dx0A6vZhJarG2qZyM83h5e9+vdSupHLA9V7VBKmZWcR
	 pYW3SPcLVn07X+3ndYt1o4nB9z4q00Goru8/azaIgdO4qf/YaOYq8kcFIx5QUxrb6Lb2p
	 GbgFiPzfXKDxT5EhK6tmnLyVcBFCFoXyhtcYug8D+KktA2WHh5yS+Jmqz9KS45UYXtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Gg0fFyktligmb90w40XfYXM2OtJ+N0bLEtyk+kcjlXc=;
	b=RfutyINLcdSB6/HeduBo6JaWnolcQJOsAnvwqqKcblJRfGwFWniavhWNdYP1NtkVM1FX
	 xGp4KCNLXDS2Ylk0mtcbVTBtND45Jv81UkCcnOL7z2hMpSwg5HGOu51rhn5YeXHrJfUxL
	 trhT2n1RbxVPDymeDekxSVCwVcFS1rymt4jDwof4KM6tM1V2iesOT3hw1VnVrmetgDkKs
	 MIOS4fUCSCKUQnDl6oHfBQl8AN/3yMpQ3EN3Ll4rPIL4N/sUjDcEOwkBdSl0SSWMWjAgp
	 5wTlavx4iSqsFl7yWNdGY/lFTd5ZizPPaCWtbZFDxtM8u4khLRfVtxR+Kh5URKz844w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="N4mv/3fi";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1459606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1459606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=N4mv/3fi
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36661f953e4so2117020eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793213947; x=1793818747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gg0fFyktligmb90w40XfYXM2OtJ+N0bLEtyk+kcjlXc=;
        b=N4mv/3fij/Gmq1tkoCN8AclDcUxzKBGXpJmdylvKfIvchQ9HaXWM+HjCW8v89keeDe
         Fp2KdO17NTnECIntWC8PMSRHM6dj61cYGolb5CwjyGGhFaNXctZ/8P8diwEE/DPyIfVW
         J5WSYaPt26U4XPrzSfJPkZRUQt2KzZ/xXR4wHrNQ4IgSQxm8XUJRlxVvrIVfY8BFjiRP
         oEz0/bo1Xs3dEswDNX44U29hie0lndVM6cBovNa7o0MHTLhPjm3acibCzXkAjqU8vEhu
         4Xwnma3bmeMbY2t/EIWHAC8cJYcra9MwtUEqHDvHzbffY6mupXo8H10IMY9jRwRoRYfx
         MOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213947; x=1793818747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gg0fFyktligmb90w40XfYXM2OtJ+N0bLEtyk+kcjlXc=;
        b=wVP/FIADh69i8/vTLL+wZp3d4oX/4bWhhDTHsKuURLfXlSUI92kYPOUxGmfbMnKgXS
         WH/f1F8YxCVxEavrLb9iwWMx8ea2KYEojfuTdiFYA2DW6UV3WLom8aUUU2fkGCiy0/0s
         wWeokFSBSrt/o0GOoe8MuO4ZHlEN9/rpM+FBDBHqXCAwHgP8pP2Txs1h+T0+P9rWNX45
         LfWg2eYvuJvSQn99YhVx2J7s+XWnegMrK1nKO8knxzqe6xtqt8Q/sBAZ2RS9h6AShWHS
         99dirJwHc44Xc+w1HhiO/UnolxPh/yiLEnLhkbaDOlEs93WOfZUtLOgxC9ov3i+VdUzp
         6HrQ==
X-Gm-Message-State: AFq9FYI324AmvNvZ2LqCWybdsG740a9O2CtRAF72bG+AOG9/y46GPhDw
	ZzJmIoWTo3A0vq1ZWdYS0rGUdmRi2mQz762DfR+VdGv7+mfZB5+m6I2T3TCheipUze+2h9NWbzw
	gvjJb
X-Gm-Gg: AYBFou3u0alsu2tCIrKuECvHHTVOeBeAxsKMSMb00l/oun6nuybrcOYdCZTjLHnJ/j2
	D/LyLfgL0dmn/MD/N/n6NukW5bBr3wRse/J/5d5LIB+N2V5YWuZHWPlOgN8M/KRQpl7Jh8Wzm25
	kQF87CfpepUWAI7Ng4e3vPrWFxVzv9lA2mDYkuoRsOEReH9AlrKcMZ6v/c/ty3Fg8F284XOF0CW
	5feqpxYuWgpQhNiUb9XP787rT58L3dRXdC+504HuCWbe/o2a7bvBkx7oFXCIt7rI2UqQKbTcKxW
	PF6MTopbmqxdiphkagHfUtSQMduioz5c9mAI9Foer0wZh/mp0eCL6VwtEVfCQ/8Ek47Rp41JNvG
	zowecY426kI2FjlOiMM6Wn/0teehBBaW9ulLdrPP1cHHeXRJJdIhdkVncEN9Dwj3a9q9AXG0ixD
	ok2iIqaVtNSOjvlNrXFRvrUdQ3UZ+gXcmpbGY3Z2Fer0+/VUvSj8c7zXM21q1x7cXZ0/P65yxTV
	yKI3/xaArDaIfIQ2h3fIUrWFcWz9aLp9uB2lmlqsOjEOkOg+Vw6UCR+Frd7ZVeCCtwRbfX0Yr67
	xk1OsuY4OC272C7ZErVbIA==
X-Received: by 2002:a05:7301:1925:b0:351:68e8:4646 with SMTP id 5a478bee46e88-36a20469b48mr6043474eec.37.1793213946626;
        Wed, 28 Oct 2026 11:59:06 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2393cc86sm7773449eec.19.2026.10.28.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
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
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEueTogKGJ1aWxkKWltcGxp?=
 =?utf-8?b?Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmF9fc3RydWN0X3NpemXigJk7?=
 =?utf-8?b?IGRpZCB5b3UgbWVhbiDigJhzdHIuLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 18:59:05 -0000
Message-ID: <179321394555.45576.11735904728867814450@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
implicit declaration of function ‘__struct_size’; did you mean ‘struct_size’? [-Wimplicit-function-declaration] in net/bluetooth/mgmt.o (net/bluetooth/mgmt.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/net/bluetooth/mgmt.c:2188:36: error: implicit declaration of function ‘__struct_size’; did you mean ‘struct_size’? [-Wimplicit-function-declaration]
 2188 |         memcpy(cp, cmd->param, min(__struct_size(cp), len));
      |                                    ^~~~~~~~~~~~~
/tmp/kci/linux/include/linux/minmax.h:92:27: note: in definition of macro ‘__careful_cmp_once’
   92 |         __auto_type ux = (x); __auto_type uy = (y);     \
      |                           ^
/tmp/kci/linux/include/linux/minmax.h:105:25: note: in expansion of macro ‘__careful_cmp’
  105 | #define min(x, y)       __careful_cmp(min, x, y)
      |                         ^~~~~~~~~~~~~
/tmp/kci/linux/net/bluetooth/mgmt.c:2188:32: note: in expansion of macro ‘min’
 2188 |         memcpy(cp, cmd->param, min(__struct_size(cp), len));
      |                                ^~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:7730c5b6a29ea3c3ba6139f7539fe2df233f093a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cf976d6a55753dce91f48c978098f1ebfafc42ed

# Builds where the incident occurred:

## defconfig+lab-setup on (arm64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae235ba5c0836a8c2f17961

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6ae2355f5c0836a8c2f174c2/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae2355f5c0836a8c2f174c2

## defconfig+netdev+nfs-root-boot on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-6ae235c45c0836a8c2f17979/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae235c45c0836a8c2f17979

## defconfig+netdev+nfs-root-boot+ltp on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-ltp-6ae235c85c0836a8c2f1798b/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae235c85c0836a8c2f1798b

#kernelci issue maestro:7730c5b6a29ea3c3ba6139f7539fe2df233f093a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
