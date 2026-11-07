Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047280;
	b=lmZtDyT8ONFWyYzlFgGuXkW2hTkiQczlZ1YQs+z3soCNYLRgGcKl/dtdcIV8B6Ep4Ctw
	 ZagPFgBQPndXhncG32NViu97tSk1W9MIKsZIWbzeolrV5Q+OpD8CcrCGrjmVkyRczaN02
	 rtSGlrjJwCUwwMFJso6sYVtczmxfLQpXNPjbxt/Xe+cet222a+4ak5FEj2EfI/25cK4an
	 iTOFEsj9jXpos/jyXwIWGBCM9mTwfF7p+X3/k4e6ToPGI9tjBFQC4H3skxK9a0IPZskEY
	 aCDRBMjfgXyP8ZjhtWJ7bvayHX7XHx4WUmnRX3E8PB0lIRfqgP/2xa2Mm92YORWa3Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047280;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zCb9mN7zmL9sxnSvgWtnWfRHBptj1z7rF9tBCK8aFHw=;
	b=LWKb7nc7BQdc47eSYN7qgKvZBM/Ly6TvrpW9BbEOu8GNSNjzgSfbduKdopst9ZXLF7j5
	 RDDAvqe3XqRu2VZlPHSXeRGsKOdlMaleP93Yvh2S9HwR4yzsqyOEF3wBhP1cU1tnndrqG
	 Ji5PH67pfz8dL8OVRoZTk9cfNKb0uBOSI3ulPhemXXeSM/GnAAa1XvllvkPPNLkLpcCWH
	 OcsgJqoqfd2YTmbnTXGfRerUGVteA2u38laz/PHUevp5acfqbSSXLX06EjYFD4Jy5xLRv
	 3991MPpLnpxlcLVE3R1yuoV/3U5TqbmEFwcoOhsdY/Z44QRJIFOW6aP8v+SrWrzz+uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5ChsIJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC43606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5ChsIJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC981F0089F;
	Sat,  7 Nov 2026 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047280;
	bh=zCb9mN7zmL9sxnSvgWtnWfRHBptj1z7rF9tBCK8aFHw=;
	h=From:To:Cc:Subject:Date;
	b=H5ChsIJCaBV+k6lDZDvAHxErBxCLWATfKdaTIqmpxag+fs1V5iqSMv1uRYFqJwwiq
	 b3KxFcUQDCEPc8MZjDa3WRGDXeuP/y2hkDNIU3/KaOybiUpCoxDXr7wL8lMtlJ10FP
	 cux6bXaWnKYcZeGBmtptrcx55dSgA69Ggwr49Qxq24rOa7XdddnFOJoV3fu2vLiXh5
	 4iuLI3bGAA7LehQ0fd87uyr0sit0vHJpwSk8MmvRZx79m82NTa5HYXyjC7L+poPqos
	 r9++WUVerfxrgZxHZo4iyC/LHCEnROYpguV6vwP/LhnMMXiz6x/edZF7YSPoj1SHqp
	 EKIpn4DJZ51eA==
From: Sasha Levin <sashal@kernel.org>
To: zhugl3@xiaopeng.com,
	john.johansen@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: check accept index + 1 is in bounds" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:58 -0500
Message-ID: <20261107052758-failed-6.12-afe5d5a74739@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x afe5d5a747393cb3d00795db31d7fce5108a766a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052758-failed-6.12-afe5d5a74739@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From afe5d5a747393cb3d00795db31d7fce5108a766a Mon Sep 17 00:00:00 2001
From: Guanglei Zhu <zhugl3@xiaopeng.com>
Date: Wed, 16 Sep 2026 19:53:07 +0800
Subject: [PATCH] apparmor: check accept index + 1 is in bounds

aa_lookup_condperms() returns perms[index + 1] when an accept entry has
ACCEPT_FLAG_OWNER set and the subject uid does not match the file uid,
so such an entry consumes two slots in the perms table.  But
verify_dfa_accept_index() only checks that index is within the perms
table, so a policy that sets the owner flag on the last entry is
accepted, and the runtime lookup then reads perms[index + 1] one entry
past the end of the table.

The perms table is allocated by unpack_perms_table() with a u16 size
read from the policy blob, so a crafted policy can place the owner flag
at index size - 1 to reach the out-of-bounds read.

Check that index + 1 is also in bounds when the owner flag is set.

Fixes: 6f442d42c0d89 ("apparmor: fix profile verification and enable it")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/policy_unpack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 3ffbab46eec30..7ebffb4ff74fa 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1495,6 +1495,15 @@ static bool verify_dfa_accept_index(const struct aa_dfa *dfa, int table_size)
 	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
 		if (ACCEPT_TABLE(dfa)[i] >= table_size)
 			return false;
+		/*
+		 * Accept indexes for owner-conditional permissions come in
+		 * pairs, so the non-owner entry at index + 1 must also be
+		 * in bounds.
+		 */
+		if (dfa->tables[YYTD_ID_ACCEPT2] &&
+		    (ACCEPT_TABLE2(dfa)[i] & ACCEPT_FLAG_OWNER) &&
+		    ACCEPT_TABLE(dfa)[i] + 1 >= table_size)
+			return false;
 	}
 	return true;
 }
-- 
2.53.0




