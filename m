Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A93F39DC
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192564; cv=none; b=itk7SkxI9XPr1Ksy7X3iD2tX2mKwyQqXN4WlYfWJeRzorfH2xZE+hFIODkXZoGfdmPa5RD690rG3rlfCksYBTA3cq8X0r6dLzyqr/wSaifmFqLjsW4hzTVpt60e+pAiCMup/Pgbeda32MeAcGo4PaAjXZIbkVfggUlkZPpzTbJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192564; c=relaxed/simple;
	bh=qArU7jGvFOZuD/4gdttHvUBeXvJ2+m/yQhcjCEo7q6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jyWNyineRvPLG9WsecXz2QH6htrhCAOHyNVdXHvEdV41CUho3IyeshzareDG9MqDzRPUVe72qxkw6pGL44IOtMY3p78SLD05RXWzxDM7I9h4dGxt/CEGQM5j9VvnJK/s8D31aL7Y7OrhpVFf/JwkzoVuzrs6NMZj4jl/uXqNql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCgdSxD4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCgdSxD4"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c86945164so54162791fa.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192558; x=1784797358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kn7GeBfx/Msft0TxexvhlKJDP63ENruWeUlNuJK7TPE=;
        b=GCgdSxD4Ye1wQdVXR0qjJTyhGmbKcFhkB9MXXawuRaIClmzQL+rqHb8htKIk4BDIR9
         74lD/frL585vQN4JjGmzls9hfCzPBXqUIYqj7hhWM9wSRanY5Wh9tERrDxOa6y34oOrb
         J1IzJggI+B6y1zE4XHlnmpvFTWIR+ERIW8t7lIORg31SxZsbL41V92sOnmgp46292lhA
         /66rSnmKQlz5qMZABpekG9S0vi6FxcgMO2dOhFoJyL1ZcedEOsouRltDPA8DyF5Wtofo
         T95Za7qDhof/Vw6zJfJuGXT1LOiPyZWjJhhsoYAMEWoSshuT+ULrk4WXJ3RCShxJNbNK
         ZN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192558; x=1784797358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kn7GeBfx/Msft0TxexvhlKJDP63ENruWeUlNuJK7TPE=;
        b=V4xIWmSRXZNp2HXQvePojEpTPKstBcdz/tdWqRs5U0AuJVPuHS9eWpSKNihqXA/Pdy
         FHfa9EMxFG0tMthHNZNVKe0hrliXyS8Pql9y3IUAdt+wp2TFryjRcszwe+luDMT1UeJy
         gpFaW/nhXjdbss6YTQhCnXtvP3BWg+b4o4QM2PseuwDVf4vYg8pOa5aSGe0Ni7Dgm7QJ
         OgEtZuw+VVhkg/+rbBjiKJclxg4uWLQVzXLUL5+d+9bMHJHuosR+NvmZD6IzuWidFQ8R
         GPqyCTRUTJyIdtNZY18z2IqqH2OtwpUjdLrOjcC9qr5ZG8uCDlpjSsq+5LlAQrMGX8bf
         MJng==
X-Gm-Message-State: AOJu0Yy+anl+Hnb6X6ZvswKphUs2EdAzAxcNVFXWxFXTNrY81PShBMKu
	WuS0+Kxr2JzJ5TJUM2K+pMVAXJo8Zw7ItU8C6cq/STxRfAlR8K3X/R/FLj6+VxpSPlM=
X-Gm-Gg: AfdE7cniQXrpaOCUJfovbRGfyq8DNtS000cZLHL9rTHiMjaNNNTgu11sgsC7i1CFkZH
	ZACg/PsnH497X2FkUE0gn1p/sUNQ8PwZQQIL7oDyU3UhldnpLPwJhOw74n1frP+xF+/C/ssNcpP
	YEoHD0xsDo/Bre3nQteGNDE+7PRb/XOvt44vfYHBdcSlGjn+dwaHjUpqyVqsQ1PRNZSB0y39tsa
	AtkF1Kosi3vdYIdcDaUHM2griuwGBZfiIFoXw+TLlbGOdL7McnYNeW0PpUGvRZxoQ9oo+80D+Ii
	QmvovrmOtEZYtol/M3XJk4oG3XtsAw2xK6jgWpsZUsrPEfDkDrni7g/crVFTs9m+U4XywRNc0Er
	GhJWBihIgLedVLu2zEsdiY8ZPFQXvnQ6o65i18sMiucr/VFTvd/94VDsvq+ig+OhSW7EWPUIiwI
	y3XdEoXD+b
X-Received: by 2002:a05:651c:50d:b0:39c:9dbf:f7b3 with SMTP id 38308e7fff4ca-39db69fa9cfmr13309161fa.0.1784192556314;
        Thu, 16 Jul 2026 02:02:36 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84b1c943sm41222011fa.18.2026.07.16.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:02:34 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jungwoo Lee <jwlee2217@gmail.com>,
	Wongi Lee <qw3rtyp0@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH 6.1] ipv4: account for fraggap on the paged allocation path
Date: Thu, 16 Jul 2026 12:01:45 +0300
Message-ID: <20260716090147.17201-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wongi Lee <qw3rtyp0@gmail.com>

commit eca856950f7cb1a221e02b99d758409f2c5cec42 upstream.

In __ip_append_data(), when the paged-allocation branch is taken,
alloclen and pagedlen are computed as

	alloclen = fragheaderlen + transhdrlen;
	pagedlen = datalen - transhdrlen;

datalen already includes fraggap, but the fraggap bytes carried over
from the previous skb are copied into the new skb's linear area at
offset transhdrlen by the subsequent skb_copy_and_csum_bits(). The
linear area is therefore undersized by fraggap bytes while pagedlen is
overstated by the same amount.

The non-paged branch sets alloclen to fraglen, which already accounts
for fraggap because datalen does. Bring the paged branch in line by
adding fraggap to alloclen and subtracting it from pagedlen.

After this adjustment, copy no longer collapses to -fraggap on the
paged path, so remove the stale comment describing that old arithmetic.

Fixes: 8eb77cc73977 ("ipv4: avoid partial copy for zc")
Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/ajFR1eLAIs42TN3g@DESKTOP-19IMU7U.localdomain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 net/ipv4/ip_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index f5a2ad2b2dbd..778214137e4a 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1117,8 +1117,8 @@ static int __ip_append_data(struct sock *sk,
 				  !(rt->dst.dev->features & NETIF_F_SG)))
 				alloclen = fraglen;
 			else {
-				alloclen = fragheaderlen + transhdrlen;
-				pagedlen = datalen - transhdrlen;
+				alloclen = fragheaderlen + transhdrlen + fraggap;
+				pagedlen = datalen - transhdrlen - fraggap;
 			}
 
 			alloclen += alloc_extra;
-- 
2.43.0

