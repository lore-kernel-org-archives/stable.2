Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F254AA579;
	Mon, 28 Sep 2026 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595413; cv=none; b=Vx6VlJcZcN4Sqs9JyhkKDWqzKGGMwRbHOH3ILD77z0wue0t0L19vCwUVH53EqW4aYub6qCIdeJ0oaTBFXKS7E32bfYQ2DWMOlpBY1e7qVdTI0EXFLtgnOygIRpNu5il/Fd9Bm9BhPh5OFy1RWcEUo2GFX3g18+GZEgMqiSt0qVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595413; c=relaxed/simple;
	bh=T5IbdwHsw/qD2EPA4qspcbLgg6+Q2R18K4Hca4xmGAI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=kNV18FcQ3w6Li3rK91zJWaK1NvkF5qF21nLIq72m2Cg1CTWf6Jq7Nn95YwBgaBAlVa5ind0hGP/F3/y69O3Bx9D/r5i35wAkMqOvqBEGGTxKf6uQkFnTPM0BOqVBQR5h7tgqdLCP0AIFdbgvGPJc+wAw43FFiElUMZQ3RmTCPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=A6miKgX7; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="A6miKgX7"
Received: from smtpclient.apple (unknown [IPV6:240e:305:1b9d:c000:658d:22e4:fce7:420c])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f5ac1a9f;
	Mon, 28 Sep 2026 19:36:40 +0800 (GMT+08:00)
From: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: [PATCH] ceph: bound the mon command wait
Message-Id: <7412F740-8826-4790-8BEC-A590DB2BC2E4@stu.pku.edu.cn>
Date: Mon, 28 Sep 2026 19:36:30 +0800
Cc: ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>,
 Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-HM-Tid: 0aa0e7cd833703a1kunmf2fcd2451f9292
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0pOVh4ZSxpPSh4fTktOTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0seQUhLTkFKGUIfQRhLS0tBTU5DH0FJSR5PQR0YHkxBT0
	lLGFlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=A6miKgX7OzTI5CY4V5dDBmqXRySp2CFYQoCBiD8wHLF+Oq4KdzRUVacZfODfltptUSluGh+XA/iNnCMP4L9KEaro/9hhJSTRMttOxUiaZdY2dLyAMjLqrH9kCyJBl1qVR+2JLjPHM6WfNK4zr4SMhZAZ9svb/0AuklXUWlRkU1c=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=TvKf7SSMp0T++430PIKppvqUMsgRV/+IYvLvPLLFBgI=;
	h=date:mime-version:subject:message-id:from;

ceph_update_snap_trace() reacts to a corrupted snap trace by fencing
the mount and blocklisting the client through ceph_monc_blocklist_add().
That issues the "osd blocklist add" mon command and waits for the reply
synchronously, from the messenger dispatch path, with session->s_mutex
held.  Dispatch runs in a kworker, where no signal will ever arrive,
and the wait has no timeout: a monitor that doesn't reply leaves that
worker asleep holding the mutex for good.  ceph_cap_release_work() and
anything else queued behind the session mutex pile up on it, and the
WARN(1, "...do remount to continue") that is supposed to tell the admin
to remount sits after the wait and never runs.

Bound the mon command wait with CEPH_MONC_PING_TIMEOUT (30s).  That is
already how long an unanswered monitor keepalive may last before the
session is reopened.  On timeout the existing error handling takes
over: the blocklist failure is reported, the warning is issued and the
mount stays fenced, so the admin can remount as intended.

The blocked worker on the unpatched kernel, trimmed:

INFO: task kworker/0:1:11 blocked for more than 10 seconds.
Workqueue: ceph-msgr ceph_con_workfn
Call Trace:
 <TASK>
 __schedule+0x1850/0x4a80
 schedule+0x7a/0x1f0
 schedule_timeout+0x217/0x250
 __wait_for_common+0x2af/0x460
 wait_for_completion_interruptible+0x1f/0x40
 wait_generic_request+0x1f/0x270
 do_mon_command+0x4b6/0x600
 ceph_monc_blocklist_add+0x88/0x1a0
 ceph_update_snap_trace+0x222/0x3420
 ceph_con_process_message+0x1e5/0x270
 [...]
 </TASK>

INFO: task kworker/0:0:9 blocked for more than 10 seconds.
Workqueue: ceph-cap ceph_cap_release_work
 mutex_lock+0xce/0xe0
 [...]

With the watchdog set to panic this ends in "Kernel panic - not
syncing: hung_task: blocked tasks"; with the production defaults it
just stays there.  With this patch the same run prints:

ceph: [client 1]: error -5
ceph: [client 1]: failed to blocklist ...: -110
[client.1] ceph_update_snap_trace do remount to continue after corrupted =
snaptrace is fixed
WARNING: fs/ceph/snap.c:926 at ceph_update_snap_trace+0x2d1/0x3420

(thirty seconds after the snap trace error) and the pending requests
on the fenced mount fail instead of hanging.

Verified on 7.3-rc4-00537-ga3ff15db6820 with only this change applied:
the blocklist failure and the warning arrive thirty seconds after the
snap trace error, and the blocked worker returns.  An unresponsive
monitor plus a corrupted snap trace used to wedge the mount for good;
when the wait expires the blocklist attempt returns -ETIMEDOUT, the
warning fires and the mount stays fenced until remount.

Fixes: a68e564adcaa6 ("ceph: blocklist the kclient when receiving =
corrupted snap trace")
Signed-off-by: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
---
 net/ceph/mon_client.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index c56457378d00e..435c7f851ab26 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -705,6 +705,24 @@ static int wait_generic_request(struct =
ceph_mon_generic_request *req)
 	return ret;
 }
=20
+static int wait_generic_request_timeout(struct ceph_mon_generic_request =
*req,
+					unsigned long timeout)
+{
+	long ret;
+
+	dout("%s greq %p tid %llu\n", __func__, req, req->tid);
+	ret =3D =
wait_for_completion_interruptible_timeout(&req->completion,
+							timeout);
+	if (ret =3D=3D 0)
+		ret =3D -ETIMEDOUT;
+	if (ret < 0) {
+		cancel_generic_request(req);
+		return ret;
+	}
+
+	return req->result; /* completed */
+}
+
 static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 					 struct ceph_msg_header *hdr,
 					 int *skip)
@@ -1006,7 +1024,14 @@ int do_mon_command_vargs(struct ceph_mon_client =
*monc, const char *fmt,
 	send_generic_request(monc, req);
 	mutex_unlock(&monc->mutex);
=20
-	ret =3D wait_generic_request(req);
+	/*
+	 * ceph_monc_blocklist_add() runs from messenger dispatch, in a
+	 * kworker, with session->s_mutex held.  No signal arrives =
there.
+	 * CEPH_MONC_PING_TIMEOUT is how long an unanswered monitor
+	 * keepalive may last before the session is reopened; use that
+	 * so this worker cannot sleep for good.
+	 */
+	ret =3D wait_generic_request_timeout(req, =
CEPH_MONC_PING_TIMEOUT);
 out:
 	put_generic_request(req);
 	return ret;
--=20
2.43.0=
