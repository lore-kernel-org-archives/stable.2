Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A103A5431
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487110; cv=none; b=Mq4dgijBi8rAX+sdpLeJWLWbO+SJz9bDhGYWp9NvKfTXVl+YQ44/77nAaoMoX2M+qOXa0ugASST+QeAIPhuQOY1zaTmHhMdgykrryAPNzAiFbiAZtNigUvZAWPgov0lBRoL5Au/H/KPdkegOR7qwP0NvpFWdhWb8JZKXUtfH/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487110; c=relaxed/simple;
	bh=8sWdTI2zKbvIUpzyNgL4cwCK1Y9JFEfvBdTqcuw7MEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZJ3xZ02abO3l/jwODaVRgXCa5Gi1YlNB4ditJSDsRaOkP7vjIeWSNLUjiQyXFIbI8U/Wd2HDATZxHZSP5jSIhK7CYivkFaqeCx1miVpcwbrmoQwq9E5/emv531YF1z3OS5shrxuU5XOIKiI3Xz9j7ul8ZeZsrnsm2mKori7/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=f5JsRbsT; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="f5JsRbsT"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-351775aa1c0so1823809eec.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791487109; x=1792091909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pOSWDS5/Ihvyp+1XM6mV0GAPNEch8iMG3fi5kmx4byo=;
        b=f5JsRbsTJXog35XU2qcpkVcOiuFL5lyg5RiI4mRsz+Y0IsnQoWQrupXTmMvqZkxopT
         N1IyC+gLA3WIOTAsmP+JFxCsj5lRoC4TmaqR1PT7D5i1yXAyWAl+KwN6+BwqoDf1DyqA
         TOcF4x8APuYOXIKjWuvpsCuyyRU6ih0VLJfTwWC09XMe1y4qNSQLKnlKi0rkDOHzONNG
         EtlYsLOGEmFNO5grjXj/mps/45YzXXs50Le7SCd9+LIjh7YVXjaZCc576vcu/1FYpgUN
         JVwjkO0Kvg/NInp/xA+Wpe5hRbnXtvGMmK3Xbq+7T7Iury+Y2v5D5SsdS7N694A0QWhV
         uILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487109; x=1792091909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pOSWDS5/Ihvyp+1XM6mV0GAPNEch8iMG3fi5kmx4byo=;
        b=pTuwesbOHUCScuU1IVkFgRNQLK93VJyF64zP5id+hh2WkvpQBbpNXLWYsndRFv1Hzd
         OQSTeMbMONsoqldMJ336iYYEkYXmIXsZZ4HLPTIlgfN35CcIhjsIc4skTQhKZm9Z8b9K
         MWzav4xm95mhPCobnu9hAG9d7B8WetBlYu3e5F2tA9AfFKFLKddhbxtS8f7Ppa9BGnWC
         8n1XYgKOqdrki0+D9y3Gx81vekjQG7+5yD8ifGb+YZlgCJVa1gpdKaLjHHCE7/r6/34I
         3/lD4W5BROzcS8FrAppze1EtJPeU6IzF3K7lRqDrDTuQfM23DRNmXI1y17CnXUsyK5j8
         quzw==
X-Gm-Message-State: AFq9FYIqI2hGtOBd87sL3rsqAxJpuNAjD4ZQWANMdHTGkPFGCjHzKi8w
	9cID42e+lP7AeGa9lmET4rXAfmffQv9HW3hsaSpPuLFaFnK6iIrLHWcysu7TlIbcK+PUIZwb+ba
	BPAZF1fL+dA==
X-Gm-Gg: AYBFou0D+cNM6/RiyxLW6npljfQG7n9rjauB29xGJt/dZlJSMHEz1ImS262n5sDOVE7
	wCyvkYeUqk2EJg2O/Jrdhm2yjAro6x9DVSWftZy8ViJ2sIDQ7FW1SUFYQjcmcLVLKisQreVRNtf
	4s+rS9426Y3g9lgpejd2OEczuKAHcp3Sqo1lMKVmjIh5kv/3YuXTVZvcNBUIMIHy12hnGgr5QBc
	msYtROsux1CjjFGHe7EdPpnYTMYoKIfCJECZgQTifHsXsucWE60ttHlSa0jlxczFX9ibquOetRE
	zyBt6oJIaei4PGy8BjqUgKdtm10TN80qTa6k4tr3C8m2StEX5k9ArVFoyst+6ugl+ELVvOc/dTZ
	IowuBEA5McSOXVr8uy/MNDf6OETjxXc361vMcxm624VPSC2aI3GdFZTPPJbNtBkITUu++SHRTfs
	GsTdkyT0oJMwWhBo4bXKYnlZoYILf+0ZYddIskVhSrRTxE0ihfv/suOZcIGFbVsrAFJb1K4HzpN
	IdM/W3szRd9klySj7JCQEhXIs5Ju9p+4LGlwdU/S8YkHtoUH8y82bZ7OmMCcXiO4adEH3T1n90E
	1xtM+w==
X-Received: by 2002:a05:693c:8941:10b0:351:1f66:469b with SMTP id 5a478bee46e88-3515dc54ec0mr7434477eec.2.1791487108233;
        Thu, 08 Oct 2026 12:18:28 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm117933eec.4.2026.10.08.12.18.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:18:27 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Marco Scardovi <scardracs@disroot.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	jay.xu@rock-chips.com
Subject: [PATCH 6.6.y 0/2] gpio: backport CVE-2026-53226, CVE-2026-64241
Date: Thu,  8 Oct 2026 15:18:19 -0400
Message-ID: <20261008191824.98662-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2026-53226,
CVE-2026-64241. They must be applied in this order because the later change
depends on or completes the earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. gpio: rockchip: teardown bugs and resource leaks
  2. gpio: rockchip: fix generic IRQ chip leak on remove

base: v6.6.157 (79643295eba17affbd16ca97f3ef04c90266b28c) plus stable-queue
revision 958ddf240a33ef26b1771be944f0ea6c3b597472
