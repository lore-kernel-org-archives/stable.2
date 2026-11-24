Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530626;
	b=khBGqJqdKpfjlyJRcyRjzqAGn2RSZYGL+zPrZn8ZlVF4pNy7lrNPnWvOjwlJqwaL6p6g
	 /D0yComHa1SBnPE6t3ckW/VTi8d3gH31Xy0tvISQEwbp8f2tgc0uZ6+3jVr8beCLOTCqv
	 DFbuf7+2rbD5VrLVqtNF+Ni4iYIozLiCRLo8e48qa39LX1qzP1FE0s5LqKFOn14C2+c3G
	 VBw9MkdagCbbPEU9PTeShVPkATdeWLFBlpLG7SubzyBp01/51nCGQyQsk/0w7Aq5L4eVQ
	 ECfyO7soZ9CZzJPzsoOlusfv1gErwa+cGqRmw/yqNdRm0C8CfC6NF+9r8HDye+m4WHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8k2Tkr44sGYSlrclTUYcdahKEXL+u5o0bkcorvRLgxc=;
	b=ES5uYi9OC+1JzvqLgwEzwzh4Jl84v98Vfyabtd+a2vqaaO5tYN+rV3bn7yqLsLjL67SG
	 5KvwuJAkca3Kq+6A/zM7xB/2JLEeYz0jD8vDNOX5JlASUIrp2hIKvI9HziKVDyfRvpU4N
	 OO2n2RajILZqLu7ce0xLxzAahqmiz/0S19TMYO8YJJbSsfgHlry3hYTroNOLI2p9i67Ll
	 ky2LOcJ9G5a80ipeVF5kcHeAkdsWCYeZpBcUctTGCiu9XsQljMtuZVP1l2yBnisY5HPA6
	 7d7+x87hFwMS+Ka4pNXA9g1DtkeTxrxjzjI7GQ4+KMLqQ9YJM+Tz5rkKNz5f5647Dcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apiz6wgp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691F606A31E;
	Tue, 24 Nov 2026 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apiz6wgp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF611F000E0;
	Tue, 24 Nov 2026 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795530625;
	bh=8k2Tkr44sGYSlrclTUYcdahKEXL+u5o0bkcorvRLgxc=;
	h=From:To:Cc:Subject:Date;
	b=apiz6wgpM7XTWsyteqZcEtKk8FR4uGWTFhx+/RoaG00UMZt2pcwFHoUsCLbjZzOQ4
	 Xd2rgP4T+RRL+nSu2YzSMf2497DycGqn1hroAU+DJv8xo1neRSle/OyQ3dTaXDZT1V
	 bhuCvf0aYGou1int4PcD4DPGeC130+rNpl2px6wArbwtxKRo8d7S0mQDAF3/RrbYHl
	 0m64rMTkHbuuhsPOIIlQkDdkehBundMp1jWKJKAiJP2kUMpeVXtKLbLMcTV2NcRjB2
	 CP6v5lMXzfnUYgDXr4wLq4VQZZp2QWO3tTBwZjmL/NMfEwJcglNOA1ZpbTj0aWIAgC
	 cvCvOVY9r+EEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Iulian Vaideanu <iulian.vaideanu@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	regressions@lists.linux.dev,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6.12.y] fs: move FMODE_NONOTIFY back to bit 26
Date: Tue, 24 Nov 2026 09:30:22 -0500
Message-ID: <20261124143022.3509525-1-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

The backport of commit a94204f4d48e ("fsnotify: opt-in for permission
events at file open time") moved FMODE_NONOTIFY to bit 25, which is
__O_TMPFILE on sparc. 6.12.y still passes FMODE_NONOTIFY in open flags, so
the BUILD_BUG_ON() in fcntl_init() has broken sparc builds since v6.12.105.

Swap it with FMODE_NONOTIFY_PERM, which never ends up in open flags.

Upstream avoided this with commit ebe559609d78 ("fs: get rid of
__FMODE_NONOTIFY kludge"), but overlayfs in 6.12.y still uses
__FMODE_NONOTIFY.

Fixes: 07ee6057f92a ("fsnotify: opt-in for permission events at file open time")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/7701ab76-4761-4596-b6a5-92c74e03ce5f@roeck-us.net/
Reported-by: Iulian Vaideanu <iulian.vaideanu@gmail.com>
Closes: https://lore.kernel.org/all/CAPK=yVMe1Ro=aw_daLCOM9cBATsp6crdgB4wd0ty4vrnxtVKkQ@mail.gmail.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 67b57ce46b203..d696a21b69ee2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -178,13 +178,13 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
  * Together with FMODE_NONOTIFY_PERM defines which fsnotify events shouldn't be
  * generated (see below)
  */
-#define FMODE_NONOTIFY		((__force fmode_t)(1 << 25))
+#define FMODE_NONOTIFY		((__force fmode_t)(1 << 26))
 
 /*
  * Together with FMODE_NONOTIFY defines which fsnotify events shouldn't be
  * generated (see below)
  */
-#define FMODE_NONOTIFY_PERM	((__force fmode_t)(1 << 26))
+#define FMODE_NONOTIFY_PERM	((__force fmode_t)(1 << 25))
 
 /* File is capable of returning -EAGAIN if I/O will block */
 #define FMODE_NOWAIT		((__force fmode_t)(1 << 27))

base-commit: e2e4b92c2b2a3ae78423cb343951cb5d2241b405
-- 
2.53.0

