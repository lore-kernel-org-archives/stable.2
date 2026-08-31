Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408733937B;
	Mon, 31 Aug 2026 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174507; cv=none; b=RCoBDaGhjWwBT07+qeZf5Y3dg3b0fVzyIcYi40VzWp2Z7cWAtNJPLURXcHwbuPrLrst+f4LrSI05+kRcpXJTb+K1H0FvkPUx3LdCjhIwzbLELKg1fgC/rTGo7h9gvwL9vZq76Zai1weZMoGaP+c9UF3pNOh5ToHqtCXnc67em9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174507; c=relaxed/simple;
	bh=/jxeczQ3Fa02IZhoJ5F0M0ByZzb0mOKhDnU2QplTJWU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o6fRGvb4sJLXEKrSthdc3vlSHOgaQCgRe+TuyJYMtBw6WDinq5/fdb0ykZ0ZH2LsoiQkj/CpCqF0NfXee8z1OYwpzXUK972LN675s2Lj/uy7H9QXZeUNhQqjIlKfUD446B9YGQTe547g/ppQEEUZ2L8+F5TaRiEaLI9Nn+fIPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TGpDoU/w; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TGpDoU/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=cdudu6qx55gfpj33jy6nsijv64.protonmail; t=1788174493; x=1788433693;
	bh=qL2nvt12B4OCMapLuiN+uCRwAvp6CZPRm4OSVLyjztg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TGpDoU/w8hracj/M7Az1bJJflLjQmlAweY1F7t95wxv9AGRAT7FoY5SWub1DYGkFF
	 +I0MQ2Z/syRpvejO5iqCj5JK4c7oqOHRsjIe55hDMQsMURj0sQXIX8IJ7cuBGEssIf
	 JDQRUA9LrDu5jP8KvZKn0Wp3+pyN80e6Wn4hbc2mGV67uTbINGYiXjQuz701oM/GN0
	 k0GleXVZe1Ol3a0/PCLGedceu9fS8gQjsxxjYNP6QtNOKE5WDdRZjdoTzP3uZb0t4G
	 9x4TkdBU4K3ErFCf8hbBMmq2WXkU0lXL+RExkdz/kfRbn+beVusKAvDxVkcVjVu+xx
	 avNCvu2AgOcpg==
Date: Mon, 31 Aug 2026 11:08:10 +0000
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>
From: nirbhayykumarr@proton.me
Cc: "w@1wt.eu" <w@1wt.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v5] misc: mei: fix queue cleanup and list handling during client teardown
Message-ID: <YJsGZtBSVaHTkfjq2Unkm1i_gI8tfiGw1vWFkjzVDMVg1MiryXVpD8JWHs3v0me811S5NfpS-OO97DKMFZDProekqAbz-LIsiiYi546FJ9o=@proton.me>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: ce6e72415c2f88582e67281ae8d2013c09b849e2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This issue was discovered using a multi threaded C fuzzer designed to
stress test HECI client lifecycles over /dev/mei0. When closing a client
while concurrent asynchronous requests are in flight, mei_cl_unlink()
triggers an invariant warning:

  WARNING: CPU: 2 PID: 5056 at drivers/misc/mei/client.c:698 mei_cl_unlink+=
0xaa/0x140 [mei]
  WARN_ON(!list_empty(&cl->rd_completed) ||
          !list_empty(&cl->rd_pending) ||
          !list_empty(&cl->link));

This occurs due to two issues in queue cleanup:
1. mei_cl_free_pending() uses list_first_entry_or_null(), freeing at
   most one callback from cl->rd_pending rather than purging all pending
   callbacks. When multiple pending reads are queued, subsequent entries
   remain in cl->rd_pending.
2. In mei_cl_flush_queues(cl, fp), when closing an individual vtag file
   descriptor (fp !=3D NULL), pending and control queues (ctrl_wr_list,
   ctrl_rd_list, rd_pending) are skipped entirely, leaving dangling
   callbacks referencing the closed file object.

Fix this by:
- Updating mei_cl_free_pending() to iterate with list_for_each_entry_safe()
  and accept fp to filter callbacks matching the closing file descriptor,
  or free all callbacks when fp is NULL.
- Updating mei_io_list_flush_cl() to support fp filtering.
- Updating mei_cl_flush_queues() to clean control and pending read queues
  for both per-file closures and final client teardown.

Fixes: f35fe5f47ed0 ("mei: add a vtag map for each client")
Cc: stable@vger.kernel.org
Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
---
v5:
 - Addressed maintainer review: fixed root causes in queue cleanup
   rather than moving call sites.
 - Updated mei_cl_free_pending() to iterate with list_for_each_entry_safe()
   to purge all pending callbacks.
 - Updated mei_io_list_flush_cl() and mei_cl_flush_queues() to support
   per-file (fp) queue flushing.
v4:
 - Added the fuzzer methodology to the commit message per maintainer reques=
t.
 - Manually wrapped commit message lines to 72 characters.
v3:
 - Removed non-standard Helped-by tags.
v2:
 - Removed redundant Reported-by tag.
 - Added Fixes tag pointing to commit f35fe5f47ed0.

 drivers/misc/mei/client.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 26d2b2742d5..5f648481024 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -390,14 +390,16 @@ static struct mei_cl_cb *mei_io_cb_init(struct mei_cl=
 *cl,
  *
  * @head:  an instance of our list structure
  * @cl:    host client
+ * @fp:    file pointer (matching cb file object), may be NULL
  */
 static void mei_io_list_flush_cl(struct list_head *head,
-=09=09=09=09 const struct mei_cl *cl)
+=09=09=09=09 const struct mei_cl *cl,
+=09=09=09=09 const struct file *fp)
 {
 =09struct mei_cl_cb *cb, *next;

 =09list_for_each_entry_safe(cb, next, head, list) {
-=09=09if (cl =3D=3D cb->cl) {
+=09=09if (cl =3D=3D cb->cl && (!fp || fp =3D=3D cb->fp)) {
 =09=09=09list_del_init(&cb->list);
 =09=09=09if (cb->fop_type =3D=3D MEI_FOP_READ)
 =09=09=09=09mei_io_cb_free(cb);
@@ -446,16 +448,19 @@ static void mei_io_rd_list_free_fp(struct mei_cl *cl,=
 const struct file *fp)
 }

 /**
- * mei_cl_free_pending - free pending cb
+ * mei_cl_free_pending - free pending cbs
  *
  * @cl: host client
+ * @fp: file pointer (matching cb file object), may be NULL
  */
-static void mei_cl_free_pending(struct mei_cl *cl)
+static void mei_cl_free_pending(struct mei_cl *cl, const struct file *fp)
 {
-=09struct mei_cl_cb *cb;
+=09struct mei_cl_cb *cb, *next;

-=09cb =3D list_first_entry_or_null(&cl->rd_pending, struct mei_cl_cb, list=
);
-=09mei_io_cb_free(cb);
+=09list_for_each_entry_safe(cb, next, &cl->rd_pending, list) {
+=09=09if (!fp || fp =3D=3D cb->fp)
+=09=09=09mei_io_cb_free(cb);
+=09}
 }

 /**
@@ -565,12 +570,9 @@ int mei_cl_flush_queues(struct mei_cl *cl, const struc=
t file *fp)
 =09cl_dbg(dev, cl, "remove list entry belonging to cl\n");
 =09mei_io_tx_list_free_cl(&cl->dev->write_list, cl, fp);
 =09mei_io_tx_list_free_cl(&cl->dev->write_waiting_list, cl, fp);
-=09/* free pending and control cb only in final flush */
-=09if (!fp) {
-=09=09mei_io_list_flush_cl(&cl->dev->ctrl_wr_list, cl);
-=09=09mei_io_list_flush_cl(&cl->dev->ctrl_rd_list, cl);
-=09=09mei_cl_free_pending(cl);
-=09}
+=09mei_io_list_flush_cl(&cl->dev->ctrl_wr_list, cl, fp);
+=09mei_io_list_flush_cl(&cl->dev->ctrl_rd_list, cl, fp);
+=09mei_cl_free_pending(cl, fp);
 =09mei_io_rd_list_free_fp(cl, fp);

 =09return 0;
@@ -790,8 +792,8 @@ static void mei_cl_set_disconnected(struct mei_cl *cl)
 =09cl->state =3D MEI_FILE_DISCONNECTED;
 =09mei_io_tx_list_free_cl(&dev->write_list, cl, NULL);
 =09mei_io_tx_list_free_cl(&dev->write_waiting_list, cl, NULL);
-=09mei_io_list_flush_cl(&dev->ctrl_rd_list, cl);
-=09mei_io_list_flush_cl(&dev->ctrl_wr_list, cl);
+=09mei_io_list_flush_cl(&dev->ctrl_rd_list, cl, NULL);
+=09mei_io_list_flush_cl(&dev->ctrl_wr_list, cl, NULL);
 =09mei_cl_wake_all(cl);
 =09cl->rx_flow_ctrl_creds =3D 0;
 =09cl->tx_flow_ctrl_creds =3D 0;
@@ -1151,8 +1153,8 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_c=
lient *me_cl,

 =09if (!mei_cl_is_connected(cl)) {
 =09=09if (cl->state =3D=3D MEI_FILE_DISCONNECT_REQUIRED) {
-=09=09=09mei_io_list_flush_cl(&dev->ctrl_rd_list, cl);
-=09=09=09mei_io_list_flush_cl(&dev->ctrl_wr_list, cl);
+=09=09=09mei_io_list_flush_cl(&dev->ctrl_rd_list, cl, NULL);
+=09=09=09mei_io_list_flush_cl(&dev->ctrl_wr_list, cl, NULL);
 =09=09=09 /* ignore disconnect return valuue;
 =09=09=09  * in case of failure reset will be invoked
 =09=09=09  */
--=20
2.55.0
