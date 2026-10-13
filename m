Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9D3F3285
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899950; cv=none; b=s4x0fWhCMbI898pQeiWbKyY9VgE6qemdtqPew62tzMO1nbQ6aXJwNWUaAM2F0ENAiWvIppH81hqrXulX3nnG74FfkO8NqkoUCkfnpWnHAngid7UQnMGRusAkatHTkeDXwZgZwjOygllUiCWX8jrivGnOGhNTFE6KfK0kzubqe/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899950; c=relaxed/simple;
	bh=i33+tNxQs9vDFfwbCffS2QA0V2fkSK+ODrnRPbBvcPQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=q9i2nJDGrhWvfgrmm9dXnLQgNTx8iilcglhan11jwW76XUibw4fQRx+R1Q4gUY52dXuBkN4NkVClI1iGyyW9Mh8JZq4QPn2UogdsAMB1iikPxu3sBi/ufG8IJ8F7su196s8053Yl/TUuZV0GcRcZhGWWuup8g6Mqbogq91/B7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=N3ZrEtYr; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="N3ZrEtYr"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-17bc533fda3so440292c88.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791899948; x=1792504748; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p33dkzGVAoSlXjbFW4ld0/xNb5fH3JIT8ZatkJMGZJI=;
        b=N3ZrEtYrYFaKeDH1RKzHm01SoidCHRxldo79PGWuPNJ9HoxPRWv1K7KALN3Ysfkybv
         ej5++mZPjzLeewx18/nH4dDWGkLHQcnBxuu3XbUkoPIBN0Eg22DWHidna/yxD1QvFmmJ
         wVBSb4aep+pdj5GVwdFgfJdp6v+0DG1oA+m97BhBRiLjuZdaxR8v5wEXE5hC86c+nIhP
         Ugjnk4id3PkCzVg/Bc3IfL6qJrAkzEHFtD9OwSo2H+2Z2uPRCthyTHVwp0JAhW2L9Ug/
         NDvc35znH3nUchF/jXuZAWsIgYF9eEvgKsbqcxh2nfXF2BFBqWgiclc4s1T6tt8oHRzc
         oykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791899948; x=1792504748;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p33dkzGVAoSlXjbFW4ld0/xNb5fH3JIT8ZatkJMGZJI=;
        b=MQzbKfj9S/jzT2qqgk2M4L1N9JgFLW7HgdSyRuhCxtJTG9FCxjv9f+HhnLqO/XL+1x
         mAUdyBU4TvnjiARYGvNegBChTaYsKqGfhN0cATdGdAHrDkxLZ8/fUrK7TYDm3Z4d/y3/
         TfC8TiT9USWWVEIwKs8VI6yiL19zjBsm3OmZYgWZnq9zU3HobW/+Q3i0i+2CAE7dKYgX
         t9X/QLmvQXXidTMOGpSrXeosZ+lVcijalLvhI59WD2ksaNDQ9dg1lsBUrOK8EY+EkHJV
         qx2D6t69yaH/SI7938Mrr4YgpDaYtY+W+p8HOgj+IxBvV1Gi8DAy5nNQosC12216GUYl
         jEkw==
X-Gm-Message-State: AFq9FYKEtPY6SGibwr9aum9+f39SgdHvBOazC03WsDy+ryr5314MYZQP
	NpR8KjKCp3Nm+razfcJJQimbRKFNQRM922IGd8yEjFf6gQ+lJykvnMeBIWw21cE2kcc=
X-Gm-Gg: AYBFou2yidAaKvA07iDCN2ulXMg+BohxH/OdhUkkPJp+O107gx2dQLwTLDMwaiVkL8s
	mY1Hn3aHncaktV0oEPDn4aLj2vKwUajZIql06FN54Ih9dSvRPfb03qQqkYEoUDvqiV6FDdr9Mbw
	EcOUxwuhmIuHRUNexOGdbX70IbC0MopTzJr6bGBbhQdqEbdMWsI9CHKRPCcvoliwWlp9BF2SZK0
	6AtR+WSwNBeqZfX3uwOZSfeCj/9vB9RqZegD+d1eMVb1cGPSGJjrAxHwv98mkkHR/fL3kpsqEPx
	Jz4u8LG0xoNzaiD34vUPeqj6BXcDvVbh49WZ5QSed/LPbC8dIdC3PshmfQXSJWs5BLB7Y+yyrEr
	NdzDKxAzs6xKwUJy3ot/G24Y0tu/p9XEvxDAUwoCu13OMyz+TAcWMAgBrpvgl/1l5OdBOdA8iI/
	lWavBzSGTSc0fLmWBjUQ1AiUlBcbW7papfFMzt2zyymWMD3GxnsBc+qXSI4lz9o4c=
X-Received: by 2002:a05:701b:2093:20b0:163:fd28:5658 with SMTP id a92af1059eb24-16a5f9b0ab5mr18255904c88.22.1791899948154;
        Tue, 13 Oct 2026 06:59:08 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm49782736c88.16.2026.10.13.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjE4Lnk6IChidWlsZCnigJhS?=
 =?utf-8?b?SVNDVl9JU0FfRVhUX0jigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMg?=
 =?utf-8?b?ZnVuY3Rpb24pOyBkaWQgeW91IC4uLg==?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 13 Oct 2026 13:59:07 -0000
Message-ID: <179189994717.261652.595413665788348689@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
‘RISCV_ISA_EXT_H’ undeclared (first use in this function); did you mean ‘RISCV_ISA_EXT_h’? in arch/riscv/kernel/cpufeature.o (arch/riscv/kernel/cpufeature.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/riscv/kernel/cpufeature.c:1140:43: error: ‘RISCV_ISA_EXT_H’ undeclared (first use in this function); did you mean ‘RISCV_ISA_EXT_h’?
 1140 |         if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_H))
      |                                           ^~~~~~~~~~~~~~~
      |                                           RISCV_ISA_EXT_h
/tmp/kci/linux/arch/riscv/kernel/cpufeature.c:1140:43: note: each undeclared identifier is reported only once for each function it appears in

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:9c2d7156a851892d9928708e16cdf53f301aae26
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  b12a02dd090ec1b0b00fc16d1be95e7b53677ceb

# Builds where the incident occurred:

## nommu_k210_defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ace2945a3f195e1aa7583bb

#kernelci issue maestro:9c2d7156a851892d9928708e16cdf53f301aae26

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
