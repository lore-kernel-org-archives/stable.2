Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E53E7BCE
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287135; cv=pass; b=K5X2yw0rmBm+hTbcQ3WGGVf786OGYe64DwZU3qapi9V63zRzIJ0S6MNn6F5AjCRAU8XZ+h3cY6tuorViKc+rlPDeImXUWDR4eeJQ6zb1QHmvFjR+/ittOSdtPIH4Ksz6hzzHXjDtLwfXBNTOhJ4inqI6rm+Gdv3UML2/dVvVfSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287135; c=relaxed/simple;
	bh=KWIm9uSpGoSIN+R3P1gUQ+9JvIW++8a5LwJI2335PJg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=O66fULPsvfgQ06Dn7a4aiGOX7yA3jdFSvQUSZubhXbQaJpr8Ym21yI2IjEaCVjnGZ/QG3KeKzXNI43zU31BLyN3PynpKgzQv5R1+li9HPSHmwwOxW/zGzRr+H2/3HM8J3Dh0bT6ZaeI9GBR/4LCeGgjPvTgKSGM9qO3y+YX4reI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=Q4XpqYNp; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="Q4XpqYNp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2dd76b1361dso18244625ad.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 04:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791287129; cv=none;
        d=google.com; s=arc-20260327;
        b=GLHfQ2DAPuSxx1dnkS/ia9m4oFRMAG+uGpsZg4DBd0+/ktQY0/d3zl3LzcAGCFs5Pg
         Brpdggx9UyjoIF6in2CdspyASLpJTRKqtH/uDgaVOSN+1ExK/xILb1d2Gbf3K5EPG8Dy
         GDa8frxK/rbBcy2FWVCe4bliLza13aTVIwlzFbHo8//TWtIkfLl6kkQ32LQZoGJJcT53
         +tpSPBnVZ2F0sIKii2YRYchzXWvlnSw/6tj9qK/zAXWx4Yq6W9t7uu+EUmjWw7K9gCkH
         9csJlF+MCwf/b+maPymOlFHNeWiGPHGxIu5QjpLyQbzPlxaPoGCtUTLXl+Ssr9vmfAHA
         BwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KWIm9uSpGoSIN+R3P1gUQ+9JvIW++8a5LwJI2335PJg=;
        fh=bOw0/yldIFmYwq1Eg1RnWfJYlcB7MvWOANoYKoEDz7g=;
        b=OkDt/nV+7Oi0S6rhZuFCxgNYGfGbZEDAoayE+tkp93lz7GfH2lqcSDS19xgw/E2d7g
         wEb2aBSGoFVv3TnXemmh6sFWBiBC3Cd16gh6pDh0z2zQc9+l6OXhxVr2CddnzELq5QoY
         DXXDv+ERfxy+fH9o7UuVT3tA4UUdOBrcf4VIZBlwsAa6blQU2MiDUjAFpwNcLidBgjyj
         X8thfpi+1mu+jV3kKrjIkPpr8dS78Mrh2ZdG2Uad9AuSAreOBxMPocZaCk0dwGVq1SDD
         tfTSeH+JPw6w3v7PGWCQsB2JXzwa24CDHmw/wI15lRGP1BRH6JDo9Gwgn0M5IjE+7A1R
         my2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791287129; x=1791891929; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWIm9uSpGoSIN+R3P1gUQ+9JvIW++8a5LwJI2335PJg=;
        b=Q4XpqYNpqN0g7sPzs2TB5ihBYa3PMGdZKqruDbTg0eNlQcRhX6lltvQpvGVW9W3R6S
         hsELwPHUEObkkFK5MKvou/y30MWtY4Xp0baFtPNc8Bj4WYqh6EgC/h9wkAWeB8V/6JiR
         nlEPwKmgf31OIYWJLcjPg9UDnGrtECy6L5pwBXbt4+LLFCI1AG8Bf49s7AILnxP7YQom
         ax3tbpctIS4Da61kq34gRLmVRtNyjbvY34YgoGg/81BIIGFQYcyMS6+X4X5b1knGNdTS
         a3ODCbnxTEubKeqLAJikJr9gOpCXQRN9ybGE20ueHOZHOcrdVgLvyZijNXL1PbYeRvQn
         6PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287129; x=1791891929;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KWIm9uSpGoSIN+R3P1gUQ+9JvIW++8a5LwJI2335PJg=;
        b=dRtAj9fLEDReEr4vN4vkXDBLlXfvEN5Rfgx9JpyRxoQVMYZyM0Kpoqg0AJ7NUXccKU
         C6eCCUZNLSjIPJOlhORpqNeImXoZ1cWiSmdFDYrI9+zjM/XK2fUG7PI8pBbNO2lfrwMz
         zUE/PHAJu2lFBa+SxNFxBKlyzMv+EkaLs3Yovnec1BxWL+xykQbh6AGb3geZ//QyVSUn
         XH6qILf1vjtOwW6tTOIJfU3EW+HUIdWK/Npmr8bI8n+t5r4v6ZEXUQTONaLLb9dRPwon
         CnSnTSP98eEb0faN9A8iOYjJs6kA94v8+SfgCn9SlD1lbCgpIkf1k9ujsuwg2dRbzyrl
         hOzw==
X-Forwarded-Encrypted: i=1; AKwUvBzStpl5gU//ZRe1ShL/pBBVNcz83517/4u5n5Qfg1CMrJ/NZbKKeWJXfM7GrD6JAKEjDlLOK4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwG6O0nB+sh72fe8IMPQDkyCYy7jF4fy4vNWcCgR4liHuXOfVL
	cH3JWP1y1PhuqPdShES7oOxFB3Q4JLHsWXm5+VUKlNLi0TPu75V8s78fbeYv9CqeZcgrgMLP0lm
	u2aIqv3FO+H6wgTswkzIJnuhIkEXRb2svrDtR+73Zwg==
X-Gm-Gg: AYBFou1v38qP2eyteuwLvcqEvtzkQM5Crj9qE1QITdnSMxC8hU1odkZWFR6o8iWo1A4
	ZT4dN6+gqupSpjSUtP6TfMyznFZFNWcJj0DCAPAm5ypN+vLWBNPLwytcAmYFfEe8FJ6Kcywc2f7
	jsy96ULMoKJP8gzGSQMfP3UF9hofPrj8W/KozuBvcWHqMNjBSBhFDQPKfx9fWVWd+I8hGd7lmi7
	G6CDO2gwP38XAxZW8LiVqcrm3/qeksX6lEmS5Ta4fxM2VHlb8MxAUl87ay/gaiTKu9rcfAqWtlY
	tU9BvZ+F20Ba/nAeIexuu7Zk/QT/QJ9fdL+iPXiySNTnccc9urJAyrkrKQ8Ur3QkMHo0P0FcuM1
	0znI//s+n/wWAHxWM++C765gEdEhH6r5sRdPO4OsJak9MU9WeEerz2pzXnO9RmILN1hEAjx/zv7
	uh
X-Received: by 2002:a17:902:e945:b0:2dd:c100:4258 with SMTP id
 d9443c01a7336-2e510587a58mr90345025ad.60.1791287129271; Tue, 06 Oct 2026
 04:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Tue, 6 Oct 2026 13:45:03 +0200
X-Gm-Features: AclHuK8SA5n7vXONC0JbjGkzdM0ZYOjGctZLd1mE8yax76JeSneiCv7T5coxQOA
Message-ID: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
Subject: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on VLAN
 frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	nic_swsd@realtek.com, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

the Home Assistant OS recently shipped kernel update from 6.18.39 to
6.18.52 which was followed by a bunch of community reports about fatal
network breakages [1] which had one thing in common - r8169 driver and
configured VLANs. This manifested as network stall early in the setup
of the system with dmesg events like this:

> r8169 0000:03:00.0 enp3s0: NETDEV WATCHDOG: CPU: 7: transmit queue 0 timed out 6125 ms
> r8169 0000:03:00.0 enp3s0: rtl_rxtx_empty_cond == 0 (loop: 42, delay: 100).

As there was no change in the r8169 driver itself, I focused on the
vlan subsystem, where AI pointed me shortly to this suspect commit in
the range: 1517d1996b5236fe69eccd9d253f725e06996eb1 ("vlan: fix
skb_under_panic and races when toggling HW VLAN offload"), added in
6.18.51. I'm not referring to the mainline counterpart below for
regzbot (447cbe95ebb9) as I can't confirm whether it triggers the bug
there as well. FWIW there was another issue [2] with a similar
combination recently in the regressions ML but that one seems
unrelated, as disabling EEE fixed that issue, and it doesn't fix it
here.

I don't have the hardware myself, I asked for testing with this commit
reverted, which confirmed that this change indeed started to cause
trouble. However, it's obvious that the change itself is not bad, as
it fixes another issue and the regression is scoped to very specific
hardware/setup combo.

Besides the revert, following workarounds were reported to fix the
issue as well:
- Disabling TX checksum offload with `ethtool.feature-tx off` in
NetworkManager for the connection (HAOS doesn't have ethtool binary,
hence this option instead of direct ethtool command)
- Enabling REORDER_HDR with `ip link set enp1s0.100 type vlan reorder_hdr on`

Clearly, this needs rather esoteric setup to trigger the bug - I guess
most systems set the REORDER_HDR flag by default, however, due to some
legacy in the DBus interface that HAOS stack uses to configure the
network [3], it was disabled. Anyway, I think that disabling it should
not lead to driver breakage as we're seeing.

So far it appears that this only affects RTL8168h/8111h, XID 541 -
there isn't any report of another chip/XID combination yet.
Unfortunately, as I said above, I don't have the hardware available
for testing but I believe I'll find some community members who'll be
willing to test a proposed fix for the issue if needed.

[1] https://github.com/home-assistant/operating-system/issues/5019
[2] https://lore.kernel.org/regressions/353419280.954808.1790290283530@mail.yahoo.com/
[3] https://github.com/home-assistant/supervisor/issues/7248

#regzbot introduced: 1517d1996b5236fe69eccd9d253f725e06996eb1
#regzbot link: https://github.com/home-assistant/operating-system/issues/5019

Cheers,
Jan
