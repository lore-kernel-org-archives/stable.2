Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC63C8719
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788494419; cv=none; b=RIS36q/uHphuw8k/kzI/b95RtZGUO4E+3ps5d/qTNjygwrP55WROpAnk0XAPXX1nFYlEBVDEiVRmxXA3+C4NV2Qk3D149UFwXGX3nYo/fGo3ZU42sNAJPANqLWC9hyjXSch9HbW/xBKb9rrg8J7E1OhTW8r2Bf6Ylccv0qs5JZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788494419; c=relaxed/simple;
	bh=irO0ztvGz9aCzG+lmimHYIagMPnJwSB90cZ9s2wamjY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kBWLoOhzHpx3JUlZU0/7YPemh+/z92/4UJykZV+zeyoVoURsDICK1aSX0plBxAfHD1kHdjT+K6fEIvL47kmmNClFyh8gt32IkpHKgGRBNwqo8CVXfly4GV43TNMqFCl6RMVy38oe2vukZYNFJ89WjkyJPU0oN6M8wEzA3YUWFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=B0cUjJwY; arc=none smtp.client-ip=109.224.244.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="B0cUjJwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788494404; x=1788753604;
	bh=02bPHVlPv8WtBxMn4N+hikdUZi0KhfDShNtz1hOgVhk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=B0cUjJwY7x+I5TOsDka9B2DsYxL2fk4FnCPELJTJUSKugwYsVOHUzXAai2Z25Cwb8
	 MY+n4U6k7CiLF4KCqIshCUn7B8fKyfoDKJcBYCADBMw3O1l2L/niPsHcc5mR5HRrhX
	 ljiPBwT35235bldmTc+oXQEBKVxbuecGxBrF+TcfvplcuoTKUFxx4b4c6HUBBLSkDe
	 oa+FvVA6nq9GJK2JJK0m6Tacc7l+Jwm30iVK741z/xJFN+vXdU6mtn2yiO6w3Cp+Jh
	 /Jubk89cx5/gTJayRpfW0frIpkkPKOOFLFiKw0HwUds7RXUaJ/49nVp8b39mAPFrsP
	 YpXumVJf1FANQ==
Date: Fri, 04 Sep 2026 03:59:58 +0000
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>
From: nirbhayykumarr@proton.me
Cc: "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] misc: mei: prevent reusing disconnecting clients in mei_ioctl_connect_vtag
Message-ID: <EMSkNBZm4uu_WZkFgR0kROn545GxY2HBpddaVmMEc5GggQEgOo5yFDDeY8r5Imj5te7fffDZwld1HeGzwFBtFZomlgCTvAetlLTaTaHHJQY=@proton.me>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: ff181a56e522d492a1754c29935a5b15e3f9910c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This issue was discovered using a custom multi-threaded C fuzzer
designed to stress-test MEI Virtual Tag (vtag) client lifecycles and
multiplexing over /dev/mei0. By concurrently racing rapid vtag
connections against file descriptor closures and streaming I/O, a
race condition is triggered during client teardown.

In mei_release(), closing the last file descriptor holding a virtual tag
invokes mei_cl_disconnect(). Inside __mei_cl_disconnect(),
dev->device_lock is dropped while awaiting the firmware disconnect ACK
on cl->wait.

During this lock-drop window, a concurrent IOCTL_MEI_CONNECT_CLIENT_VTAG
call on the same UUID scans dev->file_list. Because
mei_ioctl_connect_vtag() only verified pos->me_cl without checking
pos->state, it matched the tearing-down client (in
MEI_FILE_DISCONNECTING), repointed file->private_data to pos, and added a
new vtag to pos->vtag_map.

When the disconnect ACK arrived, __mei_cl_disconnect() called
mei_cl_set_disconnected(pos), setting pos->me_cl =3D NULL and pos->state =
=3D
MEI_FILE_DISCONNECTED. Because pos->vtag_map now contained the second
thread's tag, mei_release() skipped unlinking and freeing pos. The second
thread then attempted to reuse this disconnected client, causing packet
demuxing mismatches, continuous CSME hardware link resets, and DRM/i915
display freezes.

Fix this by:
1. Validating pos->state in mei_ioctl_connect_vtag() to ensure only
   active clients (MEI_FILE_CONNECTED or MEI_FILE_CONNECTING) are reused.
2. Setting cb->vtag during callback allocation in mei_io_cb_init() via
   mei_cl_vtag_by_fp().
3. Demuxing incoming read packets in mei_cl_irq_read_msg() by matching
   vtag against cl->rd_pending rather than blindly dequeuing the head.

Fixes: f35fe5f47ed0 ("mei: add a vtag map for each client")
Cc: stable@vger.kernel.org
Signed-off-by: Nirbhay Kumar <nirbhayykumarr@proton.me>
---
 drivers/misc/mei/client.c    | 24 ++++++++++++-
 drivers/misc/mei/client.h    |  1 +
 drivers/misc/mei/interrupt.c | 65 +++++++++++++++++++++++-------------
 drivers/misc/mei/main.c      | 24 +++----------
 4 files changed, 69 insertions(+), 45 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 5f648481024..b10c483673a 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -379,7 +379,7 @@ static struct mei_cl_cb *mei_io_cb_init(struct mei_cl *=
cl,
 =09cb->cl =3D cl;
 =09cb->buf_idx =3D 0;
 =09cb->fop_type =3D type;
-=09cb->vtag =3D 0;
+=09cb->vtag =3D mei_cl_vtag_by_fp(cl, fp);
 =09cb->ext_hdr =3D NULL;
=20
 =09return cb;
@@ -1313,6 +1313,28 @@ const struct file *mei_cl_fp_by_vtag(const struct me=
i_cl *cl, u8 vtag)
 =09return ERR_PTR(-ENOENT);
 }
=20
+/**
+ * mei_cl_vtag_by_fp - obtain the vtag by file pointer
+ *
+ * @cl: host client
+ * @fp: pointer to file structure
+ *
+ * Return: vtag value on success, otherwise 0
+ */
+u8 mei_cl_vtag_by_fp(const struct mei_cl *cl, const struct file *fp)
+{
+=09struct mei_cl_vtag *cl_vtag;
+
+=09if (!cl || !fp)
+=09=09return 0;
+
+=09list_for_each_entry(cl_vtag, &cl->vtag_map, list)
+=09=09if (cl_vtag->fp =3D=3D fp)
+=09=09=09return cl_vtag->vtag;
+=09return 0;
+}
+
 /**
  * mei_cl_reset_read_by_vtag - reset pending_read flag by given vtag
  *
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index 031114478bc..a15f1936703 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -146,6 +146,7 @@ int mei_cl_flush_queues(struct mei_cl *cl, const struct=
 file *fp);
=20
 struct mei_cl_vtag *mei_cl_vtag_alloc(struct file *fp, u8 vtag);
 const struct file *mei_cl_fp_by_vtag(const struct mei_cl *cl, u8 vtag);
+u8 mei_cl_vtag_by_fp(const struct mei_cl *cl, const struct file *fp);
 int mei_cl_vt_support_check(const struct mei_cl *cl);
 /*
  *  MEI input output function prototype
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 4262965c4f9..1e5b7728b56 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -96,7 +96,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 =09=09=09       struct list_head *cmpl_list)
 {
 =09struct mei_device *dev =3D cl->dev;
-=09struct mei_cl_cb *cb;
+=09struct mei_cl_cb *cb =3D NULL;
=20
 =09struct mei_ext_hdr_vtag *vtag_hdr =3D NULL;
 =09struct mei_ext_hdr_gsc_f2h *gsc_f2h =3D NULL;
@@ -108,24 +108,11 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 =09length =3D mei_hdr->length;
 =09ext_len =3D 0;
 =09if (mei_hdr->extended) {
+=09=09struct mei_ext_hdr *ext =3D mei_ext_begin(meta);
+
 =09=09ext_len =3D sizeof(*meta) + mei_slots2data(meta->size);
 =09=09length -=3D ext_len;
-=09}
=20
-=09cb =3D list_first_entry_or_null(&cl->rd_pending, struct mei_cl_cb, list=
);
-=09if (!cb) {
-=09=09if (!mei_cl_is_fixed_address(cl)) {
-=09=09=09cl_err(dev, cl, "pending read cb not found\n");
-=09=09=09goto discard;
-=09=09}
-=09=09cb =3D mei_cl_alloc_cb(cl, mei_cl_mtu(cl), MEI_FOP_READ, cl->fp);
-=09=09if (!cb)
-=09=09=09goto discard;
-=09=09list_add_tail(&cb->list, &cl->rd_pending);
-=09}
-
-=09if (mei_hdr->extended) {
-=09=09struct mei_ext_hdr *ext =3D mei_ext_begin(meta);
 =09=09do {
 =09=09=09switch (ext->type) {
 =09=09=09case MEI_EXT_HDR_VTAG:
@@ -133,18 +120,16 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 =09=09=09=09break;
 =09=09=09case MEI_EXT_HDR_GSC:
 =09=09=09=09gsc_f2h =3D (struct mei_ext_hdr_gsc_f2h *)ext;
-=09=09=09=09cb->ext_hdr =3D (struct mei_ext_hdr *) kzalloc_obj(*gsc_f2h);
-=09=09=09=09if (!cb->ext_hdr) {
-=09=09=09=09=09cb->status =3D -ENOMEM;
-=09=09=09=09=09goto discard;
-=09=09=09=09}
 =09=09=09=09break;
 =09=09=09case MEI_EXT_HDR_NONE:
 =09=09=09=09fallthrough;
 =09=09=09default:
 =09=09=09=09cl_err(dev, cl, "unknown extended header\n");
-=09=09=09=09cb->status =3D -EPROTO;
-=09=09=09=09break;
+=09=09=09=09cb =3D list_first_entry_or_null(&cl->rd_pending,
+=09=09=09=09=09=09=09      struct mei_cl_cb, list);
+=09=09=09=09if (cb)
+=09=09=09=09=09cb->status =3D -EPROTO;
+=09=09=09=09goto discard;
 =09=09=09}
=20
 =09=09=09ext =3D mei_ext_next(ext);
@@ -152,11 +137,38 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
=20
 =09=09if (!vtag_hdr && !gsc_f2h) {
 =09=09=09cl_dbg(dev, cl, "no vtag or gsc found in extended header.\n");
-=09=09=09cb->status =3D -EPROTO;
+=09=09=09cb =3D list_first_entry_or_null(&cl->rd_pending,
+=09=09=09=09=09=09      struct mei_cl_cb, list);
+=09=09=09if (cb)
+=09=09=09=09cb->status =3D -EPROTO;
 =09=09=09goto discard;
 =09=09}
 =09}
=20
+=09if (vtag_hdr) {
+=09=09struct mei_cl_cb *pos;
+
+=09=09list_for_each_entry(pos, &cl->rd_pending, list) {
+=09=09=09if (pos->vtag =3D=3D vtag_hdr->vtag) {
+=09=09=09=09cb =3D pos;
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09} else {
+=09=09cb =3D list_first_entry_or_null(&cl->rd_pending, struct mei_cl_cb, l=
ist);
+=09}
+
+=09if (!cb) {
+=09=09if (!mei_cl_is_fixed_address(cl)) {
+=09=09=09cl_err(dev, cl, "pending read cb not found\n");
+=09=09=09goto discard;
+=09=09}
+=09=09cb =3D mei_cl_alloc_cb(cl, mei_cl_mtu(cl), MEI_FOP_READ, cl->fp);
+=09=09if (!cb)
+=09=09=09goto discard;
+=09=09list_add_tail(&cb->list, &cl->rd_pending);
+=09}
+
 =09if (vtag_hdr) {
 =09=09cl_dbg(dev, cl, "vtag: %d\n", vtag_hdr->vtag);
 =09=09if (cb->vtag && cb->vtag !=3D vtag_hdr->vtag) {
@@ -187,6 +199,11 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 =09=09=09cb->status =3D -EPROTO;
 =09=09=09goto discard;
 =09=09}
+=09=09cb->ext_hdr =3D (struct mei_ext_hdr *) kzalloc_obj(*gsc_f2h);
+=09=09if (!cb->ext_hdr) {
+=09=09=09cb->status =3D -ENOMEM;
+=09=09=09goto discard;
+=09=09}
 =09=09memcpy(cb->ext_hdr, gsc_f2h, ext_hdr_len);
 =09}
=20
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 4fbf0b32361..99ac29a464b 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -284,26 +284,6 @@ static ssize_t mei_read(struct file *file, char __user=
 *ubuf,
 =09return rets;
 }
=20
-/**
- * mei_cl_vtag_by_fp - obtain the vtag by file pointer
- *
- * @cl: host client
- * @fp: pointer to file structure
- *
- * Return: vtag value on success, otherwise 0
- */
-static u8 mei_cl_vtag_by_fp(const struct mei_cl *cl, const struct file *fp=
)
-{
-=09struct mei_cl_vtag *cl_vtag;
-
-=09if (!fp)
-=09=09return 0;
-
-=09list_for_each_entry(cl_vtag, &cl->vtag_map, list)
-=09=09if (cl_vtag->fp =3D=3D fp)
-=09=09=09return cl_vtag->vtag;
-=09return 0;
-}
=20
 /**
  * mei_write - the write function.
@@ -564,6 +544,10 @@ static int mei_ioctl_connect_vtag(struct file *file,
 =09=09=09if (!pos->me_cl)
 =09=09=09=09continue;
=20
+=09=09=09if (pos->state !=3D MEI_FILE_CONNECTED &&
+=09=09=09    pos->state !=3D MEI_FILE_CONNECTING)
+=09=09=09=09continue;
+
 =09=09=09/* only search for same UUID */
 =09=09=09if (uuid_le_cmp(*mei_cl_uuid(pos), *in_client_uuid))
 =09=09=09=09continue;
