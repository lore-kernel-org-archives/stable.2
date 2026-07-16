Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDA82DF134
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205779; cv=none; b=VhKtMafxa7Q/RNU0W/yeTkYljGZinZdoH0UZ8VsjYwK0jyuFtUsH4Ka72P4OcU0kan+bZsm0s+dQj1BEfdYywJY3+azhuItipOuagSXeit8ym7sypsurkXk4JuuKBaLMy/3jwcmc6gPomJk+hEIwoUuFdsJzJ5ECc4IuMc45x1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205779; c=relaxed/simple;
	bh=C7odCVjCERXzRbvCK4N7dd/JoVlhWz8uMsKI32wIfIc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LFw55fReo16YUD9IttFi6cVl8nqUr/J/SjarbwJJH94W71WAYdF0ZF2j2D/cdBEuUGxng/cNN2y1/6oM6s0l9VyMLlSN7j+ZeuHecyghuH1VvwOMgtkTrVz4rXBS0ghcndYAIkmsQi72YXg+wbqLsFw2RRhVjU7lVSWd9WI0VhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEv7MZvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEv7MZvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA6B1F00A3A;
	Thu, 16 Jul 2026 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784205778;
	bh=tRG97W1iURJ7VBfdNUvsXd6b7HvKo8s536jMJQIXD5o=;
	h=Subject:To:Cc:From:Date;
	b=OEv7MZvS7yHpOUApYJfXKzrD0nF7BNXC+ys233ET2L+ieF44/Z9W2F/jo3eZMgPY1
	 kulxsCxb8RjzSqohgs9lz+0N07jmakYKdZAtd4JdFt49FckrueEayzTm8N61xVnRL/
	 IIjH0FciymdMs+0kKQMq5Ua+veXgnUWKFWfNVLlo=
Subject: FAILED: patch "[PATCH] i2c: i801: fix hardware state machine corruption in error" failed to apply to 6.6-stable tree
To: 25181214217@stu.xidian.edu.cn,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 14:42:43 +0200
Message-ID: <2026071643-unnoticed-jitters-56c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 10dd1a736d557e310a77117832874729a0175d57
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071643-unnoticed-jitters-56c2@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 10dd1a736d557e310a77117832874729a0175d57 Mon Sep 17 00:00:00 2001
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Date: Tue, 12 May 2026 17:35:34 +0800
Subject: [PATCH] i2c: i801: fix hardware state machine corruption in error
 path

A severe livelock and subsequent Hung Task panic were observed in the
i2c-i801 driver during concurrent Fuzzing. The crash is caused by an
unconditional hardware register cleanup in the error handling path of
i801_access().

When i801_check_pre() fails (e.g., returning -EBUSY because the SMBus
controller is actively used by BIOS/ACPI), the kernel does not actually
acquire the hardware ownership. However, the code jumps to the 'out'
label and executes:

    iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));

This forcefully clears the INUSE_STS lock and resets the hardware status
flags without owning the controller. Doing so interrupts ongoing BIOS/ACPI
transactions and totally corrupts the SMBus hardware state machine.

Consequently, all subsequent i801_access() calls fail at the pre-check
stage, triggering an endless stream of "SMBus is busy, can't use it!"
error logs. Over a slow serial console, this printk flood monopolizes
the CPU (Console Livelock), starving other processes trying to acquire
the mmap_lock down_read semaphore, ultimately triggering the hung task
watchdog.

Fix this by moving the 'out' label below the hardware register cleanup.
If i801_check_pre() fails, we safely bypass the iowrite8() and only
release the software locks (pm_runtime and mutex), strictly adhering to
the rule of not releasing resources that were never acquired.

Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: <stable@vger.kernel.org> # v6.3+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260512093534.348655-1-w15303746062@163.com

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 32a3cef02c7b..b29c99ed3883 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -931,13 +931,13 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	 */
 	if (hwpec)
 		iowrite8(ioread8(SMBAUXCTL(priv)) & ~SMBAUXCTL_CRC, SMBAUXCTL(priv));
-out:
 	/*
 	 * Unlock the SMBus device for use by BIOS/ACPI,
 	 * and clear status flags if not done already.
 	 */
 	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
 
+out:
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
 	mutex_unlock(&priv->acpi_lock);
 	return ret;

