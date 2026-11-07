Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046274;
	b=2qvs24o9z3kdDcxhFIs9mNiE7K6yBT2RXOocPXl+fymCc4VbX/y84Op5tG1I0r+aXv0+
	 6tcXoH0XhP4A/moSdtkk8ys5eIS6Xq1SsQ7hD68qYVLbvspEtDyqxAZZlAMKiU3l+klMM
	 Ia8G7Lblo8pI062fShOKoD6ebUcGfejeLVbXJPtBXw4dDK/Wbf4EoJ+G3s8/PcGa487F4
	 2/PqGgc3cSx9usQLc5R+R9Ib+skiC1o+Fg4NND3BAsYw5K17W3tVTSjfGT0YpvpqqIBhf
	 YrWoOIVkXB3q+NJ+fXKGXqiWnoC0tDVPxz1J0F5bAgYdaS736icnNEVwVsh9PAqXqBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qh7h7+IQvK0dK8x7TE9JmEhSAHnDhvvLmiuoFecB5OQ=;
	b=xPhXX1yrA4wCVKKUwtHpYnxN7bGnNtbtxCSJJ4XSBt0v6sfvT5nDB4TTi/JqXRmw83Ny
	 F5LVuw1YfRhN6IEaGORz5N8E//VmGw+EJmyXkqohrThSFx0PjyhiWtfiu6fI3yL8nMSaO
	 PMCSgwxxDWhzxm4SS8hbPgP8z6Phc4KMy5XxVKWY88KyyhM3+O84NbffGyOovSK0mNhxR
	 IUMNaB00tZXxafXrh0kQj1LGhIAHb3mllKuW2QSQiKpv7K40I5mQ48jkLIc0fbkNyT42p
	 LEeOlBesyWvm2Nwm4Vt7IToH/j4TQOW1sYF80KSnYOu0YIrBbr7zNrgPi8RxthyazHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLEUoFHU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38259606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLEUoFHU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB101F0089F;
	Sat,  7 Nov 2026 10:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046274;
	bh=qh7h7+IQvK0dK8x7TE9JmEhSAHnDhvvLmiuoFecB5OQ=;
	h=From:To:Cc:Subject:Date;
	b=SLEUoFHUZEaPG/mJSRcT9ZYpImjQX6Sy/JRX8wz2lhHNr9ue8asH4QaMj4+aOPNCF
	 NQav45E9PyfUXwiLb1CgSE1Fy7a8n4lckOD8qFumVcfmMTO4GF8jpSGbu8MFUN4WGX
	 +RiOtjbkf0jbZhPSpCeQVPBasVyl+ZPuX69b7OopnbyiT0ZgBExmhR5UNODUWFy0M7
	 jgPcFoOEfC+Ow3hMOEzrtyVyqZKren5MpMThumSlm5UwFxJTx0SfSsPRurksyOuBba
	 +9WjH3qksdIwl7c+CvJ54QZVd/iUcUj4Pl76PTv+sIhOlmGaaf2TFaAD+G5KMJYW3V
	 k1/mNTY/flMcg==
From: Sasha Levin <sashal@kernel.org>
To: hengyul@cs.unc.edu,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: allow empty strings for journaled quota options" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:12 -0500
Message-ID: <20261107051112-failed-6.18-0354a04b8c34@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0354a04b8c34e26cc66d0f43785d388163b6bacc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051112-failed-6.18-0354a04b8c34@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0354a04b8c34e26cc66d0f43785d388163b6bacc Mon Sep 17 00:00:00 2001
From: Hengyu Liang <hengyul@cs.unc.edu>
Date: Sat, 10 Oct 2026 12:57:50 -0400
Subject: [PATCH] f2fs: allow empty strings for journaled quota options

Commit 2a3db1e02ce0 ("f2fs: allow empty mount string for
Opt_usr|grp|projjquota") added support for passing usrjquota,
grpjquota and prjjquota as flags to disable journaled quotas.

However, it also replaced fsparam_string_empty() with fsparam_string(),
which rejects an empty string. As of now, mount(2) and
fsconfig(FSCONFIG_SET_STRING) reject usrjquota=, grpjquota= and
prjjquota= with EINVAL, although these forms are still documented in
Documentation/filesystems/f2fs.rst.

The issue can be reproduced on an F2FS device with:

    mount -t f2fs -o usrjquota= /dev/loop5 /mnt/f

Before this commit, the command succeeds. Afterwards, it fails with
EINVAL and logs "f2fs: Bad value for 'usrjquota'".
The same failure occurs when remounting to clear a quota file name.

This patch will restore fsparam_string_empty() for the three options
while retaining the flag entries, so both forms are accepted.

Fixes: 2a3db1e02ce0 ("f2fs: allow empty mount string for Opt_usr|grp|projjquota")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 17aae65e750e4..6a35144a2f7fe 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -338,11 +338,11 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_flag("usrquota", Opt_usrquota),
 	fsparam_flag("grpquota", Opt_grpquota),
 	fsparam_flag("prjquota", Opt_prjquota),
-	fsparam_string("usrjquota", Opt_usrjquota),
+	fsparam_string_empty("usrjquota", Opt_usrjquota),
 	fsparam_flag("usrjquota", Opt_usrjquota),
-	fsparam_string("grpjquota", Opt_grpjquota),
+	fsparam_string_empty("grpjquota", Opt_grpjquota),
 	fsparam_flag("grpjquota", Opt_grpjquota),
-	fsparam_string("prjjquota", Opt_prjjquota),
+	fsparam_string_empty("prjjquota", Opt_prjjquota),
 	fsparam_flag("prjjquota", Opt_prjjquota),
 	fsparam_flag("nat_bits", Opt_nat_bits),
 	fsparam_enum("jqfmt", Opt_jqfmt, f2fs_param_jqfmt),
-- 
2.53.0




