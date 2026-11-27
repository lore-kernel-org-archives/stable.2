Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795750052;
	b=4zY206VXITstshtoKy7txwCEwR1+vA2YaImNvKBNJKxhXZC5aUK64lCSL3RHEVO06oA5
	 tml9+l05ttWWO5p0ZK2Z89fUzZ7cSLZUZm0wKJwBUb66SRmKtaVD9WheSy1Cp+4L6QNEY
	 U2CB2/WCEnDEGbq9dLW5NFpGTsGroBlmhkaWR3+XUxJzP/OfRyVA75GliZKpV9yzONhPA
	 zrkNIHLkgMEC678shbGkUBOHCzuJreDt/YIgW2MqAqxA/O+Ktr0rCuXdNU8u0i7Tnrw8s
	 9SaUWkr2Labp1+7tqSNpSNYPXfFsD7yB89mqLeLuNfyxL/UluDjDRoxYNYMljMVi7WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795750052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=W65spxSOE/XnrHWe3HBeNHLHIzDrbeo2CGVaGDSIOlo=;
	b=UB97ZQNqeX6tgkN6Xix+o+vAzmv+Pqq81Lx7dZX9QDtSFqpO+nEuu4t8gkTj85ornoIw
	 mycvxFZSWaDpWgrAXJQJea18wvUIPyDvqdtEkyDpIJG/xW1B/385Qgov3qNbq+AbKNFf0
	 2u8jgh0p6Qwcs9StAte1rN14mApib9zQQUEDRl6Wf879aLEtcJ7VcaYbYj3KWJjv5p+q7
	 cnhuw7yKwO6StjUymT28g1ADgio2f21+yJaJwix57eYpJ/bkhPG0cplQFN9mqfJdTh3sK
	 lki+I6C0iYrqRSKZsMLquagbUb2/Ypus72598VvDII0rvkruvVKdCBy/c6qi19xuLXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RC9FR+kx;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD03606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD03606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RC9FR+kx
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4f4095a7aso66431667b3.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 19:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795750050; x=1796354850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W65spxSOE/XnrHWe3HBeNHLHIzDrbeo2CGVaGDSIOlo=;
        b=RC9FR+kxnESOiFo8m4INKTa4zuh7I/AlHSfvfpdivIBO+eaZ2U1vNEH9hilaBJYHiq
         SVegEQr+xwV9P2eq/2NGwyL0TS9Zj16S77YEtrEWjN0PJuxF4PQH8U7hCsKWZjARXeUp
         t6dwdcfOVd+tkcJojIfTdfuSHTDQ5JJU/ZuDULWBngIiYftcP+RvE9KacGIu5YC0tXaz
         F2HdrajO08zuy1g0kBbnK8/W1ss+iPbl8ZYUkFJBW433jw1LwSssn4HhfQ6YsIex5nUq
         HGx2qHdcT6u1a0Sci3EDm6seR9KuMxg7bOV1+tcoKcTzVDYNMZs739M0bZN2vVI0OA5h
         IMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795750050; x=1796354850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W65spxSOE/XnrHWe3HBeNHLHIzDrbeo2CGVaGDSIOlo=;
        b=YFwonqAh3zpp5Fd/2eq8aB0S8VipBprqyUCxfpaqkEe/ybhnfj25q7TyPY2EsOxiHs
         9/L3RQU2teLqgiy0MkogXVo3zvj3rhTFAKAYO06L5aK+qbF89kbRbfOqmJEx2e+umdwJ
         u+S1R+zWcxjRNkKq0Ok7xpJ17VC1rQX2BQMZoEemkeZqSqL9Zm0/4WvqYKhebJOTQrxD
         dLA01h0EbbCh3vVFkrs0Z5IstCDHfGkX/Am6zSjWjNgoduaOhDSgMLCSaDjQWBsLwMGt
         iPA/KC5x0e4rhgTLJ3EKtn+K5PSAouhjhDOmG4jEGgdph24FMBfyFov8pbHwoLw17zc2
         ge3w==
X-Forwarded-Encrypted: i=1; AL+hErHOWLnfxYzIznUR9lw4W25msl1r4ZZeiHDKG/3YBB08rPRMmQS4XADpBebjdS2717q+VvARnRU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vM+EH3pDlIPwAgUMRymYt76aME991z4eJ1vRlXsUCIeWXHL+s
	l74CxU2RJ/0S2LXXIz1IzmQV4I7cpcPLm7l4qnixTAu5Dzd+HKAHm4VL
X-Gm-Gg: AZFdTZeRbj7R7j/JEgI9UrPIwc8d0CkotoO74BS/h0vb51Qu+QKSr8slhmCbiSmxjb7
	J5f7j9E8L8PRk3726kl+cBXG8K7Kg5WyKwUYmm7UoPVsXi0wouxG9KETRt7G7qE6H55/kmMDl68
	bt5UIhWeiC5auZk3gMw1UlHS49miL1Twq6rmjp3Pvewy/D7nkrzZfaXp1NlF5t9OFkbC1JTIwH/
	jxXPscZyL4PFqXWdZqEuBmrE6yCijHfo13xIZLeCUwXop2FiSpnDLprCtjZNvkFfQXUYQqvK8Hb
	GapPLq85HtU7wn0gS0MmrhBI56XfU9YKBCF6nWxqGwZQRZnb72xkrk4o4JdJtQrOLKLSXq7hqN3
	B2/1hUawYYvZTt13K76TemXQRp2jZifuPs7mJfD0Ot2nVbdvcPgl5R+La/2mhs+ptznjgHpe5S4
	aqAV8eV2h2O75CzP/LSCuysC8yha51mQfoaM8f0zBmR8XkRjqtDCGSpMZwoseMGCOyCNcVcpTWt
	QH3hN92BrkMWvG8zz+yyaM4axsmh5The0dq09Os3ROkcRGZndFiHZzDtj5oMz3ntPVsfcTfPmuk
	ogLz5iTatrDjG+AzqZt69C6YMdmSK1OQK9T+WbhmZU8TrRFPcnv5qH3YAOMs+C6lrF9j9aszq3y
	0RJ8mhEvVvV0NL+N+DGS3elrWtWt4DyxcuseBS4LRUg==
X-Received: by 2002:a05:690e:12c7:b0:67d:f50b:d848 with SMTP id 956f58d0204a3-67df50bf365mr11533300d50.38.1795750050366;
        Thu, 26 Nov 2026 19:27:30 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df335b3aesm10715654d50.12.2026.11.26.19.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 19:27:28 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 26 Nov 2026 22:27:20 -0500
Subject: [PATCH 2/6] parisc: Fix the HPMC handler stack on SMP kernels
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
Message-Id: <20261126-parisc-hpmc-fixes-v1-2-80fb55336ac6@gmail.com>
References: <20261126-parisc-hpmc-fixes-v1-0-80fb55336ac6@gmail.com>
In-Reply-To: <20261126-parisc-hpmc-fixes-v1-0-80fb55336ac6@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>
Cc: linux-parisc@vger.kernel.org, stable@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=jBxkjFgMdQFIcidTaqAmGEWL4M+YGtN8RaJ/psbUenU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI5fkzniPUpnDhx4v2fXqWbVp3h2Hq1J013claLEu8hr
 60fte5ndHxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1bzYyMqxsW9Z+P+
 RHTO9ij9UhXPe8eERWbJux0mCn17snTFMSZHQYGRqXrq4Vjfhl2tQmJ6FcXM8oE3lHPV8vYPpW1
 qJbpq8b2AA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Commit e486288d116a ("parisc: Re-use toc_stack as hpmc_stack") made
os_hpmc use toc_stack, which is a per-cpu variable, but os_hpmc loads
PA(toc_stack) without adding any CPU's per-cpu offset, unlike
toc_handler. On SMP kernels that address is the per-cpu template in
.data..percpu, which vmlinux.lds.S puts between __init_begin and
__init_end, so it is freed by free_initmem() and handed back to the
page allocator after boot.

The HPMC handler then calls PDC_PIM, PDC_IO and PDC_IODC, and IODC
needs about 7 KB of stack, so every HPMC on an SMP kernel scribbles
over memory that now belongs to someone else. On a C8000 the PIM of a
nested HPMC showed PDC running with sp = 0x173a20, inside the freed
range, and the handler never got as far as printing anything.

Add this CPU's per-cpu offset in the same way toc_handler does, loading
the 32-bit thread_info.cpu with ldw.

Fixes: e486288d116a ("parisc: Re-use toc_stack as hpmc_stack")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/parisc/kernel/hpmc.S | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/hpmc.S b/arch/parisc/kernel/hpmc.S
index eb2e4bd67035..ee39afb9bebc 100644
--- a/arch/parisc/kernel/hpmc.S
+++ b/arch/parisc/kernel/hpmc.S
@@ -79,6 +79,7 @@ ENTRY(os_hpmc)
 	 *   Using callee saves registers without saving them.  The
 	 *   original values are in the pim dump if we need them.
 	 *
+	 *   r1   scratch
 	 *   r2   (rp)  return pointer
 	 *   r3   address of PDCE_PROC
 	 *   r4   scratch
@@ -114,7 +115,20 @@ ENTRY(os_hpmc)
 	/* Setup stack pointer. */
 
 	load32	PA(hpmc_stack),sp
-	
+
+#ifdef CONFIG_SMP
+	/*
+	 * Use this CPU's toc_stack. PA(toc_stack) by itself is the per-cpu
+	 * template in the init section, which is freed after boot.
+	 */
+	mfctl	%cr30, %r1
+	tophys	%r1,%r4			/* task_struct */
+	ldw	TASK_TI_CPU(%r4),%r4	/* cpu */
+	load32	PA(__per_cpu_offset),%r1
+	LDREGX	%r4(%r1),%r4
+	add	%r4,sp,sp
+#endif
+
 	ldo     128(sp),sp /* leave room for arguments */
 
 	/*

-- 
2.56.1

