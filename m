Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676568;
	b=eRGl3mVlYNz1RuURimOsQo36I93U4FvZiCBREyVS0Z39XgK3FRnijTwB5cwBwpK5MHpy
	 m6oh/4svq3SisGbiiWjl8zcrmgDlnskoD5bgTQgrDvZ+KVKrl27O39gMnVvQMpS9iMWbT
	 TCNQWR6kDOxBJOx/00vypeGcq/g3BkO3MRSw7myP6O1qz2ATKrNsxInte3qBUfJ+fnqS9
	 p534FKCVc97mEFbhFHKMIPkjy6UpI7ZVTS+s8iQNu+HRb6aIIOTbABKzBfTcEfzYoDgCq
	 Gp2EMTXObbyk65oZ3lxLBEQGQ5XACUu7cuXXRBHZqsrQrnYHSJDhGUJIUvwL7tscUSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SG1gtgLA49fft/gVuZfk+j/Kbs2KU1QCOtsrMpJvXoY=;
	b=gsaEsd3UHagCEvvTiSPbWmVIWKDS926DvaoQ9AWNigCb4FXiSil8Pxv3P5JboboyRB9b
	 kNPqTWSQyx1aOdbIUdjXE0ACoGf57fOg7Q3A4rvaSTV4qMQWW0dTChZZMBobK+DhLGeYY
	 r+EaIjYS7mkD7FwGEoZ9hx5Q2TthAFcjNbOh0x4+/SlBYVwr+A+shqdtYHiIHkeX6CM1e
	 GGEBbJugH4Lzr+H2d3hFEUoien6eBcfm3Galbau1ozYrh/Rl4+ZxD8DvUPPgmb96ikzf0
	 KlM7MpjO7HTl2MJi/2nu90Y6++mK5mCOp98jAOmHXBNIUkU8S1e7DdIFwsGDisSL8CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYrKiW3O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D160A2626
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYrKiW3O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90A61F000C1;
	Thu, 22 Oct 2026 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676568;
	bh=SG1gtgLA49fft/gVuZfk+j/Kbs2KU1QCOtsrMpJvXoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QYrKiW3O7ge1/0+id5pERTtYxG7Ug/hlnA+L08BpIyj05sgGEE9PVvxVYXX4VqPvu
	 NErt8chcOejEgXaksH9FEiBxQi/ZXW5B+OlxcOiWtOcFYvZD5jeP/jHcIu9DPQnPEa
	 vDnNk9rxZIfZrLw77UbyAt5QLb/vDYEYhhlLwmdlv3T9nN3w5OCBoTiPknxwgmDvqr
	 v0Zr+MFN3WUAOPYhs847iAOlWVWAZHtGxhNzo5w19F4OMETilBDcsq12KqTm+5w98a
	 p2lVN73QEriiCUL6s6vnA7iMotOrMv6rzW/cOpkpfJJBjbE3yHQr2KnkD4RkQkjLCK
	 pKppCIlvGN/fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tracing: Fix ignored return value of resize_buffer_duplicate_size()
Date: Thu, 22 Oct 2026 09:42:46 -0400
Message-ID: <20261022134231.1442323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102126-handsfree-shove-984d@gregkh>
References: <2026102126-handsfree-shove-984d@gregkh>
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

From: Dmitry Kandybka <d.kandybka@gmail.com>

[ Upstream commit 3110d09bb98e3ac66482a7b257548a1683ec6c1a ]

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
[ sashal: Adapted the resize call to use max_buffer instead of snapshot_buffer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7936e8cd7811e..2816708932d6a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7275,9 +7275,12 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
 			return -EINVAL;
 #endif
-		if (tr->allocated_snapshot)
+		if (tr->allocated_snapshot) {
 			ret = resize_buffer_duplicate_size(&tr->max_buffer,
 					&tr->array_buffer, iter->cpu_file);
+			if (ret < 0)
+				return ret;
+		}
 
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)
-- 
2.53.0

