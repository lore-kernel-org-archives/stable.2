Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2F372EE9
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563966; cv=none; b=NcENz8vPsKnuW2qVLxm11LBEbGVvqba+Q7lckX6SLv46+ysWpyAvm7BmBXkup0vwo+PwshuwUEvjvh9LJQBrfyFZobMRlxF9AeeQNPBb/qd0uNf8TUnOqjsvQv6dfjpo4I81L6BXtJSDG0s2ua9HxPZS0a3ojYMcOF47Xa45Shw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563966; c=relaxed/simple;
	bh=goiJTpD81UkO+0bjpn3mID+t6jNNmAbwGS8t9jULR+w=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Rq70IMLiakW2uhTepoFsVErVu87E4wy+vFqjlVHF/jEVdzpkbkmFK6btcOEYXd+VM3pkJiY62VAr1FYscUaqSNdSa3zVKhld5HGneEB1gsT/bw2hF5XZT5NpHKfm3IWbc/c1a/gtLYWp4RcIBGlFKHqw+7LaUMr5ihDPFyh2RaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eCxD/pA7; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eCxD/pA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3x6yn6cahjg4xcixgpjh652ui4.protonmail; t=1787563953; x=1787823153;
	bh=7+h9sFzK/L+TPtTP07y0l9vvNK0ZelQsWXu2ppus/oM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eCxD/pA7A33ZB9D38d00RotGh251Cdn3w/dvRqWuVDEOH17x5xz6xHrA3xQIZPA1k
	 JgKtmPOH9vyc1+/N2dsk4oeH6xE7XuQYR04VDVnOegC+NcZbYZ6OpN/VUdnNgJ8jtn
	 MsiNSQLBsy6TaIrZewG+PJPrvNmWpRkydhfOdc7V1utctH+60+P93zphAsA3lnxfta
	 qgudIbLrQa8eQzpyvqQLbgxtMp91L/vopm3Zxpi/jtx4czhch8So7TXfUCxyJWIYuV
	 pGNlOk3W6JuTNDM4YVbsUUzqRiLXH8ZWASa3UR1jFSo4X/596NTcKtXpxZ57uAyoNn
	 hpW+X1CFF9nww==
Date: Mon, 24 Aug 2026 09:32:27 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>
From: nirbhayykumarr@proton.me
Cc: "w@1wt.eu" <w@1wt.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3] misc: mei: fix race condition between client teardown and read completion
Message-ID: <2oKLyY1tm4g6xwyvmh7loQ1t1EBr1rNjMzfiXN-b0q8BbO_4vjW0xcxR_aTEielTWx5ma4f1NCO4Y5LG98PRKseN6WLUbnXR9zGtcQVR9zY=@proton.me>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: a2d84506cae9a7addd5c271afd29cd103fd04c40
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
Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
Cc: stable@vger.kernel.org
---
v3:
 - Removed non-standard Helped-by tags.
 - Omitted Assisted-by: No AI or co-authors were used. The "we" in my origi=
nal report referred to a colleague who merely verified and confirmed the bu=
g.
v2:
 - Removed redundant Reported-by tag.
 - Added Fixes tag pointing to commit f35fe5f47ed0.
 - Sent inline plain text without attachments.

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
