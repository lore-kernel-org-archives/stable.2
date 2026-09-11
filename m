Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374B364028
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138753; cv=none; b=SahIeRUxZRG1dS5HCyFhDT+5XGV5p8AWMT+wBVBw13Nl1/YM6doBQ0hAbZFgdkOorSWkGl2XbZ+59KXgEKR/Ldtyl3IoXrfUU78CIpRR7+kSNLdIf8F/2dfO2BGqxA4eU6CWqqWUmSJWIv98Nff4BJM0S18sqKe14twsoUphnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138753; c=relaxed/simple;
	bh=el41lOvJtOCuQA9inMaxTTPuQmcXYIXbirt298StZzE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fVIWkUc+cyCxR7uMICKUzlSmzF+YD4SYL8sU+luYKCMFtpIkFpJ859O0MJWyWDMXjGRo349uqES2OYcMTV1RPf5sRpHtHevX+bg4i/2EastOfMGnH8MtlNOw8+iJlH3ChjZFdxCncs63Ldcaee3eq3I/kCj1RNu66owfnZO/opI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=L9W/XWPX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="L9W/XWPX"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8541875f596so797365b3a.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138747; x=1789743547; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QeMmmzzcdNaIw9t0ijqAqsAaVxqFtzJ4rfXk6rZCpLY=;
        b=L9W/XWPXLYrpFbSNygZnAC4M70e06kMKmX28d/jiogkDjrOFJ4EJXijY5VqvzZj/xF
         /F+e7PYvVBLZ3GzVMxKjBd7TcGuMlsplqnGjeo9NMbye0Sk06yIIF4KZVR81t3xmsYyA
         rwSYOrI5K9BcWGC8VYRkiPqIYZESGvkRYOB23eMvV1YiLkieAxe+JAczzozWB1TfK1p4
         bxnvQDcZT67xvm62fnnByru6lR8JXHFIgdu49Iwbp3WLQDirQr84GzvaRa8UCNsbgF9E
         WBwpvqXaZthz6ggy5AKy36ceW+QP4kOC+03dYspW9/r6+5Qjk7M4KjlZ3FX7JmFeRden
         5Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138747; x=1789743547;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QeMmmzzcdNaIw9t0ijqAqsAaVxqFtzJ4rfXk6rZCpLY=;
        b=QmnCs38Ffy1a3jcnjm6rJmrR7uWj2SZ4rQ6N3wfD6ePM+HEbBvRyNFZ4JFAmtS9Oa5
         P5BUSnDE8WhxVeez69i3ww9UgmK+VpUZWfOgW79ZYF7UO6xVICptiWSEc1tkA3Wr4iGO
         kwqbuMrO404e9LsURDlfgh2uBNP16BgPClIBSlV3VenS77v7KHswzKFgmiS5Aq84Du+j
         OzBfZvzQrXjTGQduwW1rlh4W9KAydP1OThKKYwsjUJWuml2ly4IA3l4fJoeBfnJtGvgi
         N7mwttJhadDPSDfY7qVS+smsd549VPTluBtL08XBXKL3/tCrosA6zSbk7gGvGXLEfS7q
         LFRg==
X-Gm-Message-State: AFuF++lcedd0ebkVh1TDoBXvHWKhJKKTTaHcRXZYj6vSgzecB3z1LNmK
	vGGQ67DHd1pdj88UWMPxDZ/FYDQJY8rM2AJ84yOWDLfVuGbJcP+msACjgCUcc8kFpG3JaS+yVvP
	VT0KN
X-Gm-Gg: AYBFou0dR+agSz9yBuR3np2uIeknzpV5+BwS8HrWu7w6HIKDdgEIlavI7qxj58XnFRO
	kluMkbnfqEmB7eZ+ROqXVBF9zdf7u+6nSrQrF01fLyG4fAM08huAX1Jxqbrke4QBkULGKmPOx7f
	Akcj59zU3lIIzU/PghJ0eSRU6EcSBHkEsfTD7cIplIPOx7fl/TYC8o4tjcjqU9DmuCmszBw8mV0
	+buVY8GcM07LUshjJP8r04u7/jVI8i7vdme7iZYhhgKsMY1ixFQ3+Xmx77S74xugqye3BWf74Lz
	DUuCW2B7VwcY6tT8IgYiU+fI9IZCpJDRQ0J4URSyz/sx9rl6g1hbtGxEfzxg7+8rmv80ZonKz/a
	6vifA+pMEvA44fhijYbC2lTnd8YA7HAJ2D9BdusVPtTQdzO3FLspPsWKNkLryBe9puKX1SmAx4X
	xYitxethJzs1HFAUywjB/8qowkWj0XkKR+63+2FbjSAieagHD8o2+kz8cJLPy0jvAbtPQ2snkQZ
	Q==
X-Received: by 2002:a05:6a20:7d86:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3daecffe187mr8383090637.3.1789138746920;
        Fri, 11 Sep 2026 07:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm7790322eec.24.2026.09.11.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjE4Lnk6IChidWlsZCnigJhr?=
 =?utf-8?b?bmF2X3FkZXbigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rp?=
 =?utf-8?b?b24pOyBkaWQgeW91IG1lYW4g4oCYLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:06 -0000
Message-ID: <178913874613.4387.5891749310076698086@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
‘knav_qdev’ undeclared (first use in this function); did you mean ‘knav_queue’? in drivers/soc/ti/knav_qmss_queue.o (drivers/soc/ti/knav_qmss_queue.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/soc/ti/knav_qmss_queue.c:1871:9: error: ‘knav_qdev’ undeclared (first use in this function); did you mean ‘knav_queue’?
 1871 |         knav_qdev->debugfs_file =
      |         ^~~~~~~~~
      |         knav_queue
/tmp/kci/linux/drivers/soc/ti/knav_qmss_queue.c:1871:9: note: each undeclared identifier is reported only once for each function it appears in

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:822748011f95569c53dca789c6bcc483667bb798
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ee209bfcc3ce037908356ac4632c57a7e422a024

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40db720239ade9022b557

#kernelci issue maestro:822748011f95569c53dca789c6bcc483667bb798

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
