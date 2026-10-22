Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673677;
	b=QeACuS7Q/lG/4wGYRd64bSLUNXqwJjBDj08FsE+Pis1fu5qtwNXkWmPu4iAX6/GxWE46
	 io1mUMIMiMApF3fYrH4D+6y02WPaoT3E31CcSGyG58enZCgM+KOrzMyKEi5B5L8qaXBaM
	 olNvEl8LeZ5wLrdvC87Ju8IxHFWjfaJGZaAM0PKO4aUucQgDmaILTHo84dvyJxiTTz3RC
	 I602QyxDTJ4ktoYGeDc6UW42chCkMBz4zDPbLRkVmJPL2DAo1xWFkJ4ez0rKT/zsaXM/+
	 5Vl8dRwmdaEjlml1qL9N3hYXCwRNfqLjOiLWvLtFZFdp0Wcel7kRh9NviHvfODxgCjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673677;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CKnXYw7CqRqUICdsSU9pAq4INLTtlLUy4oc9EETE4ss=;
	b=aAyR9T0D8M9fpDjp2KUDobiIQxlKe1QvYS8Px61p/cKPRq3oe88VbiUls4hDhSof2bba
	 naDv277l1Q1SFBAg638MQQi2pG/gqqntQ4q+jkyUhnggNO8m9pAfHtkVROr9+zndcwQUK
	 iA8ImG1mjA3LjDGqlhdq1EkvwjcsEfPeIhcCT+SFzWsgy7bZzMl1WJLDQaq8P2k84dLz2
	 eo1NC+T1AW8popIXH+b6E8ffpWscxNg4VRCigmC7sxIAVuzt8P5QSSVClCHkOrCMfhjpm
	 tudB93T84IQmpIGhxr7Afh9tsi18SUBKRCcSKYXr7QRjS9LX1MQlreW/v9GIm0bvNuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQelt0nl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2203606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQelt0nl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1930F1F000C2;
	Thu, 22 Oct 2026 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673676;
	bh=CKnXYw7CqRqUICdsSU9pAq4INLTtlLUy4oc9EETE4ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQelt0nl7+whT2iWJbbfPBWTgupdAVwjKuOI3Je3OeSHn6wIqI4QNH0Z3smcIYeRE
	 ihjOL2MM4Mo8n7+Abt2csESy8Uk1ESVav3Rg4S20vrE2LmutuFUe8cR+o3xDhRjrXM
	 KpmEsjYleTHpFta3BAO1qqL0UBSwaBE4JIgzxkj2UYuPgWrZddrKIAk8He1o4w52Se
	 ua/fpGm6+sOueM/6igeE8ZKvOCZV+swtozQa+7BIG+xrR3SsBnsy4Bpb9NcV7mB7ao
	 lk/x9ItdMaTSuolaboqC/Nm6RJhi5a04I5Tub/rnhhhZ4PS+t+ltrxTwYkITzS37yP
	 4NTZqxil3jUAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] tracing: Fix ignored return value of resize_buffer_duplicate_size()
Date: Thu, 22 Oct 2026 08:54:34 -0400
Message-ID: <20261022125420.1194013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102126-obtuse-trimness-c3cc@gregkh>
References: <2026102126-obtuse-trimness-c3cc@gregkh>
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
[ sashal: Adapted snapshot_buffer access to max_buffer in the existing snapshot handler. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 45b24fe040ad8..a76743475e9f4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7811,9 +7811,12 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
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

