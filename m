Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CA74E1D
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908284; cv=none; b=B/0g+PGucEflfv3zU0WFdpwCPD4EpgG2Z/KKY7i6b+wBPsrBtvjPvItuKV+zkobotdwC2LXHxJskD4rX4EyAPFjWlcr9MXF1Qi+Q0TZLWa0NqQ6bZdLpf2j6+zKMnUQqAxSx80r03A9i2sWFPVAUj0H0Dh7cJj2dLMq5hAuMP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908284; c=relaxed/simple;
	bh=83M7wwCMjhqZfqGuGqRu74qM8OUaBkA8RtITx7gFqnw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lVRITFzAsUE1w4D0rsI/8yWwS/rht7N/+R86bOdVJdlYy7TbSW2Tp8/3umBfxVOI7Ow3kUSuEpZWiiWub4eF9ZH9z0siTGjscz4FFMJd9WDlWexqZmAuncmd0eqb0GJYTGZrlWCuyngfNi0Mh5emE0fMI51DtCvoMrFRvSNO9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz4ivTT9; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz4ivTT9"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso2144414a91.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908270; x=1790513070; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=88A4P29kDkshugNm/BCcrVL2Ujjw491ho4GN7oaB6GI=;
        b=Fz4ivTT9Bja5XAyrwSFYbqfb06aJXsFDy9MwuEhv5bZgx3OZtBmRjMRVsGKeLHxcYt
         pq+GU3sPDrjZ7oIab3Y1W4iHRJTDdCCjwUOqx3qxqkhQaXkudnjQ5ABgHl3pSkoO/JKg
         w8xU/P8sx9L8W5deIH0IXzd3DcnMFexDK3Joy+PEwlGf7AQ6l/jc9TUwt+sRGW30bYpp
         AJWpL5EBwcw0YsKL/PVOgMkEdJbQnRO800W2mM4inwIz0VrXlUhFRfm79JUlgr6ddu5q
         g3QPuYDmyE6Pljsagai2ZCLIrjzZyz+pLbUgppe8e63zR7qvXFgYxOKPY4grYHDNGpAe
         Hkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908270; x=1790513070;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=88A4P29kDkshugNm/BCcrVL2Ujjw491ho4GN7oaB6GI=;
        b=WZQa+3gbxgj7gluySGaOCwIIa1WO1zagr31CSo6+IxwCV4djHIgubpRk/GMHhKchAD
         6NkHCzKblp+02BaLhEeyhBNzK/YrfF1A+Ol+rL+i+wH9EfcLUvY2+xwN5V3tEhq11yuC
         dwSRzbbDNrvNkTlM+5hQrqXF/NicRJjyGfghN8hsNQ8E7W8GYPjhFa+EgESFQuTp0kQm
         WR0gu5Maf5enEoLWucy6Z86/bQNDIz2oyYasQRb/048sJPNl/SNEnYoYNt7LLkCr12y3
         X8m1IG95/bT6neVxMBJyCk0rqxjDqJHGM6cWGKLDNONsIz8AiwD9BOrWjXQlbrptLn3i
         DSJg==
X-Gm-Message-State: AFuF++mKAyQTtl80lEH6YE/U3J3R+8S2ue7/jsLf+jeg74LRAb1ZFSfc
	vmKX2YU/NP0a9+J6fBbKHDihgB1g1+lhVSBkw1REFiRASFQCfSszTGAl
X-Gm-Gg: AYBFou3Pr6uSBAqgFLFCkpCWlEWVJQE1w9bXKUD2vXpyY8CexSc55ohly+lTUJhAb8/
	9Q0UdYQvkMr/7DJYHeVX3j0v1dz4M/+IgyAV8eIlTmUT4TXWPbi296M7y1jWjgs9Z/q1zIOP+yS
	0hUV0h2eK6z59ntniKJ7Ar91Vqkhhjj+39l7XrLSztBGjSda+rM2TlmmrRpWoPlT8801xdLKnK8
	Yi5Hq4EJiJg0DcrrRXuyHmIKEA12NN28K6Ak9d6pgxvChjBIRh12bj8kyl86FHWjt5ype/nqRPH
	zxsgNzlQXsFk0oK3mfyQoVQoKsiX4J5PuySDO/6ONsf5sOg0nSg3HaFgkrkzK8pfmP1rdZsFx8x
	V7yLr3Dx4Mk1Cp606BPv8QYrAYa7aNi0iPumyIWixniRhkiVb+8O4W12mv5vBN9XdhRxISOiC6f
	dAU8LrgkOxoS2USKgRhlE8EN7Ye0oAIViQbiTFP6T8CgaBbfPwDFATFIW+ZzwSfTI94LGu3Rflp
	Tt45sYGhhKA
X-Received: by 2002:a17:90a:d005:b0:39d:f731:e5f3 with SMTP id 98e67ed59e1d1-39e54f0e839mr13510604a91.24.1789908269665;
        Sun, 20 Sep 2026 05:44:29 -0700 (PDT)
Received: from localhost.localdomain ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55b83602sm6080026a91.1.2026.09.20.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:44:28 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 6.12.y 0/2] Porting two fixes for the cpsw Ethernet driver
 to the v6.12.y stable kernel
Date: Sun, 20 Sep 2026 20:43:43 +0800
Message-Id: <20260920-v6-12-cpsw-v1-0-b8490c4ef019@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCQAwFf6W8sym7ERb0V8RDuyYaD7VstCql/
 +7aHmdgZoZLMXEcmxlFJnN7DBXirkG+dcNVyC6VwYFTOHCgKVFkyqO/SVn6bh80qjJqMBZR+6y
 zE1Ibuf3ivHl/9XfJz/8Jy/IDve9XWnYAAAA=
X-Change-ID: 20260920-v6-12-cpsw-f2eba30f1ff2
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.17-dev-5895e

A previous attempt ported only commit 0b8c878d1173 ("net: cpsw: Execute
ndo_set_rx_mode callback in a work queue") to the v6.12, v6.6, and v5.15 stable
kernels. That attempt introduced a build regression, because its companion
commit c0b5dc73a38f ("net: cpsw_new: Execute ndo_set_rx_mode callback in a work
queue")—which adds rx_mode_work to struct cpsw_priv—was left out.

As requested by Sasha, both commits are now being ported together to the v6.12,
v6.6, and v5.15 stable kernels. The two patches apply cleanly to v6.12.y.

---
Kevin Hao (2):
      net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
      net: cpsw: Execute ndo_set_rx_mode callback in a work queue

 drivers/net/ethernet/ti/cpsw.c      | 41 +++++++++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_new.c  | 35 +++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 3 files changed, 65 insertions(+), 12 deletions(-)
---
base-commit: fa5b06866b643cce7072a4e7c6be7ee3f0f1b95c
change-id: 20260920-v6-12-cpsw-f2eba30f1ff2

Best regards,
--  
Kevin Hao <haokexin@gmail.com>

