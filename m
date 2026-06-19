Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A536073E;
	Fri, 19 Jun 2026 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781908001; cv=none; b=IEeOgghs+pyqMYfJhNY39aBk2eJ4PUYXxjC9czCQFN9h7w17sjj0NG8KDdedmCyVjq5Fi8RWzs31Sc2rbnNRgeBa7ZDeORbwwZvceWHDnQqjBUM4MaypL8dsSwAyvh09Wi+jaCN/hXqKx87RYiqGvF2H4/6bL2wcU19Y/x3IPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781908001; c=relaxed/simple;
	bh=XyvanEnYWRj6xigSJ0RoRW7KPRp6fOwGjITq7jHTgd8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XE1rrzxftMOtWM9A0nbVSD5h0UTX6JOMaCM9bDSCOQKsOAC0yjcTopkafSHXmis1iMtOj5lE7W6yJnlJ+vVLfGjEy2HjvTI/Ijw7EuUw0y1PP8CKY8J+Q5o8Cgkh5z+HbU49jzzR11ta4kNjUUUIgBfFoOEekjgJCQn+kmwSDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch; spf=pass smtp.mailfrom=protonmail.ch; dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b=OakLRu02; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="OakLRu02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1781907991; x=1782167191;
	bh=XyvanEnYWRj6xigSJ0RoRW7KPRp6fOwGjITq7jHTgd8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OakLRu02evvry4+8yfaQ5cAO6ds7XheNbghFx7A3jNUqGndXtMunpLRz74gBfSBOy
	 OXYeZ6ZVJVMRt/q48GaCrVGSeKDTmIEryt6vHJMvcDRNbQiRdaqCvBbqkbv+Eq+rH9
	 rrZmXTywoAWZ/Q70bAlF2oW+CUPnQUXYOVxD45qDjd0bBsJodansvIm378s9wBeJNn
	 Z2y+ub+uCt0IzrVoktFBF26ipyXG0xc1O/KsPZl2N69TDVszIQb7DefyyqxWny7Tw/
	 GcoqBKD5MxEv6pUan108FwM+IClFgqn3+sV8oVbxqdYUjvCsOmCH2OfgOPhK1pch+v
	 H5v+0ZIJB54ug==
Date: Fri, 19 Jun 2026 22:26:24 +0000
To: "899f2dec-e8b9-44f4-ab8d-001e160a2aed@roeck-us.net" <899f2dec-e8b9-44f4-ab8d-001e160a2aed@roeck-us.net>
From: ANDREW <andreasx0@protonmail.ch>
Cc: Nathan Chancellor <nathan@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH V2] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled
Message-ID: <mQ5O_oFTbB5bqRCi_D2zBN0vB4GSzMMsY24HqedJ4MFanfuARw-KUK2EhcKLWO6MiVIjk29WWmG-OHE2QpSXO1h4BJ-VDcheRl8j8GViLRI=@protonmail.ch>
Feedback-ID: 51583129:user:proton
X-Pm-Message-ID: da933af4109c600de9a1cb261a2e02bdd1b8afd9
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------9db49a0c11458cb18e870bd467cae4956a4f22ebfdf45785de2fc34d406fd605"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9db49a0c11458cb18e870bd467cae4956a4f22ebfdf45785de2fc34d406fd605
Content-Type: multipart/mixed;boundary=---------------------23a964c72e85efeed05e27c46de823e9

-----------------------23a964c72e85efeed05e27c46de823e9
Content-Type: multipart/alternative;boundary=---------------------afabc21203141bdb62d749441a001f7f

-----------------------afabc21203141bdb62d749441a001f7f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

voidacpi_tb_print_table_header(acpi_physical_address address,
=C2=A0 struct acpi_table_header *header)
{
struct acpi_table_header local_header;

ssize_t ssrc_len =3D sizeof(ACPI_CAST_PTR(struct acpi_table_rsdp, header)-=
>signature);
size_t src_len =3D (ssrc_len < 0) ? 0 : (size_t)ssrc_len;
size_t src_length =3D (src_len < 8) ? src_len : 8;
char rsdp_sig[src_length + 1];
memcpy(rsdp_sig,
=C2=A0 =C2=A0 =C2=A0 ACPI_CAST_PTR(struct acpi_table_rsdp, header)->signat=
ure,
=C2=A0 =C2=A0 =C2=A0 src_length);
rsdp_sig[src_length] =3D '\0';

if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) {

/* FACS only has signature and length fields */

ACPI_INFO(("%-4.4s 0x%8.8X%8.8X %06X",
=C2=A0 header->signature, ACPI_FORMAT_UINT64(address),
=C2=A0 header->length));
} else if (ACPI_VALIDATE_RSDP_SIG(rsdp_sig)) {

/* RSDP has no common fields */

memcpy(local_header.oem_id,
=C2=A0 =C2=A0 =C2=A0 ACPI_CAST_PTR(struct acpi_table_rsdp, header)->oem_id=
,
=C2=A0 =C2=A0 =C2=A0 ACPI_OEM_ID_SIZE);
acpi_tb_fix_string(local_header.oem_id, ACPI_OEM_ID_SIZE);

ACPI_INFO(("RSDP 0x%8.8X%8.8X %06X (v%.2d %-6.6s)",
=C2=A0 ACPI_FORMAT_UINT64(address),
=C2=A0 (ACPI_CAST_PTR(struct acpi_table_rsdp, header)->
=C2=A0 =C2=A0revision >
=C2=A0 =C2=A00) ? ACPI_CAST_PTR(struct acpi_table_rsdp,
=C2=A0 =C2=A0 =C2=A0 header)->length : 20,
=C2=A0 ACPI_CAST_PTR(struct acpi_table_rsdp,
header)->revision,
=C2=A0 local_header.oem_id));
} else {
/* Standard ACPI table with full common header */

acpi_tb_cleanup_table_header(&local_header, header);

ACPI_INFO(("%-4.4s 0x%8.8X%8.8X"
=C2=A0 " %06X (v%.2d %-6.6s %-8.8s %08X %-4.4s %08X)",
=C2=A0 local_header.signature, ACPI_FORMAT_UINT64(address),
=C2=A0 local_header.length, local_header.revision,
=C2=A0 local_header.oem_id, local_header.oem_table_id,
=C2=A0 local_header.oem_revision,
=C2=A0 local_header.asl_compiler_id,
=C2=A0 local_header.asl_compiler_revision));
}
}
-----------------------afabc21203141bdb62d749441a001f7f
Content-Type: multipart/related;boundary=---------------------74c048a0ac71579043ac46ca88f4c8d9

-----------------------74c048a0ac71579043ac46ca88f4c8d9
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PHNwYW4+PC9zcGFuPjxzcGFuPnZvaWQ8L3NwYW4+PGRpdj48c3Bhbj5hY3BpX3RiX3ByaW50X3Rh
YmxlX2hlYWRlcihhY3BpX3BoeXNpY2FsX2FkZHJlc3MgYWRkcmVzcyw8L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj4JCQkgJm5ic3A7IHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqaGVhZGVyKTwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuPns8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4Jc3RydWN0IGFjcGlf
dGFibGVfaGVhZGVyIGxvY2FsX2hlYWRlcjs8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj48c3Bhbj4Jc3NpemVfdCBzc3JjX2xlbiA9IHNpemVvZihBQ1BJX0NBU1RfUFRSKHN0cnVjdCBh
Y3BpX3RhYmxlX3JzZHAsIGhlYWRlciktJmd0O3NpZ25hdHVyZSk7PC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+CXNpemVfdCBzcmNfbGVuID0gKHNzcmNfbGVuICZsdDsgMCkgPyAwIDogKHNpemVfdClz
c3JjX2xlbjs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4Jc2l6ZV90IHNyY19sZW5ndGggPSAoc3Jj
X2xlbiAmbHQ7IDgpID8gc3JjX2xlbiA6IDg7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+CWNoYXIg
cnNkcF9zaWdbc3JjX2xlbmd0aCArIDFdOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPgltZW1jcHko
cnNkcF9zaWcsPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+CSAmbmJzcDsgJm5ic3A7ICZuYnNwOyBB
Q1BJX0NBU1RfUFRSKHN0cnVjdCBhY3BpX3RhYmxlX3JzZHAsIGhlYWRlciktJmd0O3NpZ25hdHVy
ZSw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4JICZuYnNwOyAmbmJzcDsgJm5ic3A7IHNyY19sZW5n
dGgpOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPglyc2RwX3NpZ1tzcmNfbGVuZ3RoXSA9ICdcMCc7
PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+CWlmIChBQ1BJX0NPTVBBUkVf
TkFNRVNFRyhoZWFkZXItJmd0O3NpZ25hdHVyZSwgQUNQSV9TSUdfRkFDUykpIHs8L3NwYW4+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4JCS8qIEZBQ1Mgb25seSBoYXMgc2lnbmF0dXJl
IGFuZCBsZW5ndGggZmllbGRzICovPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNw
YW4+CQlBQ1BJX0lORk8oKCIlLTQuNHMgMHglOC44WCU4LjhYICUwNlgiLDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPgkJCSAmbmJzcDsgaGVhZGVyLSZndDtzaWduYXR1cmUsIEFDUElfRk9STUFUX1VJ
TlQ2NChhZGRyZXNzKSw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4JCQkgJm5ic3A7IGhlYWRlci0m
Z3Q7bGVuZ3RoKSk7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+CX0gZWxzZSBpZiAoQUNQSV9WQUxJ
REFURV9SU0RQX1NJRyhyc2RwX3NpZykpIHs8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj48c3Bhbj4JCS8qIFJTRFAgaGFzIG5vIGNvbW1vbiBmaWVsZHMgKi88L3NwYW4+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48c3Bhbj4JCW1lbWNweShsb2NhbF9oZWFkZXIub2VtX2lkLDwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuPgkJICZuYnNwOyAmbmJzcDsgJm5ic3A7IEFDUElfQ0FTVF9QVFIo
c3RydWN0IGFjcGlfdGFibGVfcnNkcCwgaGVhZGVyKS0mZ3Q7b2VtX2lkLDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPgkJICZuYnNwOyAmbmJzcDsgJm5ic3A7IEFDUElfT0VNX0lEX1NJWkUpOzwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuPgkJYWNwaV90Yl9maXhfc3RyaW5nKGxvY2FsX2hlYWRlci5vZW1f
aWQsIEFDUElfT0VNX0lEX1NJWkUpOzwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxz
cGFuPgkJQUNQSV9JTkZPKCgiUlNEUCAweCU4LjhYJTguOFggJTA2WCAodiUuMmQgJS02LjZzKSIs
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+CQkJICZuYnNwOyBBQ1BJX0ZPUk1BVF9VSU5UNjQoYWRk
cmVzcyksPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+CQkJICZuYnNwOyAoQUNQSV9DQVNUX1BUUihz
dHJ1Y3QgYWNwaV90YWJsZV9yc2RwLCBoZWFkZXIpLSZndDs8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj4JCQkgJm5ic3A7ICZuYnNwO3JldmlzaW9uICZndDs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4J
CQkgJm5ic3A7ICZuYnNwOzApID8gQUNQSV9DQVNUX1BUUihzdHJ1Y3QgYWNwaV90YWJsZV9yc2Rw
LDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPgkJCQkJICZuYnNwOyAmbmJzcDsgJm5ic3A7IGhlYWRl
ciktJmd0O2xlbmd0aCA6IDIwLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPgkJCSAmbmJzcDsgQUNQ
SV9DQVNUX1BUUihzdHJ1Y3QgYWNwaV90YWJsZV9yc2RwLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PgkJCQkJIGhlYWRlciktJmd0O3JldmlzaW9uLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPgkJCSAm
bmJzcDsgbG9jYWxfaGVhZGVyLm9lbV9pZCkpOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPgl9IGVs
c2Ugezwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPgkJLyogU3RhbmRhcmQgQUNQSSB0YWJsZSB3aXRo
IGZ1bGwgY29tbW9uIGhlYWRlciAqLzwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxz
cGFuPgkJYWNwaV90Yl9jbGVhbnVwX3RhYmxlX2hlYWRlcigmYW1wO2xvY2FsX2hlYWRlciwgaGVh
ZGVyKTs8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4JCUFDUElfSU5GTygo
IiUtNC40cyAweCU4LjhYJTguOFgiPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+CQkJICZuYnNwOyAi
ICUwNlggKHYlLjJkICUtNi42cyAlLTguOHMgJTA4WCAlLTQuNHMgJTA4WCkiLDwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuPgkJCSAmbmJzcDsgbG9jYWxfaGVhZGVyLnNpZ25hdHVyZSwgQUNQSV9GT1JN
QVRfVUlOVDY0KGFkZHJlc3MpLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPgkJCSAmbmJzcDsgbG9j
YWxfaGVhZGVyLmxlbmd0aCwgbG9jYWxfaGVhZGVyLnJldmlzaW9uLDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPgkJCSAmbmJzcDsgbG9jYWxfaGVhZGVyLm9lbV9pZCwgbG9jYWxfaGVhZGVyLm9lbV90
YWJsZV9pZCw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4JCQkgJm5ic3A7IGxvY2FsX2hlYWRlci5v
ZW1fcmV2aXNpb24sPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+CQkJICZuYnNwOyBsb2NhbF9oZWFk
ZXIuYXNsX2NvbXBpbGVyX2lkLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPgkJCSAmbmJzcDsgbG9j
YWxfaGVhZGVyLmFzbF9jb21waWxlcl9yZXZpc2lvbikpOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
Pgl9PC9zcGFuPjwvZGl2PjxzcGFuPn08L3NwYW4+PGRpdj48c3Bhbj48YnI+PC9zcGFuPjwvZGl2
Pg==
-----------------------74c048a0ac71579043ac46ca88f4c8d9--
-----------------------afabc21203141bdb62d749441a001f7f--
-----------------------23a964c72e85efeed05e27c46de823e9
Content-Type: application/pgp-keys; filename="publickey - andreasx0@protonmail.ch - 0xBB6B52B1.asc"; name="publickey - andreasx0@protonmail.ch - 0xBB6B52B1.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - andreasx0@protonmail.ch - 0xBB6B52B1.asc"; name="publickey - andreasx0@protonmail.ch - 0xBB6B52B1.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FYWlZVTRCWUpLd1lCQkFI
YVJ3OEJBUWRBZkJlTUtsUDR6VHV4ZXRSU293Q2NlU0VBWGNSL0tkSlIKa1ppVEhDeFIwaVBOTVdG
dVpISmxZWE40TUVCd2NtOTBiMjV0WVdsc0xtTm9JRHhoYm1SeVpXRnplREJBCmNISnZkRzl1YldG
cGJDNWphRDdDd0JFRUV4WUtBSU1GZ21vbUZPQURDd2tIQ1JCYjJzSnRBV0xVWmtVVQpBQUFBQUFB
Y0FDQnpZV3gwUUc1dmRHRjBhVzl1Y3k1dmNHVnVjR2R3YW5NdWIzSm5ZcTVEbDMwYTZocmQKUXZi
OVA5S08rTzc5aExFZGFacUk2cXMyaStuSGVrY0RGUW9JQkJZQUFnRUNHUUVDbXdNQ0hnRVdJUVM3
CmExS3hQNjhyMVNNUlRSVmIyc0p0QVdMVVpnQUEyaE1CQUlUbE1XeHFOQURxbGV5QXJTVnhVQUNk
NXlTMwowdVUvMmppM3pQUjBQblpnQVFDNzVVSlVWMUpzVTFMZ3VIZHlWRzhjem5JaThveUY2NkUy
ZW85WTJCWUIKQ2M0NEJHb21GT0FTQ2lzR0FRUUJsMVVCQlFFQkIwRHZtdzloOVJTaWwzaTZqQWdr
eGVpbVNJNWc2YytrCjZaSG1RWWwrdEYzWGV3TUJDQWZDdmdRWUZnb0FjQVdDYWlZVTRBa1FXOXJD
YlFGaTFHWkZGQUFBQUFBQQpIQUFnYzJGc2RFQnViM1JoZEdsdmJuTXViM0JsYm5CbmNHcHpMbTl5
WnlFYytsQUN0UDVTbEhVaGxDSDgKelF6blh1N1NpQU5rSGZZTmxJdTQwNmxOQXBzTUZpRUV1MnRT
c1Qrdks5VWpFVTBWVzlyQ2JRRmkxR1lBCkFNVUVBUURGWHk4aTB3bmNPQ3BObkJtUi9xcHBDdTFE
RGdySmdmOCs0S3Zlem03dXBRRUEwRkpJanBYNQpiNEFuVzdrLzEvbHZBdWs2NldmaTdqSE9yTkJB
SFNNN2J3az0KPUNQRGoKLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
-----------------------23a964c72e85efeed05e27c46de823e9--

--------9db49a0c11458cb18e870bd467cae4956a4f22ebfdf45785de2fc34d406fd605
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wroEARYKAG0Fgmo1wgYJEFvawm0BYtRmRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmf/P8XhGA/35FnZzXck7pRQEtJxoXki+jALBHtK
1kgOLhYhBLtrUrE/ryvVIxFNFVvawm0BYtRmAACeUgD4nsOvQ8SUg4zPhYRA
e+6q0duQRufWoMqE9fetHAO+dwD+NvpbHPra7dBI4bzrZMoD8F8o7EXDsZOU
ClxV1iERSgY=
=2QII
-----END PGP SIGNATURE-----


--------9db49a0c11458cb18e870bd467cae4956a4f22ebfdf45785de2fc34d406fd605--

