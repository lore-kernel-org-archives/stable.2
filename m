Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89139CD0A
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791022312; cv=none; b=AWDhoRUNujnDTBOzSOJfhy4tuz/chHro7ayv0006jElgcEgoutTy7QoiuuWsMcBmf+aDFZRkDfXJDejud8cTrtBUtuct2ajbhDciQ5Kky6CVhNPdEW13TJZsM6WWRVpvvNk7mG9Nhf0DSag0BecmFcS0mbPwXIKTdGuKE+MzXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791022312; c=relaxed/simple;
	bh=p6wAteknLTFMLbws31q1Ibfxgf0w34kWpjIk5elFF00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfLURp/DzpsOUyZWiNe48b3VfFyQ3+MILYs862QfuENGZdnt7n0Wj70/KbPva8uI4TE/g24eOclRDfUpQEQqFuJwIiOpw5KWYF9IJ7J4LzVRaUsOqwrLUe1rxQ1377lFjETJF76dNur70pU6gglpaui9OThOULRDx7NEwCaav4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=nojcn/qW; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="nojcn/qW"
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 31D361C1847
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:11:45 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1791022293; x=
	1791886294; bh=p6wAteknLTFMLbws31q1Ibfxgf0w34kWpjIk5elFF00=; b=n
	ojcn/qWraZ1RoHSZQhlsudrWNAZHLlqiz57XW0mhAEoebnfuwTTv5qjMMwV/EMw4
	A4G3yY5m27CypPrm91RFtoYA4yuIrCkAg0ct+nMuuhNTO7GySJauJ3VUhpuZpylL
	+Dmy2UhkLliEcPHHj/BUtxxxizbx4qUItQXvSDFpbM=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MyHllo67Uz25 for <stable@vger.kernel.org>;
	Sat,  3 Oct 2026 13:11:33 +0300 (MSK)
Received: from onyx3 (109-252-38-116.nat.spd-mgts.ru [109.252.38.116])
	by mail.nppct.ru (Postfix) with ESMTPSA id 5CCC91C2304;
	Sat,  3 Oct 2026 13:11:19 +0300 (MSK)
From: Mikhail Mirkin <mmirkin@nppct.ru>
To: stable@vger.kernel.org
Cc: dhowells@redhat.com,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	Mikhail Mirkin <mmirkin@nppct.ru>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12.y v2] cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1
Date: Sat,  3 Oct 2026 13:09:40 +0300
Message-ID: <20261003101004.4162-1-mmirkin@nppct.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

commit 9d85ac939d52e93d80efb01a299c6f0bedb30487 upstream.

If a DIO read or an unbuffered read request extends beyond the EOF, the
server will return a short read and a status code indicating that EOF was
hit, which gets translated to -ENODATA.  Note that the client does not cap
the request at i_size, but asks for the amount requested in case there's a
race on the server with a third party.

Now, on the client side, the request will get split into multiple
subrequests if rsize is smaller than the full request size.  A subrequest
that starts before or at the EOF and returns short data up to the EOF will
be correctly handled, with the NETFS_SREQ_HIT_EOF flag being set,
indicating to netfslib that we can't read more.

If a subrequest, however, starts after the EOF and not at it, HIT_EOF will
not be flagged, its error will be set to -ENODATA and it will be abandoned.
This will cause the request as a whole to fail with -ENODATA.

Fix this by setting NETFS_SREQ_HIT_EOF on any subrequest that lies beyond
the EOF marker.

This can be reproduced by mounting with "cache=none,sign,vers=1.0" and
doing a read of a file that's significantly bigger than the size of the
file (e.g. attempting to read 64KiB from a 16KiB file).

Fixes: a68c74865f51 ("cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: lvc-project@linuxtesting.org
Signed-off-by: Steve French <stfrench@microsoft.com>
[Mikhail Mirkin: Adopted for 6.12]
Signed-off-by: Mikhail Mirkin <mmirkin@nppct.ru>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 01c78d9e7..11d408d1a 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1321,7 +1321,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	} else {
 		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
-		    rdata->subreq.start + trans == ictx->remote_i_size) {
+		    rdata->subreq.start + trans >= ictx->remote_i_size) {
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
 		}
-- 
2.50.1

