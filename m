Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E946D579
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519092; cv=none; b=Mm6dxqDxMHQkIakhb4SrfLgLCr7iArCeyEGCNvnmdXfayOoGkWdRzg4Mu2kebKw3yR7prWj/GKcJ8A6FNjjQNhZO4WVsToebhS5Mr2n1u24khKn35VLBfUThGiyjRq3cfx4adHOJtf2gacXsKiRsgXvDgtSeerNKUGliSRG1ucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519092; c=relaxed/simple;
	bh=pSs45CfVUBr+rhnKvEiDoD6ZPLo0hWpaRQjQK59eGXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltupcJ2MYjhJsPe6D4yOI4tAdHYHRon+eqG9s4fbBIjsQr0Ki2mPHQSPvb6ClNpZZ7HFjto0nRGWAGGOlFF0mTxVke1pp1ngRsJb9r54NWpY3iXgda8H3tbs4eTFbcSN8jppEkpls3dwg/Vsc36lqlcXSM6B+8uKI8IfxvRpJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PuFOYiF9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PuFOYiF9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so8116545e9.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788519087; x=1789123887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yg+f8T7nBpMfHcLwEI2qPhrkmiUiafLrkzAcu6wVsTA=;
        b=PuFOYiF9mqcbIzmjBOPfxiYQ5IEYHyFVNoMgvUIYmvntJgG8rc9D1TixkoVNuTBRDR
         0LsxMzy+6gkxGCg412pkfjWggYmDxv5PWABphPmURGOgTZN2eZMjY+P6RoC2c169VYuf
         0x8dl3x8QOmT7roS2d+XPCf2rH37BgKjjx2GZ4eZAxZHDZGC21KFKLvkiJym7mW72Osl
         nrNAubCs7gU1H1BdMd/PvmO+yxXU1i8ir7z0zLkNYy5zJyQhio295QocRbmBO8GmIV3Q
         maO6yLRIO5k0xxgQTJ4SWBqnALgw89Zxiri5U71BIFoD4pIMeFKbNAvtL2p/XZoyJNAS
         tH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519087; x=1789123887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yg+f8T7nBpMfHcLwEI2qPhrkmiUiafLrkzAcu6wVsTA=;
        b=nDUBeWE1WpwFxGbmbtS4e5L4ke39ICRifwFO3VBJE4aQ0qxSe5kGZeNIMqfNxeHWnp
         +uCKmWBQfiJs3liDL+Yyws30WukYYg2399uIHBeHWMGcGo0Kj//OPINTMCTDtuxGO3+I
         MhFIDkDwULjWnHehADSELjnTQy0Od+5itJswikVh1FkjNfyKfOsM+LAz6F7oX2NKCxtr
         +7MbJNCEdZdJNY0bHUPIhfLpqCZy1Av3Xq5acAhUtYEeYGyN5K39C9sfoa8IYUkrbD8j
         Br44CY3cLv9O+frfsqBdiqY7opizzIC1wsd2IeIxerj6FDG8py9Z4dps1V3wU53TuaIY
         Jrig==
X-Forwarded-Encrypted: i=1; AKwUvBzMdEWAWga3eljR1yyF55xiOWj7DiprkdEp4dszx1vVLy2jQRM71Kmi8Qf6lJSzPnIwW9eH7G4=@vger.kernel.org
X-Gm-Message-State: AFuF++n32NQge4GWjH2UhJbEJ8BL/aCu08ij47Sgr7itK55/NRANlQaO
	bTx8CU40XC/wMZFoUEM6jtk2M3M48B7f6Gqx/s8TJsP/aHc4Sr73TkoUFsrFzQXkgmJVoUSlmwb
	dLytF8zc=
X-Gm-Gg: AYBFou3HhKOUHMxsORxGJx5qxmnXzGa2DzQTJePNY8NN/odGyjeaH5KVaCwkUuYFQjv
	/6AfTZ07ySqweyJuddIqfdKASNUjaafjqZdTixqxjWrdOfiiQW8zLiT/E3uGcw2eCOW0suxfXhj
	cFPUMn/e4R5a3OVlgeWHON/ovXft2c/+hLF7i/MG9I0RNvOO84ecDG1RdSAuA7nRrgdC0GqLake
	omFFL3/FSmz0ZzXxxAJ2V1G6TGPGr7ZK9A41/RLp9b8hbhm1+8Kuoj39/dyaiIkJByln/8IHKYk
	f+f+QEikCyu7M0VkatUy64sNF+bK8p0k/RVEpsFMOzzIUDoZm9eBNOYpPpDHllPqF0stJD6IaMe
	7kfPfVhYyS87flzpFVPZkUAX/Jv+4y+inBXHyiT7Ty8YUtzvDBeMpkXLYbeBZIQNjjxvNq4REyr
	yP9JCX/6a/7+tc3/fyKqBcyt/8gsS9y8IT7jbM3nYGdcOP4Hk0Zx84B3hckTzj3QB/qd4IKdTWu
	eLqCTl0XOtIfWAvd4ybgkH9VWHp/estzxxmFE82kVDjefAbluClGrUCiBJcRJs0
X-Received: by 2002:a05:600c:870f:b0:49c:fc6c:bdfb with SMTP id 5b1f17b1804b1-49cfc6cbfb2mr21910075e9.18.1788519087540;
        Fri, 04 Sep 2026 03:51:27 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm5382163f8f.32.2026.09.04.03.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:51:27 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ceph: acquire caps for read_folio without an rw context
Date: Fri,  4 Sep 2026 12:51:22 +0200
Message-ID: <20260904105122.19938-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a data corruption problem that leaked permanently into
fscache.  File-backed erofs reads metadata using
read_mapping_folio(), and the Ceph implementation of this call forgets
to acquire Ceph caps.  Therefore, mounting an erofs image file from a
Ceph mount that was just written (but not yet committed to the OSD)
would fail because the erofs code saw only zero-filled pages.  These
zero-filled pages were then copied to the fscache, making this data
corruption permanent (on this host).

Usually, Ceph checks/acquires caps at its own entry points and not in
the `address_space_operations`: ceph_read_iter() and
ceph_filemap_fault() acquire Fr/Fc before calling filemap_read() or
filemap_fault(), and ceph_write_iter() holds Fw/Fb around write_begin.

Only readahead, which the VM can invoke without passing through a Ceph
entry point, checks caps itself.  That check was added by
commit 2b1ac852eb67 ("ceph: try getting buffer capability for
readahead/fadvise") to the readpages path, converted to use the rw
context list by commit 5d988308283e ("ceph: track read contexts in
ceph_file_info"), and moved into ceph_init_request() for
NETFS_READAHEAD by commit a5c9dc445139 ("ceph: Make
ceph_init_request() check caps on readahead").

The single-folio read path never had such a check, neither in the old
ceph_readpage() nor in netfs_read_folio() via ceph_init_request().  It
assumes that the `read_folio` method is only ever reached from
filemap_read() or filemap_fault(), both of which Ceph wraps.

However, since Linux 6.12, erofs file-backed mounts
(commit ce63cb62d794 ("erofs: support unencoded inodes for fileio"))
read all metadata (including the superblock) by calling
read_mapping_folio() directly on the backing file's mapping.  On Ceph,
this issues an OSD read without holding any caps.

The result is silent data corruption.  Ceph clients do not write back
dirty pages on close(); a writer keeps Fb and its dirty data until the
MDS revokes the cap.  When another client opens the file, the MDS
initiates that revoke and replies to the open immediately.  A read()
would now block in ceph_get_caps() until the writer has flushed and
acked the cap-revoke, but the erofs superblock read goes to the OSD
without acquiring caps and thus races with the writeback.  If the
object does not exist yet, the OSD returns -ENOENT, which
finish_netfs_read() treats as "success, no data", and netfs zero-fills
the folio.  The folio is marked uptodate and, because it counts as
downloaded from the server, is also copied into fscache.  This never
recovers because Ceph invalidates the page cache and fscache only when
Fc is revoked, but gaining Fc later will not invalidate it.

Add a Ceph read_folio wrapper which acquires caps synchronously when no
rw context is present.  Cap acquisition can process a pending truncate,
so drop the folio lock before acquiring caps.  After relocking, verify
that the folio still belongs to the mapping and has not already become
uptodate before passing it to netfs_read_folio().  Leave reads with an
existing rw context and the legacy inline-data path unchanged.

Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
Note:
- commit e587a984d332 ("erofs: use dedicated meta inodes for
  file-backed mounts") eliminates this trigger, so Linux 7.3-rc1 and
  later are not affected.  The fix remains relevant to older stable
  kernels and to future direct read_mapping_folio() callers.
v1 -> v2:
- Move cap acquisition from ceph_init_request() into a read_folio
  wrapper, leaving the readahead path unchanged.
- Drop the folio lock around blocking cap acquisition, then relock and
  revalidate the folio to avoid a truncate deadlock.
- Preserve the legacy inline-data path.
- Handle a NULL file argument without acquiring caps a second time.
- Require Fc before populating the page cache; CEPH_CAP_FILE_LAZYIO
  cannot be added because the want mask is conjunctive

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 657c2cb0f881..78b805ccc5d4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1959,8 +1959,64 @@ static int ceph_write_end(const struct kiocb *iocb,
 	return copied;
 }
 
+static int ceph_read_folio(struct file *file, struct folio *folio)
+{
+	struct inode *inode = folio_inode(folio);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_file_info *fi = file ? file->private_data : NULL;
+	int got = 0;
+	int ret;
+
+	/*
+	 * Existing Ceph read paths acquire caps before entering the page
+	 * cache.  Keep the legacy inline-data path unchanged.
+	 */
+	if (ceph_has_inline_data(ci) ||
+	    (fi && ceph_find_rw_context(fi)))
+		return netfs_read_folio(file, folio);
+
+	/*
+	 * Cap acquisition can process a pending truncate, which may lock and
+	 * remove this folio.  It must therefore happen without the folio lock.
+	 */
+	folio_unlock(folio);
+	ret = __ceph_get_caps(inode, fi, CEPH_CAP_FILE_RD,
+			      CEPH_CAP_FILE_CACHE, -1, &got);
+	if (ret < 0)
+		return ret;
+
+	if (!(got & CEPH_CAP_FILE_CACHE)) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	folio_lock(folio);
+
+	/*
+	 * After re-locking, check if the folio still belongs to the
+	 * mapping...
+	 */
+	if (folio->mapping != inode->i_mapping) {
+		folio_unlock(folio);
+		ret = AOP_TRUNCATED_PAGE;
+		goto out;
+	}
+
+	/* .. or has been filled already meanwhile */
+	if (folio_test_uptodate(folio)) {
+		folio_unlock(folio);
+		ret = 0;
+		goto out;
+	}
+
+	ret = netfs_read_folio(file, folio);
+out:
+	ceph_put_cap_refs(ci, got);
+	return ret;
+}
+
 const struct address_space_operations ceph_aops = {
-	.read_folio = netfs_read_folio,
+	.read_folio = ceph_read_folio,
 	.readahead = netfs_readahead,
 	.writepages = ceph_writepages_start,
 	.write_begin = ceph_write_begin,
-- 
2.47.3

