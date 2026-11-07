Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050952;
	b=E17J3okCV5B//v4Vrohgu6MW/8OllHYh62SXe0M6hfVJrZzSxb9B+OMNXnGjzVcpX6Lq
	 m6HWfAflN7p+Xy7EaUb06lOs1B2NXojgs9/Heh2V0EDn+fzGu28bPp1nbC0kRcUxLylXS
	 2+dvzUucMsCDqfqh9cuDbGsz1HGODZr6/NTesha4B+hBVmAlzwKPBehRHNad1iEbivOMP
	 zFARjjZGyDRA2cmx/28gufIynvLtYx+LTPHpEL4LFhAZlypIEUp/wjjqL1INmK3Q99YUZ
	 vlrLVxmZuSEFJM5BTFbCfiV7KW1+g6idysNZM/iDjVGzGWywLMQJKSEOmg4jC3soxkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050952;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=loedWa4AZ8EHvXb4kYs2RE/aobTWpyfY7RwVZc9xLxw=;
	b=iIvdB3+MeZj+fhKwGo0y2kfe4Wla4U/NOFRV32Ad03j416Y3yHU53TZzIzIL6bfBbOqW
	 be9+Fh2+fVMUvPO/nXnPtDvPZAgzy7eELoGaRjPBsJNcNRaJuhHNu+qwTKSpUR8Hb1XOD
	 R31pYN3UXTmGxSrISPG9PM5lc+C0bg3tBmW0maNIMDUiJWv2wdq2VcsONlxHy1LpQnAOP
	 CNF2WXuYznHXujqCCebrTmr/takNnAt3pdbF/5F7gaMQPbs5TlTdJz63v/iSp/ftk/QHi
	 Sb6uZaD+FyUTR7HrnwVlieNH+yfSlax7BVpDPMuEHje1zPLUyqNUUJ2NIKtwg8RMYiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUCDKqBm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA028606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUCDKqBm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C671F0089F;
	Sat,  7 Nov 2026 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050951;
	bh=loedWa4AZ8EHvXb4kYs2RE/aobTWpyfY7RwVZc9xLxw=;
	h=From:To:Cc:Subject:Date;
	b=SUCDKqBmT8TVpSF337NyV7rb4cnOWCHD2PCX8WboxWVbVa5lNWgNH9NmokQzN1ikK
	 yr0XmWt369JZt+7PuliEduw6a+SbxVMzK/PUXzO7DGU7QxR3IAoGTqa7qZb0Ff6XKy
	 XvLs3I7Hono8sHq5Cb2E+F/5O0NMjEwjQzzr8O+aB2m0DMwek3AxsLlTe/H7SFWRBo
	 20W68bLQdKn9kwxWFv7NhgzOLcMHnAMPwScBkYPyntk4DwpkK2ygw0BZ243aBsIkU1
	 e4lxTCrAF5AMem2bfwUHQp+AseZTg2DbwlN2WmUwDDwX342bEM6+UrMMkiQP8ELi5x
	 uAi3Qsikb3//g==
From: Sasha Levin <sashal@kernel.org>
To: jeremy.jean@oss.cyber.gouv.fr,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: fix 32-bit overflow in readdir reply count check" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:09 -0500
Message-ID: <20261107062909-failed-5.10-52913831ba56@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 52913831ba56efceaafd80b501d68fa00f79bde6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062909-failed-5.10-52913831ba56@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 52913831ba56efceaafd80b501d68fa00f79bde6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Wed, 23 Sep 2026 20:25:34 +0000
Subject: [PATCH] ceph: fix 32-bit overflow in readdir reply count check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

parse_reply_info_readdir() checks how many entries are in a readdir
reply by computing the end pointer of the decoded array. That pointer
addition can wrap on 32-bit kernels and let an oversized count pass the
check. For example, a count of 0x40000000 with 156-byte entries wraps
to a zero offset, so the decoder can write past the preallocated buffer.

Check the count against the number of entries that fit in the allocation
before publishing dir_nr. Reject oversized replies through the existing
error path.

Cc: stable@vger.kernel.org
Fixes: 54008399dc0c ("ceph: preallocate buffer for readdir reply")
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/mds_client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a207b342e7dae..9f13f3f7b800f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -504,10 +504,8 @@ static int parse_reply_info_readdir(void **p, void *end,
 		goto done;
 
 	BUG_ON(!info->dir_entries);
-	if ((unsigned long)(info->dir_entries + num) >
-	    (unsigned long)info->dir_entries + info->dir_buf_size) {
+	if (num > info->dir_buf_size / sizeof(*info->dir_entries)) {
 		pr_err_client(cl, "dir contents are larger than expected\n");
-		WARN_ON(1);
 		goto bad;
 	}
 
-- 
2.53.0




