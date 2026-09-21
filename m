Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D94AA01E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002816; cv=none; b=ugXnMDaJ7lTkNO5ZKj1ScvFjXEtPiPE7yBic74zQKDQVdrkdgA+aXgxmPr+hsA/gEsIJIxNhXlS8y9TPTes+e/hWgwfTtH5ENJDEDIlYYiBWfFCJfwFJd0snPU3tz4jD0dqR23XgFQpX6qW1yFLR4+R5N7GRgU7Lqxn705oGk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002816; c=relaxed/simple;
	bh=HsoEui3YExaisG5WoslTzHT+gWiqVjCjFroG+4igaoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYcb9NjxnhaHd5Hfj4PmTTLhLERPn0YqkkYgDN3ThSAIzUXZnRrcAPPBBbFlE68syWRr97JPUhB9J6I/UIUWeaj7Cevmnv8kljuQTF+N7vjXAJ286jeflCHpUeRW7pQLfrXOPhIt2UBY2V7DDEaM0dd0ce3btuQW5b6yhud40o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S68+Kftk; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S68+Kftk"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso2465347f8f.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790002813; x=1790607613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=34cUXsmnuPxgm9IEcR3oRSbj60OSa+S8dJr2tJlsE8I=;
        b=S68+KftkaGCFy4PXsaMTm4e8spzFUlbKrpzjMV/8+X3B/riitEaFx9BVUNHs6lC7x7
         xuroYXgL+/tBnq3I+mTYzqDL47mKUOWOD/Jzpz0X+3JUXdhK7ej1qsRw+biD7eXcffov
         YikZD+1Krs71DInKgdhq84SRGp/HGSFyZK9eFi5NadpabNruc0I3Y7VZwvjYY2uzmF8O
         ndPd2v6JvMJtJulEHoq8THpOj/VQGzeFWr/HPuMDZ7YToPJx05mLktK8H5r93J5OARQ6
         roh+Ae5qrhCmFSL4wo/qQpF35+JIGu32+D74Oey7QhPDdEEdUZ4ULKm3ffeWqqlS4XpB
         o6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002813; x=1790607613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34cUXsmnuPxgm9IEcR3oRSbj60OSa+S8dJr2tJlsE8I=;
        b=C0YqisrISLARvF5GNPdvg0w4lXS6BuvaDN1kWLJJNh8iy2z11P7BqSwr4y/aBUU7qg
         1MaODw29VCsQzgRrRK8+MBK6UICHRbXfU3QUkOEyTtPKVitR8Szib0pXNC5ygyJ++Z/t
         /KUPlGJjRrLMPxQLU+N9jdyQWLsjtWky3ZPrYCT7aGUZxgVv8TvYMxYXhaufLcyQIEwy
         an7tayDproCxn7qFKF5QobAaqmNirV2UFGpQN6SJEFk4nmn8vZKLzLiGbPNkCKMikaN7
         MIK+VA7HQ3AEfyBgR38tThy3huqDyr07dEwdCV0cXgvob7Vh3c1x2UtcNAT9JA+6sRsn
         85CA==
X-Gm-Message-State: AFuF++ncCPoorpX8G41D6ltjSIfJyVVpdUBu1LYkp9zF86os9eJZWaQK
	rIAcvBhN3hBEvh6ol7Yqq0Xgek+gqkfdgVafx7A3ljzqjfrUpdBASbXANNPzTAFzu/0EIA==
X-Gm-Gg: AYBFou2G3mYWgxdLtkFEDpEoRC9/lvGzzuXUiiXN0CaiecSARmVHyeFauOIQPvytu8C
	qUz3DgEAtQC1DCbyn/9tThKY+aDUqX5S7BlXOjvlnv+Hjezm+EVnrC33TuPZl5mivjUZlERyh4M
	PqDkvFvXFt/h1dJSTr5IwxzNv6IgJm2c0wZzDdexJJKLGcZzrjiXttDXO0F7b0oEfN/djuQyprN
	2fccAjqx+MhXGp0P3RxMUGLCdkZpV1yqaLkenmx22EW/mrtq0fSSUHSXgKodQEZDqt6TG2mW/OF
	xMD1MynRo11uTJKksa90BbxhsjatEppQQmhoxLnY+eHThwAMWD/xHMux7cSXg40VRfMZ8VFuywy
	NaexXsymsvqDJmVrDdQxDquNgrFe28JY97odb/8z6u7doVnLECNMO9Hv0YuARyEQQP24B2wZg8f
	VEtZLjvqPfX6vHAaS5zt9c9ubUUXEfDwCT+41XkrUusBNyGvtfcxrYs8HsrFNKiSrKILjHOhdIh
	XQzbAr1F9X2GKTU7jOGW6ptNr2yFoHYVj3lldyWnAlQKONOGPKSHT5t7ieDlMuL1wqSkIJaL3ol
	A+8zl703X9ZRnk1VXUkPruxkyfObtX+cgPRqRA==
X-Received: by 2002:a05:6000:2409:b0:487:6ef:86b8 with SMTP id ffacd0b85a97d-4871e3b6afbmr19102964f8f.49.1790002812455;
        Mon, 21 Sep 2026 08:00:12 -0700 (PDT)
Received: from localhost.localdomain (37-188-130-107.red.o2.cz. [37.188.130.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724460767sm23044881f8f.13.2026.09.21.08.00.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 08:00:11 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Subject: wifi: rtw88: backport 737e980e1298 and f24d0d8c3cd7 to 6.18.y and 6.12.y
Date: Mon, 21 Sep 2026 17:00:05 +0200
Message-ID: <20260921150005.95894-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

please consider applying the following two rtw88 commits to the stable
trees noted below. Both fix user-visible breakage of USB adapters running
as an access point, both are small and self-contained, and neither carries
a Cc: stable tag:

  737e980e1298 ("wifi: rtw88: TX QOS Null data the same way as Null data")
      for 6.18.y and 6.12.y. It was merged in v7.1, so 7.1.y and 7.2.y
      already have it, and it applies to both trees unmodified. It does
      not apply to 6.6.y as is, only because the lines around the changed
      one differ there; the changed line itself is identical.

  f24d0d8c3cd7 ("wifi: rtw88: Fix the random "error beacon valid" messages
      for USB")
      for 6.12.y. It was merged in v6.16 and 6.18.y already has it.
      It applies unmodified, to 6.6.y as well should you want it there.

The setup is a Turris Omnia (armv7, mvebu) running OpenWrt 24.10 with
mac80211 from backports 6.12.96, a TP-Link Archer T2U v3 (RTL8811AU) and
an Archer T4U v3 (RTL8812BU), both as 2.4 GHz APs serving home automation
clients that spend most of their time in power save.

f24d0d8c3cd7
Without it the driver logs

    rtw_8821au 2-1:1.0: error beacon valid
    rtw_8821au 2-1:1.0: failed to download drv rsvd page
    rtw_8821au 2-1:1.0: failed to download beacon

526 times over 12 hours of uptime, roughly one every 82 seconds. The
driver mutex is held for the duration of the failing poll. With the
commit applied on top of 6.12.96 the messages stopped completely, with
the same clients connected and the same traffic.

737e980e1298
Without it the driver logs

    rtw_8822bu 3-1:1.0: failed to get tx report from firmware

every one to three seconds, and stations are dropped with

    hostapd: phy7-ap0: STA xx:xx:xx:xx:xx:xx IEEE 802.11: deauthenticated
    due to inactivity (timer DEAUTH/REMOVE)

hostapd polls an idle station with a Null frame and uses the TX status to
determine whether the station responded, so a purged status is
indistinguishable from a station that did not answer. I have not
instrumented the link between the two, but they appear together here and
the driver does drop exactly those frames.

This is my first request to the stable team, so please tell me if the
format or the amount of detail is not what you want.

Thanks,
Josef Schlehofer
