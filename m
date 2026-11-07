Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049078;
	b=StgfyHc01VD6lwTOyVB4UOojAA8K8aIUbxkaPIHzGgEPLOzDbl5CyG6iG2Nhm0bV8F9W
	 QwONzQUTQZr6UWMa51rrjFW94lOBqsY4vwc+XMcMJjghSLNMRUXCUCIk2Ee+XYiOgZwIx
	 DkIYHIi4KdBxK9TeN+zJNt9sDxnD/5lskdSyxwNCaO2vo21LSlJ1nBGlJI5SX5BOFfKyM
	 wcOKesXvmfStQ30LlxKOruEn8RERJsDk6JtycxyYNgBR3raqsy8fQjhTRSE7oNMNAg/DH
	 v/WVJtZUY88PvqvNZYAFerngcWmqX8Fd705Sm3f5JQQG5cxtDx1o1igPOzRu37Dk1Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049078;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JHDr255qnrPhOPV6hQFF5QEgtfqLG+MLFlve/aDZZNk=;
	b=uvvY7w5a4jP2BwWn3t74L+s6Uean9IyylEzRbHgscooKBcAh6b+T/Qgs6O65c0wBAVWm
	 GqbeRLlYZ6cCNlubdGzRcZIfUAfxbS6JUvfxSvHmapq7A38IjO6IaWa2bAwbEqiZQQ77Q
	 2h52agGIE9V+0uRyHz5J3pOa3kazHWX9f1EhJnKtiEn0uRn005Jj04zGa4jq4Q946pgZR
	 5rUBSKVX5QH+Qe5sJZvBDS1pjTJrlS40m7DYnJKJF8AHn833e0DoY2/YPdzqJSw/M/bLU
	 pXaIuFnyfbZ10bwDiS+RtADd1q+ObDHBVrQ8sz3ZA3dYNGy3RGnq1o6LkiRZ3gwf5Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIsjSbqd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F54606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIsjSbqd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A307C1F0089F;
	Sat,  7 Nov 2026 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049078;
	bh=JHDr255qnrPhOPV6hQFF5QEgtfqLG+MLFlve/aDZZNk=;
	h=From:To:Cc:Subject:Date;
	b=XIsjSbqdDh7RmUvKIl9rORlZZK8PHmJ1Uuqyl2++JXfdkEApXslXHZ1AwYi3I5l0U
	 GUABExs4h8nfLsqW6Z6TU8pVMLUvSpXDgsk6WnkU6JG/jlDSYsS72bdMgVDwQwDy9d
	 C1ZJzz8JI+BCBmkzOlNDYScuxUPU50FMvPKcrdIPSJgMP5j/fa+4A10rmdp6bsKBWF
	 +r2yMGlRL8DbKsLPuKq95tnilKaKSjWPbEdJd2cLRexJ/HvE6HgqQoG+nW8uwdIAd0
	 lm3pWKKu5QIQEovSBfo3LswQZKjnev+/jcChFk20lzJXd0XJpXKWcchKTP+K+1V2vN
	 KhHyhapTFbSBA==
From: Sasha Levin <sashal@kernel.org>
To: punnaysharma805@gmail.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] staging: media: av7110: fix sp8870 initialization failure state" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:56 -0500
Message-ID: <20261107055756-failed-5.15-30684fa98394@kernel.org>
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
git cherry-pick -x 30684fa98394bc0eb4362282908612aab7d4dad9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055756-failed-5.15-30684fa98394@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 30684fa98394bc0eb4362282908612aab7d4dad9 Mon Sep 17 00:00:00 2001
From: Punnay Sharma <punnaysharma805@gmail.com>
Date: Sat, 8 Aug 2026 00:04:43 +0530
Subject: [PATCH] staging: media: av7110: fix sp8870 initialization failure
 state

The SP8870 DVB frontend driver prematurely flags the device as
initialized at the very beginning of the sp8870_init() routine, prior
to requesting the firmware (dvb-fe-sp8870.fw) and executing the I2C
upload sequence.

If request_firmware() times out or sp8870_firmware_upload() encounters
an I2C bus error, the function aborts and returns -EIO. However,
because `state->initialised` is already set to 1, all subsequent
invocations of `fe->ops.init()` by the DVB core will immediately return
0 (success) without attempting to load the firmware again. This leaves
the demodulator microcontroller halted and the frontend permanently dead
until the module is forcibly reloaded.

Relocate the `state->initialised = 1` assignment to the end of
sp8870_init(), ensuring the flag is only set after the firmware is
successfully uploaded and the system controller is actually restarted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Punnay Sharma <punnaysharma805@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/staging/media/av7110/sp8870.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 340e4b22859d6..aecdbd87976fd 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -315,7 +315,6 @@ static int sp8870_init(struct dvb_frontend *fe)
 	sp8870_wake_up(state);
 	if (state->initialised)
 		return 0;
-	state->initialised = 1;
 
 	dprintk("initialising frontend...\n");
 
@@ -353,6 +352,8 @@ static int sp8870_init(struct dvb_frontend *fe)
 	sp8870_writereg(state, 0x0D00, 0x010);
 	sp8870_writereg(state, 0x0D01, 0x000);
 
+	state->initialised = 1;
+
 	return 0;
 }
 
-- 
2.53.0




