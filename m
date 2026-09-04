Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B0311968;
	Fri,  4 Sep 2026 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788486536; cv=none; b=JbRn1b4fdFRKvnq38OdDlANdmrsIyaXbUfGkMpDqrHbEDgi5Kmg4NEwx2+6myDOivJ1Es1K1FI7BaOi742JG1D4S63ftfrpu7NVwIq2072hnSZnvtNHYO1eCM+f14Ze0hFq8iTgIagKRiVdN7D5yuGCdSl3aKVkCU/l4f7Day+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788486536; c=relaxed/simple;
	bh=YH1C+COc8qRA1j5l1eSyNnqVxG5y3HDv6cEHry1GiWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cGjKyBwHYXp2sNw8/oO2IrJ6z49JPEeNsajZvnoBf4oEUjiXLfufAgSwK9XF4q2fFBiOU9WZofMEN90GLCdf72mUFxvGeOW/UbazjMvPYD+rooQDmwlYNEUXiEF3ILVGklK5XfSVfhrEWHPx+XGrudqdqfO6CBGUkQc2O5BTw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwHgevU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwHgevU/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BEA4C2BCB8;
	Fri,  4 Sep 2026 01:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788486536;
	bh=YH1C+COc8qRA1j5l1eSyNnqVxG5y3HDv6cEHry1GiWk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=GwHgevU/24dyBaM4XEj5w7I85mf/WFm1QTD3YIj8Qooez+/yx7cEtl2F+LSQR2sHX
	 q+IbCyeOM2Jo37J9gCk4hEM8CTvMM5XbQwNJrlW6Jj0lqAxeUcc7+8V1rWp6dKvr3M
	 0u+kgXF675lanBnrF3YEkXWdIMJRqWP1NjbNQ9nfJppyKCKR6O6xKCdqJBc2VnOVuc
	 AU2IoA84Txv24/poBoCc88d+R0PHcQ4TpA6VVfrl52GHH//tzD2d7Bq0irbgeB8eJX
	 DwDrRFTdu7J3S9ar8iMOJHJrCKfM48ELqQKvcS7tW0CI4LUy1zvaHU5pJXSAuIUlX4
	 gIS7n7bEEMpsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC24C624DB;
	Fri,  4 Sep 2026 01:48:55 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Thu, 03 Sep 2026 18:48:36 -0700
Subject: [PATCH] libceph: only set read_from_replica on read requests
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-read-from-replica-v1-1-76d1ad8d7c2e@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche3aT2iUEfRXjoS0DrFEgWzUmh
 Hen6m2+w/wrZZgi07layfDWrPNUcDxUlMYwDWDtisk737iTE441G0LHvc2Pspa7psBeRBBi9Gi
 FynUx9Pr5ZS/Xv/Mr3pCe3xZt2w4AJj7qeAAAAA==
X-Change-ID: 20260903-b4-read-from-replica-2333eabb2e83
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788486534; l=1667;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=1pp/hauPyQPUhFkDy5Rb9gGCh+DLMtRFxWdPt0GBjHY=;
 b=dsJX6n/Fq3mMTVrwc5yJ4ApdkX4MOSvn+uELMQtll59cU0ddJ1liPq502KO3I9qJ4Lf4d4o/n
 U6kHeQxGItsBPQOhW9Ov8Eh04CDAoqBA0UGqlOyPY8ozSVCx7X4+7x4
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

ceph_osdc_alloc_request() ORs the mount option's read_from_replica
flag into r_flags for every request, writes included.  The flag is
meant for reads: calc_target() skips the replica choice for any
request that has CEPH_OSD_FLAG_WRITE, and the OSDs only know
BALANCE_READS on read ops.  Sending it on writes is at best ignored;
with read_from_replica=balance a buffered write that fell back to
ceph_sync_write() after losing BUFFER to a revoke failed with -EIO,
while the same run without the option works fine.

Gate the flag on CEPH_OSD_FLAG_READ.

Fixes: 22d2cfdffa5b ("libceph: move away from global osd_req_flags")
Cc: stable@vger.kernel.org
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 net/ceph/osd_client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f68918fc27f9..a5fc5de2c2b5 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1109,7 +1109,9 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	req->r_base_oloc.pool = layout->pool_id;
 	req->r_base_oloc.pool_ns = ceph_try_get_string(layout->pool_ns);
 	ceph_oid_printf(&req->r_base_oid, "%llx.%08llx", vino.ino, objnum);
-	req->r_flags = flags | osdc->client->options->read_from_replica;
+	req->r_flags = flags;
+	if (flags & CEPH_OSD_FLAG_READ)
+		req->r_flags |= osdc->client->options->read_from_replica;
 
 	req->r_snapid = vino.snap;
 	if (flags & CEPH_OSD_FLAG_WRITE)

---
base-commit: 6b039a71d37a39bb90a64c4e271f90ee0588ac4a
change-id: 20260903-b4-read-from-replica-2333eabb2e83

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


