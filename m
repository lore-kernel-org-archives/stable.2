Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561189;
	b=SuclmCQBxKrjfsYCplwuPT/ci3e84KN1lMkucPQt0ErePBP31BEAZg4ZWlA+SUaYzvQ0
	 cqKrpuiuap1DAMhF5RP4XFTx2eKJ5FvSFw5mPhtG/jZrgF3F6CSUk3DSE4hoPj2g7zU+4
	 XTjtzdUiOJEV2q7p7uLWB8gqDlbEIOA0+fv5XbQy9TlgtazgjN4W/vZbGzQXzCY8frU6i
	 daRBw6yJxb7+4T8D82iPmvg+ihaXcAto2ju2JS29+DvJcbKMkO/VB3TuKNJ/5K6WQVrCl
	 crnStwIey5iNPmqn6vb9h3qz7L/EJA/VS0Z02qvnSX/u8vOkNznfILVjAW0WkswY8xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561189;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zmxU8jlcQAoOmz9SVXAVr4svm8Xhliz6+CM8YIPXeGA=;
	b=lPp0JoBd65TdAIZD3jcDqqFkxro0evnnh4MijYvOLMd+K4/vJpwhXi66dzvnF4aLJgZQ
	 o8KxoUFUQIJ84YG2IKVJWyiFUNI8emvqG95XDK0oc8HOl4rMazJG8nEnJHfGgFL9qbBa0
	 tYaNLg+XMgtK8ULOt963R7SrswQTVQdmRRovZ9aeeklB/tJfoMpw73FN/qr+SmRcOLDhN
	 +232zUMe4ErQPppErlaRnnaaSuZ8PCx+D2SQoX6UxMQGJbVNJwy/gG8fAJ2CPfOCTpVTV
	 sitCb2jl0TWjvyL7/iK4L/kAfrtNF558e81XoyeFcBK9x0YV8/TTiSnPKtKSz+fnoaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nN+bXffD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CA606A323;
	Tue, 24 Nov 2026 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nN+bXffD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7E11F000E6;
	Tue, 24 Nov 2026 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561189;
	bh=zmxU8jlcQAoOmz9SVXAVr4svm8Xhliz6+CM8YIPXeGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nN+bXffDCKcamcRSHOh5LpKsvzSpQ4Oz6YaZpVhZycBqOy4qNra1dIBQPQVbRwKse
	 gyrbI74wweoIfmrfNK8rnMlkMEfh8lf22IdjZwG41fENFIJiGE0/NmlfZ0Q02U1eaS
	 G2/wrQNK232sNjP0Efb3USghHe7mRkOAlVzuvorzInur9xifSP3mrUTUAH6pjk8Sci
	 l0g+ssPoT6SVPzdqWZu00+5IDx7U0H3GOa+aQY/QCTbI8Xox1hOxxpD6YgmVMS44dA
	 bXG0qdWyrE301cHq8lu657MvuUMAGKO9+EAhtOhmZIpmEJ5a5sVegWi7/mcwa2PnJ7
	 D0dqKukkyizSQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:28 +0100
Subject: [PATCH RFC 05/19] selinux: close inherited files that can't be
 replaced
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
Message-Id: <20261124-work-exec-update_lock-v1-5-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TCu0Afse6zxwaqsM5MKt1enhe1sRx5apMR0b/GxRpJo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzie02NNi+8c483o4E8+/B6jW3rr7Trn3++k+o6Eeju
 nal15laHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5kcvwh59P//HztS8EZL3+
 G55I/Wl6JehfoE2aCLcsy5rbUk/YjRh+MQend/Fkpq3bFT2vPFTqyqk45/D5E4PvFHVs9tt1e3s
 xMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When an exec transitions to a new SID flush_unauthorized_files()
replaces the inherited files the new SID isn't allowed to use with the
null device. It uses replace_fd() for that and ignores the return value.

replace_fd() refuses a file descriptor at or above RLIMIT_NOFILE. And a
task can lower its own soft limit as it likes. So a task that sets
RLIMIT_NOFILE to the number of a file descriptor right before the exec
keeps that file open in the new image:

	fd = open(path, O_RDONLY);	/* 3 */
	getrlimit(RLIMIT_NOFILE, &rl);
	rl.rlim_cur = fd;
	setrlimit(RLIMIT_NOFILE, &rl);
	execve(...);

The new SID still can't read from the file as that is checked again on
every use. But it holds on to the file and what isn't checked on use
like lseek() works.

Before commit ee97cd872d08 ("switch flush_unauthorized_files() to
replace_fd()") the file was closed first and stayed closed if its file
descriptor couldn't be allocated again. So close the file if it can't be
replaced.

Fixes: ee97cd872d08 ("switch flush_unauthorized_files() to replace_fd()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/selinux/hooks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9950f89dfaa23..4ec9ec723cacc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2521,7 +2521,9 @@ static inline void flush_unauthorized_files(const struct cred *cred,
 		devnull = NULL;
 	/* replace all the matching ones with this */
 	do {
-		replace_fd(n - 1, devnull, 0);
+		/* replace_fd() fails for an fd at or above RLIMIT_NOFILE. */
+		if (replace_fd(n - 1, devnull, 0) < 0)
+			close_fd(n - 1);
 	} while ((n = iterate_fd(files, n, match_file, cred)) != 0);
 	if (devnull)
 		fput(devnull);

-- 
2.53.0

