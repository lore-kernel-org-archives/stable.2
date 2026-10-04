Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD32D73B8;
	Sun,  4 Oct 2026 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131417; cv=none; b=YpnMhnCMF3J5joMKkRBP8aP9VwtETDRJpU+92dElc86Sy3I8UStYb7TPpAfdQI+0daqvUuSYgEErvmo4LMLmvWtbFxBlEZoQShuibuP04m+0phcS1VFfxGLvrjSMF/Ab5kxJg4grzcTxa49mfisUKgS9H7x/lnSqDQ49qQFiIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131417; c=relaxed/simple;
	bh=aRyoome8W4lSatphzOiJC9Q6pXg0plR+/j+LIQW2cHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVTEaA6k7Cy3mA4ZSARsIfAV4qh4OTGLq+mP8m7FCB756JHB5r/mjLuYSekBu/KJXLhOEItu76G9Y58bb6LJW5dEqacvCMRTluTri8M7l2k2K+nKOB0z7ksXiEvcOqri1frzjmSoZtUYHbYFcCyKPc+r4sAxVRtZxG70+h1txj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI1DmCP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI1DmCP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D381F00893;
	Sun,  4 Oct 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131415;
	bh=YW7U2dLcfAUO+2ue3Kr0wNWmEnHb7S/dwsSt2b5IUD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZI1DmCP1nAF1bElH6lctHd0Tq6H1t8/G2/gSiEbKrLiCjdHbpBWBf48xvtNcqU1U9
	 IYGQLX2jwS/jWcimyyAWTfFo4sRQLjN5Uso7t1yOEKBaS6DgfagbopFZSmoCf8Kv1F
	 chtzg88I+Ygj9+DmhBR3xGjw6i02z2EnbdYwY3dhad7l7Wi+dvbUbGPw7NYjtG6kO5
	 cntupuVnAh1cphPZKM+fLSOrQzKHjFvmOFzwGFBAkaFjJeE+u8fR+gMLrVtsLOCExI
	 +pGWJbk3KZ9a4IgSLEBbqseBoUH8ASD4V5KDVTIFhVVhjhlLEk5z9kxzT6t2yI59uL
	 XuWwItwRIEcPQ==
From: Sasha Levin <sashal@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Brangs <erik.brangs@gmx.de>,
	benh@debian.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	1149377@bugs.debian.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore working on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests firmware)
Date: Sun,  4 Oct 2026 12:29:45 -0400
Message-ID: <2026-10-04-1-daily-reply-0007-bt540-asus-firmware@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179104011040.2214689.5921682013387867802@eldamar.lan>
References: <179104011040.2214689.5921682013387867802@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In Debian Erik Brangs reported that after the update from 6.12.107 to
> 6.12.111, specifically with the backport of 980084de4d9b ("Bluetooth:
> btusb: Add ASUS USB-BT540 for Realtek 8761CU") Bluetooth is not
> anymore working, the full report is found at
> https://bugs.debian.org/1149377 .
>
> | [   38.138881] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761cu_fw not found

The stable code matches mainline. The failure is a missing firmware file:
rtl_bt/rtl8761cu_fw.bin has been in linux-firmware only since 20251111,
and Debian trixie's firmware-realtek 20250410-2 does not have it.

Marcel, Luiz: could you, or Christoph Zwerschke as the author of the ID
commit, send an upstream revert, or a fallback to ROM firmware when
rtl8761cu_fw.bin is missing? Stable will take it for 7.2, 6.18 and 6.12
through the normal Cc: stable route once it is in mainline.

-- 
Thanks,
Sasha
