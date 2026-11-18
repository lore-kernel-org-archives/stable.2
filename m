Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794983273;
	b=V6nT+Tsdp82l1YcGQqNaYM5l7t2TrIWAni+M3s5UcvvKpLt7GFoW2/H9X7CgwbDY611m
	 yV0nRi8iMGarZ9jDaPjsGQFtzC5Ad6oW3tCYQi380ai+RXkwGVeYWnxDTeP+yGfWbiBVz
	 XQ0457+7zYvO6uK0iSLci/kWgT0CKM6pt3MJEcGPGuBw6OQ6W0FTd3VpnyJ1Whk5OZs1U
	 jvjIyTm82D8khDeWWjZsD4yQFN1/ONT6WsxDIneI/l1vhLa0/XzpOnBdfCSde/cj+bKIs
	 VWAJ0snMgMYbChyPZmKLOSdSe8tOkh1fzdQ+d9aNYdMZvooCxf88Wdz/A9XC43fmE6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=u5Ctav/yDjXLRSHJvbAGfgAiHawDLtclHE70KW98KZA=;
	b=2DDgEnJWHB2XtU+djSLVocbiJQ5k+DpszKSHoG3+6YkrfgfHlh7CAbDl6/2+T6qLyJlT
	 B/D/QNtkzFN8rzRf2DKpSF6Ei+9tJrNi2/agpnz5eS1uliyxSEkSGIv4kQPU49GCkZuZ5
	 nY3A1tMF1Gu+RlfmB40ihBeSFBedStEZkPbmd3RMi5xhlKuFnMyHRnwE/2T25d9WL6epT
	 g6D7KmrfhvG0dZkjd5vGl86E7uO5HsvpUcUJPcTRj3C2ZL14/KoqUKSkCeGm3LkkPnoc5
	 etASM1goaRshutvw3AurTogFaHEZ4+IeM2xm3SRTpfvGHnN3ZpUfjx+x4DkIyS3d5RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WXeG34R6;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B5606A330
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A5B5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WXeG34R6
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso364568a12.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794983272; x=1795588072; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u5Ctav/yDjXLRSHJvbAGfgAiHawDLtclHE70KW98KZA=;
        b=WXeG34R6DDZWngdAiJaA7PHvZ+uKaDZCO7R75Gb/fZ5hR4hqnw+Oj05fyFYLPZ20aH
         lbxhyngcn0slgj164eujmb5/+SJC+8ah9Tennp1z0ZQ3ShlHv7Nr3QsQ4SPr9dl2JlZ8
         ogZVVmxe4pIimIDxBdPJ7Ev5355PJdJp97ovhBknNamNrmYhhK/SGJjxNb4gjOpvwCpq
         t9hd6TV4/OzNpS+/lUjU4QM8KWrgzA1VkT2iceUk5HB+c6kjU6pfzdSPP+C4fHNQr64a
         uqidN6z5JhYNhWASGiplpEFeVCNXuRFK5QyLHAC/1A0CIvrpq+XDyZqcCyky9HqyaRq5
         3LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794983272; x=1795588072;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u5Ctav/yDjXLRSHJvbAGfgAiHawDLtclHE70KW98KZA=;
        b=TS/Ny0ywg+GXQ/wGnAX9q+QxNLQ9ayP4gvTg/m+RbqCNkjQbbShycVtMAK2RdDV3Ec
         hdwWmF23fvccPWPUYjjm8bTiZytupayfV1jfo6lzgF3haAFlDtr4AXy/ZX7jb/GID7hQ
         REvD9Ww8fDjMsiY7gkiKOnqQecYiOx4jBbb2r/HF+pB85/nRPM+odtkYQBdig6hceUPf
         ZvkTMcj8ze1/JN2OQQl5rgLb2RR7/C7bqMkr7cRx7zJla67y1gDJbctuRc2SjinB0Fg7
         rCPDRc8xM/NOq55I5Cc1iTRBoyGJU6Ja5CnZ41bqubV15JqXsgNAnHVuOZdJtz1ig4Ix
         OGBw==
X-Forwarded-Encrypted: i=1; AL+hErFWxMKnNw0kHIDQQAaNjJpSOge2/7+sbwMLTvOl99k9oySM/gQAS7P8mQfiHf1AGnvvB/h4suw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+amMSuyfHXX8zontYQbKnKodDE9zt3sJEBT/a8ebMZR/cPs9dv
	EmBXV0UsnjsmP0YvOgudC3X3vvGbK/Kz6L0HlZgn0jJ2JxCg9Y0o3Ir0CgUhbA==
X-Gm-Gg: AZFdTZe3UDG1rJjuUiTKSXWNBcXodI65L3bPPvsDwsJuIk9n7vXbDhgFVXsD0qUwaci
	gcZrjeLLsUahCppso+ktndZnP9luLTICgAhqVwW750QbG3Js/m5hGxlLzcX9ZcztjlkMFBsT8YZ
	+jphYAsD5Pu8IbL7EZEXAcZ/cmEKNtXre1jtJJCZVqhVHaQoiXpJvPleJRr4iQeZkD7uJG9AqTj
	e9+rhP00a1amx2exEmXt7HF9f9aCgfkkMlEkaGMyAPRZLuxZKiADOXFbhhtfxJY50uMPaHyegUA
	jTYuJ3HDKWT4abjj9J0AEUYxCcybHl8uvCOnmOsjQbW1L29sQNaNO7HO1FD6M4mqYY9QBlJKUEt
	IgBVOm27ddUUK4OCm7U7o9+ulqKXRRCVM5BqWTepI6rgTfzTj4YOjS5WSfeiZJTw1985XZvlY4b
	ufP/8tB+eGxEj0wg0iouMn5DPR0sFCeVZ5vJWSFiE57ZT/ge/izx+9/+u6wzsF/zfd/QEYPCpFg
	fD3nhQoi0rIyiHK7frO4sL8eS4qABPj/USy0lAfPfn2TnBV7muoqZ2orbtd29VvElm5QQ90kVuH
	q2bLwmVwJVl/+gOOBo0ReneNjWEXHBYNwFzuTGpAxyZo9gE6m5PmdgNPyaNwy+Mu7NMSm45U0qH
	ZzfgFGHfxyb5X03+qi+efV2vg2pHw6KwT8+ngQV66itrA7uVDZa++27XN
X-Received: by 2002:a17:90b:2d88:b0:3ae:8106:6074 with SMTP id 98e67ed59e1d1-3b3d07649c6mr1578634a91.16.1794983272450;
        Tue, 17 Nov 2026 22:27:52 -0800 (PST)
Received: from [169.254.3.1] ([143.248.188.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acd118sm2576836a91.12.2026.11.17.22.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:27:52 -0800 (PST)
From: SeungJong Ha <engineer.jjhama@gmail.com>
Date: Wed, 18 Nov 2026 15:27:44 +0900
Subject: [PATCH net] net: release netpoll dev_lock when NETDEV_PRE_UP
 vetoes an open
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-netpoll-preup-veto-v1-1-7d3fdf101d3a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF9F/WoC/yWMywrCMBBFf6XctQOdGiP6K+LC1qmOlCQkaRFK/
 91Rl+c+zooiWaXg3KzIsmjRGAx412B43sJDSO/G6NrOM/ORgtQUp4lSljnRIjXSye1bdxidZ9/
 DjlaN+v5JL7A9rv+wzP1LhvrVYds++xXTS3sAAAA=
X-Change-ID: 20261117-netpoll-preup-veto-943045f4616b
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neil Horman <nhorman@tuxdriver.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, SeungJong Ha <engineer.jjhama@gmail.com>
X-Mailer: b4 0.15.2

When netpoll is attached to a device, __dev_open() takes
npinfo->dev_lock through netpoll_poll_disable() before calling the
NETDEV_PRE_UP notifiers, but returns without releasing it when a
notifier vetoes the open. The next attempt to open the device then
sleeps in down() with RTNL held, and every other RTNL user blocks
behind it.

For example, with netconsole on a wireless interface, cfg80211 vetoes
the open while the wiphy is rfkill-blocked. Release the lock on that
path, as the ndo_open() error path does.

Found by an AI coding assistant reviewing __dev_open(). Reproduced in
QEMU on an unmodified net tree with mac80211_hwsim built in and
netconsole bound to wlan0:

  ip link set wlan0 down
  echo 1 > /sys/class/ieee80211/phy0/rfkill0/soft
  ip link set wlan0 up    # fails: RF-kill
  echo 0 > /sys/class/ieee80211/phy0/rfkill0/soft
  ip link set wlan0 up    # hangs in D state:
    down
    __dev_open
    __dev_change_flags
    netif_change_flags
    do_setlink

With this patch the last command succeeds. Selftests were not run.

Fixes: ca99ca14c95a ("netpoll: protect napi_poll and poll_controller during dev_[open|close]")
Cc: stable@vger.kernel.org
Signed-off-by: SeungJong Ha <engineer.jjhama@gmail.com>
---
The fix just drops the lock on the veto path, the same way the
ndo_open() error path a few lines below already does.

I tested it in QEMU on net (297ae1590173) with mac80211_hwsim and
netconsole built in: the reproducer from the commit message hangs
without the patch and completes with it. W=1 allyesconfig and
allmodconfig builds are clean for net/core/dev.c.

The bug was found, and the reproducer and patch written, with Claude
Code (Claude Opus 5.5). I reviewed all of it by hand and re-ran the
reproducer myself.
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3c58db732761..0be9e78572ff 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1748,8 +1748,10 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 
 	ret = call_netdevice_notifiers_extack(NETDEV_PRE_UP, dev, extack);
 	ret = notifier_to_errno(ret);
-	if (ret)
+	if (ret) {
+		netpoll_poll_enable(dev);
 		return ret;
+	}
 
 	set_bit(__LINK_STATE_START, &dev->state);
 

---
base-commit: 297ae15901733df7562a6781613fb49f3d270401
change-id: 20261117-netpoll-preup-veto-943045f4616b

Best regards,
--  
SeungJong Ha <engineer.jjhama@gmail.com>

