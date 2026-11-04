Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809525;
	b=gWE8Gg4LtKfXoq0sK1tVfDCeBU3VVMvohQ5OiGb6AOxNjghyJOr2plTv7Q85CJwY8vEb
	 tLaDgbz95dIJ+7ub3zbxHJJJz+1IUv1qd9dM6GZylD+zL9ep1Reim14MIQW/GR+SstEXZ
	 xtMkLUo32vZMnvDJWKtTSNY5x32D4tub0CktZUEv0kF8LK6yXHVC64f12SWuHcAqok+ex
	 D3qdGr6XF/ss4CXCe/1frXpaVvdw1JcjrCdq4swsZALwfV3qRPmLyWxUi9S/+L2e0vUQl
	 yh5GT4xz+h3b6f2oeF5Kjzo4SyfAFwLAfBoUe3mFtVCXNyNbk38sL+P2dqJW4XB6eOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809525;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=HG7fdBO4WEcwQ4gpZzbvoeJECFEi3NHcwKvoIeLGBYg=;
	b=b/1f+2biV6FbpF0NctU2dL+KuBYltIAZcWLMZZ8kwbOYtbaUTqe7G6w63rLmvh1Sufq3
	 QIu61ln0VaRLx0j9BzAO3OpnIg3faD1WXULxLbO+34iUg8Rmg+Tt/+WBi3ztyLrT1Byi0
	 uXFs1rZHXhlrHi0V5TxXTNrfgOmhkvOmHBbL3afhXtIppWDJL65+EeKII93AJoMEoKoW4
	 nkXZxoEAiLvJThKbscDXBdyFKm+9QR8rFSW5oPWc2hX6NvlYu6/4a3HpDViq4N6KTrRdN
	 Vo/xALH4K7V8kfWGp0iHgbGRJPrYM9WvGwmwy/QEzDBqCdSiYX8hinKyPD/jAC8r2uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466F606A32F;
	Wed,  4 Nov 2026 16:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2466F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jKW4x5gWmz5BNRf;
	Thu, 05 Nov 2026 00:25:21 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A4GPCCv020169;
	Thu, 5 Nov 2026 00:25:12 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 5 Nov 2026 00:25:15 +0800 (CST)
X-Zmail-TransId: 2af96aeb5c6b6a7-c1505
X-Mailer: Zmail v1.0
Message-ID: <20261105002515934UMImG6EiHrJdKjsLu3j9d@zte.com.cn>
Date: Thu, 5 Nov 2026 00:25:15 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <richard@nod.at>, <linux-mtd@lists.infradead.org>
Cc: <chengzhihao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORF0gdWJpZnM6IHhhdHRyOiBmaXggb3V0LW9mLWJvdW5kcyB3cml0ZSBpbiB1Ymlmc19saXN0eGF0dHIoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A4GPCCv020169
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 05 Nov 2026 00:25:21 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB5C71.000/4jKW4x5gWmz5BNRf

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ubifs_listxattr() derives the size of the name list from
ui->xattr_names + ui->xattr_cnt and uses it to reject a call whose
buffer is too small.  It then copies every visible xattr name returned
by ubifs_tnc_next_ent() without checking @size again.

Both counters are read from the on-flash inode node and are only
accounting values.  A modified image can make them under-report the
number of xattr entries while the TNC still contains more entries: the
node CRC only protects against accidental corruption, it is recomputed
for a crafted image.

The usual caller first invokes listxattr(path, NULL, 0), which returns
the too small size computed from those counters, then allocates a
buffer of that size and invokes listxattr() again.  In the second
system call fs/xattr.c:listxattr() allocates the kernel buffer with
kvmalloc(size) and passes it to ubifs_listxattr(), which copies the
names past its end.  The copied bytes are the xattr names from the
image, so part of the overflow content is attacker controlled.

Bound each copy by @size and return -ERANGE when the list does not fit.
With a corrupt image the reported size may now be too small, but the
following call fails cleanly instead of overflowing.  Note that nlen
itself is already bounded by ubifs_validate_entry(), which every node
returned by ubifs_tnc_next_ent() has passed; the missing check is only
against the caller's buffer.

While here, validate the two counters individually.  Their sum is
computed in 32 bits, so the existing check is bypassed when it wraps
around; rejecting the oversized values at mount time keeps the O(1)
size query in listxattr() from returning a wrapped (possibly negative)
length.

Mounting UBIFS requires CAP_SYS_ADMIN in the initial user namespace, so
this is only reachable with a crafted image.  Compile tested with W=1
and checkpatch --strict.  Runtime reproduction needs a modified UBI
image: change xattr_cnt/xattr_names in an inode node and recompute its
CRC; a KASAN kernel then reports the overflow on the second
listxattr() call.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Resend after 7 days without feedback; no code change.

Link: https://lore.kernel.org/all/2026102817301132485IE4Ia6aXSqUo5KZUvgW@zte.com.cn/

Tested on 7.3.0-next-20261030 (QEMU/TCG, x86_64) with mtdram and KASAN.
The image has a file with three xattrs, i.e. 21 bytes of names.  Its
on-flash inode counters are modified and the node CRC recomputed.

low (xattr_cnt=1, xattr_names=0), unpatched:
  first listxattr() returns 1; the second call is given a 1-byte buffer
  but copies 21 bytes.  KASAN reports a slab-out-of-bounds in
  _copy_to_user and ubifs_assert(written <= size) fires.
low, patched:
  first returns 1; the second returns -ERANGE (errno 34).

wrap (xattr_cnt=0x20, xattr_names=0xFFFFFFF0; the 32-bit sum is 16),
unpatched:
  first returns 16; the second call is given a 16-byte buffer but copies
  21 bytes, with the same KASAN report and assert.
wrap, patched:
  first returns -EINVAL; ubifs_iget() rejects the counters in
  validate_inode() before ubifs_listxattr() is called.

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 38972786817e..fe24e1949bb3 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -82,7 +82,15 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
 		return 2;
 	}
 
-	if (ui->xattr_names + ui->xattr_cnt > XATTR_LIST_MAX)
+	/*
+	 * Both counters are read from the on-flash inode node.  Check them
+	 * individually first: the addition is performed in 32 bits and can
+	 * wrap around, which would make the check below pass for absurd
+	 * values.
+	 */
+	if (ui->xattr_cnt > XATTR_LIST_MAX ||
+	    ui->xattr_names > XATTR_LIST_MAX ||
+	    ui->xattr_names + ui->xattr_cnt > XATTR_LIST_MAX)
 		return 3;
 
 	if (ui->data_len < 0 || ui->data_len > UBIFS_MAX_INO_DATA)
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 3b0e8a270f59..8efe2c545bf4 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -421,8 +421,25 @@ ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		fname_len(&nm) = le16_to_cpu(xent->nlen);
 
 		if (xattr_visible(xent->name)) {
-			memcpy(buffer + written, fname_name(&nm), fname_len(&nm) + 1);
-			written += fname_len(&nm) + 1;
+			int nlen = fname_len(&nm);
+
+			/*
+			 * nlen is bounded by ubifs_validate_entry(): the
+			 * node length is nlen + UBIFS_DENT_NODE_SZ + 1 and
+			 * is itself bounded by UBIFS_MAX_DENT_NODE_SZ, so
+			 * the name cannot run past the node.
+			 *
+			 * The missing bound is the caller's buffer: the
+			 * on-flash xattr counters are not authoritative and
+			 * a crafted image can under-report them.
+			 */
+			if (written + nlen + 1 > size) {
+				kfree(xent);
+				err = -ERANGE;
+				break;
+			}
+			memcpy(buffer + written, fname_name(&nm), nlen + 1);
+			written += nlen + 1;
 		}
 
 		kfree(pxent);
@@ -432,6 +449,9 @@ ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	kfree(pxent);
 	up_read(&host_ui->xattr_sem);
 
+	if (err == -ERANGE)
+		return err;
+
 	if (err != -ENOENT) {
 		ubifs_err(c, "cannot find next direntry, error %d", err);
 		return err;
