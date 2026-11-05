Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906714;
	b=Mu9RyDxBslxNrpom+s4L8xl7pTdLdph/jdlHkxPh5tfg1oNwEXVJKculjjHKRH+gOQqg
	 AKN0kd5FtJP3HsM9fQsl68JaptEJGwMdEoG+c+Px4oJpDfvkdk+HwuBlY7oyrei6+5iDb
	 xBzmj+X0RM0Urr7UWZ5DTVJ0cNmEm0z5/3nSiOK5YChenc6N4im8KpT711SlzwdDuoW7B
	 iFP5Gf3i5uI/u5w26inAuTPc0H4LUtLxbVicBt3d+QIX2jw3yY697jnIe6p/9KhKgpBQ5
	 Y5cQLPj1QZVlJUeFabxaCNyAIPa8ad1XpLOyGI256ErNn+qjMWyGh6re7+IPRj17f1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pK7uBulsQM5HxeaDcs0VER9nyKXu9clIhlJ8nf2FkJ0=;
	b=KKIeN/lr9o8IK1fL2sNyAYKub5yGCJn473RxQaTqNjAq+qTlPfCugGakKYowV0bGEr0+
	 /ltCVhvFH8wpjhneivklLoS+/DlUk5cqQ15cFjEguwjzuqFpLe+b4Jyk9N2K+vlqs/ucM
	 LuoE67067IBErwI7RwZtWmwvK/OHnRzkZNHTeAHMAom2czPKJsMQf8HZwbaMrtUJINQnk
	 GdJTL75MSq1U4lTeCRFnnXGjQPjnecsUV9dIL8wolMsUUoLbPLwVhBCjfRJlY7VQNXDJl
	 4n/vOO5wfmsKjH0POeo3UVl4rkSRpau+UiTSB11qiUjwczgYKccePSiQ+7NeLQBcf0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bEScuDWz;
	arc=none smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B275606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B275606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bEScuDWz
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a49a022221so18487121fa.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906712; x=1794511512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pK7uBulsQM5HxeaDcs0VER9nyKXu9clIhlJ8nf2FkJ0=;
        b=bEScuDWzg2puP4njY7C9y4kK2gPXAOD+9K9zMDM/lmWcivieEF+zf1zO1bmoQrzxxB
         X6SZc8KHrFLS4xVYtYu3e4NQDZNld+90jD3Rlo4ILA59st2bpkbiSPSj7Lq1ZOCVTiLC
         ayC+wTT2ZQJvWcp+bSflWfekwii+QMi0kjWSmdsDKa24GZ4snarq0POoN4LbIzw4liMr
         qq/aJjL9j4Y/MXinvd5WAPYdYHF0MkEIyJ9dBckycixN4LPBrCzdRq9LpgE2zeWcP/Gh
         58MqTfOdDd6xeXcLfVCPC+8mI4iBd17YdfqA2s30F2Hvk5mqeALVqaBQCq62KNqDJHZJ
         N0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906712; x=1794511512;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pK7uBulsQM5HxeaDcs0VER9nyKXu9clIhlJ8nf2FkJ0=;
        b=gMQ0RqwuefwxYf3aVwh7ELQHaTIASPFkmk1rkJ6Dtg2QP92jX2FyCL3iCMJfdKoAK+
         s1l4opPiM2o2leKrmtXHU4DDYpBSkNIA+K1mXOP7D0FAAG/gJkT/D60i516Jta3rkbTH
         sNEkuRBxoo6OVHCTDPkcRr/cd4582UKgx7Mrtw71WjAc7fmlnvZJqZb3mv7O1zrhH+Tq
         heeIv2zNuB7SHG8m3jhtAQsnVvdiyIjKc3IvjyGEWLdOa+3GrAGD7kyqc6nmuLvDJ6y5
         i8k2c5FPZf7ab6LDrS4N+hL1ujYV4JFBZZZ1N2YGka7WLjNoTO3Ycryuyb/Hz3Pll4EH
         vtBA==
X-Gm-Message-State: APuU4Z/fxKqi9bO+5FJK0/+sQvE+1lxgfSk3e3le4Pd0TqxpCLaRQdus
	6fH0jynfJV7sc4jSDS7Cq+tcpXCbECksU6Foee37/nh/K7rCpgfKVHznUpLR9Fgo5ZEJ2A==
X-Gm-Gg: AYBFou00DOt3re+hEAyZXDRUY1PX76gMctxl3GLcVow+KxxsoAO/GBYkzOdni1NH6jy
	6nFyhjxH6YQdZEm1ahsxTEm8YJpVHAqViwpJCCNNE/BJV2yksY2LsS63I9UrumDNc3+P+N3BnQE
	iX25lW2i34yDVV009UwYIr+MqLJUuDpAMV6gsjHZNzoqagnCMSZT1HLfRc5BwNLz629r+zeW0ph
	zfRyDvsKeqb/Fnp56JhKPFK4m8p+VXovpAN6Kn/gmj0bpSx87u9afpLhScKoLclVfoEcuPGNP9e
	wbTLaN6KHoUQmSXOHSxOGn58oGCAvrgFqNk5i874n7kQco1fBxg44aI8oHG55FmC1gI8zZTu3IM
	jA/+L4/w7BuXc7aGBrJKUijD0rvv9+4rO65fmiPOhlKTaZiC0qicuWuDmakySRMFyfmQ4Kuj2lZ
	GI+gl1ajpEDCCZ0xpSlgAMii40/0Pv9uPNlgnioYXovG+5vS8DCWnQjGn3+fap5NBvqcu5Nx2av
	F7hExufoAV9eRss88GSb6ppfTwV/QkDaV0fCtA2GkxJ/bCsL96yNzyVmojvoSdSHQYB2UbTAcU0
	NLOdQRrSbdmfyYy5ZPiwcWQem1t2UmrXORBAnUDPwOc=
X-Received: by 2002:a05:651c:1614:b0:3ac:974c:64f3 with SMTP id 38308e7fff4ca-3acf3e57dcamr438661fa.22.1793906711385;
        Thu, 05 Nov 2026 11:25:11 -0800 (PST)
Received: from localhost.localdomain ([185.65.135.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acdc6ea213sm12015791fa.34.2026.11.05.11.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:25:10 -0800 (PST)
From: Trace <tracekotae@gmail.com>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Honglei Huang <honghuan@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [REGRESSION 6.18.y] Please backport 342981fff328 ("drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages")
Date: Thu,  5 Nov 2026 20:25:03 +0100
Message-ID: <20261105192503.228363-1-tracekotae@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

please consider upstream commit 342981fff328 ("drm/amdgpu: drop retry loop
in amdgpu_hmm_range_get_pages") for 6.18.y, 6.12.y and 6.6.y.

6.18.57, 6.12.114 and 6.6.160 took 962d684b5dc0 ("drm/amdgpu: fix
amdgpu_hmm_range_get_pages", cherry-picked from c08972f55594). As the commit
message of 342981fff328 explains, that change leaves the -EBUSY retry loop
spinning for the full timeout. 7.0.13 and 7.1.1 took the follow-up. These three
branches did not, and it carries no Fixes: or stable tag. It is not in 6.18.60,
6.12.115 or 6.6.161, and is not in the queue as of 2026-11-05.

The cost on a Radeon AI PRO R9700 with ROCm, a PyTorch speech model loaded
from safetensors:

  6.18.56 and before:  model load 6-7.5 s
  6.18.57:             model load 507 s
  6.18.59:             model load 514 s
  7.3.0:               model load 16 s with a cold page cache, 8.4 s warm

With the same 679-character text and voice on the same image, it renders
at 0.11x realtime on 6.18.59 and 0.73x on 7.3.0, against about 0.9x before
6.18.57.

The loading thread sits at 99% system time in kfd_ioctl ->
svm_range_set_attr -> svm_range_validate_and_map ->
amdgpu_hmm_range_get_pages -> hmm_range_fault.
https://github.com/ROCm/TheRock/issues/9257 reports the same stall on a gfx1100
card.

The patch does not apply cleanly. On 6.18.60 only the first hunk's context
differs, as hmm_range is still a pointer there. 6.12.115 fails on the same hunk
and 6.6.161 on both. I have not built or run a backport.

#regzbot introduced: v6.18.56..v6.18.57

Thanks,
Trace
