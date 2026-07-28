Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E43876A1
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243313; cv=none; b=l7iENSZNSKDSeAjldMYP9mJdF87SbzK3UUfn94qrNAFODQgPpsjtPzLddRXb3YLSwlcLqHXQbmKIyin4lOTouUZFaWd/vKvcXJz6tZ8Cj+RR30j+JKjLYgNYXMnZ6s+QoTJSspA9nRW3e7FIu/rYSUPyejwMeW+aXhd58a5LyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243313; c=relaxed/simple;
	bh=/+mqHkFHeQZWQoo91PDLcdeK72c5ehlB2OrXUNBlPiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/GC8+YbS/anTiPX0Wwoq5kmAZgqevZzQIk4lN6ZKeSS0w+UMUMNeXroGHwXXmEjHTZd9vjuIm16WXmzLcelNxnLGvxTK17D2yOF4FIViuIxkQ2cs5a8hIdI+rks1ByObqHoABIa5T0+X2goB5PXPUvW9Js/xq1mVsbXeBHMjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIPyzEqe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIPyzEqe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956242332dso33536765e9.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785243310; x=1785848110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z9ileo+nwDNfD8yfsO2EMCCm8J730wo2xe5C8RjlSbE=;
        b=WIPyzEqemM81XgX+dgAub7rXy65rOqsvkbWFr7oGYDfAFwiqPEVLREbb1NyS1oylEo
         knYn6PTxQ3L2/xvlNtuEz0aIsjf1X2SmXU5aLHiCUr9OF8RRlFAgUbVMJMvaQq8bhDuF
         srdPcvg2OSb2NbvN4ERU0nOCaZgnSYd1XksyUdhzTEYiUha1Te1PQzFsMBdlEtzAbplw
         c/O4tX0xtJ3gu2AxF45tuaWv62Y9vOan/2mQQNrKqzmPsxQEQC5W1CA+57ewj0dyxTS3
         cwAU+hHO4BOavP6byJTuifDaGYU61WLci2hgMoxyEzubd+bwe0ZT1ViE4Y/zY11UcWyw
         yzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243310; x=1785848110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z9ileo+nwDNfD8yfsO2EMCCm8J730wo2xe5C8RjlSbE=;
        b=kxqCUwdK5BVa8xUlsrXgNC8ESSj5yiJUbsDu7MXWihkDpXVF1ER0I7O6LyJObcNV+o
         dDWS/bh3nlw09JbXlDfwiPL5WwHASFI3iFgGdERdTpEkUvMzCALY6B4EZ+b7SmfCj3/T
         3l2pp6CrVceegS8oqRoCElTo5ToB2JPKCN8C2p8fHaK6MOb6sT/5RZUaAHyFxGvabwYC
         MNzs0s33vOrJp7/xiszXY8etPh+0D9bLnykGBu5lBDTvtJOQowXd1+Go8PBtdawTtWQs
         QqsiL7dtV1vkWg5yd3OFGAWjn6UmSX0EPGn9sDtmO24wtehUF/BIxwsQNurFfxIShjqO
         T5cg==
X-Forwarded-Encrypted: i=1; AHgh+RrSwLQ1fbewdtj3LUv5D/qeftZMViWxzDKK194Xo50O3P4ywu/GMubNl9MVgksCfm0sXn28vV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxWV4BFj0nhjx0E9Oq/HpYbvApaCTHKBPuSRVL4inYBaklqj6
	eyxLcIrEaZlqikUs/FaNfrVbbQoI8yEtOuaCNWlr+5kuWH342rATiTfR
X-Gm-Gg: AR+sD12izOTsiPpntt73Plsau8z8/HEJoem0swXmu1LNNxPuVriDiu9ZzQnpZbhOKA6
	0tzSAoRb8nFFwOilJdNDuLdH6ZxgmeoeJ6x8mrMSCUE8gMYSsC10L12kHTJ9yYJRSJSMY1na165
	d9wcD2yYnF20ywaLXL+T4FW1vhVBUHu0zlJYDaUzvY/y6hu9GYV5+guQHNUp8Ex/aP/9folcps2
	mrCH/31RR0LJp9TJKyw0Q1yV4skJJzRmkXIR/lF5Y3wYNXa4x48iJbJ5UQsvFm/nbdQQ8HqiTZW
	vtia/KvCcWHzpak71iCJLDylNb2iPIQJnaYuFaEDIzH+tq32bvya9ZSxTT2WOXjB/iasRQF0SqW
	QlNg3D/ZA2OexBx9z8+4CseZubCdDhBbQzzygMOl5e9NVaF2BGiw9vzFqa+9Ydwh+wuwbVTqsLY
	0jrI7HnUXKy0Vh9WaXGveZRay90FqNm8V6v1s2E/mgsQah3kZHtRL/vay624L0iBC95w==
X-Received: by 2002:a05:600c:8b2e:b0:495:4dd3:ca97 with SMTP id 5b1f17b1804b1-496c659f843mr30259395e9.29.1785243309992;
        Tue, 28 Jul 2026 05:55:09 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c444304esm74096505e9.0.2026.07.28.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:55:09 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 0/3] staging: rtl8723bs: fix multiple OOB reads in IE and frame parsing
Date: Tue, 28 Jul 2026 17:54:53 +0500
Message-ID: <20260728125456.32359-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 of the series fixing out-of-bounds read and buffer overflow bugs in
the rtl8723bs staging driver where length or offset fields from
untrusted wireless frames are used without validating that enough
bytes remain in the buffer.

Changes since v1:

 - Dropped patch 1/5 ("fix OOB read in rtw_get_wps_ie()") - did not
   apply.
 - Dropped patch 5/5 ("fix skb->len underflow in monitor TX path").

Muhammad Bilal (3):
  staging: rtl8723bs: fix OOB read / stack overflow in
    rtw_get_wps_attr()
  staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()
  staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()

 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 7 +++++++
 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 3 +++
 2 files changed, 10 insertions(+)

-- 
2.55.0

