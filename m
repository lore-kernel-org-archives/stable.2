Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049337;
	b=LgnAGFJZECIPGODhwdO+o07NQEjLPy8oMg1J1z70vynvDyMX6a2KbFr8gTVubocmK5e3
	 U0xm5SjdM4y/nwbsYt2bgCy7HIBNCudfKZwtpOhD83p4ayN+fIP2DDzIM1vlm7Ye51EbZ
	 9LpPAjFtPOjH1cDb4u+iyWxDU2H64JxxeZFXeFS72qk3IEw8f/pUFsyf+r9BYTX5BOzZX
	 8J7vXVLGViM0FB8m7B5VrK6vIwbWRax3fYSsB1crwSIeWJH81NUG9YiNljQYQxRwIOmx3
	 tX4eEkFh7CY2dO5pjnu56NUUlN/6hBaCD7P1tpOfujda+aYlBgPfcsf6PV4w/Xfb9Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049337;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nFGJJ4nyVD2OGDXP777fDtPEnkuBhR7kzvDa28HDJMI=;
	b=Aa8ExJdQbqCgrNmzqnLX244K6gvt/r93FsHCKN+3f/FchWLpkJRpmvDZTgMybC+pdDya
	 aY3WX0QVgsCnCLBwEI2qMbnrzGMxEygJciABqCsFfQm/5izvkyCu+7NFZFat6JJi608Bd
	 t3YWMbiQNUdAQ8+UjERA+ddCsNH25w/ebwzLr9y5BAbjSdcovWrERQpMxtVM4nHWS+fX1
	 Ixu1eTQFJ80WR887kT4nkTIkd9ZzRUlUn440Obfp8CNu4Pcbd7aEHMSqgOBDz35P7Exle
	 y+/sWztjl822DGJ3bvKn9J3/OAY0F5UlIDlI9fwZEYlEZnlYR5qrmHuesqWDu2bA5Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzaDejUd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE549606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzaDejUd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134AC1F0089F;
	Sat,  7 Nov 2026 11:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049336;
	bh=nFGJJ4nyVD2OGDXP777fDtPEnkuBhR7kzvDa28HDJMI=;
	h=From:To:Cc:Subject:Date;
	b=WzaDejUd0XJDDBEJix+H97cRCmrCZMBpIOhGvsRaA6I/OPjrz7ecCeeIihF07DGNZ
	 shASpLvNX9TPLzzGDycC/nbmpohMh+XwmtD27bgY6Il7BsfqLMd85JDRfRV8IeDhQN
	 LRQSZN8kY7wj8TPx8VT9UI1qCZMgAwjN8VPr1wQb+/8DlNa6EYvnH2eVvpOllEiYUG
	 vxCDxAGp9/ZcHOa2Kv+ZHrXeL/5SDuwU6YBZHaf0yskPRIqWKVAFVGaqGlauCo2oHY
	 CdeQ/Xu9u6kOwIC9Je1/WiktIklas9qXrF+4WfxwUpnR6n1g7+tRlefpTYtbD3nEcp
	 GpQ5k5JGLQ8Hw==
From: Sasha Levin <sashal@kernel.org>
To: cel@kernel.org,
	jlayton@kernel.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] NFSD: Resolve the recall-any mask names in the trace format" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:14 -0500
Message-ID: <20261107060214-failed-5.15-c563a1f06795@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c563a1f0679566d7d586802e5346591d0af8da78
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060214-failed-5.15-c563a1f06795@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c563a1f0679566d7d586802e5346591d0af8da78 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Tue, 18 Aug 2026 14:41:51 -0400
Subject: [PATCH] NFSD: Resolve the recall-any mask names in the trace format

RCA4_TYPE_MASK_* are enum constants, so the preprocessor cannot fold
them into the print format that show_rca_mask() builds for the
nfsd_cb_recall_any event. Nothing declares an eval map for them
either, so trace_event_eval_update() has no substitution to apply at
module load, and the event's format file ships the enumerator names
verbatim. trace-cmd and perf cannot decode the bmval0 field.

Declare the eval maps for the nine mask bits show_rca_mask() decodes.
The format then carries the shift counts as integers, the same shape
the SUNRPC trace points already emit from their BIT() flag decoders.

Fixes: 638593be55c0 ("NFSD: add CB_RECALL_ANY tracepoints")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260818184151.31180-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 include/trace/misc/nfs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index b5fb77d7954b3..27781bd7a3f78 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -359,6 +359,16 @@ TRACE_DEFINE_ENUM(IOMODE_ANY);
 		{ IOMODE_RW,			"RW" }, \
 		{ IOMODE_ANY,			"ANY" })
 
+TRACE_DEFINE_ENUM(RCA4_TYPE_MASK_RDATA_DLG);
+TRACE_DEFINE_ENUM(RCA4_TYPE_MASK_WDATA_DLG);
+TRACE_DEFINE_ENUM(RCA4_TYPE_MASK_DIR_DLG);
+TRACE_DEFINE_ENUM(RCA4_TYPE_MASK_FILE_LAYOUT);
+TRACE_DEFINE_ENUM(RCA4_TYPE_MASK_BLK_LAYOUT);
+TRACE_DEFINE_ENUM(RCA4_TYPE_MASK_OBJ_LAYOUT_MIN);
+TRACE_DEFINE_ENUM(RCA4_TYPE_MASK_OBJ_LAYOUT_MAX);
+TRACE_DEFINE_ENUM(RCA4_TYPE_MASK_OTHER_LAYOUT_MIN);
+TRACE_DEFINE_ENUM(RCA4_TYPE_MASK_OTHER_LAYOUT_MAX);
+
 #define show_rca_mask(x) \
 	__print_flags(x, "|", \
 		{ BIT(RCA4_TYPE_MASK_RDATA_DLG),	"RDATA_DLG" }, \
-- 
2.53.0




