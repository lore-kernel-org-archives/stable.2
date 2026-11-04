Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817921;
	b=SzQ/Er/bcU71vYHTHM9ScekOKHC9oXh3TwuDuhZCU4FsxOamDjTXNZps0wREpKsndmYa
	 +96fgBK2H0oWmzmKrhQVCZRdRcbnELGPXR7LI3glT+CxJN0z+iSWQOJoJ373+nn06iC6y
	 6VQEgUTWKApubLd/gOjj/v3XPXwHjguOnfo3ejuxVQ0ty/StnoujZcGgTvl9iWRV1hhBi
	 tq4ZpkM66+GnKfJSNYVP+5Q0v5IENWcZOWLxHZ3jIKVKz4pjS9Z0c3Ggj74kj3aXCXdbF
	 FCLe7mOqPk/C5X8vf3CIc67ZRlFloVbVu2/uiMU74+YAxnSpPmYExrNDgtNOR9e5w0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bH4YNBWdLzzdq7NSXPMFm8Ng1HqXQF66xJz3klxPR2U=;
	b=yV9+QYOJJmJkc9DZwyU1wo249mv3FRImzWVQ+rj5fF2DAhMvtZHAnuPq3XnodWBqTH4m
	 q1Ue3gy3Ldz0Vet3JnaWvfFHMahQR7sGOK9N7gSFrs4BZaocsHq+iHUNE9xm4QD1krQn6
	 oYaqlUrALOX8MBQo+43JeFhHvfFXn43QspQsOfiegmFdjtsF7rcR+YAM38dmSp65cMtU4
	 5L6hcBBu9Oabh3RZAFrmeAvXxjUNUvFSzUXAKchEw0BmiFBJqiBp/PE50a4XnO/V3wfDW
	 fMvU0+VIKAliDEePlnXN/vX7u1Ay3i8OFpnaXs0FGZgBGp1PbwW5G91BnNN2WtQbKOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iqVTGonm;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBE606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EBE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iqVTGonm
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so6556905e9.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817920; x=1794422720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bH4YNBWdLzzdq7NSXPMFm8Ng1HqXQF66xJz3klxPR2U=;
        b=iqVTGonmqyNFhR1Xrwtb5i8rIqkK5GzumTD1bJlGDfbOEiJNTXNkdgDv2F55JOvDUE
         R0ALaNnxKeDV0HPP1YrG4A5wr95NwlcksvEz/ByRU8GrtMcsYeKDDS9+Bsq+FIsYXkan
         IGLQt7l/LwchC1dhYDMgnBD7noYkncgj7uvot2kcGc5MA9QR0dEM2zs3NptTQMpSkIxM
         xTryQdhELSgtnDPB/hw95xEoZXsRmXf9q9MvaozgZWXK39qaktu8bLcXVFI4pn/XGi4k
         BpOG9gnUnLaDld8ikBmoLeb4HQ2Mbu7su9yEUH9Uy9ms86rspXyZwlhbQF98FkRoRP1N
         iaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817920; x=1794422720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bH4YNBWdLzzdq7NSXPMFm8Ng1HqXQF66xJz3klxPR2U=;
        b=yAQ56+HrMar2jHP9W9T/WxN9uVTxISjXBEGLKoqTXqhgSWrsCwjScpn0hxP1DiGN6w
         +HwwU2WsOlwc4c/SaSm/76R0vKd6o/4mtJ8bDX0cwVfKaBQfirm/uxstgvRUe5Jv1kjP
         qjKwkSkGjqgCGlVduiY8+hC6eJ4acsCf4bh7ysRV9lo5TTJ4dqliu7QH7PB2XJ7Fg7AC
         YCPHaSASphu2K00c7+GLa37bHtfsdrfM9wLwT1R4sKsyZTQmAQcUVichNc4eSueut9Wm
         8vQhAm5mjONoUCXQlbosIE/wH/A5439pF9VRe102GLYjNdKIycUTIk+6ST564zVjZ+k3
         YCYw==
X-Forwarded-Encrypted: i=1; AKwUvByS/EU7B8f+c46naiItyHhYkUoyicL+g8nog3grCYjyCssAMOUOTAcFECmsRcvzKpJTEI0/G4E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fbco/rJRx0l85hL8t4U3hQ41dZX56RH9+zZczNNCzMcxAXILF
	R1jk+a7USyaJOUDaZIgy+jWKxhda4FORHYP6AdubJnGOnBIReoDMtpQZ
X-Gm-Gg: AYBFou1CTt6z4LIHA6HvCNaJ1AK4WEL89X6cKvCv8xZt5Diwc4SzPNZYVTsbA+hpQmn
	DQ2wLHspsBB+3lZFUemeV0AoUUrOGhLGGjElLNligFdncvTy8zh1tZ53l0PeuGI3xyDUju2I2f3
	l0tX6ILIcIPJ2vZaeOqVqGZnTEe6dah+/E/SJ8zi6uiW9i4j/XphXboiE28cklNKhJ2idwR4s4T
	aW/18NgldYi5EeuF+q4eS0s04apL9EYuImAJ5tdfjNZbzhrNb19uwi8rYdEWKvZ101SWuntEffE
	uCQaeQl57Vu4OzccirHdSVRrzDyoUitCzJlPAzy5R0m8L3Dj2mw2UmWQnb7qO6SIoQ7atgPqCOh
	kWoQKfeNCSiOuJslpK3uGTpVu3sMWqOuEjGB4iX5Vs1RJZx4FFo4lJv3bwp8F3z2NGbXCDKb08u
	rRlfRaL+tHYPK4I+A2cIXRoKL9mjnzV2s0nLUXwWtZnHgbZwnX7PYoBj4BnKDrTNm1je1qQGqEz
	mqtj94wqh3o/0ZG44pC6NI4A724w3hcpGl92ri1QKoZAsN8RJJHc72If0Wjo6IMhVTc03MqU3gx
	+n13OpHAa8vI6mI10wtSa4voQHLhuC5SpoiTNkhM/j0vm6uwvbJgrmcAAfz+pY5t5UbPUWCUNpR
	d28pnEzLvftY=
X-Received: by 2002:a05:600c:198e:b0:4a0:2488:71cc with SMTP id 5b1f17b1804b1-4ac1932a23fmr388390675e9.32.1793817919580;
        Wed, 04 Nov 2026 10:45:19 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4527fed5bsm96022115e9.3.2026.11.04.10.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:19 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 6.18 0/3] ovl: backports of fixes that failed to apply
Date: Wed,  4 Nov 2026 19:45:13 +0100
Message-ID: <20261104184517.3630089-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Greg,

These are backports of three overlayfs fixes from ovl-fixes-7.3 that
failed to apply to the stable trees:

  e34d2ef818e4 ("ovl: check that the parents of volatile/dirty are dirs")
  16d319e12328 ("ovl: hold a reference on the parent in readdir")
  f635192ad223 ("ovl: do not copy up a dentry that was removed")

The same backports are expected to apply cleanly to 6.18, 6.12, 6.6 and
6.1, so please apply this series to all four trees.

The patches do not depend on each other and can be applied in any order.

Thanks,
Amir.

Chris Mason (3):
  ovl: check that the parents of volatile/dirty are dirs
  ovl: hold a reference on the parent in readdir
  ovl: do not copy up a dentry that was removed

 fs/overlayfs/copy_up.c |  7 +++++++
 fs/overlayfs/readdir.c | 26 +++++++++++++++++++-------
 fs/overlayfs/super.c   | 16 ++++++++++++----
 3 files changed, 38 insertions(+), 11 deletions(-)

-- 
backport
