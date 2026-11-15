Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717718;
	b=u18uZ/xmwtmsbBtBTanmwcM1lTsfQsbEqEA7xN/taPlgLN4ePPw6G76I3V0kP5JyTRWc
	 gVaYtTvSHyBRWEsZCB+QXSlFXiDHfvYSgfzyC3OUBdFN9U6sS7/LhUyjILH+ys6eCtHGl
	 VpwJKzCkxpJTt+jm/e97qV05GF/iQX0DyODWddXFu6PCg1BpAkEYyLDtRwRVIVtkc8bcP
	 xfL4bZgtDNeOLaNxpkfGsVjPsAuSeaQHOFjXtBjPuWK4hsw/JOBCDmEn7ygjJbXeAcgYq
	 JAeEiCor5WFrmcE3WLHzf9YakDCmKJaEI/bhBnyya45jWZLP8Ow1rWD/fOXtgkwk0ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717718;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ietY+R83A5Uk3+FsvAUo+7mwsEnw74vKAWiPVPCniTM=;
	b=jBKi08fix9dwiWDO6VyBNLFTKgQ20Yg3fxbSzQKpRUJWQJQh6k8utKeHuk0zNODKRZcE
	 8J1P2lVSbd5RwoTGd3WAW37rnhUk7v1RuNodmihkGx1ndWGc4H0v2mm0oiMbBBFJzS7c1
	 65Sk+1XA91FBDpmewI08qistJLHQe4QpldO0EBMTNG1IO/LpHVlT1ZiLMuCW09hc8dY/9
	 XrurWpF8Vx80xx67R8WOYF5mpt1Yw3KrAFZkYlkwI5UrOzKfc0ndhn0AjZYaoFQZFJOAP
	 8TTHfE6H6IL9rg7GsUYs2b9eLrjyGDMa3nJkOjoVCPKa4kcoRebRuxaZTNx56xlwbQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZxgZ0lP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E040606A327;
	Sun, 15 Nov 2026 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZxgZ0lP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635C21F000C4;
	Sun, 15 Nov 2026 04:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794717717;
	bh=ietY+R83A5Uk3+FsvAUo+7mwsEnw74vKAWiPVPCniTM=;
	h=From:Date:Subject:To:Cc;
	b=eZxgZ0lPsCQ+o+1TLpSa7upV4rnbXh8kV5XoJUJD1D0QmM2Etj/E3fCieSyZMHe0R
	 ixUdyNF7kBqVdiRLtu2TD/Q+OfHaQvB5j7Qm4bGsJsEa0uYNDoyZdQ9ak5xw4A0M5O
	 My/hPi1wURYCf+e4jAI/knbu9XkLOIvY/ywqluy84jTOgkaFurH2ZdtK67Bfv6hRVv
	 HQZTgrVQb/UeSvs83/JtXXCY3JKhldYSRpPH6zJmOxjqgovCdMXitgwFz6JlIM18r0
	 XWVY1cNyQ2Moa1ZLiveWIyy9VLSAqy2WCjKSdDQG6ce4EDARJasaee+iWTsTiVylDk
	 GW9YZxjPPFtCQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 14 Nov 2026 21:41:48 -0700
Subject: [PATCH] floppy: Avoid unsequenced accesses to jiffies in
 show_floppy()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-floppy-wunsequenced-v1-1-a54dba6754c4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMSw6CMBRG4a2QO7YJRSLFrRgHtv2BS0ypvdZHC
 Hu36vAbnLOSIDGEjtVKCQ8WXkKB3lXkpksYodgXU1M3B611q4brEuNbPXMQ3DKCg1fGdvve18a
 atqdSxoSBX7/r6fy3ZDvD3b8r2rYPaPADu3cAAAA=
X-Change-ID: 20261114-floppy-wunsequenced-8b739d08b849
To: Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=nathan@kernel.org;
 h=from:subject:message-id; bh=QwSxB0h0kSn5HyXRP9tGT4oF+hJsuq19SjwCHgkj9hU=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk/LQSaGJzaOZPnM7teKJg859HpF2fDHs1f9er/f/uZ7
 We84idv6ihlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATyephZDggzZTpWfaV7+7K
 LwJrF+pfCf34quPYJQ2hHP7r73Wt8l8y/GYRnqx1RkIgRvHmvObZ36XjH7Mte92s6nu2dPljnzS
 Ri3wA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appears in show_floppy(), which can
break the build with CONFIG_WERROR=y / W=e:

  drivers/block/floppy.c:1839:30: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
   1839 |                 jiffies, interruptjiffies, jiffies - interruptjiffies,
        |                 ~~~~~~~                    ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
function call is indeterminately sequenced, meaning any side effects in
the arguments are unsequenced.

Add a local variable to hold the value of jiffies before the function
call so that there are no unsequenced side effects, clearing up the
warning.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2198
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/block/floppy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c677d783811f..f6339d779be9 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1830,13 +1830,14 @@ static void reset_fdc(void)
 
 static void show_floppy(int fdc)
 {
+	unsigned long j = jiffies;
 	int i;
 
 	pr_info("\n");
 	pr_info("floppy driver state\n");
 	pr_info("-------------------\n");
 	pr_info("now=%lu last interrupt=%lu diff=%lu last called handler=%ps\n",
-		jiffies, interruptjiffies, jiffies - interruptjiffies,
+		j, interruptjiffies, j - interruptjiffies,
 		lasthandler);
 
 	pr_info("timeout_message=%s\n", timeout_message);

---
base-commit: ab43ec385580b8f8abf72d70fa3acbf4e4f098a5
change-id: 20261114-floppy-wunsequenced-8b739d08b849

Best regards,
--  
Cheers,
Nathan

