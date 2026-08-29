Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B3330656
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787970613; cv=none; b=TmSZNBWS5Q9LLTb1Ad59HHFJnDxtrut16a4/gdvKn8N7SFNpO1icr39ozXw0MoiIq51jSaJtdqqZG7Rufz1w8k+7AwBdKpiizY3kvWOKJdpsRgeuuVrJLgSAKTltYJSSV+N007S/3gLz1zcH3H5uD6djk0JwMbZkyar+MEh9sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787970613; c=relaxed/simple;
	bh=qTaGc4peh/g1kIkgZyhwe/Wud7snDEBBf+RfkhrXpC0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=T1GzhlSnjzAjRCBt7sfau5j+noL4umVCsJBABP6VmEt9T9uTyvZPb3keCBJqFt9LRahHXJVUdlekdrwV7lEIDBt7SHgASZXoeKsvVnkuluPI1Zo5LqB0oqhDG6QbFv96Zxd1bk/Abkc9rwUapfVVrIhItzs9fQUE7N+tpWCIE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=iH6zDxiL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="iH6zDxiL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca80d708489so1143334a12.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 19:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787970611; x=1788575411; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W84mEuctjgpo1fE3bjqvwcLOY4hI51hge2XbZGKxWD4=;
        b=iH6zDxiL3vlh+CtrQte6pw+6usdI72fSQyF55uynBh5BNCexAnA2IHpMfAp7e/QphJ
         Q45wNAln7B5LdTkDEa7P8YYv2/ghqOoHoVDPjLla3fA8dypGD/yBgfqO8NJN2RBoS89Y
         4/4XDYk75BHv1kO4cpPMWZZiEyyvJOiUXbX+7knnUKI1Ler6+5QUDLC3fyg9X5F3uaB1
         8j5TrD+issMB0pzzN6YjrSLfXp5aKVPBeRYiCCYmAoIi+MoTo8G1JXt1HLYQZbP4gTXh
         /KP9nzDoO0fpP+YmlUHc8klkDz4oDKTnVMOhYlK8e1YwKTj3LD0EcSYAWCYoP0MWhCLV
         HOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787970611; x=1788575411;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W84mEuctjgpo1fE3bjqvwcLOY4hI51hge2XbZGKxWD4=;
        b=VOUM4oyxCl4BYS1o9M3KnQXWgjzAqz+u6xDuGvbYh1Gs6E6R1tMog13nx+JQ/Jn/6r
         mWX0BBTjQq64a3sftZ/KzlJtWNUzcFZaOPtY77zLdphMZ1whP4q7xE1Qif/Hh9nvAtA0
         s7am1x3ID1cgRuDDl4kteMKtppFzu1Q+oDuX3zL0A669VC+elUmlhtLfnqot2DH8gTa/
         bjdfw+qP0UplhL+gi0UlFh/JiBDQ1yHGWV4dIT/jUTYkZunjOJrdEatT1waiiiQ9SIyV
         93yOGliXHENynUU4bPUctK1bdgcpCs+6ziSCjKPwmJNFgN9oi9BpMIA2NwwtoRIlw/rp
         RDzg==
X-Gm-Message-State: AFuF++n+KB8yMcKvOfkTtrSul1dNK52dqAZ72Nh11iocdLnzTIM3J7iv
	wXXpwnXrqFcIu1w/hEffXtxLpXRZ1j7jaS/mrZRiP3qnWOPqr3CF0idectZUx40LQcVPdSZA2uD
	Xg9gV
X-Gm-Gg: AR+sD13ZVfi4ScqbYMvbKa6ZDs5mWxMiMuUl9D2ntjLfzyupTLL3tYAcxh8ki6IR56w
	TBO46qzM/+U74faG7AiVGK1YCCdJXdY1bHHZgUvTuH0+ItRd1bPFCtMmS7VSBIJqQbCWLyPI5ow
	fiuiuJAsa+JByJE7tuNfwaclsWMgVcmVytBjueV32ynrzsD/LA0ZIyQytzt1v10mwT+unNxw40Z
	PdviiG6YRGnbMK6Wg+oI+tlyPpml9/PaSBD9/n6rIlSyMCCxZt/Q73Kn9HnUSt+4O/5ra/7k9q3
	3/pjJSrjQvW1swRBgG04SbjfwcpGJMsZ6Awui6FV7d8NC2OStVo9UDQgXzOgYoqPgEaQdM7yRBU
	kt/qsa45D7I+M94Hl3RgGATVJznRQNk8DYRqU/7ieTNuF/rhp9J6blh7Ytik/PWiDPyTc1+sgdW
	W78xVcTj4wEuN+HhOazLyea6tmBW1L0jw6Z6AX4KKUk/3iB5dCektvX7Pm0xooKuw=
X-Received: by 2002:a05:6a21:7e09:b0:3d3:aed2:6f28 with SMTP id adf61e73a8af0-3d3aed2736amr2841313637.28.1787970611119;
        Fri, 28 Aug 2026 19:30:11 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be607sm10251886eec.10.2026.08.28.19.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 19:30:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 38a5e4f139eb1933f8837e7e2a841810d90cd44c
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 29 Aug 2026 02:30:10 -0000
Message-ID: <178797060995.6229.18139116565265559068@b455de3d9de8>



Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/38a5e4f139eb1933f8837e7e2a841810d90cd44c/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 38a5e4f139eb1933f8837e7e2a841810d90cd44c
origin: maestro
test start time: 2026-08-28 07:16:00.088000+00:00

Builds:	   49 ✅    0 ❌    0 ⚠️
Boots: 	   34 ✅    0 ❌    0 ⚠️
Tests: 	 2193 ✅  252 ❌    2 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a914e9dc5867fba946b1294
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
