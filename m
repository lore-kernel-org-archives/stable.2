Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49648477E58
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394967; cv=none; b=c3N72tssEjiW+AGhSJlFIz+rd9Awzw0H62kmrLMm6rq1IBc5XHakrjapbuxki/KkwjvwkLfhFc7iatJKHKv8HodDRZfHwmZCfvVPuMst5GLkQQYeyUkrUmg4gjLOmmaUzZx2T/qDtEovUTHNgXG7PuXLc/apnqiGFsRk8X9oHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394967; c=relaxed/simple;
	bh=Sx9v7HQiEuMQMZvcpJR8rOdiRwK04scS8R7dUc9Mdd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUDN1y6Q3xzEwkOyxoKWPkmPDrJhSJUq0VmijDaAWZE4kO9B7nY0FcsBdLufaOGxHz/vtiBqWIXiPAca9lWZVXTNORONzdvPwH5mF+ZwNR3VfJhUMVLy5RCiUzbiBftmPn2Ndn0Xk7IlCd/OKxNml6z83gvxb15J8dXpaE++WVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUG4NIdx; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUG4NIdx"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b1a4faso763121e87.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789394960; x=1789999760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pp0hFi9J6OyCUNkr2fkBiI3LoUNXdAPY0thZeRETuic=;
        b=OUG4NIdxrWOv4nsxlrEkH/NERMzSyv8+xM3bqd5C7mplN6LnJtJWoztDjVeuFCs3O1
         m0rpUneCPhLnuUNItZBXY/+de2TCoH9MmJpLsj1YhnMt5Ew6Cd3/txbY//ewnAU5zwzy
         3MLS4Ot3YdnN0GuTfEJi8JIhPdULkN/PfSgYLg6znIdWMf+2Z6P/aLR2OuB5MmSsdSdj
         7HP9sKb2xD4MIDABVRVuuFb3jFSO8CKYUizQjcnJKT92L/pUGLcTHb69POFz/SFb06dA
         /Vgf07pSSlGHWRbmRgx2MSD1DVXsQ49ykfl/G2Nw1wof9gf/nA2jL/l1a2R5SlwRsWup
         m81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394960; x=1789999760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pp0hFi9J6OyCUNkr2fkBiI3LoUNXdAPY0thZeRETuic=;
        b=K7Dg2cV1GUbB1LvLIR3N35tF1Sh6QnjgAQeP2hLNxpJebJQUe1OOcTd5R9Ohgs2VBo
         6Nq3tTRWTvvKJYeJvwbIdvDVB5XoxrqX7Ovnpzznrxa0e1uWMSU9TGmZAEp3sDZGQzPy
         Msrj1YOvS71sVOCYkZJyzzz1eVVYeneIuK7OCsA5aJRLneb/yi685bXB2ThxyA99fbw9
         p8i+gKpe3IXnXI2vXUZWBjij3kROQanGcym3sX0P+dNDraiI5UPYiLeN+3vs2EekxuXp
         8LTglLlB2KYFfl/GzGTAAMldpBDaP9gA//ubgCMXCDYpYHeYNTAsY4mzF4zLfnHPzF9D
         05jQ==
X-Gm-Message-State: AFuF++nqj5ARZJ8uz0xrBSGspnK+9HNlD2COIHhbA/LyjKG11s+0yw8K
	3Yki0FIrxstT6xueoVGzFZegZFFWd8JNz/qPMQuj9jH8MD3/SgH0L2O/lVzgs5Sv
X-Gm-Gg: AYBFou3E1FWSEXRhWqv0HJ7I2wmIfBFOzDtLmujprDwUEiCLlKiU78bHkIgerGVidTr
	+71iaCUhY0vANBNXEqbxMtUEik9S3/eQJ8ljdnFLR0cvUk3em9H4kPBWBoCoQg2zcAWMnoxy+IA
	JiKAsx30DrBMuasIDEc1z12gFi7vYhcfVTjTo4M3LKW43sUUq6Q0JMTD+EPpiz+AlBNy4ZZg9io
	GR2G8OyKsYEJS1gIeB10ZUdi9q60OlGjSb0p/1DupVEbRtZ0PyPyRCBpfyE0V+C1bkHYrp15exz
	6uuqRFNpl3Tj4lPy4Kqbm29tdu/+TLc/mzj3zdCNaNao8hJZlpHoJerMcvGOub+T9k7phkZN6Ud
	JxhC27xVopeEAEzf+MYbxQVbMq5ToCNe8IcwTMGZg56/W9xdx+1qGmcuZ6fxuhnFsloC3wX/dyv
	Yo91g6o3K0FSpW9Xv7MuPcKmJoAIcWaepJ+a9i9E8cgSkuGXq0qWKW+IUd0RZdzHsSCvE85V+IJ
	2reK19vKKupZQ==
X-Received: by 2002:a05:651c:a189:b0:3a4:9eb9:b9a6 with SMTP id 38308e7fff4ca-3a5c86e8186mr4063111fa.0.1789394959809;
        Mon, 14 Sep 2026 07:09:19 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3304565sm25772221fa.10.2026.09.14.07.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:09:19 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	lvc-project@linuxtesting.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Kees Cook <kees@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Tom Herbert <therbert@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10/5.15/6.1/6.6/6.12/6.18] fou: Fix use-after-free in fou_create()
Date: Mon, 14 Sep 2026 17:09:07 +0300
Message-ID: <20260914140907.196765-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

commit b14361aca6350ff7907b0e9903c7b94dc7d5d4a0 upstream.

fou_create() publishes struct fou through sk_user_data before adding the
new FOU port to the per-netns list.  If fou_add_to_port_list() fails,
the error path frees fou while it is still reachable through
sk_user_data.  A concurrent receive can then dereference the freed
object in fou_from_sock().

This ordering issue was previously noted in the linked discussion.

The failure is reachable when local port 0 is requested.  Each socket
binds to a different ephemeral port, but fou_cfg_cmp() compares the
requested port 0 and reports -EALREADY once an entry already exists.

Release the tunnel socket before freeing fou so sk_user_data is cleared
first, and defer reclamation with kfree_rcu() to protect concurrent RCU
readers.  This matches the lifetime handling in fou_release().

Fixes: 23461551c006 ("fou: Support for foo-over-udp RX path")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://lore.kernel.org/netdev/20260502031401.3557229-12-kuniyu@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Link: https://patch.msgid.link/20260722083858.182506-1-xuanqiang.luo@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 net/ipv4/fou_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 0e173998f1d7..790791d08a1c 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -636,9 +636,9 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 	return 0;
 
 error:
-	kfree(fou);
 	if (sock)
 		udp_tunnel_sock_release(sock);
+	kfree_rcu(fou, rcu);
 
 	return err;
 }
-- 
2.53.0

