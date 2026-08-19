Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D948C8AA
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158775; cv=none; b=KISNCxQW4kJcq6ojFBF92fvyNUG7LaztxtvZjzeC6ZIPBRnmtAtU6EJ5wFuZ8wU+mH2Tg1tBXc9AhR7qy1NiOlWBFFyXTiOW95QehK3hqbMF4VNsEE1QiTlzonag3+Ycba0kkd6XIpNNNLjqTnqyIW38hsKCWlVszFviucL2lg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158775; c=relaxed/simple;
	bh=2XaBdkgJgruoXsAicUbM+D98FdFgxNckiG2SMl4ao5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmJ6nI1MUAmb9d/QcA2eRQXaejywj1Qu0Fux1x3W6BRfSFGVFMZ2e7YZNKON2KfFHvMqF/soxZEEDSXvYzlkNzYM+8Jg7PqUmDEC6spcah/opRaev5w1vHtN21ccmfyQMTV0WlXdCXFOKy1AcqAUcHzaTQeX5H4cnrEKuSJT8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ZEhG+p1+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ZEhG+p1+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848761b5897so556339b3a.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1787158771; x=1787763571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lroOjWUQuzkzfsFV8jZnR6n9nf3kSNRY1PDaEZgo3rY=;
        b=ZEhG+p1+JhbCtDFNGxIAUWYD5ca0Am1hyiyjKbYarH7pP8hPyMVKTTPtuJ9Onu1/eF
         PvT5WLh2M5j5c0ymfbXVlgoXIQ0jVb2NWHArvDvt1QqwVllR/dD5WNl11HYl6v4cgW1E
         kJzP9C6owIloPbytN0Bq5RnMH7g2pJLHVd1XzUmeE1PsYfwrVovA3p0pGAfFZ6sxEiIQ
         A5OqUR5GzpTxfMFadIQtWl2mZX10VqOduxPgUL9kwj6OciZcG1COCEZHd+8ISKz2b3yR
         yBn5floZcmPhUc8QC+y7/e+VI6w6WGVn6rQxi7ffzCjinq5YHCpoK+EFaOATTtteOVfX
         vi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158771; x=1787763571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lroOjWUQuzkzfsFV8jZnR6n9nf3kSNRY1PDaEZgo3rY=;
        b=X9/Q+UlqWAmUz3G1Bo+VoNaVwPc4nOvVqCyT41nrJnE7yLAIv+4ar9jqJzM2ieEB8H
         Sui/UEZwGG00uPyitNEbwOoR5OEqgxfYzGjnwSM1Oc5CMP1Yis791Kph3fqfnBzgnTEc
         Nz8QL9JC/nfJQdZlw0cdqZ62H0Bk0iZ2Rcspj+ZIZ0bd/cubY6glNS6qfYlzooNzABGb
         nTwuEgPTMHXOmFB/H1Ph3kiEeg+U8qgJSeNHMFULbdonlFifnJzEHlJ1w4atzZBRXtmm
         Z48ew8vjS8CkwoepoeZhTvzHhoipxZ9Ajtix5x+6COsM7cq8I0FPK128Isfj4ve9Oa3y
         HTVQ==
X-Gm-Message-State: AOJu0YxKwopPctTdNA+zTfrfXv5WlC7zAnNxHqLAmVgHzxH0RpvsGew5
	NVlpVfT5PYcb16qj+Tp1YsnMcWnCtKMGDpXsM2ZlBANLFbOibGnJxS5DNVO/T7v+p3igNjKdoh7
	aA2hG
X-Gm-Gg: AR+sD12a604pQWr1m8ENLYfYtrJ0dHArcrr/YJ6kjE5E5IgHHZbVe06p6F8vAzg4rcA
	BkH6/7VMggoqdglz2zmuC1Q9ey0cIVXKYUXr2RhKy8+9ntiU/kYX9WRUdrnvZNofo431kBP7K7Z
	I0mwiZ3z/QeagA8ID3wVsxG8Y/5yjl/h7LKMt49tgJPDTo8vF61TrXAZ6qCOt4LwCrrPZIAz+vS
	6Jr7wdzcWOf8mFfleLmbaQznAkCbuuOGYzC0AwBB/VVYwNaELWI0nDspOGyQ+IDuxiL9YOWCH9W
	iWkTBALcpXMd2nYECAGcwjhyu5AQAbI19kSTK7S1NBEWMJwR+J5rAIZW5eC3YWv9muaj4VXTR8c
	uV9v9X8wi1wUiuWHkEnGBG+sFNNLzWUIFHBMyXhZR4+crAcZ+zq/qrY8OQkRg+pO9xePFlZaFW5
	OgCcYbnwP5ZretoJHSCgkKzCuLX/NN4Drmq/IuH2VKe3JdKhjaeXePe+BcTeUbMe8kCQXgHVI2Z
	3AgQF/1l1RAMX6XD04ywrK52NScrdWcW1nD25V+vmJTWioTVJ+6ijGZ9LoMtg==
X-Received: by 2002:a05:6a20:c90c:b0:3c3:812a:2198 with SMTP id adf61e73a8af0-3cd00e039fcmr12251148637.4.1787158770503;
        Wed, 19 Aug 2026 09:59:30 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:8d7e:6716:d5db:2855])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bec30f49sm7687491eec.0.2026.08.19.09.59.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 09:59:29 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: [PATCH 6.1.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Wed, 19 Aug 2026 12:59:22 -0400
Message-ID: <20260819165924.1184-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei <xmei5@asu.edu>

Please queue the attached backport of upstream commit 2884bf72fb8f. It fixes
CVE-2026-31419 in 6.1.y.

An unprivileged user can create a broadcast bond and dummy slaves in a user
and network namespace. Racing ordinary packet sends with slave release makes
`bond_xmit_broadcast()` give the same skb to two transmitters. I reproduced a
KASAN use-after-free in `skb_clone()` on v6.1.182.

The attached one-line upstream fix applies cleanly to v6.1.182. The same
workload completed over one million sends and 299 slave mutations with the
patched module and no sanitizer, oops, lock, or BUG output.

The fix is already released in 6.6.143, 6.12.95, 6.18.22, and 6.19.12, but no
corresponding fix is present in 6.1.y.

Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 9898d85075d150..4370ba922b2cc2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5344,7 +5344,7 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
+		if (i + 1 == slaves_count) {
 			skb2 = skb;
 			skb_used = true;
 		} else {
-- 
2.39.5

