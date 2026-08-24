Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D236F905;
	Mon, 24 Aug 2026 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538764; cv=none; b=lHxl4gneUlWd+joC4DaHit2CHg5XVo1TsM3Zc6fgb7pMEMlOq0zE79+wny6zXrK6hO655FBKp8EvukQj3sm5SebSLa1V1r53GHLeRtwhqANrD8hMApn6ivSeZEZ3OTf8gCWiRrJhylsb9slZpgaklVZHrvNgeRJx7Zkqa082N4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538764; c=relaxed/simple;
	bh=NwkZ0WftKFL0fiULLEYQmShV0iQtCEYdG4MbEtd5z+s=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZQIzmYY20HGu9JhT/I+8H00b35FSUYbC7cgTpDQpqa/kZbGLhLmz0Uigx9Kvb3JD6teSsT9nJlaihA3EjJMNsd2hWJFPYI2D3DJvZjiIA0rJ1d3p4uanruuc0wI/QeiS3hkP2mcQvLWsQSA5gR/RcCcGmccShrOEDODjoKjHkC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FBuyvhMS; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FBuyvhMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787538746; x=1787797946;
	bh=CO0P/4spPJKMxUAFueCKPG9jpVdFqvTvazGX83BR+GA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FBuyvhMSvNA94G3vYCk/wfVeLew1gbFas2tQrUqncV6AFuXxP2ZdHRIIMqYDrcd/P
	 RWAS76Ts6kosxrbfapm7bf63M5qUQ5W45yKnNevt7yx9d3rFOjZ/YdDdW3Jk1oHbh7
	 JFZLA8BJxlnnXZBCCJuESTTtNV+/Jil47H1JMlEssxRtZWEYvIQMTquQL2bjM71vrh
	 3iVKwIXC1hwKQguUvAq02iBwhfu+3SqWPfoLO9/zyAfXe5wAd0k+7ksxMIsOLVufD2
	 ipGS/KQXklWF8tsVEjMmuYNnYa/wsWbIrqQMrxy6cC+cww4ydlykBNNNIXe4wLaxBs
	 +9ovlEwzpcciw==
Date: Mon, 24 Aug 2026 02:32:20 +0000
To: "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: nirbhayykumarr@proton.me
Cc: "w@1wt.eu" <w@1wt.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] misc: mei: fix race condition between client teardown and read completion
Message-ID: <C3Rme4R7BxcZVE877gMzMhltbPTsvsMjN39D1qWG_5JYO1-l0OphcpyU-XbPGQTMlPuZDV5Dzgn09MOdFBChmprsrpVlp27eAxmZpzV9Ays=@proton.me>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: 0bb16a8d6da00a8767e572a7db202b2a2aa83d2f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In mei_release(), a host client is torn down upon close(). During this
teardown sequence, mei_cl_disconnect() is invoked, which releases
dev->device_lock while waiting for the firmware response.

If an in-flight read request was previously submitted, an incoming
completion interrupt processed concurrently by the MEI interrupt
handler can add a completed callback into cl->rd_completed via
mei_cl_add_rd_completed().

Because mei_cl_flush_queues(cl, NULL) was invoked before mei_cl_unlink(cl),
an incoming completion callback can slip into cl->rd_completed after the
flush has completed but before the client is unlinked from dev->file_list.
When mei_cl_unlink() is subsequently called, the invariant check at
drivers/misc/mei/client.c:698 triggers:

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

Fix this by flushing queues after unlinking the client from dev->file_list
inside mei_cl_unlink(), preventing concurrent IRQ completions from
populating the client's completed queue during teardown.

Fixes: f35fe5f47ed0 ("mei: add a vtag map for each client")
Helped-by: Willy Tarreau <w@1wt.eu>
Helped-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
Cc: stable@vger.kernel.org
---
v2:
 - Removed redundant Reported-by tag.
 - Added Fixes tag tracing back to the commit that introduced the race wind=
ow.
 - Added Helped-by tags to credit Willy and Greg for guidance.
 - Sent inline without attachment as requested.

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

-=09mei_cl_flush_queues(cl, NULL);
 =09cl_dbg(dev, cl, "removing\n");

 =09mei_cl_unlink(cl);
--=20
2.55.0
