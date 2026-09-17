Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD01353A6C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649365; cv=none; b=i2D4+bULScah8VJvTa+y6IlnRVWjMZM7wCC1TPvyAcAr2/Wj8Ub/55XrcT0aioZGydi3ngveW1Hgq6ygN18ClKWDrwVHtR+rFRIHMWDd/YPNwmGnct5G/fK1Vt+gT0Rs9NRIo0zyOpkawnImh7lj9jB73nwfEsCWUJR2BDapfxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649365; c=relaxed/simple;
	bh=eDoRLd4lt+uhjIf90wGx3ZMWoSPdfZtCgPk5WAo8Ncs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/FVDHtex9MSMuXYmb5E2yMfmNZSISTKkGiGvj1ZiUwx7WmlJBmtHpQXgTjdPvMeZpAke1JlhmktWcahXeClotVg4WiGZsgzeQm0qBkKmLj7g/G8xbo0whw3qx/KxBQr3eDdaGBgdZN7tRq75f0ECdfsj0zxFRGzVLRg8CVXgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aumw4+Fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aumw4+Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C641F008A2;
	Thu, 17 Sep 2026 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649354;
	bh=wscOnxGI7YmnUBrP7fMfzTIbaCe/CIV4+zS5moyyn5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aumw4+FcFgllLwf68O1PISgjkg918bM4matmVjFC7Lvrd1iARs0VPMYQ55+o8LXL/
	 k/qBzitOGDbplPZ8tpdjOXloEu/hU3ETndsoQeyLN4/MNWaL4wBQmHVKubAL6N6J7I
	 2BN3NQzK7NQ8c5FVm9078OWFyoq2qANnv6AEoQyqqRiK0QF+WrSAi+gEpoWR8P/Oqn
	 7CYZ7JuBDX7wADgQmVT1/vS6/SQZjIPyRoJLqZsisTAaioy+S3mj2uV0Nhu2g7IiM6
	 Ij7CvldvGdLs/rDaUqAddsxtgeYjzSMTQAWO2wo2UODZNsOVQ1nx973OyDrBeSC0zg
	 fFtKAGHOIMZYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Diego Oliva <diego@bynar.io>,
	Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: reject short READ responses in CIFSSMBRead()
Date: Thu, 17 Sep 2026 08:49:12 -0400
Message-ID: <20260917124912.225371-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091605-amino-petticoat-fd86@gregkh>
References: <2026091605-amino-petticoat-fd86@gregkh>
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
index 11a400663b9f2..1939c9174f281 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1693,6 +1693,13 @@ CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
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

