Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D4400966
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190234; cv=none; b=Y847/8m45Rqy953KlFfLxq6F0qMWBTxx+MfL51bsimom/fkhxmvvC5j3RjnBJLLRgAjXuL/mc43HrAsvrZd8kS5aakRUpjkBNEewKoFijy3HvWi9Xy+oN+vNdgJ4bJ+iuALScmOKI4wwCXC+cTh2kpbUmw7HPy3aBknYg+dnSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190234; c=relaxed/simple;
	bh=MAnJ/upXvGXVCXhkEWJtKXfN1NJIIAWRkpEN2AfkPRw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o3Am0i7+QUukMIPgaGZcrDKJj8bv2NGoX/h5DWzrKwqtgKBOTYlCrnNddmqSK9Ndn2HjCGBZlUknBjpd0M+/A3zogPuIR2hcHeoKdktwC3NEqKXAIiKfM2jv66JQLFdOI5sy6Ku0Dz62VTMVlVf4dGtl4zoFp5Ni+vilC/lxOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d1S6wzrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d1S6wzrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1F31F000FF;
	Mon,  5 Oct 2026 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190232;
	bh=y6OXbhJYCsQQ/VgxjQCCEFBqxzXHSZbWtGJQgeNVdTI=;
	h=Subject:To:Cc:From:Date;
	b=d1S6wzrUVIyTnn5QS3h/SQFN/YuHdtVqioTMh/6RQlAOqTcUoyHCF5DZhbbNcPEaN
	 jw8wBSPhWi7LksQfI7AC6r7DkFWpQ3GVDJHy/HCyLJ6bCJ1Iv8E7JHRu3dQQZpcgw1
	 arQ71aecC/jIYF1iGFhMivEKIAFfZxGjLkDqqY1Y=
Subject: FAILED: patch "[PATCH] tty: tty_port: restore TTY_IO_ERROR on activation failure" failed to apply to 6.6-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:50:21 +0200
Message-ID: <2026100521-halogen-alphabet-2d56@gregkh>
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
git cherry-pick -x 56964f6a31238fb41d5830bb42520c5b10ff7d8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100521-halogen-alphabet-2d56@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56964f6a31238fb41d5830bb42520c5b10ff7d8f Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 8 Sep 2026 10:40:00 +0200
Subject: [PATCH] tty: tty_port: restore TTY_IO_ERROR on activation failure

Make sure to restore the TTY_IO_ERROR flag if activation fails to
prevent I/O attempts on a port that is gone or powered down.

This specifically avoids issues like kernel panic due to unclocked
accesses or NULL-pointer dereferences when accessing powered down or
deregistered ports when a TTY ioctl races with hangup and open.

Note that the flag is set again in tty_port_close() but not restoring it
on activation failure leaves a window where drivers fail to handle the
ioctl-hangup race.

Fixes: a9a37ec33a1b ("tty: tty_port: Move the IO_ERROR clear")
Cc: stable <stable@kernel.org>  # 2.6.33
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260908084000.218528-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 54359310e293..ae33987207b6 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -767,8 +767,10 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 		clear_bit(TTY_IO_ERROR, &tty->flags);
 		if (port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
-			if (retval)
+			if (retval) {
+				set_bit(TTY_IO_ERROR, &tty->flags);
 				return retval;
+			}
 		}
 		tty_port_set_initialized(port, true);
 	}

