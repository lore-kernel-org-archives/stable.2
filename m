Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439241;
	b=5p7kuyaJ32CzW7ow4KbiAEOtbTCInhe5iqf+G5GnKz2RewCsMJNb2c/pv2PUESPwPTYj
	 i1xsr2y3NbaPO4HNSBR/aPVJvrS6GViX+s73FheDqNHHwXkLb5NDH58rGG6jUugcdT6O/
	 tPUnFgo7sb1+zZgWgcYEWDQiRMTHnGnPfOCFa+hwK+OFHlZy1t5/HazK2ZJZLboScwXnW
	 hhSoIf0CE0+rEhb5UYdVhe2a++m/rsLs8FPAJz3GXC3J1bVfD1DORSOZQcv8/Dg6pOp6v
	 JFzyukEMtAtUIGxKMlWlGJBSC820PjbPhBOMB1PAZsigPqtSZdrkXj1wLDKlJYfiaEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FmLQ3VWVliKQn2ZRJTWFC6BLtQGJIqJZEisRFXqNzq0=;
	b=BbDmA5DVr7ZNXaxwJi1ZdFxIVB48QhfFUyuEZJK0r1a4J+cHxf3eTDn5X4MulxhtTZQH
	 kRywZQBUh3y83fUnxPOwQlSq7FuZ1/BcueVuAd8whAtFS3dCGaxwtn6eRwpX070uu0iDn
	 kuiDE5bw4ISD87sWMK4uxuE7Etm8Pnjo9I7Jz06/EPaLcnpf7TxoFbbf11Kr6/fshTvj2
	 d1l/TT+O8x40eH+dfThSQkD0BTfMwiQvVUeEZK+L2m8HpMHu3Ynn7Auxx9BrTntOCe4dt
	 1NxhGnKPsu099easAzUoG6DxD6G7isjP0rCh1WDcDMQZWL+5Pd7rZ+bg4+KPT/LbAgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PtOzryYc;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9F606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88F9F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PtOzryYc
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so36907975e9.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794439239; x=1795044039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FmLQ3VWVliKQn2ZRJTWFC6BLtQGJIqJZEisRFXqNzq0=;
        b=PtOzryYcTa9wHfYjTIWpauCYxkYJglLUvXHThOeWOweLgofJZMy9/zsiJddVaZn0jE
         tgJV3vmbZ1kfamsCqwYbpPio++T3w7MM83Bn9QLl0evqzRvPszPhaNJQeSh3LzN7ERVC
         xZO34+4kaHfpOBMt7O75MYCob6pSrXcr6lwlTZ3oVAThHAQMjyDIypLezvEy/TOfCxXG
         9Yiy89hCB9V6fPGyZI7yJLlPSESbA3HNUJOQ4gLSJzysa9ly2smTWnBQtSzKYnr9sJ6c
         zrTm/K8iC44n/DFtkS3dbcOXdgA8Pry5XzIjoRv24J850bCfnYU2bKJ2yIL6aS0gSyK6
         zcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439239; x=1795044039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FmLQ3VWVliKQn2ZRJTWFC6BLtQGJIqJZEisRFXqNzq0=;
        b=MsN+dafJYghvXe1Ar0OqJg92DpMXuQoAZmlpx7usFrMYmo8T33r+vbGNf7D0pA8gaJ
         lUt+oqkRLTXJTOFrpR35zf4E0ji4ACsgp1DpKbgB7/XYnIiOpyCwN6QHR/A46RqhCsA6
         hVNDAPqyasbTRthXSLLX7VdfPuEHxclVIR1vLcGIGx6uOjUaf2evCIr+pWxfP32rEfbm
         TfoLdgx4vZ9q3Wu41Rg+GsLuPauITsz1+kXn02h4SjTigSd6nbnhGYobupg6+kigVOvb
         rojKk+cqiQrBQjbVKsWB5ZPmo3cQtWINuCrfRmy3Yme7+FsuHVU749M+O2tKRdKuG3Wc
         f9bA==
X-Gm-Message-State: APuU4Z8urj9Kvu3IfeMNAfn8/AecUolPcK7Uwf0z6mtZb3lDd7yFuEVy
	WBQ7o9p33guwc8DrkAmx7Z0Fwp02tyGKrlPuyw+CeJtDcj4taB6frsTfdKtDTg==
X-Gm-Gg: AYBFou38xD4TTs8GrGOyYU6P6EO0gLkIs4IluZwpkO3pJKoDNcG3csdAh5ZLTnw3wBG
	cGUuONFRP3by6OX99WT5l+mb2HzjhUK4h7/3/uPpT+6+Q5hLWaLdhUU2uyMl4qEVoL2PoPluCMG
	ka5Wj4K4nkS65UdYvlFdxXN6/Ch6WqqWydZFr7XSW45MEMF+TmkrEUS18An/srg4JT62Q521j8K
	mWmjg2EJwlLXvV0I3pUNFPuyHmFpySuP2a87v5o4xje0wj1e1WcETZ6TqxMTjkrsdgaurAIGR3p
	649cSgCBXkWZKO8xl6qtYITNCMXO0V+f9h9Vz3iQqZPorjILnv4Wz+Feg8bWhcfq3gM7rdek1oE
	e9Yqa0FGpAmK8eZHLFS5UGqcNEq53eHKck+WLGoRodYiIstLAVNaVo/M/ZiADgwWNSivFuV6iJZ
	qibpqOwj/kckt5IcYaTA6V2jIEq4ssWZ8MuSndWGu5r6h76xuuMHLgSirFNyfatTsCk933vWyw9
	PTsti7sORnoQNfu1Ki5ppD69LytO2IZ8DHE/CVjRazCrgQtZIgQbhCBwnZfoRqPATEP2f3fzr0r
	+u5YC2nOQbrwyCgUPzLLmU7qaVpco7WYNv8=
X-Received: by 2002:a05:600c:4e45:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4ba093aa4abmr66726945e9.13.1794439238621;
        Wed, 11 Nov 2026 15:20:38 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0951f237sm58904685e9.4.2026.11.11.15.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:20:38 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: Please apply the rtw88 USB after-DTIM queue fixes to 7.3.y, 6.18.y, 6.12.y and 6.6.y
Date: Thu, 12 Nov 2026 00:20:37 +0100
Message-ID: <20261111232037.628934-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Hi,

please consider these four commits, in this order, for the 7.3.y, 6.18.y,
6.12.y and 6.6.y stable trees:

  c710c7c2e038 ("wifi: rtw88: usb: route bmc frames via the high queue only for DTIM delivery")
  04cc8c59a3d7 ("wifi: rtw88: usb: bound what the driver feeds the after-DTIM queue")
  185971f1b4eb ("wifi: rtw88: usb: only let the frames a dozing station needs use the after-DTIM queue")
  cf8b516f6765 ("wifi: rtw88: widen the ATIM window while an AP interface is up")

They are in mainline since 7.4-rc1. git cherry-pick applies them to
v7.3.4, v6.18.63, v6.12.117 and v6.6.162 without a conflict; on the last
two, one context line of 185971f1b4eb differs in the include block of
usb.c, so patch applies that hunk with fuzz 1. With the four commits,
rtw88 builds without a warning on all four (x86_64 allmodconfig, W=1).

Since 076f786a0ae1 ("wifi: rtw88: Fix AP mode incorrect DTIM behavior"),
in 6.5, an rtw88 USB AP routes every broadcast and multicast frame to the
after-DTIM high queue, which the firmware drains at beacon pace. Ordinary
broadcast and multicast traffic then exhausts the shared TX page pool for
as long as it lasts: every other transmit queues behind the backlog,
authentication responses can leave too late for a station to associate,
and the beacon reserved page download fails ("error beacon valid"). The
first commit stops the unconditional routing; the other three bound and
filter what still takes that path and widen the ATIM window.

Tested on v6.12.114 with an RTL8821CU AP (USB2, hostapd, one Windows
client in maximum power save) and 80 frames/s of broadcast and multicast
sent from the AP. Plain v6.12.114 rtw88: the free page count at 0x240
falls from 411 to 17 within 15 s and stays below 20, the stack gets about
5 of the 80 frames/s out, the beacon reserved page download fails 16
times ("error beacon valid", "failed to download drv rsvd page"), and
unloading the driver afterwards warns "Have pending ack frames!". The
same tree with the four commits: the pool stays above 400, 79 frames/s
go out, no beacon error, and 3 rejoins plus 10 join/ping cycles pass.

Thanks,
Mehmet
