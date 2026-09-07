Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C599477293
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789459; cv=none; b=d9vHuMSql9cCXP4+cYMVJQ2pawLHL+vtz9o/1TheJ/UwmFDy9S4z9BDzkbiuLlRdwbmUksyvkts37SMkP5o0h0fm9azz3TDhjQQrT1Lr9U2ncbkL5WMvxT+2ndZScZfd808HvFnyAJ1M+5jE/JqDkcjRhwP7vFnUSOHgZP7enpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789459; c=relaxed/simple;
	bh=SnKpeE7SOuMu9Jw7LDp3xW/f40ikLEmeORwGIuvor+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oM4dYiu+RPNQl2AVn/bPTqH65s7iQs9XbGjtnWL15VW4Out+BS5E/TPXsLvbcuuIgIgtoYwqn6DVYYJL/iU1yw7Q1qlRRbCy6PAzrukMhWy8NxwcLVCPKfMpEI5PktbXafpxJLmMzOSgSXnK8V7VgvVFOSnGcWl7ODRBmB8CH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvPW7YyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvPW7YyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790EC1F00A3A;
	Mon,  7 Sep 2026 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789457;
	bh=TW0j8V3MvbaJ/Ze2cjUeP4VU/l3XPGj1xviH9ej0Fms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nvPW7YyPxReariOUuNNvOLsiB5bsOlZeX6v1LsiykOgsS+GuDDYpdbeGPgW619goM
	 6xNPqHqH/We0lKlQk7r7qpNGekRpM0cgaH7qBt8TQO5XIcEpLBbg+bTsw6lrt4Pg3V
	 rY4dU85CI63mmSfsJc/WnmiIyESbLmuLQeD+YJvma4TxLNzrRtr0slaa1wcfvhQC5j
	 a7TWTkXbRplMJwEYp66B8Ggw7+9HLpO5KWk7xBp0QHTL18l6w9odst+TL21YUIkHM0
	 XEILFF1iS8/j876zltVFWaC090pNt1QzCPEPiPzn7b9pu3yNATgROrPiMJf+kRik/4
	 jbqmn/2izYWBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Shen Yongchao <grayhat@foxmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: fix OOB read/write from unvalidated DataOffset in coalesce_t2()
Date: Mon,  7 Sep 2026 09:57:35 -0400
Message-ID: <20260907135735.3129050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090303-reprocess-unexpired-2698@gregkh>
References: <2026090303-reprocess-unexpired-2698@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 6343c1da561962688f203362d80d6a3bfa39fa1b ]

coalesce_t2() computes data pointers directly from server-supplied
DataOffset fields with no validation against buffer bounds:

  data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
                     get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
  data_area_of_src = (char *)&pSMBs->hdr.Protocol +
                     get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
  data_area_of_tgt += total_in_tgt;
  ...
  memcpy(data_area_of_tgt, data_area_of_src, total_in_src);

A small DataOffset can push a pointer below the actual byte area,
overwriting header fields; a large one can push it past the buffer
end, causing out-of-bounds heap reads (source) or writes (target).
The BCC overflow guard does not prevent this: BCC reflects how much
data is present, while DataOffset controls where in the buffer it
starts.

The "validate target area" comment present since the function was
first written in 2005 was a placeholder that was never implemented.

Add lower- and upper-bound checks for both data pointers before the
memcpy, and before any target header fields are modified.

Fixes: e4eb295d38b5 ("[PATCH] cifs: Handle multiple response transact2 part 1 of 2")
Cc: stable@vger.kernel.org
Reported-by: Shen Yongchao <grayhat@foxmail.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ transplanted the bounds validation to coalesce_t2() in smb1ops.c due to code relocation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb1ops.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index c80b291a14a57..9c25fe15da911 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -325,12 +325,31 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr)
 	data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
 				get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
 
-	/* validate target area */
 	data_area_of_src = (char *)&pSMBs->hdr.Protocol +
 				get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
 
 	data_area_of_tgt += total_in_tgt;
 
+	/*
+	 * DataOffset fields are server-supplied and not validated against
+	 * buffer bounds; check both data pointers before mutating the
+	 * target header.
+	 */
+	if (data_area_of_tgt < (char *)target_hdr +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_tgt + total_in_src >
+	    (char *)target_hdr + CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
+		cifs_dbg(VFS, "%s: target data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+	if (data_area_of_src < second_buf +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_src + total_in_src >
+	    second_buf + smbCalcSize((struct smb_hdr *)second_buf)) {
+		cifs_dbg(VFS, "%s: secondary data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+
 	total_in_tgt += total_in_src;
 	/* is the result too big for the field? */
 	if (total_in_tgt > USHRT_MAX) {
-- 
2.53.0

