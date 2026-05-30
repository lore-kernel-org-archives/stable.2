Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810EE39D3D9
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141252; cv=none; b=KFHGbAOoZuDu+LwskPydBV56yqFOjgzZNR5OBHNB+TN5rzsOKRLcmHFYtpOZggQqPoeO7sRGYazStiZtRqXHn/UYOhPHwrP+96y3HfvL/F+U1WRkBECkTGlyw+rw/Tlahz7P+f40XbbdpbscFVfUnXhDiOB2cSt230h1E5PFXfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141252; c=relaxed/simple;
	bh=DbZGorR/nC0f8PqwgOrPkdzfdLPvJfOh6XEV6BGRlLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJNikLkL08+BztA0w1c2rk/azRyuS7ileaH/sg63LqCrLeqmydxonxAcI6wRJTZlTgT35UEv6erDJLsK5JGi4oitTzm7GcMHMO8fBu9OJsgI1DiSTbohMMiSNeblxPUopUNnXRUe5ibFTQdQOnQpUASyehGygKThBhwBKBndMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG+6E2eH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG+6E2eH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D581F00893;
	Sat, 30 May 2026 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141249;
	bh=ZRVzSxDiqOjyJfIKjhra1mUoA3a4FHSLJV0GnID6PCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KG+6E2eHsBdtUTT+3WHnotuFQLfsMJuck/UAmeMvpx+n1WmyS8Oo0ar6pgplsGaaw
	 1ASUQXI4F3pjS7bvjsvZKJCkOQXjXqQ9Wgz7TVCrIhJoCVjGxg9UidqeEjbBGFdhvQ
	 014jo22hqMhnC3M+S5JK3JEIIMIWGx9mjbLqpoNJqH06uN6O/Up6KmO9EOWF5N5oYf
	 my5gijrIlVf/M6F+thfZTb8gTF0KG/94hv9k2K1z0rTtyzH9xdmYCArL9nu8+agj9L
	 ldETceYmdmhOcQ+/pMkUqTxgoYaMTraRf6LG1lzxnjIEJBwQI/rOkKGuyQV1axP6fe
	 VyqEZkoOS/joQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] use less confusing names for iov_iter direction initializers
Date: Sat, 30 May 2026 07:40:43 -0400
Message-ID: <20260530114046.1945359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052841-mobility-surgery-8063@gregkh>
References: <2026052841-mobility-surgery-8063@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit de4eda9de2d957ef2d6a8365a01e26a435e958cb ]

READ/WRITE proved to be actively confusing - the meanings are
"data destination, as used with read(2)" and "data source, as
used with write(2)", but people keep interpreting those as
"we read data from it" and "we write data to it", i.e. exactly
the wrong way.

Call them ITER_DEST and ITER_SOURCE - at least that is harder
to misinterpret...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/microcode/intel.c    |  4 ++--
 crypto/testmgr.c                         |  4 ++--
 drivers/block/drbd/drbd_main.c           |  2 +-
 drivers/block/drbd/drbd_receiver.c       |  2 +-
 drivers/block/loop.c                     | 14 +++++++-------
 drivers/block/nbd.c                      | 10 +++++-----
 drivers/char/random.c                    |  4 ++--
 drivers/fsi/fsi-sbefifo.c                |  6 +++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c   |  2 +-
 drivers/isdn/mISDN/l1oip_core.c          |  2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c  |  6 +++---
 drivers/net/ppp/ppp_generic.c            |  2 +-
 drivers/nvme/host/tcp.c                  |  4 ++--
 drivers/nvme/target/io-cmd-file.c        |  4 ++--
 drivers/nvme/target/tcp.c                |  2 +-
 drivers/scsi/sg.c                        |  2 +-
 drivers/target/iscsi/iscsi_target_util.c |  4 ++--
 drivers/target/target_core_file.c        |  2 +-
 drivers/usb/usbip/usbip_common.c         |  2 +-
 drivers/vhost/net.c                      |  6 +++---
 drivers/vhost/scsi.c                     | 10 +++++-----
 drivers/vhost/vhost.c                    |  6 +++---
 drivers/vhost/vringh.c                   |  4 ++--
 drivers/vhost/vsock.c                    |  4 ++--
 drivers/xen/pvcalls-back.c               |  8 ++++----
 fs/9p/vfs_addr.c                         |  4 ++--
 fs/9p/vfs_dir.c                          |  2 +-
 fs/9p/xattr.c                            |  4 ++--
 fs/afs/cmservice.c                       |  2 +-
 fs/afs/dir.c                             |  2 +-
 fs/afs/file.c                            |  4 ++--
 fs/afs/internal.h                        |  4 ++--
 fs/afs/rxrpc.c                           | 10 +++++-----
 fs/afs/write.c                           |  4 ++--
 fs/aio.c                                 |  4 ++--
 fs/ceph/addr.c                           |  2 +-
 fs/ceph/file.c                           |  4 ++--
 fs/cifs/connect.c                        |  6 +++---
 fs/cifs/file.c                           |  4 ++--
 fs/cifs/smb2ops.c                        |  4 ++--
 fs/cifs/transport.c                      |  6 +++---
 fs/fuse/ioctl.c                          |  4 ++--
 fs/nfsd/vfs.c                            |  4 ++--
 fs/ocfs2/cluster/tcp.c                   |  2 +-
 fs/orangefs/inode.c                      |  8 ++++----
 fs/read_write.c                          | 12 ++++++------
 fs/seq_file.c                            |  2 +-
 fs/splice.c                              | 10 +++++-----
 include/linux/uio.h                      |  3 +++
 mm/madvise.c                             |  2 +-
 mm/page_io.c                             |  2 +-
 mm/process_vm_access.c                   |  2 +-
 net/9p/client.c                          |  2 +-
 net/bluetooth/6lowpan.c                  |  2 +-
 net/bluetooth/a2mp.c                     |  2 +-
 net/bluetooth/smp.c                      |  2 +-
 net/ceph/messenger_v1.c                  |  4 ++--
 net/ceph/messenger_v2.c                  | 14 +++++++-------
 net/compat.c                             |  2 +-
 net/ipv4/tcp.c                           |  4 ++--
 net/netfilter/ipvs/ip_vs_sync.c          |  2 +-
 net/smc/smc_clc.c                        |  6 +++---
 net/socket.c                             | 12 ++++++------
 net/sunrpc/socklib.c                     |  6 +++---
 net/sunrpc/svcsock.c                     |  4 ++--
 net/sunrpc/xprtsock.c                    |  6 +++---
 net/tipc/topsrv.c                        |  2 +-
 net/tls/tls_device.c                     |  4 ++--
 net/xfrm/espintcp.c                      |  2 +-
 security/keys/keyctl.c                   |  4 ++--
 70 files changed, 158 insertions(+), 155 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1ba590e6ef7bb..83c788ba309a0 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -940,7 +940,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
-	iov_iter_kvec(&iter, WRITE, &kvec, 1, firmware->size);
+	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, firmware->size);
 	ret = generic_load_microcode(cpu, &iter);
 
 	release_firmware(firmware);
@@ -959,7 +959,7 @@ request_microcode_user(int cpu, const void __user *buf, size_t size)
 
 	iov.iov_base = (void __user *)buf;
 	iov.iov_len = size;
-	iov_iter_init(&iter, WRITE, &iov, 1, size);
+	iov_iter_init(&iter, ITER_SOURCE, &iov, 1, size);
 
 	return generic_load_microcode(cpu, &iter);
 }
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 163a1283a866a..2398306ab5ce7 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -750,7 +750,7 @@ static int build_cipher_test_sglists(struct cipher_test_sglists *tsgls,
 	struct iov_iter input;
 	int err;
 
-	iov_iter_kvec(&input, WRITE, inputs, nr_inputs, src_total_len);
+	iov_iter_kvec(&input, ITER_SOURCE, inputs, nr_inputs, src_total_len);
 	err = build_test_sglist(&tsgls->src, cfg->src_divs, alignmask,
 				cfg->inplace ?
 					max(dst_total_len, src_total_len) :
@@ -1133,7 +1133,7 @@ static int build_hash_sglist(struct test_sglist *tsgl,
 
 	kv.iov_base = (void *)vec->plaintext;
 	kv.iov_len = vec->psize;
-	iov_iter_kvec(&input, WRITE, &kv, 1, vec->psize);
+	iov_iter_kvec(&input, ITER_SOURCE, &kv, 1, vec->psize);
 	return build_test_sglist(tsgl, cfg->src_divs, alignmask, vec->psize,
 				 &input, divs);
 }
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 13f9911bc0269..226661f6d97c2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1843,7 +1843,7 @@ int drbd_send(struct drbd_connection *connection, struct socket *sock,
 
 	/* THINK  if (signal_pending) return ... ? */
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, size);
 
 	if (sock == connection->data.socket) {
 		rcu_read_lock();
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ea38dd43c6b0e..f9cf6428a3d12 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -507,7 +507,7 @@ static int drbd_recv_short(struct socket *sock, void *buf, size_t size, int flag
 	struct msghdr msg = {
 		.msg_flags = (flags ? flags : MSG_WAITALL | MSG_NOSIGNAL)
 	};
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, size);
 	return sock_recvmsg(sock, &msg, msg.msg_flags);
 }
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a612370dd9ecf..45684136e8376 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -310,7 +310,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 	struct iov_iter i;
 	ssize_t bw;
 
-	iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
+	iov_iter_bvec(&i, ITER_SOURCE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos, 0);
@@ -388,7 +388,7 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	ssize_t len;
 
 	rq_for_each_segment(bvec, rq, iter) {
-		iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
+		iov_iter_bvec(&i, ITER_DEST, &bvec, 1, bvec.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0)
 			return len;
@@ -429,7 +429,7 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 		b.bv_offset = 0;
 		b.bv_len = bvec.bv_len;
 
-		iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
+		iov_iter_bvec(&i, ITER_DEST, &b, 1, b.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0) {
 			ret = len;
@@ -551,7 +551,7 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 }
 
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, bool rw)
+		     loff_t pos, int rw)
 {
 	struct iov_iter iter;
 	struct req_iterator rq_iter;
@@ -607,7 +607,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
 
-	if (rw == WRITE)
+	if (rw == ITER_SOURCE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
 	else
 		ret = call_read_iter(file, &cmd->iocb, &iter);
@@ -651,14 +651,14 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 		if (lo->transfer)
 			return lo_write_transfer(lo, rq, pos);
 		else if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, WRITE);
+			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
 		else
 			return lo_write_simple(lo, rq, pos);
 	case REQ_OP_READ:
 		if (lo->transfer)
 			return lo_read_transfer(lo, rq, pos);
 		else if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, READ);
+			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
 		else
 			return lo_read_simple(lo, rq, pos);
 	default:
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 79b0056edbafe..b606faa032293 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -562,7 +562,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	u32 nbd_cmd_flags = 0;
 	int sent = nsock->sent, skip = 0;
 
-	iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
+	iov_iter_kvec(&from, ITER_SOURCE, &iov, 1, sizeof(request));
 
 	type = req_to_nbd_cmd_type(req);
 	if (type == U32_MAX)
@@ -648,7 +648,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				req, bvec.bv_len);
-			iov_iter_bvec(&from, WRITE, &bvec, 1, bvec.bv_len);
+			iov_iter_bvec(&from, ITER_SOURCE, &bvec, 1, bvec.bv_len);
 			if (skip) {
 				if (skip >= iov_iter_count(&from)) {
 					skip -= iov_iter_count(&from);
@@ -700,7 +700,7 @@ static int nbd_read_reply(struct nbd_device *nbd, int index,
 	int result;
 
 	reply->magic = 0;
-	iov_iter_kvec(&to, READ, &iov, 1, sizeof(*reply));
+	iov_iter_kvec(&to, ITER_DEST, &iov, 1, sizeof(*reply));
 	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 	if (result < 0) {
 		if (!nbd_disconnected(nbd->config))
@@ -777,7 +777,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 		struct iov_iter to;
 
 		rq_for_each_segment(bvec, req, iter) {
-			iov_iter_bvec(&to, READ, &bvec, 1, bvec.bv_len);
+			iov_iter_bvec(&to, ITER_DEST, &bvec, 1, bvec.bv_len);
 			result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 			if (result < 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
@@ -1228,7 +1228,7 @@ static void send_disconnects(struct nbd_device *nbd)
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
 
-		iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
+		iov_iter_kvec(&from, ITER_SOURCE, &iov, 1, sizeof(request));
 		mutex_lock(&nsock->tx_lock);
 		ret = sock_xmit(nbd, i, 1, &from, 0, NULL);
 		if (ret < 0)
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8642326de6e1c..b10c75de7a51c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1236,7 +1236,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags
 			return ret;
 	}
 
-	ret = import_single_range(READ, ubuf, len, &iov, &iter);
+	ret = import_single_range(ITER_DEST, ubuf, len, &iov, &iter);
 	if (unlikely(ret))
 		return ret;
 	return get_random_bytes_user(&iter);
@@ -1347,7 +1347,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		if (get_user(len, p++))
 			return -EFAULT;
-		ret = import_single_range(WRITE, p, len, &iov, &iter);
+		ret = import_single_range(ITER_SOURCE, p, len, &iov, &iter);
 		if (unlikely(ret))
 			return ret;
 		ret = write_pool_user(&iter);
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 97045a8d94224..8572fac300515 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -640,7 +640,7 @@ static void sbefifo_collect_async_ffdc(struct sbefifo *sbefifo)
 	}
         ffdc_iov.iov_base = ffdc;
 	ffdc_iov.iov_len = SBEFIFO_MAX_FFDC_SIZE;
-        iov_iter_kvec(&ffdc_iter, READ, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
+        iov_iter_kvec(&ffdc_iter, ITER_DEST, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
 	cmd[0] = cpu_to_be32(2);
 	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_SBE_FFDC);
 	rc = sbefifo_do_command(sbefifo, cmd, 2, &ffdc_iter);
@@ -737,7 +737,7 @@ int sbefifo_submit(struct device *dev, const __be32 *command, size_t cmd_len,
 	rbytes = (*resp_len) * sizeof(__be32);
 	resp_iov.iov_base = response;
 	resp_iov.iov_len = rbytes;
-        iov_iter_kvec(&resp_iter, READ, &resp_iov, 1, rbytes);
+        iov_iter_kvec(&resp_iter, ITER_DEST, &resp_iov, 1, rbytes);
 
 	/* Perform the command */
 	mutex_lock(&sbefifo->lock);
@@ -817,7 +817,7 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
 	/* Prepare iov iterator */
 	resp_iov.iov_base = buf;
 	resp_iov.iov_len = len;
-	iov_iter_init(&resp_iter, READ, &resp_iov, 1, len);
+	iov_iter_init(&resp_iter, ITER_DEST, &resp_iov, 1, len);
 
 	/* Perform the command */
 	mutex_lock(&sbefifo->lock);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index dbd51e5be3a6b..797d5d61c0b2d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -968,7 +968,7 @@ static void rtrs_clt_init_req(struct rtrs_clt_io_req *req,
 	refcount_set(&req->ref, 1);
 	req->mp_policy = clt_path->clt->mp_policy;
 
-	iov_iter_kvec(&iter, WRITE, vec, 1, usr_len);
+	iov_iter_kvec(&iter, ITER_SOURCE, vec, 1, usr_len);
 	len = _copy_from_iter(req->iu->buf, usr_len, &iter);
 	WARN_ON(len != usr_len);
 
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index a77195e378b7b..c24771336f611 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -706,7 +706,7 @@ l1oip_socket_thread(void *data)
 		printk(KERN_DEBUG "%s: socket created and open\n",
 		       __func__);
 	while (!signal_pending(current)) {
-		iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, recvbuf_size);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, recvbuf_size);
 		recvlen = sock_recvmsg(socket, &msg, 0);
 		if (recvlen > 0) {
 			l1oip_socket_parse(hc, &sin_rx, recvbuf, recvlen);
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index fe67e39d68543..b1383f20ba219 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -3032,7 +3032,7 @@ ssize_t vmci_qpair_enqueue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&from, WRITE, &v, 1, buf_size);
+	iov_iter_kvec(&from, ITER_SOURCE, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3076,7 +3076,7 @@ ssize_t vmci_qpair_dequeue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ, &v, 1, buf_size);
+	iov_iter_kvec(&to, ITER_DEST, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3121,7 +3121,7 @@ ssize_t vmci_qpair_peek(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ, &v, 1, buf_size);
+	iov_iter_kvec(&to, ITER_DEST, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 91a19ed03bc7d..bc4ff3cdccf40 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -492,7 +492,7 @@ static ssize_t ppp_read(struct file *file, char __user *buf,
 	ret = -EFAULT;
 	iov.iov_base = buf;
 	iov.iov_len = count;
-	iov_iter_init(&to, READ, &iov, 1, count);
+	iov_iter_init(&to, ITER_DEST, &iov, 1, count);
 	if (skb_copy_datagram_iter(skb, 0, &to, skb->len))
 		goto outf;
 	ret = skb->len;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1be8f7867a064..249a92e4bfc00 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -297,7 +297,7 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
 	if (!iov_iter_count(&req->iter) &&
 	    req->data_sent < req->data_len) {
 		req->curr_bio = req->curr_bio->bi_next;
-		nvme_tcp_init_iter(req, WRITE);
+		nvme_tcp_init_iter(req, ITER_SOURCE);
 	}
 }
 
@@ -775,7 +775,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 				nvme_tcp_init_recv_ctx(queue);
 				return -EIO;
 			}
-			nvme_tcp_init_iter(req, READ);
+			nvme_tcp_init_iter(req, ITER_DEST);
 		}
 
 		/* we can read only from what is left in this bio */
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 098b6bf12cd0a..f576a959e36c9 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -92,10 +92,10 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			ki_flags |= IOCB_DSYNC;
 		call_iter = req->ns->file->f_op->write_iter;
-		rw = WRITE;
+		rw = ITER_SOURCE;
 	} else {
 		call_iter = req->ns->file->f_op->read_iter;
-		rw = READ;
+		rw = ITER_DEST;
 	}
 
 	iov_iter_bvec(&iter, rw, req->f.bvec, nr_segs, count);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index c6cc1dfef92cf..29ed707e76e06 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -351,7 +351,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 		sg_offset = 0;
 	}
 
-	iov_iter_bvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
+	iov_iter_bvec(&cmd->recv_msg.msg_iter, ITER_DEST, cmd->iov,
 		      nr_pages, cmd->pdu_len);
 }
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index d74bb7b42de89..ff8e7982c7700 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1696,7 +1696,7 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 	Sg_scatter_hold *rsv_schp = &sfp->reserve;
 	struct request_queue *q = sfp->parentdp->device->request_queue;
 	struct rq_map_data *md, map_data;
-	int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? WRITE : READ;
+	int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? ITER_SOURCE : ITER_DEST;
 	unsigned char *long_cmdp = NULL;
 
 	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 6998c0eec3d40..c533938484f39 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1231,7 +1231,7 @@ int rx_data(
 		return -1;
 
 	memset(&msg, 0, sizeof(struct msghdr));
-	iov_iter_kvec(&msg.msg_iter, READ, iov, iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, iov, iov_count, data);
 
 	while (msg_data_left(&msg)) {
 		rx_loop = sock_recvmsg(conn->sock, &msg, MSG_WAITALL);
@@ -1267,7 +1267,7 @@ int tx_data(
 
 	memset(&msg, 0, sizeof(struct msghdr));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, iov_count, data);
 
 	while (msg_data_left(&msg)) {
 		int tx_loop = sock_sendmsg(conn->sock, &msg);
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 538009a83c97f..e11d9897a5e43 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -472,7 +472,7 @@ fd_execute_write_same(struct se_cmd *cmd)
 		len += se_dev->dev_attrib.block_size;
 	}
 
-	iov_iter_bvec(&iter, WRITE, bvec, nolb, len);
+	iov_iter_bvec(&iter, ITER_SOURCE, bvec, nolb, len);
 	ret = vfs_iter_write(fd_dev->fd_file, &iter, &pos, 0);
 
 	kfree(bvec);
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index 2ab99244bc314..c55a8763679e7 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -309,7 +309,7 @@ int usbip_recv(struct socket *sock, void *buf, int size)
 	if (!sock || !buf || !size)
 		return -EINVAL;
 
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, size);
 
 	usbip_dbg_xmit("enter\n");
 
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 7a6892cfa3c5e..53ae64b962b71 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -615,7 +615,7 @@ static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
 	/* Skip header. TODO: support TSO. */
 	size_t len = iov_length(vq->iov, out);
 
-	iov_iter_init(iter, WRITE, vq->iov, out, len);
+	iov_iter_init(iter, ITER_SOURCE, vq->iov, out, len);
 	iov_iter_advance(iter, hdr_size);
 
 	return iov_iter_count(iter);
@@ -1193,14 +1193,14 @@ static void handle_rx(struct vhost_net *net)
 			msg.msg_control = vhost_net_buf_consume(&nvq->rxq);
 		/* On overrun, truncate and discard */
 		if (unlikely(headcount > UIO_MAXIOV)) {
-			iov_iter_init(&msg.msg_iter, READ, vq->iov, 1, 1);
+			iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, 1, 1);
 			err = sock->ops->recvmsg(sock, &msg,
 						 1, MSG_DONTWAIT | MSG_TRUNC);
 			pr_debug("Discarded rx packet: len %zd\n", sock_len);
 			continue;
 		}
 		/* We don't need to be notified again. */
-		iov_iter_init(&msg.msg_iter, READ, vq->iov, in, vhost_len);
+		iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, in, vhost_len);
 		fixup = msg.msg_iter;
 		if (unlikely((vhost_hlen))) {
 			/* We will supply the header ourselves
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index dff93612fcfd6..ff430b6d2e1f3 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -558,7 +558,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		memcpy(v_rsp.sense, cmd->tvc_sense_buf,
 		       se_cmd->scsi_sense_length);
 
-		iov_iter_init(&iov_iter, READ, &cmd->tvc_resp_iov,
+		iov_iter_init(&iov_iter, ITER_DEST, &cmd->tvc_resp_iov,
 			      cmd->tvc_in_iovs, sizeof(v_rsp));
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
@@ -863,7 +863,7 @@ vhost_scsi_get_desc(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 	 * point at the start of the outgoing WRITE payload, if
 	 * DMA_TO_DEVICE is set.
 	 */
-	iov_iter_init(&vc->out_iter, WRITE, vq->iov, vc->out, vc->out_size);
+	iov_iter_init(&vc->out_iter, ITER_SOURCE, vq->iov, vc->out, vc->out_size);
 	ret = 0;
 
 done:
@@ -1016,7 +1016,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 			data_direction = DMA_FROM_DEVICE;
 			exp_data_len = vc.in_size - vc.rsp_size;
 
-			iov_iter_init(&in_iter, READ, &vq->iov[vc.out], vc.in,
+			iov_iter_init(&in_iter, ITER_DEST, &vq->iov[vc.out], vc.in,
 				      vc.rsp_size + exp_data_len);
 			iov_iter_advance(&in_iter, vc.rsp_size);
 			data_iter = in_iter;
@@ -1146,7 +1146,7 @@ vhost_scsi_send_tmf_resp(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.response = tmf_resp_code;
 
-	iov_iter_init(&iov_iter, READ, resp_iov, in_iovs, sizeof(rsp));
+	iov_iter_init(&iov_iter, ITER_DEST, resp_iov, in_iovs, sizeof(rsp));
 
 	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
 	if (likely(ret == sizeof(rsp)))
@@ -1241,7 +1241,7 @@ vhost_scsi_send_an_resp(struct vhost_scsi *vs,
 	memset(&rsp, 0, sizeof(rsp));	/* event_actual = 0 */
 	rsp.response = VIRTIO_SCSI_S_OK;
 
-	iov_iter_init(&iov_iter, READ, &vq->iov[vc->out], vc->in, sizeof(rsp));
+	iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[vc->out], vc->in, sizeof(rsp));
 
 	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
 	if (likely(ret == sizeof(rsp)))
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 973e079025a91..9f6e41e28d6ad 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -841,7 +841,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
 				     VHOST_ACCESS_WO);
 		if (ret < 0)
 			goto out;
-		iov_iter_init(&t, WRITE, vq->iotlb_iov, ret, size);
+		iov_iter_init(&t, ITER_SOURCE, vq->iotlb_iov, ret, size);
 		ret = copy_to_iter(from, size, &t);
 		if (ret == size)
 			ret = 0;
@@ -880,7 +880,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
 			       (unsigned long long) size);
 			goto out;
 		}
-		iov_iter_init(&f, READ, vq->iotlb_iov, ret, size);
+		iov_iter_init(&f, ITER_DEST, vq->iotlb_iov, ret, size);
 		ret = copy_from_iter(to, size, &f);
 		if (ret == size)
 			ret = 0;
@@ -2137,7 +2137,7 @@ static int get_indirect(struct vhost_virtqueue *vq,
 			vq_err(vq, "Translation failure %d in indirect.\n", ret);
 		return ret;
 	}
-	iov_iter_init(&from, READ, vq->indirect, ret, len);
+	iov_iter_init(&from, ITER_DEST, vq->indirect, ret, len);
 	count = len / sizeof desc;
 	/* Buffers are chained via a 16 bit next field, so
 	 * we can have at most 2^16 of these. */
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 13b75213ebaae..e478a2c88f95f 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1160,7 +1160,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 	if (ret < 0)
 		return ret;
 
-	iov_iter_bvec(&iter, READ, iov, ret, len);
+	iov_iter_bvec(&iter, ITER_DEST, iov, ret, len);
 
 	ret = copy_from_iter(dst, len, &iter);
 
@@ -1179,7 +1179,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 	if (ret < 0)
 		return ret;
 
-	iov_iter_bvec(&iter, WRITE, iov, ret, len);
+	iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, len);
 
 	return copy_to_iter(src, len, &iter);
 }
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index a53d7bf404610..235cb8dee1b66 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -166,7 +166,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			break;
 		}
 
-		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, iov_len);
+		iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[out], in, iov_len);
 		payload_len = pkt->len - pkt->off;
 
 		/* If the packet is greater than the space available in the
@@ -372,7 +372,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
 		return NULL;
 
 	len = iov_length(vq->iov, out);
-	iov_iter_init(&iov_iter, WRITE, vq->iov, out, len);
+	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
 	nbytes = copy_from_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
 	if (nbytes != sizeof(pkt->hdr)) {
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index a1e8b6eab69d4..50dc72c5e4abd 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -129,13 +129,13 @@ static bool pvcalls_conn_back_read(void *opaque)
 	if (masked_prod < masked_cons) {
 		vec[0].iov_base = data->in + masked_prod;
 		vec[0].iov_len = wanted;
-		iov_iter_kvec(&msg.msg_iter, READ, vec, 1, wanted);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, vec, 1, wanted);
 	} else {
 		vec[0].iov_base = data->in + masked_prod;
 		vec[0].iov_len = array_size - masked_prod;
 		vec[1].iov_base = data->in;
 		vec[1].iov_len = wanted - vec[0].iov_len;
-		iov_iter_kvec(&msg.msg_iter, READ, vec, 2, wanted);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, vec, 2, wanted);
 	}
 
 	atomic_set(&map->read, 0);
@@ -188,13 +188,13 @@ static bool pvcalls_conn_back_write(struct sock_mapping *map)
 	if (pvcalls_mask(prod, array_size) > pvcalls_mask(cons, array_size)) {
 		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
 		vec[0].iov_len = size;
-		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 1, size);
+		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 1, size);
 	} else {
 		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
 		vec[0].iov_len = array_size - pvcalls_mask(cons, array_size);
 		vec[1].iov_base = data->out;
 		vec[1].iov_len = size - vec[0].iov_len;
-		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 2, size);
+		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 2, size);
 	}
 
 	atomic_set(&map->write, 0);
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 606d33ef35c66..7f69ea0ebbc65 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -50,7 +50,7 @@ static int v9fs_fid_readpage(void *data, struct page *page)
 	if (retval == 0)
 		return retval;
 
-	iov_iter_bvec(&to, READ, &bvec, 1, PAGE_SIZE);
+	iov_iter_bvec(&to, ITER_DEST, &bvec, 1, PAGE_SIZE);
 
 	retval = p9_client_read(fid, page_offset(page), &to, &err);
 	if (err) {
@@ -163,7 +163,7 @@ static int v9fs_vfs_writepage_locked(struct page *page)
 	bvec.bv_page = page;
 	bvec.bv_offset = 0;
 	bvec.bv_len = len;
-	iov_iter_bvec(&from, WRITE, &bvec, 1, len);
+	iov_iter_bvec(&from, ITER_SOURCE, &bvec, 1, len);
 
 	/* We should have writeback_fid always set */
 	BUG_ON(!v9inode->writeback_fid);
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index b6a5a0be444d3..67bbcf24ed2a7 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -108,7 +108,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 		if (rdir->tail == rdir->head) {
 			struct iov_iter to;
 			int n;
-			iov_iter_kvec(&to, READ, &kvec, 1, buflen);
+			iov_iter_kvec(&to, ITER_DEST, &kvec, 1, buflen);
 			n = p9_client_read(file->private_data, ctx->pos, &to,
 					   &err);
 			if (err)
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 31799ac10e33a..5283ba599a832 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -32,7 +32,7 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 	struct iov_iter to;
 	int err;
 
-	iov_iter_kvec(&to, READ, &kvec, 1, buffer_size);
+	iov_iter_kvec(&to, ITER_DEST, &kvec, 1, buffer_size);
 
 	attr_fid = p9_client_xattrwalk(fid, name, &attr_size);
 	if (IS_ERR(attr_fid)) {
@@ -117,7 +117,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 	struct iov_iter from;
 	int retval, err;
 
-	iov_iter_kvec(&from, WRITE, &kvec, 1, value_len);
+	iov_iter_kvec(&from, ITER_SOURCE, &kvec, 1, value_len);
 
 	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu flags = %d\n",
 		 name, value_len, flags);
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index cedd627e1fae0..573969a882e0c 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -298,7 +298,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		if (call->count2 != call->count && call->count2 != 0)
 			return afs_protocol_error(call, afs_eproto_cb_count);
 		call->iter = &call->def_iter;
-		iov_iter_discard(&call->def_iter, READ, call->count2 * 3 * 4);
+		iov_iter_discard(&call->def_iter, ITER_DEST, call->count2 * 3 * 4);
 		call->unmarshall++;
 
 		fallthrough;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index d4bd6efc8c447..b44c0ce8ed448 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -315,7 +315,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	req->actual_len = i_size; /* May change */
 	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
 	req->data_version = dvnode->status.data_version; /* May change */
-	iov_iter_xarray(&req->def_iter, READ, &dvnode->vfs_inode.i_mapping->i_pages,
+	iov_iter_xarray(&req->def_iter, ITER_DEST, &dvnode->vfs_inode.i_mapping->i_pages,
 			0, i_size);
 	req->iter = &req->def_iter;
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6774e1fcf7c5c..c52005a68ae2f 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -305,7 +305,7 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &fsreq->def_iter;
 
-	iov_iter_xarray(&fsreq->def_iter, READ,
+	iov_iter_xarray(&fsreq->def_iter, ITER_DEST,
 			&fsreq->vnode->vfs_inode.i_mapping->i_pages,
 			fsreq->pos, fsreq->len);
 
@@ -327,7 +327,7 @@ static int afs_symlink_readpage(struct page *page)
 	fsreq->len	= PAGE_SIZE;
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &fsreq->def_iter;
-	iov_iter_xarray(&fsreq->def_iter, READ, &page->mapping->i_pages,
+	iov_iter_xarray(&fsreq->def_iter, ITER_DEST, &page->mapping->i_pages,
 			fsreq->pos, fsreq->len);
 
 	ret = afs_fetch_data(fsreq->vnode, fsreq);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3918dfbd72a49..9caae7bb2a8db 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1296,7 +1296,7 @@ static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t si
 	call->iov_len = size;
 	call->kvec[0].iov_base = buf;
 	call->kvec[0].iov_len = size;
-	iov_iter_kvec(&call->def_iter, READ, call->kvec, 1, size);
+	iov_iter_kvec(&call->def_iter, ITER_DEST, call->kvec, 1, size);
 }
 
 static inline void afs_extract_to_tmp(struct afs_call *call)
@@ -1314,7 +1314,7 @@ static inline void afs_extract_to_tmp64(struct afs_call *call)
 static inline void afs_extract_discard(struct afs_call *call, size_t size)
 {
 	call->iov_len = size;
-	iov_iter_discard(&call->def_iter, READ, size);
+	iov_iter_discard(&call->def_iter, ITER_DEST, size);
 }
 
 static inline void afs_extract_to_buf(struct afs_call *call, size_t size)
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index ea40da937fcd8..5441520125bd0 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -358,7 +358,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, call->request_size);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, 1, call->request_size);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
@@ -399,7 +399,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 					RX_USER_ABORT, ret, "KSD");
 	} else {
 		len = 0;
-		iov_iter_kvec(&msg.msg_iter, READ, NULL, 0, 0);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
 				       &msg.msg_iter, &len, false,
 				       &call->abort_code, &call->service_id);
@@ -484,7 +484,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 	       ) {
 		if (state == AFS_CALL_SV_AWAIT_ACK) {
 			len = 0;
-			iov_iter_kvec(&call->def_iter, READ, NULL, 0, 0);
+			iov_iter_kvec(&call->def_iter, ITER_DEST, NULL, 0, 0);
 			ret = rxrpc_kernel_recv_data(call->net->socket,
 						     call->rxcall, &call->def_iter,
 						     &len, false, &remote_abort,
@@ -821,7 +821,7 @@ void afs_send_empty_reply(struct afs_call *call)
 
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE, NULL, 0, 0);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, NULL, 0, 0);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
@@ -861,7 +861,7 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	iov[0].iov_len		= len;
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, 1, len);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index a75c4742062aa..9ec481b52cc55 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -601,7 +601,7 @@ static ssize_t afs_write_back_from_locked_page(struct address_space *mapping,
 	if (start < i_size) {
 		_debug("write back %x @%llx [%llx]", len, start, i_size);
 
-		iov_iter_xarray(&iter, WRITE, &mapping->i_pages, start, len);
+		iov_iter_xarray(&iter, ITER_SOURCE, &mapping->i_pages, start, len);
 		ret = afs_store_data(vnode, &iter, start, false);
 	} else {
 		_debug("write discard %x @%llx [%llx]", len, start, i_size);
@@ -972,7 +972,7 @@ int afs_launder_page(struct page *page)
 		bv[0].bv_page = page;
 		bv[0].bv_offset = f;
 		bv[0].bv_len = t - f;
-		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
+		iov_iter_bvec(&iter, ITER_SOURCE, bv, 1, bv[0].bv_len);
 
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
 		ret = afs_store_data(vnode, &iter, page_offset(page) + f, true);
diff --git a/fs/aio.c b/fs/aio.c
index 0f02ea16305cf..f502a7c841909 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1546,7 +1546,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!file->f_op->read_iter))
 		return -EINVAL;
 
-	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(ITER_DEST, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
@@ -1574,7 +1574,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!file->f_op->write_iter))
 		return -EINVAL;
 
-	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(ITER_SOURCE, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e1096ca1a39b1..7b65d4b5ebe88 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -263,7 +263,7 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 	}
 
 	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
+	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages, subreq->start, len);
 	err = iov_iter_get_pages_alloc(&iter, &pages, len, &page_off);
 	if (err < 0) {
 		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index dad7a9ec4ad1d..ca8d228ee395c 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1111,7 +1111,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 				aio_req->total_len = rc + zlen;
 			}
 
-			iov_iter_bvec(&i, READ, osd_data->bvec_pos.bvecs,
+			iov_iter_bvec(&i, ITER_DEST, osd_data->bvec_pos.bvecs,
 				      osd_data->num_bvecs, len);
 			iov_iter_advance(&i, rc);
 			iov_iter_zero(zlen, &i);
@@ -1347,7 +1347,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				int zlen = min_t(size_t, len - ret,
 						 size - pos - ret);
 
-				iov_iter_bvec(&i, READ, bvecs, num_pages, len);
+				iov_iter_bvec(&i, ITER_DEST, bvecs, num_pages, len);
 				iov_iter_advance(&i, ret);
 				iov_iter_zero(zlen, &i);
 				ret += zlen;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 098a2ad8cec4e..5fd9098250906 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -621,7 +621,7 @@ cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 {
 	struct msghdr smb_msg = {};
 	struct kvec iov = {.iov_base = buf, .iov_len = to_read};
-	iov_iter_kvec(&smb_msg.msg_iter, READ, &iov, 1, to_read);
+	iov_iter_kvec(&smb_msg.msg_iter, ITER_DEST, &iov, 1, to_read);
 
 	return cifs_readv_from_socket(server, &smb_msg);
 }
@@ -636,7 +636,7 @@ cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_read)
 	 *  and cifs_readv_from_socket sets msg_control and msg_controllen
 	 *  so little to initialize in struct msghdr
 	 */
-	iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
+	iov_iter_discard(&smb_msg.msg_iter, ITER_DEST, to_read);
 
 	return cifs_readv_from_socket(server, &smb_msg);
 }
@@ -648,7 +648,7 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
 	struct msghdr smb_msg = {};
 	struct bio_vec bv = {
 		.bv_page = page, .bv_len = to_read, .bv_offset = page_offset};
-	iov_iter_bvec(&smb_msg.msg_iter, READ, &bv, 1, to_read);
+	iov_iter_bvec(&smb_msg.msg_iter, ITER_DEST, &bv, 1, to_read);
 	return cifs_readv_from_socket(server, &smb_msg);
 }
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 10bb1f9551887..71f585a41d456 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3265,7 +3265,7 @@ static ssize_t __cifs_writev(
 		ctx->iter = *from;
 		ctx->len = len;
 	} else {
-		rc = setup_aio_ctx_iter(ctx, from, WRITE);
+		rc = setup_aio_ctx_iter(ctx, from, ITER_SOURCE);
 		if (rc) {
 			kref_put(&ctx->refcount, cifs_aio_ctx_release);
 			return rc;
@@ -4010,7 +4010,7 @@ static ssize_t __cifs_readv(
 		ctx->iter = *to;
 		ctx->len = len;
 	} else {
-		rc = setup_aio_ctx_iter(ctx, to, READ);
+		rc = setup_aio_ctx_iter(ctx, to, ITER_DEST);
 		if (rc) {
 			kref_put(&ctx->refcount, cifs_aio_ctx_release);
 			return rc;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 0a62720590daf..e11aa25bafcbe 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4954,13 +4954,13 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			return 0;
 		}
 
-		iov_iter_bvec(&iter, WRITE, bvec, npages, data_len);
+		iov_iter_bvec(&iter, ITER_SOURCE, bvec, npages, data_len);
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
 		WARN_ONCE(npages > 0, "read data can be either in buf or in pages");
 		iov.iov_base = buf + data_offset;
 		iov.iov_len = data_len;
-		iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
+		iov_iter_kvec(&iter, ITER_SOURCE, &iov, 1, data_len);
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index c5c1e743359dd..65a225a9c6cf8 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -349,7 +349,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			.iov_base = &rfc1002_marker,
 			.iov_len  = 4
 		};
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE, &hiov, 1, 4);
+		iov_iter_kvec(&smb_msg.msg_iter, ITER_SOURCE, &hiov, 1, 4);
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
 			goto unmask;
@@ -370,7 +370,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			size += iov[i].iov_len;
 		}
 
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE, iov, n_vec, size);
+		iov_iter_kvec(&smb_msg.msg_iter, ITER_SOURCE, iov, n_vec, size);
 
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
@@ -386,7 +386,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			rqst_page_get_length(&rqst[j], i, &bvec.bv_len,
 					     &bvec.bv_offset);
 
-			iov_iter_bvec(&smb_msg.msg_iter, WRITE,
+			iov_iter_bvec(&smb_msg.msg_iter, ITER_SOURCE,
 				      &bvec, 1, bvec.bv_len);
 			rc = smb_send_kvec(server, &smb_msg, &sent);
 			if (rc < 0)
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 2f26b5c8e9550..34d07727a3b74 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -264,7 +264,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		ap.args.in_pages = true;
 
 		err = -EFAULT;
-		iov_iter_init(&ii, WRITE, in_iov, in_iovs, in_size);
+		iov_iter_init(&ii, ITER_SOURCE, in_iov, in_iovs, in_size);
 		for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_pages); i++) {
 			c = copy_page_from_iter(ap.pages[i], 0, PAGE_SIZE, &ii);
 			if (c != PAGE_SIZE && iov_iter_count(&ii))
@@ -331,7 +331,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		goto out;
 
 	err = -EFAULT;
-	iov_iter_init(&ii, READ, out_iov, out_iovs, transferred);
+	iov_iter_init(&ii, ITER_DEST, out_iov, out_iovs, transferred);
 	for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_pages); i++) {
 		c = copy_page_to_iter(ap.pages[i], 0, PAGE_SIZE, &ii);
 		if (c != PAGE_SIZE && iov_iter_count(&ii))
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4a81e338585cd..e1737984e0ca1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1027,7 +1027,7 @@ __be32 nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	ssize_t host_err;
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_kvec(&iter, READ, vec, vlen, *count);
+	iov_iter_kvec(&iter, ITER_DEST, vec, vlen, *count);
 	host_err = vfs_iter_read(file, &iter, &ppos, 0);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
@@ -1117,7 +1117,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && !use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
+	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index f660c0dbdb63b..785cabd71d670 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -900,7 +900,7 @@ static int o2net_recv_tcp_msg(struct socket *sock, void *data, size_t len)
 {
 	struct kvec vec = { .iov_len = len, .iov_base = data, };
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT, };
-	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, len);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, len);
 	return sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 }
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 0cf3dcb76d2f4..0c9de88c9fb89 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -53,7 +53,7 @@ static int orangefs_writepage_locked(struct page *page,
 	bv.bv_len = wlen;
 	bv.bv_offset = off % PAGE_SIZE;
 	WARN_ON(wlen == 0);
-	iov_iter_bvec(&iter, WRITE, &bv, 1, wlen);
+	iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, wlen);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
 	    len, wr, NULL, NULL);
@@ -111,7 +111,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 		else
 			ow->bv[i].bv_offset = 0;
 	}
-	iov_iter_bvec(&iter, WRITE, ow->bv, ow->npages, ow->len);
+	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->npages, ow->len);
 
 	WARN_ON(ow->off >= len);
 	if (ow->off + ow->len > len)
@@ -269,7 +269,7 @@ static void orangefs_readahead(struct readahead_control *rac)
 	offset = readahead_pos(rac);
 	i_pages = &rac->mapping->i_pages;
 
-	iov_iter_xarray(&iter, READ, i_pages, offset, readahead_length(rac));
+	iov_iter_xarray(&iter, ITER_DEST, i_pages, offset, readahead_length(rac));
 
 	/* read in the pages. */
 	if ((ret = wait_for_direct_io(ORANGEFS_IO_READ, inode,
@@ -302,7 +302,7 @@ static int orangefs_readpage(struct file *file, struct page *page)
 	bv.bv_page = page;
 	bv.bv_len = PAGE_SIZE;
 	bv.bv_offset = 0;
-	iov_iter_bvec(&iter, READ, &bv, 1, PAGE_SIZE);
+	iov_iter_bvec(&iter, ITER_DEST, &bv, 1, PAGE_SIZE);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
 	    PAGE_SIZE, inode->i_size, NULL, NULL, file);
diff --git a/fs/read_write.c b/fs/read_write.c
index b4b15279b66b6..da1bb81355a9f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -399,7 +399,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_init(&iter, READ, &iov, 1, len);
+	iov_iter_init(&iter, ITER_DEST, &iov, 1, len);
 
 	ret = call_read_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
@@ -439,7 +439,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
-	iov_iter_kvec(&iter, READ, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&iter, ITER_DEST, &iov, 1, iov.iov_len);
 	ret = file->f_op->read_iter(&kiocb, &iter);
 	if (ret > 0) {
 		if (pos)
@@ -502,7 +502,7 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_init(&iter, WRITE, &iov, 1, len);
+	iov_iter_init(&iter, ITER_SOURCE, &iov, 1, len);
 
 	ret = call_write_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
@@ -535,7 +535,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
-	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&iter, ITER_SOURCE, &iov, 1, iov.iov_len);
 	ret = file->f_op->write_iter(&kiocb, &iter);
 	if (ret > 0) {
 		if (pos)
@@ -905,7 +905,7 @@ static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 	struct iov_iter iter;
 	ssize_t ret;
 
-	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret >= 0) {
 		ret = do_iter_read(file, &iter, pos, flags);
 		kfree(iov);
@@ -922,7 +922,7 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 	struct iov_iter iter;
 	ssize_t ret;
 
-	ret = import_iovec(WRITE, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	ret = import_iovec(ITER_SOURCE, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret >= 0) {
 		file_start_write(file);
 		ret = do_iter_write(file, &iter, pos, flags);
diff --git a/fs/seq_file.c b/fs/seq_file.c
index b17ee4c4f618a..df7a5eb7573b5 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -156,7 +156,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, file);
-	iov_iter_init(&iter, READ, &iov, 1, size);
+	iov_iter_init(&iter, ITER_DEST, &iov, 1, size);
 
 	kiocb.ki_pos = *ppos;
 	ret = seq_read_iter(&kiocb, &iter);
diff --git a/fs/splice.c b/fs/splice.c
index e8591211044a3..a43152bb106fc 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -304,7 +304,7 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	unsigned int i_head;
 	int ret;
 
-	iov_iter_pipe(&to, READ, pipe, len);
+	iov_iter_pipe(&to, ITER_DEST, pipe, len);
 	i_head = to.head;
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
@@ -685,7 +685,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 			n++;
 		}
 
-		iov_iter_bvec(&from, WRITE, array, n, sd.total_len - left);
+		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
 		ret = vfs_iter_write(out, &from, &sd.pos, 0);
 		if (ret <= 0)
 			break;
@@ -1296,9 +1296,9 @@ static int vmsplice_type(struct fd f, int *type)
 	if (!f.file)
 		return -EBADF;
 	if (f.file->f_mode & FMODE_WRITE) {
-		*type = WRITE;
+		*type = ITER_SOURCE;
 	} else if (f.file->f_mode & FMODE_READ) {
-		*type = READ;
+		*type = ITER_DEST;
 	} else {
 		fdput(f);
 		return -EBADF;
@@ -1347,7 +1347,7 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 
 	if (!iov_iter_count(&iter))
 		error = 0;
-	else if (iov_iter_rw(&iter) == WRITE)
+	else if (type == ITER_SOURCE)
 		error = vmsplice_to_pipe(f.file, &iter, flags);
 	else
 		error = vmsplice_to_user(f.file, &iter, flags);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6350354f97e90..4d53a6ff8c286 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -27,6 +27,9 @@ enum iter_type {
 	ITER_DISCARD,
 };
 
+#define ITER_SOURCE	1	// == WRITE
+#define ITER_DEST	0	// == READ
+
 struct iov_iter_state {
 	size_t iov_offset;
 	size_t count;
diff --git a/mm/madvise.c b/mm/madvise.c
index 5dd5706270b0e..ef9382f776248 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1251,7 +1251,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto out;
 	}
 
-	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret < 0)
 		goto out;
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 66c6fbb07bc4c..1f992e93301ba 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -252,7 +252,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		};
 		struct iov_iter from;
 
-		iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
+		iov_iter_bvec(&from, ITER_SOURCE, &bv, 1, PAGE_SIZE);
 		init_sync_kiocb(&kiocb, swap_file);
 		kiocb.ki_pos = page_file_offset(page);
 
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 4bcc119580890..78dfaf9e8990a 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -263,7 +263,7 @@ static ssize_t process_vm_rw(pid_t pid,
 	struct iovec *iov_r;
 	struct iov_iter iter;
 	ssize_t rc;
-	int dir = vm_write ? WRITE : READ;
+	int dir = vm_write ? ITER_SOURCE : ITER_DEST;
 
 	if (flags != 0)
 		return -EINVAL;
diff --git a/net/9p/client.c b/net/9p/client.c
index 5f0b3fdc70e29..5cd26bdaf33df 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -2096,7 +2096,7 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 	struct kvec kv = {.iov_base = data, .iov_len = count};
 	struct iov_iter to;
 
-	iov_iter_kvec(&to, READ, &kv, 1, count);
+	iov_iter_kvec(&to, ITER_DEST, &kv, 1, count);
 
 	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %d\n",
 		 fid->fid, offset, count);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index b70d3a38fdedc..74dd29195330b 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -449,7 +449,7 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 	iv.iov_len = skb->len;
 
 	memset(&msg, 0, sizeof(msg));
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iv, 1, skb->len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iv, 1, skb->len);
 
 	err = l2cap_chan_send(chan, &msg, skb->len);
 	if (err > 0) {
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 1fcc482397c36..e7adb8a98cf90 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -56,7 +56,7 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *dat
 
 	memset(&msg, 0, sizeof(msg));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iv, 1, total_len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iv, 1, total_len);
 
 	l2cap_chan_send(chan, &msg, total_len);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b779849051249..85bd00479a74d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -605,7 +605,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 
 	memset(&msg, 0, sizeof(msg));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, iv, 2, 1 + len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iv, 2, 1 + len);
 
 	l2cap_chan_send(chan, &msg, 1 + len);
 
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index 2cb5ffdf071af..6290b062d631d 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -30,7 +30,7 @@ static int ceph_tcp_recvmsg(struct socket *sock, void *buf, size_t len)
 	if (!buf)
 		msg.msg_flags |= MSG_TRUNC;
 
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, len);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
 		r = 0;
@@ -49,7 +49,7 @@ static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
 	int r;
 
 	BUG_ON(page_offset + length > PAGE_SIZE);
-	iov_iter_bvec(&msg.msg_iter, READ, &bvec, 1, length);
+	iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, length);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
 		r = 0;
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 41f26df5cce06..c3b1371e41f8c 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -167,7 +167,7 @@ static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
 						  bv.bv_offset, bv.bv_len,
 						  CEPH_MSG_FLAGS);
 		} else {
-			iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, bv.bv_len);
+			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, bv.bv_len);
 			ret = sock_sendmsg(sock, &msg);
 		}
 		if (ret <= 0) {
@@ -224,7 +224,7 @@ static void reset_in_kvecs(struct ceph_connection *con)
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	con->v2.in_kvec_cnt = 0;
-	iov_iter_kvec(&con->v2.in_iter, READ, con->v2.in_kvecs, 0, 0);
+	iov_iter_kvec(&con->v2.in_iter, ITER_DEST, con->v2.in_kvecs, 0, 0);
 }
 
 static void set_in_bvec(struct ceph_connection *con, const struct bio_vec *bv)
@@ -232,7 +232,7 @@ static void set_in_bvec(struct ceph_connection *con, const struct bio_vec *bv)
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	con->v2.in_bvec = *bv;
-	iov_iter_bvec(&con->v2.in_iter, READ, &con->v2.in_bvec, 1, bv->bv_len);
+	iov_iter_bvec(&con->v2.in_iter, ITER_DEST, &con->v2.in_bvec, 1, bv->bv_len);
 }
 
 static void set_in_skip(struct ceph_connection *con, int len)
@@ -240,7 +240,7 @@ static void set_in_skip(struct ceph_connection *con, int len)
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	dout("%s con %p len %d\n", __func__, con, len);
-	iov_iter_discard(&con->v2.in_iter, READ, len);
+	iov_iter_discard(&con->v2.in_iter, ITER_DEST, len);
 }
 
 static void add_out_kvec(struct ceph_connection *con, void *buf, int len)
@@ -264,7 +264,7 @@ static void reset_out_kvecs(struct ceph_connection *con)
 
 	con->v2.out_kvec_cnt = 0;
 
-	iov_iter_kvec(&con->v2.out_iter, WRITE, con->v2.out_kvecs, 0, 0);
+	iov_iter_kvec(&con->v2.out_iter, ITER_SOURCE, con->v2.out_kvecs, 0, 0);
 	con->v2.out_iter_sendpage = false;
 }
 
@@ -276,7 +276,7 @@ static void set_out_bvec(struct ceph_connection *con, const struct bio_vec *bv,
 
 	con->v2.out_bvec = *bv;
 	con->v2.out_iter_sendpage = zerocopy;
-	iov_iter_bvec(&con->v2.out_iter, WRITE, &con->v2.out_bvec, 1,
+	iov_iter_bvec(&con->v2.out_iter, ITER_SOURCE, &con->v2.out_bvec, 1,
 		      con->v2.out_bvec.bv_len);
 }
 
@@ -289,7 +289,7 @@ static void set_out_bvec_zero(struct ceph_connection *con)
 	con->v2.out_bvec.bv_offset = 0;
 	con->v2.out_bvec.bv_len = min(con->v2.out_zero, (int)PAGE_SIZE);
 	con->v2.out_iter_sendpage = true;
-	iov_iter_bvec(&con->v2.out_iter, WRITE, &con->v2.out_bvec, 1,
+	iov_iter_bvec(&con->v2.out_iter, ITER_SOURCE, &con->v2.out_bvec, 1,
 		      con->v2.out_bvec.bv_len);
 }
 
diff --git a/net/compat.c b/net/compat.c
index 210fc3b4d0d83..bbb0e3cc1f1cb 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -98,7 +98,7 @@ int get_compat_msghdr(struct msghdr *kmsg,
 	if (err)
 		return err;
 
-	err = import_iovec(save_addr ? READ : WRITE, compat_ptr(ptr), len,
+	err = import_iovec(save_addr ? ITER_DEST : ITER_SOURCE, compat_ptr(ptr), len,
 			   UIO_FASTIOV, iov, &kmsg->msg_iter);
 	return err < 0 ? err : 0;
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 36981a3e9013f..af46c90426b25 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1886,7 +1886,7 @@ static int receive_fallback_to_copy(struct sock *sk,
 	if (copy_address != zc->copybuf_address)
 		return -EINVAL;
 
-	err = import_single_range(READ, (void __user *)copy_address,
+	err = import_single_range(ITER_DEST, (void __user *)copy_address,
 				  inq, &iov, &msg.msg_iter);
 	if (err)
 		return err;
@@ -1920,7 +1920,7 @@ static int tcp_copy_straggler_data(struct tcp_zerocopy_receive *zc,
 	if (copy_address != zc->copybuf_address)
 		return -EINVAL;
 
-	err = import_single_range(READ, (void __user *)copy_address,
+	err = import_single_range(ITER_DEST, (void __user *)copy_address,
 				  copylen, &iov, &msg.msg_iter);
 	if (err)
 		return err;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 0c061f94d6954..e1dea9a820505 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1617,7 +1617,7 @@ ip_vs_receive(struct socket *sock, char *buffer, const size_t buflen)
 	EnterFunction(7);
 
 	/* Receive a packet */
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, buflen);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, buflen);
 	len = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 	if (len < 0)
 		return len;
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index ec8c4cfdb1471..81774d84770f7 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -361,7 +361,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	 */
 	krflags = MSG_PEEK | MSG_WAITALL;
 	clc_sk->sk_rcvtimeo = timeout;
-	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1,
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1,
 			sizeof(struct smc_clc_msg_hdr));
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (signal_pending(current)) {
@@ -408,7 +408,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	} else {
 		recvlen = datlen;
 	}
-	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, recvlen);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, recvlen);
 	krflags = MSG_WAITALL;
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (len < recvlen || !smc_clc_msg_hdr_valid(clcm, check_trl)) {
@@ -425,7 +425,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		/* receive remaining proposal message */
 		recvlen = datlen > SMC_CLC_RECV_BUF_LEN ?
 						SMC_CLC_RECV_BUF_LEN : datlen;
-		iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, recvlen);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, recvlen);
 		len = sock_recvmsg(smc->clcsock, &msg, krflags);
 		if (len < recvlen) {
 			smc->sk.sk_err = EPROTO;
diff --git a/net/socket.c b/net/socket.c
index f3d0a8d66ccee..d97625d8e5f60 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -761,7 +761,7 @@ EXPORT_SYMBOL(sock_sendmsg);
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
 		   struct kvec *vec, size_t num, size_t size)
 {
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
 	return sock_sendmsg(sock, msg);
 }
 EXPORT_SYMBOL(kernel_sendmsg);
@@ -787,7 +787,7 @@ int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	if (!sock->ops->sendmsg_locked)
 		return sock_no_sendmsg_locked(sk, msg, size);
 
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
 
 	return sock->ops->sendmsg_locked(sk, msg, msg_data_left(msg));
 }
@@ -1007,7 +1007,7 @@ int kernel_recvmsg(struct socket *sock, struct msghdr *msg,
 		   struct kvec *vec, size_t num, size_t size, int flags)
 {
 	msg->msg_control_is_user = false;
-	iov_iter_kvec(&msg->msg_iter, READ, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, ITER_DEST, vec, num, size);
 	return sock_recvmsg(sock, msg, flags);
 }
 EXPORT_SYMBOL(kernel_recvmsg);
@@ -2048,7 +2048,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	struct iovec iov;
 	int fput_needed;
 
-	err = import_single_range(WRITE, buff, len, &iov, &msg.msg_iter);
+	err = import_single_range(ITER_SOURCE, buff, len, &iov, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
@@ -2109,7 +2109,7 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
 	int err, err2;
 	int fput_needed;
 
-	err = import_single_range(READ, ubuf, size, &iov, &msg.msg_iter);
+	err = import_single_range(ITER_DEST, ubuf, size, &iov, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
@@ -2380,7 +2380,7 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
 	if (err)
 		return err;
 
-	err = import_iovec(save_addr ? READ : WRITE,
+	err = import_iovec(save_addr ? ITER_DEST : ITER_SOURCE,
 			    msg.msg_iov, msg.msg_iovlen,
 			    UIO_FASTIOV, iov, &kmsg->msg_iter);
 	return err < 0 ? err : 0;
diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index d52313af82bc2..eabb95360885c 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -213,7 +213,7 @@ static inline int xprt_sendmsg(struct socket *sock, struct msghdr *msg,
 static int xprt_send_kvec(struct socket *sock, struct msghdr *msg,
 			  struct kvec *vec, size_t seek)
 {
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, 1, vec->iov_len);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, 1, vec->iov_len);
 	return xprt_sendmsg(sock, msg, seek);
 }
 
@@ -226,7 +226,7 @@ static int xprt_send_pagedata(struct socket *sock, struct msghdr *msg,
 	if (err < 0)
 		return err;
 
-	iov_iter_bvec(&msg->msg_iter, WRITE, xdr->bvec, xdr_buf_pagecount(xdr),
+	iov_iter_bvec(&msg->msg_iter, ITER_SOURCE, xdr->bvec, xdr_buf_pagecount(xdr),
 		      xdr->page_len + xdr->page_base);
 	return xprt_sendmsg(sock, msg, base + xdr->page_base);
 }
@@ -249,7 +249,7 @@ static int xprt_send_rm_and_kvec(struct socket *sock, struct msghdr *msg,
 	};
 	size_t len = iov[0].iov_len + iov[1].iov_len;
 
-	iov_iter_kvec(&msg->msg_iter, WRITE, iov, 2, len);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, iov, 2, len);
 	return xprt_sendmsg(sock, msg, base);
 }
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 112236dd72901..e1ba75824aee5 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -260,7 +260,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 	rqstp->rq_respages = &rqstp->rq_pages[i];
 	rqstp->rq_next_page = rqstp->rq_respages + 1;
 
-	iov_iter_bvec(&msg.msg_iter, READ, bvec, i, buflen);
+	iov_iter_bvec(&msg.msg_iter, ITER_DEST, bvec, i, buflen);
 	if (seek) {
 		iov_iter_advance(&msg.msg_iter, seek);
 		buflen -= seek;
@@ -871,7 +871,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 		want = sizeof(rpc_fraghdr) - svsk->sk_tcplen;
 		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
-		iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, want);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
 		len = sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
 		if (len < 0)
 			return len;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9e122c20fcc6e..ffd8f38af227d 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -363,7 +363,7 @@ static ssize_t
 xs_read_kvec(struct socket *sock, struct msghdr *msg, int flags,
 		struct kvec *kvec, size_t count, size_t seek)
 {
-	iov_iter_kvec(&msg->msg_iter, READ, kvec, 1, count);
+	iov_iter_kvec(&msg->msg_iter, ITER_DEST, kvec, 1, count);
 	return xs_sock_recvmsg(sock, msg, flags, seek);
 }
 
@@ -372,7 +372,7 @@ xs_read_bvec(struct socket *sock, struct msghdr *msg, int flags,
 		struct bio_vec *bvec, unsigned long nr, size_t count,
 		size_t seek)
 {
-	iov_iter_bvec(&msg->msg_iter, READ, bvec, nr, count);
+	iov_iter_bvec(&msg->msg_iter, ITER_DEST, bvec, nr, count);
 	return xs_sock_recvmsg(sock, msg, flags, seek);
 }
 
@@ -380,7 +380,7 @@ static ssize_t
 xs_read_discard(struct socket *sock, struct msghdr *msg, int flags,
 		size_t count)
 {
-	iov_iter_discard(&msg->msg_iter, READ, count);
+	iov_iter_discard(&msg->msg_iter, ITER_DEST, count);
 	return sock_recvmsg(sock, msg, flags);
 }
 
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 4292c0f1e3daa..0445c91db009e 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -396,7 +396,7 @@ static int tipc_conn_rcv_from_sock(struct tipc_conn *con)
 	iov.iov_base = &s;
 	iov.iov_len = sizeof(s);
 	msg.msg_name = NULL;
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, iov.iov_len);
 	ret = sock_recvmsg(con->sock, &msg, MSG_DONTWAIT);
 	if (ret == -EWOULDBLOCK)
 		return -EWOULDBLOCK;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 54c75cf4b53da..10f7b35673bc6 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -571,7 +571,7 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
 	kaddr = kmap(page);
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
-	iov_iter_kvec(&msg_iter, WRITE, &iov, 1, size);
+	iov_iter_kvec(&msg_iter, ITER_SOURCE, &iov, 1, size);
 	rc = tls_push_data(sk, &msg_iter, size,
 			   flags, TLS_RECORD_TYPE_DATA);
 	kunmap(page);
@@ -646,7 +646,7 @@ static int tls_device_push_pending_record(struct sock *sk, int flags)
 {
 	struct iov_iter	msg_iter;
 
-	iov_iter_kvec(&msg_iter, WRITE, NULL, 0, 0);
+	iov_iter_kvec(&msg_iter, ITER_SOURCE, NULL, 0, 0);
 	return tls_push_data(sk, &msg_iter, 0, flags, TLS_RECORD_TYPE_DATA);
 }
 
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index ebb9ee8906f40..98c31a27633f9 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -358,7 +358,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	*((__be16 *)buf) = cpu_to_be16(msglen);
 	pfx_iov.iov_base = buf;
 	pfx_iov.iov_len = sizeof(buf);
-	iov_iter_kvec(&pfx_iter, WRITE, &pfx_iov, 1, pfx_iov.iov_len);
+	iov_iter_kvec(&pfx_iter, ITER_SOURCE, &pfx_iov, 1, pfx_iov.iov_len);
 
 	err = sk_msg_memcopy_from_iter(sk, &pfx_iter, &emsg->skmsg,
 				       pfx_iov.iov_len);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 255115251ce53..aa1dc43b16ddf 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1256,7 +1256,7 @@ long keyctl_instantiate_key(key_serial_t id,
 		struct iov_iter from;
 		int ret;
 
-		ret = import_single_range(WRITE, (void __user *)_payload, plen,
+		ret = import_single_range(ITER_SOURCE, (void __user *)_payload, plen,
 					  &iov, &from);
 		if (unlikely(ret))
 			return ret;
@@ -1288,7 +1288,7 @@ long keyctl_instantiate_key_iov(key_serial_t id,
 	if (!_payload_iov)
 		ioc = 0;
 
-	ret = import_iovec(WRITE, _payload_iov, ioc,
+	ret = import_iovec(ITER_SOURCE, _payload_iov, ioc,
 				    ARRAY_SIZE(iovstack), &iov, &from);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

