Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879051119B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650234; cv=none; b=OVEshiQvu//D7NYzSNoZJm3Q8sM8/QAuJx3+rhOB1j+Q3yzVv7R7eICpBwXhaPa+CB9T2sNks4usHJ08ealpJrXHAT5cOoK2rRaHYtra3RaF79Y094PZkdZ14UBucJ4ZDm64hRDIo9Bi4pecCsoNXyrOxdRibtVmFXQA4ajTX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650234; c=relaxed/simple;
	bh=/4RS5KUXy5/AvjE5nVaAy+UguzSIj/SoGQ6OdGKLezU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRpC58tjY1+04DRZ9uVODsqHd8mjA+JM1YNvnpvB0FoRYSdD+AK+zTrDcf+vGvMyBxSh3onRqVs3D5GXD4ynE0PwLdTSOAF5oDhgDZuEyiDBbSvW2/pVTz/k5eVWNQQOqus1jXnrGw0vqvAPYSA0bInHYBwNS4wixszy0kI+C5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR9Soh+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR9Soh+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F7C1F00893;
	Thu, 17 Sep 2026 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650227;
	bh=EQbpLfdcN7DFDFRAkPByVNqiTGXNo0eDp+ZVSfI2gQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NR9Soh+QDDz29YrBMgPMuRijO76bMtKkaRAQkoO+a2nWJWKj2NjbB9dbXWUTrvGsZ
	 v9WBX2INywU1fZ/uHK7JGJxwBoU/y1QNn+EJ2FqZNlFY4frPYnqb5he1pm20l2ooth
	 0ubvg4i2rv6sBoqRSMnihRZML7TQL2777T5wzkBBiIDr5qh8UKhZvEy5XoM7rFM5XZ
	 wicBydr8txdbcqeGMuE0OVPt7v7S7uL4P7uD9+KNZo0sR//ovH8vg0Gtk5CXnBuJYx
	 hYbP/5HwaLeIePq1S3NkRpdKMPWRuXZ4TZkHLxTF5xiqCzkMhP5JENvRRW9MOTc//N
	 i5wxJrYj7LqeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Diego Oliva <diego@bynar.io>,
	Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: reject short READ responses in CIFSSMBRead()
Date: Thu, 17 Sep 2026 09:03:45 -0400
Message-ID: <20260917130345.320177-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091606-quickstep-handstand-fba1@gregkh>
References: <2026091606-quickstep-handstand-fba1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diego Oliva <diego@bynar.io>

[ Upstream commit e6142a8bfc230c7263eb8b0475249c958ce49367 ]

CIFSSMBRead() reads DataLengthHigh, DataLength and DataOffset out of
the READ_RSP returned by the server without first checking that a
whole READ_RSP was actually received. The length of the response is
recorded in rsp_iov.iov_len, but nothing constrains it to be at least
read_rsp_size before those fields are dereferenced.

A malicious or compromised SMB1 server can return a response shorter
than the READ_RSP header, so that parsing the header itself reads past
the end of the receive buffer. SMB1 is not negotiated by default;
reaching this code requires an explicit vers=1.0 mount.

Reject the response unless it is at least read_rsp_size bytes long.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org # 6.19.x
Assisted-by: Bynario AI
Signed-off-by: Diego Oliva <diego@bynar.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Replaced unavailable smb_EIO2() with a direct rc = -EIO assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 67ff1669cab2a..ec003e785d201 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1806,6 +1806,13 @@ CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
 	pSMBr = (READ_RSP *)rsp_iov.iov_base;
 	if (rc) {
 		cifs_dbg(VFS, "Send error in read = %d\n", rc);
+	} else if (rsp_iov.iov_len < tcon->ses->server->vals->read_rsp_size) {
+		/* check that the received response can hold a whole READ_RSP */
+		cifs_dbg(FYI, "%s: server returned short header. got=%zu expected=%zu\n",
+			 __func__, rsp_iov.iov_len,
+			 tcon->ses->server->vals->read_rsp_size);
+		rc = -EIO;
+		*nbytes = 0;
 	} else {
 		int data_length = le16_to_cpu(pSMBr->DataLengthHigh);
 		data_length = data_length << 16;
-- 
2.53.0

