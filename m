Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179841;
	b=Evz/RBRe19GT0UiPlvuldueouRVPvlT17QxNrIa0hZgdJ4br6xkQRCQAI3rgA9HMSg4N
	 o70u3kL+4wgIxSc5TzBNFbdjzVwCOOoW24PhEl+FJpOMexqGsDlEt7IjKoGc++sSzVuAp
	 juAZi4cJ+cT456YtL3UXbNPKZ9N7Pgxkwn7MOrK8JnAkwFqHtmh3C1rRWj3+idP9fr+Sc
	 IrY9T/Xo2IIbKZZQw1dTUOE+8h4FH6erjeo9tFMOg8hr0UpbMnyu3/FugthBzryS5bvHe
	 PrGK5eQi68ZGH7oSf4qBgwTvsa6svJhs81cQ09qqIEOhZM2m87QOURYxhFzErwZVxhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179841;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=BzY/9GS+8grFtALrDXv5eWekSLwpjFUB0KHUPTwIMLU=;
	b=UQ77FJfXAwMlqzeAEhPKqFoOWgfH1oQu/PwtKN4y1uOgBlFDsD5SBDpG/UOFEUEDmjVJ
	 T8L46Mi3s4lrrOwxFRjvTe6jlO8eJPhWX72Bm77/MToIUl0U6vk2rCM3SqpqjpTGlu4ZR
	 DWFhLN0DfeQvQVy4dGm9otccDS8Pp56tij3z2hjEeTeTcQ+t1PQsEg/LbM1YvLQVUUHjU
	 OlmjMauwCpm0wRwS23dvejn6EqIBAWxdDAJE40W2ooF0kILVWU054h/2YqWrxZ7vLBPhH
	 pxxRAYNFSeLG/YWY79FSz45CK0qJNwO7xH8VzBEfv265JZvSiBHpmWqfhP0mlzVGq9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7460A2608;
	Wed, 28 Oct 2026 09:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F7460A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jF2CL5V15z4yjjX;
	Wed, 28 Oct 2026 17:30:22 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 69S9U8U0063881;
	Wed, 28 Oct 2026 17:30:08 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 28 Oct 2026 17:30:11 +0800 (CST)
X-Zmail-TransId: 2afb6ae1c0a3191-f6b36
X-Mailer: Zmail v1.0
Message-ID: <2026102817301132485IE4Ia6aXSqUo5KZUvgW@zte.com.cn>
Date: Wed, 28 Oct 2026 17:30:11 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIXSB1YmlmczogeGF0dHI6IGZpeCBvdXQtb2YtYm91bmRzIHdyaXRlIGluIHViaWZzX2xpc3R4YXR0cigp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 69S9U8U0063881
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 28 Oct 2026 17:30:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE1C0AE.001/4jF2CL5V15z4yjjX

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
