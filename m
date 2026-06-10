Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1E388363
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079304; cv=none; b=nSu4AaIlgB/v7+bw/rjxqs2f3nhVGmmO5J98YoKVvDHucU/bZQ3hLbZx+by2xTbiongZYqQ3KirPcOSnkH94/EjPdqW1YNL4qWe2GL7A3bbKZq5uocTQMMeb3CLwGaqXGaiH656g31v9D31u+rlD/AqB3M4hocCzdqM71hqcg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079304; c=relaxed/simple;
	bh=o87GlFZouziDxJNQmfzvLl4CN2jqcWxVngxFdCfuAQs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oYIzMqeaBhO4WD+otdgB/XRqn5bMwnSXyW5jK4JlhgUwXUj+kPiQ3VKaZInlb/XKPWUvHUgrI7S4QaHW3jVwXhmmVAvsMwwybHhc8IqOhDDI3Xw+WryHJ/fnwRKU+EqjFw7W3IwPpxMb8j7Tb8UxVcfp9NQwt8+708XXYToRrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=UAJuiRCo; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="UAJuiRCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1781079298; x=1781338498;
	bh=sGlE8SUDHPBzUdtaKzWTSHFJvgvyCcuoz/ycf7sL140=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UAJuiRCoZQ5QWkRSc4li6iri4O76EfC/0cJQpl6YxcrsV40kDqySKUHH+nAc7ZM0K
	 n95+aNP+NYd4IfBpYfh4vP/U+F6jSLwQTR0lMM0jKk42FDsDgjtNI3lAVDm8mvgXhE
	 Sm4WsZH4UtrLv8pY8ZYPcpQL3YdaxhNm45aCZ6oMX7UGJwSRFphEtMJus8pTuQenOC
	 PcASjg7Wl7oSa/M+M7pPNfkkntjC4FyflquyfOsSVnA+RPjTPPtbK8//3NdD4djidx
	 PoD2Wucd44YQ+iUOFkYfJbqSaIjgYnADqTnP/Bt9fy9KXTqI33iTX5cQutbf/Tt34M
	 u081P7IExn5Tw==
Date: Wed, 10 Jun 2026 08:14:47 +0000
To: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, houtao1@huawei.com, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH bpf v2] bpf: Validate BTF repeated field counts before expansion
Message-ID: <20260610081434.2141515-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: db82099a15662a0e7eb91c1a1e7bd0d5bda21c35
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

btf_parse_struct_metas() walks user supplied BTF during BPF_BTF_LOAD,
and btf_repeat_fields() expands repeatable fields from array elements
into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().

The remaining-capacity check performs the expanded field count calculation
in u32. A malformed BTF can wrap that calculation, causing the check to
pass even when the expanded field count exceeds the scratch array
capacity. The following memcpy() can then write past the end of the
array.

Use checked multiplication before copying repeated fields and reject=20
impossible counts.

Add a raw BTF test that exercises repeated special-field expansion with a
large array count. The compact element layout keeps the array byte size
representable while the repeated field count overflows the old u32 capacity
calculation in btf_repeat_fields().

Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating bt=
f fields")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>

---
v1..v2
1. Combine fix and test
2. Drop check_add_overflow
---
 kernel/bpf/btf.c                             |  8 ++---
 tools/testing/selftests/bpf/prog_tests/btf.c | 37 ++++++++++++++++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..7a28886f1307 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3668,7 +3668,7 @@ static int btf_get_field_type(const struct btf *btf, =
const struct btf_type *var_
 static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 =09=09=09     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
 {
-=09u32 i, j;
+=09u32 i, j, total_cnt;
 =09u32 cur;
=20
 =09/* Ensure not repeating fields that should not be repeated. */
@@ -3686,10 +3686,8 @@ static int btf_repeat_fields(struct btf_field_info *=
info, int info_cnt,
 =09=09}
 =09}
=20
-=09/* The type of struct size or variable size is u32,
-=09 * so the multiplication will not overflow.
-=09 */
-=09if (field_cnt * (repeat_cnt + 1) > info_cnt)
+=09if (check_mul_overflow(field_cnt, repeat_cnt + 1, &total_cnt) ||
+=09    total_cnt > (u32)info_cnt)
 =09=09return -E2BIG;
=20
 =09cur =3D field_cnt;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/s=
elftests/bpf/prog_tests/btf.c
index 054ecb6b1e9f..9fcbc554e351 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4258,6 +4258,43 @@ static struct btf_raw_test raw_tests[] =3D {
 =09.max_entries =3D 1,
 },
=20
+{
+=09.descr =3D "struct test repeated fields count overflow",
+=09.raw_types =3D {
+=09=09BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),=09/* [1] */
+=09=09BTF_STRUCT_ENC(NAME_TBD, 0, 0),=09=09=09=09/* [2] */
+=09=09BTF_TYPE_TAG_ENC(NAME_TBD, 2),=09=09=09=09/* [3] */
+=09=09BTF_PTR_ENC(3),=09=09=09=09=09=09/* [4] */
+=09=09BTF_TYPE_ARRAY_ENC(4, 1, 1),=09=09=09=09/* [5] */
+=09=09BTF_STRUCT_ENC(NAME_TBD, 10, 8),=09=09=09/* [6] */
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_TYPE_ARRAY_ENC(6, 1, 0x1999999aU),=09=09=09/* [7] */
+=09=09BTF_STRUCT_ENC(NAME_TBD, 2, 8 + 8 * 0x1999999aU),=09/* [8] */
+=09=09BTF_MEMBER_ENC(NAME_TBD, 4, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 7, 64),
+=09=09BTF_END_RAW,
+=09},
+=09BTF_STR_SEC("\0int\0prog_test_ref_kfunc\0kptr_untrusted\0elem"
+=09=09    "\0p0\0p1\0p2\0p3\0p4\0p5\0p6\0p7\0p8\0p9"
+=09=09    "\0outer\0trigger\0elems"),
+=09.map_type =3D BPF_MAP_TYPE_ARRAY,
+=09.map_name =3D "repeat_fields",
+=09.key_size =3D sizeof(int),
+=09.value_size =3D 8 + 8 * 0x1999999aU,
+=09.key_type_id =3D 1,
+=09.value_type_id =3D 8,
+=09.max_entries =3D 1,
+=09.btf_load_err =3D true,
+},
 }; /* struct btf_raw_test raw_tests[] */
=20
 static const char *get_next_str(const char *start, const char *end)
--=20
2.54.0


