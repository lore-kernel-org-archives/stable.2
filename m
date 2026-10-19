Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422701;
	b=uo/G4wgNCvf/f/kQx1bMH7H+WZyOnWiVycTv1FQeDnIakjDnqFMjjV8V4cOTiaXnthOh
	 HHcV+47tEPCU5+IZ2TWobz2LsxXRNVjCTgmCoYi6Omc5fiUCPlMzFIl9c40De4c5EuA09
	 wN26xS6MXLpJBesMxbpW1Obop7hQgz6blKvmYCYPr128oQOc0+R6sh2nTxT912bY6gYQG
	 Fl9lFWu8nBAFc/Q8gvf8/JvJkmLHxU42+yOOCawQwrvvk+HZTt/MIO0wWRzC9a01cr506
	 yX88IqogKdK5iUdFLqd6UTw/vo5u/AnIFKES6jmejk4gh4azGAaPT2b3MWmEr6x9ieQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422701;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=JJE1dWAygf8nl4PgqDMAG+QEQkNU/QULVJ9fb4tJWSw=;
	b=ykfyC6UQfsXmVu9sEFFRB9PpDzg31187vJ5WRGZIx2kjVK3v/mhfflSp/tZBZuPecdSu
	 L7tfr3ZhwvOIldXVeoJsARCDZNvAE01sPA3lyi/fm/o1oHVSvm09LDUK1CRm2fXGpS/b9
	 m06CN/I2sNJI4KRQ4VdoJjiK1ZbdJ4dd6vMObZmWSmJsBh7Vexo+IaE9TqnloZ9SAlOeY
	 bHBkXasvxvF6yLv9wZdHfGmzT97K6XAdLyIoId6AC02VSB1QfhbRAUoh/oX/ICEz6APjV
	 JpZcOvrqgUj5/hC152H4VgQDxSht4yR68skbB/0zZ5XfKT+n4vqFIMvLvdNkdkGVUAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="N/Eb+x1a";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA56097793
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89EA56097793
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=N/Eb+x1a
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1E5384E41223;
	Mon, 19 Oct 2026 15:11:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE94060582;
	Mon, 19 Oct 2026 15:11:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF2AA10328C5E;
	Mon, 19 Oct 2026 17:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792422685; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=JJE1dWAygf8nl4PgqDMAG+QEQkNU/QULVJ9fb4tJWSw=;
	b=N/Eb+x1aOYztT0zGdoIXBf6HCP/w5dSkuBILx+bu4vuY8J0zaAqKhrNgMtJ7E2VJp4WfIg
	OTA20JuqDS0N5RZecvSEIAs7LK1ZFca231hdbNsfkGFFSMgYWeRK4VyJnOEsPiLjD53N2E
	12odEWFvh3sme2FQcvHt5xY2OchZ/Rn25ztp+xy/tADO39TwEMMVZRTlipX4ihz2aopXyr
	jF3wAzM8c+dIsQmud9EQ6sZdlN/LrV/832kDwwLgCRTF1qqZDOFs7QdFd9EM7qz3S08yz9
	GtzHKGYISbImSUuighfZ+jgzzszsj161URjR+wulgKKg/tUbsufV3kJ0dyGxDg==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 19 Oct 2026 17:11:17 +0200
Subject: [PATCH 5.15.y] bpf: fix potential 32-bit overflow when accessing
 ARRAY map element
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
Message-Id: <20261019-cve-2022-50167-v1-1-965ab366b9b6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3ZJd2Mx9VWMB2gXXQ9oWiUSw
 rtb9fhNMv+Kotm04NisyDpbsftUwbsG8dpPFyVL1RAnHTsOFGelCiHvuDtQEM8phH0vY0I9PbK
 O9v4FT/At+3bB+b+X13DT+PzWsG0fWUiYEHoAAAA=
X-Change-ID: 20261019-cve-2022-50167-9251d994a2fd
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792422684; l=3971;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=MXEoCqk8FuRDWidmahOOmvENdX5qV6UtkBCW57A1RwQ=;
 b=y5vwRU5gl9H9tysZw8eNu1Dg1PkNsVHvafnJwPWzJIN2JM93keXxc9/oatidbifvVbrj678d2
 1dt3FZ3EvfkCmmEYnUU/K7ULVrrVmzbXj0wNMxycq6eL7y/o7yUrAQK
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 87ac0d600943994444e24382a87aa19acc4cd3d4 ]

If BPF array map is bigger than 4GB, element pointer calculation can
overflow because both index and elem_size are u32. Fix this everywhere
by forcing 64-bit multiplication. Extract this formula into separate
small helper and use it consistently in various places.

Speculative-preventing formula utilizing index_mask trick is left as is,
but explicit u64 casts are added in both places.

Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init()")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20220715053146.1291891-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 kernel/bpf/arraymap.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index dc42970dda97..a13a270c9aa2 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -158,6 +158,11 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	return &array->map;
 }
 
+static void *array_map_elem_ptr(struct bpf_array* array, u32 index)
+{
+	return array->value + (u64)array->elem_size * index;
+}
+
 /* Called from syscall or from eBPF program */
 static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 {
@@ -167,7 +172,7 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 	if (unlikely(index >= array->map.max_entries))
 		return NULL;
 
-	return array->value + array->elem_size * (index & array->index_mask);
+	return array->value + (u64)array->elem_size * (index & array->index_mask);
 }
 
 static int array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
@@ -325,7 +330,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 		       value, map->value_size);
 	} else {
 		val = array->value +
-			array->elem_size * (index & array->index_mask);
+			(u64)array->elem_size * (index & array->index_mask);
 		if (map_flags & BPF_F_LOCK)
 			copy_map_value_locked(map, val, value, false);
 		else
@@ -393,8 +398,7 @@ static void array_map_free_timers(struct bpf_map *map)
 		return;
 
 	for (i = 0; i < array->map.max_entries; i++)
-		bpf_timer_cancel_and_free(array->value + array->elem_size * i +
-					  map->timer_off);
+		bpf_timer_cancel_and_free(array_map_elem_ptr(array, i) + map->timer_off);
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
@@ -534,7 +538,7 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
 	       return array->pptrs[index];
-	return array->value + array->elem_size * index;
+	return array_map_elem_ptr(array, index);
 }
 
 static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -553,7 +557,7 @@ static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
 	       return array->pptrs[index];
-	return array->value + array->elem_size * index;
+	return array_map_elem_ptr(array, index);
 }
 
 static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
@@ -674,7 +678,7 @@ static int bpf_for_each_array_elem(struct bpf_map *map, void *callback_fn,
 		if (is_percpu)
 			val = this_cpu_ptr(array->pptrs[i]);
 		else
-			val = array->value + array->elem_size * i;
+			val = array_map_elem_ptr(array, i);
 		num_elems++;
 		key = i;
 		ret = BPF_CAST_CALL(callback_fn)((u64)(long)map,

---
base-commit: 792fbe1537d8daeca9bd1917e84078b5432aadc2
change-id: 20261019-cve-2022-50167-9251d994a2fd

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

