Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C0367F31
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138761; cv=none; b=LXVULJj8IyzkT2RH7c/f3MNe6nnhsBP+ssutEjezubNr6SlzogtM+boxvd14HbKHsqiIVwxXqI+YCLatQMC9lj9BiXFzud+fFsi7/TNiuyvk0DLfC/sPLT0qsGNzd/Ma0PkswPsSqVca42RzJ+21Z0My62klg8W1k2TPYp5hFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138761; c=relaxed/simple;
	bh=Htw64QdEaTKfXPDyXlOxnyGtHGVJH8Rc6Ks3/d/qjwU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=tM9wNDITsiNqJhizYENiDGEuiJgskwL0l75MyXe+CaZY6KV7WZOTSXn0e/N8C6Z+vnCJParWQ7mrPAOZc1l1nFMCDsB7qOQn+GVIbUXXk9JZgiy9j5SgRffa6GuKCWBe2Hjv3n5AMRsk6aUim0+FOxUZb62HO4yz85Ged6SPGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=OjNMLwTr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="OjNMLwTr"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so850605a12.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138757; x=1789743557; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8BOLJ9bOEEzzFt84adQnIxAD4Jte5m8UloMbvyiVK0w=;
        b=OjNMLwTrag5pKWknKq8FtQN1mSkQTvJWlx8KqYdlf6+JqoHlxKzo6PoMgSonjdQngJ
         Tj4BrFVgFjcDGdv/+nYrxWwH9xLqTJofFy2vXx3j3yHNfwlRxYZMC5Jt76+R8jSZoEH9
         riVgbtd4Zk5D7Kv1xZJNPG+RnrFsQpzRbXH4IYyMQFNthfvUUW1wG7P7XFNJ8/i5dIBw
         kd1AD1kYxPDYIkZEUHjQb97cWuhvaX/E3iJzfaSS0Tke81JMKObMymye7yBSoI2SO4ag
         L8LYHfFjOHT7UnaPKlcJwHfvc8vFtbAdTbI8oXh9yxsriIqoQ3E9QZbAAK+b8DYMEx/Y
         +2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138757; x=1789743557;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BOLJ9bOEEzzFt84adQnIxAD4Jte5m8UloMbvyiVK0w=;
        b=EnUpAtthiKj9ROCQWKMIDrOBd7kuIgbz6zIu3qDhfL3FhQWx4G/75UdDUARg25IgiR
         uxAVswNc3t+9AOMNcHXkNXm8x6To1EPxoOeUuXlLjRubq1RdsiulpRj1fZdljCyp9Cbg
         /p0oITib6VQlv5yo0VAqQBdeljOGFbieXF9P1PX37aYqFS3LOb6v95J/WpqKIHto2qUf
         OMV+Mmr/1WQPfcUY9YyaiueO5uGqzNpji3mK7DDzmG1Y6vMDx32CChyjEcHpPi5Ie99I
         Cdw8Y+Hjk5PogRDK7ybLm/uEOlpXoaw2v/31MhlujSSRIHU+9dmNcy2foBI/CKK1l10y
         W41w==
X-Gm-Message-State: AFuF++mBy/Mw3im5pgTUfkbYT9DnexNWQpBimJfUeiU0653hsuxOv+Xi
	IPNXFbANeGCubs7yWcRuHAALIoyxuDbyq3MVH8rE0DI/mJeamXPZjuA+CwEqxMPyziA=
X-Gm-Gg: AYBFou3NZB8k8m2mHLwBQAnXFSYQdH6zLxjU2pfJimDLg8VABrD6e18NANuV11EEZ6s
	+L0EOxcTx53KIbZamwLvNfKRVGnDwkCDbMeqrAr8CI/0z2kYI34XpiOqHosyeNryMM5UWxiPtbO
	rVToF9gDKpAXlPP00UfuAo6oDkvLLQnnxsY2V0t5T2W8OCU9mD8PJKT9EqeCJcFd8H/34lZgCPe
	hPJzGpGKlbvvqMWiGJc1/Yy0Pz/nznw6ywptcprAssCGZEYJNut8/OWLtASUkvsN0FvKHx3aQVU
	tolQYCgVq9OQ3dAEX25fL/G85CxpHugXUGmZVeUcJfiFc7vwCjY7KMfnogFfjoQBCHCVqMb4oB+
	dxLdYyjGbuGuCdAiEyLA9F4nfhj56fODozbUG56FweeF/HnxAgX91vHkUqnhEPr42DGIjCsx6jy
	3HdKgKA1wpZuz7XiNFsVvYnBeP18llqKyruJD3QJ7nnphnCHNEuv1ET4lSbTpgjdc=
X-Received: by 2002:a05:6a21:32a6:b0:3d3:ae1f:d7f8 with SMTP id adf61e73a8af0-3daed62fa0dmr8928639637.24.1789138756958;
        Fri, 11 Sep 2026 07:59:16 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e4fb3esm7415784eec.7.2026.09.11.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)Error in vmlinux
 (/tmp/kci/linux/scripts/Makefile.vmlinux:34) [logs...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:16 -0000
Message-ID: <178913875567.4387.9914398401511231233@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
Error in vmlinux (/tmp/kci/linux/scripts/Makefile.vmlinux:34) [logspec:kbuild,kbuild.other]
---

Log excerpt:
=====================================================
make[2]: *** [/tmp/kci/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:c23bd68d70a24d68f19fc0d7711cfd899fe7f095
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9f5e4631f281f1f3c92f33dcb2dc004f416196a0

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40b7620239ade9022992f

#kernelci issue maestro:c23bd68d70a24d68f19fc0d7711cfd899fe7f095

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
