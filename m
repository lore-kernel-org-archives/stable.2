Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795072843;
	b=2+Pgtj7FHnAuxr4q7OGP+ZgyfSmwPcwN05jQm0a2Oj7+Ebth+O5gZoJAeM5G/cl3PWcv
	 yLOpAMMtqcBk5gcBMzT45goq2KNnUja6pq0k4322yfbuYR1Gf1FjWKmUIZ9IG5DyoBct3
	 Oo/5th8rGyOz7tBIh7BfENKgw+sh7B+BKDBzUIr512rTjrxTkTWTSpgipoX566sVu23ih
	 yXKbsZKEDi4y5Fb1rclq3avZffetECVVKhknTPXA02wlYVtg8wAX+kdxm50Gy3UPg6K68
	 JLVeV7wfFd9gqAn//8Nv2Zp7rZ45+ziWfMBj3BWN89Y4j48YZTn+Hd/6Lr9npzM1bTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=3lF3ame2k0Qlq5DDaiC3kZk755RYfgn7652S/tZaZ34=;
	b=2BVbI+WTC91sUL+jIgcvQ2DLEtiQWOAIIYnu44ft/osX7UnxCRo5KuH/rT+N8BTI+3Lv
	 smSRjbZmS53kBUetiDTVY6HbrYL6Urh819R4b/hysAY0lng4R18uuN3X/1SwANkFENBV8
	 2fXvKqVlGlUW9Z/6r06eDvwWSRClYb0qRgo7O/ZbGVKwpSiUkssJAzXiQl+qxc5ISmklG
	 z6l3ZFNq+zsDQkPjwEX7vnWYkF3UtgOkq5RG+YeaE7nbyT26vK7MSwrTkM+Z7qiTi+kDY
	 DDCFx6e0YbZIAoNMxGxeiPqKB1E9CQGLLRSQ2AHlyHxf/eGjShY1IeUJziac+ZhnfJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gf/6VXN6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B6606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 463B6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gf/6VXN6
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-949657a20d7so236084785a.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795072842; cv=none;
        d=google.com; s=arc-20260327;
        b=QUeX/jVUQ1m2yG+in1zCN77muBFHtGtX9k/HJMH9JosF5fFb6tN8KOyFePzU34xqHC
         gxiQoxiAUJv/l7Te2TDp3BQGed7305O3OnAGnZqwamxeEwjXw9gEJpsHp44KsP63ISCY
         +A4/VdGGyyXaVOFeSq5dQfyiP8825UPF083Ffw3zIQWSCG1RJwHHACD30tFsQ8H7PYxG
         Setzs1qdQR2NMk1RkmNhIk8SZFAY2gMPF4K/IeDPyFiNKkzgu0yfw1EUhDNs78jIXrQI
         J2Jx36HDod/bf1xrKtOK2vxeBRZGJMdRVqQrGszL+GFr4fPOqQwHauvW3Q5BpwBuXymE
         3e4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3lF3ame2k0Qlq5DDaiC3kZk755RYfgn7652S/tZaZ34=;
        fh=ZuxoyUMQgX4m+TGJoDtDYDpjE6ye6oHuT9L4IwoS9F8=;
        b=l3fK2n1EE/rnIAK8nizhPRjNY/X1LW0S6TvhiY25chbCKRhtPOzqgQklH1oNmD8Kdb
         FisOuSwgM487GRLQApM1gIrC5i8s+hvPybs9WxLaEp403lsuqwZ0jza27lY91+46PI4G
         Co0tYqNAlvJBcIiD/JZSwDQSgW73U2XkkDdUFx+MGYi02haiwBEudrSqz5a9zPFkpvZS
         XIDc+YEFcEhPXpvr6EYYqZKE4LAiCfxWZlC0hHyQFv4BM9Yh1cQIa2o5T06KLRc7dAfd
         h0xlOZt7WacKP9Sss7dILKU5bp5ZOKXdia5KzAaiPPuuObDtKh7IKprUk2z7X3P8iwbd
         0BUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072842; x=1795677642; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lF3ame2k0Qlq5DDaiC3kZk755RYfgn7652S/tZaZ34=;
        b=Gf/6VXN6vKTfzF5IRK/PaOVmORNq5ZETohNcqZx/uOl4ChwjAVa8FOfjTrDEmgjZ7Q
         07IuhTNq3ucjzj/KdUxLJHCl3gGj3aIHrQRd2OU1xoMlCXqFIhbR1UgLIcb7ZKIF7+6V
         EmDMCSFCXq2d5xEkkQorr25I7QTF1mShKSPYfaVbAsEOVA2n3s66cAGOAnAEm6E0LNQ3
         DftjKttKMEBya8nsQHm+FuFxEvRt/VYmPPz07Fo7b3fmnFh255l+LJBKHaxonhY8wPgi
         o4DPJ/y5zHHheyow0GQyqyE0CqdL/TQcKcubv8ngSe084UYz3hTI0ijqfPRYHn85ztyW
         gKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072842; x=1795677642;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3lF3ame2k0Qlq5DDaiC3kZk755RYfgn7652S/tZaZ34=;
        b=QWoQXFjJ6EJCQ5Lq44ud+uI1W/SfO7aYN0AUo8umy+Ai3VPm8hzhmo3/dLVslCbFGf
         7M/Xr2Fd1XxTubvAn3mcg15bLXqccwcvlcqrFbnsKPAFC/XtitVS4mxpxqunMiP01rZu
         eB2TkEs1flvSl7PjJIgpjIYbXnx1hj0W1EEIRhf+A8hsnPpGtnVY5hsVYwpTcEkDmrbP
         08G3Y/B4nK745oVL8qGWyypnAzQxty4hNbseH2Hi8upcenwsKCZwr/amGH4M8euvNVGv
         iEEHSKu06KQj+spXz3W0Hx/ZKXmdaF6PtGJZQdXG9c+FQC9t43k67sH9vjrE+mwYPW8F
         I5CA==
X-Forwarded-Encrypted: i=1; AL+hErEBSxSQIxgV5un/GALFe8KQtHyzOWB+bOUfWICePdkOy1poTKOsVjiMdO6gZAc6ii5SL+9udHA=@vger.kernel.org
X-Gm-Message-State: APuU4Z959y9F9Pw0aY+ZBGSQDk+I1ft4llh1HRaF+uoLa4EXQ7YzD4pE
	g8tAt3ART8+2jB/aU8GVHWZ5Lm+LxYrAZYAus726g1vVjUXaAxY4p/L4peqyyGzFP9N4fLd2bux
	NAao9T0KkkgIyD0/h+g5lWEAy16NWHUk=
X-Gm-Gg: AZFdTZcIQFPinYA1V462mDhlBoUGflMxfJ79txfR25wN1GtpszRztTUpiqzbGV87Jjz
	IEbGg6cbDFTdtluxXzTbbVGm4Z4Fq3muB+fISRwO3wHXH5fbsG+ajYBkEyThTpgLUfJkyfwof1t
	o8iUck0Uz7bdvx1yRkfSQBK+9MKo7ahRA9MqCrCSdmrNREoPnJIjXa3fxl1Pj7E2no02HBVn1m9
	4MY4He0mEGOIxlLec6C6yDjdz1KJVEWoRXliIBLtClEnzKDgjZ5AkdwoV+Ei+ReyzsPosyv2CaX
	0VItwMNzy2aLjfjv7h7wKSoLrpQW+fn1EeIvI+BFxc70CAnbYH66UsIO7w/RQqF/5Oc7KqqUIHa
	K06T9epDV7ZwdUj0/bKKnFzxqaqVOwv5D/RLspB+fe2/tDx/py2H0OpjVo3aOM0nRJcDeub6yMk
	4QpZSr4S/W0oyXGKwHvfc=
X-Received: by 2002:a05:6214:4015:b0:91f:2135:3ade with SMTP id
 6a1803df08f44-92114e00a13mr83187596d6.22.1795072842111; Wed, 18 Nov 2026
 23:20:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 02:20:29 -0500
X-Gm-Features: Aa3M54q-mZ4P5PGu6GGOD9RruuTh8D4C8_LYaREl-xwIG6PxH9jKICc7mqXhR5w
Message-ID: <CAMcAce9XkYo7gPHMnmRX5EY2dNYO+ECuUF3RkPLnoGHgh8P7tw@mail.gmail.com>
Subject: [PATCH bpf v2 2/3] bpf: Fix missing raw_tp_null_args masks for NFS
 and pNFS
To: bpf@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, linux-nfs@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Several NFS client and pNFS layout driver tracepoints pass literal NULL
or conditionally NULL pointers for struct inode, rpc_task, or struct
pnfs_layout_hdr:

  1. nfs4_xdr_badoperation (fs/nfs/nfs4xdr.c:981) passes NULL for arg 2
     (const struct rpc_task *task) when decoding compound replies outside
     RPC task context.
  2. nfs4_set_delegation (fs/nfs/delegation.c:380) passes NULL for arg 1
     (const struct inode *inode) when stateid refers to an unlinked file.
  3. pnfs_update_layout (fs/nfs/pnfs.c:1980) passes NULL for arg 4
     (const struct pnfs_layout_hdr *lo) during first-time allocation.

Add mask entries to raw_tp_null_args[] so the verifier marks these
arguments as PTR_MAYBE_NULL instead of assuming non-null pointers.
Verified on x86_64 7.4.0-rc3 and 6.12.118 LTS.

Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b234567..c345678 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6607,6 +6607,9 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "fsnotify_bump_event_seq", 0x20 },
  { "nfs4_cb_getattr", 0x200 },
  { "nfs4_cb_recall", 0x200 },
+ { "nfs4_xdr_badoperation", 0x200 },
+ { "nfs4_set_delegation", 0x20 },
+ { "pnfs_update_layout", 0x1000 },
  { "nilfs2_transaction_entry", 0x4 },
  { "iptfs_first_dequeue", 0x1000 },
  { "iptfs_first_fragmenting", 0x1000 },
-- 
2.43.0
