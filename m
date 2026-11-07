Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047537;
	b=C0ugA5FfoKXamFGMbxwQjCRntx2YItkN0lqyDZus5xMJJfrBj+zqjw8hl2bEiO9XBftx
	 K5wOomLvd+9xjC2ANIW1qXqqZ62Mt5zyWdu7TGrSH0I2eicbgU/fsmHK4fcAlf4nH6X35
	 lwmESufoJLDcOaKrGTMVt70SuU/w4mCzX4AGLHurp7rGYHKpGFl5uoik3AvSlzuW33t5F
	 0dZlU+Crmx76eFibcMz0dYg8DpWF1tk3yfHNTikVQ4wt5UCoXH5wZp4cmBwS30ew13i2V
	 f1Woz4OcNKPF8bC6R79KLXqs8LKnXJbAEYy8yNXgkckSkAFtRiRVCQ3DL8LQUGNZt8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gyWp/4up6te1c+o1zGL41/iw+I5CDdPq0JfOTi34aF8=;
	b=IuFJg50OjjcEvs/EatdeUH7NQGZVXjuWMSIBrBoSSBGthwemUVaZV9qJL0G0xMmeaSHY
	 9Lpo0AHm95AxZ7+d37BOlc4cOokyYCh1baqi4Is0h5DrIJVkgcqvC+I/1ts8L7LogH3EM
	 lB4bsI9LEQau6jb0ycXFufFMk17KSql1pvo3+r7sd6qDK5KzUZkUgTI8i0jnihS8f0XAf
	 lhbH6/HqnW/qWpemj4RoOZHW1Kq30ogaOirOCc6n93tvOTMzCxTT+RPC7/cLoU18dwer8
	 8JC9I+ezoLDH8qPTL/cMKCgjqfrmHf2NvX0upRPvBTGf00iC1wCe4SAlpxJ5zmFrF7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arcLyqaK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088B606A33C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arcLyqaK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB70C1F0089F;
	Sat,  7 Nov 2026 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047537;
	bh=gyWp/4up6te1c+o1zGL41/iw+I5CDdPq0JfOTi34aF8=;
	h=From:To:Cc:Subject:Date;
	b=arcLyqaKadOJVG5GmelRp4fSFQsuWMdDJtfm6NdYcGjvqJwEeGbtIsdPEMArbxCpJ
	 1XDwga5xd59UG1OxijJdPrJchTvs2OnyURPBsMLtDSQlG/Q5zX4JyqWQfAqkQayJTl
	 pH+EsDo1zOOEAoq4PKo2vAfScGn78VrLxCFSKA9OgWQVqUhSIqobpL44vuWb7qXY29
	 t7G0+FIZoZzETDfnPWzFPfFh1d96Y1i3tTKNdFWH3DX/hhS++TQaGA2GzrWJnYrKOf
	 d/jSyPASui0xHtZsTQlJsmpaCiYk68umeHZ0wkUR8QW6tAnqHA1/7IxtwAjdJg5JyQ
	 fWun1K/EaIvog==
From: Sasha Levin <sashal@kernel.org>
To: blum@kernel.org,
	akpm@linux-foundation.org,
	dmoulding@me.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] init: fix early boot crash with bare hostname parameter" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:15 -0500
Message-ID: <20261107053215-failed-6.6-b6bec5b63a5b@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b6bec5b63a5b812145e53aaad1e63661c7214f93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053215-failed-6.6-b6bec5b63a5b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b6bec5b63a5b812145e53aaad1e63661c7214f93 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <blum@kernel.org>
Date: Wed, 26 Aug 2026 12:09:03 +0200
Subject: [PATCH] init: fix early boot crash with bare hostname parameter

When a bare hostname parameter is specified on the kernel command line
without the '=' separator, early parameter parsing passes NULL to
early_hostname(), which dereferences it in strscpy() and can crash the
system during early boot.

Reject NULL values in early_hostname() and return -EINVAL instead.

Link: https://lore.kernel.org/20260826100904.296151-2-blum@kernel.org
Fixes: 5a704629f2c1 ("init: add "hostname" kernel parameter")
Signed-off-by: Thorsten Blum <blum@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Moulding <dmoulding@me.com>
Cc: <stable@vger.kernel.org>
---
 init/version.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/version.c b/init/version.c
index 94c96f6fbfe6a..0bd5c45aabc46 100644
--- a/init/version.c
+++ b/init/version.c
@@ -23,6 +23,9 @@ static int __init early_hostname(char *arg)
 	size_t maxlen  = bufsize - 1;
 	ssize_t arglen;
 
+	if (!arg)
+		return -EINVAL;
+
 	arglen = strscpy(init_uts_ns.name.nodename, arg, bufsize);
 	if (arglen < 0) {
 		pr_warn("hostname parameter exceeds %zd characters and will be truncated",
-- 
2.53.0




