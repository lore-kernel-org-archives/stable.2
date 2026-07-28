Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F623C3F58
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223527; cv=none; b=e6m7gKUEupt5rXdmyPJA3RszJYPGMMmpUvvvLkHnzcM9AQZDrzI9qhKA/iyLOkvkpiuDw0lA3i5oE18nDq9UXD/8u5VqXHwuUP20jZFp9Kdoa4jHqylUSmbKS8ALsuJ+ukNfek41wsX6gbQgPzHIwnWnnabExdzkRgjdmitD154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223527; c=relaxed/simple;
	bh=TwUKmfDwikIUrbYKY/w+2ET/fAt32bHu/jjK5NTWhCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmHo8gLMC5AFjVe7JswNN83yF42NxJQcAtLTJ0mHmKDQgGq++iKNxKwXwP4hoCe5GbFdNMzbQ3BTUgVvO/MCkOhM2qyx+U9Kg3nWqTh6CSTjH2ucgSJtfN3jH2vM9xqh9Q09Q8NbaZL/tJTiT5XUGDilypl+jEmEVfjfAYWJzak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eA2pND4n; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eA2pND4n"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15ef474e72so196461566b.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785223524; x=1785828324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOrUbsueUGdhBndebSakH36gIJMoeUOFLJteGze8ArY=;
        b=eA2pND4nOc3bP78//DMvOyQLuaCwXlOYxzyKV2oaxe4f0VHBOhe50ET9DpoVSLUFvU
         VRlnNAe14QzUL+heRgniy+oIXcavxXeahsXEE7WE8ruMDsKEAoLvtv5bIKf9+4UymHCw
         Q3hkZeVS+fEmcll6gzfdSlk5NEYI8PFZPELJMfBW/kVrsfpnmQN8XgnccnauI+lAMg9a
         TO03+LGmYrKY5goM4pydKf8h0usGcQQNanzd42NTiBGpaZJBSdEnVtTbUSRjLFjffEls
         4ahnA+ab/sxTwZJ1p/oRmeXshikZEAPrRSPqUyzFGle6oanaIqzawQi44wkL1iXCrlOh
         HWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785223524; x=1785828324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mOrUbsueUGdhBndebSakH36gIJMoeUOFLJteGze8ArY=;
        b=hApeYPz64UtwSKeIafBlmG3B0vScaSK0vb3bXqwAMSg8obHvEm1m/5/PYRBSTL0NGB
         cE2UHooqLFJlFyhgKPg4b1I14mwKCkU0Rip43UfOV+66xG7hJjm6Y6amIgU58xv3CJwK
         UYZKq6gG/w9pcyhgwcklW6t5UnFHQJ4KEeIIud9XXGwoHK8ETVSSgqz4eNnk31SqN0HS
         8CSWMizY/OAPvV/+dA92OsAsnrHq8QgsXs7G5eMn3K4EqQeel8D+Izfua1fL0cJEYNvQ
         Es6+XGeYYeUx2DHADIM37ewAnmY+f7tjBJGNixp42HZt9QZuN+z4gI+1gMrra+cWKSNn
         YGrQ==
X-Gm-Message-State: AOJu0YyHTlBs3Wasy5CDX/u38den0bIRhr1YpWjLhMqM2pBVzFTDU6zg
	ILrzEdgHSWT9ZgA6jkGmyW04GpMgVEvGZMjvwhEC7G0wqsQb4MXpEOScGynwKwZvcpS0mv9yJGM
	LIh5jS6OBLlL+
X-Gm-Gg: AR+sD13FOrIOAX20eCN9GxrsGzskRdWS2MtJTUTFc74VjqHIEkxpRZyfkeShcxo8H/4
	UofHR3Cpz6huleHB51xlsEuUDPLy8MRojpyRzFYC0RqOCCyZCkHUgK8F2jlhTZAsGg9JxiwQIkn
	0mrxCN3g+S0Ml8Kbwhs02G4gMzQuddETR3IdpLPF8Dq323lVRbodKxRQFr1HLJ1amYES99jaNyk
	QVDO3PmdkmOZBnsxjbB9pj1PzADnvI6dTSs+mR3CcGS4qLvmidgnhp3yWT0k8tQfWRwQgQwaNC1
	iuJGw1Kps2qZ3/htVyIdwS9fDjlQ9t0qA/n9ztpd2r/eyhJ5vpON6rzhXYbuF6ykdugVtM6KjuL
	8M+PABEnvdIf13VCniIgZKuS1AIFEFe+D2Noql9sNoSWWO6at61bWM01d9DcQyhly7DzsPA3TM4
	KALSf3NTt25/W9mb1LIZNeZfT+J7Q/Yh8=
X-Received: by 2002:a17:907:d303:b0:c1f:13ec:bcbf with SMTP id a640c23a62f3a-c1f72177efemr47645866b.44.1785223523485;
        Tue, 28 Jul 2026 00:25:23 -0700 (PDT)
Received: from localhost (27-53-136-186.adsl.fetnet.net. [27.53.136.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53254f1asm4045788b3a.6.2026.07.28.00.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:25:22 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 7.1 6.18 1/2] selftests/bpf: Adjust verifier_map_ptr for the map's excl field
Date: Tue, 28 Jul 2026 15:25:08 +0800
Message-ID: <20260728072512.33620-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728072512.33620-1-shung-hsi.yu@suse.com>
References: <20260728072512.33620-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: KP Singh <kpsingh@kernel.org>

commit 38498c0ebacd54dbaac3513a548a13f1a8455c4e upstream.

Adding the u32 excl field at offset 32 of struct bpf_map right after the
sha[SHA256_DIGEST_SIZE] hash shifts the ops pointer from offset 32 to 40.
Therefore, fix up the test case.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_map_ptr
  [...]
  #637/1   verifier_map_ptr/bpf_map_ptr: read with negative offset rejected:OK
  #637/2   verifier_map_ptr/bpf_map_ptr: read with negative offset rejected @unpriv:OK
  #637/3   verifier_map_ptr/bpf_map_ptr: write rejected:OK
  #637/4   verifier_map_ptr/bpf_map_ptr: write rejected @unpriv:OK
  #637/5   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected:OK
  #637/6   verifier_map_ptr/bpf_map_ptr: read non-existent field rejected @unpriv:OK
  #637/7   verifier_map_ptr/bpf_map_ptr: read ops field accepted:OK
  #637/8   verifier_map_ptr/bpf_map_ptr: read ops field accepted @unpriv:OK
  [...]
  Summary: 2/18 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260601150248.394863-7-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/progs/verifier_map_ptr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index e2767d27d8aa..d8e822d1a8ba 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -70,13 +70,15 @@ __naked void bpf_map_ptr_write_rejected(void)
 	: __clobber_all);
 }
 
-/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, accessing
- * into this array is valid. The opts field is now at offset 33.
+/*
+ * struct bpf_map starts with the SHA256 hash sha[32] at offset 0 (a readable
+ * byte array), followed by the u32 excl field at offset 32. Reading a u32 at
+ * offset 33 runs past the end of excl and is rejected.
  */
 SEC("socket")
 __description("bpf_map_ptr: read non-existent field rejected")
 __failure
-__msg("cannot access ptr member ops with moff 32 in struct bpf_map with off 33 size 4")
+__msg("access beyond the end of member excl (mend:36) in struct bpf_map with off 33 size 4")
 __failure_unpriv
 __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
 __flag(BPF_F_ANY_ALIGNMENT)
-- 
2.55.0

