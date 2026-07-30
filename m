Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3643F4CD
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427147; cv=none; b=nIQlZqcBkRFpvqJb1lhxFpFt8lApfPdXt8DRab007ad/iQdoBjbcYQsXbRuP6e1E4NQqA/l9+Tp7heIZlzAA5lODcx1GEmPR8DAUmg97DwOgHE94ei0BKP6hFQ7SAL/D8dn2v/Izcer/FeSbdwL/z++DAyL5L+qwAhNRI+x0/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427147; c=relaxed/simple;
	bh=RVq6yOE8DL4bSi9nKoXkdVUrNwNVrg6t76ftAPZ4pWE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Pp6HWzUOtGUfQd8DhMyrKVqYKZjxIBI2bbU+IxwhPO0N+hDFh2vwaAmLuBA5/uyYy3k9+pIMLvvJAD4gDSx5nKomubkV8KVBagxUaSGb6oXax/2ZmSCD/rakxeoSDM9B8rJr9zyKkb54sUqU+HFHK+0wRKzMHIlv7y6FbLrNqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=jmXeVKdq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="jmXeVKdq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38f620399a0so20832a91.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1785427145; x=1786031945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zTiLpYGA2tLFXIHcVcVO6e5uP/MhaZFCgyK1iNblYFo=;
        b=jmXeVKdqmYh63FRGI75ujKgonxOZTlp1viLCgGspNOkN7SntyTTSIBB8jCrlZugj8k
         UdsfvfUA9aeuhe4eoX3XrzgcwXCEJDpzn3IvXSAWVGb57hdaup6SYRjNepi36dxZaVuh
         Q1o9L6qknaJmN03hb4fUyQamjUHhqTYPYarz7WvS3UqOVHqb6X/429ZZGC8xEMR0F38B
         rkLmpBcYogboWl55AoFO8qp7t78KbUGWbZdPRiVsyY01vUdlVToiXjBFC9iEmKeYHoIu
         /BELwvp0bBzHQHI4u4klU6OFrYAM8DxkgiZKOYTVNdycTtOjh+EU+BQ2ROJu6zO6SjmZ
         7scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427145; x=1786031945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zTiLpYGA2tLFXIHcVcVO6e5uP/MhaZFCgyK1iNblYFo=;
        b=ED1BFNtvoRNhgtyfnynsMYG3sNk4G7+jQ3dctSNuDl2kvVWmfL3X2N4tnUobYcQjdK
         Rhwzx+v7E1yjS0pZRF3BpwdwWGZRmh9DqA+dm17B1u8YBqO4CC/3KfPTyNpdbrCDt9/X
         LLHXbx8pINn/x3hU/2lmCjQ4v0FAurTQxnVwC639oUwsgZ1mp5pM0+dXSXDmGGmtIk2S
         zyOvIDUvYZ/z4tdUs0rLjdeSkh5mlzg1hxJjCLJ8Bp/GuFB6EtacLNf2vw6nqNq60mDy
         CVYMj3LTFxKekBbOBYGAYysqI07Bv1NDaEZGvXtn2vO0T3GN7k78vd5krmvqpn9bpJ2Q
         5JYQ==
X-Gm-Message-State: AOJu0YxXhODUEGdfOihTZgmRSla7fvsP8GBvLWEqX2QTaXrBKc0nOtjL
	fMCMBeeRgq30yRa0Cn6Y9EktCc/NPnBM3ZJYxY4TV38RxOLDqXzFDXf2lcgkhgoJ0TZOOVGueKp
	/SqB/
X-Gm-Gg: AR+sD126zfttXdCyi21ROeDnABGqzraKAA9PvkDARpGvWVCs3t7WPb4Nbw9WyOZSMns
	bUx/0qoJKy0X0g/qInWjCeMsfT3kWYDAfR9/NJFLtp938WkzesN9QuCNOay/ool2pwrIg4SAc/2
	QisEFEvVZQvDJBy14kZAXlKCfDr+LzkRZ1oEPvW/ETj5HHg8IyKWxCNLj36WMlRhTf3MR2d1wxr
	9mY5wgCGr3LXJXz1zBJB62h+J6LbfbKketXgavbjkamhF/JwUiPbYuUE1cW8qDIT9Ccr49YDaGU
	HcbbDGRfr2kuz2ss0wLZlscruZzz2mvPKIgVCy08AvK1ddJ5eapTyAo1dqwoSmfhwihsdh915YN
	/+IRn9SquOfxJigDfAxCyB+hP4gClck8r1dQB1ExkcNJT0ej3O7G930PXuWGJvb68b6m/Ofmpwi
	t4IehJRf8vIeo4FDqpM9hpNAYlX7wq1HFsIcMLVaOWJINI1BR1RKJi/w==
X-Received: by 2002:a17:90b:3b87:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-38fa7e37685mr626344a91.13.1785427144922;
        Thu, 30 Jul 2026 08:59:04 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm24464253eec.14.2026.07.30.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) call to undeclared
 function
 'kzalloc_obj'; ISO C99 and later do no...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 30 Jul 2026 15:59:04 -0000
Message-ID: <178542714373.4058.4312420996135460246@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
 call to undeclared function 'kzalloc_obj'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in drivers/firmware/stratix10-svc.o (drivers/firmware/stratix10-svc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/firmware/stratix10-svc.c:1086:9: error: call to undeclared function 'kzalloc_obj'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1086 |         pmem = kzalloc_obj(*pmem);
      |                ^
/tmp/kci/linux/drivers/firmware/stratix10-svc.c:1086:9: note: did you mean 'kzalloc_node'?
/tmp/kci/linux/include/linux/slab.h:730:37: note: 'kzalloc_node' declared here
  730 | static inline __alloc_size(1) void *kzalloc_node(size_t size, gfp_t flags, int node)
      |                                     ^
/tmp/kci/linux/drivers/firmware/stratix10-svc.c:1086:7: error: incompatible integer to pointer conversion assigning to 'struct stratix10_svc_data_mem *' from 'int' [-Wint-conversion]
 1086 |         pmem = kzalloc_obj(*pmem);
      |              ^ ~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:1c59e08d26a3998eb3dda3d8b7e9e1e0318b8fd5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9c792855fefcc3161b47b8794beaa1a26f0dafde

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a6a331d798ea6c1ef87b487

#kernelci issue maestro:1c59e08d26a3998eb3dda3d8b7e9e1e0318b8fd5

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
