Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607989;
	b=gARWaBi5sC7efNyRcvIBp0Y60TBq9pik6B5RZ6ss8lSopACInKiDROrbID64y/b6FnuJ
	 baccenpsHO8WnK8sLdYEq4XRB0QVCLC3oDcVzxg3V7sBWOygeIE5zNy+paL/HspKi+oxw
	 e5EP+o0436dZDD9MoAEAfE5fLgH42KgzlQnsHiMjigv6btwbyvT507blvweaj1se347wA
	 6y7pKwDfzJvTy9KQLZFxTrE7HB4MBx+RdRkkyz0LkwRqhZWlwOg2wBZfOX/Wpz7btI3AX
	 IUSjXqrEi3xKj0lrjcukM9xRzl6LVYkTppQb6sqQzJH0WaMr2EwOPJXq1BNzh1uAQOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607989;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wc67iqENQNdz8kfpb4qvReLIrwRW3c7fdUuSxfaKmQ4=;
	b=HRm22xuGsimlIG/Zc+X5tZdpHs95smunEyia6z+vvJE02Gd+cQEg4CTQOOy6V9a9UZYa
	 Z1zRbYr96lHTyqOO28wLdiVhpedtStgJYtgYUw4hGyfIl0zOoKRv9bEht91+xCVyVs35O
	 uDuBBKrW3X7LWTycChs0b6uHQmKW06+C4j8xzj3I+ujjq7yb1ilbKujqZaZthXxmHXfYi
	 +6qSkVmOfUWVuHfHoP/8kjOMbSOCL7BNTq3fAQ+8mu+1akjSgZ3d8nRgIO+icIVN0zZj5
	 +6lEWTfaRrKR2G2D8gGWtGXuN0yhHQnBLXxMxW4ydfmUZIj3w/QBo+XW3B9aFvZxuyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dF9c8/8C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44F606A326;
	Mon,  2 Nov 2026 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dF9c8/8C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C231F000C1;
	Mon,  2 Nov 2026 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793607989;
	bh=wc67iqENQNdz8kfpb4qvReLIrwRW3c7fdUuSxfaKmQ4=;
	h=From:To:Cc:Subject:Date;
	b=dF9c8/8CetP2MVTXs1oE3V/apf3XnaeFM258Tx8zPLNXOxUHIAtoN35duMo9WrHJN
	 JtVMb3gSd7qMzMi7Sx32W1wdbH72mzR1hxtzCLx2Pkfx38/42f5IilvNqo8BD9l817
	 4yVTeqFnHQnGg5CF4RZnw9idelXGVmYx20ElCl6AM/xh1urlyoKZ57GuhJ/754tPS6
	 cls6vAziH0T1Th+VEZeCi7LBmKFwnkRNN8vMtgZuP5p95cKjYi8d6Z4gjz9VQa6eH6
	 t+5J46N9uayDlOWgbZsgAbAm/lp0WtbiGD4N1YCOv8p+ps7OWfJpvN12o5kIAq25LL
	 EVq7Sq20M5BvQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xNnN4-00000005Ll4-3IDa;
	Mon, 02 Nov 2026 09:26:26 +0100
From: Johan Hovold <johan@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] devcoredump: fix double free on device registration failure
Date: Mon,  2 Nov 2026 09:25:36 +0100
Message-ID: <20261102082536.1275223-1-johan@kernel.org>
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

The device coredump class release function devcd_dev_release() puts the
module reference and frees the data so just return after dropping the
device reference on registration failures to avoid a module reference
imbalance and double free.

This issue was flagged by an LLM.

Fixes: 833c95456a70 ("device coredump: add new device coredump class")
Cc: stable@vger.kernel.org	# 3.18
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/devcoredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 8bb1763083dd..16e99ac926a7 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -433,10 +433,12 @@ void dev_coredumpm_timeout(struct device *dev, struct module *owner,
 	devcd->init_completed = true;
 	mutex_unlock(&devcd->mutex);
 	return;
+
  put_device:
 	mutex_unlock(&devcd->mutex);
 	cancel_delayed_work_sync(&devcd->del_wk);
 	put_device(&devcd->devcd_dev);
+	return;
 
  put_module:
 	module_put(owner);
-- 
2.55.0

