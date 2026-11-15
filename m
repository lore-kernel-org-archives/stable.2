Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794773220;
	b=W1mW+y796hZ2P7O6v+xdKXeHSKjuipqdWbShADPolk9iue7jJoUZUu+yPp5GorBP90k8
	 paVwMILEeXCcumnChO5dVZQMDxiPV5yCW3DPf/06Zv2rgv8vl1wEXHb2zLnud0HSpg0ZE
	 nHXDnCuhQi/EEGbTCFiXiyJnJLBib7DwN/VIWErtrMbsgTlk/CgHNvKxdVpzOPAAquu0j
	 lsq7uZEZ8LNlsXysIIL9jiGK0bv17eXvpFtRF9rVZ52BEEqOuNO1W+0ae46B3jhH3IfaO
	 LeAFaZktPHMQ+qn01PFtrJMOxSypl2wXm9pfaI5jYmYf0or7Xo9cxgUCbezio7ZemvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773220;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dncwCu8rZrSPdbDpAn+uA+POilsNf3H5kpWC2RULAUc=;
	b=l3ib7JCGyk/pSvQlrQM5IaIIcgfr2MT+vuPab28lduj1tWLI4cTwOTDMPojueaVfIlYO
	 2QI4mwLVdo72e1+lub2qlFOQRVRQPWEXzUHHjy4iqm+IQLRLUJvHcn953tuD6atp1D4gQ
	 RvRBF8Nqp5xFETaVooEFT6TViF3sz099xsss74kZuID+bFPcnM1464zxvZ8aYyeWjHM0w
	 LuxxxoW2FbK4t1vcrrmGzocWH+Z+G1K4PhUSgM+WsB9nViMziWSKwQBXV1KFOhTSuSYoP
	 SYqZVy/9Wy031FQLpTQl/OYMNgmvWKH8CghHy+IQSqzYX8X2bpydcjvakK82dsQy7Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=kyHzkVsh;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A4606A323;
	Sun, 15 Nov 2026 20:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 033A4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=kyHzkVsh
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7FAF814C2DE;
	Sun, 15 Nov 2026 21:06:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1794773209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dncwCu8rZrSPdbDpAn+uA+POilsNf3H5kpWC2RULAUc=;
	b=kyHzkVsh6I6BVaVM2zft+j2swrKVLAd0i/Zy3mu0LdasWpdRqlQ95WAyqEXs2BmtraRiiL
	zfLAZDIHkt947jEl/XG/llycIOYakucVLImZT/MjTnStW2018PKaM9kJNb/OKudZncNLdV
	Veo+YWLfpT14Q2PZMTtEMMXYsqbqpFvxyKdhKcstIdk9rjSrmeCSkMf7GUCU+3SDwEpRqZ
	BEVrF0ha00qRUZ2Myvva2W+a6YRqoeKnUasFMiRajBT/b90Ict0DDfgxXCRHWzeNVbTHdG
	APaxcTuxDF2JjnbpCCAGzDMxqdSmtE8uk2gwSrMnyuK/1sIXETt3DIVrwB9GwA==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id aa031c75;
	Sun, 15 Nov 2026 20:06:42 +0000 (UTC)
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
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 5.10-6.18] libbpf: fix cross-endian build with newer libbpf
Date: Mon, 16 Nov 2026 05:05:06 +0900
Message-ID: <20261115200505.1494710-2-asmadeus@codewreck.org>
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
case, but the patch is too intrusive to backport, just fix the header
length comparison.

Link: https://github.com/NixOS/nixpkgs/pull/570639
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Hey,

we've got a cross build failure report for ppc64 in nixpkgs (link in
commit message), that turned out as described above.
(build broke for all kernels before 7.1)

In this case I believe it's easier to just fix the check than backport
the full layout section handling support, is that ok?
I've confirmed the build succeeds with this, I assume the reporter will
eventually also boot check but from my understanding of the code this
should be fine.

Feel free to throw this away if there's a better way, just let me know
if I can help.

Thanks

 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9f141395c074..ae344cf58e85 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -236,7 +236,7 @@ static int btf_parse_hdr(struct btf *btf)
 
 	if (hdr->magic == bswap_16(BTF_MAGIC)) {
 		btf->swapped_endian = true;
-		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
+		if (bswap_32(hdr->hdr_len) < sizeof(struct btf_header)) {
 			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
 				bswap_32(hdr->hdr_len));
 			return -ENOTSUP;
-- 
2.56.1

