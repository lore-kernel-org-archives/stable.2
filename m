Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323A4AA56A
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327446; cv=none; b=iLbT5GILrHLV44JVRhS+gTPCI0UCbCDyn7WgZBAnYKaFnQMlrGgfISQCMXvlKlnh+uhIezuR7KwLAbvYEoH2OKdEhYXzWY1xgVknR5xHZVEBfV1lwJoEili/FjLJ0lOvGwVa/WFiDqV5NyKEIj9akqE2iN3qSMsQ4CK8HVRXwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327446; c=relaxed/simple;
	bh=13NbGyX7wYTZfIM3a90KyWdJXMVPqc8IYb2/HLv9uX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXWYZcxyDCiSER+cmSJi4NSWbqKdJ6iNB/Ko0erQ2YDotskHL83E+JQsga8Mn8Xh4NDF2V20EGH3dFbI0WATJQXtBhXK5TFCMqAmMyAgMjljcRhm/lCWF4rkaVDBcikF6+IKOyAaCJTig4Fi5yLV54EOoIErMeQTvAXGLYeoVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGDHK9V6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGDHK9V6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3A61F0089B;
	Tue,  6 Oct 2026 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327446;
	bh=O+oOTUfKOXBMHL8vVTuDlZeVCK5rlOoem3v6i8kvKuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGDHK9V6qIHU9G48aiHWesJGB7dbH1tgQc2rqPbsfmMmr0sqjOSZalIySotk5ZLLb
	 AOBduKGei4dkyDEStKXshALcEGKMhwYSJ6yn2a5fmLU0xdddgN47Z/YH09ccnHsyZ+
	 YpKQcUawJx6PyBNRKrJYS+vhc6gSxG8Zq4p58XpJqOa0Hq9PCJaaTp59PJX5GbhmOP
	 8Api9BtjPUZr0Mfx5t73p5u+OgjJD4LYtMFIOhIZYSGk2SzFsndICar1J6CXzxA8zA
	 sP4OJAZOyXjVoZByaVIKN1JQMm4PUER/pHnWaxvOo8jzrw53LYJk6Mgddo1xEHFqpU
	 DOdQnsvsz5Wxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Corey Minyard <cminyard@mvista.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] USB: serial: report unsupported break signalling
Date: Tue,  6 Oct 2026 18:57:20 -0400
Message-ID: <20261006225449.1126693-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006225449.1126693-1-sashal@kernel.org>
References: <2026100507-couch-zit-6026@gregkh>
 <20261006225449.1126693-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit c9d934053d9e850bc901b6425eacb5fe3d4b1738 ]

Instead of returning success when a driver does not support break
signalling, return an error to let user space know and to avoid waiting
when break is not supported.

Tested-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Stable-dep-of: ae0e61d95677 ("USB: serial: fix ioctl hangup race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 291053a74a8b7..c7140aa8c5908 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -540,7 +540,7 @@ static int serial_break(struct tty_struct *tty, int break_state)
 	if (port->serial->type->break_ctl)
 		return port->serial->type->break_ctl(tty, break_state);
 
-	return 0;
+	return -ENOTTY;
 }
 
 static int serial_proc_show(struct seq_file *m, void *v)
-- 
2.53.0

