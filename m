Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729E3515CC
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138765; cv=none; b=Wg/6D/bhPUILaNI54oAv6RyFvMuSxoMrTBEenPrn/5TaBJ5w0zBv7jbagEj1LSsYpJhZRtF4MmRn0aJwIAQYRoQ78bNTW7ZvmgNx9s+pZfsQxXfqA5dVDDv5lTSh08HCt4eWxp6Eq9VXCSL/PTsKIBvUEj8I7L/q5h7KszEbGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138765; c=relaxed/simple;
	bh=kWf3NXpKUlKPYHghjtKm20p96AutB8aDWOaHAdLjNpQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=lPuf47p3yA8p4qCyCSQWUJUfBPTbYzgrYM4h29QoA6M3BWWbOHfoh2AKkAj0R//JeucYhTqKThk2i85dldXb1MxQKMNYzRDwCoKTnXScilMty/4/NqYmWVSXyjjWqZt8BfuJ1C3bFSmy0I5TUW8dwvmyBRrNjMhNVWThB+Z6W8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=RqoYjM5m; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="RqoYjM5m"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d91ded8174so9343425ad.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138760; x=1789743560; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pKhgJyl8toO0JcgAQZzuTFoc1JT4ac3vSkEcIPno2O4=;
        b=RqoYjM5mzhHDKasiIbBbF4hEZugC6siGQIbosoelw69TGaJ9seS6aJDMVFW+Knz+lV
         LhuGkeJPN6YViOlkNs6LZDy5JkDaKpuUK7A1DEl0jH0NyzNIdaQd1PE7TsgBk6keDnc6
         4pV69VRQVhhom6wYsGyuuDblvjx8aliRPkLY78D//aP8H/Ebrwkc+azHkr1018zQhIID
         5Z8bhS7gryxQLNBD2kxvKsEeUjJgfVVGP5/rDgZ7TpIGoWWbAi37/gu0e9mTI9kB3miA
         zP4hiuo8ope6EPKnBKD/glxSjwBkF8McfY8zH2T1kRPos6/cs7FwL2tfDGpJReHQnHPW
         4eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138760; x=1789743560;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pKhgJyl8toO0JcgAQZzuTFoc1JT4ac3vSkEcIPno2O4=;
        b=nCCSX+mxBsWAj/eZ6KrbbnstlolhyE/gWKTj9wh0V9sNGs4KKlyBnyxcx8YN9psYfm
         gjVUzKGwNWB7SKnHoWL6Ciuys3+es1ucnyz8mUz12qBoHGAeClFsKyN0sN1vDUd//OaH
         It2WvHFa2VM9XvIQpRX/FS8J/4ap3lava5vVsr1VvhnddH2YeaCWPNZ7rkV+JWlF55JV
         gLQLicPDGD9DXRpMFRMQNl7Sf1EYOSfjWJ1TP+r+JYmNRbfDuniH+vc3AJo+vMtiyJP2
         Qwr3QJYTaSRTj9Tukt5SC0Gho0ZCuvQ5AQNUqn1OTP6Lpqrtz14gM6ECwyogz4Dgiu6G
         /K1A==
X-Gm-Message-State: AFuF++kWi9ed2J8dqefgftsV4gTCJH0jH+eXG42mtqa4GXbTn7nC+gci
	YmvDpzHox65W2fdtZ3/EOX4bHicHlQaVAZS5vE8glf1+lPk9EhFzvIDpplsvfZh6HdAKf2ZbayI
	TjZ6t
X-Gm-Gg: AYBFou0TCgkclkEIaFSVZYX8TSSJMB3SgDIEpKKw0sj8rvIuXdjuR9N2M5SL6Kyw25O
	fN6D1xQ5rRxz8HSUqkZn5qwJwy8aH9/f0x9uqsKL2lgt8Su4lkbJAKn3uuYJIXIBjKbfrG7zyYT
	h+vZ137FAbbdwYbV8CQF3d6FlWoPKlZLgFMGpypKE1qILTDr00wIzmgD2tzASmOgC+KgnJLnpxC
	dFftr/seQI03WfZYFJamWTnRJrVkuU7eZiY/TZaoO7Tuq/zmQhw+cmVTm+XWwrAijoZ6vdlp03E
	UM2m17dUUPOHuXkJ+19wUPLzUekeXs8/3647aN3jF9yfrlI4icspVf8lEn2KsZI4Oq9C+nizl0d
	MmTOZFD3KCp16w9rmV78WCsJCVLufX9lRPlcQMZdCXu+Axy8uL2gbx5zxVeQZR2k5Y4zVMjPrqk
	xfT9PAtVhUAaS1edMIvaVGQFTYSScbxdfuyM8KR9PmCYFX7+waAcvSjyHNMw66aGE=
X-Received: by 2002:a17:90b:2b50:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39d9c1c199dmr7998134a91.14.1789138759746;
        Fri, 11 Sep 2026 07:59:19 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e5193dsm6872264eec.10.2026.09.11.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)fs/ext4/bitmap.o: in
 function
 `ext4_chksum': in kernel/irq/irqdomai...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:18 -0000
Message-ID: <178913875843.4387.8317378968648475109@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
fs/ext4/bitmap.o: in function `ext4_chksum': in kernel/irq/irqdomain (arm-linux-gnueabihf-ld) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/kernel/irq/irqdomain.c:361:(.text+0xde8): undefined reference to `irq_domain_remove_generic_chips'
arm-linux-gnueabihf-ld: fs/ext4/bitmap.o: in function `ext4_chksum':
/tmp/kci/linux/fs/ext4/ext4.h:2465:(.text+0x48): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: /tmp/kci/linux/fs/ext4/ext4.h:2465:(.text+0x98): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: /tmp/kci/linux/fs/ext4/ext4.h:2465:(.text+0xec): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: /tmp/kci/linux/fs/ext4/ext4.h:2465:(.text+0x140): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o: in function `ext4_chksum':
/tmp/kci/linux/fs/ext4/ext4.h:2465:(.text+0x258): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o:/tmp/kci/linux/fs/ext4/ext4.h:2465: more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:8b1e16836b85da54be61fe46a48a5b4d7b7d6a4b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c3520239ade90229f1a

#kernelci issue maestro:8b1e16836b85da54be61fe46a48a5b4d7b7d6a4b

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
