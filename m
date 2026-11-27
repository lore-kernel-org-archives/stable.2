Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795754091;
	b=C9R0vqEEBuxi7t0rrkKPOReuqyPmq2i0QDW4v/PWN1QSL5W9rSGh2FgDR1MZxIjV4xjq
	 IV5zaW4sKaWStAXGJC/keoGgM+S4hwVdPAuAK6zSOapQ30mLa2EacHL6dFzDRrtDJXJDP
	 dHDVMar5iJ6iGxlFRBhsHsblFsb0guW/QSZLqzxIJtQMNUOfubyOpM6xRVFM2Bp045m0y
	 8+t4LT0nWDD5IPidjxJbzkVk6XYloINo5I/3PqNJaMj6zJxp1ugrUU/tg6n/XshM1X1V0
	 5X9lbgt/3iRmDSHCYgzDp0nSgR8TFFMVGwVFm67IPoL/DWy5ot+Ut3uLBPkS/UfL83Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754091;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5LMiR0I8eERcmOiHEs3fH0wY7Z7NXwv2db/BnsDj8zw=;
	b=sCVspc3kbti08+9lWKi+qMs01rgWXpc99n076gWsxqnIXNVujdNnY1q8KC1q287Qka2W
	 caimRGVjOgV2Z7WGpo9uAucLyU44tw3ro2ldDRDP+grkaIJ05Tx2TPKQWa8XmlP47ZEBE
	 I2mk9He7TpkCEt2ldFlqPywiaXZGHg6P0AZnB5fkl/Kj+hFsjd/P5ZhqHFpqCLpQ1k7EP
	 yIMGQEZlGIUZ8ZYscIUDytWhcyG3/yVb2kJUdvteFEirBLlpyN/5ffbAvsndpV6zRKCob
	 UrRvoBPBNBTST4ZJcT29KIcL2lB4SN1VqWB7bpK8K+kb3ilVhyhIeYvA0C4LId5R1Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W34LQhWv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FD606A31C;
	Fri, 27 Nov 2026 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W34LQhWv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795754090;
	b=xOxq0hg1j2OEp0Lzv7xK3oWoXo/ae2wU1qyBW63tVEtWRUKJ7igTLsxuuvbfBdn41kUu
	 UhcdiuTPCL4xqmqyqK3PTXr3QcD8pEHa/Z6oWExp2+ybFIaFjRoRVhnRLVW05BIZ1kAuU
	 f6dgJo+pHWHEYVX+QIHWxWT23BgkIFZ2EbhPsUKY3a+/zypuip6ZTm5j9f+cKKbWrRyA/
	 lzZsd5HBTaxI+DzABSK5dm9wtujyKQZ69uyO5c7GQ7gPQjrwXPtTBBXt6OrjVYt/n9MMx
	 qkMNV7IZbiCW23BUBcpLcuPWkOJb1Y03ausYRtE6v/vGBkJQEb/QpN65JwEIPV/OloQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754090;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5LMiR0I8eERcmOiHEs3fH0wY7Z7NXwv2db/BnsDj8zw=;
	b=hSN6CVKddd16xNHQLcRyAczkaQHT12Ogr2pQ08eIiN3f3tmS4Sr3Dnx1Y20VgcNWW/FL
	 tr7wflZFxE/25M2Kqp/UKLxUx/5QjW7+0Zhs2oPx9roqTT7zWYqArr7nibc38y0lqnNeP
	 CFnVgp9usrxOZbFX9C+6fvuFRsotQy6A2rm7DxeFL/33dANxGp3N9c2nqkd0cCACADmHR
	 UeaAtANcZcYdA7ivsVcRYDg8rVVnO8YRKPXCavPVDJ17osUdImJMi5d2iR1sxNzuv3JrD
	 /pt6UgUe6dyegm2N143lkPIAWB40ksr8rIS2ear5ukCewd+CDvxpkj/6iXm+mD/TDsQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2F1191F00897;
	Fri, 27 Nov 2026 04:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754090;
	bh=5LMiR0I8eERcmOiHEs3fH0wY7Z7NXwv2db/BnsDj8zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W34LQhWvNnfC+06P84Z/0yM333S62BFDc9Flw8CJ64drI48BbrxzLubsWg5L03lla
	 4MLbdypweOfrDhDQ0cuNed/CFwMeBaHZTTCJlcxwbgktk8vR25FamtgDjXFGk5xyOM
	 h0yEBhAq6CtCOh33fTJGhXja9ygmzOySNnNK6jd4Gc1iRExwSi1pIZMjq8kFN805Mw
	 2Kme0FHcvwm7PQ81MCUdwqA440/868tOahiDfR4oSjqC3kj2D+RF0uRYgmTEvIqAo/
	 rBevYRziPUobGRsVIKwCcp9Z45yDnT32Ol9CLd5GuBlbTEDq5RwhYOa8pLMZ1Ly2dL
	 anzMIn+N6Dlow==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B53194B569;
	Fri, 27 Nov 2026 04:34:45 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 27 Nov 2026 05:34:38 +0100
Subject: [PATCH 1/2] ceph: tell the MDS when a closed file no longer wants
 Fr or Fw
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-ceph-drop-stale-wanted-v1-1-763882859c5f@clyso.com>
References: <20261127-ceph-drop-stale-wanted-v1-0-763882859c5f@clyso.com>
In-Reply-To: <20261127-ceph-drop-stale-wanted-v1-0-763882859c5f@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?PATRICK_B=C3=89GOU?= <patrick.begou@univ-grenoble-alpes.fr>, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795754083; l=3161;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=pffS/mCkZJh6WEF7XHRVXxBboLfbNbLy63vgUyCni1U=;
 b=alo+dUHgRrOS5eTXfRsfrcUDJUXRjDegf4XMdgQuFH4qMkEdtJtj1icVFCYn7qVnxUQUx5TH0
 8TlVKHRe+H2AvjoDyUYLtCTzQ3VpDlJOI5jteQT7eHb+ZUtk0rN4COW
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubo.li@clyso.com>

ceph_check_caps() skips a cap whose issued caps are all ones we retain.
Since commit fdac94fab799 ("ceph: skip updating 'wanted' caps if caps
are already issued") this holds even when the MDS still has a 'wanted'
mask we dropped long ago.  After a file opened for reading is closed,
we may keep the inode with only Fr and shared caps issued, and then
never tell the MDS that we no longer want Fr.

The MDS counts every client wanting Fr or a write cap as a user of the
file.  If another client keeps the file open for writing, no loner is
chosen and the filelock stays in MIX for as long as we keep the inode
cached.  The writer has no Fb, so every write() goes to the OSDs
synchronously.  A single "tail" of a log file from a second mount made
the writer of that file over 1000 times slower until the reader
dropped its caches.

Send the cap message when the MDS still has Fr or a write cap in the
'wanted' mask of a regular file that we no longer want.  Reopening an
inode whose caps are still issued tells the MDS nothing, as before, so
this does not bring back the two messages the commit above avoided.

The closed file is only checked again at caps_wanted_delay_max, so the
writer gets Fb back about 60 s after the "tail".  Two noshare mounts
on one VM, 1 MDS, 3 OSDs, 64 byte writes on mount A, one "tail" of the
file on mount B:

  +--------+---------------+-----------------------------------+
  |        | before "tail" | after "tail"                      |
  | kernel | ops/s         | ops/s                             |
  +--------+---------------+-----------------------------------+
  | before | ~120,000      | ~85, as long as the test ran      |
  | after  | ~120,000      | ~110,000, from 60 s after "tail"  |
  +--------+---------------+-----------------------------------+

Fixes: fdac94fab799 ("ceph: skip updating 'wanted' caps if caps are already issued")
Cc: stable@vger.kernel.org
Reported-by: PATRICK BÉGOU <patrick.begou@univ-grenoble-alpes.fr>
Link: https://tracker.ceph.com/issues/83627
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index cc8748f7e0bd..add63a8f6212 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2418,6 +2418,21 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 				goto ack;
 		}
 
+		/*
+		 * Does the mds still think we want to read or write a
+		 * file that is no longer open here?  It counts every
+		 * client wanting Fr or a write cap as a user of the
+		 * file, so it keeps the filelock in MIX and no other
+		 * client gets Fb or Fc back.  The caps we hold may all
+		 * be ones we retain, so tell it now.  This only fires
+		 * for bits the mds was told about, so reopening an
+		 * inode whose caps are still issued sends no update.
+		 */
+		if (!S_ISDIR(inode->i_mode) &&
+		    (cap->mds_wanted & ~want &
+		     (CEPH_CAP_ANY_WR | CEPH_CAP_FILE_RD)))
+			goto ack;
+
 		/* things we might delay */
 		if ((cap->issued & ~retain) == 0)
 			continue;     /* nope, all good */

-- 
2.53.0


