Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D91CDFCA
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486994; cv=none; b=I/x9XvzFzFnykLhbxUj1fS/Xp8WRvSPni9OfGOk1GrsTr+92d7BdVgFbP/4Q9gZ3iR1PwlLnHTLkbVssEghA0MPUYiUjw3VRvt4/zIY+F4umXX03p4Ip0rR8UYzEMegEdrtze4QOonHrYmoFndecxRM9MgaaUY29pgxCfJmAfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486994; c=relaxed/simple;
	bh=Zduh2DU6SfY5so6BkNbBiVSWdbKi86BAIrpyrB+S01I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWMKxA+DL/VS77S+iSh43lspsC2TSFbKOZExglLLeTq3f8IlBuBoMwSzVOnG74FfbAtDlbofYLzh8GLPAI4S0gaY32XBU5//BrQ/eb4e/I33b14Zy9LVgFeY9Yw/2uyFVZKVIRZKEL1dloybUFpufDs9uzTd0pTa5z1KsgiR6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=MzewuW+y; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="MzewuW+y"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3149340eec.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486992; x=1792091792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJxEIraSPOLWNZvCZSoZUxwKzeKR9+5tZ/1A97aGpYs=;
        b=MzewuW+yy0tntgC4TVkCNCgPrac0C+/RrxAqDvhDoT8j1V5scpP5T5ouvln9lblKK3
         QH6+bWNHrvnwk1yXsAVtAww8AvQh4MInQJpuzLd3+T324yro++xwBAQGBCv65Mnnif2a
         pzAVw//myKcVf62DtTJimWTUyPdMoPMjvynE2912Yz6ALLcgMJ1SCcp/tCffOCdoonjL
         B0lCIOyJAnYR69gLTlxTylv/crXBcv3Zzr20ipcPdCsl3g1Cfa1QE1m49kVWVSgKxETn
         qNuczwzpnuXUKsgahWEbYvBzL/MffmrZti9uTlRHzyd2gYCQuOcddHtM5o9Tn1BGSEA3
         SKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486992; x=1792091792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJxEIraSPOLWNZvCZSoZUxwKzeKR9+5tZ/1A97aGpYs=;
        b=aAeou0iWYFBPFpExlK1eXGcuTAUSVR4anJP7rkDZ5RKuL8/vechpv6rJ33QI/V0aEL
         RMbUK+Hgd7gEgHG8mnKkU903pOHWC3o7xkAPmGyzmpVWFaEBylq2WkkzEVkp1g3AOty2
         SUYexfBoEIyXejpZDMgPBOd2FN2YcGVeieEhKFfcO4uYTBXkNPmuyc2EBDQo0G14dxx3
         mrw/SmjE3UaeqpSSL1W0KXVUIG5VqIv7dJfGQz+nPzLWwO34Zg8zNmWxKM5uP/XSS4GB
         WT4U/sgROEvXJf635S/HdftZhNE4lsosmrRwdQdDibVBOiqwPHPGgfeOK2uDB3C9i0Gx
         9CXQ==
X-Gm-Message-State: AFq9FYJ1N7N73SGvi+/OnDWG6DHUIuvM2mHVAVI6RcaL4SLk5Aa1vTpv
	5pak9+/aXUGHCfSk7u3nTOUD4VqUTz2ko90v4ejYUMqk/upzySAZx+G30e1wSgJsBQO+czv/iEv
	zXqXL+/QqjA==
X-Gm-Gg: AYBFou0lEoKedqdvN4xdQM5AXJoMQYM+YyX+TpREPRtKwKrvBBeSeCD6vl4SK2XL/A/
	h/yhsrIWaY0o8lSXcphfZ1pJ1a0rNgud8kRYB2FGus1Mx5lAxvjCA7hyTlkLLboTnLvBAxoQ5kr
	IjBpH3wiMkwRyoxpRsO3HySyPe9pIc8oMqxlhIiraY/rjnw8JxA3pcM48m8Ym0ejv4sgdJvq/Ar
	laH3Io3msYpkAFwUQw/NZstf5/zYPoYItIqtoZPKDcafraqw57ly4c3GZUnijO2QcEi8VWrcjEN
	IZrYTfkMSxD4TzIkqOCtg2mHSqNIU0vt13o4eKK0tb/jmhYiajqx05ZUxrQfbz8l6uqQQu72AEl
	bOpoGPtIniXc+Q8mjLiIljk0z9U2fi7flyFXakgN8PFQ4+Z7hpUM+xGaBr0gyFmfRmPQvZ7XQ+1
	ZSzZ08SYbqi9m+bmvnSa1Z1eWUpEGCXLaUeb7WXAA70c2IVm0iabf1EJ0mHo24c9QDJnWL5gzdE
	IWDxbNYd6irB7AhjZZVWcb+TQ6XQojozJKZL2+P2htIsb1aoZ0WKl2xhLv5YrC3Cq3WjTn+NF1u
	r40MkA==
X-Received: by 2002:a05:7300:881b:b0:351:207d:bff4 with SMTP id 5a478bee46e88-3515db9c789mr8494154eec.4.1791486990854;
        Thu, 08 Oct 2026 12:16:30 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm54053eec.20.2026.10.08.12.16.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:16:30 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	viresh.kumar@linaro.org
Subject: [PATCH 6.6.y 0/2] firmware: backport CVE-2026-93083, CVE-2026-93093
Date: Thu,  8 Oct 2026 15:16:19 -0400
Message-ID: <20261008191624.98532-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2026-93083,
CVE-2026-93093. They must be applied in this order because the later change
depends on or completes the earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
Patch 1 also affects 6.1.y and will need a separate backport; this
series contains only the 6.6.y patches.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. firmware: arm_scmi: Publish channel state before callbacks
  2. firmware: arm_scmi: Unwind TX receiver mailbox setup failure

base: v6.6.157 (79643295eba17affbd16ca97f3ef04c90266b28c) plus stable-queue
revision 958ddf240a33ef26b1771be944f0ea6c3b597472
