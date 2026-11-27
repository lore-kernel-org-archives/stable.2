Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795750048;
	b=vRTskyuVtUFyMFKyYjKZQYttrb6CxbfbRp9vVCCR2UbueKTKb8/eaaWYlTIeAC2Zr1mV
	 B+mnqm+UyUtu64A42NM0OHuWNz8yU1ERwthRDH+IwgyziLNNfeI7d8AcHJPYOFHTx3wA/
	 mBzKTiR3ElygEBi/Bm6MggTdUlbbCwH/88Jy4+X7EoJDffjkmcR+LARc7X6jdl1BlLGSs
	 GRaFGaCENPeWhvtZ2hxqHEPmahY5xA/fuLiWun+o3y3Et5LpLj63kxZgN698nw0VlZYnl
	 gD4jzTGDPj9PoCkXHHeNqvPJKP2MO0MAj181z84KYYdwb9PArYw9ikKupnPS8fzFEvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795750048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=yINKduVTwMLXn44jK+J1RxDRjRtoj9U5w2guzaWqgpc=;
	b=yj1PjTR8FCP14ePZwz44FTGAHpFadLbHbWkMG8kMLCHA1JSZc5WqH3D9QPblUWL7/yCb
	 TTwB6cRRx+BVfs3GCJ8Zk0oJrBp7BKwYuNYoXm2/15lED3xRnDBT5KhMCkJfVi2PSBtBZ
	 jGzm6s5HBfnwpdwwuEumhtR1lsHT5L1145243VYNXk/tlowAGgi8vCIomsg9k1TDfSKhC
	 l5oFVbGaeIzm+er8RYUVetD/KP293PFh0cYkF8Ec5s3qbVXaQ1AwMQdkJy9Hm8H0LsZgm
	 I84GGyPvVGiZ6uwgB9F82aVDHIn/ybxXej+Y4PtfXD6bN9tksHKrJTOSAo/O/01soYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COJpT3c3;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5369606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5369606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COJpT3c3
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4d543b6b6so43901287b3.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 19:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795750047; x=1796354847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yINKduVTwMLXn44jK+J1RxDRjRtoj9U5w2guzaWqgpc=;
        b=COJpT3c3RCUOxL2p0994Xfjk7HULSDO/Ubf8PPXLlYPjlMe9mnXT0Oa2hKNujgb+UH
         uLQvydHS4Dk8bTe2M6v+faARRnPgEjN66HYAvMIcjJfhnjsoouFqYPf5ZRtLBpqzl4Zy
         8YvGT9/+KA++AyOA0WMyRzpaBOdNs37P3b/R8yOfK7S4PIjvstQgTn8l6JaSOfPmYwl1
         GWIznrdc7M2zi79t3Vv0AqJviaCwNRx+O+04k5KxYJmhoFWuhJ3IHTCxGIvieON5e3Hr
         moq+MJ2BAlvX9HnE93duTPNl+VkjcHXwiWeg+AErcvbaQaqbyAFNwBRdqFVDpwAsAmzJ
         hy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795750047; x=1796354847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yINKduVTwMLXn44jK+J1RxDRjRtoj9U5w2guzaWqgpc=;
        b=qyf3jx3BQJ+Vgly6fouFOiSGM0TViV3xfWiBEKztBOfOgfCQvdSuCUtPYj0ifK2dCa
         0F8b4ls5Y3lsXJ7BEyHi2A6cpN/vGTbgvLRvSnHtJG5FB3QFom623MLmsgZ7gzyj1Fvh
         +Uf/AhtmPeSKkb09VLYJFyOMNBilo21tXZQn194DN4SKBojR7p9ZeyVBjsvtWNEt6GPX
         rsg3XTVYCeEwxLQiSFGDxXpZ3uPLhsBXNfRqAmDKptUgxkrNE8WdifyyXpOPBiWe03fu
         N1ZQJwn0kFKbhonh9/CA/FI5cALupg7yfgg2b3s6A2Fo37ujsDxsrW91/M0OgGEKDNCy
         3VbA==
X-Forwarded-Encrypted: i=1; AL+hErFlCPimQNqgH7shspqPvmrQZ4dR6W+Xbommp2JTprG33ilsXtkATnVb/kQINhGW7tWeErCsi70=@vger.kernel.org
X-Gm-Message-State: APuU4Z86/HZBt2lBOxi/Ba0BJ9oPryxk4MmKwmsNaNiya1Hh6WPIfe8P
	i65PJXFBssbhZVBwvwhKM4lqefczYAoxKPBt/C+Fi2Qh1CxUNBMYUJjS
X-Gm-Gg: AZFdTZf5DkkBu0/85Mgtk1jT7tG6C1GcN6zr8mRukLfXfiB8h34YjP3drdGJuaMP1XR
	ulwzcRfr2AuXKDy4qBUxRFjERQ/RF/wjyh+0d6fxA4+ajER9b1XQ3ITxEKU/rOddKfYOM5UHhkn
	kirYkYElmHrqpgDg51VsKTyQu1QsPiuucgFtptckl/V4ixOSGF0uhtPe1FMXTQo5nOEkny40Ak8
	CpKoof+poAFKc0sfXmq2xK07aNxrPV1M/LJjD85rB5cN2JrvZkha6wmTt/gj3H4N7Z06Sr5YXqP
	prTurbSYWceZKn4sQzc1qr8C6UmYK1W89h822t+ZgKB/3ZrGCDOmJmPw1UsN53vrsGTykOGToyv
	42VJ1T8VI6BAz+lg7Lscp10jcCGoFPnOCI1AMGqSJ1HIeBWrdVMhOidJnuHMDrOfHg/7ZUv6pzy
	4Z2WxoXlzndZra2bUK+qR7AIp70VdKXLfKIsk7NukoUiyRfps7QIHO48qC0o+R6ytTOwg5zNUF2
	N75cdBcyGe83+MnmLrHRkVV/zy2tnNZV4ySg2f5Q8+dfIzanVc7l0rBEgiykXyI6wRuF+k9xXJf
	QViX0zMFNYhE4lsgX6Z5HmcOm7Dp6tC0Ah+nxIcvHOrNRFPX0+uZeMOGRr5KPqF7qnsjzCMikVd
	6ZwMAJ3cIxLHGXGuh3vZlDVJg0GsVjj89RECk3F+xfw==
X-Received: by 2002:a05:690c:4d81:b0:8b4:cc58:7901 with SMTP id 00721157ae682-8b52031bd6dmr81735937b3.8.1795750046641;
        Thu, 26 Nov 2026 19:27:26 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b520c5b6f7sm90701157b3.9.2026.11.26.19.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 19:27:24 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 26 Nov 2026 22:27:19 -0500
Subject: [PATCH 1/6] parisc: Load the CPU number with ldw in the TOC
 handler
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
Message-Id: <20261126-parisc-hpmc-fixes-v1-1-80fb55336ac6@gmail.com>
References: <20261126-parisc-hpmc-fixes-v1-0-80fb55336ac6@gmail.com>
In-Reply-To: <20261126-parisc-hpmc-fixes-v1-0-80fb55336ac6@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>
Cc: linux-parisc@vger.kernel.org, stable@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=zWWfEbrOWE9jyNVO6R+Q9o8IY8fifsE1PJwlyNdsTIU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI5fkwvl3yh9W3/5Ym/1S4Wfa/ek7fYcGGI99d6fsNn8
 bfKV9w37vjIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhrYoQYGfb8u+Nybp
 3Xv8uL06xe/UxmqT3sFPSqytDhSEDEjw1fd95kZNi4k5s3olw6uspldZbAjdiJk79csy+duMFkW
 ua6mwx7+pkB
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

toc_handler finds this CPU's toc_stack by loading thread_info.cpu and
indexing __per_cpu_offset with it, but it loads the field with LDREG,
which is ldd on 64-bit kernels. thread_info.cpu is an unsigned int at
offset 12, so the ldd is misaligned and takes an unaligned data
reference trap inside the TOC handler, on every CPU.

Load the field with ldw.

Fixes: bc294838cc34 ("parisc: add support for TOC (transfer of control)")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/parisc/kernel/toc_asm.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/toc_asm.S b/arch/parisc/kernel/toc_asm.S
index 570f5cef526e..3e19bd24132b 100644
--- a/arch/parisc/kernel/toc_asm.S
+++ b/arch/parisc/kernel/toc_asm.S
@@ -19,7 +19,7 @@ ENTRY_CFI(toc_handler)
 	/* get per-cpu toc_stack address. */
 	mfctl   %cr30, %r1
 	tophys  %r1,%r2			/* task_struct */
-	LDREG   TASK_TI_CPU(%r2),%r4	/* cpu */
+	ldw     TASK_TI_CPU(%r2),%r4	/* cpu */
 	load32	PA(__per_cpu_offset),%r1
 	LDREGX  %r4(%r1),%r4
 	add	%r4,%sp,%sp

-- 
2.56.1

