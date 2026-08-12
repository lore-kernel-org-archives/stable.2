Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00F4499AA
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544059; cv=none; b=YwOxQ1ViUyiNila4jp5G0MLut9BMew48FzgSw0xRaHJGqxqeQ78r0AjnF4c6l7iB9FqzdDnfhNuWdPC7+1rb5VIUH4h4q7JK27O8Aclx5HVxywXsvG2VsSF2cRTle8L916BIxW3Ri3NLvRyA6DroPDoc7r3b2nC4f5qYN4kAN0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544059; c=relaxed/simple;
	bh=/2s11HKj/UkP9vpmnqSeeOzeO4in3KC+LcgVgF6xTqI=;
	h=From:To:Subject:Cc:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A83S7SZxCM/KF5I4Md7ROxcM/IXXVhn2uj8xikzMVvZKBOuF8Lt77B/Rdgj9GgSyHR6Aictx8/62AeW9OzpsCLSYouP8ef5mgf4e2aeWohhsGIq8UZEUtCp9WB5CraKjL2iVorE2dqBjQOKmz8HkRXBgle5jrbezyYXDEG56u2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ+Cg4DR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ+Cg4DR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4957eefd361so7653405e9.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786544056; x=1787148856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :reply-to:references:in-reply-to:message-id:date:cc:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/2s11HKj/UkP9vpmnqSeeOzeO4in3KC+LcgVgF6xTqI=;
        b=MZ+Cg4DRLS9HUOSqGI7SxLPCwH8lQo90J7eHF5f7nv0kyeTNlKizs9hS6Ra0HOPwVE
         2buv6N9PIue+Rvf4tE4RvwgZg5holqZ/L5g6SDy2gyoEXx3WRY4Ze9hbmK5+WjAqdAFy
         YwJL3GJigviIY6o03OVgH1K9arle1OovMfjd3GYDLOsnpynqVvwuNOOTBY8ZQWVlVwDs
         1Bxo0XRKcArfA9De9yAXDh19uwRxTvs2hZ9986g7mw1FCQNvQKxzKGcpoT9HMP+y54oQ
         48HWY9Jat1dNJjDT34YttvxDAsMZOAvgrCVY/vjBUgS3NKm8xolMFbzDFiIpzhqzWHmo
         wUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544056; x=1787148856;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :reply-to:references:in-reply-to:message-id:date:cc:subject:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/2s11HKj/UkP9vpmnqSeeOzeO4in3KC+LcgVgF6xTqI=;
        b=py5rSyhDo+iuPdxixuNvozLCjoIxKUyL5iPoDs8ZW1duB6KNOFb0bSWXv+fm9f+IkV
         1FUxuO1T4DnSyCgJvyd/HmpOMWa2QWt+s+QisX674T6o5dJ6mRbspUHAQ+/33C3jY0Du
         Kje1lmRoOwU+wt9VDWpovOMODu+OjfKeV0ZbXxAU9Hz5sFAgEv4UVSw/xZ+2Tp43pd+9
         8mdJUIvGAplU6+jJcD34mtdgRYbWLkHalNgIX9Qk2yLI8qeN3vX78J8epVgsUQgTdTUw
         f9kHHt0u0Flpv6HF+2WLk5eaucujazx/QqeHxvXESg4+mmHBS+SJ/cyRfSF+O9KzAFli
         NR+w==
X-Gm-Message-State: AOJu0YwHlE/8OAJmL6PnG4fMdP3WTIdi88fqkIpYkbKUHHv5wtRZLoQT
	l2pq9grNHF+9Jsd9XADTYcpV+br5w8sOYn5zm29IgxBeV1qobbApgDfoLqEnlyfQ
X-Gm-Gg: AR+sD13SC1VEDPT1tfmR9Q+5KfdyZUKZpQqfGMO+D3qigMm132oYlJPUGI39gJwhRfm
	0tTHWrgun+O+3weIPEl4L1pLjyfw4vHoh4NPZRqQK479UuyprSWTYmUgf80tzlM3q+hBDNv2Nju
	Np+Y4jKNNMyRoqGgRCVpMJgmRVsjOgw0sbX+ih4PhsmEJhqkkrGO+PUnSBXI+OFp5GzRtXdwJFn
	sF3VqSXpZf6QqilGajJE3gwo62lM9Zgank4OP5wpY/dpwBM00fFUOcyi91MwuvDLJVywhmT10bg
	f7Mq9aSuoOlFljIlzSEQSGxcBejIqM9AFHZc7IHIEyks8frwov6jQ5+M5YV+owsiolLco9KlDdM
	PehugieNNFCBghfh8wTefPkut9onE49CrZth+iAsNY3V9IX0NwQwS8Q4MdoIKgaOIfA+DfNfzAt
	Zt6wO3U9YC+rKxrq/U7kUO42eg/LZkLT7cp3O7rnFDQLo4omj0zjQw/VGIRsL34a/1TnnyJEw2X
	N3WUDxc+3zV7YyxIm0NwoA=
X-Received: by 2002:a05:600c:8b38:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4997c17bc44mr62125405e9.16.1786544055779;
        Wed, 12 Aug 2026 07:14:15 -0700 (PDT)
Received: from ?IPv6:::ffff:10.0.1.212? ([5.14.164.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150bf5c5fsm7535044f8f.3.2026.08.12.07.14.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2026 07:14:14 -0700 (PDT)
From: "Stefan Muraru" <muraru.stefaan@gmail.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Please backport two btusb/btrtl commits for RTL8761BU to 7.1.y, 6.18.y, 6.12.y
 and 6.6.y
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "Nils
 Helmig" <nils.helmig@web.de>, "Alexej Sidorenko" <alexej@sidorenko.cz>,
 "Marcel Holtmann" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
 <luiz.dentz@gmail.com>
Date: Wed, 12 Aug 2026 14:14:13 +0000
Message-Id: <em37b1be4a-6bda-427f-a913-4d6e6521e457@gmail.com>
In-Reply-To: <em41fdaeff-f823-4a9c-9130-608653576777@gmail.com>
References: <em41fdaeff-f823-4a9c-9130-608653576777@gmail.com>
Reply-To: "Stefan Muraru" <muraru.stefaan@gmail.com>
User-Agent: eMClient/10.4.0.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

Could you please pick these two mainline commits into 7.1.y, 6.18.y,=20
6.12.y and 6.6.y:

```
bc597f0cc44f ("Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV=E2=
=80=9D)
5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended=20
scan=E2=80=9D)
```

Both landed in v7.2-rc1. They went through bluetooth-next, so neither=20
carries a Cc: stable and AUTOSEL did not pick them up.

The first commit is a plain device ID addition. The TP-Link UB600 is an=20
RTL8761BUV sold under TP-Link's own USB ID 37ad:0600, and without that=20
entry btusb never sets BTUSB_REALTEK, so btrtl never uploads=20
rtl_bt/rtl8761bu_fw.bin and the chip stays on ROM firmware.
hci0 comes up and reports itself powered and discovering, but it never=20
delivers a single LE advertisement and the interrupt URBs die, so dmesg=20
fills with

```
Bluetooth: hci0: urb 000000009204cf55 failed to resubmit (2)
```

Hence, the adapter is unusable in that state. The ID is the only thing=20
missing, rtl8761bu_fw.bin already ships in linux-firmware, and btrtl=20
already seems to handle the 8761BU. I checked that the commit applies to=20
7.1.y, 6.18.y, 6.12.y and 6.6.y unchanged.

The second commit matters as soon as the first one works. The 8761B and=20
8761BU report HCI 5.1 but do not implement the LE extended scan=20
commands, so extended scanning fails with Opcode 0x2042 returning -EBUSY=20
whenever a connection is active. Backporting only the device ID would=20
leave people with a dongle that enumerates and then logs errors=20
continuously.

For context, i=E2=80=99ve Home Assistant OS 18.2 running kernel 6.18.39 as=
 an=20
immutable image with no kernel headers and no dkms, so users like me=20
cannot patch btusb themselves and have no workaround.

Thanks,
=C8=98tefan Muraru
