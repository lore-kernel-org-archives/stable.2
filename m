Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6737F33A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496655; cv=none; b=HuCIY7aiEXeqgqe9TiEjfif0p+HyqjfhGQ+N00VWVTtbhVKrdMfpl0eeAkMux8SA52aRQVxjw4yWMeJKj7NE4H1M5DbcJlpKnrHmZHrRc0deCkwvRUlc8gyUGkGztXuBJV0IXVjueS7IeY+mikRqmCRRWUBOS84ZWoqrfouxj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496655; c=relaxed/simple;
	bh=6J955qafx5iLMDu+1mjt6fIVDe/0NV2Q8BZrI0Kf6uU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fcQiRmv0LwV8czn67K9lYUbRiCQAchQj7kVny8njbZgdfj2SEKwurocBhk61u3Ugj+ORiFqyiG2HUKIZeoyuA4W+jg/ASByc5uqVOdZQkTJhVko7rv35Ilg/f71HwoemVGHDWfFvX7XrK7qKrjvZHE+FYwybrDmrez8/uUmW0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vY/LRBC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vY/LRBC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132801F00A3D;
	Fri,  4 Sep 2026 04:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788496654;
	bh=XyAtzI4BfpwtBeEhhw6QhODRqDr6idN4ecxzJ2gse9Q=;
	h=Subject:To:Cc:From:Date;
	b=vY/LRBC4JqyJsfB5kn4WEyiUX4Wkl0VHr/EGN21ks9xCR/f4Swlh9OAirL7lyq+hJ
	 bP9nA18Ql1NoXxgLltuIvOpNMNEaNyd/kJDtABCHU9zFfWI2gLdrVEGYDpL8R8cFXr
	 kC7sVGxZwtjuPIQqvj8MHF+KdWuEXnYVDAqiA6zQ=
Subject: FAILED: patch "[PATCH] i3c: master: Do not treat master device as a duplicate target" failed to apply to 5.10-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com,mukesh.savaliya@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:37:12 +0200
Message-ID: <2026090412-tidbit-broken-5a32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4dc1b3eeba7991905a5b5b8129ebea51be7d87b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090412-tidbit-broken-5a32@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4dc1b3eeba7991905a5b5b8129ebea51be7d87b7 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 7 Aug 2026 17:56:27 +0300
Subject: [PATCH] i3c: master: Do not treat master device as a duplicate target

i3c_master_search_i3c_dev_duplicate() searches the bus for another I3C
device with the same PID as the reference device.  The search can match
master->this, causing the controller itself to be returned as a
duplicate.

Since the controller is not a target device, it cannot be a duplicate of
one.  Exclude master->this from matching so that the function only
returns real duplicate target devices.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Link: https://patch.msgid.link/20260807145638.168865-4-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index c7bb52b71d88..abb582645a2e 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2545,7 +2545,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
 		if (i3cdev != refdev && i3cdev->info.pid &&
-		    i3cdev->info.pid == refdev->info.pid)
+		    i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 

