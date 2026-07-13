Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36642EED6
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953120; cv=none; b=nPW5LsQYzwCGDX23vpWN8aN30CXe+f4nOkaWGDLhnSTkBi7l7Dkx6FEANumwGh0luQPZE2oQBO52mTLuNfHR6I94OKJ7okiytxIgzG1ikbqCbymUq6T3H/DvVzpSFvzV8iHuH4lnmoXD1BS4N4CL5hf+KpjiWRJ2UKDxkGMmAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953120; c=relaxed/simple;
	bh=A2xFIOQn4EQBrTYygnbPTaYiYbMmq15YdbnLqyoZHoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGy6Tcohh5GVTn693PKEaqLy3JLXmI5k6NUPW5zecUdnoIbMkc4Cg+YISqAiZ9QZIXY5rKj3Ma112xt9M6dP9bznznxXu/1LH9L4sOabZn8xZYrMdr1dQhO55+MdZQYNd4CBSOhygdgnMcpcsupVVORLPaIFFHttj8JDZMcTOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=BUBC3eqF; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="BUBC3eqF"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92f03daaa97so123746085a.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1783953117; x=1784557917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d3Xnf5pBN/p4XtBmZRoAH7hQuhbyP5Ve4fda8RvOTYw=;
        b=BUBC3eqFnHZZihZxxvKvddgoru68dhXMc2clPdkXpQSfsHweuoAoDnLFWHYiXt1VW6
         UdOtwTbm8qu5PuCyZlc8TiqYioP/9uxjdM8k41beLW+Lmg8lJc0fVS9/LbylxWb/J24B
         EuzbAar3/EtyVHlliFD2Yvgnz2nA36w9Mou8J0qLaosI9GansqBEqu1HhAQqoGeDbug2
         ouda2fWzMw/0Z8+Ev9Hn+ause5V5iH60DS+JnCu7SuWBZvgLHHu6TO0lfSohf4ABp+ZM
         yWkFa63EmOit1GbXeGboemp3fBwBm5/PWlc2gpTP7ljSmQU0NDbFjz2Yct8Ysl3ZkxUH
         y6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783953117; x=1784557917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d3Xnf5pBN/p4XtBmZRoAH7hQuhbyP5Ve4fda8RvOTYw=;
        b=ZUWESHv7xZC5W4Ir58oG2C5jAiVWy0QRfhu2VH65AKzU/VNbP86GlgfIHpE/2dEPGZ
         6ZOx7zhCe1+mpjxKjvUmgWzBh69rXYeLgfIvx8mGHibBexhi6iGTNXp7nBzVxw8apHhs
         vV4re5VdCmrHets19jOv0qTwETE2WMfppdjEZgClEz0Jv32jEgt9UeuSmpf5rEz+iOal
         KVBIScLitkULeQLKevZFVeJdf2BIJ44TVgLDyQqinkfUOPRobcd/KT4lGtpiyAic/CXz
         7fHtqj0c1GRdMJ0bATSNdBjXOifM+ty/kaGHD5bwo/8moAVwcAbKBZTj0s4BK3Nu4ujN
         38Iw==
X-Gm-Message-State: AOJu0YyABm+k74TnTa+zLSXzf69nnL8xEVo15/jR4zUcQL8VA37Fr1SN
	tXlapDvlVd6IdkuSVkQQFQGqTGCjHXrkVfG7vqXAxeR7gXFVrwyTuRjqzosIvST+UGn3U9znktQ
	3XWqi3uU=
X-Gm-Gg: AfdE7cmbRwcbMI13ASseinHPbehbBXz2Vn61+8YtGKmvfKuVFXAZ+pOd1w/9No89HHk
	Zmte8T98xFc6BGiz41DC3ceh8Ln0URPatvbBPnBZsMA5D8/J+ih0FQpjsWLD6EY6+GyIfh8/z2t
	o9zidMCXNGLSsIxPS6LZd/H0LBFZlIICu3Y8voYfmYjiNHr59bQFFBxG8+lMAlUeN8rv4GiLTNe
	hl/6F//faYQa79JvMAp13zPfIRtNQ1nV9q9hEvmZ5vH4mGU4ZTV7gMkb5Pqlz4E0WkHhMdYM9dn
	0DJD340HIVnoQITPblFi6v28Z1+JVwq29UeDuWNUSnsQRQRBqXfADQae/WmD1+3v7OwM/IRzy7c
	fFXdCfBMz55aw557ml6cXU/IbFoGxxebp1CtyPcPHAJ7+fKOJFuRcODoCd0/4v0R0NK1moOFYwb
	az8VbanWA8K2agiqO2kzkvhezkhHEt8QjCCd+hSwcE9GsrPjU2gBml
X-Received: by 2002:a05:620a:2549:b0:92b:6805:eade with SMTP id af79cd13be357-92ef2c04ebbmr929968585a.59.1783953117044;
        Mon, 13 Jul 2026 07:31:57 -0700 (PDT)
Received: from vinp2.lan (c-71-235-107-29.hsd1.vt.comcast.net. [71.235.107.29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6a77csm1102905185a.45.2026.07.13.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:31:56 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	baolu.lu@linux.intel.com,
	skhawaja@google.com,
	kevin.tian@intel.com,
	joerg.roedel@amd.com,
	dmaluka@chromium.org,
	Brett A C Sheffield <bacs@librecast.net>,
	Peter Schneider <pschneider1968@googlemail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Mark Brown <broonie@kernel.org>,
	Ron Economos <re@w6rz.net>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y] Linux 6.18.38
Date: Mon, 13 Jul 2026 10:31:38 -0400
Message-ID: <20260713143138.1926364-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Link: https://lore.kernel.org/r/20260702155112.110058792@linuxfoundation.org
Tested-by: Brett A C Sheffield <bacs@librecast.net>
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20260703072816.644513463@linuxfoundation.org
Tested-by: Brett A C Sheffield <bacs@librecast.net>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Ron Economos <re@w6rz.net>
Tested-by: Wentao Guan <guanwentao@uniontech.com>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 74cbca8abc6c..7ee3beedceca 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 18
-SUBLEVEL = 37
+SUBLEVEL = 38
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
-- 
2.54.0

