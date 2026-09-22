Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B47343FD18
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089845; cv=none; b=RtfJ56Ncc84a4DtJGD23go3+UG9oq5LFHsvSoPncdJR7WQL9sZMf9z+j30mG65UX1ud65ZOSDVrD06Y07ytP0Amznk6awofs+KE7a2dtVRiRehAJ57rDaPn3btx0KMDSQ00U1k91Gy33vhUS3eAgnSkHiuqb1zZJSisrnuFlok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089845; c=relaxed/simple;
	bh=hMWG9rrbzA4R741LVl4hd3tEdaTDvGNd3epeIYDKYAo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NYfN+i3gV/qgCOMEUOWgV9mXinGkzcLXvRVqsKKdfnP+MRmRUg3UNAIwjHOjliX9gBkl0o1SPSIBScvgqVphmWX4n/453Apy21+3IgNmRzjN9hMwK75wNfN2Q+1cPczHpC5pUY54UFMtshmCBLg/niVBFtvDKEkKTjO0f0SVOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YtN9Qi+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YtN9Qi+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3603D1F000FF;
	Tue, 22 Sep 2026 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089844;
	bh=RZrZxRYtqOd+WRn4BZLXtWK9cjx/kxkfhoQdWleWe3I=;
	h=Subject:To:Cc:From:Date;
	b=YtN9Qi+haLAxobvMHjGE4ZSlfY4mH+fnwxi/4InP72eJ97unfn26lrmZN1RutIT62
	 p3PZxuYy6iy2/Eve2Kmudlzoa7Z0/SKR/IPAXUUiRUZx3KgiEZJ2/5yKTWGmTGLm2v
	 z+swl7H7d5QMNni2GgtxlGAVGA1+9UooJzeLOrZ0=
Subject: FAILED: patch "[PATCH] hwmon: (pmbus/core) increase number of phases and add new" failed to apply to 5.10-stable tree
To: nuno.sa@analog.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:55:14 +0200
Message-ID: <2026092214-quotation-winter-5dc8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 06bd6794b5fd2163880ac3bfe973d4cc61f359f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092214-quotation-winter-5dc8@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06bd6794b5fd2163880ac3bfe973d4cc61f359f3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 14:53:37 +0100
Subject: [PATCH] hwmon: (pmbus/core) increase number of phases and add new
 mask
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Increase the number of phases to 16 as a new upcoming device supports
such a number.

While at it, add a new mask for controlling the source of the output
voltage.

Note (groeck):

This patch was meant to prepare for support of MAX20826 and compatible
devices, which support more than 10 phases per page. However, Sashiko
reports that the mp2975 driver already supports up to 14 phases, and the
mp2856 driver supports up to 12 phases. This already has the potential for
out-of-bounds writes when probing the affected chips, making this patch a
bug fix.

Fixes: 2c6fcbb21149 ("hwmon: (pmbus) Add support for MPS Multi-phase mp2975 controller")
Fixes: f9e5f289b686 ("hwmon: (pmbus) Add support for MPS Multi-phase mp2856/mp2857 controller")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20260911-hwmon-max20826-support-v2-1-5e30cbd97d84@analog.com
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 2cd3216b3cd9..920c1102ab6d 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -242,6 +242,7 @@ enum pmbus_regs {
 /*
  * OPERATION
  */
+#define PB_OPERATION_CONTROL_V_SRC	GENMASK(5, 4)
 #define PB_OPERATION_CONTROL_ON		BIT(7)
 
 /*
@@ -386,7 +387,7 @@ enum pmbus_sensor_classes {
 };
 
 #define PMBUS_PAGES	32	/* Per PMBus specification */
-#define PMBUS_PHASES	10	/* Maximum number of phases per page */
+#define PMBUS_PHASES	16	/* Maximum number of phases per page */
 
 /* Functionality bit mask */
 #define PMBUS_HAVE_VIN		BIT(0)

