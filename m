Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119E24BBEE
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581961; cv=none; b=RLbQyNXf+/voyCUNXRKhnGHXJRCPTXJi5w4nfPjrxoVONjVhf0gwa8XSZLoIlY/63MFFMdRFDc4lQngL7tbugmxQjQYkDRwZDNcb0dlMs2jbmwX6HyvbIA/IxiFOgUqGvnpMNdX0Nnn+edx5b38DCeZiM7nJyJTtDGpDSrE37cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581961; c=relaxed/simple;
	bh=jHckoklhFIgNQ3KRP8JNstw2U/aL4fV2GempOj3JSMk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uuIIo07iz/WSKtWvJLWD/bK+Kd0IvWVx0zSkUvOb0Sgcux4nka9B4CJQmkosklCRjKkN69nhEfs/v70akUkE/iFmOZL0a9U/5ANvcNlj8gUU+MDxAopMmCiA9KTFxddlWgIhQp9Genbc++hEdJXLZlD+HT3vg0vBH3IZDuvfNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eFhpxblD; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eFhpxblD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787581950; x=1787841150;
	bh=A3wwR3oTd+5Q2Tv8TFn8AY+Nb5hdderYWsWgxvfswLY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eFhpxblD8IBw9Y1+MxKnNT2LGy+3bCQ8FV63lIErT4A+yrb2uQw93rIkUb2K1fgsg
	 0j83WusYNpJemAGUA5k8awwSNeyT5kx6dDH3BMxTj8b8YShtd2gtpsk1ErHuAQvLsX
	 vq/+h3FU1+d3nAB1uM6+Ukv+xxDNz4+Yx92+hShAzeTmyvINbGncS+gkY6t02o8obx
	 Z7zeJrv3rG+HM1AdR21Hn4G6YYdgkN2OpK9JbUj7oe0pe0S6dz1KGp9oazO6uLyi+z
	 GoE0za8CF8k29aGWYEYShdB/F4GeA4ik7pPYwm0CjrzeZcWB4sRHCG2YlDx58yNGWi
	 EwXSNBtQe5pcQ==
Date: Mon, 24 Aug 2026 14:32:25 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>, "arnd@arndb.de" <arnd@arndb.de>
From: nirbhayykumarr@proton.me
Cc: "w@1wt.eu" <w@1wt.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v4] misc: mei: fix race condition between client teardown and read completion
Message-ID: <ftGV8Hp-LYTtUVnxctTg6RSMnglJf1Dkgx65y7bRorozRtAeBBPU3zTQNG8Bmj-wNjNl0hTO5m2hyGMw8TktWQ2bijbJzdmGsRmlv-XLk3A=@proton.me>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: 73ea16c688187fae6cd415c4a4467ced2cdf9d35
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This issue was discovered using a custom multi-threaded C fuzzer
designed to stress-test HECI client lifecycles over /dev/mei0. By
running one thread that streams asynchronous MKHI requests while a
second thread concurrently drives rapid open/close/reconnect cycles,
a race condition is triggered during client teardown.

In mei_release(), a host client is torn down upon close(). During this
sequence, mei_cl_disconnect() is invoked, which temporarily releases
dev->device_lock while waiting for the firmware response.

If an in-flight read request was previously submitted, an incoming
completion interrupt processed concurrently by the MEI interrupt
handler can add a completed callback into cl->rd_completed via
mei_cl_add_rd_completed().

Because mei_cl_flush_queues(cl, NULL) was invoked before
mei_cl_unlink(cl), an incoming completion callback can slip into
cl->rd_completed after the flush has completed but before the client
is unlinked from dev->file_list. When mei_cl_unlink() is subsequently
called, the invariant check at drivers/misc/mei/client.c:698 triggers:

  WARN_ON(!list_empty(&cl->rd_completed) ||
          !list_empty(&cl->rd_pending) ||
          !list_empty(&cl->link));

Call trace:
  WARNING: CPU: 2 PID: 5056 at drivers/misc/mei/client.c:698 mei_cl_unlink+=
0xaa/0x140 [mei]
  RIP: 0010:mei_cl_unlink+0xaa/0x140 [mei]
  Call Trace:
   <TASK>
   mei_release+0x202/0x270 [mei]
   __fput+0x105/0x2e0
   __x64_sys_close+0x90/0x140
   do_syscall_64+0xaa/0x660
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Immediately following mei_cl_unlink(), mei_release() calls kfree(cl).
If any remaining or deferred callback references the freed client, a
use-after-free occurs.

Fix this by flushing queues after unlinking the client from
dev->file_list inside mei_cl_unlink(), preventing concurrent IRQ
completions from populating the completed queue during teardown.

Note: An LLM was used solely to assist with the proper phrasing and=20
formatting of this commit message. The vulnerability discovery,=20
fuzzer development, and code fix are entirely original author's work.

Fixes: f35fe5f47ed0 ("mei: add a vtag map for each client")
Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
Cc: stable@vger.kernel.org
---
v4:
 - Added the fuzzer methodology to the commit message per maintainer reques=
t.
 - Documented LLM usage for Changelog formatting in the commit message.
 - Manually wrapped commit message lines to 72 characters.
v3:
 - Removed non-standard Helped-by tags.
v2:
 - Removed redundant Reported-by tag.
 - Added Fixes tag pointing to commit f35fe5f47ed0.

 drivers/misc/mei/client.c | 2 ++
 drivers/misc/mei/main.c   | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 643b003..38b5792 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -695,6 +695,8 @@ int mei_cl_unlink(struct mei_cl *cl)
 =09cl->state =3D MEI_FILE_UNINITIALIZED;
 =09cl->writing_state =3D MEI_IDLE;
=20
+=09mei_cl_flush_queues(cl, NULL);
+
 =09WARN_ON(!list_empty(&cl->rd_completed) ||
 =09=09!list_empty(&cl->rd_pending) ||
 =09=09!list_empty(&cl->link));
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 4fbf0b3..9e14ab4 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -148,7 +148,6 @@ static int mei_release(struct inode *inode, struct file=
 *file)
 =09=09goto out;
 =09}
=20
-=09mei_cl_flush_queues(cl, NULL);
 =09cl_dbg(dev, cl, "removing\n");
=20
 =09mei_cl_unlink(cl);
--=20
2.55.0
