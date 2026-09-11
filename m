Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C0362120
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142355; cv=none; b=mbOQNF6XQzfaqO7hA5yI1Nrgp2ZBlhEyn2diMB2fj9WPgPiFSbFkswJgIpCcDfjwA5w/MBTlW6L/mJoXNn5+EiBVrxaq/x179Nwxe+XNURvMfmlRC15enuahmw8RhkGzMVSbiGA16t8PArPTfJTy0JHajYRmDf1RFedfWTCpDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142355; c=relaxed/simple;
	bh=s9MmvX2CA82QdFu/crfDcROIPg9rT6TLe9b9CCk+UV4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=qKAqR3LpS7OjVzJX5w3SlWCZ+Z/MbNZfl3QFX9/4TOXo57H9t2DMiTU9hNKlU2MmPsfEjRC3V6X+wOHteEyfpGzUyyOoJsRTlHBj8p4xwgFZ2x4YL9j3hGNXOUTD0pV26VPJKYui+sIrYoXNQH6crsU49hAJJWxiaRjYuv3/+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Qg2Cc9Kw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Qg2Cc9Kw"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1227103a91.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789142353; x=1789747153; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bQbcPfjYT9q6q4oUJI6vwidLf+RRQuF9vpNKn30i2Kc=;
        b=Qg2Cc9KwGlFE9ZMJLqRVWBMuPgrsfSpjzpaR9F5paoRaCgl5EbheOgy37yJDirXR6V
         GPyUnjSs53O8h6/3QYvZT8cUknPg2Co8R7j4V1L1efmt2T8sVmJUV+GQmPC5eN9VWjJT
         1Mowogwx1UdxtAvruvl/3VHfFWCJqb79O+jDcuSabwGXN1tudQ8JZEb3YYoU1KBc9ezc
         NAh9WvHcwXME+uFv9xdr40npFbP+HSg39r1vAxMV+Negyp/WB1WR6rGOUhJCbM9WlKp8
         Fg2NCCrdn4jW+UC5ingGmNUyOZ1XdGYD+I5wFiOs+YxcVR1KVoy9TOrDJ4hWv3CAHw/s
         SyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142353; x=1789747153;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQbcPfjYT9q6q4oUJI6vwidLf+RRQuF9vpNKn30i2Kc=;
        b=Nfmk+5VbWqoj3eDlR8p07pQojMrGkPkgBkpb3FkvIr8MTF/qr3h9Dvja9q4Mmx9fc0
         ciWG9GubmaMG7GCwfS6W8a6Vgmn/8d3yXrHWutXPQ60sdEy9CBQOuzahRdvPm72pQJxd
         FaGZQtiY1MeNhiRVzL2U4tu4wvCP9jGuq9QEbOChNuj/+C5buguN2gmzCE/ERzy9xye1
         tYWmy/djirAnQvFlJmCvIjO57uhdqgNCxw3n9iRnpT1eotaYKF9eXSGrl5IIkGpBVCiS
         6qwiSU30wsdtWS9QZ9VmSohNEniYspy/V/djvxn/8hedYiAmrSt6RwUFWrWyQFrrhNhz
         7TOA==
X-Gm-Message-State: AFuF++kbg14fmgwJ/sxc4AGfO0jFISjKk6FzuGK/i6y3zOc4Mwdf/wab
	TC5/+1N78aJFLWcaPspIqxQfdhocnNj+KjV49ymR0pNnAVM6gHCDlGNHH/2KOSbi+9G40816Dkq
	PPAmO
X-Gm-Gg: AYBFou2t34Z7CyeusroC4vUZGm7h8YkXbYqh5cQhzE/WUtY37zFNjrjZEsDLEez7inn
	ATfcvN/9prVv1F1+lL7PiFYl76I/h9bIMEEAM+SzmHZxFBRkVj7o23SPsIa6hwLsdTKpH4hQOgi
	C9Q2RiAcI9DX/2/Vy9z7mQcsog10AfOoJ6LTw63yXG1UNHV1Lzkwnb0i55u4GTBI+G4tVozM71t
	TZ303FCHt20mTV0XVOqUNfdK1uhBtCmP+Ry0mlCazonChy54z3JCpI0Dj4aBcSvIJFICj5Ww9k/
	664FR83QI42/WfQWYJd4T16EtsJI0DpF8oWhkm++iJcMmlNzEix1vX6ns7XSRqIff/hbQ3AKAXO
	zv7na0dZiANNTz5ZB8Gzakq05W4KThEruA6aTUr2byFYQgHAvBL+uuYlXkMqhbXgl1N67x4RILF
	oqLWljVC4Q+cYHLnYxSDdqZdxf0ydKvCZ5o7XBlFj1R5SwWL3Ul6HpDLfjf+SNR2A=
X-Received: by 2002:a17:90b:5790:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39d9bda7ba2mr8505935a91.11.1789142353270;
        Fri, 11 Sep 2026 08:59:13 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba729dsm11678736c88.14.2026.09.11.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:59:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build)use of undeclared
 identifier
 'knav_qdev' in drivers/soc/ti/knav_qms...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 15:59:12 -0000
Message-ID: <178914235258.4405.17940178445917674491@kernelci.org>

New build issue found on stable-rc/linux-6.12.y:

---
use of undeclared identifier 'knav_qdev' in drivers/soc/ti/knav_qmss_queue.o (drivers/soc/ti/knav_qmss_queue.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/soc/ti/knav_qmss_queue.c:1874:2: error: use of undeclared identifier 'knav_qdev'
 1874 |         knav_qdev->debugfs_file =
      |         ^~~~~~~~~
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:1427a7050ab2bb90d200c684124a8ab298666190
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f97429de1ef3e1b6f7986abbcb45bb115b876977

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40cb920239ade9022a710

#kernelci issue maestro:1427a7050ab2bb90d200c684124a8ab298666190

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
