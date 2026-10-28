Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213947;
	b=YUCADB4tsV66LGgvztki8sKPne/S4jzPHFtB+GOt/hBSGxi/1112+v2mZMLn9TZsEXi+
	 s0oFPDGfud3RJHFec5YNHNt12QUAJbdCNsN0S0ZLxRMf1SJFivVZ0Gwa35db0JCyMkdb8
	 vgcr0iCLd2Gc2bQg4goD+4gTYljX5fj7EyAPYRCejIeaWFeNbdzF8SmTrpivKiXaHAgFC
	 3Vb8yfA9jSfyW5Y7Lh6BopidIjW1iZ8q/RYCT59uDMZys9dqBFk8c+XX8D+lQ58J6WP/y
	 +26dLN2L9gbbQot8B7f8YfEcphgyJgX3hJBEZj0w87JbA7D9NdBKnaRNQzjCs8HSTIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=ZmBtsC3qcU7kujJ20OJWBktciPNNORM7yeHmxmWeXg4=;
	b=b8mA07lNmwmCi6KQ0Sbq0uTgTBr/D124erIoihKk5Ql/L3fq8+F57ZgMKK1AAE6UThQW
	 83xwtyfdKCYLPcUqU3nAn0lqfCZY2nT79N5B7DKTVQlKUItAP/4/6deHEBTNDKCjuUl2U
	 K6goVCYjDwZ6Je1fmDniEQjRpT8sApWZ5QGz/7xankFhpkpSqjO2llOn6pj76jxCqnBe0
	 uDy/VrQBS91JYquGjdFZ0O7me3Qs5+KnJ3y+FXa/6nF5KPchQyzFoGeMlcTGpJCwljcsG
	 6o6rbdv6Kh8cjSG0hCp7LIX6bKgy58Haob2aUNNtVgg3j6+U1xGcKIOjTpQevQwNl1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=CrrjcwLx;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E09606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3E09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=CrrjcwLx
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so1377197eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793213946; x=1793818746; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZmBtsC3qcU7kujJ20OJWBktciPNNORM7yeHmxmWeXg4=;
        b=CrrjcwLx7QT/bkpX1NE8IurajzFCvOq7LaJ+1L9oLal1qlYVR2n04O7S+H3CAx+Ptl
         ITHlkNkHHsge27Cv9JdHkUpvNBv2gIrnYa9ulMbL8q8XKdG20S4a7DQdjr9Duxr9OL7s
         cw/PljBGnKDdH0LuxVlWMTAvyJRtoP1zu4sHmNkj5L33pkwzgqhxovH6ihXpRgCysN4B
         o0qW85mZMp2ZLie4UvDdBYLg+JZhBxYeXuDPxCcNoNjkODZNsg9e8NvDheVw1cxSmPIt
         QFWswYAHB1LmQgAUddVEDITks5ZMB/OmrKP6bMwCyLKnK8y/c8tuass1F1V/Q0CfCJlD
         dOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213946; x=1793818746;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZmBtsC3qcU7kujJ20OJWBktciPNNORM7yeHmxmWeXg4=;
        b=xGnQcHP3Xxdqtk9uJ/iY24U9gZnO4gpYh0A+iGq0ePEUXoWs1ow8OD7CYmhaCokDI+
         +mka9HU4acGn+H9Cujd8N9rsc8Bwg9Yw8VGSMbE42LKHW/k8v0pcIUQqiRelYRY3Qa1e
         8d8L+B9vm8SmEtu/ycgtBlBwFsXtNerlCq1BCcQVTRaW2n78aPG1Irq2lZi27f/5YQCw
         l0DUuHIjOduPa6DmFqsknz5KXIaHxRptbMOqkTjz7zLqfS3luUcWzipSTAKrU4vX7Var
         ucmekLHJZGQM1hU7/sNuOKhMjuE1NHnQGD6/VDsVs9kTsIACzjpixY2lFAvb8EatzpNM
         k24w==
X-Gm-Message-State: AFq9FYJYR7uaA/w20T/n+ZduUmlFLE4VJcB5pB7iO0h2O7xu3c30UQAO
	EcPDeqM6rSn3iR59cKcBe6vlHRAK73RTj6JTD/sXkzIQvIJtYR4u9iJpuRzO2l9mXWA=
X-Gm-Gg: AYBFou0Y0wGcc74L6JUzheUgpOXc+BvLsUBw5heKblI1Mg8enXc0bKDywUHKpGV5E+V
	x3BqKkfa2LhsMa7AzrSngt34WZeHQH66bUXvjsB55j66vbnN3QIeg47Lm3nBwtA28ZNlFbHqWQs
	DL6jGWgnE37LP7cvxhnFkge9rbAkCBrqeXH1j1bRWrkhD4PkO3gAsVpvSLTL+wlywuaFPx5+hKR
	crWyKJSF5GFZeX3JWw3OUCuaLxEkiJJ+IAIOU54ZmBWaqWym6DgY1M8di5nVTeYcf6F12KHpMiV
	VJHr42I4c4cbPUXMfjZWq+nAh0X70q+E9MosGCyqI7S+k1szXb+RSunAxpfzLlV4EpgvnZi/lPX
	xGnnDbgW5zVVWK6yDGC+UCRmj3FPekbOqwChzukTvMgWlAdg7iaQfEDkyFAeNleZcY/xLZgdAK9
	ptbF1ShakUEeJGSze9DmpqG7rqRa6YJBi2zPQZ/YZ5tJ70CXjhdFu/krqq0t1IcnsBcahhssU8E
	wjc2ZcL9YtX53lDOwp+GaKm2abVoeIVtymwrQjgtaAswnx045eYnOaC1s88dD2es1UPy2PfrWzJ
	4zvhwrJ0jBI+z8FiWXHloxs=
X-Received: by 2002:a05:7300:3aaa:b0:369:21a:dcca with SMTP id 5a478bee46e88-36a203abe41mr4396561eec.10.1793213945352;
        Wed, 28 Oct 2026 11:59:05 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23908449sm8701299eec.11.2026.10.28.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undecl...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 18:59:04 -0000
Message-ID: <179321394356.45576.6811041719289095450@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in init/main.o (init/main.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/init/main.c:50:
In file included from /tmp/kci/linux/include/linux/writeback.h:13:
In file included from /tmp/kci/linux/include/linux/blk_types.h:10:
In file included from /tmp/kci/linux/include/linux/bvec.h:10:
/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^
/tmp/kci/linux/include/linux/highmem.h:448:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  448 |                 if (folio_test_highmem(folio) &&
      |                     ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:6be82e656ec02301571fd0100a519a2d8ff8046e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  cf976d6a55753dce91f48c978098f1ebfafc42ed

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae2356d5c0836a8c2f17650

#kernelci issue maestro:6be82e656ec02301571fd0100a519a2d8ff8046e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
