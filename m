Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E293998AF
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791081014; cv=none; b=qrvrufBTM2++XsmzBV6zz7mG134cxyJexWnn2bdemykX+BCeW9pqdy5mQryXuJHRxniNOmkcXpvDraUvs1aM64ilk7VCq9xSpoB7ugEbmW8KeJcom8mn6mZlQA+vqVKSppd1aKO6+TpIkgEVhwK9YxCYOc78SGRMeGHhY2JLC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791081014; c=relaxed/simple;
	bh=dti3KUONhXpzFgf+4xowylZ2svbCkdZhQndw+J3/ADQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=PegoFt6HtLxszXgRm1cNpI0wPcfFGnqB9OdqBp49W66kIgoPCpT1qEu3d7Fk1M3EwSVMarChODn/5N/CqeunSDfDlWnvjKdtjCdhMncrhDuMbUmp7D33tvZOauIX7pLQONbvVft0D9th3NYhcL6PvzShy7Rr3S8k21SDP3xVX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=MUUtnPAq; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="MUUtnPAq"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c4a0870d2so392231eec.2
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 19:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791081011; x=1791685811; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+Pf7QUSZBZWWRjJqOrTUII1f7oBsO8f1EAPFVyAyHh0=;
        b=MUUtnPAqIcT/21VwCAcQGxXGnJ4pKUXNS2rUQ7BWS+zIaU20t4j9gi1+wJRPg5WJiy
         VHuZqfzrUa78KKR9GZKNP1a/j261y5u7zGYmd98FldzyN1R5wOfeZ97doP7a7CEKDM4h
         CvS+CslwZk/pK0bWE5bflrhbIPowaxxr1Fyp9bS7JzGDc5/8fgtyXxAXEB2TqkHz/6mw
         m0BVPyIaK/5Qi8JncIb/eWwbefV4dWp/bSTNk6H6TE4Y76EiFuj1BhTpsAuGSmtCwiih
         43lwbIVaxw1GHNhnOUbpWmeWE5Dwbblh4zFhmzCdZI4Gacy/Hi36aDYw6Jpd0ZbGJvdg
         6XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791081011; x=1791685811;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Pf7QUSZBZWWRjJqOrTUII1f7oBsO8f1EAPFVyAyHh0=;
        b=Xq+DoFsUKw0xaHtkQvAzKNGscSwewnjKRZSGcODk+9TdsPq1jxfzSXUuezk7l71EWv
         /A4RHHk4bSNyyoZISjwJfbICrtwf+cjNkQhMw1LysfZBren9S8uvjwg2yyVLkqZtkD0H
         baNbNV5YUzlFNkJFN4/M/nRY6KFZDuG+lom9muVSa+186NuEwRCg6+RoFiuHX5WBvHjF
         +pgbdmnTwU55e6DEmkKSNB07P00OXISmcA99iQYFScHEL77vENUUffJgGcH7JXur1OLX
         GeXRmwO3QuOQfVFEA8u7cOMtYwVS5zTjrCoOH62pckZikqR5Q05C4HVk4oICWe55CHXA
         dd3A==
X-Gm-Message-State: AFuF++mb/uAM0o23pzP2C4c25qmzeOvk5HZdhK+oEMvj0ALcEzCVhOry
	N7AjRKYvh38U6j14XnjlEDGmSxjsaQkIhWze2afSVbmSBh0OREgigDh/sGAE7wAkPhY=
X-Gm-Gg: AYBFou127PFMFl/N1GkpWecSzDu7oMY0nxQTOR9vbgZ8q/EYKYiqQJPWLM65xCWcYUU
	gvHHQyiw1l8G4rpJfqCFunXcl2ckxIrQekiewJqzs2s+NUvtivq1u6KSvW5xAbAj0Z9MrfiPa4q
	6ErIA573Y+ihWP+u3/FoA0692AwK5kKukpibbPLbSHFN+d3C2u5/i7du3mHXpMAmQ4u6fIiZxrz
	t7Mx9A7Lz9gjuJGwi5BFAqRwrfNsrFi++v3DMwHYjGXpJtA4eTGSQ/fMX+U8Ik+kZBReZlUxD0l
	FqE+6/fSasnws5abstk6Ozdu+kn/LMQG/QHamsJEAvNgH8XbjctWvncG0PvWHNwm/4oOyOabrDM
	ymG/DoYRkawGfW2MVZAzzAF04L/OJXBb8QCvVWmyQWxT1DRZ+uBwV6KzC66qmRiJaXPR5XYzegw
	EXiGaMDsAIEL7KUYM04PgLsY/MNHtdk6Fv3iKdIpjie+LamhArG1QDj6dbYFugM9A=
X-Received: by 2002:a05:7022:b88e:b0:143:298f:33b7 with SMTP id a92af1059eb24-14f5cbd5378mr8814779c88.47.1791081010595;
        Sat, 03 Oct 2026 19:30:10 -0700 (PDT)
Received: from 5a6d9a2c18a2 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fcd83fadsm10527534c88.11.2026.10.03.19.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 19:30:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.1.y -
 a500ba24937a966eab140b95eac42782a7ce2c85
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 04 Oct 2026 02:30:09 -0000
Message-ID: <179108100958.282967.8834905714692403267@5a6d9a2c18a2>



Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/a500ba24937a966eab140b95eac42782a7ce2c85/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: a500ba24937a966eab140b95eac42782a7ce2c85
origin: maestro
test start time: 2026-10-03 11:23:56.860000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   23 ✅    0 ❌    0 ⚠️
Tests: 	 4768 ✅  488 ❌  686 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6ac0f0d3a3f195e1aa2a7930
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
