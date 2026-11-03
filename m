Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701010;
	b=Pjqt5hez6XI1hCuP8VvFN63mF4FjiAYSFHTJShLhFZ1987+M5j8kSZGZywvsvvihBdc6
	 nz69LEQ3xOMQ2XFFbdGJac9gs9Ybq8ltMJTG053h6SV69fxONstXbJbK5FhqZfGPhd4N1
	 /SOHkPlznh5ywWpJYdjKIMcZ/Z0h9FFFPKNU5suak9/VC6IYNC0nQ/WPoJ0yhsTCdOtiz
	 Y55mxDN37Tx0u4C2XoxBUDkZKZ97wwHF3kRbj4YygYAS87sJf+xwXsMjJ/P7QylZcfI5X
	 IlwYygf2HrDZ8N8vcY1zAC4fy/GzBjBKWcmYzc3VZse6ENw+Irx7P5gEidedvWSOn4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701010;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZV3x6Q99+KY4mBwAHW84Cxnd7+9ziusRje5+7Iv1oUA=;
	b=f/f/hXo7hNKXcw2CnyIvivNNdEKekmO8mV2AhLmOdgvgdB6GjmwOH78CqYEcUL59WNiO
	 7oh26v99NRPn8XdiMR+ngrFNQUjuQPjHw9LtFQ78slgg65rRukmS8vf59PAAN9JWKfiHX
	 UVvCsrlHFRT2i1JwccrsPrZqliELWrkjIQtIRS8cEM6Ds35F9yfSwx/jrutQtC2be5m6A
	 TEHlYtbk7XJWtRKyqntV8LUf2cKk8sQiD06CAEnTYry0FNPFKIEOB8zdIyFEsoPl0yxZ6
	 fv/Z8KSJtIrVYSwK28kN021wWaI8MSpe1Hx7lv+9AQenj8yidNwNrSlc/0T4FYF4Guw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1ToxBBge;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B5606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1ToxBBge
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F9D1F00A02;
	Tue,  3 Nov 2026 10:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701010;
	bh=ZV3x6Q99+KY4mBwAHW84Cxnd7+9ziusRje5+7Iv1oUA=;
	h=Subject:To:Cc:From:Date;
	b=1ToxBBge0luAOJyxPkh4hGtOmutaoIeKvBfAUGOoQyXUPRM2wRsXtRm2lsO/kqt58
	 ZWJlYPZQavkTZQWc5Rj21PwydBPHGKdJ4i2ogApqsPMJm3FJjzsLV6zg4sU/5gRR2d
	 o5SagJcVHDN+8LGywBROe4gUIx7cZfrJyF1opAic=
Subject: FAILED: patch "[PATCH] ksmbd: fix overflow in dacloffset bounds check in" failed to apply to 5.15-stable tree
To: gkobakhi@asu.edu,linkinjeon@kernel.org,xmei5@asu.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:16:48 +0100
Message-ID: <2026110348-unselfish-dinginess-65e2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x eb96e2a0e817807c48dc8387ca6a5249fdeae3a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110348-unselfish-dinginess-65e2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eb96e2a0e817807c48dc8387ca6a5249fdeae3a0 Mon Sep 17 00:00:00 2001
From: Giorgi Kobakhia <gkobakhi@asu.edu>
Date: Fri, 11 Sep 2026 17:08:17 -0700
Subject: [PATCH] ksmbd: fix overflow in dacloffset bounds check in
 build_sec_desc()

When the large dacl_offset is provided, dacl_offset + sizeof(struct
smb_acl) overflows on 32-bit builds and the check is passed,
Which makes le16_to_cpu(ppdacl_ptr->size) read out-of-bounds. This
only happens for dacl_offset in range [0xFFFFFFF8, 0xFFFFFFFF]. So
the oob read is max 8 bytes preceding the allocated ppntsd.

    unsigned int dacl_offset = le32_to_cpu(ppntsd->dacloffset);
    int ppdacl_size, ntacl_size = ppntsd_size - dacl_offset;

    if (!dacl_offset ||
	(dacl_offset + sizeof(struct smb_acl) > ppntsd_size))
	    goto out;

Commit beff0bc9d69b ("ksmbd: fix overflow in dacloffset bounds check")
fixes similar checks in other functions. But leaves this one out,
because it is only valid for 32-bit builds.

Reproduced on 32-bit ARM with KASAN, by a client sending SMB2
SET_INFO(SEC) with dacloffset=0xfffffff8, then QUERY_INFO(SEC) on the
same file:

 BUG: KASAN: slab-out-of-bounds in build_sec_desc (fs/smb/server/smbacl.c:1105)
 Read of size 2 at addr c2a273fa by task kworker/1:1/35
 CPU: 1 UID: 0 PID: 35 Comm: kworker/1:1 Not tainted 7.3.0-rc2+ #5
 Workqueue: ksmbd-io handle_ksmbd_work
 Call trace:
  kasan_check_range from build_sec_desc (fs/smb/server/smbacl.c:1105)
  build_sec_desc from smb2_query_info (fs/smb/server/smb2pdu.c:7676)
  smb2_query_info from handle_ksmbd_work (fs/smb/server/server.c:160)
  handle_ksmbd_work from process_one_work (kernel/workqueue.c:3401)
  process_one_work from worker_thread (kernel/workqueue.c:3473)
  worker_thread from kthread (kernel/kthread.c:436)

Add overflow check.

Fixes: 8f0541186e9a ("ksmbd: fix heap-based overflow in set_ntacl_dacl()")
Cc: stable@vger.kernel.org
Assisted-by: LLM claude
Tested-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 05f93a4d9d82..cf8093c7e381 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1096,9 +1096,12 @@ int build_sec_desc(const struct mnt_idmap *idmap,
 			struct smb_acl *ppdacl_ptr;
 			unsigned int dacl_offset = le32_to_cpu(ppntsd->dacloffset);
 			int ppdacl_size, ntacl_size = ppntsd_size - dacl_offset;
+			size_t dacl_struct_end;
 
 			if (!dacl_offset ||
-			    (dacl_offset + sizeof(struct smb_acl) > ppntsd_size))
+			    check_add_overflow(dacl_offset, sizeof(struct smb_acl),
+					       &dacl_struct_end) ||
+			    dacl_struct_end > (size_t)ppntsd_size)
 				goto out;
 
 			ppdacl_ptr = (struct smb_acl *)((char *)ppntsd + dacl_offset);

