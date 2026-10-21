Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594966;
	b=kJaP225b5zzegzs9gJPuft35PgDa+7ljPgeBeTMkdlYtOtKlvBeKrPIwaSE57mBYtmBx
	 1dtNIfZA/py519WQZvFW/nfBlgWx/BMHVIoGAJyWnvN8XuWl72LZ162FBSGXjFnYBiyZi
	 QL6fMx72p2aogFhPa8VCjzD014k1T2YOlBp27pk1XUkpYsyv6lOgGvXEFyQJs7CCxCVT2
	 fy6X4A5/TepsioBQ7dnP0qwk/8axKH4DROEtthdwVIzeZDt04BtsZzZMH9DK/VwvDlWzo
	 yRf5AfX9gWRfNKu4TBEdbsK0NFIRZABw2sc4AWtJ9hlztnbXYNATSMEuF3/Ws1Amh8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594966;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yJ5YprPTJ68DgfM8C9L3paKZUPJuHYoa+o08Rb8GIMM=;
	b=ScF99XiX3Ld/7wRL6bcPNHIzG0iEE6ahD47ZWozpBjPp3dzZAj0ba91VHdzat+nbIglz
	 dnnYvo+nRL8d4q9xYPapKq+nHFk0obsXcrM4gRivPa/PuzjywPmYTUQnpZWFb66E2DH72
	 SUusiEY80S7HnRD+iLjmj+Ib9aT3dfkKClpTS3WH50SCp4gYkSPUv/6grnIykG2DuGiyT
	 wKlJbV/fFrvXIk4FWUh0y2pugOZ3iWDZ0wxgb9LHhSINbCTTRUMcPDtyQEouUzIRtAcT4
	 E4NYCSqSyZQ/QLXNwneY17FJ9NESlvbWVGizS+j221gaRfT30qB2H6kOhBHIwNe8AmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZRcq7Asy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09184606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZRcq7Asy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614B81F000C1;
	Wed, 21 Oct 2026 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594965;
	bh=yJ5YprPTJ68DgfM8C9L3paKZUPJuHYoa+o08Rb8GIMM=;
	h=Subject:To:Cc:From:Date;
	b=ZRcq7AsypRnUJ6A0jdPpAVuAHiOgmyxUkSAP6AeUtCNDTqHjDldCMhnU1Qu578SHN
	 SCdh0acR0pVkMzh/rBP0WFWRznFpdLAEO7eXM9Y9lKvNb6b1cr9TO9aHRJLk+8SG21
	 y4jOIHnl3UscD4zsnjeo9t2YHDaGwsZy+FmILd7M=
Subject: FAILED: patch "[PATCH] tracing: Fix ignored return value of" failed to apply to 6.18-stable tree
To: d.kandybka@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:51:26 +0200
Message-ID: <2026102126-obtuse-trimness-c3cc@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3110d09bb98e3ac66482a7b257548a1683ec6c1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102126-obtuse-trimness-c3cc@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

