Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF73B42C7;
	Wed,  1 Jul 2026 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890052; cv=none; b=If4z71+j2Rih/+2anTG4oTKBop1rzHkgHJ4qG+pdKxF/XbzM7dVeOvUHLC+mpMihpqDeXA2IK2AxQn+fHDcaHeWmwYoShm5e2Qhur4Q/U6svRFOcHicb3S9HtSQ/d+e1IT92vO8wLrhkry8j0aRh8jC+NqdDuLOTG4h26QZevx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890052; c=relaxed/simple;
	bh=R95S7oZ0TLTfSna4noC3sjwk2JQrExYIh0ldu29zQz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3D8wM/Q12UWjDs5LDjAwmVO0vfvP2znzvjtoa5NV4g/0mMwfkjuRM01QxnZ2r0jqXNBb8gArQUwra9E9/ztg93sfc1Hv+7JLtF3HOqOaJ9rBSkrWCjmUnnSCogDEEhVUgyYJWwhGEhMO/iWA1r7Uc8wuDm0Mm8ovIgsHCmD69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=wxWfY9GO; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wxWfY9GO"
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward205b.mail.yandex.net (postfix) with ESMTPS id 50770821F1;
	Wed, 01 Jul 2026 10:06:06 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:221f:0:640:b03f:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id 5AA7AC00AF;
	Wed, 01 Jul 2026 10:05:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (smtp) with ESMTPSA id u5ZXBD0dMuQ0-029dcTP5;
	Wed, 01 Jul 2026 10:05:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782889557; bh=623+SyxJNrq/SwM4fNvWDIo8zRjLiExQEHmwxuKG8gU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=wxWfY9GODBnUo/CMWTsKZ+mZQQ8mfJAjwOwlOWF7R6+d+8kZ5jVfwEnJJbvqktgvv
	 zcYui9xhtiWGh7054O0a/DxhN+UPIuxj4A5t4Z0wrqWd8J6al3BTs0tm30LHYoxRdl
	 r+S0iPcv6uH6r2yeXeF5msIqYpB4t2h1oWnE/NMw=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d37184d9d8cc34602616@syzkaller.appspotmail.com
Subject: [PATCH RESEND] media: dvb-core: fix dvb device instance leak
Date: Wed,  1 Jul 2026 10:03:49 +0300
Message-ID: <20260701070349.2755931-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After 'replace_fops()' trick in 'dvb_device_open()', reference count
of the corresponding 'struct dvb_device' instance can't be managed in
a regular way (e.g. by using 'dvd_device_put()' in '.release' callback
of 'dvb_device_ops'). Since there is a race condition between
'dvb_dmxdev_release()' and 'dvb_demux_release()' (there is no way to
guarantee that the former always sees non-zero 'exit' flag maybe set
by the latter), an extra check for non-zero 'minor' field of 'struct
dvb_device' is used to ensure that the device has passed through
'dvb_register_device()', has reference count more or equal to 2 and
call to 'dvb_device_put()' from 'dvb_demux_release()' never actually
frees the device (with 'dvb_free_device()' called via 'kref_put()').

Reported-by: syzbot+d37184d9d8cc34602616@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d37184d9d8cc34602616
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
This is a resend of https://lore.kernel.org/all/20260216154152.2597331-1-dmantipov@yandex.ru/T.
Since 6.12.x looks affected, cc: stable as well.
---
 drivers/media/dvb-core/dmxdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 3c8bc75e4d6c..c33490acba15 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -1256,6 +1256,9 @@ static int dvb_demux_release(struct inode *inode, struct file *file)
 	} else
 		mutex_unlock(&dmxdev->mutex);
 
+	if (dmxdev->dvbdev->minor)
+		dvb_device_put(dmxdev->dvbdev);
+
 	return ret;
 }
 
-- 
2.54.0

