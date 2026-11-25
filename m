Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637123;
	b=U2i7oMQRj2sgdDkgHSHLvP0xE56KhA26kbVmE2QH/FiOPhB3KuYeypdnDU6Z1Hnm5Y/r
	 kG0FyKiPSTdQLp624N8Vy5qm1RsyK41x8xtbXNL5rn6YGzz1fqGsDFeu/BJXzTfPdAgBr
	 5yIJpDV7VOp1Tqss9HXLVFmJwL1vCuc3rxwPfmXeDCKQuzvJoShdnfxW5LAPTDJUuLwvc
	 xdPUdX6etmpEafQpebePyR4usM1aFWQ2tFgMHk1bC7d5rhJgPFuhWFZHIcxQxxdOV/XIU
	 8q2b4reMX4kIgRcmlslpBqxSJtwBgJB7AXjcamTrlafSh5UPMAvHBfgqhbhpKrzyxvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LnX4BLL/owJ/6QqdK2L5YNPZH34dzDNwk3WUAyF4Kmk=;
	b=eukfIVekpmbZDPW4jHVDuR4YegyQeReveLhlfJ+x8+cNejoovZ45fGNSN16VObvi+FpH
	 Ff4xOJUrrtFPXiU1RCvxGx/HrhsA6fNpK1FyjpQTSdF/TqmRYGVKVB0gQIu3zlUJDyrFo
	 WRJQnoy/O8OKTW1S7qkhwP/Yrq9BB/IC7QVloRU2zuUncZlH5mjT8jXqi8yLRnm/1X1AC
	 R0lyPyX/ouCc5jJLSnC9BJcWM63JQdSjLqZvePoiNiJ/40ngeTE3Pc0CGuMjKE6U8y9X+
	 Zjvy8s832lSWHNCqmSy0trWPg/T3S9ZgxxHzDH7plZPVHtEUE6QFB2CF175cH+Qbwkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fRNkBP/v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4524606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRNkBP/v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1B51F000CA;
	Wed, 25 Nov 2026 20:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795637123;
	bh=LnX4BLL/owJ/6QqdK2L5YNPZH34dzDNwk3WUAyF4Kmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fRNkBP/vI+bIBWwTQLg4pWlRgfD6hggCPi5Vxo8E2kKu68v4Z9Ccl4Fk1eYv9iLi+
	 1cz3M/d/vQ7IJuQn/LgfsFat4HsL25bs3+6euJ+0WyJhpfTadJwAPf8HoBfdAXNKPs
	 n3LCoktrIFR6tzVzUn16mdBXA2qYEjn5vd7oJLqXyMHZv8RKa6hUJbNFqIOvNnCb+3
	 ArRwaph7iRWPRfO12snbC6oYLcqEF4ZBAPyC5Si2HN407ZCYRUGmy00CpaZObViS07
	 vh6CQqGNhM1GQvnKw/zxgHO5RzyYkhNob0PxRmGPrhdhwXs5BB69xLwbkh8hS8wVxp
	 fwRCUPjs5G/Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tracing/probes: Fix missing BTF kind checks in char pointer/array helpers
Date: Wed, 25 Nov 2026 15:05:21 -0500
Message-ID: <20261125200448.1372860-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112532-gone-canine-62be@gregkh>
References: <2026112532-gone-canine-62be@gregkh>
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit c1e2c63e65421068566db3dde44dfd4fe7adb46d ]

In struct btf_type, the type ID and byte size share a union, and only
BTF_KIND_INT types are followed by a 32-bit integer encoding word.
Because btf_type_is_char_ptr() and btf_type_is_char_array() do not
verify that the outer type is BTF_KIND_PTR or that the resolved element
type is a non-NULL BTF_KIND_INT before inspecting it, non-pointer BTF
types can have their byte size misinterpreted as a BTF type ID, and
arrays of non-integer types read out-of-bounds or misinterpret trailing
BTF metadata as BTF_INT_* encoding bits.

Validate the BTF type kinds and NULL pointers before reading inner type
metadata in both helpers.

Link: https://lore.kernel.org/all/179455851632.403392.258264246782960594.stgit@devnote2/

Fixes: 27973e5c64b9 ("tracing/probes: Add string type check with BTF")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ sashal: Adapted btf_type_is_char_ptr/array hunks to the older code, which passes a &tid argument to btf_type_skip_modifiers() instead of NULL. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4265518ce967c..1a0e03dc59c07 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -325,6 +325,9 @@ static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
 	u32 intdata;
 	s32 tid;
 
+	if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR)
+		return false;
+
 	real_type = btf_type_skip_modifiers(btf, type->type, &tid);
 	if (!real_type)
 		return false;
@@ -350,6 +353,11 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 	array = (const struct btf_array *)(type + 1);
 
 	real_type = btf_type_skip_modifiers(btf, array->type, &tid);
+	if (!real_type)
+		return false;
+
+	if (BTF_INFO_KIND(real_type->info) != BTF_KIND_INT)
+		return false;
 
 	intdata = btf_type_int(real_type);
 	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
-- 
2.53.0

