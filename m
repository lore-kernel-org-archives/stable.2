Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413220;
	b=KzE32GOEoTel5e/sWqrH/fnxVlNV1PYZ34SDES5nwacGOoWguikqlTHv4Mgoz9SoSMFx
	 GmC1siKwgC5lWKr1enin65+0/t8+fT5omm6DD5LOyXbAAIlGvuk4vZDWWBRyBflQIHObU
	 6186OPVPf95i0y/OzJi7lRWIfpyAzWliQgDoaFRA6/zCZGANa+Kp0m5+cbvEJlGHgsrXY
	 kYMGig9vzFXvm3ZAK04IsnGaOxJmEPy4vOzr6XICNsX8krwaZKwqy0ok7Z0G3YinxPu+a
	 saXtQIAqMibaz0Zq9Iw9bDLIuXFSskm2gmDVC0UjTB3PGuLxry7mNL3pXSEuznVj7Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9BSVf0nHP4/mhP9EqbQcCZ9FFbpmkiKR53pnCEDo/p4=;
	b=Js9097gQS/ZCY3D2QMwj+01qpRAXnt/5SSAFh52heXZX8zQD4NliXE5BQX27tuSIJczq
	 sZf1WxFKbpoGtFRKDbOE+qRgAKZRtcecPaOqsSNwbdMCuWzciYNukBACrC5ML6o/t4ph7
	 ekOfJGsKRRmg4yz0BBJKDFnNgn/7mbi5KzUf4ad9DovNY4ZcS0RBCG0v9KV4IvT4inGhK
	 eZ5cIMM+/u16im7v+3sGs9EyXmQSR3V5KpLEJ/P4El5haQ+39aq4fLCXCn7t5MQYuxPRO
	 0+9Ps38hZqfIvbT+9lkMT0PehuZyD3kKBc7VD7A5maYUAm/XZcXlfks6gTZHv5Wuy1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJR7GQih;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E0606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D6E0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJR7GQih
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso25784965e9.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794413219; x=1795018019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9BSVf0nHP4/mhP9EqbQcCZ9FFbpmkiKR53pnCEDo/p4=;
        b=zJR7GQihQ73Z/nNA1UHEb+m3JMssWqtoH+69LxKJb236waKuGCqP1jBnY1+prralYt
         wJa/5JZDK5rob/brOCQgzqOCU6cr02+AK7CJFdQL81167FXtD3kIwpTsuEufcDo5D/d9
         I65c9oFzQR2YeQqMW0jhQNVQi7YHA2DAQwqo9QM5oPH7iGytXu9TJUKrPy3tCqXIKbnU
         snYM/PYdpPht4CtPBRoQ82UMQzOwTcgMl6UYE5d+5TWC2XMpkZJGx3GaxDomNCNTm4QF
         aorF8HkdMDqY9GuckAw0gkC7CknPK9+SzAQS3kPwzwFumMGWjJnTHPuqIOJj14CWx7k3
         lN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413219; x=1795018019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BSVf0nHP4/mhP9EqbQcCZ9FFbpmkiKR53pnCEDo/p4=;
        b=TElWWMWBM1Y1AVVGXcCiMBIwu1j7m4lvj7CPZbfmZXfcyIBGd0mtni6HUYMk9kItP+
         k+gtl6AHcdKNeH+n5E6XQ17tS9iVzNUH+FfXjfmSScSRolje8nsAwOEyduRIiYgxfZ5s
         +M1hcFDK8h68uwDhD9zQeSey7YYBRp26fa9CV/+rVU9R/r4RYJHkMsk3URXsxOnDYX33
         pVM2kwfUtDabw9IdtBPKAoDrfbS68600Zou3hSGsQKo7zmB7sDkBwkhQzvBsnXEBHxG7
         fPvHFTXNBbcMmnbLCWCPnktLEzCf0WTFy/xj99kz+3q7rgxaWs9GNxN9AwBkfdQdfG1p
         /h8A==
X-Forwarded-Encrypted: i=1; AL+hErG9c7ga17L9mL/1BAw4XR87hwjGtXoiRM3FXAiLGKqjFMIxFAAB9UcLPzqAkatsPvZfP5kNs70=@vger.kernel.org
X-Gm-Message-State: APuU4Z8J8FQS69sWZeI7ylE50f+0NaSxjQOY+XTppuvDZQhjspKtFxdm
	x1dxGj9i7tjeAIvku9FkpnDahXrKTAoPasL+VvbwvR5YbgXWzB96eCE=
X-Gm-Gg: AYBFou2/bQ0ik15VetpUKc6Lw/l7vYrMnsoCIcd4bLbCuP64YD2sffoXi4SGQY90aSl
	V9J7vP6k3DhnCtOE3rHnAp4Yd1IYoHme7TBQh/TOjRR2xtdB5I+zBBNHMjfQr6Oefq8XQU4JJgC
	mAKBkm2rs1YWcFCuZN4Bn+F6lHAtpsD8m3wXVrwJq9chRJkAQZzPnvFBGOB1sQJN/asPtmRi0s2
	XNYLsGECEbOCZxdubpCVExOYY9U4qttczOstKnnEqH1vuP02MDulIfCjVm146/VTRYUonfQA7Cw
	lpjdpqbNcrYq0V14AcKpvp2Mv1GRET/lY/qVMmunQKyzdd92ijrZfT9aN2Mr9gSiJhUkNjr+imP
	PCj7K4jlRXLecX8LnLImh6PUX9lhvliF+MlikH2Ne1iKySlS9ckRI/qb1aYA+/BpaeDde+1cAtu
	V2P5jqu3tGKrq/TBxjUCPV5JENb1JrUN3o7nxwGWauzFwqLs7dswWj4bFfx1xs5k7Z9u/8MbrSM
	tsKh/z5A/qMqBM5g1Z303NcVAp6sRo5I3kizq9IfQd2+hH6lzguYwDBlkKXv0JkyDWtaxD9tlR4
	TJ3cvwdomAvuqRM=
X-Received: by 2002:a05:600c:3e07:b0:4aa:1527:659 with SMTP id 5b1f17b1804b1-4ba0938369amr51998385e9.17.1794413218559;
        Wed, 11 Nov 2026 08:06:58 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c57e999sm8350485e9.1.2026.11.11.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:06:57 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] net/ncsi: use kfree_rcu_mightsleep for RCU-protected list entries
Date: Wed, 11 Nov 2026 16:06:49 +0000
Message-ID: <20261111160649.677910-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

ncsi_remove_channel(), ncsi_remove_package(), and ncsi_unregister_dev()
each call list_del_rcu() to remove an entry from an RCU-protected list,
then immediately call kfree(). Concurrent RCU readers traversing the
list may still hold references to the freed object.

A similar pattern was already fixed in the VLAN list, but these three
sites were missed.

Replace kfree() with kfree_rcu_mightsleep() to defer the free until
after an RCU grace period.

Fixes: 2d283bdd5b20 ("net/ncsi: Package and channel management")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/ncsi/ncsi-manage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe6..64274a5058346 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -263,7 +263,7 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
 	np->channel_num--;
 	spin_unlock_irqrestore(&np->lock, flags);
 
-	kfree(nc);
+	kfree_rcu_mightsleep(nc);
 }
 
 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
@@ -326,7 +326,7 @@ void ncsi_remove_package(struct ncsi_package *np)
 	ndp->package_num--;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	kfree(np);
+	kfree_rcu_mightsleep(np);
 }
 
 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
@@ -1969,6 +1969,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 
 	disable_work_sync(&ndp->work);
 
-	kfree(ndp);
+	kfree_rcu_mightsleep(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.47.3

