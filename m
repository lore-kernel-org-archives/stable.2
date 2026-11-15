Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794770890;
	b=V9h8bY5T0sRtpuBp1eftGQfFfAP9wlxNEVPvGVBs82n8UqdBGYkUKnsuAkNxZGUelHqX
	 uHHAqQD6iK6XMkUchpfNOHUkqUkp8YhxrXF5gLQPchBJ1TvUOW3oreiaLS6qDIXCmead8
	 PwhsB39Hh7Nbw3Gpvrz/mvpg7B9A8ZZFQ5AAc5bFC1hThEpo71fS7gpp17WVqcF07vVP+
	 1Y2Wz7BYOro1Tw9gdS2vYZDvU477XyHAfYQX4qWiJJ7jOG6imOqhAnFVVByyH6C1of7tX
	 2joQD4M39dqYyIsKK5BaLzNsUodfugELZ7RIFD8Yn7sm9kXHcafal3keuB3A8eC23Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770890;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=94KhW5gFHB+Tf5veh73vuUJrUSUoa7+UvlWhnH1zYYY=;
	b=TdRMQJ1DQicAR0ToPJ7sclUL92Mb3sVKG4A3rJp7sw7G6L76WzX1ELgazMGH9SS4JlpT
	 XB90OdocTLvpXFhx/gfmyG7W+f6eeDHn2loZXdjGbAPyMRhQFZa39UpJDsnBBwhypRlry
	 KQM3GE1teaxfG8m1xxfK054Oxh6L9KsrTaP/RvA5fxdnqC9jtlWIcQJF0jq6hvB6Btjh6
	 GvF+ISvxwWE4sJfCTG09rpWFuSp1rvs99Tf1NjnIcf3c9x6Ua2rrfw8sOgOMZMwn35DtP
	 lJ+1c52ApIztjYqI9ZpmKrXwmj/AWO11iG9afbKp1WmnD0StkMXzKPilAg3iIJTdOyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=bfjbAJ4a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2596606A329;
	Sun, 15 Nov 2026 19:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2596606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=bfjbAJ4a
ARC-Seal: i=1; a=rsa-sha256; t=1794770875; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AU3276MvoEErBKNULN6GHvtPTZtA7sEJw7agjxG8u+rz5cQVQxrG2VsKNms5mc+69iJsgKG8RCc66KLsNXHhaByyFZkuc8nfistRy7+VoOsuyeBimgme0/SSbQoyKkb/rksdP8cFTcksilwgpzEtOIE8SUmKmF5qmmhhO0Q+ox8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794770875; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=94KhW5gFHB+Tf5veh73vuUJrUSUoa7+UvlWhnH1zYYY=; 
	b=MiY8vaObsT9GxYRepKkhGc8R6Zjlj4OqwUoesK6g8nWJI2apCRmHtNGbyzFqVcwGEL8RSKOBNSWdrSurj03Q1yhPClBY/v62gdZ/Fq6aWngnnOniVjkR3CTguhIzAzd2IKoS6sOqPXUXIdChWOY5Lg5GDeRNNta/4czWKXIAKQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=bfjbAJ4aKEh8jmjZcQDZxWoYgcewHcg0aLtdtqPBJbWambb3eA+zdYNZraYC29f4ZfWVgTcaLGH6ktS3MibXw6iePbgHLIBVOU9RSyp3FCcP9b1YVmECX7nb/s1UcxzDTNEcNPqjBEkLP/4CufaLVGECxltEirlwCq0upng10vrIaGQuWYGXbsmwBbc3swW6XpbUKNVou6fMrfiE5eJaG4S9pGZkjRwFA+B36LC1Y7ebr2iQw4wmOhHBf6dYrsoWUdA8ajF6Zp/rhK6cCr1VwOuobHJnnWDxmpC4hzlyKj8i9R778ksm6HHy9j79r90dBk+kZ30PJC5z+JG1vVbhkg==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=94KhW5gFHB+Tf5veh73vuUJrUSUoa7+UvlWhnH1zYYY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794770873306199.81259782201857;
	Sun, 15 Nov 2026 11:27:53 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH 0/7] platform/x86: ideapad-laptop: Trigger the EC on YMC
 events following Windows behavior
Date: Mon, 16 Nov 2026 03:27:01 +0800
Message-Id: <20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JROzREOLRAMz3crcZF0Lo8oc3RRTyySTNIs0C0vDVCWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQA1rli5bAAAAA==
X-Change-ID: 46a18a06-ymc-82yl-d59b4f8f891e
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Gergo Koteles <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, 
 Andrew Kallmeyer <kallmeyeras@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahir Faisal <mahirfaisalantiq33@gmail.com>, Rong Zhang <i@rong.moe>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Currently, the ideapad-laptop driver triggers the EC with YMC command
0x01, which seems to be randomly chosen with trail-and-error and turns
out to be not a command for YMC events. While the devices in the DMI
quirk table recognize it, some other devices do not, making the
trigger_ec functionality a no-op.

Lenovo's YMC driver for Windows (YMC.exe) emits YMC command 0x08/0x09 on
fold/unfold YMC events, in which "unfold" means laptop mode and "fold"
means other modes.

Adopt the said sequence to make it work on all relevant devices. For the
sake of caution, only emit YMC command 0x08 only for the known fold
postures. For all other postures (including unknown ones), emit 0x09 to
make sure the touchpad and keyboard are still functional.

Beforehand, also fix pre-existing issues, modernize relevant WMI
drivers, and add a resume callback refreshing the posture and poke
ideapad-laptop to trigger the EC. See each patch for details.

With these changes, add a DMI quirk table entry the Lenovo Yoga 7
14IRL8 as its EC must be triggered by software on YMC events properly
(i.e., with command 0x08/0x09), or else the enable state of touchpad,
keyboard, and keyboard backlight become out of sync.

Reported-by: Mahir Faisal <mahirfaisalantiq33@gmail.com>
Closes: https://msgid.link/CAGAHqH6o0TUa1HXMrNV6e+HNYwU3xxHkOM665756n8Cp3AzhVQ@mail.gmail.com
Signed-off-by: Rong Zhang <i@rong.moe>
---
Rong Zhang (7):
      platform/x86: lenovo-ymc: Use enumeration to represent device posture
      platform/x86: lenovo-ymc: Serialize WMI event handling
      platform/x86: lenovo-wmi-events: Modernize WMI event handling
      platform/x86: lenovo-ymc: Modernize WMI driver and factor out events
      platform/x86: lenovo-ymc: Refresh posture on resume
      platform/x86: ideapad-laptop: Trigger the EC on YMC events following Windows behavior
      platform/x86: ideapad-laptop: Enable ymc_ec_trigger for Lenovo Yoga 7 14IRL8

 drivers/platform/x86/lenovo/Kconfig          |   2 +
 drivers/platform/x86/lenovo/ideapad-laptop.c |  42 +++++++++-
 drivers/platform/x86/lenovo/ideapad-laptop.h |   9 ++
 drivers/platform/x86/lenovo/wmi-events.c     |  38 +++++----
 drivers/platform/x86/lenovo/wmi-events.h     |   1 +
 drivers/platform/x86/lenovo/ymc.c            | 118 +++++++++++++++++----------
 6 files changed, 147 insertions(+), 63 deletions(-)
---
base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
change-id: 46a18a06-ymc-82yl-d59b4f8f891e

Thanks,
Rong

