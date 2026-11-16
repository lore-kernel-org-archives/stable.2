Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872005;
	b=wVrdJZY2HpiXyyfocow8OEEZZVfP1UsUHmgoDcxLTasY3axhnIcS4S71HsS1nYuZVKLp
	 nYWL4Eibt62yNBwfXDBF51D6m7OKgbA94hNmkqxENYZzraGpBD0iKZNCPR7+jXDa1KXpI
	 EmLTorKojvsY6uLaIIArpWNxkurB+Rm41PY1zy/q5MM/PiIkRIMjwpULZrNI94KWRlmQJ
	 t3UlFUbH769zj2SDJrY9S46dCVs//1jdko4yGSWQBKmaoMhbWg0HcGVR6sHIOsaPmrdol
	 25nAJpLLVqRXu07XmfFWzKFBUyZ4rqjprobT9C27XjX/W8K6DKKiV/YhICHOPZmiRow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872005;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JkYXEQFB9TJaWPCUl6oELzMgMKopSE/CjrWR4W7FyQE=;
	b=2OVEWAxed3lPyDXjpB669i+rP3bnybK9/+3vEMNcS8ovYpANQ6ovAdza4mVfHr6y5BN4
	 kdiiIa0gz+fHYz0DE2AIATT0Q4fF6dPjfo3V2G8CjKIauIuB7/0kO6V1w07OW/Hnel9+F
	 n6rdasPM9Rr12HkUcwKaUyRwipR43TOiWiLqQ18T/tDNBsfQ2/Wct8GK5m5zkG3/N0vSS
	 NHkPchzzJczLq38JN/gDXOt4fxZLstgCtYwEv7nBFm9xPYccZEBMXFo4kFdMruSbgw2/W
	 kOU+TEew/dOrep7pNZlsA9+5f8GiV6YSU8CtkRXYyETU3BrZo0Ckj4yeOZtTVRFZy6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=pNuTU8B3;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E460606A31C;
	Mon, 16 Nov 2026 23:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E460606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=pNuTU8B3
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 60FE714C2D6;
	Tue, 17 Nov 2026 00:33:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1794871994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JkYXEQFB9TJaWPCUl6oELzMgMKopSE/CjrWR4W7FyQE=;
	b=pNuTU8B3i6pOmJ0Tv3rncHYONbO5KnmNW9dj7+hdcT1hbaN0JZjXHVFWcaKZgrYqZwpfDM
	viEkrRNUO8hNJ84QoOE77456DldXXOdQ2h36yYZmegZEhSur07Nmfvi9TBfljUAtf+kw7K
	kW0fmVigSsuR0Wi0Ixe0iK57cUgNl96sFg4eWZCSjQGrR2bKj7p6kspqOJvCmYJhDmXqsO
	AZcwpTyUpZe5l0/CsJB0rMp1UJGDxDk/Jnde3XNKQPYztgHfkA9Gtu6vFyPyIPVBd0dQ8p
	YCAnF/4QWmedIW2FKRU6AbAJb/XPObmBgkXBuxVCVVwYnzXnk6gmuu8d5e7HiQ==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 2d9951d4;
	Mon, 16 Nov 2026 23:33:07 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: stable@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: ast@kernel.org,
	ihor.solodrai@linux.dev,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH 5.10-6.18 v2] libbpf: fix cross-endian build with newer libbpf
Date: Tue, 17 Nov 2026 08:33:01 +0900
Message-ID: <20261116233301.1531563-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.54.0
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

commit 087f3964f4b3 ("libbpf: Support layout section handling in BTF")
added extra data to the BTF header.

This extra data is ignored in the native case, but when building with
different endianness the bswap code in old libbpf would check for strict
size equality, leading to build failures such as this when BTF data is
generated with a newer version of libbpf (through pahole)
    BTFIDS  vmlinux.unstripped
  libbpf: Can't load BTF with non-native endianness due to unsupported header length 32
  FAILED: load BTF from vmlinux.unstripped: Operation not supported
  make[2]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255

Newer libbpf versions also properly ignore trailing data in the bswap
case, but the patch is too intrusive to backport, so take the header 
length comparison fix from it instead.

Link: https://github.com/NixOS/nixpkgs/pull/570639
Fixes: 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
Acked-by: Alan Maguire <almagui@kernel.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
v1 -> v2:
- link to v1: https://lore.kernel.org/r/20261115200505.1494710-2-asmadeus@codewreck.org
- use offsetofend() instead of sizeof() to match the support layout
section handling patch as suggested by Alan
I checked this builds on 5.10 (non-cross-endian build) and 6.18 (ppc64
cross build)
- add Fixes tag as suggested by sashiko

 tools/lib/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9f141395c074..0ab11be8ebc5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -229,14 +229,14 @@ static int btf_parse_hdr(struct btf *btf)
 	struct btf_header *hdr = btf->hdr;
 	__u32 meta_left;
 
-	if (btf->raw_size < sizeof(struct btf_header)) {
+	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
 		pr_debug("BTF header not found\n");
 		return -EINVAL;
 	}
 
 	if (hdr->magic == bswap_16(BTF_MAGIC)) {
 		btf->swapped_endian = true;
-		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
+		if (bswap_32(hdr->hdr_len) < offsetofend(struct btf_header, str_len)) {
 			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
 				bswap_32(hdr->hdr_len));
 			return -ENOTSUP;
-- 
2.56.1

