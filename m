Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594963;
	b=OvTAqegZr+JFkXKArKKO5dGc9bGZ+VaMlEliwwtdbSzSvHEh0fSXXR6ty6vS25bXa4X5
	 aN3//f0IEoOqvS9r/kWOR6wUgzUzZKL4PgSFyoCxaLvglzaG2oHRtyTkf6KbQg29uS4Io
	 18dlZLDZLACtH6NykUCpHeSeWqgz0nln4wW3L2J4fnSe4OVRoGzmg8n50W/x+Yzxusd+y
	 Xy0+DNgN4TWUG5DXzZWXfnxR96qSt+FN2MsiwgrXy5zniu/e+CWuC8rD/jTMQhTnNxDac
	 seBCjbQu/gPykT2KCyC0Agdin+51k6ODZXi9Um7IQFM3WV0ahXzv4doJ81TmeXAdAtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594963;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kMT88WsIgT2NaxKCkFeoLFCmMtm8Iwta6tRBuTeJ8U4=;
	b=H/+8AeWIhXQM3o/+nQCUj8ZOcs6EJT/Gs/3MtUh/a/4IxvIpqE+9RBrYobIFUs52CjGd
	 uu9D7sZ+6jYPcxOYv6LykaFp/p9Ed95Lm+HtUw9y9FB1WgLWPQaj1apPmeq733WZiFNGM
	 /2wfVvmUR/isTYOQsqAKqJXZ6iePt74C0tlgm2PmYxQwnYr2yUln8gg8jEz5JleKbWXmk
	 3qY7YuhK5wERXH1h5YWmgvRuYZfWyLE/3hUQKdjf40RnG0CKMmODkF/3VKEIVL4K7UXoA
	 i2CmM/e0bhudrza+g0TG+7mlRniJVD2vyEtZssIoJ8QsbhyRV4Exf+EldgQb3GOD4gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KOnCQQO9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED55606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KOnCQQO9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FAC1F000C2;
	Wed, 21 Oct 2026 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594963;
	bh=kMT88WsIgT2NaxKCkFeoLFCmMtm8Iwta6tRBuTeJ8U4=;
	h=Subject:To:Cc:From:Date;
	b=KOnCQQO94ErPz0NNS0Dtc52HsxBehmmRza4nntcYf61GEZfcyATVzL4CVRk7x7Fw2
	 tTha2LxL2zUfxVF6R8ygr5gipnoW7rx5W3lsmNVwIEGzblQ+uKpwUG1xBUbcb3sKeu
	 LtoEdp/8QeDZieQEbPtsLweHDd3vDdEIrdl66ec8=
Subject: FAILED: patch "[PATCH] tracing: Fix ignored return value of" failed to apply to 6.12-stable tree
To: d.kandybka@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:51:26 +0200
Message-ID: <2026102126-handsfree-shove-984d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3110d09bb98e3ac66482a7b257548a1683ec6c1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102126-handsfree-shove-984d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3110d09bb98e3ac66482a7b257548a1683ec6c1a Mon Sep 17 00:00:00 2001
From: Dmitry Kandybka <d.kandybka@gmail.com>
Date: Mon, 28 Sep 2026 18:26:32 +0300
Subject: [PATCH] tracing: Fix ignored return value of
 resize_buffer_duplicate_size()

When tr->allocated_snapshot is true, resize_buffer_duplicate_size() is
called to update the snapshot buffer size. However, its return value was
not checked. In case of a failed resize this could lead next snapshot
being incomplete.

Add resize_buffer_duplicate_size() result check and return error if
resize fails.

Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260928152634.4354-1-d.kandybka@gmail.com
Fixes: 180e4e390978 ("tracing: Add snapshot refcount")
Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
index 07b43c9863a2..4731ef7325a5 100644
--- a/kernel/trace/trace_snapshot.c
+++ b/kernel/trace/trace_snapshot.c
@@ -675,9 +675,12 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
 			return -EINVAL;
 #endif
-		if (tr->allocated_snapshot)
+		if (tr->allocated_snapshot) {
 			ret = resize_buffer_duplicate_size(&tr->snapshot_buffer,
 					&tr->array_buffer, iter->cpu_file);
+			if (ret < 0)
+				return ret;
+		}
 
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)

