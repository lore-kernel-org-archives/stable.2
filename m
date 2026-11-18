Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994551;
	b=0I1oqFz24dLhRj/dYpGAPw34lUO6pOIeEP2++oVDGAJS3Mwlup6bjC9cWrBSD/aDRinP
	 2GGEY0U4p238NS1Z8q7BppDTGK0TSURr6ry1KGpcXrC429HTAQh046OY+uv0b0fTlvk39
	 QksBHDg8iGQv+EJuWytmxYSJBYoa/D25qCNfnDrR2s/2R6H6kwn1rHzdF8evXytJZZvQ1
	 U3rLhrlYQlbn3lPl4SNSS+CT3BKYuhLiJ1wSz6TSWh+Ow7dtDhYuNeZ2OMaQ5NKPRPCGm
	 TGHMoY5BWsp8p8QiPgL8DcxR4WgNJonzc+MT8fkBR3X4WDuw+1jxDV3fT4bBmzFFqkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=81i9KAZGppLVXeBJ/pqGA8hg4RtcbTdEbLwDNWzzkHA=;
	b=D8+XxtQU6Qa5ZjeI4qxG+5PyHr3UVkUH0fXu0O3sAOxwy0SLxyI3TmRFeYZzd7JQiCWZ
	 Rl1yex919GpVMrF4caTyI84TJbt2zgbjNYLMG2LaJ90zQ1Vz/5lHSPmMafOGVZaa4I4M3
	 dHSBlgBX6J/S1HutTA6G2SOXdewh1jkKN57avg1tVab3vUzN1mtPKDKTqarzTzD4MYcfc
	 7qOoQYBElB39YbTJTVrShefadI9eqDgLjDswp3e9m1Wd4nIMutzFPxwxxFlk+BWLXEr+P
	 Jcc8EuAiONuP+5KFWqUXdzpSMFesH9wPsriu2UQwQW3DoszhsIc2mk1OgCrhPlapxTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=T0gwlKA6;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0338606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0338606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=T0gwlKA6
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40e30c26a4so380145566b.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794994549; x=1795599349; darn=vger.kernel.org;
        h=to:content-transfer-encoding:content-type:mime-version:message-id
         :date:subject:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81i9KAZGppLVXeBJ/pqGA8hg4RtcbTdEbLwDNWzzkHA=;
        b=T0gwlKA6yq4sdjOhsEzm2oCq1D6kS46iw7X0WQJ64i7MjVW75Fx5+wUWX1wQjUc71C
         FDMOXMVdi3+Kur5CzDTOOEJ3gCNpca/eBl/V5DBrfmmBFtb0wUKids/A//153x8/htH6
         FNJvki3MrwMr6C8fy5HUUzMiLGV68Op/MANio0OZ+8lS5B+ATZhqk0G9eP2UPIa1ax/P
         lXiQkskO3HyIDA0hbrsbDnnUX/y1QQzHiff3TSBoc7k04e4Hjc/jto9Q1l5Dnsadejc9
         ZTDzluZxSExrOv8+8B65ME9rgoFSvT/G2P2swHqh1e1iqSdUHbW/RpsYbbIvk+Cz2ZaX
         nspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994549; x=1795599349;
        h=to:content-transfer-encoding:content-type:mime-version:message-id
         :date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=81i9KAZGppLVXeBJ/pqGA8hg4RtcbTdEbLwDNWzzkHA=;
        b=gfVSryp1r1WvXPE6hsO+CBotSz5G90C5cv/vp6wzthbFz/qxsl36HyutrH3DoHZEbE
         aqy7df/AZ7xQ1yEbaCiQmTcLm5pamK29amRHLSYeszI/2RihEsX/XxeqxfLVcgctEe3L
         6ylQZYZBSg+Hyt9fqLlRRkRYU4ozFX0hbN97pqt9ja4cPHyfbDmvzdInqJQLT63wZTRv
         7fbpNCBpt2vLE5wcWfAJZWEUwKyLUAD527i3XC5kXN2x+CBd3jJHYZoX02n60qv2gixJ
         F8SJW9W4nmsi6psqkO5hfJ8yJwSXXAweEFAhm44e5JujX0wREtrweZBmI8nAg1Pcv+ji
         v6cA==
X-Gm-Message-State: APuU4Z/K6S7cAFGy/GC6bJQlUrsf9dJZZPx1PkCWXgmiOLj8Dv7rC9CY
	Fw+lGkObo7Rws7itYG050Usw8suZXSE/9hUTmhz1narHHQ5Qrre0dCNHwaVpVkrGXj6kdFjmh32
	TRwjXPZOQrQ==
X-Gm-Gg: AYBFou08gGbkf1YMfhL0lh5+jaqDEPLiYNr7YLZN5T+i7RGFG8RAiUw4+KP4mn5vC4J
	t515fEbeNHwwC8T3e4dPycOngtwgiIxCvMOTos8/OVMSDDiCRhtgDB3G9C4VsTbbIw2wZTungZY
	8XV/hrh0h+gMJwQuaPq1ypKoc5SPw90p07tTV3KLbKv5fT71Q81FHJzLvobvSsVAfj517um9tCp
	ktNJsug1RRyNc3PEOH3YAVeb3JpXTgHMHIhCG2wszma69e9X89XvFEdvoNiCEDxwElJ6GF+50PB
	Aa1Hq5c/4IoQc3SM9iGENSPZDlZsG4KSEZEjDazfh1ay70TzFd3nllIu7TqkV7GZ1un22zaGZ1U
	8s3oruSSWJo3JL92piGt2RcFYuMJEVcfDJK3egZnvKHaB5UiHDzokpZDBPfv1LHSRUzcNUxPzGT
	mHwyUCmAZDjTeRHgQqxVrv1grF3AMxQMNpDRRGItrD0bTvoxoC/ZZ6k2Vi0f+rcHE1l2eeIAa+d
	p9Pivx/sK/zR/ixIxxPvBI7RxvWY6SP/jrAKMK4nUlXww5MAc5kHVM89x6c0on1HNs8XMmvreSS
	wxtisfUSJRJsOkoJKsknNAxzeOCUTy3IFrb5DLZ8ZLeYLJJjGzutUhwk6QelAeTcmrbF0pAdcru
	H8OPIlsA=
X-Received: by 2002:a17:907:d406:b0:c2e:1b6b:8b19 with SMTP id a640c23a62f3a-c50f3771f34mr480149466b.23.1794994549153;
        Wed, 18 Nov 2026 01:35:49 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab3000sm75275066b.56.2026.11.18.01.35.48
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:35:48 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 5.15.y 5.10.y 0/4] Backport sign-file,extract-cert patches
 for OpenSSL 4 compatibility
Date: Wed, 18 Nov 2026 10:35:40 +0100
Message-Id: <20261118-openssl4-515-v1-0-e1fbd1da96d4@fairphone.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEfyXsswm90Kj4K+JDTU49kbTkamkp/
 XejPi3DMrNCuQgrTmZF4UlU+lyBdgbx0eU7W0mV4Ru/J6Kj7QfOqq/WBgqWuO0i+XSIKaEqQ+G
 bzL/cGcFRcIup07gFl/+t7+uT4/hNYts+GhKGlH8AAAA=
X-Change-ID: 20261118-openssl4-515-1e4ac12d7cdd
To: stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794994548; l=1193;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=XvhWWEZotv1zSNCT1h6N+RnEH7ZewLG+Z8VjGzsbpN4=;
 b=OsaHjEernmppzpgfAbsuD12Py4HvoL0YuU4K8ULzGtXzdhYJH/FNAM/zsJoGaJu9m0Rn9Wdyk
 aL3OwdzE/vqDv8o51GBFQdXX4yMvoyqCX0NLjghyzDWcIl1XzqTxLlp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

On Arch Linux the extract-cert tool from 5.15/5.10 doesn't compile
anymore due to OpenSSL 4 upgrade which removed some APIs used in the
host tools.

Backport some patches, taken from linux-6.1.y to fix compilation.

These patches should apply to both linux-5.15.y and linux-5.10.y the
same, so I'm just sending the series once.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Jan Stancek (3):
      sign-file,extract-cert: move common SSL helper functions to a header
      sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
      sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3

Nathan Chancellor (1):
      extract-cert: Wrap key_pass with '#ifdef USE_PKCS11_ENGINE'

 MAINTAINERS            |   1 +
 scripts/extract-cert.c | 144 +++++++++++++++++++++++++++----------------------
 scripts/sign-file.c    | 132 +++++++++++++++++++++++----------------------
 scripts/ssl-common.h   |  32 +++++++++++
 4 files changed, 180 insertions(+), 129 deletions(-)
---
base-commit: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
change-id: 20261118-openssl4-515-1e4ac12d7cdd

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

