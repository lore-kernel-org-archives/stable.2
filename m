Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF22D7817
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787970611; cv=none; b=Fht48yY7Wt+beILYmo5GzWUcJB3wtXWSTEW6fwhIrEQXJhLmgjur3b9AVDYuHFz3jc4gv6r9H3EP9XueAsysaJdnMiASZQfzVowGCtLXV+ea8s0ET5seDuy8oD2F72BCLMN2Jjj/nr9EUeYWz7vgBpM79H2eqIoMl0HmqbwIohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787970611; c=relaxed/simple;
	bh=nRGtiMt3YGPfnGiGE6BHpruYjrgqthxYGQTEFo+Q5II=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=VhNU2dYn4kJvDbiSPf583Pqdl4PTzPIfaZse0eYgkFKMTvuN/70lL/zGkSTjxVzyBmGYPmDjldCNElGHni0NNcsFuUJOe50FcBzCwx5aSh4fMjcbUsjxAvVBXmxZeT+IfSAl4VU4NPGMkBEG3TRy6s4bj6K6OCPBTmq2ji/3wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=M/Xplc28; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="M/Xplc28"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6d28aa26cso12296875ad.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1787970609; x=1788575409; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TqGfMw2At09nNB2nhf2Xyr/2yQOqbxtQPLzPIOufRUI=;
        b=M/Xplc28dk9mMvGI9MB1QseamCWl8yyG85GdS1397BewNUYAjwVePE18cUStdhnn9g
         P46R0xRNkINI6ZnV6RMIv/IgupKR/5XBME61NdxPAcQVHae8rqvmbykHWTity4gn4bL5
         9FCXmwGx1tIQspgR9OGVYp901oU+GLOZC4SSWOCbc3R2TiiBTbvkCfdVcTjAGmDxVOqp
         IcbXgWK9i+fzhePuheMaakSkNcVL1qEnVqxnUeqTiol9nEEtM2FA0tg/scKAM0Qx61tt
         tylWET5vchKmYfvriJ9SUbyB3oT7sbn78vC1GnkalJwWkPNuAs9Z5pSC87QJfyXvFOAk
         yDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787970609; x=1788575409;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TqGfMw2At09nNB2nhf2Xyr/2yQOqbxtQPLzPIOufRUI=;
        b=Xq+VXGX1WA+bqaQihZeT0Lt+DAHvxtbE/immW+FH88qGIvvRf9kK2++FMk2BRcOgLJ
         MNGPSnPIPeYuRjckXb+5BdgeGijc59uEg/sQ5RxOPr/qvMwOjAGYdK69lWL6SRqVP8cH
         uNR8/GOb76NrdguTvT/JNqfwXgXt4EHn0N5fwH7gQM+buqJ4wVRE7FAVhuuOTklYTbUB
         hnylfi/SInVGmanKhbVvXvTHZBqsZsDbrKo5qoqqK7WXeM5m+K2F2llBlRAZSR+9QDpj
         UW2Vb+T5P13BN9kZDoCFPk0jJuqK7v+WrLTsIvm8q7Rohb8bF3ClRRkhTVc+LwzpxFcy
         G34A==
X-Gm-Message-State: AFuF++n+cpLML+8AP8fz8zy6/xikZnxK2GDQGz9CXtORmqv3iXqLzFRH
	fZEJh1Tecv7scfu4V81NzamiFmnpuQIDgA9b54Db0hHo6uWpyJFqF9Hf7fCqX9CBgLfOSQrV+Tv
	6M/xL
X-Gm-Gg: AR+sD12ml+SmHU6qFw+ZQnakd+Kz1ZV8dNyZgxfu9Q0GaYOoQ5/85LykypaVR1mXgFp
	e8uj1QdJv2Xvm7jUPXS/HrB5xyGtsGajg1QQ1mRvEu66Zkj3mb95PB9P3WKb3YB5XGF+YtzdMw5
	jDY+3XmTPCtcymXHOFe4/YfnboUS32tc0EKBsg23z2uNAjuTt8UTvCyEk5mTpGZCqexmlb4KkJ1
	PCx5eabrWFvtU872DieRkX3AMqd1OattFWg/QYpUpEckwF/eaii4JEqnjkRf3wKurEeDay2p0Li
	rNvLO0Q4MiF6u6jTSIDkN4EdO6OLyMTCNA59UfQEwB5E8/uLTL/e8ucROD5TK8RgDeN32fldFdy
	sv1t1V5cLbFdMXOXoU4lZLQsrg+itoVRFWRyz7EOASQKxSCvNelxOq9sfSKLwFaW4rFsh8N5RIW
	C79FEBKhRK+VmzPVuKMQo/bSl8yBbGAff+ELWyzf0Qs26F1Y2/0FxxMth7kSNaVag=
X-Received: by 2002:a17:903:3d06:b0:2d8:d4ce:9f34 with SMTP id d9443c01a7336-2d8d4cea3e9mr68390365ad.18.1787970609119;
        Fri, 28 Aug 2026 19:30:09 -0700 (PDT)
Received: from b455de3d9de8 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm9883270eec.27.2026.08.28.19.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 19:30:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 28c35638ec51efdaa30089020b2abf7608898cb3
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 29 Aug 2026 02:30:08 -0000
Message-ID: <178797060771.6229.1038755489606877675@b455de3d9de8>



Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/28c35638ec51efdaa30089020b2abf7608898cb3/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 28c35638ec51efdaa30089020b2abf7608898cb3
origin: maestro
test start time: 2026-08-28 07:16:00.522000+00:00

Builds:	   48 ✅    1 ❌    0 ⚠️
Boots: 	   32 ✅    0 ❌    0 ⚠️
Tests: 	 2413 ✅  207 ❌    1 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+kselftest
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6a9156ccc5867fba946b3335
      history:  > ✅  > ❌  > ✅  > ✅  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
