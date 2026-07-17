Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBF3914EE
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318046; cv=none; b=SliFng9BCIPC3rTeaP97mDmZFuWCVjzZkEIpLIJO3f5Ovlaux2EJOYquyjiBEYl/IEgCqs2+TUpF5RzRxG9uMgdOSrM6+4iATA9S95gCufLTQhn8thfmMqk2boeGoFmBqOV1bN7luCaDPlN2FyiOArQwoaeInbGv1zNWjsp+L7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318046; c=relaxed/simple;
	bh=qDEL+NdYHAMBArrfQo7xo37wngGQUozp4Fd2l50ofPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEv9DNljFqIdxWvjGms07Y7zG5JThKBnzLZo85oYbmNhYMb2hNbtCvG/2kV2ee+/IXVWr0t6Bk3x+hqQjqp4dPKiVtHQ/tbZINLryj/gYecW9oamnBa4XBgKQLqI0w/sfi23Ea+6f6f+c+A82RaMHfY0x8Xt8UGk4yDmdOrqz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+uxy9AU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+uxy9AU"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so334621a12.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784318045; x=1784922845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OErWzxQXSQHPfYViK6AsSVvyH9H9J8o7igncn0U/Abc=;
        b=L+uxy9AUZC3kEidm+53y3EJTc7PQo7VYY36st+YyDjSGKiA59gU1ARKuXr93lIvTuS
         9LoCifD3NuTzEWYiY3B2v7f09wUfe9SLBRbhv0xAeC1DUPKMJ/HIRYweobUd6rx5a6JW
         i0vk/u+gGJoGWkd7/iaPFH5UPX8+4hezyzMjGfVCuZRzEMLU9HZKJQK/A9a1qBnUmccy
         ARbITB2d8E4nPPl5432QId6U59i0Op45A3C0thrkNKoRDaua+3ks/LJE2yjXqwe/KDbO
         l9H9zKCFV9BCMRVSIuZmI4tHrFFXRwqLDh/4PcuHaIxwfUUgniRL3L1bLx2H67gagbTo
         wGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784318045; x=1784922845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OErWzxQXSQHPfYViK6AsSVvyH9H9J8o7igncn0U/Abc=;
        b=R2FqG3J11UNHnmES5+guzQ8o6lEAxZ+j178g8bj2fEYPuDVbUANB3Ztav+EvTqZVRg
         HFflBhxkN+lByvq+AM+5teXJ5Oto+sUKZg5wRpOd47r0y+LiryUQQJbNd7oPp+JechOx
         T5rle8sp29nTfKnxLKUNAiAi1tL+3fTKjg+JxkXJErt56j/abhBweIIJdeQPr39Rl32s
         D21pXkuY7+vVPEPJENBRStPrqUySBcireZRS2goPpbGbK3+o/GDxFu4OdQaYKfFZUc5J
         nmTtDtH/MvyvD13WVhIPX5OeLfeasoziJ0z5EgJXzHwuE9sqO0EdWpINuYlleheKC2GS
         hA5w==
X-Forwarded-Encrypted: i=1; AHgh+RpwTDEV6+9UHpaqdwX2slMcInDOOFLccZoG/mUi9+lf6SeB5HlgjueJVkXEq2sfE9t/Tu3m08U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SL/P7idUlNALBy5kiwJBgr1dgkxqwsQpzE7+co616mI1Jo7A
	M8IhdAg0ks61MEz6T9C0kedUPe6WTyz6ZAHuVQWlU/L1S65p1BTnX+P4
X-Gm-Gg: AfdE7cmBP64siH0TGik2F0L4OLHqqOAZlYDMhIUbHYbIrxa6RKpJ/Z1Yr84crkaTjan
	NeLHGrJdNOKUV9eH02wxa464QvE7/ZhJRbzLeL/+uZMUKO0rWK+iQP05lgcwhwdsrP+dLa/SL2Y
	EWUyggWOqIcRikhlhqlnQ6QQtU/u5Xx84V/GBWr2G6PZ1tVCjVgRYUXgDwP0LRniUB1Y+UO8VPr
	9uBNumDoSRlVObPmx9uasyg6NNrHyauNIUNlRiyIT0sCNMhiajinY3x3k9F5MwMoYuKc4FdW/QM
	erCUNNisw8bjkosw7J+s6Shv97d0oTrLawe+QY8fiFpEYQiTCIPBhaKYRsFdO6fV33ALoqVaFhA
	hrXO77ftwKqUXXYSVPVO9uhvL0tLu1mwGUUwa9KCkzpf9KfKZ0NcVhuqgks0/i6QSQZALTaQxG9
	Cz8PEglyW3gjogdNtYs17xqDpnF5jUd42wuQvUQCUkEUDXt7quRqyfOPGe/3TlRJvYROwAanjeF
	bQg
X-Received: by 2002:a05:6a21:6813:b0:3c0:9c19:b27d with SMTP id adf61e73a8af0-3c3adb1f025mr4919860637.75.1784318045058;
        Fri, 17 Jul 2026 12:54:05 -0700 (PDT)
Received: from ghost.localdomain ([103.170.252.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2dcdsm7103119c88.1.2026.07.17.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:54:04 -0700 (PDT)
Received: from ghost.localdomain (ip6-localhost [::1])
	by ghost.localdomain (OpenSMTPD) with ESMTP id 7fc67677;
	Fri, 17 Jul 2026 19:53:56 +0000 (UTC)
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu,
	michal.pecio@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	stable@vger.kernel.org,
	Nikhil Solanke <nikhilsolanke5@gmail.com>
Subject: [PATCH 0/2] usbcore: Add quirk for 255-byte initial config read
Date: Sat, 18 Jul 2026 01:23:34 +0530
Message-ID: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a quirk for USB devices that fail enumeration when
the initial GET_DESCRIPTOR(CONFIGURATION) request uses wLength=9.

Patch 1 adds USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE which causes
usb_get_configuration() to use wLength=255 for the initial config
descriptor request, mirroring long-standing Windows behavior.

Patch 2 splits announce_device() to log device identity before
enumeration, improving failure diagnosis.

Nikhil Solanke (2):
  usbcore: Add quirk for 255-bytes initial config read
  USB: hub: Split announce_device() to log device identity before
    enumeration

 .../admin-guide/kernel-parameters.txt         | 10 +++++
 drivers/usb/core/config.c                     | 39 +++++++++++++++----
 drivers/usb/core/hub.c                        | 16 ++++++--
 drivers/usb/core/quirks.c                     |  4 ++
 include/linux/usb/quirks.h                    |  3 ++
 5 files changed, 61 insertions(+), 11 deletions(-)

-- 
2.55.0

