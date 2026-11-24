Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795544279;
	b=3PiWm09hDkORDdEjrB7sN1MI4z0FNzqqBcmj0FRuvJm1oCHlP7Fn+0QjeW0cL5DgyEKd
	 83bTfYZBWs/60BvrJHxd0mL0LeBx+zIWZM9XT8yclstdcVgb0DNhX5TU5gjvddQuFoFSc
	 NFqV/2Mdk9O1rOs7S4iz3ZzGwPt7b+regF4lqFEpcdb9/9iEYa+K+pfkNuw+SBwfIruOT
	 OJiVhHWscTe9bVcOddRBW56FjvrkEAebSxJc2smgxl+boCVz9v3RvXm2Y+qd750HfEaJr
	 pnSZJpabWtfvPCfhomoW/GIZsNrDWuwN3WksqcHqbN9b/dSxWDK3wGnIWP4g3GHSsiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544279;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=f4Pmx0ojsxTGoRiAuq5SAyDtKOVpfDvqtyWV1/+c/8w=;
	b=drZuMZyp4zfOIu+b0SVCMKMHRiDiXoLwZbIskA+5iHLmK+shwbj+QM+r81aj5irBGAOv
	 LiVVTZyWluZ7c9+qrOmOZX3zgXZHCILtncsejNNYe5J/q63DRoRjQWfkoYkCkodnLzzM8
	 dwot8lNfsx0ZMMNNXCnOXerIH8MQlBbu8ur1kycPadCOdUhrEZ5tndzrrr/uqc7UfT7HW
	 zlrsdsyC3GChj6MaQDI7yq+OQbqbwfkL062pXZr5U8Jx17zL1kb8k+/Qd4Iz8KIe8dKki
	 q8T5sAwh/qQan1aujUC72ecZnDugWKfKY6zKdDk3JoGBcx2cjW4L3t3L0mHQoCXFqDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=bVa+rXON;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45E606A31E;
	Tue, 24 Nov 2026 18:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A45E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=bVa+rXON
ARC-Seal: i=1; a=rsa-sha256; t=1795544263; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ewAphw+J5Co+/0NS53YWFh7ruC0R2YIE37aAi/XbBGtPKDA/uZgxHGskd3kzIhIP8ecPuGGl+owtgnrZ1ayHoieSvD31OhP34xjrHM3GxCaQoMSgFPcgmU07q0N7IjRRRk3wa2QOkOs4GiSZ06eskdWSkYDRR5UeklbEQJ0fs6w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795544263; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f4Pmx0ojsxTGoRiAuq5SAyDtKOVpfDvqtyWV1/+c/8w=; 
	b=k0q75tclXr1Pz+Zk23vKwy5vLPzONx7e0Ml1pEbWqg9j6JM7BpQO9eCkOEaiLJ4SSvRtQ0aYP9dI0+UOSKqeR63e++UOMK00nAcWFABURjjvgsyBwmXwGgWsoAhyy61A+zNOXhW3EOJN3Vy0HxGnk/WMC12BaetsIbN2V+W+bt0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=bVa+rXONCYzxV9sO4ACYsj1XC3A4CGVOT/URcKDbXx88W6eHPrSpPVNADig9TfRzy+eqsTcWRvTDqnAeQFJ4xOEHN0Ai4cV6RvyelgBu0ECC8MjEBoQmPcXSq25Q/iFOdGZ4tRK+Bm2lJTir0lBkpwQoHFP684P0rmv10mYrjm3I7cxNB3C4ongg8SXaePSEM7Bw/o09tsdOX5DikZGfhtIvuoKoEyI0BGnuoxFIjT0ujOBa1FqbMgOZ7YV8Vwg0exMjQkl098IRLqzeNOSj0xuaN5B/5OFOPt0wJ5AFSWVKBzSx5D3JVqRxFt8ZvIvGRRG7ruuhM1sBR2whhif52g==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=f4Pmx0ojsxTGoRiAuq5SAyDtKOVpfDvqtyWV1/+c/8w=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795544261924196.57969139492798;
	Tue, 24 Nov 2026 10:17:41 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v2 0/7] platform/x86: ideapad-laptop: Trigger the EC on YMC
 events following Windows behavior
Date: Wed, 25 Nov 2026 02:16:56 +0800
Message-Id: <20261125-ymc-82yl-v2-0-624bdcb3c50e@rong.moe>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NwQ6DIBAFf8XsuTQssQZ76n80HgAXpanSgDU1h
 n8v2EuPk8ybt0Ok4CjCtdoh0Oqi83MGcarAjGoeiLk+M9SNQql4w7bJMCm2J+svra6ttLJFgqy
 /Aln3OVL37sfxrR9klrIvxuji4sN2fK1YPBBcNIj4l12RcWaVQSU0RyXrW/DzcJ48QZdS+gJVR
 F6tsQAAAA==
X-Change-ID: 46a18a06-ymc-82yl-d59b4f8f891e
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Gergo Koteles <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, 
 Andrew Kallmeyer <kallmeyeras@gmail.com>
Cc: Eduard Aliman <edialiman20@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahir Faisal <mahirfaisalantiq33@gmail.com>, Rong Zhang <i@rong.moe>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Currently, the ideapad-laptop driver triggers the EC with YMC command
0x01, which seems to be randomly chosen with trial-and-error and turns
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
Changes in v2:
- Rephrase the commit message of PATCH 6 (thanks Mark Pearson)
- Fix typos (ditto)
- Link to v1: https://patch.msgid.link/20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe

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
base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
change-id: 46a18a06-ymc-82yl-d59b4f8f891e

Thanks,
Rong

